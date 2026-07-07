-- Schema for Domain: distribution | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`distribution` COMMENT 'Owns the potable water distribution network topology, hydraulic modeling, and operational data including mains, service lines, valves, PRVs, hydrants, pump stations, storage tanks, DMAs, and pressure zones. Integrates with Esri ArcGIS and Innovyze InfoWater for network modeling, NRW/UFW analysis, and pressure (PSI) and flow (GPM/MGD) management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` (
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the pipe main referenced by each pipe main record in the distribution domain.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each pipe main record in the distribution domain.',
    `dma_id` BIGINT COMMENT 'Unique identifier for the dma referenced by each pipe main record in the distribution domain.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset referenced by each pipe main record in the distribution domain.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the installation vendor referenced by each pipe main record in the distribution domain.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master referenced by each pipe main record in the distribution domain.',
    `network_node_id` BIGINT COMMENT 'Unique identifier for the network node referenced by each pipe main record in the distribution domain.',
    `pressure_zone_id` BIGINT COMMENT 'Unique identifier for the pressure zone referenced by each pipe main record in the distribution domain.',
    `asset_owner` STRING COMMENT 'The asset owner value recorded for each pipe main in the distribution domain.',
    `average_daily_flow_gpm` DECIMAL(18,2) COMMENT 'The average daily flow gpm value recorded for each pipe main in the distribution domain.',
    `bedding_type` STRING COMMENT 'The bedding type value recorded for each pipe main in the distribution domain.',
    `break_history_count` STRING COMMENT 'The break history count value recorded for each pipe main in the distribution domain.',
    `cathodic_protection_flag` BOOLEAN COMMENT 'The cathodic protection flag value recorded for each pipe main in the distribution domain.',
    `coating_type` STRING COMMENT 'The coating type value recorded for each pipe main in the distribution domain.',
    `condition_assessment_date` DATE COMMENT 'The condition assessment date associated with each pipe main record in the distribution domain.',
    `condition_grade` STRING COMMENT 'The condition grade value recorded for each pipe main in the distribution domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each pipe main record in the distribution domain.',
    `criticality_rating` STRING COMMENT 'The criticality rating value recorded for each pipe main in the distribution domain.',
    `depth_feet` DECIMAL(18,2) COMMENT 'The depth feet value recorded for each pipe main in the distribution domain.',
    `downstream_node_code` STRING COMMENT 'The downstream node code value recorded for each pipe main in the distribution domain.',
    `fire_flow_capable_flag` BOOLEAN COMMENT 'The fire flow capable flag value recorded for each pipe main in the distribution domain.',
    `gis_feature_code` BOOLEAN COMMENT 'The gis feature code value recorded for each pipe main in the distribution domain.',
    `gis_geometry_wkt` BOOLEAN COMMENT 'The gis geometry wkt value recorded for each pipe main in the distribution domain.',
    `hazen_williams_c_factor` DECIMAL(18,2) COMMENT 'The hazen williams c factor value recorded for each pipe main in the distribution domain.',
    `installation_date` DATE COMMENT 'The installation date associated with each pipe main record in the distribution domain.',
    `installation_year` STRING COMMENT 'The installation year value recorded for each pipe main in the distribution domain.',
    `joint_type` STRING COMMENT 'The joint type value recorded for each pipe main in the distribution domain.',
    `last_break_date` DATE COMMENT 'The last break date associated with each pipe main record in the distribution domain.',
    `last_inspection_date` DATE COMMENT 'The last inspection date associated with each pipe main record in the distribution domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each pipe main record in the distribution domain.',
    `length_feet` DECIMAL(18,2) COMMENT 'The length feet value recorded for each pipe main in the distribution domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status value recorded for each pipe main in the distribution domain.',
    `lining_type` STRING COMMENT 'The lining type value recorded for each pipe main in the distribution domain.',
    `maintenance_responsibility` STRING COMMENT 'The maintenance responsibility value recorded for each pipe main in the distribution domain.',
    `material` STRING COMMENT 'The material value recorded for each pipe main in the distribution domain.',
    `max_flow_capacity_gpm` DECIMAL(18,2) COMMENT 'The max flow capacity gpm value recorded for each pipe main in the distribution domain.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each pipe main in the distribution domain.',
    `nominal_diameter_inches` DECIMAL(18,2) COMMENT 'The nominal diameter inches value recorded for each pipe main in the distribution domain.',
    `notes` STRING COMMENT 'The notes value recorded for each pipe main in the distribution domain.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'The operating pressure psi value recorded for each pipe main in the distribution domain.',
    `pipe_number` STRING COMMENT 'The pipe number value recorded for each pipe main in the distribution domain.',
    `pipe_type` STRING COMMENT 'The pipe type value recorded for each pipe main in the distribution domain.',
    `pressure_class_psi` STRING COMMENT 'The pressure class psi value recorded for each pipe main in the distribution domain.',
    `street_name` STRING COMMENT 'The street name used to identify each pipe main record in the distribution domain.',
    `warranty_expiration_date` DATE COMMENT 'The warranty expiration date associated with each pipe main record in the distribution domain.',
    CONSTRAINT pk_pipe_main PRIMARY KEY(`pipe_main_id`)
) COMMENT 'Water distribution main pipes forming the backbone of the distribution network. Tracks material, diameter, length, installation date, condition, break history, and hydraulic characteristics per AWWA M11 Steel Pipe Design and Installation and AWWA C600 Installation of Ductile-Iron Mains. Critical for hydraulic modeling (InfoWater, WaterGEMS), asset management (IBM Maximo), and capital planning. Supports LCRR lead service line inventory requirements and main replacement prioritization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` (
    `service_line_id` BIGINT COMMENT 'Unique identifier for the service line referenced by each service line record in the distribution domain.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each service line record in the distribution domain.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each service line record in the distribution domain.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each service line record in the distribution domain.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset referenced by each service line record in the distribution domain.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the installation vendor referenced by each service line record in the distribution domain.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master referenced by each service line record in the distribution domain.',
    `metering_meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each service line record in the distribution domain.',
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the pipe main referenced by each service line record in the distribution domain.',
    `premise_id` BIGINT COMMENT 'Unique identifier for the premise referenced by each service line record in the distribution domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each service line record in the distribution domain.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each service line record in the distribution domain.',
    `city` STRING COMMENT 'The city component of the address for each service line record.',
    `connection_status` STRING COMMENT 'The connection status value recorded for each service line in the distribution domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each service line record in the distribution domain.',
    `curb_stop_installed` BOOLEAN COMMENT 'The curb stop installed value recorded for each service line in the distribution domain.',
    `curb_stop_location` STRING COMMENT 'The curb stop location value recorded for each service line in the distribution domain.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'The diameter inches value recorded for each service line in the distribution domain.',
    `dma_code` STRING COMMENT 'The dma code value recorded for each service line in the distribution domain.',
    `gis_feature_code` BOOLEAN COMMENT 'The gis feature code value recorded for each service line in the distribution domain.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the service line location.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the service line location.',
    `installation_date` DATE COMMENT 'The installation date associated with each service line record in the distribution domain.',
    `installation_year` STRING COMMENT 'The installation year value recorded for each service line in the distribution domain.',
    `last_inspection_date` DATE COMMENT 'The last inspection date associated with each service line record in the distribution domain.',
    `last_leak_repair_date` DATE COMMENT 'The last leak repair date associated with each service line record in the distribution domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each service line record in the distribution domain.',
    `lcrr_classification` STRING COMMENT 'The lcrr classification value recorded for each service line in the distribution domain.',
    `lcrr_inventory_verified` BOOLEAN COMMENT 'The lcrr inventory verified value recorded for each service line in the distribution domain.',
    `lcrr_verification_date` DATE COMMENT 'The lcrr verification date associated with each service line record in the distribution domain.',
    `lcrr_verification_method` STRING COMMENT 'The lcrr verification method value recorded for each service line in the distribution domain.',
    `leak_history_count` STRING COMMENT 'The leak history count value recorded for each service line in the distribution domain.',
    `length_feet` DECIMAL(18,2) COMMENT 'The length feet value recorded for each service line in the distribution domain.',
    `material_type` STRING COMMENT 'The material type value recorded for each service line in the distribution domain.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each service line in the distribution domain.',
    `notes` STRING COMMENT 'The notes value recorded for each service line in the distribution domain.',
    `ownership_type` STRING COMMENT 'The ownership type value recorded for each service line in the distribution domain.',
    `postal_code` STRING COMMENT 'The postal code component of the address for each service line record.',
    `pressure_zone_code` STRING COMMENT 'The pressure zone code value recorded for each service line in the distribution domain.',
    `replacement_method` STRING COMMENT 'The replacement method value recorded for each service line in the distribution domain.',
    `replacement_priority_score` STRING COMMENT 'The replacement priority score value recorded for each service line in the distribution domain.',
    `service_line_number` STRING COMMENT 'The service line number value recorded for each service line in the distribution domain.',
    `service_type` STRING COMMENT 'The service type value recorded for each service line in the distribution domain.',
    `state_province` STRING COMMENT 'The state province value recorded for each service line in the distribution domain.',
    `street_address` STRING COMMENT 'The street address value recorded for each service line in the distribution domain.',
    `tap_size_inches` DECIMAL(18,2) COMMENT 'The tap size inches value recorded for each service line in the distribution domain.',
    CONSTRAINT pk_service_line PRIMARY KEY(`service_line_id`)
) COMMENT 'Individual service connections from distribution mains to customer premises. Tracks material type, diameter, length, installation date, ownership, and LCRR lead classification. Central to EPA Lead and Copper Rule Revisions (LCRR) compliance requiring complete service line material inventory by October 2024. Links to customer accounts, meters, premises, and sampling points. Supports lead service line replacement programs and customer notification requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` (
    `pressure_zone_id` BIGINT COMMENT 'Unique identifier for the pressure zone within the distribution network. Primary key. Ref: OSIsoft PI Historian.',
    `arcgis_feature_code` BOOLEAN COMMENT 'Corresponding feature identifier in the Esri ArcGIS Geographic Information System (GIS) for spatial representation and network topology management. Ref: OSIsoft PI Historian.',
    `average_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Average daily water demand in Million Gallons per Day (MGD) for the pressure zone, used for capacity planning and hydraulic modeling. Ref: OSIsoft PI Historian.',
    `average_elevation_ft` DECIMAL(18,2) COMMENT 'Average ground elevation in feet above sea level across the pressure zone, used for hydraulic modeling and demand allocation. Ref: OSIsoft PI Historian.',
    `boundary_description` STRING COMMENT 'Textual description of the geographic or infrastructure boundaries defining the pressure zone, including major streets, landmarks, or infrastructure features. Ref: OSIsoft PI Historian.',
    `commissioning_date` DATE COMMENT 'Date when the pressure zone was officially commissioned and placed into active service for water distribution operations. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pressure zone record was first created in the system, used for audit trail and data lineage tracking. Ref: OSIsoft PI Historian.',
    `customer_count` STRING COMMENT 'Total number of active customer service connections within the pressure zone, used for demand forecasting and revenue allocation. Ref: OSIsoft PI Historian.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Design or nominal operating pressure in Pounds per Square Inch (PSI) for which the zone infrastructure was engineered and constructed. Ref: OSIsoft PI Historian.',
    `elevation_max_ft` DECIMAL(18,2) COMMENT 'Maximum ground elevation in feet above sea level within the pressure zone boundary, critical for pressure management and PRV settings. Ref: OSIsoft PI Historian.',
    `elevation_min_ft` DECIMAL(18,2) COMMENT 'Minimum ground elevation in feet above sea level within the pressure zone boundary, used for hydraulic gradient calculations. Ref: OSIsoft PI Historian.',
    `fire_flow_capacity_gpm` STRING COMMENT 'Minimum fire flow capacity in Gallons per Minute (GPM) that the pressure zone must maintain at specified residual pressure for fire protection, per Insurance Services Office (ISO) and NFPA standards.',
    `hydraulic_model_last_calibrated_date` DATE COMMENT 'Date when the hydraulic model for this pressure zone was last calibrated against field measurements, ensuring model accuracy for planning and operational decisions. Ref: OSIsoft PI Historian.',
    `infowater_model_zone_code` STRING COMMENT 'Corresponding pressure zone identifier in the Innovyze InfoWater hydraulic model, used for synchronization between operational systems and modeling platforms. Ref: OSIsoft PI Historian.',
    `last_boundary_review_date` DATE COMMENT 'Date when the pressure zone boundaries were last reviewed and validated for accuracy, typically as part of GIS updates or hydraulic model recalibration. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pressure zone record was last modified, used for audit trail, change tracking, and data synchronization. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each pressure zone in the distribution domain.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special considerations, historical context, or other relevant information about the pressure zone. Ref: OSIsoft PI Historian.',
    `nrw_percentage` DECIMAL(18,2) COMMENT 'Percentage of Non-Revenue Water (NRW) within the pressure zone, calculated as the difference between water supplied and billed consumption, used for loss control and efficiency analysis. Ref: OSIsoft PI Historian.',
    `operational_status` STRING COMMENT 'Current operational state of the pressure zone indicating whether it is actively serving customers, temporarily inactive, under maintenance, in emergency mode, or in planned development. Ref: OSIsoft PI Historian.. Valid values are `active|inactive|maintenance|emergency|planned`',
    `peak_hour_demand_mgd` DECIMAL(18,2) COMMENT 'Peak hourly water demand in Million Gallons per Day (MGD) for the pressure zone, critical for sizing infrastructure and ensuring adequate pressure during high-demand periods. Ref: OSIsoft PI Historian.',
    `residual_pressure_fire_psi` DECIMAL(18,2) COMMENT 'Minimum residual pressure in Pounds per Square Inch (PSI) that must be maintained during fire flow conditions to ensure adequate service to other customers and fire suppression effectiveness. Ref: OSIsoft PI Historian.',
    `scada_zone_tag` STRING COMMENT 'SCADA system tag or point identifier for real-time monitoring of pressure, flow, and operational status within this zone via OSIsoft PI Historian or similar SCADA platforms.',
    `service_area_sq_mi` DECIMAL(18,2) COMMENT 'Geographic area in square miles covered by the pressure zone, used for demand density calculations and infrastructure planning. Ref: OSIsoft PI Historian.',
    `storage_capacity_mg` DECIMAL(18,2) COMMENT 'Total storage capacity in Million Gallons (MG) of all tanks and reservoirs serving the pressure zone, used for emergency supply and pressure stabilization. Ref: OSIsoft PI Historian.',
    `target_pressure_max_psi` DECIMAL(18,2) COMMENT 'Maximum target operating pressure in Pounds per Square Inch (PSI) to prevent infrastructure damage, excessive leakage, and customer service issues. Ref: OSIsoft PI Historian.',
    `target_pressure_min_psi` DECIMAL(18,2) COMMENT 'Minimum target operating pressure in Pounds per Square Inch (PSI) that must be maintained throughout the zone to ensure adequate service delivery and regulatory compliance. Ref: OSIsoft PI Historian.',
    `ufw_percentage` DECIMAL(18,2) COMMENT 'Percentage of Unaccounted-for Water (UFW) within the pressure zone, representing water losses that cannot be attributed to known uses, critical for leak detection and infrastructure assessment. Ref: OSIsoft PI Historian.',
    `zone_code` STRING COMMENT 'Unique alphanumeric code or identifier for the pressure zone used in GIS, SCADA, and hydraulic modeling systems. Ref: OSIsoft PI Historian.',
    `zone_name` STRING COMMENT 'Business name or designation of the pressure zone used for operational reference and communication. Ref: OSIsoft PI Historian.',
    `zone_type` STRING COMMENT 'Classification of the pressure zone based on the primary method of pressure maintenance: gravity-fed from elevated storage, pumped from pump stations, combination of both, elevated tank-fed, or booster zone. Ref: OSIsoft PI Historian.. Valid values are `gravity|pumped|combination|elevated|booster`',
    CONSTRAINT pk_pressure_zone PRIMARY KEY(`pressure_zone_id`)
) COMMENT 'Hydraulic pressure zones within the distribution system, each maintained at target pressure ranges through storage tanks, pump stations, and PRV stations. Tracks elevation ranges, design pressures, customer count, demand patterns, storage capacity, and NRW metrics. Essential for hydraulic modeling, fire flow analysis, and system planning per AWWA M31 Distribution System Requirements for Fire Protection.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`dma` (
    `dma_id` BIGINT COMMENT 'Unique identifier for the District Metered Area. Primary key for the DMA master record. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee or team responsible for monitoring and maintaining the DMA. Used for accountability and work assignment. Ref: OSIsoft PI Historian.',
    `dma_responsible_operator_employee_id` BIGINT COMMENT 'Reference to the workforce employee or team responsible for monitoring and maintaining the DMA. Used for accountability and work assignment. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone within which this DMA operates. Pressure zones define areas of similar hydraulic pressure managed by Pressure Reducing Valves (PRVs) and pump stations. Ref: OSIsoft PI Historian.',
    `maintenance_zone_id` BIGINT COMMENT 'Reference to the maintenance zone or service district to which the DMA belongs. Used for work order routing and resource planning. Ref: OSIsoft PI Historian.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure within the DMA measured in Pounds per Square Inch. Pressure management is critical for leakage control; excessive pressure increases leak rates and pipe stress. Ref: OSIsoft PI Historian.',
    `boundary_description` STRING COMMENT 'Textual description of the DMA boundary including street names, landmarks, and physical boundaries used to define the hydraulically isolated zone.',
    `dma_code` STRING COMMENT 'Business identifier code for the DMA used in operational systems, GIS, and reporting. Typically alphanumeric and unique across the distribution network. Ref: OSIsoft PI Historian.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DMA record was first created in the system. Used for audit trail and data lineage tracking. Ref: OSIsoft PI Historian.',
    `criticality_rating` STRING COMMENT 'Business criticality rating of the DMA based on factors such as population served, infrastructure condition, leakage history, and service area importance. Critical DMAs receive priority for monitoring and maintenance. Ref: OSIsoft PI Historian.. Valid values are `critical|high|medium|low`',
    `decommissioned_date` DATE COMMENT 'Date when the DMA was decommissioned or reconfigured. Null for active DMAs. Used for historical tracking and audit purposes. Ref: OSIsoft PI Historian.',
    `dma_description` STRING COMMENT 'Detailed description of the DMA including boundary landmarks, service area characteristics, and any operational notes relevant to leakage management and monitoring. Ref: OSIsoft PI Historian.',
    `design_flow_mgd` DECIMAL(18,2) COMMENT 'Design flow capacity for the DMA in Million Gallons per Day. Represents the maximum daily demand the DMA is engineered to supply under normal operating conditions. Ref: OSIsoft PI Historian.',
    `dma_status` STRING COMMENT 'Current operational status of the DMA. Active DMAs are fully operational and monitored; inactive or decommissioned DMAs are no longer in use; planned DMAs are in design phase; under review indicates reconfiguration or audit in progress. Ref: OSIsoft PI Historian.. Valid values are `active|inactive|planned|decommissioned|under_review|suspended`',
    `established_date` DATE COMMENT 'Date when the DMA was first established and commissioned for operational monitoring. Represents the start of the DMAs lifecycle. Ref: OSIsoft PI Historian.',
    `gis_polygon_boundary` BOOLEAN COMMENT 'GIS polygon geometry defining the spatial boundary of the DMA. Typically stored as WKT (Well-Known Text) or reference to GIS layer feature ID for integration with Esri ArcGIS. Ref: OSIsoft PI Historian.',
    `inlet_meter_count` STRING COMMENT 'Number of inlet flow meters installed at entry points to the DMA. Inlet meters measure total water entering the zone and are critical for NRW calculation. Ref: OSIsoft PI Historian.',
    `isolation_valve_count` STRING COMMENT 'Number of isolation valves installed at the DMA boundary. Isolation valves enable hydraulic isolation of the DMA for accurate flow measurement and leakage detection.',
    `last_leakage_survey_date` DATE COMMENT 'Date of the most recent active leakage detection survey conducted within the DMA. Used to track compliance with leakage management programs. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the DMA record was last updated. Used for audit trail, change tracking, and data synchronization. Ref: OSIsoft PI Historian.',
    `leakage_detection_frequency_days` STRING COMMENT 'Frequency in days at which active leakage detection surveys are conducted within the DMA. High-risk or high-leakage DMAs may be surveyed more frequently. Ref: OSIsoft PI Historian.',
    `main_length_miles` DECIMAL(18,2) COMMENT 'Total length of water mains (distribution pipes) within the DMA measured in miles. Used for calculating leakage per mile of main and infrastructure density metrics. Ref: OSIsoft PI Historian.',
    `minimum_night_flow_threshold_gpm` DECIMAL(18,2) COMMENT 'Minimum Night Flow threshold in Gallons per Minute. MNF is the lowest flow rate measured during nighttime hours (typically 2 AM to 4 AM) when legitimate consumption is minimal. Elevated MNF indicates leakage within the DMA. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each dma in the distribution domain.',
    `dma_name` STRING COMMENT 'Human-readable name or designation of the DMA, often reflecting geographic location or service area (e.g., Downtown West DMA, Industrial Park Zone 3). Ref: OSIsoft PI Historian.',
    `next_scheduled_survey_date` DATE COMMENT 'Scheduled date for the next active leakage detection survey within the DMA. Used for planning and resource allocation. Ref: OSIsoft PI Historian.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, historical context, or any additional information relevant to the DMA management and monitoring. Ref: OSIsoft PI Historian.',
    `outlet_meter_count` STRING COMMENT 'Number of outlet flow meters installed at exit points from the DMA. Outlet meters are used in complex DMA configurations where water may flow to adjacent zones. Ref: OSIsoft PI Historian.',
    `population_served` STRING COMMENT 'Estimated population served by the DMA. Used for per-capita consumption analysis and demand forecasting. Ref: OSIsoft PI Historian.',
    `prv_count` STRING COMMENT 'Number of Pressure Reducing Valves installed within or at the boundary of the DMA. PRVs control pressure to reduce leakage and pipe stress. Ref: OSIsoft PI Historian.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the DMA is actively monitored by the SCADA system. SCADA-monitored DMAs provide real-time flow, pressure, and alarm data for proactive leakage management. Ref: OSIsoft PI Historian.',
    `service_connection_count` STRING COMMENT 'Total number of active service connections (customer meters) within the DMA. Used for calculating per-connection leakage rates and NRW metrics. Ref: OSIsoft PI Historian.',
    `target_nrw_percentage` DECIMAL(18,2) COMMENT 'Target threshold for Non-Revenue Water as a percentage of total water supplied to the DMA. NRW includes physical losses (leakage) and commercial losses (metering inaccuracies, theft). Typical industry targets range from 10% to 20%. Ref: OSIsoft PI Historian.',
    `target_ufw_percentage` DECIMAL(18,2) COMMENT 'Target threshold for Unaccounted-for Water as a percentage of total water supplied. UFW is a broader measure than NRW and includes all water that cannot be accounted for through billing or authorized use. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_dma PRIMARY KEY(`dma_id`)
) COMMENT 'District Metered Areas (DMAs) for water loss control and non-revenue water (NRW) management. Each DMA is a discrete zone with defined boundaries, inlet/outlet metering, and isolation valves enabling water balance calculations per IWA Water Loss Task Force methodology. Tracks minimum night flow, leakage detection frequency, infrastructure leakage index (ILI), and target NRW percentages. Central to AWWA M36 Water Audits and Loss Control Programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` (
    `network_valve_id` BIGINT COMMENT 'Unique identifier for the distribution network valve record. Primary key. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) containing this valve. DMAs are isolated network sections with defined boundaries and metered inflows/outflows, used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Valves on DMA boundaries are critical for isolation and flow control.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Valves are capitalized assets requiring depreciation tracking and condition-based valuation for asset management financial reporting, replacement cost analysis, and GASB compliance. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Valves are procured inventory items with manufacturer specifications. Essential for spare parts management, warranty tracking, equipment standardization programs, and maintenance planning. Manufacture. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Reference to the asset registry record in the Computerized Maintenance Management System (CMMS). Links this valve to IBM Maximo Asset Management for maintenance tracking, work orders, and lifecycle management.',
    `network_registry_id` BIGINT COMMENT 'Reference to the asset registry record in the Computerized Maintenance Management System (CMMS). Links this valve to IBM Maximo Asset Management for maintenance tracking, work orders, and lifecycle management.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the water main on which this valve is installed. Links the valve to the pipe segment for network topology modeling in Esri ArcGIS and Innovyze InfoWater. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which this valve is located. Pressure zones are geographic areas maintained at specific pressure ranges (measured in Pounds per Square Inch - PSI) to ensure adequate service and prevent pipe bursts. Critical for hydraulic modeling in Innovyze InfoWater. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Valve suppliers tracked for approved vendor list management, quality assurance, delivery performance, and warranty management. Essential for procurement compliance and equipment standardization progra. Ref: OSIsoft PI Historian.',
    `burial_depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the valve operating nut. Used for excavation planning, valve box sizing, and accessibility assessment. Typical range is 3-8 feet depending on frost line and main depth. Ref: OSIsoft PI Historian.',
    `city` STRING COMMENT 'City or municipality in which the valve is located. Used for jurisdictional reporting and geographic analysis. Ref: OSIsoft PI Historian.',
    `condition_rating` STRING COMMENT 'Assessment of the valves physical condition based on the most recent inspection. Excellent: like new, no defects; Good: minor wear, fully functional; Fair: moderate wear, functional with minor issues; Poor: significant deterioration, may fail soon; Critical: immediate replacement required. Used for risk-based asset management and Capital Expenditure (CAPEX) planning. Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve record was first created in the system. Used for data lineage, audit trails, and compliance with data governance policies. Ref: OSIsoft PI Historian.',
    `criticality_rating` STRING COMMENT 'Business criticality of the valve based on its role in the distribution network. Critical valves control large trunk mains or serve hospitals/fire protection; high criticality valves isolate major zones; medium and low criticality valves serve smaller areas. Drives maintenance prioritization and replacement sequencing.. Valid values are `critical|high|medium|low`',
    `current_position` STRING COMMENT 'Actual current position of the valve as of the last field verification or SCADA reading. May differ from normal_position during maintenance, emergencies, or operational adjustments. Ref: OSIsoft PI Historian.. Valid values are `open|closed|throttled|unknown`',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the valve in inches. Critical for hydraulic modeling in Innovyze InfoWater and flow capacity calculations. Common sizes range from 2 to 48 inches in distribution networks. Ref: OSIsoft PI Historian.',
    `exercising_frequency_months` STRING COMMENT 'Planned frequency in months for valve exercising activities. Typically 12 months for standard valves, 6 months for critical isolation valves, and 24 months for low-priority valves. Drives preventive maintenance scheduling in CMMS.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier in the Esri ArcGIS system. Links this valve record to the corresponding GIS feature layer for spatial analysis, map display, and network topology modeling. Ref: OSIsoft PI Historian.',
    `installation_date` DATE COMMENT 'Date the valve was originally installed in the distribution network. Used for age-based asset management, depreciation calculations, and replacement planning under the Capital Improvement Program (CIP). Ref: OSIsoft PI Historian.',
    `installation_year` STRING COMMENT 'Year the valve was installed. Derived from installation_date for simplified age analysis and reporting when exact date is not required. Ref: OSIsoft PI Historian.',
    `is_buried` BOOLEAN COMMENT 'Indicates whether the valve is buried underground (True) or above ground in a vault or building (False). Buried valves require valve box access and are more difficult to exercise; above-ground valves are more accessible but require weather protection. Ref: OSIsoft PI Historian.',
    `is_motorized` BOOLEAN COMMENT 'Indicates whether the valve is equipped with a motor or actuator for remote operation. True for SCADA-controlled valves; False for manual valves requiring field crew operation. Ref: OSIsoft PI Historian.',
    `last_exercised_by` STRING COMMENT 'Name or identifier of the crew member or contractor who last exercised the valve. Supports accountability and quality assurance in valve maintenance programs. Ref: OSIsoft PI Historian.',
    `last_exercised_date` DATE COMMENT 'Date the valve was last exercised (opened and closed through its full range of motion). Regular valve exercising prevents seizing and ensures operability during emergencies. AWWA recommends annual exercising for critical valves.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the valve location in decimal degrees. Used for Geographic Information System (GIS) mapping in Esri ArcGIS, field crew navigation, and spatial analysis. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the valve location in decimal degrees. Used for Geographic Information System (GIS) mapping in Esri ArcGIS, field crew navigation, and spatial analysis. Ref: OSIsoft PI Historian.',
    `material` STRING COMMENT 'Primary construction material of the valve body. Ductile iron is most common for large distribution valves; bronze and brass for smaller service valves; stainless steel for corrosive environments; PVC for low-pressure applications. Ref: OSIsoft PI Historian.. Valid values are `cast_iron|ductile_iron|bronze|stainless_steel|pvc|brass`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve record was last modified. Supports change tracking, audit requirements, and data quality monitoring. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each network valve in the distribution domain.',
    `normal_position` STRING COMMENT 'Standard operating position of the valve under normal conditions. Critical for hydraulic modeling, isolation planning, and Supervisory Control and Data Acquisition (SCADA) monitoring. Most distribution valves are normally open; some isolation and control valves are normally closed or throttled.. Valid values are `open|closed|throttled`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, access restrictions, or historical information about the valve. Examples: Requires two-person crew due to tight turns, Located in private easement, coordinate access, Replaced stem in 2018. Ref: OSIsoft PI Historian.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure at the valve location in Pounds per Square Inch (PSI). Used for hydraulic modeling, pressure zone verification, and valve sizing validation. Typical distribution system pressures range from 40-120 PSI. Ref: OSIsoft PI Historian.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the valve in the distribution network. Active valves are in service; inactive valves are temporarily out of service; abandoned valves are no longer used but not removed; removed valves have been physically extracted; planned valves are scheduled for installation. Ref: OSIsoft PI Historian.. Valid values are `active|inactive|abandoned|removed|planned`',
    `postal_code` STRING COMMENT 'Postal code of the valve location. Supports geographic segmentation and service area analysis. Ref: OSIsoft PI Historian.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum rated working pressure of the valve in Pounds per Square Inch (PSI) as specified by the manufacturer. Must exceed operating_pressure_psi with adequate safety margin. Common ratings are 150, 200, 250, and 300 PSI. Ref: OSIsoft PI Historian.',
    `scada_tag` STRING COMMENT 'SCADA system tag identifier for automated valves with remote monitoring and control capability. Links to OSIsoft PI Historian for real-time position monitoring, alarm management, and operational analytics. Only populated for motorized or actuated valves integrated with SCADA.',
    `state_province` STRING COMMENT 'State or province in which the valve is located. Used for regulatory reporting to State Drinking Water Programs and Primacy Agencies. Ref: OSIsoft PI Historian.',
    `street_address` STRING COMMENT 'Nearest street address or intersection to the valve location. Provides human-readable location reference for field crews, emergency responders, and customer service representatives. Ref: OSIsoft PI Historian.',
    `turns_to_close` STRING COMMENT 'Number of complete turns required to fully close the valve from the fully open position. Used by field crews during valve exercising programs and emergency isolation procedures. Typical range is 5-50 turns depending on valve size and type.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the valve in years from installation date. Used for depreciation calculations per Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB) standards, and for long-term replacement planning. Typical range is 50-75 years for distribution valves. Ref: OSIsoft PI Historian.',
    `valve_box_type` STRING COMMENT 'Type of valve box or access structure protecting the buried valve. Standard boxes for sidewalk/lawn areas; traffic-rated boxes for roadways; extension boxes for deep valves; vaults for large valves; none for above-ground installations. Ref: OSIsoft PI Historian.. Valid values are `standard|traffic_rated|extension|vault|none`',
    `valve_function` STRING COMMENT 'Primary operational function of the valve in the distribution network. Isolation valves segment the network for maintenance; control valves regulate flow; pressure reducing valves (PRV) manage pressure zones; check valves prevent backflow; air release valves expel trapped air; blowoff valves drain sections.. Valid values are `isolation|control|pressure_reducing|check|air_release|blowoff`',
    `valve_number` STRING COMMENT 'Externally-known business identifier for the valve, typically painted or tagged on the valve in the field. Used by operations and maintenance crews for identification. Ref: OSIsoft PI Historian.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `valve_type` STRING COMMENT 'Classification of the valve mechanism. Gate valves provide full flow with minimal pressure drop; butterfly valves are compact and quick-operating; ball valves offer tight shutoff; check valves prevent backflow; plug, cone, and needle valves provide throttling control. [ENUM-REF-CANDIDATE: gate|butterfly|ball|check|plug|cone|needle — 7 candidates stripped; promote to reference product]. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_network_valve PRIMARY KEY(`network_valve_id`)
) COMMENT 'Isolation and control valves in the distribution network. Tracks valve type (gate, butterfly, ball), size, material, position, exercising history, and operability status. Regular valve exercising programs per AWWA M44 Distribution Valves prevent valve failures during emergencies. Links to asset registry, work orders, and maintenance schedules in IBM Maximo.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` (
    `prv_station_id` BIGINT COMMENT 'Unique identifier for the PRV station record. Primary key. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that the PRV station serves or controls for NRW analysis. Ref: OSIsoft PI Historian.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: PRV stations are major capital assets with significant acquisition costs requiring depreciation tracking for rate base calculations and capital asset inventory in financial statements. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: PRV equipment is procured with specific make/model specifications. Required for maintenance parts inventory, equipment standardization, lifecycle replacement planning, and capital asset management. Ma. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the upstream hydraulic pressure zone feeding into the PRV station. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: PRV stations are major capital assets requiring PM schedules, condition assessments, criticality ratings, and financial tracking. Standard practice for enterprise asset management in water distributio. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: PRV equipment suppliers tracked for maintenance service contracts, equipment procurement, technical support, and warranty management. Critical for pressure management system reliability and vendor per. Ref: OSIsoft PI Historian.',
    `address` STRING COMMENT 'Physical street address or location description of the PRV station for field operations and emergency response. Ref: OSIsoft PI Historian.',
    `asset_criticality` STRING COMMENT 'Business criticality classification of the PRV station based on impact to service delivery and network reliability. Ref: OSIsoft PI Historian.. Valid values are `critical|high|medium|low`',
    `bypass_configuration` STRING COMMENT 'Type of bypass arrangement installed at the PRV station for maintenance and emergency operations. Ref: OSIsoft PI Historian.. Valid values are `none|manual|automatic|redundant`',
    `calibration_frequency_months` STRING COMMENT 'Standard interval in months between required calibration activities for the PRV station. Ref: OSIsoft PI Historian.',
    `city` STRING COMMENT 'City or municipality where the PRV station is located. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PRV station record was first created in the system. Ref: OSIsoft PI Historian.',
    `design_flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the PRV station in Gallons Per Minute (GPM) under normal operating conditions. Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier in the Esri ArcGIS system linking the PRV station to the spatial network model. Ref: OSIsoft PI Historian.',
    `hydraulic_model_node_code` STRING COMMENT 'Node identifier in the Innovyze InfoWater hydraulic model representing the PRV station for network analysis. Ref: OSIsoft PI Historian.',
    `installation_date` DATE COMMENT 'Date when the PRV station was originally installed and commissioned in the distribution network. Ref: OSIsoft PI Historian.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration or pressure set point verification performed on the PRV. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the PRV station record was most recently updated. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the PRV station location in decimal degrees for GIS mapping. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the PRV station location in decimal degrees for GIS mapping. Ref: OSIsoft PI Historian.',
    `maximo_asset_number` STRING COMMENT 'Asset number in IBM Maximo CMMS for work order management and maintenance tracking.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each prv station in the distribution domain.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or maintenance inspection of the PRV. Ref: OSIsoft PI Historian.',
    `notes` STRING COMMENT 'Free-form text field for operational notes, special instructions, or historical information about the PRV station. Ref: OSIsoft PI Historian.',
    `operational_status` STRING COMMENT 'Current operational state of the PRV station in the distribution network lifecycle. Ref: OSIsoft PI Historian.. Valid values are `active|inactive|standby|maintenance|decommissioned|planned`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the PRV station asset. Ref: OSIsoft PI Historian.. Valid values are `utility_owned|customer_owned|shared|leased`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the PRV station location. Ref: OSIsoft PI Historian.',
    `prv_serial_number` STRING COMMENT 'Unique serial number of the pressure reducing valve equipment for warranty and maintenance tracking. Ref: OSIsoft PI Historian.',
    `rtu_code` STRING COMMENT 'Identifier of the Remote Terminal Unit (RTU) device installed at the PRV station for SCADA communication. Ref: OSIsoft PI Historian.',
    `scada_tag_flow_rate` DECIMAL(18,2) COMMENT 'OSIsoft PI Historian tag reference for real-time flow rate monitoring via SCADA system.',
    `scada_tag_inlet_pressure` STRING COMMENT 'OSIsoft PI Historian tag reference for real-time inlet pressure monitoring via SCADA system.',
    `scada_tag_outlet_pressure` STRING COMMENT 'OSIsoft PI Historian tag reference for real-time outlet pressure monitoring via SCADA system.',
    `set_point_pressure_psi` DECIMAL(18,2) COMMENT 'Target outlet pressure in Pounds per Square Inch (PSI) that the PRV is configured to maintain. Ref: OSIsoft PI Historian.',
    `state` STRING COMMENT 'State or province where the PRV station is located. Ref: OSIsoft PI Historian.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the PRV station for asset tracking and GIS integration. Ref: OSIsoft PI Historian.',
    `station_name` STRING COMMENT 'Business name or designation of the PRV station for operational reference. Ref: OSIsoft PI Historian.',
    `station_type` STRING COMMENT 'Classification of the PRV station installation type based on physical configuration. Ref: OSIsoft PI Historian.. Valid values are `inline|vault|above_ground|below_ground|chamber|kiosk`',
    `telemetry_status` STRING COMMENT 'Current connectivity status of the SCADA telemetry equipment at the PRV station. Ref: OSIsoft PI Historian.. Valid values are `online|offline|intermittent|not_installed`',
    `valve_size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the PRV in inches, indicating flow capacity and pipe connection size. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_prv_station PRIMARY KEY(`prv_station_id`)
) COMMENT 'Pressure Reducing Valve (PRV) stations controlling pressure between zones. Tracks set point pressures, inlet/outlet pressures, flow capacity, bypass configuration, and SCADA integration. Critical for maintaining optimal system pressures, reducing leakage, and protecting customer plumbing per AWWA M11. Monitored via OSIsoft PI Historian or similar SCADA systems.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` (
    `hydrant_id` BIGINT COMMENT 'Unique identifier for the fire hydrant asset in the distribution network. Primary key. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) to which the hydrant belongs, used for Non-Revenue Water (NRW) analysis and leak detection programs. Ref: OSIsoft PI Historian.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Hydrants are capitalized assets tracked for depreciation, replacement cost analysis, annual GASB reporting, insurance valuation, and capital planning in water utilities. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Identifier of the nearest or connected water main pipe from which the hydrant is fed, used for hydraulic modeling and network topology analysis. Ref: OSIsoft PI Historian.',
    `hydrant_pipe_main_id` BIGINT COMMENT 'Identifier of the nearest or connected water main pipe from which the hydrant is fed, used for hydraulic modeling and network topology analysis. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Hydrants are standardized procured assets. Essential for spare parts inventory, replacement programs, manufacturer warranty tracking, and fire flow compliance. Manufacturer and model specifications no. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone or hydraulic district in which the hydrant is located, used for pressure management and network segmentation. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Hydrants are individual assets with inspection schedules, maintenance requirements, replacement cost tracking, and regulatory compliance needs (NFPA/ISO). Essential for asset lifecycle management and ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Hydrant manufacturers/suppliers tracked for warranty management, product recall tracking, approved vendor compliance, and fire protection equipment standards. Essential for public safety and regulator. Ref: OSIsoft PI Historian.',
    `bury_depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the hydrant valve or base, critical for freeze protection and installation specifications. Ref: OSIsoft PI Historian.',
    `city` STRING COMMENT 'City or municipality name where the hydrant is located. Ref: OSIsoft PI Historian.',
    `condition_status` STRING COMMENT 'Current physical condition assessment of the hydrant based on inspection findings: excellent (like new), good (minor wear), fair (functional with moderate wear), poor (requires repair), critical (non-functional or unsafe). Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrant record was first created in the asset management system. Ref: OSIsoft PI Historian.',
    `criticality_rating` STRING COMMENT 'Business criticality rating based on consequence-of-failure analysis: critical (hospitals, schools, high-density areas), high (commercial districts), medium (residential), low (rural or redundant coverage). Ref: OSIsoft PI Historian.. Valid values are `critical|high|medium|low`',
    `fire_district` STRING COMMENT 'Name or code of the fire protection district or fire department jurisdiction responsible for this hydrant, used for emergency response coordination. Ref: OSIsoft PI Historian.',
    `flow_capacity_gpm` STRING COMMENT 'Rated fire flow capacity of the hydrant in gallons per minute (GPM) at 20 pounds per square inch (PSI) residual pressure, determined by flow testing per NFPA 291. Ref: OSIsoft PI Historian.',
    `flow_class_color` STRING COMMENT 'Color coding per NFPA 291 indicating fire flow capacity class: Red (<500 GPM), Orange (500-999 GPM), Green (1000-1499 GPM), Blue (>=1500 GPM), Light Blue (>=2500 GPM). Used for visual identification by fire departments. Ref: OSIsoft PI Historian.. Valid values are `red|orange|green|blue|light_blue`',
    `flushing_program_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this hydrant is included in the routine unidirectional flushing program for water quality maintenance and sediment removal. Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier from the Esri ArcGIS system linking this hydrant record to the spatial GIS layer for network modeling and map visualization. Ref: OSIsoft PI Historian.',
    `hydrant_number` STRING COMMENT 'External business identifier or asset tag number assigned to the hydrant for field operations, maintenance tracking, and municipal records. Ref: OSIsoft PI Historian.',
    `hydrant_type` STRING COMMENT 'Classification of hydrant design. Dry barrel hydrants drain after use (freeze-resistant for cold climates), wet barrel hydrants remain charged with water (warm climates), flush hydrants are below-grade, wall hydrants are building-mounted. Ref: OSIsoft PI Historian.. Valid values are `dry_barrel|wet_barrel|flush|wall`',
    `installation_date` DATE COMMENT 'Date when the hydrant was originally installed in the distribution network. Ref: OSIsoft PI Historian.',
    `installation_year` STRING COMMENT 'Year of hydrant installation, used for age-based asset management, depreciation schedules, and replacement planning. Ref: OSIsoft PI Historian.',
    `last_flow_test_date` DATE COMMENT 'Date of the most recent fire flow test conducted on the hydrant per NFPA 291 standards, used to verify flow capacity and pressure performance. Ref: OSIsoft PI Historian.',
    `last_flushing_date` DATE COMMENT 'Date when the hydrant was last used for system flushing or water quality maintenance activities. Ref: OSIsoft PI Historian.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent routine inspection of the hydrant for physical condition, operability, and maintenance needs. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrant record was last updated in the asset management system, used for audit trail and data lineage tracking. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the hydrant location for GIS mapping, spatial analysis, and emergency response routing. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the hydrant location for GIS mapping, spatial analysis, and emergency response routing. Ref: OSIsoft PI Historian.',
    `main_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the connected water main pipe in inches, critical for fire flow capacity calculations and hydraulic modeling. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each hydrant in the distribution domain.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next routine inspection of the hydrant, based on preventive maintenance (PM) schedule and regulatory requirements. Ref: OSIsoft PI Historian.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the hydrant (e.g., access restrictions, historical issues, special maintenance requirements). Ref: OSIsoft PI Historian.',
    `operational_status` STRING COMMENT 'Current operational status of the hydrant in the distribution network: in_service (active and available), out_of_service (temporarily unavailable), under_repair (maintenance in progress), abandoned (permanently removed from service), planned (not yet installed). Ref: OSIsoft PI Historian.. Valid values are `in_service|out_of_service|under_repair|abandoned|planned`',
    `outlet_count` STRING COMMENT 'Total number of discharge outlets (nozzles) on the hydrant, typically 2-5 outlets including pumper and hose connections. Ref: OSIsoft PI Historian.',
    `outlet_size_inches` STRING COMMENT 'Sizes of hydrant outlets in inches, typically formatted as a comma-separated list (e.g., 2.5,2.5,4.5 for two 2.5-inch hose outlets and one 4.5-inch pumper outlet). Ref: OSIsoft PI Historian.',
    `ownership_type` STRING COMMENT 'Entity responsible for ownership and maintenance of the hydrant: utility_owned (water utility), municipality_owned (city/town), private (property owner), fire_district (fire protection district). Ref: OSIsoft PI Historian.. Valid values are `utility_owned|municipality_owned|private|fire_district`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the hydrant location, used for geographic segmentation and service area analysis. Ref: OSIsoft PI Historian.',
    `residual_pressure_psi` DECIMAL(18,2) COMMENT 'Residual water pressure at the hydrant in pounds per square inch (PSI) during flow testing at rated capacity, used to assess available fire flow. Ref: OSIsoft PI Historian.',
    `scada_tag` STRING COMMENT 'SCADA system tag or point identifier if the hydrant is equipped with remote monitoring sensors (e.g., pressure transducers), integrated with OSIsoft PI Historian.',
    `state_province` STRING COMMENT 'State or province code (e.g., CA, TX, ON) where the hydrant is located. Ref: OSIsoft PI Historian.',
    `static_pressure_psi` DECIMAL(18,2) COMMENT 'Static water pressure at the hydrant location in pounds per square inch (PSI) when no water is flowing, measured during flow testing. Ref: OSIsoft PI Historian.',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the hydrant is located, used for field crew dispatch and fire department coordination. Ref: OSIsoft PI Historian.',
    `valve_turns_to_open` DECIMAL(18,2) COMMENT 'Number of complete turns required to fully open the hydrant main valve, used for operational training and maintenance documentation. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_hydrant PRIMARY KEY(`hydrant_id`)
) COMMENT 'Fire hydrants providing emergency water supply for fire protection. Tracks hydrant type, outlet configuration, flow capacity, static/residual pressures, flow test results, flushing history, and NFPA color classification. Flow testing per AWWA M17 Installation, Field Testing, and Maintenance of Fire Hydrants supports ISO fire flow ratings and hydraulic model calibration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` (
    `pump_station_id` BIGINT COMMENT 'Unique identifier for the booster pump station within the distribution network. Primary key. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) that this pump station serves for NRW and UFW analysis. Ref: OSIsoft PI Historian.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Pump stations are high-value capital assets central to rate base and depreciation schedules, essential for regulatory asset reporting, financial statements, and rate case filings. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone served by this pump station for hydraulic modeling and network segmentation. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Pump stations are critical assets requiring comprehensive lifecycle management, PM scheduling, condition assessments, criticality ratings, and depreciation tracking. Core requirement for enterprise as. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Pump equipment suppliers/service contractors tracked for maintenance contracts, equipment procurement, service level agreements, and emergency response. Critical for system reliability and operational. Ref: OSIsoft PI Historian.',
    `address_line_1` STRING COMMENT 'Primary street address of the pump station facility for physical access and emergency response. Ref: OSIsoft PI Historian.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number or suite for the pump station facility. Ref: OSIsoft PI Historian.',
    `asset_condition_rating` STRING COMMENT 'Current condition assessment rating of the pump station based on inspection and maintenance records. Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|critical`',
    `backup_generator_available` BOOLEAN COMMENT 'Indicates whether the pump station has a backup generator for emergency power supply. Ref: OSIsoft PI Historian.',
    `backup_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Capacity of the backup generator in kilowatts (kW) if available. Ref: OSIsoft PI Historian.',
    `city` STRING COMMENT 'City or municipality where the pump station is located. Ref: OSIsoft PI Historian.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the pump station is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump station record was first created in the system. Ref: OSIsoft PI Historian.',
    `criticality_rating` STRING COMMENT 'Business criticality rating indicating the importance of this pump station to system operations and service delivery. Ref: OSIsoft PI Historian.. Valid values are `critical|high|medium|low`',
    `design_flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the pump station measured in gallons per minute (GPM). Ref: OSIsoft PI Historian.',
    `design_flow_capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the pump station measured in million gallons per day (MGD). Ref: OSIsoft PI Historian.',
    `discharge_pressure_psi` DECIMAL(18,2) COMMENT 'Target discharge pressure in pounds per square inch (PSI) maintained by the pump station. Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier in the Esri ArcGIS system linking this pump station to the GIS network model. Ref: OSIsoft PI Historian.',
    `hydraulic_model_node_code` STRING COMMENT 'Node identifier in the Innovyze InfoWater hydraulic model representing this pump station. Ref: OSIsoft PI Historian.',
    `installation_date` DATE COMMENT 'Date when the pump station was originally installed and commissioned. Ref: OSIsoft PI Historian.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major upgrade or rehabilitation of the pump station. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump station record was last updated in the system. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the pump station location in decimal degrees for GIS integration. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the pump station location in decimal degrees for GIS integration. Ref: OSIsoft PI Historian.',
    `maximo_asset_number` STRING COMMENT 'Asset number assigned to the pump station in the IBM Maximo CMMS for maintenance management.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each pump station in the distribution domain.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or historical information about the pump station. Ref: OSIsoft PI Historian.',
    `number_of_duty_pumps` STRING COMMENT 'Count of pumps designated for normal operational duty at the station. Ref: OSIsoft PI Historian.',
    `number_of_pumps` STRING COMMENT 'Total count of pump units installed at the station, including duty and standby pumps. Ref: OSIsoft PI Historian.',
    `number_of_standby_pumps` STRING COMMENT 'Count of pumps designated as standby or backup units for redundancy. Ref: OSIsoft PI Historian.',
    `operational_status` STRING COMMENT 'Current operational state of the pump station indicating availability for service. Ref: OSIsoft PI Historian.. Valid values are `active|standby|maintenance|inactive|decommissioned|under_construction`',
    `ownership_type` STRING COMMENT 'Ownership classification of the pump station asset. Ref: OSIsoft PI Historian.. Valid values are `owned|leased|shared|third_party`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the pump station location. Ref: OSIsoft PI Historian.',
    `power_supply_phase` STRING COMMENT 'Electrical power supply phase configuration for the pump station. Ref: OSIsoft PI Historian.. Valid values are `single_phase|three_phase`',
    `power_supply_voltage` STRING COMMENT 'Electrical power supply voltage specification for the pump station (e.g., 480V, 4160V). Ref: OSIsoft PI Historian.',
    `scada_integrated` BOOLEAN COMMENT 'Indicates whether the pump station is integrated with the SCADA system for remote monitoring and control. Ref: OSIsoft PI Historian.',
    `scada_tag_prefix` STRING COMMENT 'Prefix used for SCADA tags associated with this pump station in the OSIsoft PI Historian system.',
    `state_province` STRING COMMENT 'State or province code where the pump station is located. Ref: OSIsoft PI Historian.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the pump station for asset tracking and SCADA integration. Ref: OSIsoft PI Historian.',
    `station_name` STRING COMMENT 'Business name or designation of the pump station for operational reference and reporting. Ref: OSIsoft PI Historian.',
    `station_type` STRING COMMENT 'Classification of the pump station based on its operational function within the distribution network. Ref: OSIsoft PI Historian.. Valid values are `booster|transfer|lift|high_service|low_service|emergency`',
    `suction_pressure_psi` DECIMAL(18,2) COMMENT 'Inlet or suction pressure in pounds per square inch (PSI) at the pump station intake. Ref: OSIsoft PI Historian.',
    `total_dynamic_head_ft` DECIMAL(18,2) COMMENT 'Total dynamic head (TDH) in feet that the pump station must overcome, including elevation and friction losses. Ref: OSIsoft PI Historian.',
    `vfd_configuration` STRING COMMENT 'Description of the VFD configuration including number of drives and control strategy. Ref: OSIsoft PI Historian.',
    `vfd_equipped` BOOLEAN COMMENT 'Indicates whether the pump station is equipped with Variable Frequency Drive (VFD) technology for flow and pressure control. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_pump_station PRIMARY KEY(`pump_station_id`)
) COMMENT 'Distribution system pump stations (booster stations) maintaining pressure and flow. Tracks pump count, duty/standby configuration, design flow capacity, total dynamic head, VFD configuration, power supply, backup generation, and SCADA integration. Energy monitoring supports efficiency optimization per AWWA M32. Links to asset registry, work orders, and energy meters.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` (
    `storage_tank_id` BIGINT COMMENT 'Unique identifier for the potable water storage facility. Primary key for the storage tank master record. Ref: OSIsoft PI Historian.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Storage tanks are major capital assets requiring depreciation, insurance valuation, and regulatory reporting for GASB compliance, rate base calculations, and asset valuation. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Tanks are major capital assets with material specifications. Required for coating materials procurement, structural component tracking, rehabilitation planning, and regulatory compliance for water sto. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone served by this storage tank. Pressure zones are geographic areas of the distribution network maintained at similar hydraulic pressure ranges. Ref: OSIsoft PI Historian.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Storage tanks are major capital assets with regulatory inspection requirements (AWWA D100), condition assessments, coating schedules, and depreciation tracking. Essential for asset management and fina',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that this storage tank serves. DMAs are discrete zones used for water balance analysis and Non-Revenue Water (NRW) management. Ref: OSIsoft PI Historian.',
    `storage_dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that this storage tank serves. DMAs are discrete zones used for water balance analysis and Non-Revenue Water (NRW) management. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Tank construction/coating contractors tracked for construction quality, warranty tracking, maintenance service contracts, and regulatory compliance. Essential for water storage infrastructure manageme. Ref: OSIsoft PI Historian.',
    `asset_criticality_rating` STRING COMMENT 'Risk-based criticality classification of the storage tank based on consequence of failure analysis considering population served, redundancy, and system impact: critical (single point of failure for large population), high (significant impact), medium (moderate impact), or low (minimal impact with redundancy available). Ref: OSIsoft PI Historian.. Valid values are `critical|high|medium|low`',
    `base_elevation_feet` DECIMAL(18,2) COMMENT 'Ground or foundation elevation (in feet above mean sea level or local datum) at the base of the storage tank structure. Used for hydraulic gradient calculations. Ref: OSIsoft PI Historian.',
    `capacity_gallons` DECIMAL(18,2) COMMENT 'Total storage capacity of the tank measured in gallons. Represents the maximum volume of potable water the tank can hold at overflow elevation. Ref: OSIsoft PI Historian.',
    `capacity_million_gallons` DECIMAL(18,2) COMMENT 'Total storage capacity expressed in million gallons (MG), the standard unit for water utility storage reporting and system adequacy analysis. Ref: OSIsoft PI Historian.',
    `coating_condition` STRING COMMENT 'Assessment of the current condition of the tanks protective coating system based on the most recent inspection: excellent (no defects), good (minor wear), fair (localized deterioration), poor (widespread deterioration), or failed (coating breakdown requiring immediate attention). Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|failed`',
    `emergency_storage_gallons` DECIMAL(18,2) COMMENT 'Volume of water (in gallons) reserved for emergency supply during system outages, treatment plant failures, or other contingencies. Separate from fire flow reserve and operational storage. Ref: OSIsoft PI Historian.',
    `fire_flow_reserve_gallons` DECIMAL(18,2) COMMENT 'Volume of water (in gallons) reserved in the storage tank to meet fire protection requirements and emergency fire flow demands as defined by local fire codes and insurance standards. Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier from the Esri ArcGIS system linking this storage tank record to its spatial representation in the GIS network model. Ref: OSIsoft PI Historian.',
    `hydraulic_model_node_code` STRING COMMENT 'Node identifier in the Innovyze InfoWater hydraulic model representing this storage tank. Used for network simulation, pressure analysis, and system optimization studies. Ref: OSIsoft PI Historian.',
    `inlet_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter (in inches) of the primary inlet pipe supplying water to the storage tank. Used for hydraulic modeling and flow capacity analysis. Ref: OSIsoft PI Historian.',
    `installation_date` DATE COMMENT 'Date when the storage tank was originally constructed and placed into service. Used for asset age calculation and depreciation schedules. Ref: OSIsoft PI Historian.',
    `last_cleaning_date` DATE COMMENT 'Date when the storage tank interior was last drained, cleaned, and disinfected. Regular cleaning is required to maintain water quality and prevent sediment accumulation. Ref: OSIsoft PI Historian.',
    `last_coating_date` DATE COMMENT 'Date when the interior or exterior protective coating was last applied or rehabilitated. Coating maintenance is critical for corrosion prevention and structural longevity. Ref: OSIsoft PI Historian.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent comprehensive inspection of the storage tank, including structural integrity, coating condition, and safety systems. Required for regulatory compliance and asset management. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the storage tank location. Used for GIS mapping, spatial analysis, and integration with Esri ArcGIS. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the storage tank location. Used for GIS mapping, spatial analysis, and integration with Esri ArcGIS. Ref: OSIsoft PI Historian.',
    `maximo_asset_number` STRING COMMENT 'Asset identifier from IBM Maximo Asset Management (CMMS) system linking this storage tank to its maintenance history, work orders, preventive maintenance schedules, and spare parts inventory.',
    `maximum_operating_level_feet` DECIMAL(18,2) COMMENT 'Highest water level (in feet) at which the tank should operate under normal conditions, typically set below overflow elevation to provide freeboard and prevent overflow events. Ref: OSIsoft PI Historian.',
    `minimum_operating_level_feet` DECIMAL(18,2) COMMENT 'Lowest water level (in feet) at which the tank should operate under normal conditions to maintain adequate system pressure and prevent pump cavitation or structural stress. Ref: OSIsoft PI Historian.',
    `mixing_system_installed` BOOLEAN COMMENT 'Indicates whether an active mixing system is installed in the storage tank to prevent water age stratification and maintain disinfectant residual throughout the tank volume. Ref: OSIsoft PI Historian.',
    `mixing_system_type` STRING COMMENT 'Type of mixing system installed: mechanical (motor-driven mixer), hydraulic (jet mixing using inlet flow), or none (no active mixing). Ref: OSIsoft PI Historian.. Valid values are `mechanical|hydraulic|none`',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each storage tank in the distribution domain.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required comprehensive inspection based on regulatory requirements, manufacturer recommendations, or utility inspection frequency policy. Ref: OSIsoft PI Historian.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special conditions, historical information, or other relevant details about the storage tank not captured in structured fields. Ref: OSIsoft PI Historian.',
    `operational_status` STRING COMMENT 'Current operational state of the storage tank in the distribution network: in-service (actively storing and supplying water), out-of-service (temporarily offline), standby (available but not actively used), under-maintenance (undergoing inspection or repair), or decommissioned (permanently retired). Ref: OSIsoft PI Historian.. Valid values are `in_service|out_of_service|standby|under_maintenance|decommissioned`',
    `outlet_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter (in inches) of the primary outlet pipe distributing water from the storage tank to the distribution network. Used for hydraulic modeling and flow capacity analysis. Ref: OSIsoft PI Historian.',
    `overflow_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation (in feet above mean sea level or local datum) at which the tank overflow pipe is located. Represents the absolute maximum water level before overflow discharge occurs. Ref: OSIsoft PI Historian.',
    `overflow_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter (in inches) of the overflow pipe that prevents tank overfilling by discharging excess water when the maximum level is reached. Ref: OSIsoft PI Historian.',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the storage tank: utility-owned (owned and operated by the water utility), leased (leased from another entity), shared (jointly owned with another utility or municipality), or third-party (owned by external entity with service agreement). Ref: OSIsoft PI Historian.. Valid values are `utility_owned|leased|shared|third_party`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage tank record was first created in the system. Used for data lineage and audit trail purposes. Ref: OSIsoft PI Historian.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage tank record was last modified. Used for data lineage, change tracking, and audit trail purposes. Ref: OSIsoft PI Historian.',
    `regulatory_inspection_status` STRING COMMENT 'Current compliance status with state drinking water program and EPA inspection requirements: compliant (meets all requirements), non-compliant (deficiencies identified), pending-review (inspection submitted awaiting approval), or not-applicable (exempt from inspection requirements). Ref: OSIsoft PI Historian.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `scada_flow_meter_tag` STRING COMMENT 'OSIsoft PI Historian tag name for the flow meter measuring inflow or outflow (GPM or MGD) from this storage tank. Used for demand analysis and water balance calculations.',
    `scada_level_sensor_tag` STRING COMMENT 'OSIsoft PI Historian tag name for the real-time water level sensor monitoring this storage tank. Used to retrieve current level, historical trends, and alarm conditions from the SCADA system.',
    `scada_pressure_sensor_tag` STRING COMMENT 'OSIsoft PI Historian tag name for the pressure sensor monitoring outlet pressure (PSI) from this storage tank. Used for hydraulic performance monitoring and pressure zone management.',
    `security_system_installed` BOOLEAN COMMENT 'Indicates whether physical security systems (fencing, locks, intrusion detection, surveillance cameras) are installed to protect the storage tank from unauthorized access and potential contamination threats. Ref: OSIsoft PI Historian.',
    `structural_condition` STRING COMMENT 'Overall structural integrity assessment of the storage tank based on the most recent inspection: excellent (no defects), good (minor issues), fair (moderate deterioration), poor (significant deterioration requiring repair), or critical (unsafe condition requiring immediate action). Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|critical`',
    `tank_material` STRING COMMENT 'Primary construction material of the storage tank structure: steel (welded or bolted), concrete (cast-in-place or precast), prestressed concrete, composite (steel and concrete), or fiberglass. Ref: OSIsoft PI Historian.. Valid values are `steel|concrete|prestressed_concrete|composite|fiberglass`',
    `tank_name` STRING COMMENT 'Common name or designation of the storage tank, often referencing geographic location or service area (e.g., Hillside Elevated Tank, Downtown Reservoir). Ref: OSIsoft PI Historian.',
    `tank_number` STRING COMMENT 'Business identifier or asset tag assigned to the storage tank for operational reference and field identification. Ref: OSIsoft PI Historian.',
    `tank_type` STRING COMMENT 'Classification of storage tank by structural configuration: elevated (water tower), ground-level (surface reservoir), standpipe (tall cylindrical), reservoir (large capacity ground storage), clearwell (treated water storage at WTP), or hydropneumatic (pressure tank). Ref: OSIsoft PI Historian.. Valid values are `elevated|ground_level|standpipe|reservoir|clearwell|hydropneumatic`',
    `usable_capacity_gallons` DECIMAL(18,2) COMMENT 'Effective storage capacity available for distribution operations, calculated as the volume between minimum operating level and overflow elevation. Excludes dead storage below minimum operating level. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_storage_tank PRIMARY KEY(`storage_tank_id`)
) COMMENT 'Elevated tanks, ground storage reservoirs, and standpipes providing system storage, pressure maintenance, and emergency supply. Tracks capacity, operating levels, overflow elevation, mixing systems, coating condition, inspection history, and SCADA level/pressure monitoring. Regular inspection and cleaning per AWWA D100-D115 standards prevent water quality degradation and ensure structural integrity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` (
    `flow_reading_id` BIGINT COMMENT 'Unique identifier for the flow measurement record. Primary key for the flow reading transaction. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) associated with this flow measurement. Used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Ref: OSIsoft PI Historian.',
    `point_id` BIGINT COMMENT 'Reference to the physical location or asset where the flow measurement was captured (DMA inlet/outlet meter, pump station discharge meter, PRV station meter, or bulk transfer point). Ref: OSIsoft PI Historian.',
    `metering_meter_id` BIGINT COMMENT 'Reference to the specific flow meter device that captured this reading. Links to asset registry for meter calibration history and maintenance records. Ref: OSIsoft PI Historian.',
    `alarm_flag` BOOLEAN COMMENT 'Indicates whether this flow reading triggered an alarm condition in the SCADA system (e.g., flow exceeds threshold, negative flow, meter communication failure). Ref: OSIsoft PI Historian.',
    `alarm_type` STRING COMMENT 'Classification of the alarm condition if alarm_flag is true. [ENUM-REF-CANDIDATE: high_flow|low_flow|no_flow|reverse_flow|communication_failure|meter_fault|pressure_deviation|temperature_anomaly|data_gap|validation_failure — promote to reference product]. Ref: OSIsoft PI Historian.. Valid values are `high_flow|low_flow|no_flow|reverse_flow|communication_failure|meter_fault`',
    `billing_flag` BOOLEAN COMMENT 'Indicates whether this flow reading is used for bulk water billing or wholesale customer invoicing (e.g., inter-utility transfers, industrial bulk customers). Ref: OSIsoft PI Historian.',
    `calibration_date` DATE COMMENT 'Date of the most recent meter calibration prior to this reading. Used to assess measurement reliability and schedule recalibration. Ref: OSIsoft PI Historian.',
    `comments` STRING COMMENT 'Free-text field for operator notes, validation comments, or explanations of anomalies in the flow reading. Used for audit trail and troubleshooting. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'Quality indicator for the flow reading. Good = validated measurement, Suspect = questionable but not rejected, Bad = failed validation, Estimated = calculated/interpolated value, Manual = operator-entered reading. Ref: OSIsoft PI Historian.',
    `engineering_unit` STRING COMMENT 'Unit of measure for the flow reading. GPM = Gallons per Minute, MGD = Million Gallons per Day, CFS = Cubic Feet per Second, LPS = Liters per Second, M3H = Cubic Meters per Hour, M3D = Cubic Meters per Day. Ref: OSIsoft PI Historian.. Valid values are `GPM|MGD|CFS|LPS|M3H|M3D`',
    `estimated_flag` BOOLEAN COMMENT 'Indicates whether the flow value is an estimated or interpolated value rather than a direct meter reading. True when meter communication fails or reading is missing. Ref: OSIsoft PI Historian.',
    `estimation_method` STRING COMMENT 'Method used to estimate the flow value when direct measurement is unavailable. None indicates a direct measured value. Ref: OSIsoft PI Historian.. Valid values are `linear_interpolation|historical_average|pattern_based|manual_estimate|none`',
    `flow_direction` STRING COMMENT 'Direction of water flow at the measurement point. Inflow = water entering the zone/DMA, Outflow = water leaving the zone/DMA, Bidirectional = flow can reverse direction. Ref: OSIsoft PI Historian.. Valid values are `inflow|outflow|bidirectional`',
    `flow_value` DECIMAL(18,2) COMMENT 'The raw flow measurement value as captured by the meter. Represents instantaneous flow rate or cumulative volume depending on measurement type. Used with engineering_unit to interpret the measurement. Ref: OSIsoft PI Historian.',
    `hydraulic_model_flag` BOOLEAN COMMENT 'Indicates whether this flow reading is used for hydraulic model calibration in Innovyze InfoWater or similar distribution network modeling software. Ref: OSIsoft PI Historian.',
    `interval_duration_minutes` STRING COMMENT 'Time interval in minutes over which the flow measurement was aggregated or averaged. Common values: 15, 30, 60 minutes for SCADA polling intervals. Ref: OSIsoft PI Historian.',
    `measurement_type` STRING COMMENT 'Classification of the flow measurement: instantaneous (real-time snapshot), cumulative (totalizer reading), average (calculated over interval), peak (maximum in interval), or minimum (lowest in interval). Ref: OSIsoft PI Historian.. Valid values are `instantaneous|cumulative|average|peak|minimum`',
    `meter_accuracy_percent` DECIMAL(18,2) COMMENT 'The rated accuracy of the flow meter at the time of this reading, expressed as a percentage. Used to calculate measurement uncertainty for water balance calculations. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each flow reading in the distribution domain.',
    `nrw_calculation_flag` BOOLEAN COMMENT 'Indicates whether this flow reading is included in Non-Revenue Water (NRW) or Unaccounted-for Water (UFW) balance calculations for the associated DMA. Ref: OSIsoft PI Historian.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Water pressure measurement in PSI at the flow measurement point, captured concurrently with the flow reading. Used for hydraulic model calibration and pressure zone analysis. Ref: OSIsoft PI Historian.',
    `reading_timestamp` TIMESTAMP COMMENT 'The precise date and time when the flow measurement was captured by the meter or SCADA system. This is the business event timestamp representing the actual measurement occurrence. Ref: OSIsoft PI Historian.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this flow reading record was first inserted into the data system. Used for data lineage and audit trail. Ref: OSIsoft PI Historian.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this flow reading record was last modified. Used for change tracking and audit trail. Ref: OSIsoft PI Historian.',
    `scada_tag_name` STRING COMMENT 'The SCADA system tag or point identifier that sourced this flow reading. Used for traceability back to the PI Historian or SCADA historian database. Ref: OSIsoft PI Historian.',
    `temperature_f` DECIMAL(18,2) COMMENT 'Water temperature in degrees Fahrenheit at the measurement point. Used for flow compensation calculations and water quality correlation analysis. Ref: OSIsoft PI Historian.',
    `totalizer_reading` DECIMAL(18,2) COMMENT 'Cumulative volume reading from the meter totalizer register. Used to calculate interval consumption by differencing consecutive readings. Typically in gallons or cubic meters. Ref: OSIsoft PI Historian.',
    `validated_by` STRING COMMENT 'User ID or system process name that performed the validation of this flow reading. Used for audit trail and accountability. Ref: OSIsoft PI Historian.',
    `validation_status` STRING COMMENT 'Current validation state of the flow reading. Pending = awaiting review, Validated = approved by operator or automated validation, Rejected = failed validation rules, Corrected = manually adjusted after validation. Ref: OSIsoft PI Historian.. Valid values are `pending|validated|rejected|corrected`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the flow reading was validated or reviewed by an operator or automated validation process. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_flow_reading PRIMARY KEY(`flow_reading_id`)
) COMMENT 'Time-series flow measurements from distribution system flow meters at DMA boundaries, pump stations, storage tanks, and critical network points. Captured from SCADA systems (OSIsoft PI, Wonderware, Ignition) at 15-minute or hourly intervals. Essential for water balance calculations, NRW analysis, hydraulic model calibration, and demand forecasting. Supports AWWA M36 water audit methodology.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` (
    `network_reading_id` BIGINT COMMENT 'Primary key for network_reading. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: network_reading captures telemetry measurements within the distribution network. Each reading is taken at a location within a specific DMA (District Metered Area). This FK establishes the DMA context. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Operator who recorded manual reading. Ref: OSIsoft PI Historian.',
    `installation_id` BIGINT COMMENT 'Flow meter installation that produced this reading. Ref: OSIsoft PI Historian.',
    `flow_reading_id` BIGINT COMMENT 'FK to distribution.flow_reading. Ref: OSIsoft PI Historian.',
    `location_id` BIGINT COMMENT 'Unique identifier for the location referenced by each network reading record in the distribution domain.',
    `network_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the network created by employee referenced by each network reading record in the distribution domain.',
    `network_node_id` BIGINT COMMENT 'FK to distribution.network_node. Ref: OSIsoft PI Historian.',
    `network_operator_employee_id` BIGINT COMMENT 'Unique identifier for the network operator employee referenced by each network reading record in the distribution domain.',
    `network_validated_by_employee_id` BIGINT COMMENT 'FK to workforce.employee. Ref: OSIsoft PI Historian.',
    `node_id` BIGINT COMMENT 'Hydraulic model node identifier associated with the reading location. Ref: OSIsoft PI Historian.',
    `online_instrument_id` BIGINT COMMENT 'FK to the online instrument that produced the reading. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Pipe main associated with this reading. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: network_reading captures pressure and flow telemetry. Each reading is taken within a specific pressure zone, which is critical for hydraulic model calibration and pressure management. This FK enables. Ref: OSIsoft PI Historian.',
    `pump_station_id` BIGINT COMMENT 'FK to pump station if reading is station-related. Ref: OSIsoft PI Historian.',
    `read_id` BIGINT COMMENT 'Unique identifier for the network_reading data product (auto-inserted pre-linking). Ref: OSIsoft PI Historian.',
    `scada_tag_id` BIGINT COMMENT 'Unique identifier for the scada tag referenced by each network reading record in the distribution domain.',
    `storage_tank_id` BIGINT COMMENT 'FK to storage tank if reading is tank-related. Ref: OSIsoft PI Historian.',
    `alarm_state` STRING COMMENT 'The alarm state value recorded for each network reading in the distribution domain.',
    `alarm_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the reading exceeded a configured alarm threshold. Ref: OSIsoft PI Historian.',
    `alarm_threshold_high` STRING COMMENT 'High alarm threshold value. Ref: OSIsoft PI Historian.',
    `alarm_threshold_low` STRING COMMENT 'Low alarm threshold value. Ref: OSIsoft PI Historian.',
    `alarm_triggered` BOOLEAN COMMENT 'Whether reading triggered an alarm condition. Ref: OSIsoft PI Historian.',
    `alarm_type` STRING COMMENT 'Type of alarm if triggered. Ref: OSIsoft PI Historian.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each network reading in the distribution domain.',
    `avg_value` DECIMAL(18,2) COMMENT 'Average value over the interval. Ref: OSIsoft PI Historian.',
    `calibration_offset` DECIMAL(18,2) COMMENT 'Calibration offset applied. Ref: OSIsoft PI Historian.',
    `network_reading_category` STRING COMMENT 'The network reading category value recorded for each network reading in the distribution domain.',
    `classification` STRING COMMENT 'The classification value recorded for each network reading in the distribution domain.',
    `network_reading_code` STRING COMMENT 'The network reading code value recorded for each network reading in the distribution domain.',
    `comments` STRING COMMENT 'The comments value recorded for each network reading in the distribution domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each network reading in the distribution domain.',
    `compression_applied` BOOLEAN COMMENT 'Whether data compression was applied to the reading. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'Whether reading passed quality validation. Ref: OSIsoft PI Historian.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each network reading in the distribution domain.',
    `network_reading_description` STRING COMMENT 'The network reading description value recorded for each network reading in the distribution domain.',
    `ecm_mvm_depth_reconciliation_note` STRING COMMENT 'ECM attribute depth reconciled to match or exceed MVM (prior ecm_depth=4, mvm_depth=7). ECM now carries the full backbone attribute set. Ref: OSIsoft PI Historian.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each network reading record in the distribution domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: OSIsoft PI Historian.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: OSIsoft PI Historian.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each network reading record in the distribution domain.',
    `engineering_unit` STRING COMMENT 'Unit of measurement (psi, gpm, mg/L, NTU, degC). Ref: OSIsoft PI Historian.',
    `estimation_method` STRING COMMENT 'Method used for estimation if applicable. Ref: OSIsoft PI Historian.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each network reading record in the distribution domain.',
    `flow_gpm` DECIMAL(18,2) COMMENT 'Flow reading in gallons per minute. Ref: OSIsoft PI Historian.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The flow rate gpm value recorded for each network reading in the distribution domain.',
    `high_alarm_limit` DOUBLE COMMENT 'Upper alarm threshold for the parameter. Ref: OSIsoft PI Historian.',
    `high_alarm_threshold` DOUBLE COMMENT 'High alarm threshold value for this parameter. Ref: OSIsoft PI Historian.',
    `high_limit` DECIMAL(18,2) COMMENT 'The high limit value recorded for each network reading in the distribution domain.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp record was ingested. Ref: OSIsoft PI Historian.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: OSIsoft PI Historian.',
    `is_alarm` BOOLEAN COMMENT 'Whether reading triggered an alarm condition. Ref: OSIsoft PI Historian.',
    `is_alarm_active` BOOLEAN COMMENT 'Flag indicating an alarm condition is active for this reading. Ref: OSIsoft PI Historian.',
    `is_anomaly` BOOLEAN COMMENT 'Indicates whether the reading was flagged as anomalous. Ref: OSIsoft PI Historian.',
    `is_estimated` BOOLEAN COMMENT 'Boolean flag indicating whether the is estimated condition applies to the network reading record.',
    `is_manual_entry` BOOLEAN COMMENT 'Boolean flag indicating whether the is manual entry condition applies to the network reading record.',
    `is_regulatory_exceedance` BOOLEAN COMMENT 'Whether the reading exceeds the regulatory limit. Ref: OSIsoft PI Historian.',
    `is_validated` BOOLEAN COMMENT 'Whether the reading has been validated. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude of reading location. Ref: OSIsoft PI Historian.',
    `location_description` STRING COMMENT 'Description of reading location. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude of reading location. Ref: OSIsoft PI Historian.',
    `low_alarm_limit` DOUBLE COMMENT 'Lower alarm threshold for the parameter. Ref: OSIsoft PI Historian.',
    `low_alarm_threshold` DOUBLE COMMENT 'Low alarm threshold value for this parameter. Ref: OSIsoft PI Historian.',
    `low_limit` DECIMAL(18,2) COMMENT 'The low limit value recorded for each network reading in the distribution domain.',
    `max_value` DECIMAL(18,2) COMMENT 'Maximum value over the interval. Ref: OSIsoft PI Historian.',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value of the reading. Ref: OSIsoft PI Historian.',
    `measurement_date` TIMESTAMP COMMENT 'Date of the measurement. Ref: OSIsoft PI Historian.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp of the measurement. Ref: OSIsoft PI Historian.',
    `min_value` DECIMAL(18,2) COMMENT 'Minimum value over the interval. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each network reading in the distribution domain.',
    `network_reading_name` STRING COMMENT 'The network reading name used to identify each network reading record in the distribution domain.',
    `network_reading_number` STRING COMMENT 'The network reading number value recorded for each network reading in the distribution domain.',
    `network_reading_type` STRING COMMENT 'The network reading type value recorded for each network reading in the distribution domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: OSIsoft PI Historian.',
    `operator_verified` BOOLEAN COMMENT 'The operator verified value recorded for each network reading in the distribution domain.',
    `parameter_code` STRING COMMENT 'Code identifying the measured parameter. Ref: OSIsoft PI Historian.',
    `parameter_name` STRING COMMENT 'Name of the parameter being measured. Ref: OSIsoft PI Historian.',
    `parameter_type` STRING COMMENT 'The parameter type value recorded for each network reading in the distribution domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each network reading in the distribution domain.',
    `pi_tag_name` STRING COMMENT 'OSIsoft PI Historian tag name for this reading',
    `pressure_psi` DECIMAL(18,2) COMMENT 'The pressure psi value recorded for each network reading in the distribution domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each network reading in the distribution domain.',
    `quality_code` STRING COMMENT 'Quality code: Good, Suspect, Bad, Estimated. Ref: OSIsoft PI Historian.',
    `quality_flag` BOOLEAN COMMENT 'Flag indicating data quality issues with this reading. Ref: OSIsoft PI Historian.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each network reading in the distribution domain.',
    `raw_value` DECIMAL(18,2) COMMENT 'Raw unprocessed value from the sensor or instrument. Ref: OSIsoft PI Historian.',
    `reading_date` TIMESTAMP COMMENT 'The reading date associated with each network reading record in the distribution domain.',
    `reading_method` STRING COMMENT 'AMI, SCADA, manual, portable logger. Ref: OSIsoft PI Historian.',
    `reading_number` STRING COMMENT 'Unique reading identifier. Ref: OSIsoft PI Historian.',
    `reading_source` STRING COMMENT 'SCADA, Manual, AMI, Telemetry. Ref: OSIsoft PI Historian.',
    `reading_status` STRING COMMENT 'The reading status value recorded for each network reading in the distribution domain.',
    `reading_timestamp` TIMESTAMP COMMENT 'Timestamp of the network reading. Ref: OSIsoft PI Historian.',
    `reading_type` STRING COMMENT 'Type of reading (pressure, flow, chlorine_residual, turbidity, temperature). Ref: OSIsoft PI Historian.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: OSIsoft PI Historian.',
    `record_status` STRING COMMENT 'The record status value recorded for each network reading in the distribution domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each network reading in the distribution domain.',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'Applicable regulatory limit for the measured parameter. Ref: OSIsoft PI Historian.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each network reading in the distribution domain.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether this reading is used for regulatory reporting. Ref: OSIsoft PI Historian.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each network reading record in the distribution domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each network reading in the distribution domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each network reading in the distribution domain.',
    `sample_interval_seconds` STRING COMMENT 'Sampling interval in seconds for time-series data. Ref: OSIsoft PI Historian.',
    `scada_tag` STRING COMMENT 'SCADA system tag identifier. Ref: OSIsoft PI Historian.',
    `sensor_code` BIGINT COMMENT 'Identifier of the sensor/instrument. Ref: OSIsoft PI Historian.',
    `sensor_location` STRING COMMENT 'Description of sensor location in network. Ref: OSIsoft PI Historian.',
    `sensor_location_description` STRING COMMENT 'Description of the sensor location in the network. Ref: OSIsoft PI Historian.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each network reading record in the distribution domain.',
    `network_reading_status` STRING COMMENT 'Lifecycle status of the record. Ref: OSIsoft PI Historian.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement. Ref: OSIsoft PI Historian.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each network reading record in the distribution domain.',
    `validated_timestamp` TIMESTAMP COMMENT 'Timestamp of validation. Ref: OSIsoft PI Historian.',
    `validation_status` STRING COMMENT 'Validation status (raw, validated, suspect, rejected). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_network_reading PRIMARY KEY(`network_reading_id`)
) COMMENT 'Time-series operational readings from distribution network sensors including pressure transducers, chlorine analyzers, turbidity monitors, and temperature sensors. Captured from SCADA/telemetry systems at configurable intervals. Supports real-time operational decisions, regulatory compliance monitoring, and early warning of water quality or hydraulic anomalies. Links to online instruments, SCADA tags, DMAs, and pressure zones.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` (
    `distribution_nrw_water_balance_id` BIGINT COMMENT 'Unique identifier for the water balance record. Primary key for the NRW water balance data product. Ref: OSIsoft PI Historian.',
    `metering_nrw_water_balance_id` BIGINT COMMENT 'Canonical reference to metering.metering_nrw_water_balance. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area for which this water balance is calculated. Links to the DMA master data in the distribution network domain. Ref: OSIsoft PI Historian.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: NRW water balance audits are submitted to regulators as part of water loss control programs, permit reporting requirements, and infrastructure efficiency mandates. Audits must link to regulatory submi. Ref: OSIsoft PI Historian.',
    `revenue_requirement_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_requirement. Business justification: NRW volumes directly impact revenue requirements and rate calculations for rate case revenue requirement calculations, water loss cost recovery, and regulatory reporting. Ref: OSIsoft PI Historian.',
    `apparent_losses_mg` DECIMAL(18,2) COMMENT 'Volume of water that is consumed but not measured or billed due to customer meter inaccuracies, data handling errors, and unauthorized consumption (theft), measured in million gallons. Ref: OSIsoft PI Historian.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this water balance audit. Supports accountability and regulatory compliance. Ref: OSIsoft PI Historian.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this water balance audit was formally approved by management or regulatory authority. Marks the transition to official reporting status. Ref: OSIsoft PI Historian.',
    `audit_methodology` STRING COMMENT 'Description of the methodology and tools used to conduct the water balance audit (e.g., AWWA Free Water Audit Software v6.0, IWA Water Balance, custom methodology).',
    `audit_period_end_date` DATE COMMENT 'The last day of the reporting period for this water balance calculation. Typically the last day of a month or year. Ref: OSIsoft PI Historian.',
    `audit_period_start_date` DATE COMMENT 'The first day of the reporting period for this water balance calculation. Typically the first day of a month or year. Ref: OSIsoft PI Historian.',
    `audit_period_type` STRING COMMENT 'The frequency or granularity of the water balance reporting period (monthly, quarterly, or annual). Ref: OSIsoft PI Historian.. Valid values are `monthly|quarterly|annual`',
    `audit_status` STRING COMMENT 'Current workflow status of the water balance audit record. Tracks the audit through draft, submission, validation, approval, and publication stages. Ref: OSIsoft PI Historian.. Valid values are `draft|submitted|validated|approved|published`',
    `auditor_name` STRING COMMENT 'Name of the person or team responsible for preparing and validating this water balance audit. Supports accountability and quality assurance. Ref: OSIsoft PI Historian.',
    `authorized_consumption_mg` DECIMAL(18,2) COMMENT 'Total volume of metered and unmetered water taken by registered customers, the water utility, and others who are implicitly or explicitly authorized to do so by the water utility, measured in million gallons. Ref: OSIsoft PI Historian.',
    `average_system_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure in the distribution system during the audit period, measured in pounds per square inch. Higher pressure increases leakage rates. Used in UARL calculation. Ref: OSIsoft PI Historian.',
    `billed_metered_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water that is metered and billed to customers during the audit period, measured in million gallons. This is the primary revenue-generating component. Ref: OSIsoft PI Historian.',
    `billed_unmetered_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water that is billed to customers but not metered (e.g., flat-rate customers), measured in million gallons. Estimated based on customer count and average usage. Ref: OSIsoft PI Historian.',
    `comments` STRING COMMENT 'Free-text field for auditor notes, data quality issues, assumptions made, or other contextual information relevant to the interpretation of this water balance record. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this water balance record was first created in the system. Part of audit trail for data lineage and compliance. Ref: OSIsoft PI Historian.',
    `current_annual_real_losses_mg` DECIMAL(18,2) COMMENT 'Annualized volume of real losses (physical leakage) in the distribution system, measured in million gallons per year. Used in the calculation of Infrastructure Leakage Index. Ref: OSIsoft PI Historian.',
    `customer_meter_inaccuracies_mg` DECIMAL(18,2) COMMENT 'Volume of water consumed but not registered by customer meters due to meter under-registration, measured in million gallons. Typically estimated based on meter age and testing data. Ref: OSIsoft PI Historian.',
    `data_grading` STRING COMMENT 'AWWA Water Audit Software data grading (1-10 scale) where 1-3 is poor, 4-6 is fair, 7-8 is good, and 9-10 is excellent. Reflects the overall quality and reliability of the audit data. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|10 — 10 candidates stripped; promote to reference product]',
    `data_handling_errors_mg` DECIMAL(18,2) COMMENT 'Volume of water lost due to billing system errors, data transfer errors, and accounting mistakes, measured in million gallons. Estimated based on billing system audits. Ref: OSIsoft PI Historian.',
    `data_validity_score` STRING COMMENT 'AWWA Water Audit Software data validity score (0-100) indicating the reliability and accuracy of the input data used in the water balance calculation. Higher scores indicate more reliable audits.',
    `infrastructure_leakage_index` DECIMAL(18,2) COMMENT 'Ratio of Current Annual Real Losses (CARL) to Unavoidable Annual Real Losses (UARL). Dimensionless indicator of how well the distribution system is managed relative to its physical characteristics. ILI < 2 is excellent, 2-4 is good, 4-8 is fair, > 8 is poor. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this water balance record was last updated. Supports change tracking and audit trail requirements. Ref: OSIsoft PI Historian.',
    `leakage_on_service_connections_mg` DECIMAL(18,2) COMMENT 'Volume of water lost through leaks on service connections from the main to the customer meter, measured in million gallons. Includes leaks on both utility-owned and customer-owned portions. Ref: OSIsoft PI Historian.',
    `leakage_on_storage_tanks_mg` DECIMAL(18,2) COMMENT 'Volume of water lost through leaks and overflows at storage tanks and reservoirs, measured in million gallons. Includes structural leaks and operational overflows. Ref: OSIsoft PI Historian.',
    `leakage_on_transmission_mains_mg` DECIMAL(18,2) COMMENT 'Volume of water lost through leaks and breaks on transmission and distribution mains, measured in million gallons. Includes both reported and unreported leaks. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each distribution nrw water balance in the distribution domain.',
    `nrw_percentage` DECIMAL(18,2) COMMENT 'Non-Revenue Water expressed as a percentage of system input volume. Calculated as (NRW Volume / System Input Volume) × 100. Industry benchmark for water loss performance. Ref: OSIsoft PI Historian.',
    `nrw_volume_mg` DECIMAL(18,2) COMMENT 'Total volume of water that does not generate revenue for the utility, calculated as system input volume minus billed authorized consumption, measured in million gallons. Key performance indicator for water loss management. Ref: OSIsoft PI Historian.',
    `real_losses_mg` DECIMAL(18,2) COMMENT 'Volume of water physically lost from the distribution system through leaks, breaks, and overflows on mains, service connections, and storage tanks, measured in million gallons. Ref: OSIsoft PI Historian.',
    `service_connection_count` STRING COMMENT 'Total number of active service connections in the system or DMA during the audit period. Used in UARL calculation and for normalizing leakage metrics. Ref: OSIsoft PI Historian.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: OSIsoft PI Historian.',
    `system_input_volume_mg` DECIMAL(18,2) COMMENT 'Total volume of water introduced into the distribution system during the audit period, measured in million gallons. Represents the sum of all water entering the system from treatment plants, wells, and purchased sources. Ref: OSIsoft PI Historian.',
    `total_main_length_miles` DECIMAL(18,2) COMMENT 'Total length of transmission and distribution mains in the system or DMA, measured in miles. Used in UARL calculation and for normalizing leakage metrics. Ref: OSIsoft PI Historian.',
    `ufw_percentage` DECIMAL(18,2) COMMENT 'Unaccounted-for Water expressed as a percentage of system input volume. Calculated as (UFW Volume / System Input Volume) × 100. Legacy metric still used in some jurisdictions. Ref: OSIsoft PI Historian.',
    `ufw_volume_mg` DECIMAL(18,2) COMMENT 'Legacy term for water losses, calculated as system input volume minus authorized consumption, measured in million gallons. Equivalent to water losses in modern AWWA methodology.',
    `unauthorized_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water consumed through illegal connections, meter tampering, or theft, measured in million gallons. Estimated based on field investigations and industry benchmarks. Ref: OSIsoft PI Historian.',
    `unavoidable_annual_real_losses_mg` DECIMAL(18,2) COMMENT 'Theoretical minimum achievable annual real losses for a well-maintained and well-managed system, calculated based on system characteristics (main length, service connections, pressure). Used as the denominator in ILI calculation. Ref: OSIsoft PI Historian.',
    `unbilled_authorized_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water used for authorized purposes but not billed, such as firefighting, main flushing, street cleaning, and utility operations, measured in million gallons. Ref: OSIsoft PI Historian.',
    `water_losses_mg` DECIMAL(18,2) COMMENT 'Total volume of water lost in the distribution system, calculated as system input volume minus authorized consumption, measured in million gallons. Comprises apparent losses and real losses. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_distribution_nrw_water_balance PRIMARY KEY(`distribution_nrw_water_balance_id`)
) COMMENT 'Non-Revenue Water (NRW) audits and water balance calculations per AWWA M36 methodology and IWA Water Loss Task Force standards. Tracks system input volume, authorized consumption, water losses (real and apparent), billed/unbilled consumption, and performance indicators including NRW%, Infrastructure Leakage Index (ILI), and unavoidable annual real losses (UARL). Conducted annually or quarterly for each DMA or system-wide. Critical for loss control programs, rate case justification, and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` (
    `leak_detection_survey_id` BIGINT COMMENT 'Unique identifier for the leak detection survey record. Primary key. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Leak surveys are performed as part of CIP project scoping (pre-construction baseline) or post-construction validation. Linking survey to project enables cost allocation, project outcome measurement, a. Ref: OSIsoft PI Historian.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Leak surveys identify infrastructure deficiencies requiring corrective action under consent decrees, enforcement orders, or water loss control programs. Survey findings must link to corrective action. Ref: OSIsoft PI Historian.',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: Leak survey findings inform asset condition grades, remaining useful life estimates, and repair/replace decisions. Direct linkage supports proactive asset management and CIP prioritization in water ut. Ref: OSIsoft PI Historian.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Leak detection costs are allocated across pressure zones/DMAs for cost recovery and rate design in cost-of-service studies, rate case cost allocation, and NRW program tracking. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Reference to the internal field crew or team that performed the leak detection survey. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) in which the surveyed pipe segment is located, used for Non-Revenue Water (NRW) analysis. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Reference to the external contractor or vendor that performed the leak detection survey, if outsourced. Ref: OSIsoft PI Historian.',
    `leak_vendor_id` BIGINT COMMENT 'Reference to the external contractor or vendor that performed the leak detection survey, if outsourced. Ref: OSIsoft PI Historian.',
    `leak_detection_event_id` BIGINT COMMENT 'Foreign key linking to metering.leak_detection_event. Business justification: Acoustic leak surveys investigate AMI-generated continuous flow alerts. Field crews need to reference which AMI leak event triggered the survey and update resolution status. Enables closed-loop leak m. Ref: OSIsoft PI Historian.',
    `nrw_program_id` BIGINT COMMENT 'Reference to the Non-Revenue Water (NRW) reduction program or initiative under which this survey was conducted. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the specific distribution main or service line segment that was surveyed for leaks. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which the surveyed pipe segment operates. Ref: OSIsoft PI Historian.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order or service request that initiated this leak detection survey activity. Ref: OSIsoft PI Historian.',
    `ambient_noise_level` STRING COMMENT 'Qualitative assessment of ambient noise levels during the survey, which can affect acoustic leak detection effectiveness. Ref: OSIsoft PI Historian.. Valid values are `low|moderate|high`',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or manager who reviewed and approved the survey results.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey results were officially approved by a supervisor or manager.',
    `completed_date` DATE COMMENT 'The date on which the leak detection survey was marked as completed and results were finalized. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection survey record was first created in the system. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the reliability and accuracy of the survey data collected, used for quality assurance and analytics filtering. Ref: OSIsoft PI Historian.',
    `equipment_used` STRING COMMENT 'Description or list of specific leak detection equipment and instruments used during the survey (e.g., model numbers, device names). Ref: OSIsoft PI Historian.',
    `estimated_leak_rate_gpm` DECIMAL(18,2) COMMENT 'Estimated total leak flow rate for all leaks detected during this survey, measured in Gallons Per Minute (GPM). Ref: OSIsoft PI Historian.',
    `leak_locations_gis` STRING COMMENT 'Geographic coordinates or GIS feature identifiers for each leak location detected during the survey, typically stored as comma-separated latitude/longitude pairs or GIS asset IDs. Ref: OSIsoft PI Historian.',
    `leaks_found_count` STRING COMMENT 'Total number of leaks identified during this survey. Ref: OSIsoft PI Historian.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection survey record was last updated or modified. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each leak detection survey in the distribution domain.',
    `repair_work_order_generated` BOOLEAN COMMENT 'Indicates whether a repair work order was automatically or manually generated as a result of leaks found during this survey. Ref: OSIsoft PI Historian.',
    `scheduled_date` DATE COMMENT 'The originally planned or scheduled date for this leak detection survey, which may differ from the actual survey date. Ref: OSIsoft PI Historian.',
    `survey_cost_currency` DECIMAL(18,2) COMMENT 'Currency code for the survey cost amount. Defaults to USD for U.S. water utilities. Ref: OSIsoft PI Historian.',
    `survey_date` DATE COMMENT 'The calendar date on which the leak detection survey was conducted in the field. Ref: OSIsoft PI Historian.',
    `survey_end_time` TIMESTAMP COMMENT 'Timestamp when the field crew completed the leak detection survey activity. Ref: OSIsoft PI Historian.',
    `survey_length_feet` DECIMAL(18,2) COMMENT 'Total linear length of pipe surveyed during this leak detection activity, measured in feet. Ref: OSIsoft PI Historian.',
    `survey_method` STRING COMMENT 'The technology or technique used to conduct the leak detection survey (e.g., acoustic correlator, listening stick, ground-penetrating radar, leak noise logger). Ref: OSIsoft PI Historian.. Valid values are `acoustic_correlator|listening_stick|ground_penetrating_radar|leak_noise_logger|tracer_gas|thermal_imaging`',
    `survey_notes` STRING COMMENT 'Free-text field for technician observations, special conditions, challenges encountered, or additional context about the survey. Ref: OSIsoft PI Historian.',
    `survey_number` STRING COMMENT 'Business-facing unique identifier or reference number assigned to this leak detection survey for tracking and reporting purposes. Ref: OSIsoft PI Historian.',
    `survey_outcome` STRING COMMENT 'Final outcome or result classification of the leak detection survey activity. Ref: OSIsoft PI Historian.. Valid values are `leaks_detected|no_leaks_found|inconclusive|equipment_failure|weather_delay`',
    `survey_priority` STRING COMMENT 'Priority level assigned to this leak detection survey based on factors such as DMA performance, customer complaints, or infrastructure criticality. Ref: OSIsoft PI Historian.. Valid values are `routine|high|critical|emergency`',
    `survey_start_time` TIMESTAMP COMMENT 'Timestamp when the field crew began the leak detection survey activity. Ref: OSIsoft PI Historian.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the leak detection survey activity. Ref: OSIsoft PI Historian.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold|failed`',
    `technician_name` STRING COMMENT 'Name of the lead technician or operator who conducted the leak detection survey. Ref: OSIsoft PI Historian.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the survey, which may impact detection accuracy (e.g., rain, wind, temperature). Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_leak_detection_survey PRIMARY KEY(`leak_detection_survey_id`)
) COMMENT 'Acoustic leak detection surveys conducted in DMAs or targeted zones using correlating loggers, ground microphones, or leak noise correlators. Tracks survey date, method, equipment, area covered, leaks found, estimated leak rates, and follow-up repair work orders. Supports proactive leak detection programs per AWWA M36 and reduces real losses. Links to DMAs, NRW programs, pipe mains, and work orders.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` (
    `main_break_id` BIGINT COMMENT 'Unique identifier for the distribution main break event. Primary key for the main break record. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Main breaks frequently trigger capital replacement projects. Tracking which CIP project was initiated by a break event is essential for asset management, root cause analysis, and justifying project pr. Ref: OSIsoft PI Historian.',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.public_notification. Business justification: Main breaks that compromise water quality trigger public notification requirements under Safe Drinking Water Act. Boil water advisories and service disruption notices must link to specific break event',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Emergency repair costs are allocated to cost centers/pressure zones for budgeting and rate recovery in O&M expense tracking, cost-of-service analysis, and budget variance reporting. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the break occurred. Used for NRW (Non-Revenue Water) and UFW (Unaccounted-for Water) analysis. Ref: OSIsoft PI Historian.',
    `encumbrance_id` BIGINT COMMENT 'Foreign key linking to finance.encumbrance. Business justification: Emergency repair purchase orders create encumbrances against maintenance budgets for budget control, expenditure tracking, and fiscal year-end reporting. Ref: OSIsoft PI Historian.',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Main breaks are asset failure events requiring root cause analysis, MTBF/MTTR tracking, failure mode classification, and reliability analysis. Links distribution failures to enterprise failure trackin. Ref: OSIsoft PI Historian.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Main breaks trigger mandatory bacteriological sampling for regulatory compliance before system restoration per SDWA requirements. Break records must reference associated samples to document compliance. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the distribution main pipe asset where the break occurred. Links to the distribution main asset registry. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone where the break occurred. Critical for hydraulic modeling and pressure management analysis. Ref: OSIsoft PI Historian.',
    `quality_public_notification_id` BIGINT COMMENT 'FK to public notification per VREQ-023. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or team that performed the repair work. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Break repairs require specific materials (pipe sections, fittings, clamps). Essential for emergency inventory management, material failure analysis, procurement planning, and break pattern analysis fo. Ref: OSIsoft PI Historian.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Main breaks trigger mandatory bacteriological resampling per Revised Total Coliform Rule (RTCR). Boil water advisories and repeat sampling directly tied to break events. Essential for tracking complia',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created in the CMMS (Computerized Maintenance Management System) for the repair activity. Links to IBM Maximo Asset Management work order.',
    `actual_restoration_at` TIMESTAMP COMMENT 'Actual service restoration timestamp. Ref: OSIsoft PI Historian.',
    `affected_customer_count` STRING COMMENT 'Number of customer accounts affected by the incident. Ref: OSIsoft PI Historian.',
    `affected_dmas` STRING COMMENT 'Comma-separated list of affected DMA IDs. Ref: OSIsoft PI Historian.',
    `affected_pressure_zones` STRING COMMENT 'Comma-separated list of affected pressure zone IDs. Ref: OSIsoft PI Historian.',
    `affected_zones` STRING COMMENT 'Comma-separated list of affected pressure zones per VREQ-023. Ref: OSIsoft PI Historian.',
    `boil_water_advisory_issued` BOOLEAN COMMENT 'Indicates whether a boil water advisory was issued to affected customers due to potential water quality compromise. True if advisory was issued, False otherwise.',
    `break_number` STRING COMMENT 'Business identifier for the main break event, typically formatted as MB-YYYYNNNNNN for external reference and reporting. Ref: OSIsoft PI Historian.. Valid values are `^MB-[0-9]{6,10}$`',
    `break_status` STRING COMMENT 'Current lifecycle status of the main break event: reported, dispatched, in progress, repaired, closed, or deferred. Ref: OSIsoft PI Historian.. Valid values are `reported|dispatched|in_progress|repaired|closed|deferred`',
    `break_timestamp` TIMESTAMP COMMENT 'Date and time when the main break was first detected or reported. Principal business event timestamp for the break occurrence. Ref: OSIsoft PI Historian.',
    `break_type` STRING COMMENT 'Classification of the main break failure mode: circumferential crack, longitudinal crack, blowout, joint failure, service line break, or corrosion pinhole. Ref: OSIsoft PI Historian.. Valid values are `circumferential|longitudinal|blowout|joint_failure|service_line_break|corrosion_pinhole`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the main break record was first created in the system. Audit trail timestamp for record creation. Ref: OSIsoft PI Historian.',
    `customers_affected_count` STRING COMMENT 'Number of customer accounts impacted by service disruption due to the main break. Ref: OSIsoft PI Historian.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when field crew was dispatched to the main break location. Ref: OSIsoft PI Historian.',
    `expected_restoration_at` DECIMAL(18,2) COMMENT 'Expected service restoration timestamp per VREQ-023. Ref: OSIsoft PI Historian.',
    `expected_restoration_timestamp` DECIMAL(18,2) COMMENT 'Expected service restoration timestamp. Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Reference to the GIS feature identifier in Esri ArcGIS for the main pipe segment where the break occurred. Ref: OSIsoft PI Historian.',
    `hydraulic_model_node_code` STRING COMMENT 'Reference to the node identifier in Innovyze InfoWater hydraulic model for network analysis and pressure simulation. Ref: OSIsoft PI Historian.',
    `installation_year` STRING COMMENT 'Year the pipe was originally installed in the distribution network. Ref: OSIsoft PI Historian.',
    `location_address` STRING COMMENT 'Street address or nearest intersection where the main break occurred. Organizational location data classified as confidential. Ref: OSIsoft PI Historian.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the main break location for GIS mapping and spatial analysis. Ref: OSIsoft PI Historian.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the main break location for GIS mapping and spatial analysis. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each main break in the distribution domain.',
    `notes` STRING COMMENT 'Free-text field for additional observations, special circumstances, or detailed notes about the main break event and repair. Ref: OSIsoft PI Historian.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure in the main at the time of break, measured in PSI (Pounds per Square Inch). Ref: OSIsoft PI Historian.',
    `pipe_age_years` STRING COMMENT 'Estimated age of the pipe at the time of break, calculated from installation date to break date, measured in years. Ref: OSIsoft PI Historian.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the failed pipe in inches. Ref: OSIsoft PI Historian.',
    `pipe_material` STRING COMMENT 'Material composition of the failed pipe: cast iron, ductile iron, PVC (polyvinyl chloride), HDPE (high-density polyethylene), steel, concrete, asbestos cement, or copper. [ENUM-REF-CANDIDATE: cast_iron|ductile_iron|pvc|hdpe|steel|concrete|asbestos_cement|copper — 8 candidates stripped; promote to reference product]. Ref: OSIsoft PI Historian.',
    `population_at_risk` STRING COMMENT 'Estimated population affected by incident per VREQ-023. Ref: OSIsoft PI Historian.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the main break based on severity, customer impact, and safety considerations: emergency, urgent, high, medium, or low. Ref: OSIsoft PI Historian.. Valid values are `emergency|urgent|high|medium|low`',
    `regulatory_report_required` BOOLEAN COMMENT 'Indicates whether the main break requires regulatory reporting to EPA, state primacy agency, or Public Utilities Commission. True if reporting is required, False otherwise. Ref: OSIsoft PI Historian.',
    `repair_complete_timestamp` TIMESTAMP COMMENT 'Date and time when repair work was completed and the main was returned to service. Ref: OSIsoft PI Historian.',
    `repair_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the repair activity from start to completion, measured in hours. Ref: OSIsoft PI Historian.',
    `repair_method` STRING COMMENT 'Method used to repair the main break: clamp, sleeve, pipe replacement, joint repair, valve replacement, or temporary bypass. Ref: OSIsoft PI Historian.. Valid values are `clamp|sleeve|pipe_replacement|joint_repair|valve_replacement|temporary_bypass`',
    `repair_start_timestamp` TIMESTAMP COMMENT 'Date and time when repair work commenced on the main break. Ref: OSIsoft PI Historian.',
    `reported_by` STRING COMMENT 'Source of the main break report: customer, field crew, SCADA alert, patrol, third party, or internal inspection. Ref: OSIsoft PI Historian.. Valid values are `customer|field_crew|scada_alert|patrol|third_party|internal_inspection`',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the main break was officially reported to the utility operations center or SCADA system. Ref: OSIsoft PI Historian.',
    `root_cause` STRING COMMENT 'Identified root cause of the main break: corrosion, age deterioration, soil movement, freeze-thaw cycle, pressure surge, third-party damage, manufacturing defect, or unknown. [ENUM-REF-CANDIDATE: corrosion|age_deterioration|soil_movement|freeze_thaw|pressure_surge|third_party_damage|manufacturing_defect|unknown — 8 candidates stripped; promote to reference product]. Ref: OSIsoft PI Historian.',
    `soil_condition` STRING COMMENT 'Soil condition at the break location: clay, sand, gravel, rock, mixed, corrosive, saturated, or unknown. Influences corrosion rates and pipe stability. [ENUM-REF-CANDIDATE: clay|sand|gravel|rock|mixed|corrosive|saturated|unknown — 8 candidates stripped; promote to reference product]. Ref: OSIsoft PI Historian.',
    `traffic_impact` STRING COMMENT 'Impact of the main break on traffic and road access: none, lane closure, road closure, detour required, or emergency access restricted. Ref: OSIsoft PI Historian.. Valid values are `none|lane_closure|road_closure|detour_required|emergency_access_restricted`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the main break record was last modified. Audit trail timestamp for record updates. Ref: OSIsoft PI Historian.',
    `water_lost_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost during the break event, measured in gallons. Critical for NRW (Non-Revenue Water) and UFW (Unaccounted-for Water) reporting. Ref: OSIsoft PI Historian.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of the break: normal, freezing, extreme cold, heavy rain, drought, snow, or extreme heat. Relevant for freeze-thaw and soil movement analysis. [ENUM-REF-CANDIDATE: normal|freezing|extreme_cold|heavy_rain|drought|snow|extreme_heat — 7 candidates stripped; promote to reference product]. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_main_break PRIMARY KEY(`main_break_id`)
) COMMENT 'Distribution main break incidents including pipe failures, joint separations, and fitting failures. Tracks break location, timestamp, pipe characteristics, break type, root cause, repair method, duration, customers affected, water lost, and boil water advisory issuance. Critical for asset failure analysis, capital planning, and regulatory reporting. Links to pipe mains, work orders, crews, public notifications, and water quality samples. Enhanced with customer-impact fields (population_at_risk, affected_zones, expected_restoration_at, public_notification_id) per VREQ-023.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` (
    `valve_exercise_id` BIGINT COMMENT 'Unique identifier for the valve exercise transaction record. Ref: OSIsoft PI Historian.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Preventive maintenance costs are allocated across service areas for cost recovery in maintenance cost tracking, rate case O&M justification, and budget planning. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or team assigned to the valve exercise work order. Ref: OSIsoft PI Historian.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Valve exercising is a regulatory inspection activity (AWWA M44) with pass/fail outcomes, deficiency tracking, and compliance reporting. Natural mapping to enterprise inspection framework for audit tra',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Valve maintenance may identify parts needs (operating nuts, stems, seals). Links exercise program findings to preventive maintenance parts inventory and valve rebuild material tracking for maintenance. Ref: OSIsoft PI Historian.',
    `network_valve_id` BIGINT COMMENT 'Reference to the distribution network valve asset that was exercised. Ref: OSIsoft PI Historian.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent preventive maintenance work order under which this valve exercise was performed. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Reference to the field technician or crew member who performed the valve exercise. Ref: OSIsoft PI Historian.',
    `valve_technician_employee_id` BIGINT COMMENT 'Reference to the field technician or crew member who performed the valve exercise. Ref: OSIsoft PI Historian.',
    `condition_assessment` STRING COMMENT 'Overall condition assessment result from the valve exercise: pass indicates normal operation, fail or needs repair indicates deficiency requiring follow-up. Ref: OSIsoft PI Historian.. Valid values are `pass|fail|needs_repair|needs_replacement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve exercise record was first created in the system. Ref: OSIsoft PI Historian.',
    `deficiency_code` STRING COMMENT 'Standardized deficiency or failure code from the CMMS failure classification taxonomy. Ref: OSIsoft PI Historian.',
    `deficiency_description` STRING COMMENT 'Detailed narrative description of any deficiencies, damage, leaks, or operational issues observed during the valve exercise. Ref: OSIsoft PI Historian.',
    `deficiency_noted` BOOLEAN COMMENT 'Boolean flag indicating whether any deficiency, damage, or maintenance need was identified during the valve exercise. Ref: OSIsoft PI Historian.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area in which the valve is located, used for NRW and UFW analysis. Ref: OSIsoft PI Historian.',
    `duration_minutes` STRING COMMENT 'Total time in minutes required to complete the valve exercise activity, used for labor planning and efficiency analysis. Ref: OSIsoft PI Historian.',
    `exercise_date` DATE COMMENT 'The calendar date on which the valve exercise activity was performed. Ref: OSIsoft PI Historian.',
    `exercise_direction` STRING COMMENT 'Direction of valve operation during the exercise activity: opened, closed, or full open-close cycle. Ref: OSIsoft PI Historian.. Valid values are `open|close|open_close_cycle`',
    `exercise_method` STRING COMMENT 'Method used to exercise the valve: manual wrench, powered actuator, or hydraulic tool. Ref: OSIsoft PI Historian.. Valid values are `manual|powered|hydraulic`',
    `exercise_status` STRING COMMENT 'Current status of the valve exercise activity in the maintenance workflow. Ref: OSIsoft PI Historian.. Valid values are `completed|incomplete|deferred|cancelled`',
    `exercise_timestamp` TIMESTAMP COMMENT 'The precise date and time when the valve exercise activity was completed, recorded from field device or CMMS. Ref: OSIsoft PI Historian.',
    `final_position` STRING COMMENT 'Confirmed position of the valve at the completion of the exercise activity. Ref: OSIsoft PI Historian.. Valid values are `open|closed|partially_open`',
    `final_position_percent` DECIMAL(18,2) COMMENT 'Percentage of valve opening at completion of exercise, where 0% is fully closed and 100% is fully open. Ref: OSIsoft PI Historian.',
    `follow_up_required` BOOLEAN COMMENT 'Boolean flag indicating whether follow-up maintenance or repair work order is required based on exercise findings. Ref: OSIsoft PI Historian.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the valve location in decimal degrees, captured from GIS or field GPS device. Ref: OSIsoft PI Historian.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the valve location in decimal degrees, captured from GIS or field GPS device. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve exercise record was last updated or modified in the system. Ref: OSIsoft PI Historian.',
    `leak_detected` BOOLEAN COMMENT 'Boolean flag indicating whether a water leak was detected at the valve during exercise. Ref: OSIsoft PI Historian.',
    `leak_severity` STRING COMMENT 'Severity classification of any detected leak: none, minor seepage, moderate leak, or severe leak requiring immediate repair. Ref: OSIsoft PI Historian.. Valid values are `none|minor|moderate|severe`',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each valve exercise in the distribution domain.',
    `notes` STRING COMMENT 'Free-form text field for additional observations, comments, or context related to the valve exercise activity. Ref: OSIsoft PI Historian.',
    `operability_status` STRING COMMENT 'Functional operability status of the valve following exercise: operable, inoperable, or restricted operation. Ref: OSIsoft PI Historian.. Valid values are `operable|inoperable|restricted`',
    `operating_nut_condition` STRING COMMENT 'Condition of the valve operating nut or stem: good, worn, damaged, or missing. Ref: OSIsoft PI Historian.. Valid values are `good|worn|damaged|missing`',
    `pressure_zone_code` STRING COMMENT 'Code identifying the hydraulic pressure zone in which the valve is located, used for network modeling and operational planning. Ref: OSIsoft PI Historian.',
    `technician_name` STRING COMMENT 'Full name of the field technician who performed the valve exercise, captured for audit and accountability. Ref: OSIsoft PI Historian.',
    `torque_reading` DECIMAL(18,2) COMMENT 'Measured torque in foot-pounds required to operate the valve, used to assess mechanical condition and operability. Ref: OSIsoft PI Historian.',
    `torque_unit` STRING COMMENT 'Unit of measure for the torque reading: foot-pounds or newton-meters. Ref: OSIsoft PI Historian.. Valid values are `ft_lbs|nm`',
    `turns_to_close` STRING COMMENT 'Number of complete rotations required to fully close the valve from its open position, recorded during exercise. Ref: OSIsoft PI Historian.',
    `valve_box_condition` STRING COMMENT 'Condition assessment of the valve box or vault structure: good, fair, poor, or missing. Ref: OSIsoft PI Historian.. Valid values are `good|fair|poor|missing`',
    `valve_box_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth in inches from ground surface to the valve operating nut, recorded during exercise for access planning. Ref: OSIsoft PI Historian.',
    `valve_number` STRING COMMENT 'Business identifier for the valve asset, typically displayed on field maps and work orders. Ref: OSIsoft PI Historian.',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of valve exercise, recorded for context on field work conditions. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_valve_exercise PRIMARY KEY(`valve_exercise_id`)
) COMMENT 'Valve exercising activities (opening/closing cycles) performed on distribution network valves to maintain operability. Tracks exercise date, method, technician, valve condition, operability status, turns to close, deficiencies noted, and follow-up actions. Regular exercising per AWWA M44 prevents valve seizure and ensures emergency isolation capability. Links to network valves, crews, work orders, and inspection events.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` (
    `hydrant_flow_test_id` BIGINT COMMENT 'Unique identifier for the hydrant flow test record. Primary key. Ref: OSIsoft PI Historian.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Testing program costs are allocated to distribution cost centers for rate recovery in O&M expense allocation and regulatory compliance cost tracking. Ref: OSIsoft PI Historian.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Flow testing is a regulatory inspection (NFPA 291, ISO rating) with documented outcomes, deficiency tracking, and compliance reporting. Links distribution testing to enterprise inspection management f',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Testing may reveal need for hydrant parts/replacement (nozzles, caps, valves). Links testing program to maintenance parts procurement and hydrant replacement planning for fire protection system reliab. Ref: OSIsoft PI Historian.',
    `hydrant_id` BIGINT COMMENT 'Reference to the fire hydrant asset that was tested. Links to the hydrant asset registry for location, installation date, and maintenance history. Ref: OSIsoft PI Historian.',
    `tertiary_residual_hydrant_id` BIGINT COMMENT 'Reference to the hydrant asset used as the residual hydrant (where pressure is monitored). Typically the hydrant being tested or a nearby hydrant on the same main. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or work order team that performed the flow test. Used for quality assurance and crew productivity tracking. Ref: OSIsoft PI Historian.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which the flow test was performed. Links the test to maintenance scheduling, crew assignment, and cost tracking systems. Ref: OSIsoft PI Historian.',
    `available_flow_at_20psi_gpm` DECIMAL(18,2) COMMENT 'Calculated available fire flow at 20 PSI residual pressure in gallons per minute, derived using the NFPA 291 formula. This is the key metric for fire suppression adequacy and ISO rating.',
    `calibration_date` DATE COMMENT 'Date when the test equipment (pitot gauge, pressure gauges) was last calibrated. Ensures measurement accuracy and regulatory compliance. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the flow test record was first created in the system. Used for audit trail and data lineage tracking. Ref: OSIsoft PI Historian.',
    `dma_code` STRING COMMENT 'Identifier for the district metered area containing the tested hydrant. Used for NRW analysis and network performance monitoring. Ref: OSIsoft PI Historian.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Measured flow rate during the test in gallons per minute, calculated from pitot pressure and outlet diameter. Represents the actual flow delivered during the test. Ref: OSIsoft PI Historian.',
    `flushing_duration_minutes` STRING COMMENT 'Duration in minutes that the hydrant was flushed before or during the test to clear sediment and ensure representative flow measurements. Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique identifier for the hydrant in the GIS system. Used to link flow test results to spatial analysis, network modeling, and map visualization. Ref: OSIsoft PI Historian.',
    `hydrant_condition_observed` STRING COMMENT 'Field technician notes on the physical condition of the hydrant during testing, including leaks, corrosion, operability issues, or damage. Used to trigger maintenance work orders. Ref: OSIsoft PI Historian.',
    `hydraulic_model_updated` BOOLEAN COMMENT 'Flag indicating whether the flow test results have been incorporated into the hydraulic model (e.g., Innovyze InfoWater) for calibration. True if updated, false if pending. Ref: OSIsoft PI Historian.',
    `iso_fire_flow_adequacy` STRING COMMENT 'Assessment of whether the tested flow meets ISO Public Protection Classification requirements for the area. Adequate flow supports better ISO ratings and lower insurance premiums.. Valid values are `adequate|marginal|deficient`',
    `iso_rating_submitted` BOOLEAN COMMENT 'Flag indicating whether this flow test result has been submitted to ISO as part of the Public Protection Classification rating process. True if submitted, false if not.',
    `iso_submission_date` DATE COMMENT 'Date when the flow test data was submitted to ISO for fire suppression rating purposes. Used for compliance tracking and rating cycle management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the flow test record was last updated. Used for audit trail, change tracking, and data quality monitoring. Ref: OSIsoft PI Historian.',
    `model_update_date` DATE COMMENT 'Date when the flow test data was incorporated into the hydraulic model. Used to track model calibration currency and data lineage. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each hydrant flow test in the distribution domain.',
    `nfpa_color_classification` STRING COMMENT 'NFPA 291 color code classification based on available fire flow: Class AA (blue) >= 1500 GPM, Class A (green) 1000-1499 GPM, Class B (orange) 500-999 GPM, Class C (red) < 500 GPM, Inadequate for areas with insufficient flow. Ref: OSIsoft PI Historian.. Valid values are `class_aa_blue|class_a_green|class_b_orange|class_c_red|inadequate`',
    `notes` STRING COMMENT 'Free-text field for additional observations, anomalies, or context recorded by the field technician during the flow test. May include traffic conditions, customer interactions, or equipment issues. Ref: OSIsoft PI Historian.',
    `number_of_outlets_flowed` STRING COMMENT 'Count of hydrant outlets opened during the test. Multiple outlets may be flowed simultaneously to achieve higher flow rates for testing. Ref: OSIsoft PI Historian.',
    `outlet_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the hydrant outlet used for the flow test, measured in inches. Typically 2.5 inches for standard outlets. Required for accurate flow calculation from pitot pressure. Ref: OSIsoft PI Historian.',
    `pitot_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure reading from the pitot gauge placed in the discharge stream of the flow hydrant, used to calculate flow rate in gallons per minute. Ref: OSIsoft PI Historian.',
    `pressure_zone_code` STRING COMMENT 'Identifier for the pressure zone in which the tested hydrant is located. Used to correlate test results with hydraulic model zones and SCADA pressure monitoring. Ref: OSIsoft PI Historian.',
    `residual_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure measured at the residual hydrant while flow hydrants are open, recorded in pounds per square inch. Used to calculate available fire flow at 20 PSI residual per NFPA 291. Ref: OSIsoft PI Historian.',
    `static_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure measured at the residual hydrant before any flow is initiated, recorded in pounds per square inch. Baseline pressure used to calculate available fire flow. Ref: OSIsoft PI Historian.',
    `technician_name` STRING COMMENT 'Name of the lead technician who conducted the test. Captured for certification tracking and quality control purposes. Ref: OSIsoft PI Historian.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient air temperature during the test in degrees Fahrenheit. Extreme temperatures may affect equipment accuracy and water viscosity. Ref: OSIsoft PI Historian.',
    `test_date` DATE COMMENT 'Date when the hydrant flow test was conducted. Used for compliance tracking, ISO rating cycles, and hydraulic model calibration schedules.',
    `test_method` STRING COMMENT 'Method used to measure flow during the test. Pitot gauge is the standard NFPA 291 method; flow meters and pressure differential methods are alternatives. Ref: OSIsoft PI Historian.. Valid values are `pitot_gauge|flow_meter|pressure_differential`',
    `test_number` STRING COMMENT 'Business identifier for the flow test, typically formatted as a sequential or location-based test reference number used for external reporting and field crew coordination. Ref: OSIsoft PI Historian.',
    `test_status` STRING COMMENT 'Current lifecycle status of the flow test. Tracks progression from scheduling through completion or cancellation. Ref: OSIsoft PI Historian.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `test_time` TIMESTAMP COMMENT 'Time of day when the test was performed, recorded in HH:MM format. Important for correlating with demand patterns and SCADA pressure data. Ref: OSIsoft PI Historian.',
    `test_type` STRING COMMENT 'Classification of the reason for conducting the flow test. Routine tests are scheduled, complaint tests respond to customer concerns, post-repair tests verify work, new installation tests commission assets, model calibration tests support hydraulic modeling, and ISO rating tests support fire insurance ratings.. Valid values are `routine|complaint|post_repair|new_installation|model_calibration|iso_rating`',
    `water_clarity` STRING COMMENT 'Visual assessment of water clarity during the flow test. Turbidity or discoloration may indicate main breaks, sediment accumulation, or water quality issues requiring investigation. Ref: OSIsoft PI Historian.. Valid values are `clear|slightly_turbid|turbid|discolored|sediment`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the test (e.g., clear, rain, snow, temperature). Recorded for quality control and to identify potential impacts on test accuracy. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_hydrant_flow_test PRIMARY KEY(`hydrant_flow_test_id`)
) COMMENT 'Fire hydrant flow tests measuring static pressure, residual pressure, pitot pressure, and flow rate per AWWA M17 and NFPA 291. Results determine available fire flow, NFPA color classification, and ISO fire suppression ratings. Data feeds hydraulic model calibration (InfoWater, WaterGEMS) and supports fire department pre-planning. Conducted annually or biennially on representative hydrants.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` (
    `flushing_event_id` BIGINT COMMENT 'Unique identifier for the flushing event record. Primary key. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Post-construction flushing and disinfection are commissioning activities tied to specific CIP projects. Required for regulatory acceptance, bacteriological clearance, asset turnover to operations, and. Ref: OSIsoft PI Historian.',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.public_notification. Business justification: Flushing events that affect water quality or discolor water may require public notification under state regulations. Customer advisories for planned flushing and water quality impacts must link to spe',
    `crew_id` BIGINT COMMENT 'Reference to the field operations crew that performed the flushing activity. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who served as the crew lead or supervisor for this flushing activity.',
    `customer_complaint_id` BIGINT COMMENT 'Reference to the originating customer service request or complaint that triggered this flushing event, if applicable. Ref: OSIsoft PI Historian.',
    `hydrant_id` BIGINT COMMENT 'Reference to the fire hydrant or blow-off valve used as the discharge point for the flushing activity. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the primary distribution main segment that was flushed, linked to the GIS network topology. Ref: OSIsoft PI Historian.',
    `turbidity_reading_id` BIGINT COMMENT 'Foreign key linking to quality.turbidity_reading. Business justification: Flushing events generate turbidity spikes monitored via online instruments or grab samples. Links distribution maintenance activity to water quality response. Enables tracking flushing effectiveness a. Ref: OSIsoft PI Historian.',
    `water_sample_id` BIGINT COMMENT 'Reference to the water quality sample record in the Laboratory Information Management System (LIMS) if a sample was collected. Ref: OSIsoft PI Historian.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order in the asset management system (CMMS) under which this flushing activity was scheduled and executed. Ref: OSIsoft PI Historian.',
    `city` STRING COMMENT 'City or municipality where the flushing activity occurred. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this flushing event record was first created in the database. Ref: OSIsoft PI Historian.',
    `discharge_point_type` STRING COMMENT 'The type of infrastructure asset used as the discharge point for flushed water. Ref: OSIsoft PI Historian.. Valid values are `fire_hydrant|blow_off_valve|air_release_valve|service_connection`',
    `dma_code` STRING COMMENT 'The District Metered Area code in which the flushing activity took place, used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Ref: OSIsoft PI Historian.. Valid values are `^DMA-[A-Z0-9]{3,6}$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time of the flushing activity in minutes, calculated from start to end timestamps or manually recorded by field crew. Ref: OSIsoft PI Historian.',
    `equipment_used` STRING COMMENT 'Comma-separated list or description of specialized equipment used during the flushing activity (e.g., flow meters, turbidity meters, diffusers, flushing trailers). Ref: OSIsoft PI Historian.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate during the flushing activity measured in Gallons Per Minute (GPM), used to assess flushing effectiveness and velocity. Ref: OSIsoft PI Historian.',
    `flush_date` DATE COMMENT 'The calendar date on which the flushing activity was performed or is scheduled to be performed. Ref: OSIsoft PI Historian.',
    `flush_effectiveness_rating` STRING COMMENT 'Qualitative assessment of the flushing effectiveness based on turbidity reduction, chlorine residual improvement, and visual water quality. Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|failed`',
    `flush_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the flushing activity was completed and the system was returned to normal operation. Ref: OSIsoft PI Historian.',
    `flush_number` STRING COMMENT 'Human-readable business identifier for the flushing event, typically formatted as FLU-YYYY-NNNNNN for tracking and reporting purposes. Ref: OSIsoft PI Historian.. Valid values are `^FLU-[0-9]{4}-[0-9]{6}$`',
    `flush_reason` STRING COMMENT 'The primary business driver or trigger for performing the flushing activity. Ref: OSIsoft PI Historian.. Valid values are `routine_maintenance|water_quality_complaint|discoloration_event|low_chlorine|biofilm_control|new_main_commissioning`',
    `flush_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the flushing activity commenced, captured from field crew mobile devices or SCADA systems. Ref: OSIsoft PI Historian.',
    `flush_status` STRING COMMENT 'Current lifecycle status of the flushing event in the operational workflow. Ref: OSIsoft PI Historian.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `flushing_method` STRING COMMENT 'The technique used to perform the flushing activity. Unidirectional Flushing (UDF) is the preferred method for sediment removal; conventional flushing is used for routine maintenance. Ref: OSIsoft PI Historian.. Valid values are `conventional|unidirectional|UDF|hydrant_blow_off|air_scouring|ice_pigging`',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional flushing or corrective action is required based on post-flush water quality results. Ref: OSIsoft PI Historian.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the primary flushing location in decimal degrees, captured from GIS or mobile field devices. Ref: OSIsoft PI Historian.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the primary flushing location in decimal degrees, captured from GIS or mobile field devices. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this flushing event record was last updated, used for audit trail and data synchronization. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each flushing event in the distribution domain.',
    `notes` STRING COMMENT 'Free-text field for crew observations, operational challenges, unusual conditions, or additional context not captured in structured fields. Ref: OSIsoft PI Historian.',
    `post_flush_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Free chlorine residual concentration measured after flushing, in milligrams per liter (mg/L). Confirms restoration of adequate disinfection levels. Ref: OSIsoft PI Historian.',
    `pre_flush_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Free chlorine residual concentration measured before flushing, in milligrams per liter (mg/L). Indicates disinfection adequacy and water age. Ref: OSIsoft PI Historian.',
    `pressure_zone_code` STRING COMMENT 'The pressure zone identifier where the flushing occurred, used for hydraulic modeling and pressure management. Ref: OSIsoft PI Historian.. Valid values are `^PZ-[A-Z0-9]{2,4}$`',
    `public_notification_sent` BOOLEAN COMMENT 'Indicates whether advance public notification was sent to affected customers regarding potential water discoloration or service disruption. Ref: OSIsoft PI Historian.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the flushing activity occurred. Ref: OSIsoft PI Historian.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the flushing activity took place, used for public communication and record-keeping. Ref: OSIsoft PI Historian.',
    `traffic_control_required` BOOLEAN COMMENT 'Indicates whether traffic control measures were required for safe execution of the flushing activity. Ref: OSIsoft PI Historian.',
    `volume_discharged_gallons` DECIMAL(18,2) COMMENT 'Total volume of water discharged during the flushing event, measured in gallons. Critical for water loss accounting and NRW analysis. Ref: OSIsoft PI Historian.',
    `water_quality_sample_collected` BOOLEAN COMMENT 'Indicates whether a formal water quality sample was collected during or after the flushing event for laboratory analysis. Ref: OSIsoft PI Historian.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the flushing activity, relevant for operational safety and scheduling. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_flushing_event PRIMARY KEY(`flushing_event_id`)
) COMMENT 'Unidirectional or conventional flushing events to remove sediment, improve water quality, and maintain chlorine residuals. Tracks flushing date, method, hydrant/location, duration, flow rate, volume discharged, pre/post chlorine residuals, water quality samples, and public notification. Supports routine flushing programs, complaint response, and main break follow-up per AWWA M17 and EPA RTCR.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` (
    `hydraulic_model_run_id` BIGINT COMMENT 'Unique identifier for the hydraulic model simulation run. Primary key. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Identifier linking this hydraulic model run to a specific capital project, infrastructure study, or operational initiative for which the simulation was performed. Ref: OSIsoft PI Historian.',
    `consumption_profile_id` BIGINT COMMENT 'Foreign key linking to metering.consumption_profile. Business justification: Hydraulic model calibration requires actual consumption data from billing periods to validate demand patterns and loading assumptions. Engineers reference specific consumption profiles to adjust model. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Hydraulic model runs are often scoped to specific District Metered Areas (DMAs) for calibration and analysis. The hydraulic_model_run table currently has dma_code as a STRING, which should be normaliz. Ref: OSIsoft PI Historian.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Modeling scenarios support CIP project budgeting and capital planning for capital budget justification, project feasibility analysis, and rate case capital planning. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Hydraulic model runs are often scoped to specific pressure zones for network analysis and scenario planning. The hydraulic_model_run table currently has pressure_zone_code as a STRING, which should be. Ref: OSIsoft PI Historian.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Hydraulic model results support permit applications, capacity demonstrations, and system adequacy reports submitted to regulators. Model runs demonstrating fire flow capacity, pressure compliance, and. Ref: OSIsoft PI Historian.',
    `analyst_name` STRING COMMENT 'Name of the engineer or analyst who executed and is responsible for this hydraulic model run, used for accountability and technical review. Ref: OSIsoft PI Historian.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Mean nodal pressure in pounds per square inch (PSI) across all nodes in the distribution network during the simulation, providing an overall system pressure indicator. Ref: OSIsoft PI Historian.',
    `boundary_conditions` STRING COMMENT 'Description of hydraulic boundary conditions applied to the model, including source pressures, tank levels, pump operating rules, and valve settings that define the system state for this simulation. Ref: OSIsoft PI Historian.',
    `calibration_status` STRING COMMENT 'Indicates the level of calibration and validation applied to the hydraulic model for this run: not calibrated (theoretical), preliminary (initial tuning), calibrated (field-verified), or validated (peer-reviewed and accepted). Ref: OSIsoft PI Historian.. Valid values are `not_calibrated|preliminary|calibrated|validated`',
    `convergence_achieved` BOOLEAN COMMENT 'Boolean indicator of whether the hydraulic solver achieved numerical convergence within tolerance limits, ensuring the simulation results are mathematically valid and stable. Ref: OSIsoft PI Historian.',
    `convergence_iterations` STRING COMMENT 'Number of solver iterations required to achieve hydraulic convergence, used to assess model complexity and computational efficiency. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hydraulic model run record was first created in the system, supporting audit trail and data lineage tracking. Ref: OSIsoft PI Historian.',
    `demand_multiplier` DECIMAL(18,2) COMMENT 'Scaling factor applied to baseline water demand values to simulate different loading conditions (e.g., 1.0 for average day, 1.5 for peak day, 2.5 for maximum day plus fire flow). Used for capacity planning and stress testing. Ref: OSIsoft PI Historian.',
    `fire_flow_available_gpm` DECIMAL(18,2) COMMENT 'Maximum fire flow capacity in gallons per minute (GPM) available at critical nodes while maintaining minimum residual pressure, used for fire protection adequacy assessment and Insurance Services Office (ISO) rating.',
    `gis_model_sync_date` DATE COMMENT 'Date when the hydraulic model network topology was last synchronized with the authoritative Esri ArcGIS geographic information system (GIS) database, ensuring spatial accuracy and asset alignment. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hydraulic model run record was last updated, supporting change tracking and data governance. Ref: OSIsoft PI Historian.',
    `maximum_pressure_psi` DECIMAL(18,2) COMMENT 'Highest nodal pressure in pounds per square inch (PSI) observed across the entire distribution network during the simulation, used to identify areas at risk of pipe bursts or excessive pressure. Ref: OSIsoft PI Historian.',
    `maximum_velocity_fps` DECIMAL(18,2) COMMENT 'Highest water velocity in feet per second (fps) observed in any pipe segment during the simulation, used to identify areas at risk of excessive head loss, water hammer, or pipe erosion. Ref: OSIsoft PI Historian.',
    `minimum_pressure_psi` DECIMAL(18,2) COMMENT 'Lowest nodal pressure in pounds per square inch (PSI) observed across the entire distribution network during the simulation, critical for identifying areas at risk of low pressure or negative pressure events. Ref: OSIsoft PI Historian.',
    `minimum_velocity_fps` DECIMAL(18,2) COMMENT 'Lowest water velocity in feet per second (fps) observed in any pipe segment during the simulation, used to identify areas with stagnant water or inadequate flushing velocity. Ref: OSIsoft PI Historian.',
    `model_version` STRING COMMENT 'Version identifier of the hydraulic model used for this simulation run, tracking model evolution and configuration changes over time. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each hydraulic model run in the distribution domain.',
    `notes` STRING COMMENT 'Free-text field for analyst comments, observations, assumptions, or special conditions related to this hydraulic model run, supporting documentation and knowledge transfer. Ref: OSIsoft PI Historian.',
    `output_file_path` STRING COMMENT 'File system path or cloud storage location where detailed simulation output files (node results, pipe results, time-series data) are stored for this hydraulic model run. Ref: OSIsoft PI Historian.',
    `pressure_violations_count` STRING COMMENT 'Number of nodes where pressure fell below the minimum regulatory threshold (typically 20 PSI under normal conditions or 30 PSI during fire flow) during the simulation, indicating potential compliance issues. Ref: OSIsoft PI Historian.',
    `pump_energy_kwh` DECIMAL(18,2) COMMENT 'Total electrical energy consumed by all pump stations in kilowatt-hours (kWh) during the simulation period, used for operational cost analysis and energy efficiency optimization. Ref: OSIsoft PI Historian.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the hydraulic model simulation run completed execution, whether successfully or with errors. Ref: OSIsoft PI Historian.',
    `run_number` STRING COMMENT 'Business-facing identifier or reference number for the hydraulic model run, used for tracking and reporting purposes. Ref: OSIsoft PI Historian.',
    `run_purpose` STRING COMMENT 'Business purpose or objective for executing this hydraulic model run, such as Capital Improvement Program (CIP) planning, regulatory compliance analysis, operational troubleshooting, or infrastructure design validation. Ref: OSIsoft PI Historian.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the hydraulic model simulation run was initiated by the analyst or automated scheduler. Ref: OSIsoft PI Historian.',
    `run_status` STRING COMMENT 'Current execution status of the hydraulic model run, indicating whether the simulation is pending, in progress, successfully completed with convergence, failed due to errors, or cancelled by the user. [ENUM-REF-CANDIDATE: queued|running|completed|failed|cancelled|converged|not_converged — 7 candidates stripped; promote to reference product]. Ref: OSIsoft PI Historian.',
    `scada_data_source` STRING COMMENT 'Identifier of the SCADA system or OSIsoft PI Historian data source used to calibrate or validate this hydraulic model run with real-time operational data.',
    `scenario_type` STRING COMMENT 'Type of hydraulic simulation scenario executed: steady-state for snapshot conditions, extended period simulation (EPS) for time-series analysis, fire flow for emergency capacity, water quality for contaminant tracking, emergency response for outage planning, or capacity planning for infrastructure investment analysis. Ref: OSIsoft PI Historian.. Valid values are `steady_state|extended_period_simulation|fire_flow|water_quality|emergency_response|capacity_planning`',
    `simulation_duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time in seconds for the hydraulic model simulation to execute, used for performance monitoring and optimization. Ref: OSIsoft PI Historian.',
    `simulation_end_time` TIMESTAMP COMMENT 'Simulated real-world end date and time for extended period simulation (EPS) scenarios, representing the conclusion of the modeled time window. Ref: OSIsoft PI Historian.',
    `simulation_start_time` TIMESTAMP COMMENT 'Simulated real-world start date and time for extended period simulation (EPS) scenarios, representing the beginning of the modeled time window. Ref: OSIsoft PI Historian.',
    `system_demand_mgd` DECIMAL(18,2) COMMENT 'Total water demand across the entire distribution system in million gallons per day (MGD) for the simulation scenario, representing aggregate customer consumption and system losses. Ref: OSIsoft PI Historian.',
    `tank_level_variation_feet` DECIMAL(18,2) COMMENT 'Maximum range of water level fluctuation in feet across all storage tanks during the simulation, indicating storage utilization and operational cycling. Ref: OSIsoft PI Historian.',
    `time_step_minutes` STRING COMMENT 'Temporal resolution in minutes for extended period simulation, defining the interval at which hydraulic conditions are calculated (e.g., 15, 30, or 60 minutes). Ref: OSIsoft PI Historian.',
    `total_head_loss_feet` DECIMAL(18,2) COMMENT 'Cumulative hydraulic head loss in feet across the distribution network from source to the most remote node, indicating overall system friction and energy dissipation. Ref: OSIsoft PI Historian.',
    `velocity_violations_count` STRING COMMENT 'Number of pipe segments where velocity exceeded recommended maximum thresholds (typically 5-8 fps) during the simulation, indicating potential water quality or infrastructure integrity concerns. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_hydraulic_model_run PRIMARY KEY(`hydraulic_model_run_id`)
) COMMENT 'Hydraulic model simulation runs (steady-state, extended period, fire flow, water quality) performed in InfoWater, WaterGEMS, EPANET, or similar platforms. Tracks scenario name, model version, simulation type, demand patterns, boundary conditions, results summary, and calibration metrics. Supports CIP planning, fire flow analysis, water age studies, and regulatory compliance. Links to CIP projects, pressure zones, and consumption profiles.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` (
    `network_isolation_event_id` BIGINT COMMENT 'Unique identifier for the network isolation event record.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Planned isolations for construction work must be linked to the driving CIP project for construction coordination, customer communication planning, project schedule tracking, and post-project water qua',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.public_notification. Business justification: Isolation events affecting large customer populations trigger public notification requirements for service disruptions. Regulatory requirements mandate advance notice for planned outages and emergency',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Planned outage costs (labor, water loss) are allocated to maintenance cost centers for O&M cost tracking and service reliability cost analysis. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Reference to the crew assigned to perform the isolation and restoration work.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) where the isolation event occurred.',
    `encumbrance_id` BIGINT COMMENT 'Foreign key linking to finance.encumbrance. Business justification: Planned work requiring contractor services creates budget encumbrances for budget control and contractor payment tracking. Ref: OSIsoft PI Historian.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Isolation events requiring system depressurization trigger mandatory bacteriological sampling before restoration per regulatory requirements. Event records must reference samples to document complianc',
    `vendor_id` BIGINT COMMENT 'Reference to the external contractor performing the work, if applicable. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Reference to the crew supervisor responsible for managing the isolation event.',
    `network_employee_id` BIGINT COMMENT 'Reference to the crew supervisor responsible for managing the isolation event.',
    `network_vendor_id` BIGINT COMMENT 'Reference to the external contractor performing the work, if applicable. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the primary pressure zone affected by this isolation event.',
    `quality_public_notification_id` BIGINT COMMENT 'Foreign key to the public notification record issued for this incident. Ref: OSIsoft PI Historian.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Isolation events require pre- and post-restoration water quality sampling to verify system integrity and bacteriological compliance before returning to service. Standard operating procedure for planne',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that triggered or documented this isolation event.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the network isolation was completed and service was restored.',
    `actual_restoration_at` TIMESTAMP COMMENT 'Actual service restoration timestamp. Ref: OSIsoft PI Historian.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the network isolation began.',
    `affected_customer_count` STRING COMMENT 'Number of customer accounts affected by the incident. Ref: OSIsoft PI Historian.',
    `affected_dmas` STRING COMMENT 'Comma-separated list of affected DMA IDs. Ref: OSIsoft PI Historian.',
    `affected_pressure_zones` STRING COMMENT 'Comma-separated list of affected pressure zone IDs. Ref: OSIsoft PI Historian.',
    `affected_zones` STRING COMMENT 'Comma-separated list of affected zones per VREQ-023. Ref: OSIsoft PI Historian.',
    `boil_water_advisory_issued` BOOLEAN COMMENT 'Indicates whether a boil water advisory was issued to affected customers due to the isolation event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this isolation event record was first created in the system.',
    `critical_customers_affected` BOOLEAN COMMENT 'Indicates whether critical customers (hospitals, fire stations, nursing homes) were affected by the isolation.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether advance notification was sent to affected customers before the isolation event.',
    `customers_affected_count` STRING COMMENT 'Total number of customer accounts impacted by the service interruption during this isolation event.',
    `estimated_water_loss_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost during the isolation event due to draining, flushing, or leakage.',
    `expected_restoration_at` DECIMAL(18,2) COMMENT 'Expected restoration timestamp per VREQ-023. Ref: OSIsoft PI Historian.',
    `expected_restoration_timestamp` DECIMAL(18,2) COMMENT 'Expected service restoration timestamp. Ref: OSIsoft PI Historian.',
    `flushing_performed` BOOLEAN COMMENT 'Indicates whether system flushing was performed after restoration to ensure water quality. Ref: OSIsoft PI Historian.',
    `gis_isolation_boundary` BOOLEAN COMMENT 'GIS polygon or geometry defining the geographic boundary of the isolated area.',
    `hydraulic_model_verified` BOOLEAN COMMENT 'Indicates whether the isolation plan was verified using hydraulic modeling software before execution.',
    `isolation_area_length_feet` DECIMAL(18,2) COMMENT 'Total length in feet of the distribution network isolated during this event.',
    `isolation_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the isolation event in hours from start to restoration.',
    `isolation_number` STRING COMMENT 'Business identifier for the isolation event, used for tracking and reporting.. Valid values are `^ISO-[0-9]{6,10}$`',
    `isolation_reason` STRING COMMENT 'Detailed explanation of why the network isolation was necessary, including specific work to be performed.',
    `isolation_status` STRING COMMENT 'Current lifecycle status of the isolation event from planning through restoration.. Valid values are `scheduled|in_progress|isolated|restoring|restored|cancelled`',
    `isolation_type` STRING COMMENT 'Classification of the isolation event based on the reason for network shutdown. [ENUM-REF-CANDIDATE: planned_maintenance|emergency_repair|main_break|construction|leak_repair|valve_replacement|hydrant_repair — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this isolation event record was last updated.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each network isolation event in the distribution domain.',
    `notes` STRING COMMENT 'Additional notes, observations, or special circumstances related to the isolation event.',
    `notification_datetime` TIMESTAMP COMMENT 'Date and time when customer notifications were sent for this isolation event.',
    `pipe_segments_isolated` STRING COMMENT 'Comma-separated list of pipe segment identifiers that were isolated during this event.',
    `population_at_risk` STRING COMMENT 'Estimated population affected by isolation per VREQ-023',
    `premises_affected_count` STRING COMMENT 'Total number of physical premises (addresses) impacted by the service interruption. Ref: OSIsoft PI Historian.',
    `pressure_impact_description` STRING COMMENT 'Description of how the isolation affected water pressure in adjacent zones or areas.',
    `priority` STRING COMMENT 'Priority level assigned to the isolation event based on urgency and impact.. Valid values are `emergency|urgent|high|medium|low`',
    `restoration_confirmed` BOOLEAN COMMENT 'Indicates whether full service restoration has been confirmed and all valves returned to normal operating position. Ref: OSIsoft PI Historian.',
    `restoration_confirmed_by` BIGINT COMMENT 'Reference to the employee who confirmed successful restoration of service. Ref: OSIsoft PI Historian.',
    `restoration_confirmed_datetime` TIMESTAMP COMMENT 'Date and time when service restoration was confirmed and documented. Ref: OSIsoft PI Historian.',
    `scada_monitoring_active` BOOLEAN COMMENT 'Indicates whether SCADA monitoring was active during the isolation event to track pressure and flow impacts.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the network isolation is scheduled to be completed and service restored.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the network isolation is scheduled to begin.',
    `valve_count` STRING COMMENT 'Total number of valves operated during the isolation event.',
    `valves_operated` STRING COMMENT 'Comma-separated list of valve identifiers that were operated (closed or opened) to achieve isolation.',
    `water_quality_testing_required` BOOLEAN COMMENT 'Indicates whether water quality testing is required before restoring service to customers. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_network_isolation_event PRIMARY KEY(`network_isolation_event_id`)
) COMMENT 'Planned or emergency network isolation events where valves are closed to isolate sections for maintenance, repairs, or emergencies. Tracks isolation date, reason, valves operated, area isolated, customers affected, duration, and restoration. Critical for emergency response planning and valve operability verification. Enhanced with customer-impact fields (population_at_risk, affected_zones, expected_restoration_at, public_notification_id) per VREQ-023.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` (
    `pipe_condition_assessment_id` BIGINT COMMENT 'Unique identifier for the pipe condition assessment record. Primary key. Ref: OSIsoft PI Historian.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project created or updated based on this assessment, if applicable. Ref: OSIsoft PI Historian.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Condition assessments identify pipe deficiencies requiring corrective action under regulatory compliance schedules, enforcement agreements, or infrastructure improvement mandates. Assessment findings. Ref: OSIsoft PI Historian.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Assessment program costs are allocated to asset management cost centers for capital planning cost tracking and condition assessment program budgeting. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Reference to the internal crew or team that performed the assessment. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) in which the assessed pipe main is located. Ref: OSIsoft PI Historian.',
    `encumbrance_id` BIGINT COMMENT 'Foreign key linking to finance.encumbrance. Business justification: Assessment contracts create encumbrances against capital or O&M budgets for contract commitment tracking and budget availability verification. Ref: OSIsoft PI Historian.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Assessment identifies pipe materials needing replacement, linking condition findings to procurement specifications for rehabilitation projects. Essential for capital planning, material standardization. Ref: OSIsoft PI Historian.',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor who performed the assessment, if outsourced. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Reference to the lead technician or inspector who conducted the assessment. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the distribution main that was assessed. Ref: OSIsoft PI Historian.',
    `pipe_technician_employee_id` BIGINT COMMENT 'Reference to the lead technician or inspector who conducted the assessment. Ref: OSIsoft PI Historian.',
    `pipe_vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor who performed the assessment, if outsourced. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which the assessed pipe main is located. Ref: OSIsoft PI Historian.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Pipe rehabilitation activities (CIPP lining, coating) trigger water quality sampling to verify no contamination from construction materials or activities. Required for NSF/ANSI 61 compliance verificat. Ref: OSIsoft PI Historian.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this condition assessment was performed. Ref: OSIsoft PI Historian.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or engineer who reviewed and approved the assessment findings.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment findings were reviewed and approved. Ref: OSIsoft PI Historian.',
    `assessment_date` DATE COMMENT 'Date on which the condition assessment was performed. Ref: OSIsoft PI Historian.',
    `assessment_end_time` TIMESTAMP COMMENT 'Timestamp when the condition assessment activity was completed. Ref: OSIsoft PI Historian.',
    `assessment_equipment_used` STRING COMMENT 'Description or identifier of the equipment or instrumentation used to perform the assessment (e.g., CCTV crawler model, acoustic logger model). Ref: OSIsoft PI Historian.',
    `assessment_method` STRING COMMENT 'Technology or technique used to perform the condition assessment (e.g., CCTV inspection, acoustic pipe assessment, electromagnetic inspection, visual inspection, ultrasonic testing). Ref: OSIsoft PI Historian.. Valid values are `CCTV|acoustic|electromagnetic|visual|ultrasonic|other`',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier or reference number for the condition assessment activity. Ref: OSIsoft PI Historian.',
    `assessment_report_url` STRING COMMENT 'URL or file path to the detailed condition assessment report, including photos, videos, and technical findings. Ref: OSIsoft PI Historian.',
    `assessment_start_time` TIMESTAMP COMMENT 'Timestamp when the condition assessment activity began. Ref: OSIsoft PI Historian.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the condition assessment activity. Ref: OSIsoft PI Historian.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `contractor_name` STRING COMMENT 'Name of the contractor or vendor who performed the assessment, denormalized for reporting. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was first created in the system. Ref: OSIsoft PI Historian.',
    `data_quality_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the assessment data meets quality standards (True=acceptable quality, False=quality issues noted). Ref: OSIsoft PI Historian.',
    `data_quality_notes` STRING COMMENT 'Free-text notes describing any data quality issues, limitations, or caveats related to the assessment findings. Ref: OSIsoft PI Historian.',
    `defect_count` STRING COMMENT 'Total number of discrete defects or anomalies identified during the assessment. Ref: OSIsoft PI Historian.',
    `defect_types_identified` STRING COMMENT 'Comma-separated list or description of defect types found during the assessment (e.g., corrosion, cracks, joint separation, tuberculation, lining failure). Ref: OSIsoft PI Historian.',
    `gis_feature_code` BOOLEAN COMMENT 'Reference to the GIS feature identifier for the assessed pipe main in Esri ArcGIS. Ref: OSIsoft PI Historian.',
    `internal_condition_grade` STRING COMMENT 'Internal surface condition rating on a 1-5 scale, assessing corrosion, tuberculation, and lining integrity. Ref: OSIsoft PI Historian.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was last updated or modified. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each pipe condition assessment in the distribution domain.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the condition assessment activity, findings, or follow-up actions. Ref: OSIsoft PI Historian.',
    `overall_condition_grade` STRING COMMENT 'Overall condition rating assigned to the pipe main on a 1-5 scale (1=excellent, 5=critical/failed), based on assessment findings. Ref: OSIsoft PI Historian.',
    `pipe_length_assessed_feet` DECIMAL(18,2) COMMENT 'Total length of pipe main inspected during this assessment, measured in feet. Ref: OSIsoft PI Historian.',
    `pipe_number` STRING COMMENT 'Business identifier of the pipe main assessed, denormalized for reporting convenience. Ref: OSIsoft PI Historian.',
    `recommended_action` STRING COMMENT 'Recommended next step based on assessment findings (e.g., monitor, rehabilitate, replace, urgent repair, no action required). Ref: OSIsoft PI Historian.. Valid values are `monitor|rehabilitate|replace|urgent_repair|no_action`',
    `recommended_action_priority` STRING COMMENT 'Priority level assigned to the recommended action for Capital Improvement Program (CIP) planning and asset renewal prioritization. Ref: OSIsoft PI Historian.. Valid values are `critical|high|medium|low`',
    `remaining_useful_life_years` STRING COMMENT 'Estimated remaining useful life of the pipe main in years, based on condition assessment findings and deterioration modeling. Ref: OSIsoft PI Historian.',
    `structural_condition_grade` STRING COMMENT 'Structural integrity rating on a 1-5 scale, assessing the pipes ability to withstand loads and pressure. Ref: OSIsoft PI Historian.',
    `technician_name` STRING COMMENT 'Name of the lead technician or inspector, denormalized for reporting. Ref: OSIsoft PI Historian.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of the assessment, which may affect inspection quality or findings. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_pipe_condition_assessment PRIMARY KEY(`pipe_condition_assessment_id`)
) COMMENT 'Condition assessments of distribution mains using internal inspection (CCTV, acoustic, electromagnetic), external inspection, or indirect methods (break history, soil corrosivity, age). Tracks assessment date, method, condition grade, remaining useful life, defects identified, and rehabilitation recommendations. Supports asset management, capital planning, and main replacement prioritization per AWWA M28 Rehabilitation of Water Mains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` (
    `dma_crew_coverage_id` BIGINT COMMENT 'Unique identifier for this DMA-crew coverage assignment record. Primary key. Ref: OSIsoft PI Historian.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the field service crew assigned to cover this DMA. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to the District Metered Area being covered by this crew assignment. Ref: OSIsoft PI Historian.',
    `after_hours_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this crew has after-hours (night/weekend/holiday) emergency response responsibility for this DMA. Used for on-call scheduling and emergency dispatch routing. Ref: OSIsoft PI Historian.',
    `assignment_end_date` DATE COMMENT 'Date when this crew coverage assignment ended or is scheduled to end. Null for current active assignments. Supports crew rotation and reassignment tracking. Ref: OSIsoft PI Historian.',
    `assignment_start_date` DATE COMMENT 'Date when this crew began coverage responsibility for this DMA. Used to track historical crew assignments and support crew rotation analysis. Ref: OSIsoft PI Historian.',
    `coverage_type` STRING COMMENT 'Classification of the coverage responsibility: routine (scheduled maintenance and monitoring), emergency (main break and leak response), after_hours (night/weekend coverage), on_call (standby), primary (first responder), backup (secondary responder). Determines dispatch priority and labor costing. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage assignment record was created in the system. Ref: OSIsoft PI Historian.',
    `dma_crew_coverage_status` STRING COMMENT 'Current operational status of this coverage assignment: active (currently in effect), inactive (ended), suspended (temporarily paused), seasonal (active only during specific periods). Used to filter current assignments for dispatch. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each dma crew coverage in the distribution domain.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, geographic boundaries within the DMA, equipment requirements, access restrictions, or coordination notes for this crew-DMA assignment. Ref: OSIsoft PI Historian.',
    `response_priority` STRING COMMENT 'Numeric priority rank for this crew when multiple crews cover the same DMA (1=primary responder, 2=backup, etc.). Used by dispatch systems to route emergency work orders. Ref: OSIsoft PI Historian.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage assignment record was last modified. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_dma_crew_coverage PRIMARY KEY(`dma_crew_coverage_id`)
) COMMENT 'Assignment of field crews to DMAs or maintenance zones for routine operations, leak detection, valve exercising, and emergency response. Tracks crew, DMA, coverage period, responsibilities, and performance metrics. Supports workforce planning, response time optimization, and workload balancing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` (
    `pipe_procurement_id` BIGINT COMMENT 'Unique identifier for this pipe procurement line item record. Primary key. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to the specific pipe main segment that was procured under this contract line item. Ref: OSIsoft PI Historian.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the blanket procurement contract under which this pipe main was sourced. Ref: OSIsoft PI Historian.',
    `actual_delivery_date` DATE COMMENT 'The actual date the pipe material was delivered to the job site or utility warehouse. Used for vendor performance measurement and project schedule variance analysis. Ref: OSIsoft PI Historian.',
    `contract_line_item_number` STRING COMMENT 'The specific line item number within the procurement contract that covers this pipe main procurement. Allows traceability to contract terms, pricing schedules, and delivery conditions specific to this material specification. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipe procurement record was created in the system. Audit trail for procurement planning and execution. Ref: OSIsoft PI Historian.',
    `delivery_schedule` DATE COMMENT 'The scheduled delivery date for this pipe main material as coordinated between procurement and the construction project schedule. Used for project planning and vendor performance tracking. Ref: OSIsoft PI Historian.',
    `installation_specification` STRING COMMENT 'Reference to the technical specification or standard that governs the installation of this pipe main under the contract terms. May reference AWWA standards, utility-specific installation procedures, or project-specific engineering drawings. Ensures contract compliance and warranty validity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this pipe procurement record. Audit trail for status changes and data corrections. Ref: OSIsoft PI Historian.',
    `material_certification_number` STRING COMMENT 'The manufacturers material certification or mill test report number for this specific pipe main batch. Required for quality assurance, regulatory compliance, and warranty claims. Links physical asset to material traceability documentation. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each pipe procurement in the distribution domain.',
    `procurement_status` STRING COMMENT 'Current status of this procurement line item in the procurement-to-installation lifecycle. Tracks progression from planning through final installation. Ref: OSIsoft PI Historian.',
    `purchase_order_number` STRING COMMENT 'The specific purchase order or contract release number issued against the blanket contract for this pipe main procurement. Links to accounts payable and financial systems for payment processing. Ref: OSIsoft PI Historian.',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'The quantity of pipe material allocated from the contract for this specific pipe main installation, typically measured in linear feet or number of pipe segments. Used for contract consumption tracking and remaining balance calculation. Ref: OSIsoft PI Historian.',
    `total_line_value` DECIMAL(18,2) COMMENT 'The total monetary value of this procurement line item (quantity_allocated × unit_price). Used for contract consumption tracking, budget management, and asset capitalization. Ref: OSIsoft PI Historian.',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price paid for this pipe main procurement under the contract terms at the time of release. May vary from the base contract price due to escalation clauses, volume discounts, or material specification adjustments. Critical for asset capitalization and lifecycle cost analysis. Ref: OSIsoft PI Historian.',
    `warranty_start_date` DATE COMMENT 'The date from which the manufacturer or contractor warranty period begins for this pipe main procurement. May differ from installation date based on contract terms. Used for warranty claim eligibility determination. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_pipe_procurement PRIMARY KEY(`pipe_procurement_id`)
) COMMENT 'Procurement records for distribution pipe materials including ductile iron, PVC, HDPE, and steel pipe. Tracks material specifications, quantities, vendors, purchase orders, delivery schedules, and quality certifications. Ensures compliance with AWWA standards (C900, C905, C151) and supports main replacement programs and CIP projects.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` (
    `zone_operator_assignment_id` BIGINT COMMENT 'Unique identifier for each pressure zone operator assignment record. Primary key. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the certified operator assigned to the pressure zone. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to the pressure zone requiring operator coverage. Ref: OSIsoft PI Historian.',
    `assignment_end_date` DATE COMMENT 'Date when the operator assignment to this pressure zone ended. Nullable for active assignments. Used for historical coverage analysis. Ref: OSIsoft PI Historian.',
    `assignment_start_date` DATE COMMENT 'Date when the operator was assigned to this pressure zone for the specified role. Used for coverage tracking and compliance reporting. Ref: OSIsoft PI Historian.',
    `assignment_status` STRING COMMENT 'Current status of the operator assignment. Active for current assignments, Suspended for temporary holds, Inactive for ended assignments, Pending for future-dated assignments. Ref: OSIsoft PI Historian.',
    `certification_level_required` STRING COMMENT 'Minimum operator certification grade or class required for this zone assignment per state regulatory requirements. Varies by zone complexity, population served, and treatment processes. Ref: OSIsoft PI Historian.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system. Ref: OSIsoft PI Historian.',
    `last_coverage_date` DATE COMMENT 'Most recent date when this operator provided coverage for this pressure zone. Used for rotation balancing and workload distribution analysis. Ref: OSIsoft PI Historian.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this assignment record. Ref: OSIsoft PI Historian.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each zone operator assignment in the distribution domain.',
    `on_call_rotation_flag` BOOLEAN COMMENT 'Indicates whether this operator is part of the on-call rotation schedule for this pressure zone. True for operators in rotation, false for fixed assignments. Ref: OSIsoft PI Historian.',
    `operator_role` STRING COMMENT 'Role of the operator for this specific pressure zone assignment. Defines responsibility level and coverage type (Primary, Backup, On-Call, Relief). Ref: OSIsoft PI Historian.',
    `primary_backup_flag` BOOLEAN COMMENT 'Indicates whether this operator serves as the primary backup for this pressure zone. True for designated primary backup, false otherwise. Ref: OSIsoft PI Historian.',
    `rotation_sequence` STRING COMMENT 'Sequence number for on-call rotation scheduling. Defines the order in which operators are called for this pressure zone. Nullable for non-rotation assignments. Ref: OSIsoft PI Historian.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this assignment record. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_zone_operator_assignment PRIMARY KEY(`zone_operator_assignment_id`)
) COMMENT 'Assignment of licensed operators to pressure zones or DMAs for operational oversight, SCADA monitoring, and regulatory compliance. Tracks operator, zone, assignment period, certification level, and responsibilities. Ensures adequate operator coverage per state primacy agency requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` (
    `maintenance_zone_id` BIGINT COMMENT 'Primary key for maintenance_zone. Ref: IBM Maximo.',
    `dma_id` BIGINT COMMENT 'Foreign key to the District Metered Area that contains this maintenance zone. Ref: IBM Maximo.',
    `hydraulic_model_run_id` BIGINT COMMENT 'Identifier of the hydraulic model used for simulation of the zone. Ref: IBM Maximo.',
    `parent_maintenance_zone_id` BIGINT COMMENT 'Self-referencing FK on maintenance_zone (parent_maintenance_zone_id). Ref: IBM Maximo.',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Geographic area covered by the maintenance zone in square kilometres. Ref: IBM Maximo.',
    `average_flow_gpm` DECIMAL(18,2) COMMENT 'Typical water flow rate in the zone measured in gallons per minute. Ref: IBM Maximo.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Typical operating pressure within the zone measured in pounds per square inch. Ref: IBM Maximo.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the zone. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance zone record was first created. Ref: IBM Maximo.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance zone is scheduled to be retired or become inactive (nullable). Ref: IBM Maximo.',
    `effective_start_date` DATE COMMENT 'Date when the maintenance zone became effective for operational use. Ref: IBM Maximo.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether the zone contains assets classified as critical infrastructure (true/false). Ref: IBM Maximo.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed in the zone. Ref: IBM Maximo.',
    `maintenance_priority` STRING COMMENT 'Priority level for scheduled maintenance activities in the zone. Ref: IBM Maximo.',
    `maintenance_window_hours` STRING COMMENT 'Typical duration in hours allocated for maintenance activities within the zone. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each maintenance zone in the distribution domain.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Planned date for the next routine maintenance in the zone. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free‑form text for additional comments, observations, or special instructions. Ref: IBM Maximo.',
    `population_served` STRING COMMENT 'Estimated number of customers or residents served by the zone. Ref: IBM Maximo.',
    `pressure_zone` STRING COMMENT 'Pressure zone classification used for regulatory reporting and operational planning. Ref: IBM Maximo.',
    `regulatory_region` STRING COMMENT 'Three‑letter code representing the regulatory jurisdiction for the zone. Ref: IBM Maximo.',
    `maintenance_zone_status` STRING COMMENT 'Current operational status of the maintenance zone. Ref: IBM Maximo.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the maintenance zone record. Ref: IBM Maximo.',
    `zone_code` STRING COMMENT 'Official alphanumeric code used to reference the maintenance zone in operational systems. Ref: IBM Maximo.',
    `zone_name` STRING COMMENT 'Human‑readable name of the maintenance zone. Ref: IBM Maximo.',
    `zone_type` STRING COMMENT 'Category of the zone based on service profile or land use. Ref: IBM Maximo.',
    CONSTRAINT pk_maintenance_zone PRIMARY KEY(`maintenance_zone_id`)
) COMMENT 'Geographic maintenance zones grouping distribution assets for work planning, crew assignment, and performance tracking. May align with DMAs, pressure zones, or service territories. Tracks zone boundaries, asset counts, maintenance schedules, and responsible crews. Supports preventive maintenance programs and resource allocation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` (
    `nrw_program_id` BIGINT COMMENT 'Primary key for nrw_program. Ref: OSIsoft PI Historian.',
    `finance_budget_id` BIGINT COMMENT 'FK to finance budget per VREQ-037. Ref: OSIsoft PI Historian.',
    `predecessor_nrw_program_id` BIGINT COMMENT 'Self-referencing FK on nrw_program (predecessor_nrw_program_id). Ref: OSIsoft PI Historian.',
    `territory_id` BIGINT COMMENT 'FK to service territory per VREQ-038. Ref: OSIsoft PI Historian.',
    `actual_nrw_reduction_percent` DECIMAL(18,2) COMMENT 'Measured percentage reduction in non‑revenue water realized to date. Ref: OSIsoft PI Historian.',
    `actual_nrw_reduction_volume_mgd` DECIMAL(18,2) COMMENT 'Measured volume of water (million gallons per day) saved to date. Ref: OSIsoft PI Historian.',
    `approval_date` DATE COMMENT 'Date on which the program received formal approval. Ref: OSIsoft PI Historian.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the program. Ref: OSIsoft PI Historian.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to the program. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system. Ref: OSIsoft PI Historian.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amount.',
    `data_source` STRING COMMENT 'System or dataset providing the measurement data (e.g., SCADA, InfoWater). Ref: OSIsoft PI Historian.',
    `nrw_program_description` STRING COMMENT 'Detailed description of the program objectives, scope, and approach. Ref: OSIsoft PI Historian.',
    `end_date` DATE COMMENT 'Planned completion date of the program; may be null for open‑ended initiatives. Ref: OSIsoft PI Historian.',
    `last_review_date` DATE COMMENT 'Date of the most recent program performance review. Ref: OSIsoft PI Historian.',
    `measurement_method` STRING COMMENT 'Primary method used to measure NRW reduction outcomes. Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each nrw program in the distribution domain.',
    `next_review_date` DATE COMMENT 'Planned date for the next program performance review. Ref: OSIsoft PI Historian.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the program. Ref: OSIsoft PI Historian.',
    `priority_level` STRING COMMENT 'Priority assigned to the program based on strategic importance. Ref: OSIsoft PI Historian.',
    `program_code` STRING COMMENT 'External business code used to reference the program in reports and external systems. Ref: OSIsoft PI Historian.',
    `program_name` STRING COMMENT 'Human‑readable name of the NRW reduction program. Ref: OSIsoft PI Historian.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program. Ref: OSIsoft PI Historian.',
    `program_type` STRING COMMENT 'Category of the program indicating the primary focus area for water loss reduction. Ref: OSIsoft PI Historian.',
    `region` STRING COMMENT 'Geographic region or service area where the program is applied. Ref: OSIsoft PI Historian.',
    `responsible_department` STRING COMMENT 'Internal department accountable for execution of the program. Ref: OSIsoft PI Historian.',
    `risk_level` STRING COMMENT 'Risk assessment rating for the program. Ref: OSIsoft PI Historian.',
    `start_date` DATE COMMENT 'Date when the program officially begins. Ref: OSIsoft PI Historian.',
    `target_nrw_reduction_percent` DECIMAL(18,2) COMMENT 'Planned percentage reduction in non‑revenue water achieved by the program. Ref: OSIsoft PI Historian.',
    `target_nrw_reduction_volume_mgd` DECIMAL(18,2) COMMENT 'Target volume of water (million gallons per day) to be saved through the program. Ref: OSIsoft PI Historian.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_nrw_program PRIMARY KEY(`nrw_program_id`)
) COMMENT 'Non-Revenue Water reduction programs encompassing leak detection, pressure management, meter accuracy, and water audit activities. Tracks program goals, budget, activities, performance metrics (NRW%, ILI), and cost-benefit analysis. Supports AWWA M36 loss control strategies and rate case justification. Enhanced with finance_budget_id and territory_id foreign keys per VREQ-037 and VREQ-038.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Demand‑Management Area identifier for the node. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone to which the node belongs. Ref: OSIsoft PI Historian.',
    `network_upstream_node_id` BIGINT COMMENT 'Identifier of the immediate upstream node in the hydraulic flow direction. Ref: OSIsoft PI Historian.',
    `primary_pressure_zone_id` BIGINT COMMENT 'Identifier of the broader network zone containing the node. Ref: OSIsoft PI Historian.',
    `primary_upstream_network_node_id` BIGINT COMMENT 'Self-referencing FK on network_node (upstream_network_node_id). Ref: OSIsoft PI Historian.',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall condition derived from inspections. Ref: OSIsoft PI Historian.',
    `asset_lifecycle_stage` STRING COMMENT 'Current stage of the asset within its lifecycle. Ref: OSIsoft PI Historian.',
    `asset_tag` STRING COMMENT 'Physical tag or barcode assigned to the node for inventory. Ref: OSIsoft PI Historian.',
    `asset_value_usd` DECIMAL(18,2) COMMENT 'Current book value of the node in US dollars. Ref: OSIsoft PI Historian.',
    `commissioning_date` DATE COMMENT 'Date the node entered service after testing and acceptance. Ref: OSIsoft PI Historian.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the node. Ref: OSIsoft PI Historian.',
    `condition_rating` STRING COMMENT 'Qualitative assessment of the nodes physical condition. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the node record was first created in the system. Ref: OSIsoft PI Historian.',
    `decommission_date` DATE COMMENT 'Date the node was permanently removed from service, if applicable. Ref: OSIsoft PI Historian.',
    `diameter_in` DECIMAL(18,2) COMMENT 'Internal diameter of the pipe or conduit at the node, inches. Ref: OSIsoft PI Historian.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Ground elevation of the node above sea level, meters. Ref: OSIsoft PI Historian.',
    `flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity for the node, gallons per minute. Ref: OSIsoft PI Historian.',
    `flow_gpm` DECIMAL(18,2) COMMENT 'Average water flow through the node, gallons per minute. Ref: OSIsoft PI Historian.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection. Ref: OSIsoft PI Historian.',
    `installation_date` DATE COMMENT 'Date the node was physically installed. Ref: OSIsoft PI Historian.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the node is considered critical for service continuity. Ref: OSIsoft PI Historian.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the node. Ref: OSIsoft PI Historian.',
    `last_maintenance_date` DATE COMMENT 'Date the node most recently underwent scheduled maintenance. Ref: OSIsoft PI Historian.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the node in decimal degrees. Ref: OSIsoft PI Historian.',
    `length_m` DECIMAL(18,2) COMMENT 'Length of pipe segment represented by the node, meters. Ref: OSIsoft PI Historian.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the node in decimal degrees. Ref: OSIsoft PI Historian.',
    `maintenance_priority` STRING COMMENT 'Priority level for scheduling maintenance activities. Ref: OSIsoft PI Historian.',
    `maintenance_schedule` STRING COMMENT 'Standard maintenance frequency for the node. Ref: OSIsoft PI Historian.',
    `material` STRING COMMENT 'Construction material of the node (e.g., ductile iron, PVC). Ref: OSIsoft PI Historian.',
    `mutator_note` STRING COMMENT 'The mutator note value recorded for each network node in the distribution domain.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance. Ref: OSIsoft PI Historian.',
    `node_code` STRING COMMENT 'External or legacy code that uniquely identifies the node within legacy GIS or SCADA systems. Ref: OSIsoft PI Historian.',
    `node_name` STRING COMMENT 'Human‑readable name of the node used in operations and reporting. Ref: OSIsoft PI Historian.',
    `node_type` STRING COMMENT 'Category of the node describing its functional role in the distribution network. Ref: OSIsoft PI Historian.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the node. Ref: OSIsoft PI Historian.',
    `owner_department` STRING COMMENT 'Internal department responsible for the nodes operation and maintenance. Ref: OSIsoft PI Historian.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Measured hydraulic pressure at the node, pounds per square inch. Ref: OSIsoft PI Historian.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum design pressure rating for the node, psi. Ref: OSIsoft PI Historian.',
    `sensor_code` STRING COMMENT 'Identifier of the sensor attached to the node, if any. Ref: OSIsoft PI Historian.',
    `network_node_status` STRING COMMENT 'Current operational status of the node. Ref: OSIsoft PI Historian.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the node record. Ref: OSIsoft PI Historian.',
    `water_quality_monitoring` BOOLEAN COMMENT 'Indicates if the node includes a water‑quality sensor. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Hydraulic model nodes representing junctions, demand points, or connection points in the distribution network. Tracks node ID, elevation, demand allocation, pressure, and GIS coordinates. Essential for hydraulic modeling in InfoWater, WaterGEMS, or EPANET. Links to pipe mains, service lines, and network readings.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_maintenance_zone_id` FOREIGN KEY (`maintenance_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`maintenance_zone`(`maintenance_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_hydrant_pipe_main_id` FOREIGN KEY (`hydrant_pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_storage_dma_id` FOREIGN KEY (`storage_dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_flow_reading_id` FOREIGN KEY (`flow_reading_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`flow_reading`(`flow_reading_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ADD CONSTRAINT `fk_distribution_distribution_nrw_water_balance_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_nrw_program_id` FOREIGN KEY (`nrw_program_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`nrw_program`(`nrw_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_tertiary_residual_hydrant_id` FOREIGN KEY (`tertiary_residual_hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ADD CONSTRAINT `fk_distribution_dma_crew_coverage_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ADD CONSTRAINT `fk_distribution_pipe_procurement_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ADD CONSTRAINT `fk_distribution_zone_operator_assignment_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ADD CONSTRAINT `fk_distribution_maintenance_zone_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ADD CONSTRAINT `fk_distribution_maintenance_zone_hydraulic_model_run_id` FOREIGN KEY (`hydraulic_model_run_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run`(`hydraulic_model_run_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ADD CONSTRAINT `fk_distribution_maintenance_zone_parent_maintenance_zone_id` FOREIGN KEY (`parent_maintenance_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`maintenance_zone`(`maintenance_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ADD CONSTRAINT `fk_distribution_nrw_program_predecessor_nrw_program_id` FOREIGN KEY (`predecessor_nrw_program_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`nrw_program`(`nrw_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_network_upstream_node_id` FOREIGN KEY (`network_upstream_node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_primary_pressure_zone_id` FOREIGN KEY (`primary_pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_primary_upstream_network_node_id` FOREIGN KEY (`primary_upstream_network_node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_network' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_lcrr' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_lead' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_hydraulics' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_network' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `arcgis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Esri ArcGIS Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `average_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `average_elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Average Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Boundary Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `elevation_max_ft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `elevation_min_ft` SET TAGS ('dbx_business_glossary_term' = 'Minimum Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `fire_flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Capacity (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `hydraulic_model_last_calibrated_date` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Last Calibrated Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `infowater_model_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Innovyze InfoWater Model Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `last_boundary_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Boundary Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `nrw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|emergency|planned');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `peak_hour_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Demand (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `residual_pressure_fire_psi` SET TAGS ('dbx_business_glossary_term' = 'Residual Pressure During Fire Flow (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `scada_zone_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Zone Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `service_area_sq_mi` SET TAGS ('dbx_business_glossary_term' = 'Service Area (Square Miles)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `storage_capacity_mg` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Million Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `target_pressure_max_psi` SET TAGS ('dbx_business_glossary_term' = 'Target Maximum Pressure (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `target_pressure_min_psi` SET TAGS ('dbx_business_glossary_term' = 'Target Minimum Pressure (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `ufw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted-for Water (UFW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'gravity|pumped|combination|elevated|booster');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_nrw' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_leakage' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_metering' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_responsible_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_responsible_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_responsible_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `maintenance_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `average_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Boundary Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `decommissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioned Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_description` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `design_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Flow in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_status` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_review|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `gis_polygon_boundary` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Polygon Boundary');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `inlet_meter_count` SET TAGS ('dbx_business_glossary_term' = 'Inlet Meter Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `isolation_valve_count` SET TAGS ('dbx_business_glossary_term' = 'Isolation Valve Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `last_leakage_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Leakage Survey Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `leakage_detection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Leakage Detection Frequency in Days');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `main_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Main Length in Miles');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `minimum_night_flow_threshold_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow (MNF) Threshold in Gallons per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_name` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `next_scheduled_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Survey Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `outlet_meter_count` SET TAGS ('dbx_business_glossary_term' = 'Outlet Meter Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `prv_count` SET TAGS ('dbx_business_glossary_term' = 'Pressure Reducing Valve (PRV) Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `scada_monitored_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitored Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `service_connection_count` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `target_nrw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Non-Revenue Water (NRW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `target_ufw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Unaccounted-for Water (UFW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `network_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Water Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `burial_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Valve Burial Depth (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Valve City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Valve Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Valve Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `current_position` SET TAGS ('dbx_business_glossary_term' = 'Valve Current Position');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `current_position` SET TAGS ('dbx_value_regex' = 'open|closed|throttled|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Valve Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `exercising_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Valve Exercising Frequency (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Valve Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Valve Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `is_buried` SET TAGS ('dbx_business_glossary_term' = 'Valve Is Buried Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `is_motorized` SET TAGS ('dbx_business_glossary_term' = 'Valve Is Motorized Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `last_exercised_by` SET TAGS ('dbx_business_glossary_term' = 'Valve Last Exercised By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `last_exercised_date` SET TAGS ('dbx_business_glossary_term' = 'Valve Last Exercised Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Valve Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Valve Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Valve Material');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `material` SET TAGS ('dbx_value_regex' = 'cast_iron|ductile_iron|bronze|stainless_steel|pvc|brass');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `normal_position` SET TAGS ('dbx_business_glossary_term' = 'Valve Normal Operating Position');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `normal_position` SET TAGS ('dbx_value_regex' = 'open|closed|throttled');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Valve Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Valve Operating Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Valve Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|removed|planned');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Valve Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Valve Pressure Rating (Pounds per Square Inch - PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Valve State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Valve Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `street_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `turns_to_close` SET TAGS ('dbx_business_glossary_term' = 'Valve Turns to Close Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Valve Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_box_type` SET TAGS ('dbx_business_glossary_term' = 'Valve Box Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_box_type` SET TAGS ('dbx_value_regex' = 'standard|traffic_rated|extension|vault|none');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_function` SET TAGS ('dbx_business_glossary_term' = 'Valve Function');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_function` SET TAGS ('dbx_value_regex' = 'isolation|control|pressure_reducing|check|air_release|blowoff');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_number` SET TAGS ('dbx_business_glossary_term' = 'Valve Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `valve_type` SET TAGS ('dbx_business_glossary_term' = 'Valve Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_hydraulics' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_scada' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `prv_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Reducing Valve (PRV) Station Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Inlet Pressure Zone Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Station Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `bypass_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bypass Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `bypass_configuration` SET TAGS ('dbx_value_regex' = 'none|manual|automatic|redundant');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `calibration_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `design_flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Capacity (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `hydraulic_model_node_code` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Node Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|standby|maintenance|decommissioned|planned');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|shared|leased');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `prv_serial_number` SET TAGS ('dbx_business_glossary_term' = 'PRV Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `rtu_code` SET TAGS ('dbx_business_glossary_term' = 'Remote Terminal Unit (RTU) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `scada_tag_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `scada_tag_inlet_pressure` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Inlet Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `scada_tag_outlet_pressure` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Outlet Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `set_point_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Set Point Pressure (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'PRV Station Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'PRV Station Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'PRV Station Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'inline|vault|above_ground|below_ground|chamber|kiosk');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_value_regex' = 'online|offline|intermittent|not_installed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `valve_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Valve Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_fire_protection' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Pipe Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Pipe Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `bury_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Bury Depth in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Municipality City Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `fire_district` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection District Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Capacity in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `flow_class_color` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) Flow Class Color Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `flow_class_color` SET TAGS ('dbx_value_regex' = 'red|orange|green|blue|light_blue');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `flushing_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Flushing Program Participation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_number` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Type Classification');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_type` SET TAGS ('dbx_value_regex' = 'dry_barrel|wet_barrel|flush|wall');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `last_flow_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fire Flow Test Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `last_flushing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Flushing Activity Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `main_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Main Pipe Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Maintenance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_repair|abandoned|planned');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Outlet Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `outlet_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Outlet Size in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|municipality_owned|private|fire_district');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code or ZIP Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `residual_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Residual Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `static_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `valve_turns_to_open` SET TAGS ('dbx_business_glossary_term' = 'Valve Turns Required to Fully Open');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_scada' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_energy' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Street Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Street Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_available` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Available');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Capacity in Kilowatts (kW)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `design_flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Capacity in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `design_flow_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Capacity in Million Gallons Per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `discharge_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Discharge Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `hydraulic_model_node_code` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Node Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `number_of_duty_pumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Duty Pumps');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `number_of_pumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Pumps');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `number_of_standby_pumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Standby Pumps');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|standby|maintenance|inactive|decommissioned|under_construction');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|shared|third_party');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_phase` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Phase');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_phase` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_voltage` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `scada_integrated` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integrated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'booster|transfer|lift|high_service|low_service|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `suction_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Suction Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `total_dynamic_head_ft` SET TAGS ('dbx_business_glossary_term' = 'Total Dynamic Head (TDH) in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `vfd_configuration` SET TAGS ('dbx_business_glossary_term' = 'Variable Frequency Drive (VFD) Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `vfd_equipped` SET TAGS ('dbx_business_glossary_term' = 'Variable Frequency Drive (VFD) Equipped');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_scada' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_water_quality' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `storage_dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `base_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Base Elevation in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `capacity_million_gallons` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Million Gallons (MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `coating_condition` SET TAGS ('dbx_business_glossary_term' = 'Coating Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `coating_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `emergency_storage_gallons` SET TAGS ('dbx_business_glossary_term' = 'Emergency Storage in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `fire_flow_reserve_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Reserve in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `hydraulic_model_node_code` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Node Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `inlet_pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Inlet Pipe Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `last_cleaning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaning Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `last_coating_date` SET TAGS ('dbx_business_glossary_term' = 'Last Coating Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `maximum_operating_level_feet` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Level in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `minimum_operating_level_feet` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Level in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `mixing_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Mixing System Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `mixing_system_type` SET TAGS ('dbx_business_glossary_term' = 'Mixing System Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `mixing_system_type` SET TAGS ('dbx_value_regex' = 'mechanical|hydraulic|none');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|standby|under_maintenance|decommissioned');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `outlet_pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Outlet Pipe Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `overflow_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Overflow Elevation in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `overflow_pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Overflow Pipe Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|leased|shared|third_party');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `regulatory_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `regulatory_inspection_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `scada_flow_meter_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Flow Meter Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `scada_level_sensor_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Level Sensor Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `scada_pressure_sensor_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Pressure Sensor Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `security_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Security System Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `structural_condition` SET TAGS ('dbx_business_glossary_term' = 'Structural Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `structural_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_material` SET TAGS ('dbx_business_glossary_term' = 'Tank Material');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_material` SET TAGS ('dbx_value_regex' = 'steel|concrete|prestressed_concrete|composite|fiberglass');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_name` SET TAGS ('dbx_business_glossary_term' = 'Tank Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_type` SET TAGS ('dbx_business_glossary_term' = 'Tank Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_type` SET TAGS ('dbx_value_regex' = 'elevated|ground_level|standpipe|reservoir|clearwell|hydropneumatic');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `usable_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Usable Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_scada' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_telemetry' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_nrw' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_metering' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `flow_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Reading Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `alarm_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'high_flow|low_flow|no_flow|reverse_flow|communication_failure|meter_fault');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_value_regex' = 'GPM|MGD|CFS|LPS|M3H|M3D');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `estimated_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimated Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'linear_interpolation|historical_average|pattern_based|manual_estimate|none');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `flow_direction` SET TAGS ('dbx_business_glossary_term' = 'Flow Direction');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `flow_direction` SET TAGS ('dbx_value_regex' = 'inflow|outflow|bidirectional');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `flow_value` SET TAGS ('dbx_business_glossary_term' = 'Flow Value');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `hydraulic_model_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'instantaneous|cumulative|average|peak|minimum');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `meter_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Meter Accuracy Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `nrw_calculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Calculation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit (F)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `totalizer_reading` SET TAGS ('dbx_business_glossary_term' = 'Totalizer Reading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|corrected');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_scada' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_telemetry' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_water_quality' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_pressure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_ecm_depth_target' = '7');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Network Reading Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Meter Installation');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_validated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_validated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Node ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for network_reading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `alarm_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Alarm Threshold Exceeded');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `alarm_triggered` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `calibration_offset` SET TAGS ('dbx_business_glossary_term' = 'Calibration Offset');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `compression_applied` SET TAGS ('dbx_business_glossary_term' = 'Compression Applied');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_business_glossary_term' = 'ECM/MVM Depth Reconciliation');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_mvm_reconciliation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `high_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `high_alarm_threshold` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `is_alarm_active` SET TAGS ('dbx_business_glossary_term' = 'Is Alarm Active');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `is_anomaly` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `is_regulatory_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exceedance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `low_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `low_alarm_threshold` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `parameter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'PI Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `raw_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Value');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `reading_number` SET TAGS ('dbx_business_glossary_term' = 'Reading Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `reading_source` SET TAGS ('dbx_business_glossary_term' = 'Reading Source');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `sample_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval Seconds');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `sensor_location` SET TAGS ('dbx_business_glossary_term' = 'Sensor Location');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `sensor_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sensor Location');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_nrw' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_water_loss' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_performance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_awwa_m36' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `distribution_nrw_water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Water Balance ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `revenue_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `apparent_losses_mg` SET TAGS ('dbx_business_glossary_term' = 'Apparent Losses (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_period_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|validated|approved|published');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `auditor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `authorized_consumption_mg` SET TAGS ('dbx_business_glossary_term' = 'Authorized Consumption (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `average_system_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average System Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `billed_metered_consumption_mg` SET TAGS ('dbx_business_glossary_term' = 'Billed Metered Consumption (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `billed_unmetered_consumption_mg` SET TAGS ('dbx_business_glossary_term' = 'Billed Unmetered Consumption (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Audit Comments');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `current_annual_real_losses_mg` SET TAGS ('dbx_business_glossary_term' = 'Current Annual Real Losses (CARL) (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `customer_meter_inaccuracies_mg` SET TAGS ('dbx_business_glossary_term' = 'Customer Meter Inaccuracies (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `data_grading` SET TAGS ('dbx_business_glossary_term' = 'Data Grading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `data_handling_errors_mg` SET TAGS ('dbx_business_glossary_term' = 'Data Handling Errors (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `data_validity_score` SET TAGS ('dbx_business_glossary_term' = 'Data Validity Score');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `infrastructure_leakage_index` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Leakage Index (ILI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `leakage_on_service_connections_mg` SET TAGS ('dbx_business_glossary_term' = 'Leakage on Service Connections (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `leakage_on_storage_tanks_mg` SET TAGS ('dbx_business_glossary_term' = 'Leakage and Overflow on Storage Tanks (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `leakage_on_transmission_mains_mg` SET TAGS ('dbx_business_glossary_term' = 'Leakage on Transmission and Distribution Mains (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `nrw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `nrw_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Volume (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `real_losses_mg` SET TAGS ('dbx_business_glossary_term' = 'Real Losses (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `service_connection_count` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `system_input_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'System Input Volume (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `total_main_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Main Length (Miles)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `ufw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted-for Water (UFW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `ufw_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted-for Water (UFW) Volume (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `unauthorized_consumption_mg` SET TAGS ('dbx_business_glossary_term' = 'Unauthorized Consumption (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `unavoidable_annual_real_losses_mg` SET TAGS ('dbx_business_glossary_term' = 'Unavoidable Annual Real Losses (UARL) (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `unbilled_authorized_consumption_mg` SET TAGS ('dbx_business_glossary_term' = 'Unbilled Authorized Consumption (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `water_losses_mg` SET TAGS ('dbx_business_glossary_term' = 'Water Losses (Million Gallons - MG)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_nrw' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_leakage' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_detection_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Survey Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_detection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Leak Detection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `nrw_program_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Program Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Segment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `ambient_noise_level` SET TAGS ('dbx_business_glossary_term' = 'Ambient Noise Level');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `ambient_noise_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `estimated_leak_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Estimated Leak Rate Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_locations_gis` SET TAGS ('dbx_business_glossary_term' = 'Leak Locations Geographic Information System (GIS) Coordinates');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leaks_found_count` SET TAGS ('dbx_business_glossary_term' = 'Leaks Found Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `repair_work_order_generated` SET TAGS ('dbx_business_glossary_term' = 'Repair Work Order Generated Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Survey Cost Currency');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_end_time` SET TAGS ('dbx_business_glossary_term' = 'Survey End Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Survey Length (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'acoustic_correlator|listening_stick|ground_penetrating_radar|leak_noise_logger|tracer_gas|thermal_imaging');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_outcome` SET TAGS ('dbx_business_glossary_term' = 'Survey Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_outcome` SET TAGS ('dbx_value_regex' = 'leaks_detected|no_leaks_found|inconclusive|equipment_failure|weather_delay');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_priority` SET TAGS ('dbx_business_glossary_term' = 'Survey Priority');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_priority` SET TAGS ('dbx_value_regex' = 'routine|high|critical|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_start_time` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold|failed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `technician_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_incident' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_emergency' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_customer_impact' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `encumbrance_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `quality_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `affected_zones` SET TAGS ('dbx_business_glossary_term' = 'Affected Zones');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `boil_water_advisory_issued` SET TAGS ('dbx_business_glossary_term' = 'Boil Water Advisory Issued');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_number` SET TAGS ('dbx_business_glossary_term' = 'Break Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_number` SET TAGS ('dbx_value_regex' = '^MB-[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_status` SET TAGS ('dbx_business_glossary_term' = 'Break Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_status` SET TAGS ('dbx_value_regex' = 'reported|dispatched|in_progress|repaired|closed|deferred');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Break Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_type` SET TAGS ('dbx_business_glossary_term' = 'Break Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `break_type` SET TAGS ('dbx_value_regex' = 'circumferential|longitudinal|blowout|joint_failure|service_line_break|corrosion_pinhole');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `expected_restoration_at` SET TAGS ('dbx_business_glossary_term' = 'Expected Restoration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `expected_restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Restoration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `hydraulic_model_node_code` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Node Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_age_years` SET TAGS ('dbx_business_glossary_term' = 'Pipe Age (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Required');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `repair_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Repair Complete Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `repair_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Repair Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `repair_method` SET TAGS ('dbx_business_glossary_term' = 'Repair Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `repair_method` SET TAGS ('dbx_value_regex' = 'clamp|sleeve|pipe_replacement|joint_repair|valve_replacement|temporary_bypass');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `repair_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Repair Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `reported_by` SET TAGS ('dbx_value_regex' = 'customer|field_crew|scada_alert|patrol|third_party|internal_inspection');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `soil_condition` SET TAGS ('dbx_business_glossary_term' = 'Soil Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `traffic_impact` SET TAGS ('dbx_business_glossary_term' = 'Traffic Impact');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `traffic_impact` SET TAGS ('dbx_value_regex' = 'none|lane_closure|road_closure|detour_required|emergency_access_restricted');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `water_lost_gallons` SET TAGS ('dbx_business_glossary_term' = 'Water Lost (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_preventive' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_exercise_id` SET TAGS ('dbx_business_glossary_term' = 'Valve Exercise ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Valve ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_value_regex' = 'pass|fail|needs_repair|needs_replacement');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `deficiency_code` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `deficiency_noted` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Noted');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Exercise Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_direction` SET TAGS ('dbx_business_glossary_term' = 'Exercise Direction');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_direction` SET TAGS ('dbx_value_regex' = 'open|close|open_close_cycle');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_method` SET TAGS ('dbx_business_glossary_term' = 'Exercise Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_method` SET TAGS ('dbx_value_regex' = 'manual|powered|hydraulic');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Exercise Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|deferred|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `exercise_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exercise Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `final_position` SET TAGS ('dbx_business_glossary_term' = 'Final Position');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `final_position` SET TAGS ('dbx_value_regex' = 'open|closed|partially_open');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `final_position_percent` SET TAGS ('dbx_business_glossary_term' = 'Final Position Percent');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `leak_detected` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `leak_severity` SET TAGS ('dbx_business_glossary_term' = 'Leak Severity');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `leak_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|severe');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `operability_status` SET TAGS ('dbx_business_glossary_term' = 'Operability Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `operability_status` SET TAGS ('dbx_value_regex' = 'operable|inoperable|restricted');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `operating_nut_condition` SET TAGS ('dbx_business_glossary_term' = 'Operating Nut Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `operating_nut_condition` SET TAGS ('dbx_value_regex' = 'good|worn|damaged|missing');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `pressure_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `technician_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `torque_reading` SET TAGS ('dbx_business_glossary_term' = 'Torque Reading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `torque_unit` SET TAGS ('dbx_business_glossary_term' = 'Torque Unit');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `torque_unit` SET TAGS ('dbx_value_regex' = 'ft_lbs|nm');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `turns_to_close` SET TAGS ('dbx_business_glossary_term' = 'Turns to Close');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_box_condition` SET TAGS ('dbx_business_glossary_term' = 'Valve Box Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_box_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|missing');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_box_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Valve Box Depth Inches');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `valve_number` SET TAGS ('dbx_business_glossary_term' = 'Valve Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_fire_protection' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_hydraulics' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_testing' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `hydrant_flow_test_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Flow Test ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `tertiary_residual_hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Hydrant ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Test Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `available_flow_at_20psi_gpm` SET TAGS ('dbx_business_glossary_term' = 'Available Flow at 20 PSI (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'DMA (District Metered Area) Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `flushing_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Flushing Duration (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `hydrant_condition_observed` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Condition Observed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `hydraulic_model_updated` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Updated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `iso_fire_flow_adequacy` SET TAGS ('dbx_business_glossary_term' = 'ISO (Insurance Services Office) Fire Flow Adequacy');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `iso_fire_flow_adequacy` SET TAGS ('dbx_value_regex' = 'adequate|marginal|deficient');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `iso_rating_submitted` SET TAGS ('dbx_business_glossary_term' = 'ISO (Insurance Services Office) Rating Submitted');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `iso_submission_date` SET TAGS ('dbx_business_glossary_term' = 'ISO (Insurance Services Office) Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `model_update_date` SET TAGS ('dbx_business_glossary_term' = 'Model Update Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `nfpa_color_classification` SET TAGS ('dbx_business_glossary_term' = 'NFPA (National Fire Protection Association) Color Classification');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `nfpa_color_classification` SET TAGS ('dbx_value_regex' = 'class_aa_blue|class_a_green|class_b_orange|class_c_red|inadequate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `number_of_outlets_flowed` SET TAGS ('dbx_business_glossary_term' = 'Number of Outlets Flowed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `outlet_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Outlet Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `pitot_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pitot Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `pressure_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `residual_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Residual Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `static_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `technician_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'pitot_gauge|flow_meter|pressure_differential');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_time` SET TAGS ('dbx_business_glossary_term' = 'Test Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'routine|complaint|post_repair|new_installation|model_calibration|iso_rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `water_clarity` SET TAGS ('dbx_business_glossary_term' = 'Water Clarity');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `water_clarity` SET TAGS ('dbx_value_regex' = 'clear|slightly_turbid|turbid|discolored|sediment');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_water_quality' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_operations' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flushing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Flushing Event Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Segment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `turbidity_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Reading Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `discharge_point_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `discharge_point_type` SET TAGS ('dbx_value_regex' = 'fire_hydrant|blow_off_valve|air_release_valve|service_connection');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^DMA-[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Flush Duration in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_date` SET TAGS ('dbx_business_glossary_term' = 'Flush Execution Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Flush Effectiveness Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flush End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_number` SET TAGS ('dbx_business_glossary_term' = 'Flush Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_number` SET TAGS ('dbx_value_regex' = '^FLU-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_reason` SET TAGS ('dbx_business_glossary_term' = 'Flush Reason');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_reason` SET TAGS ('dbx_value_regex' = 'routine_maintenance|water_quality_complaint|discoloration_event|low_chlorine|biofilm_control|new_main_commissioning');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flush Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_status` SET TAGS ('dbx_business_glossary_term' = 'Flush Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flush_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flushing_method` SET TAGS ('dbx_business_glossary_term' = 'Flushing Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flushing_method` SET TAGS ('dbx_value_regex' = 'conventional|unidirectional|UDF|hydrant_blow_off|air_scouring|ice_pigging');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Flushing Event Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `post_flush_chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Post-Flush Chlorine Residual in Milligrams Per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `pre_flush_chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Pre-Flush Chlorine Residual in Milligrams Per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `pressure_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `pressure_zone_code` SET TAGS ('dbx_value_regex' = '^PZ-[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `public_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `traffic_control_required` SET TAGS ('dbx_business_glossary_term' = 'Traffic Control Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `volume_discharged_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Discharged in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `water_quality_sample_collected` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Sample Collected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_modeling' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_hydraulics' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_engineering' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `hydraulic_model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Run Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `consumption_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consumption Profile Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `analyst_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `average_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `boundary_conditions` SET TAGS ('dbx_business_glossary_term' = 'Boundary Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_calibrated|preliminary|calibrated|validated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `convergence_achieved` SET TAGS ('dbx_business_glossary_term' = 'Convergence Achieved Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `convergence_iterations` SET TAGS ('dbx_business_glossary_term' = 'Convergence Iterations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `demand_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Demand Multiplier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `fire_flow_available_gpm` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Available (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `gis_model_sync_date` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Model Synchronization Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `maximum_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `maximum_velocity_fps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Velocity (FPS - Feet per Second)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `minimum_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `minimum_velocity_fps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Velocity (FPS - Feet per Second)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `output_file_path` SET TAGS ('dbx_business_glossary_term' = 'Output File Path');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `pressure_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Pressure Violations Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `pump_energy_kwh` SET TAGS ('dbx_business_glossary_term' = 'Pump Energy Consumption (kWh - Kilowatt-Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `run_purpose` SET TAGS ('dbx_business_glossary_term' = 'Run Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `scada_data_source` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'steady_state|extended_period_simulation|fire_flow|water_quality|emergency_response|capacity_planning');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `simulation_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Simulation Duration (Seconds)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `simulation_end_time` SET TAGS ('dbx_business_glossary_term' = 'Simulation End Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `simulation_start_time` SET TAGS ('dbx_business_glossary_term' = 'Simulation Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `system_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'System Demand (MGD - Million Gallons per Day)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `tank_level_variation_feet` SET TAGS ('dbx_business_glossary_term' = 'Tank Level Variation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `time_step_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Step (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `total_head_loss_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Head Loss (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `velocity_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Velocity Violations Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_incident' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_emergency' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_operations' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_customer_impact' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `network_isolation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Network Isolation Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `encumbrance_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Supervisor ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `network_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Supervisor ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `network_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `network_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `network_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `quality_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `affected_zones` SET TAGS ('dbx_business_glossary_term' = 'Affected Zones');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `boil_water_advisory_issued` SET TAGS ('dbx_business_glossary_term' = 'Boil Water Advisory Issued Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `critical_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Critical Customers Affected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `estimated_water_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Water Loss (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `expected_restoration_at` SET TAGS ('dbx_business_glossary_term' = 'Expected Restoration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `expected_restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Restoration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `flushing_performed` SET TAGS ('dbx_business_glossary_term' = 'Flushing Performed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `gis_isolation_boundary` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Isolation Boundary');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `hydraulic_model_verified` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_area_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Isolation Area Length (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Isolation Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_number` SET TAGS ('dbx_business_glossary_term' = 'Isolation Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_number` SET TAGS ('dbx_value_regex' = '^ISO-[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_reason` SET TAGS ('dbx_business_glossary_term' = 'Isolation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_status` SET TAGS ('dbx_business_glossary_term' = 'Isolation Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|isolated|restoring|restored|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Event Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Isolation Event Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Notification Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `pipe_segments_isolated` SET TAGS ('dbx_business_glossary_term' = 'Pipe Segments Isolated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `premises_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Premises Affected Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `pressure_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Pressure Impact Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Isolation Priority');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `restoration_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Restoration Confirmed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `restoration_confirmed_by` SET TAGS ('dbx_business_glossary_term' = 'Restoration Confirmed By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `restoration_confirmed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Restoration Confirmed Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `scada_monitoring_active` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitoring Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `valve_count` SET TAGS ('dbx_business_glossary_term' = 'Valve Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `valves_operated` SET TAGS ('dbx_business_glossary_term' = 'Valves Operated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `water_quality_testing_required` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Testing Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_condition' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_inspection' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Condition Assessment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `encumbrance_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_end_time` SET TAGS ('dbx_business_glossary_term' = 'Assessment End Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Assessment Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'CCTV|acoustic|electromagnetic|visual|ultrasonic|other');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_start_time` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `contractor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `defect_types_identified` SET TAGS ('dbx_business_glossary_term' = 'Defect Types Identified');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `internal_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Internal Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `overall_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_length_assessed_feet` SET TAGS ('dbx_business_glossary_term' = 'Pipe Length Assessed (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `pipe_number` SET TAGS ('dbx_business_glossary_term' = 'Pipe Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'monitor|rehabilitate|replace|urgent_repair|no_action');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `recommended_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action Priority');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `recommended_action_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `structural_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Structural Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `technician_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_association_edges' = 'distribution.dma,workforce.crew');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_workforce' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_operations' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `dma_crew_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'DMA Crew Coverage Assignment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Crew Coverage - Crew Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Crew Coverage - Dma Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `after_hours_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Responsibility Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment End Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type Classification');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `dma_crew_coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `response_priority` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_association_edges' = 'distribution.pipe_main,supply.procurement_contract');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_procurement' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_supply' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_materials' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `pipe_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Procurement Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Procurement - Pipe Main Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Procurement - Procurement Contract Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `contract_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `installation_specification` SET TAGS ('dbx_business_glossary_term' = 'Installation Specification Reference');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `material_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `total_line_value` SET TAGS ('dbx_business_glossary_term' = 'Total Line Value');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_association_edges' = 'distribution.pressure_zone,workforce.employee');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_workforce' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_operations' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `zone_operator_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Operator Assignment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Operator Assignment - Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Operator Assignment - Pressure Zone Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `certification_level_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `last_coverage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Coverage Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `on_call_rotation_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Call Rotation Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `operator_role` SET TAGS ('dbx_business_glossary_term' = 'Operator Role');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `primary_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Backup Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `rotation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rotation Sequence Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` SET TAGS ('dbx_maintenance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `maintenance_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Zone Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `hydraulic_model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Run Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `parent_maintenance_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Maintenance Zone Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `parent_maintenance_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Area Sq Km');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `average_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Flow Gpm');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `average_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average Pressure Psi');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `maintenance_priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `maintenance_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Hours');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `maintenance_zone_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_nrw' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_water_loss' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_program' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_performance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `nrw_program_id` SET TAGS ('dbx_business_glossary_term' = 'Nrw Program Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `predecessor_nrw_program_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Nrw Program Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `actual_nrw_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Nrw Reduction Percent');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `actual_nrw_reduction_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Actual Nrw Reduction Volume Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `nrw_program_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `program_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `target_nrw_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Nrw Reduction Percent');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `target_nrw_reduction_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Target Nrw Reduction Volume Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` SET TAGS ('dbx_hydraulics' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` SET TAGS ('dbx_modeling' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_upstream_node_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Node Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_upstream_node_id` SET TAGS ('dbx_self_ref_role' = 'upstream');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `primary_pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Network Zone Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `primary_upstream_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Network Node Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `asset_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Stage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `asset_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Asset Value Usd');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `diameter_in` SET TAGS ('dbx_business_glossary_term' = 'Diameter In');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation M');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Capacity Gpm');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Gpm');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `length_m` SET TAGS ('dbx_business_glossary_term' = 'Length M');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `maintenance_priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Psi');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating Psi');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_node_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `water_quality_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Monitoring');
