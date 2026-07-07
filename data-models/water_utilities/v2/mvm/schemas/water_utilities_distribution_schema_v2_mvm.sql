-- Schema for Domain: distribution | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`distribution` COMMENT 'Owns the potable water distribution network topology, hydraulic modeling, and operational data including mains, service lines, valves, PRVs, hydrants, pump stations, storage tanks, DMAs, and pressure zones. Integrates with Esri ArcGIS and Innovyze InfoWater for network modeling, NRW/UFW analysis, and pressure (PSI) and flow (GPM/MGD) management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` (
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the pipe main referenced by each pipe main record in the distribution domain.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each pipe main record in the distribution domain.',
    `dma_id` BIGINT COMMENT 'Unique identifier for the dma referenced by each pipe main record in the distribution domain.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Pipe mains have scheduled maintenance programs (cathodic protection checks, condition inspections, flushing). Linking pipe_main to its PM schedule enables automated work order generation and complianc',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Shutoff/reconnect field operations and consumption billing require direct linkage from the physical service line to its billing account. Enables account lookup from GIS field tools and supports servic',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: service_line currently stores dma_code as a plain STRING column, which is a denormalized reference to the dma entity. The dma table has a dma_code attribute (dma.dma_code) that is the authoritative co',
    `meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each service line record in the distribution domain.',
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the pipe main referenced by each service line record in the distribution domain.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Under LCRR (Lead and Copper Rule Revisions), service lines — especially lead lines — require scheduled inspection and replacement programs. Linking service_line to a PM schedule supports regulatory co',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: service_line currently stores pressure_zone_code as a plain STRING column, which is a denormalized reference to the pressure_zone entity. The pressure_zone table has a zone_code attribute (pressure_zo',
    `city` STRING COMMENT 'The city component of the address for each service line record.',
    `connection_status` STRING COMMENT 'The connection status value recorded for each service line in the distribution domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each service line record in the distribution domain.',
    `curb_stop_installed` BOOLEAN COMMENT 'The curb stop installed value recorded for each service line in the distribution domain.',
    `curb_stop_location` STRING COMMENT 'The curb stop location value recorded for each service line in the distribution domain.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'The diameter inches value recorded for each service line in the distribution domain.',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Each pressure zone is primarily served by a treatment facility. This link is required for hydraulic model calibration, treatment permit coverage mapping, and water quality zone delineation. Role-prefi',
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
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone within which this DMA operates. Pressure zones define areas of similar hydraulic pressure managed by Pressure Reducing Valves (PRVs) and pump stations. Ref: OSIsoft PI Historian.',
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
    `registry_id` BIGINT COMMENT 'Reference to the asset registry record in the Computerized Maintenance Management System (CMMS). Links this valve to IBM Maximo Asset Management for maintenance tracking, work orders, and lifecycle management.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the water main on which this valve is installed. Links the valve to the pipe segment for network topology modeling in Esri ArcGIS and Innovyze InfoWater. Ref: OSIsoft PI Historian.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: AWWA M44 and regulatory standards require periodic valve exercising programs. network_valve has exercising_frequency_months as a plain attribute but no link to the formal PM schedule that drives work ',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which this valve is located. Pressure zones are geographic areas maintained at specific pressure ranges (measured in Pounds per Square Inch - PSI) to ensure adequate service and prevent pipe bursts. Critical for hydraulic modeling in Innovyze InfoWater. Ref: OSIsoft PI Historian.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` (
    `hydrant_id` BIGINT COMMENT 'Unique identifier for the fire hydrant asset in the distribution network. Primary key. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) to which the hydrant belongs, used for Non-Revenue Water (NRW) analysis and leak detection programs. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Identifier of the nearest or connected water main pipe from which the hydrant is fed, used for hydraulic modeling and network topology analysis. Ref: OSIsoft PI Historian.',
    `hydrant_pipe_main_id` BIGINT COMMENT 'Identifier of the nearest or connected water main pipe from which the hydrant is fed, used for hydraulic modeling and network topology analysis. Ref: OSIsoft PI Historian.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: NFPA 291 and ISO 9001 require annual hydrant flow testing and flushing programs. hydrant has flushing_program_flag and last_flushing_date as plain attributes but no link to the formal PM schedule. Thi',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone or hydraulic district in which the hydrant is located, used for pressure management and network segmentation. Ref: OSIsoft PI Historian.',
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
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Pump stations require operating permits (air permits for emergency generators, state operating permits, NPDES discharge permits). Compliance managers track permit coverage per pump station for regulat',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) that this pump station serves for NRW and UFW analysis. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Pump stations receive finished water from treatment facilities. This link is essential for hydraulic modeling, chlorine residual decay tracking from treatment to distribution, and regulatory water qua',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Pump stations are fixed facilities managed in the asset location hierarchy for access management, spatial queries, and facility planning. Linking pump_station to asset.location normalizes the address ',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Pump stations have dedicated bulk flow meters on discharge lines for energy efficiency reporting, NRW accounting, and SCADA integration. Utilities track which metering_meter measures pump station outp',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Pump stations require formal preventive maintenance schedules (pump testing, mechanical inspections, generator testing). This FK links each pump station to its governing PM schedule, enabling automate',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone served by this pump station for hydraulic modeling and network segmentation. Ref: OSIsoft PI Historian.',
    `asset_condition_rating` STRING COMMENT 'Current condition assessment rating of the pump station based on inspection and maintenance records. Ref: OSIsoft PI Historian.. Valid values are `excellent|good|fair|poor|critical`',
    `backup_generator_available` BOOLEAN COMMENT 'Indicates whether the pump station has a backup generator for emergency power supply. Ref: OSIsoft PI Historian.',
    `backup_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Capacity of the backup generator in kilowatts (kW) if available. Ref: OSIsoft PI Historian.',
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
    `power_supply_phase` STRING COMMENT 'Electrical power supply phase configuration for the pump station. Ref: OSIsoft PI Historian.. Valid values are `single_phase|three_phase`',
    `power_supply_voltage` STRING COMMENT 'Electrical power supply voltage specification for the pump station (e.g., 480V, 4160V). Ref: OSIsoft PI Historian.',
    `scada_integrated` BOOLEAN COMMENT 'Indicates whether the pump station is integrated with the SCADA system for remote monitoring and control. Ref: OSIsoft PI Historian.',
    `scada_tag_prefix` STRING COMMENT 'Prefix used for SCADA tags associated with this pump station in the OSIsoft PI Historian system.',
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
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Storage tanks require regulatory permits (state sanitary survey permits, inspection permits). storage_tank.regulatory_inspection_status confirms regulatory oversight exists. Compliance staff track whi',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Storage tanks are fixed facilities in the asset location hierarchy, supporting access management, emergency response planning, and spatial asset queries. Linking storage_tank to asset.location integra',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Storage tanks require dedicated inlet/outlet flow meters for NRW/UFW accounting and regulatory compliance reporting. Utilities track which metering_meter measures tank throughput as an asset managemen',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Storage tanks require regulatory inspection schedules (AWWA D100, state drinking water regulations mandate periodic cleaning and structural inspection). This FK links each tank to its PM schedule, ena',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone served by this storage tank. Pressure zones are geographic areas of the distribution network maintained at similar hydraulic pressure ranges. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that this storage tank serves. DMAs are discrete zones used for water balance analysis and Non-Revenue Water (NRW) management. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Storage tanks receive treated water from a specific treatment facility. This link supports water age tracking, DBP (TTHM/HAA5) compliance reporting, and finished water quality audits. Role-prefix sou',
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
    `meter_id` BIGINT COMMENT 'Reference to the specific flow meter device that captured this reading. Links to asset registry for meter calibration history and maintenance records. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: flow_reading captures measurements from inline flow meters installed on distribution mains. pipe_main has average_daily_flow_gpm and max_flow_capacity_gpm attributes that are derived from flow reading',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: flow_reading captures time-series flow measurements at pump stations (booster stations) as explicitly stated in the product description. Adding pump_station_id FK allows direct linkage of a flow readi',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: flow_reading captures time-series flow measurements at storage tank inlet/outlet points. storage_tank has scada_flow_meter_tag, scada_level_sensor_tag, and scada_pressure_sensor_tag indicating SCADA-m',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` (
    `leak_detection_survey_id` BIGINT COMMENT 'Unique identifier for the leak detection survey record. Primary key. Ref: OSIsoft PI Historian.',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: Leak survey findings inform asset condition grades, remaining useful life estimates, and repair/replace decisions. Direct linkage supports proactive asset management and CIP prioritization in water ut. Ref: OSIsoft PI Historian.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) in which the surveyed pipe segment is located, used for Non-Revenue Water (NRW) analysis. Ref: OSIsoft PI Historian.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Leak detection surveys are a formal type of inspection event in asset management systems. Linking leak_detection_survey to inspection_event enables unified inspection reporting, regulatory submission ',
    `pipe_main_id` BIGINT COMMENT 'Reference to the specific distribution main or service line segment that was surveyed for leaks. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which the surveyed pipe segment operates. Ref: OSIsoft PI Historian.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Leak detection surveys are mandated by regulatory requirements (EPA water loss control rules, state NRW reporting mandates). Compliance managers must demonstrate survey frequency meets the specific re',
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
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the break occurred. Used for NRW (Non-Revenue Water) and UFW (Unaccounted-for Water) analysis. Ref: OSIsoft PI Historian.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the distribution main pipe asset where the break occurred. Links to the distribution main asset registry. Ref: OSIsoft PI Historian.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone where the break occurred. Critical for hydraulic modeling and pressure management analysis. Ref: OSIsoft PI Historian.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_hydrant_pipe_main_id` FOREIGN KEY (`hydrant_pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Water Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Pipe Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `hydrant_pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Pipe Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_available` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Available');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Capacity in Kilowatts (kW)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_phase` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Phase');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_phase` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_voltage` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `scada_integrated` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integrated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_subdomain' = 'operations_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `flow_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Reading Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_subdomain' = 'operations_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_detection_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Survey Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Segment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_subdomain' = 'operations_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
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
