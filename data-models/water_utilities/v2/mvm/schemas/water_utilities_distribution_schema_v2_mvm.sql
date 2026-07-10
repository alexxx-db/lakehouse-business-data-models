-- Schema for Domain: distribution | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`distribution` COMMENT 'Owns the potable water distribution network topology, hydraulic modeling, and operational data including mains, service lines, valves, PRVs, hydrants, pump stations, storage tanks, DMAs, and pressure zones. Integrates with Esri ArcGIS and Innovyze InfoWater for network modeling, NRW/UFW analysis, and pressure (PSI) and flow (GPM/MGD) management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` (
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the potable water distribution main. Primary key for the pipe main master record.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Water mains are capital assets requiring depreciation tracking, GASB reporting, and rate base valuation. Essential for annual financial statements, regulatory asset reporting, and rate case filings.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) to which this pipe main is assigned. DMAs are isolated network zones used for water balance analysis, non-revenue water (NRW) detection, and leak management.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which this pipe main operates. Pressure zones are geographic areas maintained at specific pressure ranges (PSI) to ensure adequate service and prevent over-pressurization.',
    `asset_owner` STRING COMMENT 'Legal owner of the pipe main asset. Typically the water utility, but may be a municipality, private developer, or other entity. Important for maintenance responsibility and capital planning.',
    `average_daily_flow_gpm` DECIMAL(18,2) COMMENT 'Average daily flow through the pipe main in gallons per minute (GPM), typically derived from SCADA flow meters or hydraulic model calibration. Used for demand analysis and capacity utilization assessment.',
    `bedding_type` STRING COMMENT 'Type of bedding material and installation method used to support the pipe main in the trench. Common types include sand, gravel, crushed stone, and controlled low-strength material (CLSM). Affects pipe structural integrity and longevity.',
    `break_history_count` STRING COMMENT 'Total number of main breaks or failures recorded for this pipe main since installation. High break counts indicate poor condition and prioritize replacement. Used for reliability analysis and risk assessment.',
    `cathodic_protection_flag` BOOLEAN COMMENT 'Indicates whether the pipe main is protected by a cathodic protection system to prevent corrosion. True if cathodic protection is installed and active; false otherwise. Primarily applicable to metallic pipes (ductile iron, steel).',
    `coating_type` STRING COMMENT 'Exterior coating material applied to the pipe main to protect against soil corrosion and environmental degradation. Common coatings include polyethylene wrap, epoxy, and zinc.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipe main record was first created in the system. Used for data lineage and audit trail.',
    `depth_feet` DECIMAL(18,2) COMMENT 'Depth of the pipe main below ground surface in feet, measured to the pipe crown. Affects frost protection, traffic load resistance, and excavation cost for repairs.',
    `downstream_node_code` STRING COMMENT 'Identifier of the downstream hydraulic node (junction, tank, reservoir, or pump) in the distribution network topology. Used for hydraulic modeling in Innovyze InfoWater and network connectivity analysis.',
    `fire_flow_capable_flag` BOOLEAN COMMENT 'Indicates whether the pipe main is sized and pressurized to provide adequate fire flow per AWWA and Insurance Services Office (ISO) standards. True if the main meets fire flow requirements; false otherwise.',
    `gis_feature_code` STRING COMMENT 'Unique identifier for the pipe main feature in the Esri ArcGIS spatial database. Links the asset record to its geographic representation for mapping, spatial analysis, and field operations.',
    `gis_geometry_wkt` STRING COMMENT 'Well-Known Text (WKT) representation of the pipe main centerline geometry (LINESTRING). Captures the spatial path of the pipe for GIS integration, routing, and proximity analysis.',
    `hazen_williams_c_factor` DECIMAL(18,2) COMMENT 'Hazen-Williams roughness coefficient (C-factor) used in hydraulic modeling to represent pipe friction and head loss. New pipes typically have C=130-140; older or corroded pipes may have C=80-100. Used in Innovyze InfoWater hydraulic models.',
    `installation_date` DATE COMMENT 'Date when the pipe main was installed and placed into service. Used for age-based condition assessment, remaining useful life calculations, and capital improvement planning (CIP).',
    `installation_year` STRING COMMENT 'Year the pipe main was installed. Commonly used for age-based analysis and replacement prioritization when exact installation date is unknown.',
    `joint_type` STRING COMMENT 'Type of joint used to connect pipe segments. Common types include push-on, mechanical joint, flanged, welded, and restrained joint. Joint type affects installation cost, seismic resilience, and leak risk.',
    `last_break_date` DATE COMMENT 'Date of the most recent main break or failure event on this pipe main. Used for failure trend analysis and to assess time since last incident.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the pipe main. Used to track inspection compliance and schedule future inspections per preventive maintenance (PM) schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipe main record was last updated. Used for change tracking and data quality monitoring.',
    `length_feet` DECIMAL(18,2) COMMENT 'Physical length of the pipe main segment in feet, measured from upstream to downstream node. Used for network inventory, hydraulic modeling, and asset valuation.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the pipe main in its asset lifecycle. Active pipes are in service; planned pipes are in design or budgeted; abandoned pipes are no longer used but not removed.. Valid values are `active|inactive|abandoned|planned|under_construction|retired`',
    `lining_type` STRING COMMENT 'Interior lining material applied to the pipe main to prevent corrosion and maintain water quality. Common linings include cement mortar, epoxy, polyurethane, and polyethylene. Critical for compliance with Safe Drinking Water Act (SDWA) and Lead and Copper Rule Revisions (LCRR).',
    `maintenance_responsibility` STRING COMMENT 'Entity responsible for operations and maintenance (O&M) of the pipe main. May differ from asset owner in cases of shared infrastructure or developer-owned systems pending transfer.. Valid values are `utility|municipality|private|shared`',
    `material` STRING COMMENT 'Material composition of the pipe main. Common materials include ductile iron (DI), polyvinyl chloride (PVC), high-density polyethylene (HDPE), cast iron (CI), and steel. Material affects durability, corrosion resistance, and hydraulic performance. [ENUM-REF-CANDIDATE: ductile_iron|pvc|hdpe|cast_iron|concrete|steel|copper|galvanized_steel|asbestos_cement — 9 candidates stripped; promote to reference product]',
    `max_flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum hydraulic flow capacity of the pipe main in gallons per minute (GPM) under design conditions. Calculated based on diameter, pressure, and Hazen-Williams C-factor. Used for capacity planning and fire flow analysis.',
    `nominal_diameter_inches` DECIMAL(18,2) COMMENT 'Nominal inside diameter of the pipe main in inches. Standard sizes range from 2 inches for service lines to 72+ inches for transmission mains. Critical for hydraulic capacity and flow (GPM/MGD) calculations.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the pipe main. May include historical information, operational constraints, or field observations.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Typical operating pressure in pounds per square inch (PSI) at which the pipe main operates under normal conditions. Used for hydraulic analysis and to ensure adequate service pressure (typically 40-80 PSI at customer meters).',
    `pipe_number` STRING COMMENT 'Business identifier for the pipe main, typically assigned by the utility for asset tracking and field reference. May follow utility-specific numbering conventions.',
    `pipe_type` STRING COMMENT 'Classification of the pipe main by its function in the water distribution system. Transmission mains convey large volumes between facilities; distribution mains serve neighborhoods; service laterals connect to premises.. Valid values are `transmission|distribution|service_lateral|fire_line|raw_water|reclaimed`',
    `pressure_class_psi` STRING COMMENT 'Rated working pressure class of the pipe main in pounds per square inch (PSI). Common classes include 150, 200, 250, 300 PSI. Must meet or exceed the operating pressure of the assigned pressure zone.',
    `street_name` STRING COMMENT 'Name of the street or roadway where the pipe main is located. Used for field crew dispatch, work order management, and public communication during maintenance or repairs.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or contractor warranty for the pipe main expires. Used for warranty claim management and defect tracking.',
    CONSTRAINT pk_pipe_main PRIMARY KEY(`pipe_main_id`)
) COMMENT 'Master record for potable water distribution mains including transmission mains and distribution mains. Captures pipe material (ductile iron, PVC, HDPE, cast iron), nominal diameter, installation year, pressure class, lining type, coating type, operating pressure zone, DMA assignment, GIS geometry (from Esri ArcGIS), Innovyze InfoWater model node references, condition grade, and lifecycle status. SSOT for distribution pipe inventory.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` (
    `service_line_id` BIGINT COMMENT 'Unique identifier for the individual customer service connection from the distribution main to the meter setter. Primary key for service line records.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Service lines are capitalized infrastructure requiring depreciation and asset valuation, especially critical for LCRR lead replacement cost tracking and capital improvement planning in rate cases.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Service connections operate under utility permits. LCRR compliance requires linking service lines to permit conditions for lead/copper monitoring, material inventory reporting, and replacement program',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: LCRR (Lead and Copper Rule Revisions) mandates condition assessments of service lines for lead pipe identification and replacement prioritization. Direct FK to condition_assessment enables regulatory ',
    `criticality_rating_id` BIGINT COMMENT 'Foreign key linking to asset.criticality_rating. Business justification: LCRR replacement prioritization requires formal criticality ratings for service lines, incorporating public health impact (lead exposure risk), customer vulnerability, and failure likelihood. Direct F',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service lines belong to a District Metered Area (DMA) for NRW/UFW leakage analysis, pressure monitoring, and LCRR compliance tracking. The existing dma_code STRING column is a denormalized reference t',
    `meter_id` BIGINT COMMENT 'Reference to the water meter installed at the terminus of this service line for consumption measurement.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Each service line originates from a distribution main; linking to pipe_main provides a parent relationship and eliminates the need for storing pipe_main details redundantly.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service lines operate within a specific hydraulic pressure zone, which is critical for LCRR lead service line inventory management, pressure compliance reporting, and hydraulic modeling calibration. T',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: LCRR requires address-level service line material inventory. A direct FK from service_line to service_address enables address-based LCRR compliance queries without joining through premise, and elimina',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Lead service line replacement programs (LCRR compliance) are tracked as CIP projects. Each service line replacement requires project attribution for cost tracking, grant reimbursement, regulatory repo',
    `connection_status` STRING COMMENT 'Current operational status of the service line connection indicating whether it is actively serving a customer or has been deactivated.. Valid values are `active|inactive|abandoned|disconnected|pending_activation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was first created in the system.',
    `curb_stop_installed` BOOLEAN COMMENT 'Indicates whether a curb stop shutoff valve is installed on the service line for isolation purposes.',
    `curb_stop_location` STRING COMMENT 'Descriptive location of the curb stop valve for field crew reference during service shutoff operations.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the service line pipe measured in inches. Typical residential service lines range from 0.75 to 2.0 inches.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier in the Esri ArcGIS system linking this service line record to the corresponding GIS spatial feature.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the service line connection point in decimal degrees for GIS mapping and spatial analysis.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the service line connection point in decimal degrees for GIS mapping and spatial analysis.',
    `installation_date` DATE COMMENT 'Date when the service line was originally installed and connected to the distribution main.',
    `installation_year` STRING COMMENT 'Year of service line installation. Used for age-based risk assessment and replacement prioritization when exact installation date is unknown.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or condition assessment of the service line.',
    `last_leak_repair_date` DATE COMMENT 'Date of the most recent leak repair performed on this service line.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was most recently updated.',
    `lcrr_classification` STRING COMMENT 'EPA LCRR regulatory classification of service line material status for lead service line inventory and replacement planning. Mandatory for LCRR compliance reporting.. Valid values are `lead|lead_status_unknown|galvanized_requiring_replacement|non_lead`',
    `lcrr_inventory_verified` BOOLEAN COMMENT 'Indicates whether the service line material classification has been physically verified for LCRR compliance inventory accuracy.',
    `lcrr_verification_date` DATE COMMENT 'Date when the service line material was physically verified for LCRR inventory compliance.',
    `lcrr_verification_method` STRING COMMENT 'Method used to verify the service line material classification for LCRR compliance.. Valid values are `visual_inspection|excavation|records_review|predictive_modeling|customer_survey`',
    `leak_history_count` STRING COMMENT 'Total number of documented leak incidents on this service line since installation. Used for reliability assessment and replacement prioritization.',
    `length_feet` DECIMAL(18,2) COMMENT 'Total measured length of the service line from the distribution main tap to the meter setter, measured in feet.',
    `material_type` STRING COMMENT 'Material composition of the service line pipe. Critical for Lead and Copper Rule Revisions (LCRR) compliance and corrosion risk assessment. [ENUM-REF-CANDIDATE: lead|galvanized_steel|copper|polyethylene|pvc|hdpe|unknown — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or historical information about the service line.',
    `ownership_type` STRING COMMENT 'Designation of ownership responsibility for the service line. Determines maintenance and replacement liability between utility and property owner.. Valid values are `utility_owned|customer_owned|shared|unknown`',
    `replacement_method` STRING COMMENT 'Planned or executed method for service line replacement. Trenchless methods minimize surface disruption.. Valid values are `open_cut|trenchless|directional_drill|pipe_bursting|not_applicable`',
    `replacement_priority_score` STRING COMMENT 'Calculated priority score for service line replacement based on age, material, leak history, and LCRR compliance requirements. Higher scores indicate higher replacement urgency.',
    `service_line_number` STRING COMMENT 'Business identifier or tag number assigned to the service connection for field operations and customer reference.',
    `service_type` STRING COMMENT 'Classification of the service line based on customer type and usage category.. Valid values are `residential|commercial|industrial|municipal|fire_service|irrigation`',
    `tap_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the tap connection point on the distribution main where the service line originates, measured in inches.',
    CONSTRAINT pk_service_line PRIMARY KEY(`service_line_id`)
) COMMENT 'Master record for individual customer service connections from the distribution main to the meter setter, including material (lead, galvanized, copper, HDPE), diameter, installation year, length, LCRR material classification (lead, non-lead, unknown), GIS coordinates, pressure zone, and connection status. Critical for Lead and Copper Rule Revisions (LCRR) compliance inventory. Links to meter and customer account in respective domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` (
    `pressure_zone_id` BIGINT COMMENT 'Unique identifier for the pressure zone within the distribution network. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Pressure zones are operational units subject to permit conditions for minimum pressure requirements, water quality monitoring locations, and disinfection residual compliance. Permit conditions specify',
    `facility_id` BIGINT COMMENT 'Identifier of the primary storage tank or reservoir that serves this pressure zone, providing hydraulic head and emergency storage.',
    `arcgis_feature_code` STRING COMMENT 'Corresponding feature identifier in the Esri ArcGIS Geographic Information System (GIS) for spatial representation and network topology management.',
    `average_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Average daily water demand in Million Gallons per Day (MGD) for the pressure zone, used for capacity planning and hydraulic modeling.',
    `average_elevation_ft` DECIMAL(18,2) COMMENT 'Average ground elevation in feet above sea level across the pressure zone, used for hydraulic modeling and demand allocation.',
    `boundary_description` STRING COMMENT 'Textual description of the geographic or infrastructure boundaries defining the pressure zone, including major streets, landmarks, or infrastructure features.',
    `commissioning_date` DATE COMMENT 'Date when the pressure zone was officially commissioned and placed into active service for water distribution operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pressure zone record was first created in the system, used for audit trail and data lineage tracking.',
    `customer_count` STRING COMMENT 'Total number of active customer service connections within the pressure zone, used for demand forecasting and revenue allocation.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Design or nominal operating pressure in Pounds per Square Inch (PSI) for which the zone infrastructure was engineered and constructed.',
    `elevation_max_ft` DECIMAL(18,2) COMMENT 'Maximum ground elevation in feet above sea level within the pressure zone boundary, critical for pressure management and PRV settings.',
    `elevation_min_ft` DECIMAL(18,2) COMMENT 'Minimum ground elevation in feet above sea level within the pressure zone boundary, used for hydraulic gradient calculations.',
    `fire_flow_capacity_gpm` STRING COMMENT 'Minimum fire flow capacity in Gallons per Minute (GPM) that the pressure zone must maintain at specified residual pressure for fire protection, per Insurance Services Office (ISO) and NFPA standards.',
    `hydraulic_model_last_calibrated_date` DATE COMMENT 'Date when the hydraulic model for this pressure zone was last calibrated against field measurements, ensuring model accuracy for planning and operational decisions.',
    `infowater_model_zone_code` STRING COMMENT 'Corresponding pressure zone identifier in the Innovyze InfoWater hydraulic model, used for synchronization between operational systems and modeling platforms.',
    `last_boundary_review_date` DATE COMMENT 'Date when the pressure zone boundaries were last reviewed and validated for accuracy, typically as part of GIS updates or hydraulic model recalibration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pressure zone record was last modified, used for audit trail, change tracking, and data synchronization.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special considerations, historical context, or other relevant information about the pressure zone.',
    `nrw_percentage` DECIMAL(18,2) COMMENT 'Percentage of Non-Revenue Water (NRW) within the pressure zone, calculated as the difference between water supplied and billed consumption, used for loss control and efficiency analysis.',
    `operational_status` STRING COMMENT 'Current operational state of the pressure zone indicating whether it is actively serving customers, temporarily inactive, under maintenance, in emergency mode, or in planned development.. Valid values are `active|inactive|maintenance|emergency|planned`',
    `peak_hour_demand_mgd` DECIMAL(18,2) COMMENT 'Peak hourly water demand in Million Gallons per Day (MGD) for the pressure zone, critical for sizing infrastructure and ensuring adequate pressure during high-demand periods.',
    `residual_pressure_fire_psi` DECIMAL(18,2) COMMENT 'Minimum residual pressure in Pounds per Square Inch (PSI) that must be maintained during fire flow conditions to ensure adequate service to other customers and fire suppression effectiveness.',
    `scada_zone_tag` STRING COMMENT 'SCADA system tag or point identifier for real-time monitoring of pressure, flow, and operational status within this zone via OSIsoft PI Historian or similar SCADA platforms.',
    `service_area_sq_mi` DECIMAL(18,2) COMMENT 'Geographic area in square miles covered by the pressure zone, used for demand density calculations and infrastructure planning.',
    `storage_capacity_mg` DECIMAL(18,2) COMMENT 'Total storage capacity in Million Gallons (MG) of all tanks and reservoirs serving the pressure zone, used for emergency supply and pressure stabilization.',
    `target_pressure_max_psi` DECIMAL(18,2) COMMENT 'Maximum target operating pressure in Pounds per Square Inch (PSI) to prevent infrastructure damage, excessive leakage, and customer service issues.',
    `target_pressure_min_psi` DECIMAL(18,2) COMMENT 'Minimum target operating pressure in Pounds per Square Inch (PSI) that must be maintained throughout the zone to ensure adequate service delivery and regulatory compliance.',
    `ufw_percentage` DECIMAL(18,2) COMMENT 'Percentage of Unaccounted-for Water (UFW) within the pressure zone, representing water losses that cannot be attributed to known uses, critical for leak detection and infrastructure assessment.',
    `zone_code` STRING COMMENT 'Unique alphanumeric code or identifier for the pressure zone used in GIS, SCADA, and hydraulic modeling systems.',
    `zone_name` STRING COMMENT 'Business name or designation of the pressure zone used for operational reference and communication.',
    `zone_type` STRING COMMENT 'Classification of the pressure zone based on the primary method of pressure maintenance: gravity-fed from elevated storage, pumped from pump stations, combination of both, elevated tank-fed, or booster zone.. Valid values are `gravity|pumped|combination|elevated|booster`',
    CONSTRAINT pk_pressure_zone PRIMARY KEY(`pressure_zone_id`)
) COMMENT 'Master record defining hydraulic pressure zones within the distribution network. Captures zone name, target operating pressure range (PSI min/max), design pressure, elevation range, boundary description, associated storage facilities, PRV stations controlling the zone, and Innovyze InfoWater hydraulic model zone reference. Used for pressure management, NRW analysis, and DMA boundary definition.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`dma` (
    `dma_id` BIGINT COMMENT 'Unique identifier for the District Metered Area. Primary key for the DMA master record.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: DMAs are management units subject to permit conditions for water loss control, NRW reporting requirements, and system efficiency standards. Permits may mandate specific NRW targets and leakage reducti',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone within which this DMA operates. Pressure zones define areas of similar hydraulic pressure managed by Pressure Reducing Valves (PRVs) and pump stations.',
    `territory_id` BIGINT COMMENT 'Reference to the maintenance zone or service district to which the DMA belongs. Used for work order routing and resource planning.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure within the DMA measured in Pounds per Square Inch. Pressure management is critical for leakage control; excessive pressure increases leak rates and pipe stress.',
    `boundary_description` STRING COMMENT 'Textual description of the DMA boundary including street names, landmarks, and physical boundaries used to define the hydraulically isolated zone.',
    `dma_code` STRING COMMENT 'Business identifier code for the DMA used in operational systems, GIS, and reporting. Typically alphanumeric and unique across the distribution network.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DMA record was first created in the system. Used for audit trail and data lineage tracking.',
    `criticality_rating` STRING COMMENT 'Business criticality rating of the DMA based on factors such as population served, infrastructure condition, leakage history, and service area importance. Critical DMAs receive priority for monitoring and maintenance.. Valid values are `critical|high|medium|low`',
    `decommissioned_date` DATE COMMENT 'Date when the DMA was decommissioned or reconfigured. Null for active DMAs. Used for historical tracking and audit purposes.',
    `dma_description` STRING COMMENT 'Detailed description of the DMA including boundary landmarks, service area characteristics, and any operational notes relevant to leakage management and monitoring.',
    `design_flow_mgd` DECIMAL(18,2) COMMENT 'Design flow capacity for the DMA in Million Gallons per Day. Represents the maximum daily demand the DMA is engineered to supply under normal operating conditions.',
    `dma_status` STRING COMMENT 'Current operational status of the DMA. Active DMAs are fully operational and monitored; inactive or decommissioned DMAs are no longer in use; planned DMAs are in design phase; under review indicates reconfiguration or audit in progress.. Valid values are `active|inactive|planned|decommissioned|under_review|suspended`',
    `established_date` DATE COMMENT 'Date when the DMA was first established and commissioned for operational monitoring. Represents the start of the DMAs lifecycle.',
    `gis_polygon_boundary` STRING COMMENT 'GIS polygon geometry defining the spatial boundary of the DMA. Typically stored as WKT (Well-Known Text) or reference to GIS layer feature ID for integration with Esri ArcGIS.',
    `inlet_meter_count` STRING COMMENT 'Number of inlet flow meters installed at entry points to the DMA. Inlet meters measure total water entering the zone and are critical for NRW calculation.',
    `isolation_valve_count` STRING COMMENT 'Number of isolation valves installed at the DMA boundary. Isolation valves enable hydraulic isolation of the DMA for accurate flow measurement and leakage detection.',
    `last_leakage_survey_date` DATE COMMENT 'Date of the most recent active leakage detection survey conducted within the DMA. Used to track compliance with leakage management programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the DMA record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `leakage_detection_frequency_days` STRING COMMENT 'Frequency in days at which active leakage detection surveys are conducted within the DMA. High-risk or high-leakage DMAs may be surveyed more frequently.',
    `main_length_miles` DECIMAL(18,2) COMMENT 'Total length of water mains (distribution pipes) within the DMA measured in miles. Used for calculating leakage per mile of main and infrastructure density metrics.',
    `minimum_night_flow_threshold_gpm` DECIMAL(18,2) COMMENT 'Minimum Night Flow threshold in Gallons per Minute. MNF is the lowest flow rate measured during nighttime hours (typically 2 AM to 4 AM) when legitimate consumption is minimal. Elevated MNF indicates leakage within the DMA.',
    `dma_name` STRING COMMENT 'Human-readable name or designation of the DMA, often reflecting geographic location or service area (e.g., Downtown West DMA, Industrial Park Zone 3).',
    `next_scheduled_survey_date` DATE COMMENT 'Scheduled date for the next active leakage detection survey within the DMA. Used for planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, historical context, or any additional information relevant to the DMA management and monitoring.',
    `outlet_meter_count` STRING COMMENT 'Number of outlet flow meters installed at exit points from the DMA. Outlet meters are used in complex DMA configurations where water may flow to adjacent zones.',
    `population_served` STRING COMMENT 'Estimated population served by the DMA. Used for per-capita consumption analysis and demand forecasting.',
    `prv_count` STRING COMMENT 'Number of Pressure Reducing Valves installed within or at the boundary of the DMA. PRVs control pressure to reduce leakage and pipe stress.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the DMA is actively monitored by the SCADA system. SCADA-monitored DMAs provide real-time flow, pressure, and alarm data for proactive leakage management.',
    `service_connection_count` STRING COMMENT 'Total number of active service connections (customer meters) within the DMA. Used for calculating per-connection leakage rates and NRW metrics.',
    `target_nrw_percentage` DECIMAL(18,2) COMMENT 'Target threshold for Non-Revenue Water as a percentage of total water supplied to the DMA. NRW includes physical losses (leakage) and commercial losses (metering inaccuracies, theft). Typical industry targets range from 10% to 20%.',
    `target_ufw_percentage` DECIMAL(18,2) COMMENT 'Target threshold for Unaccounted-for Water as a percentage of total water supplied. UFW is a broader measure than NRW and includes all water that cannot be accounted for through billing or authorized use.',
    CONSTRAINT pk_dma PRIMARY KEY(`dma_id`)
) COMMENT 'Master record for District Metered Areas (DMAs) — discrete, hydraulically isolated zones of the distribution network used for NRW/UFW monitoring and leakage management. Captures DMA name, boundary description, inlet meter points, outlet meter points, target NRW percentage, minimum night flow (MNF) threshold (GPM), associated pressure zone, GIS polygon boundary, and active status. Core to leakage detection and water loss control programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` (
    `network_valve_id` BIGINT COMMENT 'Unique identifier for the distribution network valve record. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Valves are capitalized assets requiring depreciation tracking and condition-based valuation for asset management financial reporting, replacement cost analysis, and GASB compliance.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) containing this valve. DMAs are isolated network sections with defined boundaries and metered inflows/outflows, used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Valves on DMA boundaries are critical for isolation and flow control.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the water main on which this valve is installed. Links the valve to the pipe segment for network topology modeling in Esri ArcGIS and Innovyze InfoWater.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Valve exercising programs are formal PM schedules required by AWWA standards and many state regulations. Direct FK to pm_schedule enables automated work order generation for valve exercising, frequenc',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which this valve is located. Pressure zones are geographic areas maintained at specific pressure ranges (measured in Pounds per Square Inch - PSI) to ensure adequate service and prevent pipe bursts. Critical for hydraulic modeling in Innovyze InfoWater.',
    `registry_id` BIGINT COMMENT 'Reference to the asset registry record in the Computerized Maintenance Management System (CMMS). Links this valve to IBM Maximo Asset Management for maintenance tracking, work orders, and lifecycle management.',
    `burial_depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the valve operating nut. Used for excavation planning, valve box sizing, and accessibility assessment. Typical range is 3-8 feet depending on frost line and main depth.',
    `city` STRING COMMENT 'City or municipality in which the valve is located. Used for jurisdictional reporting and geographic analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve record was first created in the system. Used for data lineage, audit trails, and compliance with data governance policies.',
    `current_position` STRING COMMENT 'Actual current position of the valve as of the last field verification or SCADA reading. May differ from normal_position during maintenance, emergencies, or operational adjustments.. Valid values are `open|closed|throttled|unknown`',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the valve in inches. Critical for hydraulic modeling in Innovyze InfoWater and flow capacity calculations. Common sizes range from 2 to 48 inches in distribution networks.',
    `exercising_frequency_months` STRING COMMENT 'Planned frequency in months for valve exercising activities. Typically 12 months for standard valves, 6 months for critical isolation valves, and 24 months for low-priority valves. Drives preventive maintenance scheduling in CMMS.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier in the Esri ArcGIS system. Links this valve record to the corresponding GIS feature layer for spatial analysis, map display, and network topology modeling.',
    `installation_date` DATE COMMENT 'Date the valve was originally installed in the distribution network. Used for age-based asset management, depreciation calculations, and replacement planning under the Capital Improvement Program (CIP).',
    `installation_year` STRING COMMENT 'Year the valve was installed. Derived from installation_date for simplified age analysis and reporting when exact date is not required.',
    `is_buried` BOOLEAN COMMENT 'Indicates whether the valve is buried underground (True) or above ground in a vault or building (False). Buried valves require valve box access and are more difficult to exercise; above-ground valves are more accessible but require weather protection.',
    `is_motorized` BOOLEAN COMMENT 'Indicates whether the valve is equipped with a motor or actuator for remote operation. True for SCADA-controlled valves; False for manual valves requiring field crew operation.',
    `last_exercised_by` STRING COMMENT 'Name or identifier of the crew member or contractor who last exercised the valve. Supports accountability and quality assurance in valve maintenance programs.',
    `last_exercised_date` DATE COMMENT 'Date the valve was last exercised (opened and closed through its full range of motion). Regular valve exercising prevents seizing and ensures operability during emergencies. AWWA recommends annual exercising for critical valves.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the valve location in decimal degrees. Used for Geographic Information System (GIS) mapping in Esri ArcGIS, field crew navigation, and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the valve location in decimal degrees. Used for Geographic Information System (GIS) mapping in Esri ArcGIS, field crew navigation, and spatial analysis.',
    `material` STRING COMMENT 'Primary construction material of the valve body. Ductile iron is most common for large distribution valves; bronze and brass for smaller service valves; stainless steel for corrosive environments; PVC for low-pressure applications.. Valid values are `cast_iron|ductile_iron|bronze|stainless_steel|pvc|brass`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve record was last modified. Supports change tracking, audit requirements, and data quality monitoring.',
    `normal_position` STRING COMMENT 'Standard operating position of the valve under normal conditions. Critical for hydraulic modeling, isolation planning, and Supervisory Control and Data Acquisition (SCADA) monitoring. Most distribution valves are normally open; some isolation and control valves are normally closed or throttled.. Valid values are `open|closed|throttled`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, access restrictions, or historical information about the valve. Examples: Requires two-person crew due to tight turns, Located in private easement, coordinate access, Replaced stem in 2018.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure at the valve location in Pounds per Square Inch (PSI). Used for hydraulic modeling, pressure zone verification, and valve sizing validation. Typical distribution system pressures range from 40-120 PSI.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the valve in the distribution network. Active valves are in service; inactive valves are temporarily out of service; abandoned valves are no longer used but not removed; removed valves have been physically extracted; planned valves are scheduled for installation.. Valid values are `active|inactive|abandoned|removed|planned`',
    `postal_code` STRING COMMENT 'Postal code of the valve location. Supports geographic segmentation and service area analysis.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum rated working pressure of the valve in Pounds per Square Inch (PSI) as specified by the manufacturer. Must exceed operating_pressure_psi with adequate safety margin. Common ratings are 150, 200, 250, and 300 PSI.',
    `scada_tag` STRING COMMENT 'SCADA system tag identifier for automated valves with remote monitoring and control capability. Links to OSIsoft PI Historian for real-time position monitoring, alarm management, and operational analytics. Only populated for motorized or actuated valves integrated with SCADA.',
    `state_province` STRING COMMENT 'State or province in which the valve is located. Used for regulatory reporting to State Drinking Water Programs and Primacy Agencies.',
    `street_address` STRING COMMENT 'Nearest street address or intersection to the valve location. Provides human-readable location reference for field crews, emergency responders, and customer service representatives.',
    `turns_to_close` STRING COMMENT 'Number of complete turns required to fully close the valve from the fully open position. Used by field crews during valve exercising programs and emergency isolation procedures. Typical range is 5-50 turns depending on valve size and type.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the valve in years from installation date. Used for depreciation calculations per Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB) standards, and for long-term replacement planning. Typical range is 50-75 years for distribution valves.',
    `valve_box_type` STRING COMMENT 'Type of valve box or access structure protecting the buried valve. Standard boxes for sidewalk/lawn areas; traffic-rated boxes for roadways; extension boxes for deep valves; vaults for large valves; none for above-ground installations.. Valid values are `standard|traffic_rated|extension|vault|none`',
    `valve_function` STRING COMMENT 'Primary operational function of the valve in the distribution network. Isolation valves segment the network for maintenance; control valves regulate flow; pressure reducing valves (PRV) manage pressure zones; check valves prevent backflow; air release valves expel trapped air; blowoff valves drain sections.. Valid values are `isolation|control|pressure_reducing|check|air_release|blowoff`',
    `valve_number` STRING COMMENT 'Externally-known business identifier for the valve, typically painted or tagged on the valve in the field. Used by operations and maintenance crews for identification.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `valve_type` STRING COMMENT 'Classification of the valve mechanism. Gate valves provide full flow with minimal pressure drop; butterfly valves are compact and quick-operating; ball valves offer tight shutoff; check valves prevent backflow; plug, cone, and needle valves provide throttling control. [ENUM-REF-CANDIDATE: gate|butterfly|ball|check|plug|cone|needle — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_network_valve PRIMARY KEY(`network_valve_id`)
) COMMENT 'Master record for all distribution network valves including gate valves, butterfly valves, ball valves, and check valves used for flow control and system isolation. Captures valve type, size (inches), manufacturer, installation year, location (GIS coordinates, street address, nearest main reference), pressure zone, DMA, normal operating position (open/closed), number of turns to operate, last exercised date, condition rating, and CMMS asset reference. Critical for isolation analysis (determining minimum valve closures to isolate a pipe segment) and valve exercising programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` (
    `hydrant_id` BIGINT COMMENT 'Unique identifier for the fire hydrant asset in the distribution network. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Hydrants are capitalized assets tracked for depreciation, replacement cost analysis, annual GASB reporting, insurance valuation, and capital planning in water utilities.',
    `criticality_rating_id` BIGINT COMMENT 'Foreign key linking to asset.criticality_rating. Business justification: Hydrant criticality ratings drive fire protection planning, replacement prioritization, and mutual aid agreements. criticality_rating on hydrant is denormalized. Direct FK supports consequence-of-fail',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) to which the hydrant belongs, used for Non-Revenue Water (NRW) analysis and leak detection programs.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Hydrant flushing and inspection programs are formal PM schedules required by AWWA M17 and fire code compliance. Direct FK to pm_schedule enables automated scheduling of hydrant inspections, flushing e',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone or hydraulic district in which the hydrant is located, used for pressure management and network segmentation.',
    `bury_depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the hydrant valve or base, critical for freeze protection and installation specifications.',
    `city` STRING COMMENT 'City or municipality name where the hydrant is located.',
    `condition_status` STRING COMMENT 'Current physical condition assessment of the hydrant based on inspection findings: excellent (like new), good (minor wear), fair (functional with moderate wear), poor (requires repair), critical (non-functional or unsafe).. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrant record was first created in the asset management system.',
    `fire_district` STRING COMMENT 'Name or code of the fire protection district or fire department jurisdiction responsible for this hydrant, used for emergency response coordination.',
    `flow_capacity_gpm` STRING COMMENT 'Rated fire flow capacity of the hydrant in gallons per minute (GPM) at 20 pounds per square inch (PSI) residual pressure, determined by flow testing per NFPA 291.',
    `flow_class_color` STRING COMMENT 'Color coding per NFPA 291 indicating fire flow capacity class: Red (<500 GPM), Orange (500-999 GPM), Green (1000-1499 GPM), Blue (>=1500 GPM), Light Blue (>=2500 GPM). Used for visual identification by fire departments.. Valid values are `red|orange|green|blue|light_blue`',
    `flushing_program_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this hydrant is included in the routine unidirectional flushing program for water quality maintenance and sediment removal.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier from the Esri ArcGIS system linking this hydrant record to the spatial GIS layer for network modeling and map visualization.',
    `hydrant_number` STRING COMMENT 'External business identifier or asset tag number assigned to the hydrant for field operations, maintenance tracking, and municipal records.',
    `hydrant_type` STRING COMMENT 'Classification of hydrant design. Dry barrel hydrants drain after use (freeze-resistant for cold climates), wet barrel hydrants remain charged with water (warm climates), flush hydrants are below-grade, wall hydrants are building-mounted.. Valid values are `dry_barrel|wet_barrel|flush|wall`',
    `installation_date` DATE COMMENT 'Date when the hydrant was originally installed in the distribution network.',
    `installation_year` STRING COMMENT 'Year of hydrant installation, used for age-based asset management, depreciation schedules, and replacement planning.',
    `last_flow_test_date` DATE COMMENT 'Date of the most recent fire flow test conducted on the hydrant per NFPA 291 standards, used to verify flow capacity and pressure performance.',
    `last_flushing_date` DATE COMMENT 'Date when the hydrant was last used for system flushing or water quality maintenance activities.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent routine inspection of the hydrant for physical condition, operability, and maintenance needs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrant record was last updated in the asset management system, used for audit trail and data lineage tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the hydrant location for GIS mapping, spatial analysis, and emergency response routing.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the hydrant location for GIS mapping, spatial analysis, and emergency response routing.',
    `main_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the connected water main pipe in inches, critical for fire flow capacity calculations and hydraulic modeling.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next routine inspection of the hydrant, based on preventive maintenance (PM) schedule and regulatory requirements.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the hydrant (e.g., access restrictions, historical issues, special maintenance requirements).',
    `operational_status` STRING COMMENT 'Current operational status of the hydrant in the distribution network: in_service (active and available), out_of_service (temporarily unavailable), under_repair (maintenance in progress), abandoned (permanently removed from service), planned (not yet installed).. Valid values are `in_service|out_of_service|under_repair|abandoned|planned`',
    `outlet_count` STRING COMMENT 'Total number of discharge outlets (nozzles) on the hydrant, typically 2-5 outlets including pumper and hose connections.',
    `outlet_size_inches` STRING COMMENT 'Sizes of hydrant outlets in inches, typically formatted as a comma-separated list (e.g., 2.5,2.5,4.5 for two 2.5-inch hose outlets and one 4.5-inch pumper outlet).',
    `ownership_type` STRING COMMENT 'Entity responsible for ownership and maintenance of the hydrant: utility_owned (water utility), municipality_owned (city/town), private (property owner), fire_district (fire protection district).. Valid values are `utility_owned|municipality_owned|private|fire_district`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the hydrant location, used for geographic segmentation and service area analysis.',
    `residual_pressure_psi` DECIMAL(18,2) COMMENT 'Residual water pressure at the hydrant in pounds per square inch (PSI) during flow testing at rated capacity, used to assess available fire flow.',
    `scada_tag` STRING COMMENT 'SCADA system tag or point identifier if the hydrant is equipped with remote monitoring sensors (e.g., pressure transducers), integrated with OSIsoft PI Historian.',
    `state_province` STRING COMMENT 'State or province code (e.g., CA, TX, ON) where the hydrant is located.',
    `static_pressure_psi` DECIMAL(18,2) COMMENT 'Static water pressure at the hydrant location in pounds per square inch (PSI) when no water is flowing, measured during flow testing.',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the hydrant is located, used for field crew dispatch and fire department coordination.',
    `valve_turns_to_open` DECIMAL(18,2) COMMENT 'Number of complete turns required to fully open the hydrant main valve, used for operational training and maintenance documentation.',
    CONSTRAINT pk_hydrant PRIMARY KEY(`hydrant_id`)
) COMMENT 'Master record for fire hydrants in the distribution network. Captures hydrant type (dry barrel, wet barrel), manufacturer, installation year, GIS location, nearest main pipe, outlet size and count, color coding (flow capacity class per NFPA 291), last flow test date, last inspection date, condition status, and municipality ownership flag. Supports fire flow planning, flushing programs, and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` (
    `pump_station_id` BIGINT COMMENT 'Unique identifier for the booster pump station within the distribution network. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Pump stations are high-value capital assets central to rate base and depreciation schedules, essential for regulatory asset reporting, financial statements, and rate case filings.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Pump stations require operating permits governing discharge pressure, flow capacity, and emergency response. pump_station already has regulatory_inspection_id but lacks compliance_permit_id — an incon',
    `criticality_rating_id` BIGINT COMMENT 'Foreign key linking to asset.criticality_rating. Business justification: Pump station criticality ratings drive redundancy planning, backup generator requirements, and CIP prioritization. criticality_rating on pump_station is denormalized. Direct FK supports consequence-of',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) that this pump station serves for NRW and UFW analysis.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Pump station preventive maintenance programs (lubrication, impeller inspection, seal replacement) are formal PM schedules. Direct FK to pm_schedule enables automated work order generation, maintenance',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone served by this pump station for hydraulic modeling and network segmentation.',
    `address_line_1` STRING COMMENT 'Primary street address of the pump station facility for physical access and emergency response.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number or suite for the pump station facility.',
    `backup_generator_available` BOOLEAN COMMENT 'Indicates whether the pump station has a backup generator for emergency power supply.',
    `backup_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Capacity of the backup generator in kilowatts (kW) if available.',
    `city` STRING COMMENT 'City or municipality where the pump station is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the pump station is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump station record was first created in the system.',
    `design_flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the pump station measured in gallons per minute (GPM).',
    `design_flow_capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the pump station measured in million gallons per day (MGD).',
    `discharge_pressure_psi` DECIMAL(18,2) COMMENT 'Target discharge pressure in pounds per square inch (PSI) maintained by the pump station.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier in the Esri ArcGIS system linking this pump station to the GIS network model.',
    `hydraulic_model_node_code` STRING COMMENT 'Node identifier in the Innovyze InfoWater hydraulic model representing this pump station.',
    `installation_date` DATE COMMENT 'Date when the pump station was originally installed and commissioned.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major upgrade or rehabilitation of the pump station.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump station record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the pump station location in decimal degrees for GIS integration.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the pump station location in decimal degrees for GIS integration.',
    `maximo_asset_number` STRING COMMENT 'Asset number assigned to the pump station in the IBM Maximo CMMS for maintenance management.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or historical information about the pump station.',
    `number_of_duty_pumps` STRING COMMENT 'Count of pumps designated for normal operational duty at the station.',
    `number_of_pumps` STRING COMMENT 'Total count of pump units installed at the station, including duty and standby pumps.',
    `number_of_standby_pumps` STRING COMMENT 'Count of pumps designated as standby or backup units for redundancy.',
    `operational_status` STRING COMMENT 'Current operational state of the pump station indicating availability for service.. Valid values are `active|standby|maintenance|inactive|decommissioned|under_construction`',
    `ownership_type` STRING COMMENT 'Ownership classification of the pump station asset.. Valid values are `owned|leased|shared|third_party`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the pump station location.',
    `power_supply_phase` STRING COMMENT 'Electrical power supply phase configuration for the pump station.. Valid values are `single_phase|three_phase`',
    `power_supply_voltage` STRING COMMENT 'Electrical power supply voltage specification for the pump station (e.g., 480V, 4160V).',
    `scada_integrated` BOOLEAN COMMENT 'Indicates whether the pump station is integrated with the SCADA system for remote monitoring and control.',
    `scada_tag_prefix` STRING COMMENT 'Prefix used for SCADA tags associated with this pump station in the OSIsoft PI Historian system.',
    `state_province` STRING COMMENT 'State or province code where the pump station is located.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the pump station for asset tracking and SCADA integration.',
    `station_name` STRING COMMENT 'Business name or designation of the pump station for operational reference and reporting.',
    `station_type` STRING COMMENT 'Classification of the pump station based on its operational function within the distribution network.. Valid values are `booster|transfer|lift|high_service|low_service|emergency`',
    `suction_pressure_psi` DECIMAL(18,2) COMMENT 'Inlet or suction pressure in pounds per square inch (PSI) at the pump station intake.',
    `total_dynamic_head_ft` DECIMAL(18,2) COMMENT 'Total dynamic head (TDH) in feet that the pump station must overcome, including elevation and friction losses.',
    `vfd_configuration` STRING COMMENT 'Description of the VFD configuration including number of drives and control strategy.',
    `vfd_equipped` BOOLEAN COMMENT 'Indicates whether the pump station is equipped with Variable Frequency Drive (VFD) technology for flow and pressure control.',
    CONSTRAINT pk_pump_station PRIMARY KEY(`pump_station_id`)
) COMMENT 'Master record for booster pump stations within the distribution network that maintain pressure and flow across the system. Captures station name, location (GIS), pressure zone served, design flow capacity (GPM/MGD), total dynamic head (TDH), number of pumps, VFD configuration, SCADA integration tags (OSIsoft PI Historian), power supply details, backup generator status, and operational status. Distinct from WTP/WWTP pump stations owned by treatment/wastewater domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` (
    `storage_tank_id` BIGINT COMMENT 'Unique identifier for the potable water storage facility. Primary key for the storage tank master record.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Storage tanks are major capital assets requiring depreciation, insurance valuation, and regulatory reporting for GASB compliance, rate base calculations, and asset valuation.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Storage tanks operate under facility operating permits that specify inspection intervals, water quality requirements, and structural standards. All other major distribution infrastructure (pipe_main, ',
    `criticality_rating_id` BIGINT COMMENT 'Foreign key linking to asset.criticality_rating. Business justification: Storage tank criticality ratings drive water supply reliability planning, emergency storage requirements, and CIP prioritization. asset_criticality_rating on storage_tank is denormalized. Direct FK su',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Tank cleaning and inspection PM schedules are required by AWWA D100/ANSI/NSF standards and state drinking water regulations. Direct FK to pm_schedule enables automated scheduling of tank inspections, ',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone served by this storage tank. Pressure zones are geographic areas of the distribution network maintained at similar hydraulic pressure ranges.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that this storage tank serves. DMAs are discrete zones used for water balance analysis and Non-Revenue Water (NRW) management.',
    `base_elevation_feet` DECIMAL(18,2) COMMENT 'Ground or foundation elevation (in feet above mean sea level or local datum) at the base of the storage tank structure. Used for hydraulic gradient calculations.',
    `capacity_gallons` DECIMAL(18,2) COMMENT 'Total storage capacity of the tank measured in gallons. Represents the maximum volume of potable water the tank can hold at overflow elevation.',
    `capacity_million_gallons` DECIMAL(18,2) COMMENT 'Total storage capacity expressed in million gallons (MG), the standard unit for water utility storage reporting and system adequacy analysis.',
    `coating_condition` STRING COMMENT 'Assessment of the current condition of the tanks protective coating system based on the most recent inspection: excellent (no defects), good (minor wear), fair (localized deterioration), poor (widespread deterioration), or failed (coating breakdown requiring immediate attention).. Valid values are `excellent|good|fair|poor|failed`',
    `emergency_storage_gallons` DECIMAL(18,2) COMMENT 'Volume of water (in gallons) reserved for emergency supply during system outages, treatment plant failures, or other contingencies. Separate from fire flow reserve and operational storage.',
    `fire_flow_reserve_gallons` DECIMAL(18,2) COMMENT 'Volume of water (in gallons) reserved in the storage tank to meet fire protection requirements and emergency fire flow demands as defined by local fire codes and insurance standards.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier from the Esri ArcGIS system linking this storage tank record to its spatial representation in the GIS network model.',
    `hydraulic_model_node_code` STRING COMMENT 'Node identifier in the Innovyze InfoWater hydraulic model representing this storage tank. Used for network simulation, pressure analysis, and system optimization studies.',
    `inlet_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter (in inches) of the primary inlet pipe supplying water to the storage tank. Used for hydraulic modeling and flow capacity analysis.',
    `installation_date` DATE COMMENT 'Date when the storage tank was originally constructed and placed into service. Used for asset age calculation and depreciation schedules.',
    `last_cleaning_date` DATE COMMENT 'Date when the storage tank interior was last drained, cleaned, and disinfected. Regular cleaning is required to maintain water quality and prevent sediment accumulation.',
    `last_coating_date` DATE COMMENT 'Date when the interior or exterior protective coating was last applied or rehabilitated. Coating maintenance is critical for corrosion prevention and structural longevity.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent comprehensive inspection of the storage tank, including structural integrity, coating condition, and safety systems. Required for regulatory compliance and asset management.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the storage tank location. Used for GIS mapping, spatial analysis, and integration with Esri ArcGIS.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the storage tank location. Used for GIS mapping, spatial analysis, and integration with Esri ArcGIS.',
    `maximo_asset_number` STRING COMMENT 'Asset identifier from IBM Maximo Asset Management (CMMS) system linking this storage tank to its maintenance history, work orders, preventive maintenance schedules, and spare parts inventory.',
    `maximum_operating_level_feet` DECIMAL(18,2) COMMENT 'Highest water level (in feet) at which the tank should operate under normal conditions, typically set below overflow elevation to provide freeboard and prevent overflow events.',
    `minimum_operating_level_feet` DECIMAL(18,2) COMMENT 'Lowest water level (in feet) at which the tank should operate under normal conditions to maintain adequate system pressure and prevent pump cavitation or structural stress.',
    `mixing_system_installed` BOOLEAN COMMENT 'Indicates whether an active mixing system is installed in the storage tank to prevent water age stratification and maintain disinfectant residual throughout the tank volume.',
    `mixing_system_type` STRING COMMENT 'Type of mixing system installed: mechanical (motor-driven mixer), hydraulic (jet mixing using inlet flow), or none (no active mixing).. Valid values are `mechanical|hydraulic|none`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required comprehensive inspection based on regulatory requirements, manufacturer recommendations, or utility inspection frequency policy.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special conditions, historical information, or other relevant details about the storage tank not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current operational state of the storage tank in the distribution network: in-service (actively storing and supplying water), out-of-service (temporarily offline), standby (available but not actively used), under-maintenance (undergoing inspection or repair), or decommissioned (permanently retired).. Valid values are `in_service|out_of_service|standby|under_maintenance|decommissioned`',
    `outlet_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter (in inches) of the primary outlet pipe distributing water from the storage tank to the distribution network. Used for hydraulic modeling and flow capacity analysis.',
    `overflow_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation (in feet above mean sea level or local datum) at which the tank overflow pipe is located. Represents the absolute maximum water level before overflow discharge occurs.',
    `overflow_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter (in inches) of the overflow pipe that prevents tank overfilling by discharging excess water when the maximum level is reached.',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the storage tank: utility-owned (owned and operated by the water utility), leased (leased from another entity), shared (jointly owned with another utility or municipality), or third-party (owned by external entity with service agreement).. Valid values are `utility_owned|leased|shared|third_party`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage tank record was first created in the system. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage tank record was last modified. Used for data lineage, change tracking, and audit trail purposes.',
    `scada_flow_meter_tag` STRING COMMENT 'OSIsoft PI Historian tag name for the flow meter measuring inflow or outflow (GPM or MGD) from this storage tank. Used for demand analysis and water balance calculations.',
    `scada_level_sensor_tag` STRING COMMENT 'OSIsoft PI Historian tag name for the real-time water level sensor monitoring this storage tank. Used to retrieve current level, historical trends, and alarm conditions from the SCADA system.',
    `scada_pressure_sensor_tag` STRING COMMENT 'OSIsoft PI Historian tag name for the pressure sensor monitoring outlet pressure (PSI) from this storage tank. Used for hydraulic performance monitoring and pressure zone management.',
    `security_system_installed` BOOLEAN COMMENT 'Indicates whether physical security systems (fencing, locks, intrusion detection, surveillance cameras) are installed to protect the storage tank from unauthorized access and potential contamination threats.',
    `structural_condition` STRING COMMENT 'Overall structural integrity assessment of the storage tank based on the most recent inspection: excellent (no defects), good (minor issues), fair (moderate deterioration), poor (significant deterioration requiring repair), or critical (unsafe condition requiring immediate action).. Valid values are `excellent|good|fair|poor|critical`',
    `tank_material` STRING COMMENT 'Primary construction material of the storage tank structure: steel (welded or bolted), concrete (cast-in-place or precast), prestressed concrete, composite (steel and concrete), or fiberglass.. Valid values are `steel|concrete|prestressed_concrete|composite|fiberglass`',
    `tank_name` STRING COMMENT 'Common name or designation of the storage tank, often referencing geographic location or service area (e.g., Hillside Elevated Tank, Downtown Reservoir).',
    `tank_number` STRING COMMENT 'Business identifier or asset tag assigned to the storage tank for operational reference and field identification.',
    `tank_type` STRING COMMENT 'Classification of storage tank by structural configuration: elevated (water tower), ground-level (surface reservoir), standpipe (tall cylindrical), reservoir (large capacity ground storage), clearwell (treated water storage at WTP), or hydropneumatic (pressure tank).. Valid values are `elevated|ground_level|standpipe|reservoir|clearwell|hydropneumatic`',
    `usable_capacity_gallons` DECIMAL(18,2) COMMENT 'Effective storage capacity available for distribution operations, calculated as the volume between minimum operating level and overflow elevation. Excludes dead storage below minimum operating level.',
    CONSTRAINT pk_storage_tank PRIMARY KEY(`storage_tank_id`)
) COMMENT 'Master record for potable water storage facilities in the distribution network including elevated tanks, ground-level reservoirs, and standpipes. Captures tank type, material, capacity (gallons/MG), operating level range (min/max feet), overflow elevation, pressure zone served, GIS location, SCADA level sensor tags (OSIsoft PI Historian), last inspection date, coating condition, and regulatory inspection status. Supports system storage adequacy and fire flow reserve analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` (
    `flow_reading_id` BIGINT COMMENT 'Unique identifier for the flow measurement record. Primary key for the flow reading transaction.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: DMA inlet/bulk meters equipped with AMI endpoints transmit flow readings directly into distribution flow_reading records. Linking ami_endpoint_id identifies the AMI device as the data source, supporti',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) associated with this flow measurement. Used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis.',
    `finished_water_production_id` BIGINT COMMENT 'Foreign key linking to treatment.finished_water_production. Business justification: Water balance and NRW (non-revenue water) calculations require reconciling distribution flow readings against finished water production volumes. Linking distribution entry-point flow readings to the c',
    `point_id` BIGINT COMMENT 'Reference to the physical location or asset where the flow measurement was captured (DMA inlet/outlet meter, pump station discharge meter, PRV station meter, or bulk transfer point).',
    `meter_id` BIGINT COMMENT 'Reference to the specific flow meter device that captured this reading. Links to asset registry for meter calibration history and maintenance records.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Flow readings can be captured directly on distribution mains (e.g., inline flow meters on transmission mains) for hydraulic model calibration and NRW analysis. A nullable pipe_main_id FK to distributi',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Per the flow_reading product description, flow measurements are captured at pump stations in addition to DMA meters. A nullable pump_station_id FK to distribution.pump_station.pump_station_id links ea',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Per the flow_reading product description, flow measurements are captured at storage tank inlet/outlet points. A nullable storage_tank_id FK to distribution.storage_tank.storage_tank_id links each flow',
    `alarm_flag` BOOLEAN COMMENT 'Indicates whether this flow reading triggered an alarm condition in the SCADA system (e.g., flow exceeds threshold, negative flow, meter communication failure).',
    `alarm_type` STRING COMMENT 'Classification of the alarm condition if alarm_flag is true. [ENUM-REF-CANDIDATE: high_flow|low_flow|no_flow|reverse_flow|communication_failure|meter_fault|pressure_deviation|temperature_anomaly|data_gap|validation_failure — promote to reference product]. Valid values are `high_flow|low_flow|no_flow|reverse_flow|communication_failure|meter_fault`',
    `billing_flag` BOOLEAN COMMENT 'Indicates whether this flow reading is used for bulk water billing or wholesale customer invoicing (e.g., inter-utility transfers, industrial bulk customers).',
    `calibration_date` DATE COMMENT 'Date of the most recent meter calibration prior to this reading. Used to assess measurement reliability and schedule recalibration.',
    `comments` STRING COMMENT 'Free-text field for operator notes, validation comments, or explanations of anomalies in the flow reading. Used for audit trail and troubleshooting.',
    `data_quality_flag` BOOLEAN COMMENT 'Quality indicator for the flow reading. Good = validated measurement, Suspect = questionable but not rejected, Bad = failed validation, Estimated = calculated/interpolated value, Manual = operator-entered reading.',
    `engineering_unit` STRING COMMENT 'Unit of measure for the flow reading. GPM = Gallons per Minute, MGD = Million Gallons per Day, CFS = Cubic Feet per Second, LPS = Liters per Second, M3H = Cubic Meters per Hour, M3D = Cubic Meters per Day.. Valid values are `GPM|MGD|CFS|LPS|M3H|M3D`',
    `estimated_flag` BOOLEAN COMMENT 'Indicates whether the flow value is an estimated or interpolated value rather than a direct meter reading. True when meter communication fails or reading is missing.',
    `estimation_method` STRING COMMENT 'Method used to estimate the flow value when direct measurement is unavailable. None indicates a direct measured value.. Valid values are `linear_interpolation|historical_average|pattern_based|manual_estimate|none`',
    `flow_direction` STRING COMMENT 'Direction of water flow at the measurement point. Inflow = water entering the zone/DMA, Outflow = water leaving the zone/DMA, Bidirectional = flow can reverse direction.. Valid values are `inflow|outflow|bidirectional`',
    `flow_value` DECIMAL(18,2) COMMENT 'The raw flow measurement value as captured by the meter. Represents instantaneous flow rate or cumulative volume depending on measurement type. Used with engineering_unit to interpret the measurement.',
    `hydraulic_model_flag` BOOLEAN COMMENT 'Indicates whether this flow reading is used for hydraulic model calibration in Innovyze InfoWater or similar distribution network modeling software.',
    `interval_duration_minutes` STRING COMMENT 'Time interval in minutes over which the flow measurement was aggregated or averaged. Common values: 15, 30, 60 minutes for SCADA polling intervals.',
    `measurement_type` STRING COMMENT 'Classification of the flow measurement: instantaneous (real-time snapshot), cumulative (totalizer reading), average (calculated over interval), peak (maximum in interval), or minimum (lowest in interval).. Valid values are `instantaneous|cumulative|average|peak|minimum`',
    `meter_accuracy_percent` DECIMAL(18,2) COMMENT 'The rated accuracy of the flow meter at the time of this reading, expressed as a percentage. Used to calculate measurement uncertainty for water balance calculations.',
    `nrw_calculation_flag` BOOLEAN COMMENT 'Indicates whether this flow reading is included in Non-Revenue Water (NRW) or Unaccounted-for Water (UFW) balance calculations for the associated DMA.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Water pressure measurement in PSI at the flow measurement point, captured concurrently with the flow reading. Used for hydraulic model calibration and pressure zone analysis.',
    `reading_timestamp` TIMESTAMP COMMENT 'The precise date and time when the flow measurement was captured by the meter or SCADA system. This is the business event timestamp representing the actual measurement occurrence.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this flow reading record was first inserted into the data system. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this flow reading record was last modified. Used for change tracking and audit trail.',
    `scada_tag_name` STRING COMMENT 'The SCADA system tag or point identifier that sourced this flow reading. Used for traceability back to the PI Historian or SCADA historian database.',
    `temperature_f` DECIMAL(18,2) COMMENT 'Water temperature in degrees Fahrenheit at the measurement point. Used for flow compensation calculations and water quality correlation analysis.',
    `totalizer_reading` DECIMAL(18,2) COMMENT 'Cumulative volume reading from the meter totalizer register. Used to calculate interval consumption by differencing consecutive readings. Typically in gallons or cubic meters.',
    `validated_by` STRING COMMENT 'User ID or system process name that performed the validation of this flow reading. Used for audit trail and accountability.',
    `validation_status` STRING COMMENT 'Current validation state of the flow reading. Pending = awaiting review, Validated = approved by operator or automated validation, Rejected = failed validation rules, Corrected = manually adjusted after validation.. Valid values are `pending|validated|rejected|corrected`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the flow reading was validated or reviewed by an operator or automated validation process.',
    CONSTRAINT pk_flow_reading PRIMARY KEY(`flow_reading_id`)
) COMMENT 'Transactional record of flow measurements (GPM/MGD) captured at DMA inlet/outlet meters, pump station discharge meters, PRV station meters, and bulk transfer points. Sourced from OSIsoft PI Historian SCADA telemetry and AMI bulk meters. Captures reading timestamp, measurement point reference, raw flow value, engineering unit, data quality flag, and source system. Foundation for NRW/UFW water balance calculations and hydraulic model calibration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` (
    `leak_detection_survey_id` BIGINT COMMENT 'Unique identifier for the leak detection survey record. Primary key.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: AMI endpoints generate leak alerts (leak_detection_enabled_flag, leak_alert_threshold_gpm) that directly trigger field leak detection surveys. Utilities track which AMI device initiated a survey for a',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: Leak survey findings inform asset condition grades, remaining useful life estimates, and repair/replace decisions. Direct linkage supports proactive asset management and CIP prioritization in water ut',
    `conservation_program_id` BIGINT COMMENT 'Foreign key linking to service.conservation_program. Business justification: Leak detection surveys are frequently executed as part of NRW/conservation programs. Linking surveys to the sponsoring conservation program enables program performance reporting (actual_water_savings_',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Leak surveys identify infrastructure deficiencies requiring corrective action under consent decrees, enforcement orders, or water loss control programs. Survey findings must link to corrective action',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) in which the surveyed pipe segment is located, used for Non-Revenue Water (NRW) analysis.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the specific distribution main or service line segment that was surveyed for leaks.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which the surveyed pipe segment operates.',
    `registry_id` BIGINT COMMENT 'Reference to the internal field crew or team that performed the leak detection survey.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory sanitary surveys frequently mandate leak detection surveys as a corrective finding. Linking leak_detection_survey to the regulatory_inspection that triggered it documents the regulatory bas',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Leak surveys are performed as part of CIP project scoping (pre-construction baseline) or post-construction validation. Linking survey to project enables cost allocation, project outcome measurement, a',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order or service request that initiated this leak detection survey activity.',
    `ambient_noise_level` STRING COMMENT 'Qualitative assessment of ambient noise levels during the survey, which can affect acoustic leak detection effectiveness.. Valid values are `low|moderate|high`',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or manager who reviewed and approved the survey results.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey results were officially approved by a supervisor or manager.',
    `completed_date` DATE COMMENT 'The date on which the leak detection survey was marked as completed and results were finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection survey record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the reliability and accuracy of the survey data collected, used for quality assurance and analytics filtering.',
    `equipment_used` STRING COMMENT 'Description or list of specific leak detection equipment and instruments used during the survey (e.g., model numbers, device names).',
    `estimated_leak_rate_gpm` DECIMAL(18,2) COMMENT 'Estimated total leak flow rate for all leaks detected during this survey, measured in Gallons Per Minute (GPM).',
    `leak_locations_gis` STRING COMMENT 'Geographic coordinates or GIS feature identifiers for each leak location detected during the survey, typically stored as comma-separated latitude/longitude pairs or GIS asset IDs.',
    `leaks_found_count` STRING COMMENT 'Total number of leaks identified during this survey.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection survey record was last updated or modified.',
    `repair_work_order_generated` BOOLEAN COMMENT 'Indicates whether a repair work order was automatically or manually generated as a result of leaks found during this survey.',
    `scheduled_date` DATE COMMENT 'The originally planned or scheduled date for this leak detection survey, which may differ from the actual survey date.',
    `survey_cost_currency` STRING COMMENT 'Currency code for the survey cost amount. Defaults to USD for U.S. water utilities.. Valid values are `USD`',
    `survey_date` DATE COMMENT 'The calendar date on which the leak detection survey was conducted in the field.',
    `survey_end_time` TIMESTAMP COMMENT 'Timestamp when the field crew completed the leak detection survey activity.',
    `survey_length_feet` DECIMAL(18,2) COMMENT 'Total linear length of pipe surveyed during this leak detection activity, measured in feet.',
    `survey_method` STRING COMMENT 'The technology or technique used to conduct the leak detection survey (e.g., acoustic correlator, listening stick, ground-penetrating radar, leak noise logger).. Valid values are `acoustic_correlator|listening_stick|ground_penetrating_radar|leak_noise_logger|tracer_gas|thermal_imaging`',
    `survey_notes` STRING COMMENT 'Free-text field for technician observations, special conditions, challenges encountered, or additional context about the survey.',
    `survey_number` STRING COMMENT 'Business-facing unique identifier or reference number assigned to this leak detection survey for tracking and reporting purposes.',
    `survey_outcome` STRING COMMENT 'Final outcome or result classification of the leak detection survey activity.. Valid values are `leaks_detected|no_leaks_found|inconclusive|equipment_failure|weather_delay`',
    `survey_priority` STRING COMMENT 'Priority level assigned to this leak detection survey based on factors such as DMA performance, customer complaints, or infrastructure criticality.. Valid values are `routine|high|critical|emergency`',
    `survey_start_time` TIMESTAMP COMMENT 'Timestamp when the field crew began the leak detection survey activity.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the leak detection survey activity.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold|failed`',
    `technician_name` STRING COMMENT 'Name of the lead technician or operator who conducted the leak detection survey.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the survey, which may impact detection accuracy (e.g., rain, wind, temperature).',
    CONSTRAINT pk_leak_detection_survey PRIMARY KEY(`leak_detection_survey_id`)
) COMMENT 'Transactional record of field leak detection surveys conducted on distribution mains and service lines using acoustic correlators, listening sticks, or ground-penetrating radar. Captures survey date, survey method, crew/contractor, pipe segment surveyed, length surveyed (feet), leaks found count, leak locations (GIS), estimated leak rate (GPM), and survey outcome status. Feeds into repair work order generation and NRW reduction programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` (
    `main_break_id` BIGINT COMMENT 'Unique identifier for the distribution main break event. Primary key for the main break record.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the break occurred. Used for NRW (Non-Revenue Water) and UFW (Unaccounted-for Water) analysis.',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Main breaks are asset failure events requiring root cause analysis, MTBF/MTTR tracking, failure mode classification, and reliability analysis. Links distribution failures to enterprise failure trackin',
    `pipe_main_id` BIGINT COMMENT 'Reference to the distribution main pipe asset where the break occurred. Links to the distribution main asset registry.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone where the break occurred. Critical for hydraulic modeling and pressure management analysis.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Main breaks frequently trigger capital replacement projects. Tracking which CIP project was initiated by a break event is essential for asset management, root cause analysis, and justifying project pr',
    `boil_water_advisory_issued` BOOLEAN COMMENT 'Indicates whether a boil water advisory was issued to affected customers due to potential water quality compromise. True if advisory was issued, False otherwise.',
    `break_number` STRING COMMENT 'Business identifier for the main break event, typically formatted as MB-YYYYNNNNNN for external reference and reporting.. Valid values are `^MB-[0-9]{6,10}$`',
    `break_status` STRING COMMENT 'Current lifecycle status of the main break event: reported, dispatched, in progress, repaired, closed, or deferred.. Valid values are `reported|dispatched|in_progress|repaired|closed|deferred`',
    `break_timestamp` TIMESTAMP COMMENT 'Date and time when the main break was first detected or reported. Principal business event timestamp for the break occurrence.',
    `break_type` STRING COMMENT 'Classification of the main break failure mode: circumferential crack, longitudinal crack, blowout, joint failure, service line break, or corrosion pinhole.. Valid values are `circumferential|longitudinal|blowout|joint_failure|service_line_break|corrosion_pinhole`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the main break record was first created in the system. Audit trail timestamp for record creation.',
    `customers_affected_count` STRING COMMENT 'Number of customer accounts impacted by service disruption due to the main break.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when field crew was dispatched to the main break location.',
    `gis_feature_code` STRING COMMENT 'Reference to the GIS feature identifier in Esri ArcGIS for the main pipe segment where the break occurred.',
    `hydraulic_model_node_code` STRING COMMENT 'Reference to the node identifier in Innovyze InfoWater hydraulic model for network analysis and pressure simulation.',
    `installation_year` STRING COMMENT 'Year the pipe was originally installed in the distribution network.',
    `location_address` STRING COMMENT 'Street address or nearest intersection where the main break occurred. Organizational location data classified as confidential.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the main break location for GIS mapping and spatial analysis.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the main break location for GIS mapping and spatial analysis.',
    `notes` STRING COMMENT 'Free-text field for additional observations, special circumstances, or detailed notes about the main break event and repair.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure in the main at the time of break, measured in PSI (Pounds per Square Inch).',
    `pipe_age_years` STRING COMMENT 'Estimated age of the pipe at the time of break, calculated from installation date to break date, measured in years.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the failed pipe in inches.',
    `pipe_material` STRING COMMENT 'Material composition of the failed pipe: cast iron, ductile iron, PVC (polyvinyl chloride), HDPE (high-density polyethylene), steel, concrete, asbestos cement, or copper. [ENUM-REF-CANDIDATE: cast_iron|ductile_iron|pvc|hdpe|steel|concrete|asbestos_cement|copper — 8 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Priority classification assigned to the main break based on severity, customer impact, and safety considerations: emergency, urgent, high, medium, or low.. Valid values are `emergency|urgent|high|medium|low`',
    `regulatory_report_required` BOOLEAN COMMENT 'Indicates whether the main break requires regulatory reporting to EPA, state primacy agency, or Public Utilities Commission. True if reporting is required, False otherwise.',
    `repair_complete_timestamp` TIMESTAMP COMMENT 'Date and time when repair work was completed and the main was returned to service.',
    `repair_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the repair activity from start to completion, measured in hours.',
    `repair_method` STRING COMMENT 'Method used to repair the main break: clamp, sleeve, pipe replacement, joint repair, valve replacement, or temporary bypass.. Valid values are `clamp|sleeve|pipe_replacement|joint_repair|valve_replacement|temporary_bypass`',
    `repair_start_timestamp` TIMESTAMP COMMENT 'Date and time when repair work commenced on the main break.',
    `reported_by` STRING COMMENT 'Source of the main break report: customer, field crew, SCADA alert, patrol, third party, or internal inspection.. Valid values are `customer|field_crew|scada_alert|patrol|third_party|internal_inspection`',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the main break was officially reported to the utility operations center or SCADA system.',
    `root_cause` STRING COMMENT 'Identified root cause of the main break: corrosion, age deterioration, soil movement, freeze-thaw cycle, pressure surge, third-party damage, manufacturing defect, or unknown. [ENUM-REF-CANDIDATE: corrosion|age_deterioration|soil_movement|freeze_thaw|pressure_surge|third_party_damage|manufacturing_defect|unknown — 8 candidates stripped; promote to reference product]',
    `soil_condition` STRING COMMENT 'Soil condition at the break location: clay, sand, gravel, rock, mixed, corrosive, saturated, or unknown. Influences corrosion rates and pipe stability. [ENUM-REF-CANDIDATE: clay|sand|gravel|rock|mixed|corrosive|saturated|unknown — 8 candidates stripped; promote to reference product]',
    `traffic_impact` STRING COMMENT 'Impact of the main break on traffic and road access: none, lane closure, road closure, detour required, or emergency access restricted.. Valid values are `none|lane_closure|road_closure|detour_required|emergency_access_restricted`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the main break record was last modified. Audit trail timestamp for record updates.',
    `water_lost_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost during the break event, measured in gallons. Critical for NRW (Non-Revenue Water) and UFW (Unaccounted-for Water) reporting.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of the break: normal, freezing, extreme cold, heavy rain, drought, snow, or extreme heat. Relevant for freeze-thaw and soil movement analysis. [ENUM-REF-CANDIDATE: normal|freezing|extreme_cold|heavy_rain|drought|snow|extreme_heat — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_main_break PRIMARY KEY(`main_break_id`)
) COMMENT 'Transactional record of distribution network incidents including main breaks (pipe bursts, joint failures), planned shutdowns, and emergency/planned isolation events. Captures incident type, date/time, location (GIS coordinates, address, pipe main reference), failure mode (circumferential, longitudinal, blowout, joint) for breaks, valves operated with sequence for isolations, customers affected count and service addresses, estimated volume lost (gallons), repair method, repair duration, root cause classification, pressure zone impact, crew supervisor, and restoration confirmation timestamp. SSOT for outage management, customer notification, asset renewal prioritization, and regulatory reporting of service interruptions.';

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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `asset_owner` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `average_daily_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `bedding_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Bedding Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `break_history_count` SET TAGS ('dbx_business_glossary_term' = 'Break History Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `cathodic_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `coating_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Coating Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Burial Depth (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `downstream_node_code` SET TAGS ('dbx_business_glossary_term' = 'Downstream Node Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `fire_flow_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Capable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `gis_geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Geometry Well-Known Text (WKT)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `hazen_williams_c_factor` SET TAGS ('dbx_business_glossary_term' = 'Hazen-Williams C-Factor');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `joint_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Joint Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `last_break_date` SET TAGS ('dbx_business_glossary_term' = 'Last Break Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `length_feet` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Length (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Lifecycle Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|planned|under_construction|retired');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `lining_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Lining Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'utility|municipality|private|shared');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Material');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `max_flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flow Capacity (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `nominal_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Nominal Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pipe_number` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pipe_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pipe_type` SET TAGS ('dbx_value_regex' = 'transmission|distribution|service_lateral|fire_line|raw_water|reclaimed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pressure_class_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Class (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_business_glossary_term' = 'Street Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `street_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Service Line Connection Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|disconnected|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `curb_stop_installed` SET TAGS ('dbx_business_glossary_term' = 'Curb Stop Valve Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `curb_stop_location` SET TAGS ('dbx_business_glossary_term' = 'Curb Stop Valve Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Service Line Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Service Line Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Service Line Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `last_leak_repair_date` SET TAGS ('dbx_business_glossary_term' = 'Last Leak Repair Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `lcrr_classification` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Material Classification');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `lcrr_classification` SET TAGS ('dbx_value_regex' = 'lead|lead_status_unknown|galvanized_requiring_replacement|non_lead');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `lcrr_inventory_verified` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Inventory Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `lcrr_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `lcrr_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `lcrr_verification_method` SET TAGS ('dbx_value_regex' = 'visual_inspection|excavation|records_review|predictive_modeling|customer_survey');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `leak_history_count` SET TAGS ('dbx_business_glossary_term' = 'Service Line Leak History Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `length_feet` SET TAGS ('dbx_business_glossary_term' = 'Service Line Length (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Line Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Service Line Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|shared|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `replacement_method` SET TAGS ('dbx_business_glossary_term' = 'Service Line Replacement Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `replacement_method` SET TAGS ('dbx_value_regex' = 'open_cut|trenchless|directional_drill|pipe_bursting|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `replacement_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Service Line Replacement Priority Score');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_line_number` SET TAGS ('dbx_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Line Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|fire_service|irrigation');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `tap_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Main Tap Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Storage Facility ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'gravity|pumped|combination|elevated|booster');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Zone ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ALTER COLUMN `dma_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Water Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `burial_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Valve Burial Depth (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Valve City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Valve Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `bury_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Bury Depth in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Municipality City Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `static_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `valve_turns_to_open` SET TAGS ('dbx_business_glossary_term' = 'Valve Turns Required to Fully Open');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Street Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Street Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_available` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Available');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Capacity in Kilowatts (kW)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_phase` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Phase');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_phase` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `power_supply_voltage` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `scada_integrated` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integrated');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'booster|transfer|lift|high_service|low_service|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `suction_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Suction Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `total_dynamic_head_ft` SET TAGS ('dbx_business_glossary_term' = 'Total Dynamic Head (TDH) in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `vfd_configuration` SET TAGS ('dbx_business_glossary_term' = 'Variable Frequency Drive (VFD) Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `vfd_equipped` SET TAGS ('dbx_business_glossary_term' = 'Variable Frequency Drive (VFD) Equipped');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `scada_flow_meter_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Flow Meter Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `scada_level_sensor_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Level Sensor Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `scada_pressure_sensor_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Pressure Sensor Tag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `security_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Security System Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `structural_condition` SET TAGS ('dbx_business_glossary_term' = 'Structural Condition');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `structural_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_material` SET TAGS ('dbx_business_glossary_term' = 'Tank Material');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_material` SET TAGS ('dbx_value_regex' = 'steel|concrete|prestressed_concrete|composite|fiberglass');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_name` SET TAGS ('dbx_business_glossary_term' = 'Tank Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_type` SET TAGS ('dbx_business_glossary_term' = 'Tank Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_type` SET TAGS ('dbx_value_regex' = 'elevated|ground_level|standpipe|reservoir|clearwell|hydropneumatic');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `usable_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Usable Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `flow_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Reading Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit (F)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `totalizer_reading` SET TAGS ('dbx_business_glossary_term' = 'Totalizer Reading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|corrected');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_detection_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Survey Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Segment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `survey_cost_currency` SET TAGS ('dbx_value_regex' = 'USD');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `hydraulic_model_node_code` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Node Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
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
