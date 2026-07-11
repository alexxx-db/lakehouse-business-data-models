-- Schema for Domain: distribution | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`distribution` COMMENT 'Owns the potable water distribution network topology, hydraulic modeling, and operational data including mains, service lines, valves, PRVs, hydrants, pump stations, storage tanks, DMAs, and pressure zones. Integrates with Esri ArcGIS and Innovyze InfoWater for network modeling, NRW/UFW analysis, and pressure (PSI) and flow (GPM/MGD) management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` (
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the potable water distribution main. Primary key for the pipe main master record.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Distribution infrastructure operates under utility operating permits. Pipe mains must reference permits for regulatory compliance tracking, permit condition enforcement, and water quality monitoring r',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) to which this pipe main is assigned. DMAs are isolated network zones used for water balance analysis, non-revenue water (NRW) detection, and leak management.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Water mains are capital assets requiring depreciation tracking, GASB reporting, and rate base valuation. Essential for annual financial statements, regulatory asset reporting, and rate case filings.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Pipes installed by contractors tracked for installation quality, warranty claims, contractor performance evaluation. Essential for capital project management and contractor accountability. Normalizes',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pipes are procured materials with specifications (material type, diameter, coating) tracked in material master. Essential for asset lifecycle management, replacement planning, procurement history, and',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which this pipe main operates. Pressure zones are geographic areas maintained at specific pressure ranges (PSI) to ensure adequate service and prevent over-pressurization.',
    `network_node_id` BIGINT COMMENT 'Identifier of the upstream hydraulic node (junction, tank, reservoir, or pump) in the distribution network topology. Used for hydraulic modeling in Innovyze InfoWater and network connectivity analysis.',
    `asset_owner` STRING COMMENT 'Legal owner of the pipe main asset. Typically the water utility, but may be a municipality, private developer, or other entity. Important for maintenance responsibility and capital planning.',
    `average_daily_flow_gpm` DECIMAL(18,2) COMMENT 'Average daily flow through the pipe main in gallons per minute (GPM), typically derived from SCADA flow meters or hydraulic model calibration. Used for demand analysis and capacity utilization assessment.',
    `bedding_type` STRING COMMENT 'Type of bedding material and installation method used to support the pipe main in the trench. Common types include sand, gravel, crushed stone, and controlled low-strength material (CLSM). Affects pipe structural integrity and longevity.',
    `break_history_count` STRING COMMENT 'Total number of main breaks or failures recorded for this pipe main since installation. High break counts indicate poor condition and prioritize replacement. Used for reliability analysis and risk assessment.',
    `cathodic_protection_flag` BOOLEAN COMMENT 'Indicates whether the pipe main is protected by a cathodic protection system to prevent corrosion. True if cathodic protection is installed and active; false otherwise. Primarily applicable to metallic pipes (ductile iron, steel).',
    `coating_type` STRING COMMENT 'Exterior coating material applied to the pipe main to protect against soil corrosion and environmental degradation. Common coatings include polyethylene wrap, epoxy, and zinc.',
    `condition_assessment_date` DATE COMMENT 'Date of the most recent condition assessment or inspection of the pipe main. Used to track assessment currency and schedule future inspections.',
    `condition_grade` STRING COMMENT 'Current physical condition assessment grade of the pipe main based on inspection, break history, and age. Used for risk-based capital planning and replacement prioritization.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipe main record was first created in the system. Used for data lineage and audit trail.',
    `criticality_rating` STRING COMMENT 'Business criticality rating of the pipe main based on consequence of failure analysis. Considers factors such as customer impact, fire protection, hospital service, and redundancy. Critical mains receive priority for maintenance and replacement.. Valid values are `critical|high|medium|low`',
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
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Lead service line replacement programs (LCRR compliance) are tracked as CIP projects. Each service line replacement requires project attribution for cost tracking, grant reimbursement, regulatory repo',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Service connections operate under utility permits. LCRR compliance requires linking service lines to permit conditions for lead/copper monitoring, material inventory reporting, and replacement program',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer billing account served by this service line. Links service infrastructure to customer billing domain.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Service lines are capitalized infrastructure requiring depreciation and asset valuation, especially critical for LCRR lead replacement cost tracking and capital improvement planning in rate cases.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Service line installation/replacement contractors tracked for LCRR program contractor management, installation quality assurance, performance tracking, and warranty management in lead service line rep',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Service lines are procured materials (copper, lead, plastic). Critical for LCRR compliance requiring material specification tracking and procurement records for lead service line inventory and replace',
    `metering_meter_id` BIGINT COMMENT 'Reference to the water meter installed at the terminus of this service line for consumption measurement.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Each service line originates from a distribution main; linking to pipe_main provides a parent relationship and eliminates the need for storing pipe_main details redundantly.',
    `premise_id` BIGINT COMMENT 'Reference to the physical premise or property location served by this service line.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Service lines are mandatory Lead & Copper Rule sampling locations. Tier 1/2/3 sites are service line addresses. Essential for LCR compliance monitoring, LCRR inventory verification, and tracking high-',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service lines are capital assets requiring LCRR compliance tracking, depreciation schedules, and replacement cost accounting. Essential for regulatory inventory reporting and financial asset valuation',
    `city` STRING COMMENT 'City or municipality where the service line is located.',
    `connection_status` STRING COMMENT 'Current operational status of the service line connection indicating whether it is actively serving a customer or has been deactivated.. Valid values are `active|inactive|abandoned|disconnected|pending_activation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was first created in the system.',
    `curb_stop_installed` BOOLEAN COMMENT 'Indicates whether a curb stop shutoff valve is installed on the service line for isolation purposes.',
    `curb_stop_location` STRING COMMENT 'Descriptive location of the curb stop valve for field crew reference during service shutoff operations.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the service line pipe measured in inches. Typical residential service lines range from 0.75 to 2.0 inches.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area (DMA) containing this service line. Used for Non-Revenue Water (NRW) analysis and leak detection.',
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
    `postal_code` STRING COMMENT 'Postal or ZIP code for the service line location.',
    `pressure_zone_code` STRING COMMENT 'Code identifying the hydraulic pressure zone within the distribution network where this service line is located. Used for pressure management and hydraulic modeling.',
    `replacement_method` STRING COMMENT 'Planned or executed method for service line replacement. Trenchless methods minimize surface disruption.. Valid values are `open_cut|trenchless|directional_drill|pipe_bursting|not_applicable`',
    `replacement_priority_score` STRING COMMENT 'Calculated priority score for service line replacement based on age, material, leak history, and LCRR compliance requirements. Higher scores indicate higher replacement urgency.',
    `service_line_number` STRING COMMENT 'Business identifier or tag number assigned to the service connection for field operations and customer reference.',
    `service_type` STRING COMMENT 'Classification of the service line based on customer type and usage category.. Valid values are `residential|commercial|industrial|municipal|fire_service|irrigation`',
    `state_province` STRING COMMENT 'State or province where the service line is located.',
    `street_address` STRING COMMENT 'Street address of the property served by this service line for field operations and customer correspondence.',
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
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee or team responsible for monitoring and maintaining the DMA. Used for accountability and work assignment.',
    `dma_responsible_operator_employee_id` BIGINT COMMENT 'Reference to the workforce employee or team responsible for monitoring and maintaining the DMA. Used for accountability and work assignment.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone within which this DMA operates. Pressure zones define areas of similar hydraulic pressure managed by Pressure Reducing Valves (PRVs) and pump stations.',
    `maintenance_zone_id` BIGINT COMMENT 'Reference to the maintenance zone or service district to which the DMA belongs. Used for work order routing and resource planning.',
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
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) containing this valve. DMAs are isolated network sections with defined boundaries and metered inflows/outflows, used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Valves on DMA boundaries are critical for isolation and flow control.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Valves are capitalized assets requiring depreciation tracking and condition-based valuation for asset management financial reporting, replacement cost analysis, and GASB compliance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Valves are procured inventory items with manufacturer specifications. Essential for spare parts management, warranty tracking, equipment standardization programs, and maintenance planning. Manufacture',
    `registry_id` BIGINT COMMENT 'Reference to the asset registry record in the Computerized Maintenance Management System (CMMS). Links this valve to IBM Maximo Asset Management for maintenance tracking, work orders, and lifecycle management.',
    `network_registry_id` BIGINT COMMENT 'Reference to the asset registry record in the Computerized Maintenance Management System (CMMS). Links this valve to IBM Maximo Asset Management for maintenance tracking, work orders, and lifecycle management.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the water main on which this valve is installed. Links the valve to the pipe segment for network topology modeling in Esri ArcGIS and Innovyze InfoWater.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which this valve is located. Pressure zones are geographic areas maintained at specific pressure ranges (measured in Pounds per Square Inch - PSI) to ensure adequate service and prevent pipe bursts. Critical for hydraulic modeling in Innovyze InfoWater.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Valve suppliers tracked for approved vendor list management, quality assurance, delivery performance, and warranty management. Essential for procurement compliance and equipment standardization progra',
    `burial_depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the valve operating nut. Used for excavation planning, valve box sizing, and accessibility assessment. Typical range is 3-8 feet depending on frost line and main depth.',
    `city` STRING COMMENT 'City or municipality in which the valve is located. Used for jurisdictional reporting and geographic analysis.',
    `condition_rating` STRING COMMENT 'Assessment of the valves physical condition based on the most recent inspection. Excellent: like new, no defects; Good: minor wear, fully functional; Fair: moderate wear, functional with minor issues; Poor: significant deterioration, may fail soon; Critical: immediate replacement required. Used for risk-based asset management and Capital Expenditure (CAPEX) planning.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve record was first created in the system. Used for data lineage, audit trails, and compliance with data governance policies.',
    `criticality_rating` STRING COMMENT 'Business criticality of the valve based on its role in the distribution network. Critical valves control large trunk mains or serve hospitals/fire protection; high criticality valves isolate major zones; medium and low criticality valves serve smaller areas. Drives maintenance prioritization and replacement sequencing.. Valid values are `critical|high|medium|low`',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` (
    `prv_station_id` BIGINT COMMENT 'Unique identifier for the PRV station record. Primary key.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that the PRV station serves or controls for NRW analysis.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: PRV stations are major capital assets with significant acquisition costs requiring depreciation tracking for rate base calculations and capital asset inventory in financial statements.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: PRV equipment is procured with specific make/model specifications. Required for maintenance parts inventory, equipment standardization, lifecycle replacement planning, and capital asset management. Ma',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the upstream hydraulic pressure zone feeding into the PRV station.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: PRV stations are major capital assets requiring PM schedules, condition assessments, criticality ratings, and financial tracking. Standard practice for enterprise asset management in water distributio',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: PRV equipment suppliers tracked for maintenance service contracts, equipment procurement, technical support, and warranty management. Critical for pressure management system reliability and vendor per',
    `address` STRING COMMENT 'Physical street address or location description of the PRV station for field operations and emergency response.',
    `asset_criticality` STRING COMMENT 'Business criticality classification of the PRV station based on impact to service delivery and network reliability.. Valid values are `critical|high|medium|low`',
    `bypass_configuration` STRING COMMENT 'Type of bypass arrangement installed at the PRV station for maintenance and emergency operations.. Valid values are `none|manual|automatic|redundant`',
    `calibration_frequency_months` STRING COMMENT 'Standard interval in months between required calibration activities for the PRV station.',
    `city` STRING COMMENT 'City or municipality where the PRV station is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PRV station record was first created in the system.',
    `design_flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the PRV station in Gallons Per Minute (GPM) under normal operating conditions.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier in the Esri ArcGIS system linking the PRV station to the spatial network model.',
    `hydraulic_model_node_code` STRING COMMENT 'Node identifier in the Innovyze InfoWater hydraulic model representing the PRV station for network analysis.',
    `installation_date` DATE COMMENT 'Date when the PRV station was originally installed and commissioned in the distribution network.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration or pressure set point verification performed on the PRV.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the PRV station record was most recently updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the PRV station location in decimal degrees for GIS mapping.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the PRV station location in decimal degrees for GIS mapping.',
    `maximo_asset_number` STRING COMMENT 'Asset number in IBM Maximo CMMS for work order management and maintenance tracking.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or maintenance inspection of the PRV.',
    `notes` STRING COMMENT 'Free-form text field for operational notes, special instructions, or historical information about the PRV station.',
    `operational_status` STRING COMMENT 'Current operational state of the PRV station in the distribution network lifecycle.. Valid values are `active|inactive|standby|maintenance|decommissioned|planned`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the PRV station asset.. Valid values are `utility_owned|customer_owned|shared|leased`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the PRV station location.',
    `prv_serial_number` STRING COMMENT 'Unique serial number of the pressure reducing valve equipment for warranty and maintenance tracking.',
    `rtu_code` STRING COMMENT 'Identifier of the Remote Terminal Unit (RTU) device installed at the PRV station for SCADA communication.',
    `scada_tag_flow_rate` DECIMAL(18,2) COMMENT 'OSIsoft PI Historian tag reference for real-time flow rate monitoring via SCADA system.',
    `scada_tag_inlet_pressure` STRING COMMENT 'OSIsoft PI Historian tag reference for real-time inlet pressure monitoring via SCADA system.',
    `scada_tag_outlet_pressure` STRING COMMENT 'OSIsoft PI Historian tag reference for real-time outlet pressure monitoring via SCADA system.',
    `set_point_pressure_psi` DECIMAL(18,2) COMMENT 'Target outlet pressure in Pounds per Square Inch (PSI) that the PRV is configured to maintain.',
    `state` STRING COMMENT 'State or province where the PRV station is located.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the PRV station for asset tracking and GIS integration.',
    `station_name` STRING COMMENT 'Business name or designation of the PRV station for operational reference.',
    `station_type` STRING COMMENT 'Classification of the PRV station installation type based on physical configuration.. Valid values are `inline|vault|above_ground|below_ground|chamber|kiosk`',
    `telemetry_status` STRING COMMENT 'Current connectivity status of the SCADA telemetry equipment at the PRV station.. Valid values are `online|offline|intermittent|not_installed`',
    `valve_size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the PRV in inches, indicating flow capacity and pipe connection size.',
    CONSTRAINT pk_prv_station PRIMARY KEY(`prv_station_id`)
) COMMENT 'Master record for Pressure Reducing Valve (PRV) stations that regulate pressure between hydraulic zones. Captures station name, location (GIS coordinates), inlet pressure zone, outlet pressure zone, PRV make/model, set point pressure (PSI), flow capacity (GPM), bypass configuration, SCADA tag references (OSIsoft PI Historian), telemetry status, and last calibration date. Critical for pressure management and zone boundary control.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` (
    `hydrant_id` BIGINT COMMENT 'Unique identifier for the fire hydrant asset in the distribution network. Primary key.',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) to which the hydrant belongs, used for Non-Revenue Water (NRW) analysis and leak detection programs.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Hydrants are capitalized assets tracked for depreciation, replacement cost analysis, annual GASB reporting, insurance valuation, and capital planning in water utilities.',
    `pipe_main_id` BIGINT COMMENT 'Identifier of the nearest or connected water main pipe from which the hydrant is fed, used for hydraulic modeling and network topology analysis.',
    `hydrant_pipe_main_id` BIGINT COMMENT 'Identifier of the nearest or connected water main pipe from which the hydrant is fed, used for hydraulic modeling and network topology analysis.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Hydrants are standardized procured assets. Essential for spare parts inventory, replacement programs, manufacturer warranty tracking, and fire flow compliance. Manufacturer and model specifications no',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone or hydraulic district in which the hydrant is located, used for pressure management and network segmentation.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Hydrants are individual assets with inspection schedules, maintenance requirements, replacement cost tracking, and regulatory compliance needs (NFPA/ISO). Essential for asset lifecycle management and',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Hydrant manufacturers/suppliers tracked for warranty management, product recall tracking, approved vendor compliance, and fire protection equipment standards. Essential for public safety and regulator',
    `bury_depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the hydrant valve or base, critical for freeze protection and installation specifications.',
    `city` STRING COMMENT 'City or municipality name where the hydrant is located.',
    `condition_status` STRING COMMENT 'Current physical condition assessment of the hydrant based on inspection findings: excellent (like new), good (minor wear), fair (functional with moderate wear), poor (requires repair), critical (non-functional or unsafe).. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hydrant record was first created in the asset management system.',
    `criticality_rating` STRING COMMENT 'Business criticality rating based on consequence-of-failure analysis: critical (hospitals, schools, high-density areas), high (commercial districts), medium (residential), low (rural or redundant coverage).. Valid values are `critical|high|medium|low`',
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
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) that this pump station serves for NRW and UFW analysis.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Pump stations are high-value capital assets central to rate base and depreciation schedules, essential for regulatory asset reporting, financial statements, and rate case filings.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pump equipment is major procured capital asset. Critical for parts inventory management, equipment specifications, procurement history for capital planning, and maintenance program management in water',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone served by this pump station for hydraulic modeling and network segmentation.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Pump stations are critical assets requiring comprehensive lifecycle management, PM scheduling, condition assessments, criticality ratings, and depreciation tracking. Core requirement for enterprise as',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Pump stations are major facilities subject to sanitary surveys and regulatory inspections for operational reliability, maintenance practices, and cross-connection control. Inspection findings must ref',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Pump equipment suppliers/service contractors tracked for maintenance contracts, equipment procurement, service level agreements, and emergency response. Critical for system reliability and operational',
    `address_line_1` STRING COMMENT 'Primary street address of the pump station facility for physical access and emergency response.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number or suite for the pump station facility.',
    `asset_condition_rating` STRING COMMENT 'Current condition assessment rating of the pump station based on inspection and maintenance records.. Valid values are `excellent|good|fair|poor|critical`',
    `backup_generator_available` BOOLEAN COMMENT 'Indicates whether the pump station has a backup generator for emergency power supply.',
    `backup_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Capacity of the backup generator in kilowatts (kW) if available.',
    `city` STRING COMMENT 'City or municipality where the pump station is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the pump station is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump station record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business criticality rating indicating the importance of this pump station to system operations and service delivery.. Valid values are `critical|high|medium|low`',
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
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Storage tanks are major capital assets requiring depreciation, insurance valuation, and regulatory reporting for GASB compliance, rate base calculations, and asset valuation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Tanks are major capital assets with material specifications. Required for coating materials procurement, structural component tracking, rehabilitation planning, and regulatory compliance for water sto',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone served by this storage tank. Pressure zones are geographic areas of the distribution network maintained at similar hydraulic pressure ranges.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Storage tanks are major capital assets with regulatory inspection requirements (AWWA D100), condition assessments, coating schedules, and depreciation tracking. Essential for asset management and fina',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that this storage tank serves. DMAs are discrete zones used for water balance analysis and Non-Revenue Water (NRW) management.',
    `storage_dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) that this storage tank serves. DMAs are discrete zones used for water balance analysis and Non-Revenue Water (NRW) management.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Tank construction/coating contractors tracked for construction quality, warranty tracking, maintenance service contracts, and regulatory compliance. Essential for water storage infrastructure manageme',
    `asset_criticality_rating` STRING COMMENT 'Risk-based criticality classification of the storage tank based on consequence of failure analysis considering population served, redundancy, and system impact: critical (single point of failure for large population), high (significant impact), medium (moderate impact), or low (minimal impact with redundancy available).. Valid values are `critical|high|medium|low`',
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
    `regulatory_inspection_status` STRING COMMENT 'Current compliance status with state drinking water program and EPA inspection requirements: compliant (meets all requirements), non-compliant (deficiencies identified), pending-review (inspection submitted awaiting approval), or not-applicable (exempt from inspection requirements).. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
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
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) associated with this flow measurement. Used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis.',
    `point_id` BIGINT COMMENT 'Reference to the physical location or asset where the flow measurement was captured (DMA inlet/outlet meter, pump station discharge meter, PRV station meter, or bulk transfer point).',
    `metering_meter_id` BIGINT COMMENT 'Reference to the specific flow meter device that captured this reading. Links to asset registry for meter calibration history and maintenance records.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` (
    `network_reading_id` BIGINT COMMENT 'Primary key for network_reading',
    `read_id` BIGINT COMMENT 'Unique identifier for the network_reading data product (auto-inserted pre-linking).',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: network_reading captures telemetry measurements within the distribution network. Each reading is taken at a location within a specific DMA (District Metered Area). This FK establishes the DMA context',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: network_reading captures pressure and flow telemetry. Each reading is taken within a specific pressure zone, which is critical for hydraulic model calibration and pressure management. This FK enables',
    CONSTRAINT pk_network_reading PRIMARY KEY(`network_reading_id`)
) COMMENT 'Transactional record of all distribution network telemetry measurements including pressure (PSI), flow (GPM/MGD), tank level (feet), and velocity (fps) captured from SCADA systems (OSIsoft PI Historian), AMI bulk meters, field data loggers, and pressure transducers. Captures reading timestamp, measurement point location (GIS reference, asset reference), measurement type, raw value, engineering unit, interval statistics (min/max/average), data quality flag, and source system identifier. Foundation for NRW/UFW water balance calculations, pressure zone compliance monitoring, transient detection, pump station performance tracking, and hydraulic model calibration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` (
    `distribution_nrw_water_balance_id` BIGINT COMMENT 'Unique identifier for the water balance record. Primary key for the NRW water balance data product.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area for which this water balance is calculated. Links to the DMA master data in the distribution network domain.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: NRW water balance audits are submitted to regulators as part of water loss control programs, permit reporting requirements, and infrastructure efficiency mandates. Audits must link to regulatory submi',
    `revenue_requirement_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_requirement. Business justification: NRW volumes directly impact revenue requirements and rate calculations for rate case revenue requirement calculations, water loss cost recovery, and regulatory reporting.',
    `apparent_losses_mg` DECIMAL(18,2) COMMENT 'Volume of water that is consumed but not measured or billed due to customer meter inaccuracies, data handling errors, and unauthorized consumption (theft), measured in million gallons.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this water balance audit. Supports accountability and regulatory compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this water balance audit was formally approved by management or regulatory authority. Marks the transition to official reporting status.',
    `audit_methodology` STRING COMMENT 'Description of the methodology and tools used to conduct the water balance audit (e.g., AWWA Free Water Audit Software v6.0, IWA Water Balance, custom methodology).',
    `audit_period_end_date` DATE COMMENT 'The last day of the reporting period for this water balance calculation. Typically the last day of a month or year.',
    `audit_period_start_date` DATE COMMENT 'The first day of the reporting period for this water balance calculation. Typically the first day of a month or year.',
    `audit_period_type` STRING COMMENT 'The frequency or granularity of the water balance reporting period (monthly, quarterly, or annual).. Valid values are `monthly|quarterly|annual`',
    `audit_status` STRING COMMENT 'Current workflow status of the water balance audit record. Tracks the audit through draft, submission, validation, approval, and publication stages.. Valid values are `draft|submitted|validated|approved|published`',
    `auditor_name` STRING COMMENT 'Name of the person or team responsible for preparing and validating this water balance audit. Supports accountability and quality assurance.',
    `authorized_consumption_mg` DECIMAL(18,2) COMMENT 'Total volume of metered and unmetered water taken by registered customers, the water utility, and others who are implicitly or explicitly authorized to do so by the water utility, measured in million gallons.',
    `average_system_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure in the distribution system during the audit period, measured in pounds per square inch. Higher pressure increases leakage rates. Used in UARL calculation.',
    `billed_metered_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water that is metered and billed to customers during the audit period, measured in million gallons. This is the primary revenue-generating component.',
    `billed_unmetered_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water that is billed to customers but not metered (e.g., flat-rate customers), measured in million gallons. Estimated based on customer count and average usage.',
    `comments` STRING COMMENT 'Free-text field for auditor notes, data quality issues, assumptions made, or other contextual information relevant to the interpretation of this water balance record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this water balance record was first created in the system. Part of audit trail for data lineage and compliance.',
    `current_annual_real_losses_mg` DECIMAL(18,2) COMMENT 'Annualized volume of real losses (physical leakage) in the distribution system, measured in million gallons per year. Used in the calculation of Infrastructure Leakage Index.',
    `customer_meter_inaccuracies_mg` DECIMAL(18,2) COMMENT 'Volume of water consumed but not registered by customer meters due to meter under-registration, measured in million gallons. Typically estimated based on meter age and testing data.',
    `data_grading` STRING COMMENT 'AWWA Water Audit Software data grading (1-10 scale) where 1-3 is poor, 4-6 is fair, 7-8 is good, and 9-10 is excellent. Reflects the overall quality and reliability of the audit data. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|10 — 10 candidates stripped; promote to reference product]',
    `data_handling_errors_mg` DECIMAL(18,2) COMMENT 'Volume of water lost due to billing system errors, data transfer errors, and accounting mistakes, measured in million gallons. Estimated based on billing system audits.',
    `data_validity_score` STRING COMMENT 'AWWA Water Audit Software data validity score (0-100) indicating the reliability and accuracy of the input data used in the water balance calculation. Higher scores indicate more reliable audits.',
    `infrastructure_leakage_index` DECIMAL(18,2) COMMENT 'Ratio of Current Annual Real Losses (CARL) to Unavoidable Annual Real Losses (UARL). Dimensionless indicator of how well the distribution system is managed relative to its physical characteristics. ILI < 2 is excellent, 2-4 is good, 4-8 is fair, > 8 is poor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this water balance record was last updated. Supports change tracking and audit trail requirements.',
    `leakage_on_service_connections_mg` DECIMAL(18,2) COMMENT 'Volume of water lost through leaks on service connections from the main to the customer meter, measured in million gallons. Includes leaks on both utility-owned and customer-owned portions.',
    `leakage_on_storage_tanks_mg` DECIMAL(18,2) COMMENT 'Volume of water lost through leaks and overflows at storage tanks and reservoirs, measured in million gallons. Includes structural leaks and operational overflows.',
    `leakage_on_transmission_mains_mg` DECIMAL(18,2) COMMENT 'Volume of water lost through leaks and breaks on transmission and distribution mains, measured in million gallons. Includes both reported and unreported leaks.',
    `nrw_percentage` DECIMAL(18,2) COMMENT 'Non-Revenue Water expressed as a percentage of system input volume. Calculated as (NRW Volume / System Input Volume) × 100. Industry benchmark for water loss performance.',
    `nrw_volume_mg` DECIMAL(18,2) COMMENT 'Total volume of water that does not generate revenue for the utility, calculated as system input volume minus billed authorized consumption, measured in million gallons. Key performance indicator for water loss management.',
    `real_losses_mg` DECIMAL(18,2) COMMENT 'Volume of water physically lost from the distribution system through leaks, breaks, and overflows on mains, service connections, and storage tanks, measured in million gallons.',
    `service_connection_count` STRING COMMENT 'Total number of active service connections in the system or DMA during the audit period. Used in UARL calculation and for normalizing leakage metrics.',
    `system_input_volume_mg` DECIMAL(18,2) COMMENT 'Total volume of water introduced into the distribution system during the audit period, measured in million gallons. Represents the sum of all water entering the system from treatment plants, wells, and purchased sources.',
    `total_main_length_miles` DECIMAL(18,2) COMMENT 'Total length of transmission and distribution mains in the system or DMA, measured in miles. Used in UARL calculation and for normalizing leakage metrics.',
    `ufw_percentage` DECIMAL(18,2) COMMENT 'Unaccounted-for Water expressed as a percentage of system input volume. Calculated as (UFW Volume / System Input Volume) × 100. Legacy metric still used in some jurisdictions.',
    `ufw_volume_mg` DECIMAL(18,2) COMMENT 'Legacy term for water losses, calculated as system input volume minus authorized consumption, measured in million gallons. Equivalent to water losses in modern AWWA methodology.',
    `unauthorized_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water consumed through illegal connections, meter tampering, or theft, measured in million gallons. Estimated based on field investigations and industry benchmarks.',
    `unavoidable_annual_real_losses_mg` DECIMAL(18,2) COMMENT 'Theoretical minimum achievable annual real losses for a well-maintained and well-managed system, calculated based on system characteristics (main length, service connections, pressure). Used as the denominator in ILI calculation.',
    `unbilled_authorized_consumption_mg` DECIMAL(18,2) COMMENT 'Volume of water used for authorized purposes but not billed, such as firefighting, main flushing, street cleaning, and utility operations, measured in million gallons.',
    `water_losses_mg` DECIMAL(18,2) COMMENT 'Total volume of water lost in the distribution system, calculated as system input volume minus authorized consumption, measured in million gallons. Comprises apparent losses and real losses.',
    CONSTRAINT pk_distribution_nrw_water_balance PRIMARY KEY(`distribution_nrw_water_balance_id`)
) COMMENT 'Analytical and operational record for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) management per AWWA Free Water Audit methodology. Includes periodic (monthly/annual) water balance calculations per DMA and system-wide: system input volume (MGD), authorized consumption (billed metered, billed unmetered, unbilled authorized), apparent losses (meter inaccuracies, unauthorized consumption), real losses (leakage), NRW volume/percentage, and Infrastructure Leakage Index (ILI). Also captures leak detection survey records: survey date, method (acoustic correlator, listening stick, GPR), pipe segment surveyed, length surveyed (feet), leaks found, estimated leak rate (GPM), and survey outcome. SSOT for water loss performance tracking and leakage reduction program management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` (
    `leak_detection_survey_id` BIGINT COMMENT 'Unique identifier for the leak detection survey record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Leak surveys are performed as part of CIP project scoping (pre-construction baseline) or post-construction validation. Linking survey to project enables cost allocation, project outcome measurement, a',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Leak surveys identify infrastructure deficiencies requiring corrective action under consent decrees, enforcement orders, or water loss control programs. Survey findings must link to corrective action',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: Leak survey findings inform asset condition grades, remaining useful life estimates, and repair/replace decisions. Direct linkage supports proactive asset management and CIP prioritization in water ut',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Leak detection costs are allocated across pressure zones/DMAs for cost recovery and rate design in cost-of-service studies, rate case cost allocation, and NRW program tracking.',
    `crew_id` BIGINT COMMENT 'Reference to the internal field crew or team that performed the leak detection survey.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) in which the surveyed pipe segment is located, used for Non-Revenue Water (NRW) analysis.',
    `grant_expenditure_id` BIGINT COMMENT 'Foreign key linking to finance.grant_expenditure. Business justification: Leak detection programs often funded by state/federal grants (EPA WIFIA, state revolving funds) requiring grant compliance reporting, eligible cost tracking, and drawdown documentation.',
    `vendor_id` BIGINT COMMENT 'Reference to the external contractor or vendor that performed the leak detection survey, if outsourced.',
    `leak_vendor_id` BIGINT COMMENT 'Reference to the external contractor or vendor that performed the leak detection survey, if outsourced.',
    `leak_detection_event_id` BIGINT COMMENT 'Foreign key linking to metering.leak_detection_event. Business justification: Acoustic leak surveys investigate AMI-generated continuous flow alerts. Field crews need to reference which AMI leak event triggered the survey and update resolution status. Enables closed-loop leak m',
    `nrw_program_id` BIGINT COMMENT 'Reference to the Non-Revenue Water (NRW) reduction program or initiative under which this survey was conducted.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the specific distribution main or service line segment that was surveyed for leaks.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which the surveyed pipe segment operates.',
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
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Main breaks frequently trigger capital replacement projects. Tracking which CIP project was initiated by a break event is essential for asset management, root cause analysis, and justifying project pr',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.public_notification. Business justification: Main breaks that compromise water quality trigger public notification requirements under Safe Drinking Water Act. Boil water advisories and service disruption notices must link to specific break event',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Emergency repair costs are allocated to cost centers/pressure zones for budgeting and rate recovery in O&M expense tracking, cost-of-service analysis, and budget variance reporting.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the break occurred. Used for NRW (Non-Revenue Water) and UFW (Unaccounted-for Water) analysis.',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Main breaks are asset failure events requiring root cause analysis, MTBF/MTTR tracking, failure mode classification, and reliability analysis. Links distribution failures to enterprise failure trackin',
    `pipe_main_id` BIGINT COMMENT 'Reference to the distribution main pipe asset where the break occurred. Links to the distribution main asset registry.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone where the break occurred. Critical for hydraulic modeling and pressure management analysis.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or team that performed the repair work.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Break repairs require specific materials (pipe sections, fittings, clamps). Essential for emergency inventory management, material failure analysis, procurement planning, and break pattern analysis fo',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created in the CMMS (Computerized Maintenance Management System) for the repair activity. Links to IBM Maximo Asset Management work order.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` (
    `valve_exercise_id` BIGINT COMMENT 'Unique identifier for the valve exercise transaction record.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Preventive maintenance costs are allocated across service areas for cost recovery in maintenance cost tracking, rate case O&M justification, and budget planning.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or team assigned to the valve exercise work order.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Valve exercising is a regulatory inspection activity (AWWA M44) with pass/fail outcomes, deficiency tracking, and compliance reporting. Natural mapping to enterprise inspection framework for audit tra',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Valve maintenance may identify parts needs (operating nuts, stems, seals). Links exercise program findings to preventive maintenance parts inventory and valve rebuild material tracking for maintenance',
    `network_valve_id` BIGINT COMMENT 'Reference to the distribution network valve asset that was exercised.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent preventive maintenance work order under which this valve exercise was performed.',
    `employee_id` BIGINT COMMENT 'Reference to the field technician or crew member who performed the valve exercise.',
    `valve_technician_employee_id` BIGINT COMMENT 'Reference to the field technician or crew member who performed the valve exercise.',
    `condition_assessment` STRING COMMENT 'Overall condition assessment result from the valve exercise: pass indicates normal operation, fail or needs repair indicates deficiency requiring follow-up.. Valid values are `pass|fail|needs_repair|needs_replacement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve exercise record was first created in the system.',
    `deficiency_code` STRING COMMENT 'Standardized deficiency or failure code from the CMMS failure classification taxonomy.',
    `deficiency_description` STRING COMMENT 'Detailed narrative description of any deficiencies, damage, leaks, or operational issues observed during the valve exercise.',
    `deficiency_noted` BOOLEAN COMMENT 'Boolean flag indicating whether any deficiency, damage, or maintenance need was identified during the valve exercise.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area in which the valve is located, used for NRW and UFW analysis.',
    `duration_minutes` STRING COMMENT 'Total time in minutes required to complete the valve exercise activity, used for labor planning and efficiency analysis.',
    `exercise_date` DATE COMMENT 'The calendar date on which the valve exercise activity was performed.',
    `exercise_direction` STRING COMMENT 'Direction of valve operation during the exercise activity: opened, closed, or full open-close cycle.. Valid values are `open|close|open_close_cycle`',
    `exercise_method` STRING COMMENT 'Method used to exercise the valve: manual wrench, powered actuator, or hydraulic tool.. Valid values are `manual|powered|hydraulic`',
    `exercise_status` STRING COMMENT 'Current status of the valve exercise activity in the maintenance workflow.. Valid values are `completed|incomplete|deferred|cancelled`',
    `exercise_timestamp` TIMESTAMP COMMENT 'The precise date and time when the valve exercise activity was completed, recorded from field device or CMMS.',
    `final_position` STRING COMMENT 'Confirmed position of the valve at the completion of the exercise activity.. Valid values are `open|closed|partially_open`',
    `final_position_percent` DECIMAL(18,2) COMMENT 'Percentage of valve opening at completion of exercise, where 0% is fully closed and 100% is fully open.',
    `follow_up_required` BOOLEAN COMMENT 'Boolean flag indicating whether follow-up maintenance or repair work order is required based on exercise findings.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the valve location in decimal degrees, captured from GIS or field GPS device.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the valve location in decimal degrees, captured from GIS or field GPS device.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valve exercise record was last updated or modified in the system.',
    `leak_detected` BOOLEAN COMMENT 'Boolean flag indicating whether a water leak was detected at the valve during exercise.',
    `leak_severity` STRING COMMENT 'Severity classification of any detected leak: none, minor seepage, moderate leak, or severe leak requiring immediate repair.. Valid values are `none|minor|moderate|severe`',
    `notes` STRING COMMENT 'Free-form text field for additional observations, comments, or context related to the valve exercise activity.',
    `operability_status` STRING COMMENT 'Functional operability status of the valve following exercise: operable, inoperable, or restricted operation.. Valid values are `operable|inoperable|restricted`',
    `operating_nut_condition` STRING COMMENT 'Condition of the valve operating nut or stem: good, worn, damaged, or missing.. Valid values are `good|worn|damaged|missing`',
    `pressure_zone_code` STRING COMMENT 'Code identifying the hydraulic pressure zone in which the valve is located, used for network modeling and operational planning.',
    `technician_name` STRING COMMENT 'Full name of the field technician who performed the valve exercise, captured for audit and accountability.',
    `torque_reading` DECIMAL(18,2) COMMENT 'Measured torque in foot-pounds required to operate the valve, used to assess mechanical condition and operability.',
    `torque_unit` STRING COMMENT 'Unit of measure for the torque reading: foot-pounds or newton-meters.. Valid values are `ft_lbs|nm`',
    `turns_to_close` STRING COMMENT 'Number of complete rotations required to fully close the valve from its open position, recorded during exercise.',
    `valve_box_condition` STRING COMMENT 'Condition assessment of the valve box or vault structure: good, fair, poor, or missing.. Valid values are `good|fair|poor|missing`',
    `valve_box_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth in inches from ground surface to the valve operating nut, recorded during exercise for access planning.',
    `valve_number` STRING COMMENT 'Business identifier for the valve asset, typically displayed on field maps and work orders.',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of valve exercise, recorded for context on field work conditions.',
    CONSTRAINT pk_valve_exercise PRIMARY KEY(`valve_exercise_id`)
) COMMENT 'Transactional record of valve exercising activities performed as part of the annual valve maintenance program. Captures exercise date, valve reference, technician, number of turns completed, direction (open/close), final position confirmed, torque reading, valve condition assessment (pass/fail/needs repair), and any deficiencies noted. Supports CMMS integration with IBM Maximo and regulatory compliance for system operability.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` (
    `hydrant_flow_test_id` BIGINT COMMENT 'Unique identifier for the hydrant flow test record. Primary key.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Testing program costs are allocated to distribution cost centers for rate recovery in O&M expense allocation and regulatory compliance cost tracking.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Flow testing is a regulatory inspection (NFPA 291, ISO rating) with documented outcomes, deficiency tracking, and compliance reporting. Links distribution testing to enterprise inspection management f',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Testing may reveal need for hydrant parts/replacement (nozzles, caps, valves). Links testing program to maintenance parts procurement and hydrant replacement planning for fire protection system reliab',
    `hydrant_id` BIGINT COMMENT 'Reference to the fire hydrant asset that was tested. Links to the hydrant asset registry for location, installation date, and maintenance history.',
    `tertiary_residual_hydrant_id` BIGINT COMMENT 'Reference to the hydrant asset used as the residual hydrant (where pressure is monitored). Typically the hydrant being tested or a nearby hydrant on the same main.',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or work order team that performed the flow test. Used for quality assurance and crew productivity tracking.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which the flow test was performed. Links the test to maintenance scheduling, crew assignment, and cost tracking systems.',
    `available_flow_at_20psi_gpm` DECIMAL(18,2) COMMENT 'Calculated available fire flow at 20 PSI residual pressure in gallons per minute, derived using the NFPA 291 formula. This is the key metric for fire suppression adequacy and ISO rating.',
    `calibration_date` DATE COMMENT 'Date when the test equipment (pitot gauge, pressure gauges) was last calibrated. Ensures measurement accuracy and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the flow test record was first created in the system. Used for audit trail and data lineage tracking.',
    `dma_code` STRING COMMENT 'Identifier for the district metered area containing the tested hydrant. Used for NRW analysis and network performance monitoring.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Measured flow rate during the test in gallons per minute, calculated from pitot pressure and outlet diameter. Represents the actual flow delivered during the test.',
    `flushing_duration_minutes` STRING COMMENT 'Duration in minutes that the hydrant was flushed before or during the test to clear sediment and ensure representative flow measurements.',
    `gis_feature_code` STRING COMMENT 'Unique identifier for the hydrant in the GIS system. Used to link flow test results to spatial analysis, network modeling, and map visualization.',
    `hydrant_condition_observed` STRING COMMENT 'Field technician notes on the physical condition of the hydrant during testing, including leaks, corrosion, operability issues, or damage. Used to trigger maintenance work orders.',
    `hydraulic_model_updated` BOOLEAN COMMENT 'Flag indicating whether the flow test results have been incorporated into the hydraulic model (e.g., Innovyze InfoWater) for calibration. True if updated, false if pending.',
    `iso_fire_flow_adequacy` STRING COMMENT 'Assessment of whether the tested flow meets ISO Public Protection Classification requirements for the area. Adequate flow supports better ISO ratings and lower insurance premiums.. Valid values are `adequate|marginal|deficient`',
    `iso_rating_submitted` BOOLEAN COMMENT 'Flag indicating whether this flow test result has been submitted to ISO as part of the Public Protection Classification rating process. True if submitted, false if not.',
    `iso_submission_date` DATE COMMENT 'Date when the flow test data was submitted to ISO for fire suppression rating purposes. Used for compliance tracking and rating cycle management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the flow test record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `model_update_date` DATE COMMENT 'Date when the flow test data was incorporated into the hydraulic model. Used to track model calibration currency and data lineage.',
    `nfpa_color_classification` STRING COMMENT 'NFPA 291 color code classification based on available fire flow: Class AA (blue) >= 1500 GPM, Class A (green) 1000-1499 GPM, Class B (orange) 500-999 GPM, Class C (red) < 500 GPM, Inadequate for areas with insufficient flow.. Valid values are `class_aa_blue|class_a_green|class_b_orange|class_c_red|inadequate`',
    `notes` STRING COMMENT 'Free-text field for additional observations, anomalies, or context recorded by the field technician during the flow test. May include traffic conditions, customer interactions, or equipment issues.',
    `number_of_outlets_flowed` STRING COMMENT 'Count of hydrant outlets opened during the test. Multiple outlets may be flowed simultaneously to achieve higher flow rates for testing.',
    `outlet_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the hydrant outlet used for the flow test, measured in inches. Typically 2.5 inches for standard outlets. Required for accurate flow calculation from pitot pressure.',
    `pitot_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure reading from the pitot gauge placed in the discharge stream of the flow hydrant, used to calculate flow rate in gallons per minute.',
    `pressure_zone_code` STRING COMMENT 'Identifier for the pressure zone in which the tested hydrant is located. Used to correlate test results with hydraulic model zones and SCADA pressure monitoring.',
    `residual_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure measured at the residual hydrant while flow hydrants are open, recorded in pounds per square inch. Used to calculate available fire flow at 20 PSI residual per NFPA 291.',
    `static_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure measured at the residual hydrant before any flow is initiated, recorded in pounds per square inch. Baseline pressure used to calculate available fire flow.',
    `technician_name` STRING COMMENT 'Name of the lead technician who conducted the test. Captured for certification tracking and quality control purposes.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient air temperature during the test in degrees Fahrenheit. Extreme temperatures may affect equipment accuracy and water viscosity.',
    `test_date` DATE COMMENT 'Date when the hydrant flow test was conducted. Used for compliance tracking, ISO rating cycles, and hydraulic model calibration schedules.',
    `test_method` STRING COMMENT 'Method used to measure flow during the test. Pitot gauge is the standard NFPA 291 method; flow meters and pressure differential methods are alternatives.. Valid values are `pitot_gauge|flow_meter|pressure_differential`',
    `test_number` STRING COMMENT 'Business identifier for the flow test, typically formatted as a sequential or location-based test reference number used for external reporting and field crew coordination.',
    `test_status` STRING COMMENT 'Current lifecycle status of the flow test. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `test_time` TIMESTAMP COMMENT 'Time of day when the test was performed, recorded in HH:MM format. Important for correlating with demand patterns and SCADA pressure data.',
    `test_type` STRING COMMENT 'Classification of the reason for conducting the flow test. Routine tests are scheduled, complaint tests respond to customer concerns, post-repair tests verify work, new installation tests commission assets, model calibration tests support hydraulic modeling, and ISO rating tests support fire insurance ratings.. Valid values are `routine|complaint|post_repair|new_installation|model_calibration|iso_rating`',
    `water_clarity` STRING COMMENT 'Visual assessment of water clarity during the flow test. Turbidity or discoloration may indicate main breaks, sediment accumulation, or water quality issues requiring investigation.. Valid values are `clear|slightly_turbid|turbid|discolored|sediment`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the test (e.g., clear, rain, snow, temperature). Recorded for quality control and to identify potential impacts on test accuracy.',
    CONSTRAINT pk_hydrant_flow_test PRIMARY KEY(`hydrant_flow_test_id`)
) COMMENT 'Transactional record of all scheduled preventive maintenance activities performed on distribution network assets including hydrant flow tests, valve exercising, and unidirectional/conventional flushing. Captures activity type, date, asset reference (hydrant, valve, pipe segment), technician/crew, activity-specific measurements (static/residual pressure and flow rate for hydrant tests; turns completed, torque, and condition for valve exercises; volume discharged, duration, and pre/post turbidity/chlorine for flushing), outcome status (pass/fail/needs repair), deficiencies noted, and CMMS work order reference. Supports NFPA 291 compliance, ISO fire suppression rating, valve operability programs, water quality maintenance, and system turnover management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` (
    `flushing_event_id` BIGINT COMMENT 'Unique identifier for the flushing event record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Post-construction flushing and disinfection are commissioning activities tied to specific CIP projects. Required for regulatory acceptance, bacteriological clearance, asset turnover to operations, and',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.public_notification. Business justification: Flushing events that affect water quality or discolor water may require public notification under state regulations. Customer advisories for planned flushing and water quality impacts must link to spe',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Water quality maintenance costs are allocated across zones for cost-of-service analysis in O&M expense tracking, water loss accounting, and rate case cost justification.',
    `crew_id` BIGINT COMMENT 'Reference to the field operations crew that performed the flushing activity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who served as the crew lead or supervisor for this flushing activity.',
    `customer_complaint_id` BIGINT COMMENT 'Reference to the originating customer service request or complaint that triggered this flushing event, if applicable.',
    `hydrant_id` BIGINT COMMENT 'Reference to the fire hydrant or blow-off valve used as the discharge point for the flushing activity.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the primary distribution main segment that was flushed, linked to the GIS network topology.',
    `turbidity_reading_id` BIGINT COMMENT 'Foreign key linking to quality.turbidity_reading. Business justification: Flushing events generate turbidity spikes monitored via online instruments or grab samples. Links distribution maintenance activity to water quality response. Enables tracking flushing effectiveness a',
    `water_sample_id` BIGINT COMMENT 'Reference to the water quality sample record in the Laboratory Information Management System (LIMS) if a sample was collected.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order in the asset management system (CMMS) under which this flushing activity was scheduled and executed.',
    `city` STRING COMMENT 'City or municipality where the flushing activity occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this flushing event record was first created in the database.',
    `discharge_point_type` STRING COMMENT 'The type of infrastructure asset used as the discharge point for flushed water.. Valid values are `fire_hydrant|blow_off_valve|air_release_valve|service_connection`',
    `dma_code` STRING COMMENT 'The District Metered Area code in which the flushing activity took place, used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis.. Valid values are `^DMA-[A-Z0-9]{3,6}$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time of the flushing activity in minutes, calculated from start to end timestamps or manually recorded by field crew.',
    `equipment_used` STRING COMMENT 'Comma-separated list or description of specialized equipment used during the flushing activity (e.g., flow meters, turbidity meters, diffusers, flushing trailers).',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate during the flushing activity measured in Gallons Per Minute (GPM), used to assess flushing effectiveness and velocity.',
    `flush_date` DATE COMMENT 'The calendar date on which the flushing activity was performed or is scheduled to be performed.',
    `flush_effectiveness_rating` STRING COMMENT 'Qualitative assessment of the flushing effectiveness based on turbidity reduction, chlorine residual improvement, and visual water quality.. Valid values are `excellent|good|fair|poor|failed`',
    `flush_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the flushing activity was completed and the system was returned to normal operation.',
    `flush_number` STRING COMMENT 'Human-readable business identifier for the flushing event, typically formatted as FLU-YYYY-NNNNNN for tracking and reporting purposes.. Valid values are `^FLU-[0-9]{4}-[0-9]{6}$`',
    `flush_reason` STRING COMMENT 'The primary business driver or trigger for performing the flushing activity.. Valid values are `routine_maintenance|water_quality_complaint|discoloration_event|low_chlorine|biofilm_control|new_main_commissioning`',
    `flush_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the flushing activity commenced, captured from field crew mobile devices or SCADA systems.',
    `flush_status` STRING COMMENT 'Current lifecycle status of the flushing event in the operational workflow.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `flushing_method` STRING COMMENT 'The technique used to perform the flushing activity. Unidirectional Flushing (UDF) is the preferred method for sediment removal; conventional flushing is used for routine maintenance.. Valid values are `conventional|unidirectional|UDF|hydrant_blow_off|air_scouring|ice_pigging`',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional flushing or corrective action is required based on post-flush water quality results.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the primary flushing location in decimal degrees, captured from GIS or mobile field devices.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the primary flushing location in decimal degrees, captured from GIS or mobile field devices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this flushing event record was last updated, used for audit trail and data synchronization.',
    `notes` STRING COMMENT 'Free-text field for crew observations, operational challenges, unusual conditions, or additional context not captured in structured fields.',
    `post_flush_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Free chlorine residual concentration measured after flushing, in milligrams per liter (mg/L). Confirms restoration of adequate disinfection levels.',
    `pre_flush_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Free chlorine residual concentration measured before flushing, in milligrams per liter (mg/L). Indicates disinfection adequacy and water age.',
    `pressure_zone_code` STRING COMMENT 'The pressure zone identifier where the flushing occurred, used for hydraulic modeling and pressure management.. Valid values are `^PZ-[A-Z0-9]{2,4}$`',
    `public_notification_sent` BOOLEAN COMMENT 'Indicates whether advance public notification was sent to affected customers regarding potential water discoloration or service disruption.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the flushing activity occurred.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the flushing activity took place, used for public communication and record-keeping.',
    `traffic_control_required` BOOLEAN COMMENT 'Indicates whether traffic control measures were required for safe execution of the flushing activity.',
    `volume_discharged_gallons` DECIMAL(18,2) COMMENT 'Total volume of water discharged during the flushing event, measured in gallons. Critical for water loss accounting and NRW analysis.',
    `water_quality_sample_collected` BOOLEAN COMMENT 'Indicates whether a formal water quality sample was collected during or after the flushing event for laboratory analysis.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the flushing activity, relevant for operational safety and scheduling.',
    CONSTRAINT pk_flushing_event PRIMARY KEY(`flushing_event_id`)
) COMMENT 'Transactional record of unidirectional flushing (UDF) and conventional flushing activities performed on distribution mains to remove sediment, biofilm, and stale water. Captures flush date, pipe segment(s) flushed, flushing method (conventional vs. UDF), volume discharged (gallons), duration, pre/post turbidity (NTU) and chlorine residual readings, crew, and discharge point. Supports water quality maintenance and system turnover management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` (
    `hydraulic_model_run_id` BIGINT COMMENT 'Unique identifier for the hydraulic model simulation run. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Identifier linking this hydraulic model run to a specific capital project, infrastructure study, or operational initiative for which the simulation was performed.',
    `consumption_profile_id` BIGINT COMMENT 'Foreign key linking to metering.consumption_profile. Business justification: Hydraulic model calibration requires actual consumption data from billing periods to validate demand patterns and loading assumptions. Engineers reference specific consumption profiles to adjust model',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Hydraulic model runs are often scoped to specific District Metered Areas (DMAs) for calibration and analysis. The hydraulic_model_run table currently has dma_code as a STRING, which should be normaliz',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Modeling scenarios support CIP project budgeting and capital planning for capital budget justification, project feasibility analysis, and rate case capital planning.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Hydraulic model runs are often scoped to specific pressure zones for network analysis and scenario planning. The hydraulic_model_run table currently has pressure_zone_code as a STRING, which should be',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Hydraulic model results support permit applications, capacity demonstrations, and system adequacy reports submitted to regulators. Model runs demonstrating fire flow capacity, pressure compliance, and',
    `analyst_name` STRING COMMENT 'Name of the engineer or analyst who executed and is responsible for this hydraulic model run, used for accountability and technical review.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Mean nodal pressure in pounds per square inch (PSI) across all nodes in the distribution network during the simulation, providing an overall system pressure indicator.',
    `boundary_conditions` STRING COMMENT 'Description of hydraulic boundary conditions applied to the model, including source pressures, tank levels, pump operating rules, and valve settings that define the system state for this simulation.',
    `calibration_status` STRING COMMENT 'Indicates the level of calibration and validation applied to the hydraulic model for this run: not calibrated (theoretical), preliminary (initial tuning), calibrated (field-verified), or validated (peer-reviewed and accepted).. Valid values are `not_calibrated|preliminary|calibrated|validated`',
    `convergence_achieved` BOOLEAN COMMENT 'Boolean indicator of whether the hydraulic solver achieved numerical convergence within tolerance limits, ensuring the simulation results are mathematically valid and stable.',
    `convergence_iterations` STRING COMMENT 'Number of solver iterations required to achieve hydraulic convergence, used to assess model complexity and computational efficiency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hydraulic model run record was first created in the system, supporting audit trail and data lineage tracking.',
    `demand_multiplier` DECIMAL(18,2) COMMENT 'Scaling factor applied to baseline water demand values to simulate different loading conditions (e.g., 1.0 for average day, 1.5 for peak day, 2.5 for maximum day plus fire flow). Used for capacity planning and stress testing.',
    `fire_flow_available_gpm` DECIMAL(18,2) COMMENT 'Maximum fire flow capacity in gallons per minute (GPM) available at critical nodes while maintaining minimum residual pressure, used for fire protection adequacy assessment and Insurance Services Office (ISO) rating.',
    `gis_model_sync_date` DATE COMMENT 'Date when the hydraulic model network topology was last synchronized with the authoritative Esri ArcGIS geographic information system (GIS) database, ensuring spatial accuracy and asset alignment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hydraulic model run record was last updated, supporting change tracking and data governance.',
    `maximum_pressure_psi` DECIMAL(18,2) COMMENT 'Highest nodal pressure in pounds per square inch (PSI) observed across the entire distribution network during the simulation, used to identify areas at risk of pipe bursts or excessive pressure.',
    `maximum_velocity_fps` DECIMAL(18,2) COMMENT 'Highest water velocity in feet per second (fps) observed in any pipe segment during the simulation, used to identify areas at risk of excessive head loss, water hammer, or pipe erosion.',
    `minimum_pressure_psi` DECIMAL(18,2) COMMENT 'Lowest nodal pressure in pounds per square inch (PSI) observed across the entire distribution network during the simulation, critical for identifying areas at risk of low pressure or negative pressure events.',
    `minimum_velocity_fps` DECIMAL(18,2) COMMENT 'Lowest water velocity in feet per second (fps) observed in any pipe segment during the simulation, used to identify areas with stagnant water or inadequate flushing velocity.',
    `model_version` STRING COMMENT 'Version identifier of the hydraulic model used for this simulation run, tracking model evolution and configuration changes over time.',
    `notes` STRING COMMENT 'Free-text field for analyst comments, observations, assumptions, or special conditions related to this hydraulic model run, supporting documentation and knowledge transfer.',
    `output_file_path` STRING COMMENT 'File system path or cloud storage location where detailed simulation output files (node results, pipe results, time-series data) are stored for this hydraulic model run.',
    `pressure_violations_count` STRING COMMENT 'Number of nodes where pressure fell below the minimum regulatory threshold (typically 20 PSI under normal conditions or 30 PSI during fire flow) during the simulation, indicating potential compliance issues.',
    `pump_energy_kwh` DECIMAL(18,2) COMMENT 'Total electrical energy consumed by all pump stations in kilowatt-hours (kWh) during the simulation period, used for operational cost analysis and energy efficiency optimization.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the hydraulic model simulation run completed execution, whether successfully or with errors.',
    `run_number` STRING COMMENT 'Business-facing identifier or reference number for the hydraulic model run, used for tracking and reporting purposes.',
    `run_purpose` STRING COMMENT 'Business purpose or objective for executing this hydraulic model run, such as Capital Improvement Program (CIP) planning, regulatory compliance analysis, operational troubleshooting, or infrastructure design validation.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the hydraulic model simulation run was initiated by the analyst or automated scheduler.',
    `run_status` STRING COMMENT 'Current execution status of the hydraulic model run, indicating whether the simulation is pending, in progress, successfully completed with convergence, failed due to errors, or cancelled by the user. [ENUM-REF-CANDIDATE: queued|running|completed|failed|cancelled|converged|not_converged — 7 candidates stripped; promote to reference product]',
    `scada_data_source` STRING COMMENT 'Identifier of the SCADA system or OSIsoft PI Historian data source used to calibrate or validate this hydraulic model run with real-time operational data.',
    `scenario_type` STRING COMMENT 'Type of hydraulic simulation scenario executed: steady-state for snapshot conditions, extended period simulation (EPS) for time-series analysis, fire flow for emergency capacity, water quality for contaminant tracking, emergency response for outage planning, or capacity planning for infrastructure investment analysis.. Valid values are `steady_state|extended_period_simulation|fire_flow|water_quality|emergency_response|capacity_planning`',
    `simulation_duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time in seconds for the hydraulic model simulation to execute, used for performance monitoring and optimization.',
    `simulation_end_time` TIMESTAMP COMMENT 'Simulated real-world end date and time for extended period simulation (EPS) scenarios, representing the conclusion of the modeled time window.',
    `simulation_start_time` TIMESTAMP COMMENT 'Simulated real-world start date and time for extended period simulation (EPS) scenarios, representing the beginning of the modeled time window.',
    `system_demand_mgd` DECIMAL(18,2) COMMENT 'Total water demand across the entire distribution system in million gallons per day (MGD) for the simulation scenario, representing aggregate customer consumption and system losses.',
    `tank_level_variation_feet` DECIMAL(18,2) COMMENT 'Maximum range of water level fluctuation in feet across all storage tanks during the simulation, indicating storage utilization and operational cycling.',
    `time_step_minutes` STRING COMMENT 'Temporal resolution in minutes for extended period simulation, defining the interval at which hydraulic conditions are calculated (e.g., 15, 30, or 60 minutes).',
    `total_head_loss_feet` DECIMAL(18,2) COMMENT 'Cumulative hydraulic head loss in feet across the distribution network from source to the most remote node, indicating overall system friction and energy dissipation.',
    `velocity_violations_count` STRING COMMENT 'Number of pipe segments where velocity exceeded recommended maximum thresholds (typically 5-8 fps) during the simulation, indicating potential water quality or infrastructure integrity concerns.',
    CONSTRAINT pk_hydraulic_model_run PRIMARY KEY(`hydraulic_model_run_id`)
) COMMENT 'Transactional record of Innovyze InfoWater (or equivalent) hydraulic model simulation runs for network analysis and operational decision support. Captures run date, model version/calibration date, scenario type (steady-state, extended period simulation, fire flow, water quality decay, energy optimization), demand conditions, boundary conditions, convergence status, key output metrics (min/max pressure PSI, velocity fps, headloss, system demand MGD), and modeler. Used for CIP planning, fire flow certification, pressure zone boundary changes, and regulatory pressure compliance demonstrations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` (
    `network_isolation_event_id` BIGINT COMMENT 'Unique identifier for the network isolation event record.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Planned isolations for construction work must be linked to the driving CIP project for construction coordination, customer communication planning, project schedule tracking, and post-project water qua',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.public_notification. Business justification: Isolation events affecting large customer populations trigger public notification requirements for service disruptions. Regulatory requirements mandate advance notice for planned outages and emergency',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Planned outage costs (labor, water loss) are allocated to maintenance cost centers for O&M cost tracking and service reliability cost analysis.',
    `crew_id` BIGINT COMMENT 'Reference to the crew assigned to perform the isolation and restoration work.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) where the isolation event occurred.',
    `encumbrance_id` BIGINT COMMENT 'Foreign key linking to finance.encumbrance. Business justification: Planned work requiring contractor services creates budget encumbrances for budget control and contractor payment tracking.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Isolation events requiring system depressurization trigger mandatory bacteriological sampling before restoration per regulatory requirements. Event records must reference samples to document complianc',
    `vendor_id` BIGINT COMMENT 'Reference to the external contractor performing the work, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the crew supervisor responsible for managing the isolation event.',
    `network_employee_id` BIGINT COMMENT 'Reference to the crew supervisor responsible for managing the isolation event.',
    `network_vendor_id` BIGINT COMMENT 'Reference to the external contractor performing the work, if applicable.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the primary pressure zone affected by this isolation event.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Isolation events require pre- and post-restoration water quality sampling to verify system integrity and bacteriological compliance before returning to service. Standard operating procedure for planne',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that triggered or documented this isolation event.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the network isolation was completed and service was restored.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the network isolation began.',
    `boil_water_advisory_issued` BOOLEAN COMMENT 'Indicates whether a boil water advisory was issued to affected customers due to the isolation event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this isolation event record was first created in the system.',
    `critical_customers_affected` BOOLEAN COMMENT 'Indicates whether critical customers (hospitals, fire stations, nursing homes) were affected by the isolation.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether advance notification was sent to affected customers before the isolation event.',
    `customers_affected_count` STRING COMMENT 'Total number of customer accounts impacted by the service interruption during this isolation event.',
    `estimated_water_loss_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost during the isolation event due to draining, flushing, or leakage.',
    `flushing_performed` BOOLEAN COMMENT 'Indicates whether system flushing was performed after restoration to ensure water quality.',
    `gis_isolation_boundary` STRING COMMENT 'GIS polygon or geometry defining the geographic boundary of the isolated area.',
    `hydraulic_model_verified` BOOLEAN COMMENT 'Indicates whether the isolation plan was verified using hydraulic modeling software before execution.',
    `isolation_area_length_feet` DECIMAL(18,2) COMMENT 'Total length in feet of the distribution network isolated during this event.',
    `isolation_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the isolation event in hours from start to restoration.',
    `isolation_number` STRING COMMENT 'Business identifier for the isolation event, used for tracking and reporting.. Valid values are `^ISO-[0-9]{6,10}$`',
    `isolation_reason` STRING COMMENT 'Detailed explanation of why the network isolation was necessary, including specific work to be performed.',
    `isolation_status` STRING COMMENT 'Current lifecycle status of the isolation event from planning through restoration.. Valid values are `scheduled|in_progress|isolated|restoring|restored|cancelled`',
    `isolation_type` STRING COMMENT 'Classification of the isolation event based on the reason for network shutdown. [ENUM-REF-CANDIDATE: planned_maintenance|emergency_repair|main_break|construction|leak_repair|valve_replacement|hydrant_repair — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this isolation event record was last updated.',
    `notes` STRING COMMENT 'Additional notes, observations, or special circumstances related to the isolation event.',
    `notification_datetime` TIMESTAMP COMMENT 'Date and time when customer notifications were sent for this isolation event.',
    `pipe_segments_isolated` STRING COMMENT 'Comma-separated list of pipe segment identifiers that were isolated during this event.',
    `premises_affected_count` STRING COMMENT 'Total number of physical premises (addresses) impacted by the service interruption.',
    `pressure_impact_description` STRING COMMENT 'Description of how the isolation affected water pressure in adjacent zones or areas.',
    `priority` STRING COMMENT 'Priority level assigned to the isolation event based on urgency and impact.. Valid values are `emergency|urgent|high|medium|low`',
    `restoration_confirmed` BOOLEAN COMMENT 'Indicates whether full service restoration has been confirmed and all valves returned to normal operating position.',
    `restoration_confirmed_by` BIGINT COMMENT 'Reference to the employee who confirmed successful restoration of service.',
    `restoration_confirmed_datetime` TIMESTAMP COMMENT 'Date and time when service restoration was confirmed and documented.',
    `scada_monitoring_active` BOOLEAN COMMENT 'Indicates whether SCADA monitoring was active during the isolation event to track pressure and flow impacts.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the network isolation is scheduled to be completed and service restored.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the network isolation is scheduled to begin.',
    `valve_count` STRING COMMENT 'Total number of valves operated during the isolation event.',
    `valves_operated` STRING COMMENT 'Comma-separated list of valve identifiers that were operated (closed or opened) to achieve isolation.',
    `water_quality_testing_required` BOOLEAN COMMENT 'Indicates whether water quality testing is required before restoring service to customers.',
    CONSTRAINT pk_network_isolation_event PRIMARY KEY(`network_isolation_event_id`)
) COMMENT 'Transactional record of planned and emergency network isolation events where distribution pipe segments are shut down via valve operations. Captures isolation start/end datetime, isolated pipe segment(s), valves operated with sequence, customers affected count and service addresses, pressure zone impact, isolation reason (main break repair, planned maintenance, new connection, construction), notification status, crew supervisor, and restoration confirmation timestamp. Core to outage management, customer notification, and regulatory reporting of service interruptions.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` (
    `pipe_condition_assessment_id` BIGINT COMMENT 'Unique identifier for the pipe condition assessment record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project created or updated based on this assessment, if applicable.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Condition assessments identify pipe deficiencies requiring corrective action under regulatory compliance schedules, enforcement agreements, or infrastructure improvement mandates. Assessment findings',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Assessment program costs are allocated to asset management cost centers for capital planning cost tracking and condition assessment program budgeting.',
    `crew_id` BIGINT COMMENT 'Reference to the internal crew or team that performed the assessment.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area (DMA) in which the assessed pipe main is located.',
    `encumbrance_id` BIGINT COMMENT 'Foreign key linking to finance.encumbrance. Business justification: Assessment contracts create encumbrances against capital or O&M budgets for contract commitment tracking and budget availability verification.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Assessment identifies pipe materials needing replacement, linking condition findings to procurement specifications for rehabilitation projects. Essential for capital planning, material standardization',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor who performed the assessment, if outsourced.',
    `employee_id` BIGINT COMMENT 'Reference to the lead technician or inspector who conducted the assessment.',
    `pipe_main_id` BIGINT COMMENT 'Reference to the distribution main that was assessed.',
    `pipe_technician_employee_id` BIGINT COMMENT 'Reference to the lead technician or inspector who conducted the assessment.',
    `pipe_vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor who performed the assessment, if outsourced.',
    `pressure_zone_id` BIGINT COMMENT 'Reference to the pressure zone in which the assessed pipe main is located.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Pipe rehabilitation activities (CIPP lining, coating) trigger water quality sampling to verify no contamination from construction materials or activities. Required for NSF/ANSI 61 compliance verificat',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this condition assessment was performed.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or engineer who reviewed and approved the assessment findings.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment findings were reviewed and approved.',
    `assessment_date` DATE COMMENT 'Date on which the condition assessment was performed.',
    `assessment_end_time` TIMESTAMP COMMENT 'Timestamp when the condition assessment activity was completed.',
    `assessment_equipment_used` STRING COMMENT 'Description or identifier of the equipment or instrumentation used to perform the assessment (e.g., CCTV crawler model, acoustic logger model).',
    `assessment_method` STRING COMMENT 'Technology or technique used to perform the condition assessment (e.g., CCTV inspection, acoustic pipe assessment, electromagnetic inspection, visual inspection, ultrasonic testing).. Valid values are `CCTV|acoustic|electromagnetic|visual|ultrasonic|other`',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier or reference number for the condition assessment activity.',
    `assessment_report_url` STRING COMMENT 'URL or file path to the detailed condition assessment report, including photos, videos, and technical findings.',
    `assessment_start_time` TIMESTAMP COMMENT 'Timestamp when the condition assessment activity began.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the condition assessment activity.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `contractor_name` STRING COMMENT 'Name of the contractor or vendor who performed the assessment, denormalized for reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the assessment data meets quality standards (True=acceptable quality, False=quality issues noted).',
    `data_quality_notes` STRING COMMENT 'Free-text notes describing any data quality issues, limitations, or caveats related to the assessment findings.',
    `defect_count` STRING COMMENT 'Total number of discrete defects or anomalies identified during the assessment.',
    `defect_types_identified` STRING COMMENT 'Comma-separated list or description of defect types found during the assessment (e.g., corrosion, cracks, joint separation, tuberculation, lining failure).',
    `gis_feature_code` STRING COMMENT 'Reference to the GIS feature identifier for the assessed pipe main in Esri ArcGIS.',
    `internal_condition_grade` STRING COMMENT 'Internal surface condition rating on a 1-5 scale, assessing corrosion, tuberculation, and lining integrity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the condition assessment activity, findings, or follow-up actions.',
    `overall_condition_grade` STRING COMMENT 'Overall condition rating assigned to the pipe main on a 1-5 scale (1=excellent, 5=critical/failed), based on assessment findings.',
    `pipe_length_assessed_feet` DECIMAL(18,2) COMMENT 'Total length of pipe main inspected during this assessment, measured in feet.',
    `pipe_number` STRING COMMENT 'Business identifier of the pipe main assessed, denormalized for reporting convenience.',
    `recommended_action` STRING COMMENT 'Recommended next step based on assessment findings (e.g., monitor, rehabilitate, replace, urgent repair, no action required).. Valid values are `monitor|rehabilitate|replace|urgent_repair|no_action`',
    `recommended_action_priority` STRING COMMENT 'Priority level assigned to the recommended action for Capital Improvement Program (CIP) planning and asset renewal prioritization.. Valid values are `critical|high|medium|low`',
    `remaining_useful_life_years` STRING COMMENT 'Estimated remaining useful life of the pipe main in years, based on condition assessment findings and deterioration modeling.',
    `structural_condition_grade` STRING COMMENT 'Structural integrity rating on a 1-5 scale, assessing the pipes ability to withstand loads and pressure.',
    `technician_name` STRING COMMENT 'Name of the lead technician or inspector, denormalized for reporting.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of the assessment, which may affect inspection quality or findings.',
    CONSTRAINT pk_pipe_condition_assessment PRIMARY KEY(`pipe_condition_assessment_id`)
) COMMENT 'Transactional record of condition assessment activities performed on distribution mains using CCTV inspection, acoustic pipe assessment, electromagnetic inspection, or visual inspection. Captures assessment date, pipe main reference, assessment method, contractor, pipe length assessed (feet), defect types identified, overall condition grade (1-5 scale), remaining useful life estimate (years), and recommended action (monitor, rehabilitate, replace). Feeds CIP prioritization and asset renewal planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` (
    `dma_crew_coverage_id` BIGINT COMMENT 'Unique identifier for this DMA-crew coverage assignment record. Primary key.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the field service crew assigned to cover this DMA',
    `dma_id` BIGINT COMMENT 'Foreign key linking to the District Metered Area being covered by this crew assignment',
    `after_hours_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this crew has after-hours (night/weekend/holiday) emergency response responsibility for this DMA. Used for on-call scheduling and emergency dispatch routing.',
    `assignment_end_date` DATE COMMENT 'Date when this crew coverage assignment ended or is scheduled to end. Null for current active assignments. Supports crew rotation and reassignment tracking.',
    `assignment_start_date` DATE COMMENT 'Date when this crew began coverage responsibility for this DMA. Used to track historical crew assignments and support crew rotation analysis.',
    `coverage_type` STRING COMMENT 'Classification of the coverage responsibility: routine (scheduled maintenance and monitoring), emergency (main break and leak response), after_hours (night/weekend coverage), on_call (standby), primary (first responder), backup (secondary responder). Determines dispatch priority and labor costing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage assignment record was created in the system.',
    `dma_crew_coverage_status` STRING COMMENT 'Current operational status of this coverage assignment: active (currently in effect), inactive (ended), suspended (temporarily paused), seasonal (active only during specific periods). Used to filter current assignments for dispatch.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, geographic boundaries within the DMA, equipment requirements, access restrictions, or coordination notes for this crew-DMA assignment.',
    `response_priority` STRING COMMENT 'Numeric priority rank for this crew when multiple crews cover the same DMA (1=primary responder, 2=backup, etc.). Used by dispatch systems to route emergency work orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage assignment record was last modified.',
    CONSTRAINT pk_dma_crew_coverage PRIMARY KEY(`dma_crew_coverage_id`)
) COMMENT 'This association product represents the operational assignment of field service crews to District Metered Areas for leak detection, valve exercising, emergency response, and NRW management. Each record links one DMA to one crew with coverage period, coverage type (routine vs emergency), response priority, and after-hours responsibility flag. Supports crew dispatch planning, emergency response routing, and labor allocation for water loss control programs.. Existence Justification: In water utility operations, DMAs require coverage by multiple crews for different functions (leak detection crews, valve crews, emergency response crews) and shift periods (day shift, night shift, on-call). Simultaneously, field service crews are assigned to cover multiple DMAs across their service territory, with different coverage types (routine maintenance vs emergency response) and priority levels. The business actively manages these coverage assignments with start/end dates, coverage types, response priorities, and after-hours responsibility flags.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` (
    `pipe_procurement_id` BIGINT COMMENT 'Unique identifier for this pipe procurement line item record. Primary key.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to the specific pipe main segment that was procured under this contract line item',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the blanket procurement contract under which this pipe main was sourced',
    `actual_delivery_date` DATE COMMENT 'The actual date the pipe material was delivered to the job site or utility warehouse. Used for vendor performance measurement and project schedule variance analysis.',
    `contract_line_item_number` STRING COMMENT 'The specific line item number within the procurement contract that covers this pipe main procurement. Allows traceability to contract terms, pricing schedules, and delivery conditions specific to this material specification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipe procurement record was created in the system. Audit trail for procurement planning and execution.',
    `delivery_schedule` DATE COMMENT 'The scheduled delivery date for this pipe main material as coordinated between procurement and the construction project schedule. Used for project planning and vendor performance tracking.',
    `installation_specification` STRING COMMENT 'Reference to the technical specification or standard that governs the installation of this pipe main under the contract terms. May reference AWWA standards, utility-specific installation procedures, or project-specific engineering drawings. Ensures contract compliance and warranty validity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this pipe procurement record. Audit trail for status changes and data corrections.',
    `material_certification_number` STRING COMMENT 'The manufacturers material certification or mill test report number for this specific pipe main batch. Required for quality assurance, regulatory compliance, and warranty claims. Links physical asset to material traceability documentation.',
    `procurement_status` STRING COMMENT 'Current status of this procurement line item in the procurement-to-installation lifecycle. Tracks progression from planning through final installation.',
    `purchase_order_number` STRING COMMENT 'The specific purchase order or contract release number issued against the blanket contract for this pipe main procurement. Links to accounts payable and financial systems for payment processing.',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'The quantity of pipe material allocated from the contract for this specific pipe main installation, typically measured in linear feet or number of pipe segments. Used for contract consumption tracking and remaining balance calculation.',
    `total_line_value` DECIMAL(18,2) COMMENT 'The total monetary value of this procurement line item (quantity_allocated × unit_price). Used for contract consumption tracking, budget management, and asset capitalization.',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price paid for this pipe main procurement under the contract terms at the time of release. May vary from the base contract price due to escalation clauses, volume discounts, or material specification adjustments. Critical for asset capitalization and lifecycle cost analysis.',
    `warranty_start_date` DATE COMMENT 'The date from which the manufacturer or contractor warranty period begins for this pipe main procurement. May differ from installation date based on contract terms. Used for warranty claim eligibility determination.',
    CONSTRAINT pk_pipe_procurement PRIMARY KEY(`pipe_procurement_id`)
) COMMENT 'This association product represents the procurement line item relationship between pipe_main and procurement_contract. It captures the specific procurement details for each pipe main segment sourced under a blanket contract. Each record links one pipe main installation to one procurement contract with attributes that exist only in the context of this procurement transaction, including contract line item reference, allocated quantity, unit pricing, delivery schedule, and installation specifications.. Existence Justification: Water utilities operate multi-year blanket procurement contracts for pipe materials that supply multiple pipe main installations across different construction projects and time periods. A single procurement contract (covering specific materials, diameters, and pressure classes) supplies materials for many pipe main installations, and a large capital improvement project installing multiple pipe mains may draw from multiple procurement contracts due to different material specifications, vendor sources, or contract periods. The procurement line item relationship is actively managed by both procurement and distribution teams for contract consumption tracking, material traceability, warranty management, and asset capitalization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` (
    `zone_operator_assignment_id` BIGINT COMMENT 'Unique identifier for each pressure zone operator assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the certified operator assigned to the pressure zone',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to the pressure zone requiring operator coverage',
    `assignment_end_date` DATE COMMENT 'Date when the operator assignment to this pressure zone ended. Nullable for active assignments. Used for historical coverage analysis.',
    `assignment_start_date` DATE COMMENT 'Date when the operator was assigned to this pressure zone for the specified role. Used for coverage tracking and compliance reporting.',
    `assignment_status` STRING COMMENT 'Current status of the operator assignment. Active for current assignments, Suspended for temporary holds, Inactive for ended assignments, Pending for future-dated assignments.',
    `certification_level_required` STRING COMMENT 'Minimum operator certification grade or class required for this zone assignment per state regulatory requirements. Varies by zone complexity, population served, and treatment processes.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `last_coverage_date` DATE COMMENT 'Most recent date when this operator provided coverage for this pressure zone. Used for rotation balancing and workload distribution analysis.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this assignment record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified.',
    `on_call_rotation_flag` BOOLEAN COMMENT 'Indicates whether this operator is part of the on-call rotation schedule for this pressure zone. True for operators in rotation, false for fixed assignments.',
    `operator_role` STRING COMMENT 'Role of the operator for this specific pressure zone assignment. Defines responsibility level and coverage type (Primary, Backup, On-Call, Relief).',
    `primary_backup_flag` BOOLEAN COMMENT 'Indicates whether this operator serves as the primary backup for this pressure zone. True for designated primary backup, false otherwise.',
    `rotation_sequence` STRING COMMENT 'Sequence number for on-call rotation scheduling. Defines the order in which operators are called for this pressure zone. Nullable for non-rotation assignments.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this assignment record.',
    CONSTRAINT pk_zone_operator_assignment PRIMARY KEY(`zone_operator_assignment_id`)
) COMMENT 'This association product represents the operational assignment between pressure zones and certified operators. It captures the 24/7 coverage model where multiple operators are assigned to each pressure zone with specific roles (primary, backup, on-call rotation) and tracks the required certification levels, assignment dates, and rotation status per state operator licensing requirements. Each record links one pressure zone to one operator with attributes that exist only in the context of this assignment relationship.. Existence Justification: In water utility operations, pressure zones require 24/7 certified operator coverage with multiple operators assigned to each zone in different roles (primary, backup, on-call rotation). Simultaneously, operators are cross-trained and assigned to multiple pressure zones to provide operational flexibility, coverage during absences, and compliance with state licensing requirements. This is an operational assignment relationship that the business actively manages with specific role designations, certification requirements, rotation schedules, and assignment dates.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` (
    `maintenance_zone_id` BIGINT COMMENT 'Primary key for maintenance_zone',
    `dma_id` BIGINT COMMENT 'Foreign key to the District Metered Area that contains this maintenance zone.',
    `hydraulic_model_run_id` BIGINT COMMENT 'Identifier of the hydraulic model used for simulation of the zone.',
    `parent_maintenance_zone_id` BIGINT COMMENT 'Self-referencing FK on maintenance_zone (parent_maintenance_zone_id)',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - maintenance zones are subdivisions of service territories for field operations',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Geographic area covered by the maintenance zone in square kilometres.',
    `average_flow_gpm` DECIMAL(18,2) COMMENT 'Typical water flow rate in the zone measured in gallons per minute.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Typical operating pressure within the zone measured in pounds per square inch.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the zone.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance zone record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance zone is scheduled to be retired or become inactive (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the maintenance zone became effective for operational use.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether the zone contains assets classified as critical infrastructure (true/false).',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed in the zone.',
    `maintenance_priority` STRING COMMENT 'Priority level for scheduled maintenance activities in the zone.',
    `maintenance_window_hours` STRING COMMENT 'Typical duration in hours allocated for maintenance activities within the zone.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Planned date for the next routine maintenance in the zone.',
    `notes` STRING COMMENT 'Free‑form text for additional comments, observations, or special instructions.',
    `population_served` STRING COMMENT 'Estimated number of customers or residents served by the zone.',
    `pressure_zone` STRING COMMENT 'Pressure zone classification used for regulatory reporting and operational planning.',
    `regulatory_region` STRING COMMENT 'Three‑letter code representing the regulatory jurisdiction for the zone.',
    `maintenance_zone_status` STRING COMMENT 'Current operational status of the maintenance zone.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the maintenance zone record.',
    `zone_code` STRING COMMENT 'Official alphanumeric code used to reference the maintenance zone in operational systems.',
    `zone_name` STRING COMMENT 'Human‑readable name of the maintenance zone.',
    `zone_type` STRING COMMENT 'Category of the zone based on service profile or land use.',
    CONSTRAINT pk_maintenance_zone PRIMARY KEY(`maintenance_zone_id`)
) COMMENT 'Master reference table for maintenance_zone. Referenced by maintenance_zone_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` (
    `nrw_program_id` BIGINT COMMENT 'Primary key for nrw_program',
    `finance_budget_id` BIGINT COMMENT 'add column finance_budget_id (BIGINT) with FK to finance.finance_budget.finance_budget_id - NRW programs require budget allocation tracking for cost-benefit analysis',
    `predecessor_nrw_program_id` BIGINT COMMENT 'Self-referencing FK on nrw_program (predecessor_nrw_program_id)',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - NRW programs are scoped to specific service territories',
    `actual_nrw_reduction_percent` DECIMAL(18,2) COMMENT 'Measured percentage reduction in non‑revenue water realized to date.',
    `actual_nrw_reduction_volume_mgd` DECIMAL(18,2) COMMENT 'Measured volume of water (million gallons per day) saved to date.',
    `approval_date` DATE COMMENT 'Date on which the program received formal approval.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the program.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amount.',
    `data_source` STRING COMMENT 'System or dataset providing the measurement data (e.g., SCADA, InfoWater).',
    `nrw_program_description` STRING COMMENT 'Detailed description of the program objectives, scope, and approach.',
    `end_date` DATE COMMENT 'Planned completion date of the program; may be null for open‑ended initiatives.',
    `last_review_date` DATE COMMENT 'Date of the most recent program performance review.',
    `measurement_method` STRING COMMENT 'Primary method used to measure NRW reduction outcomes.',
    `next_review_date` DATE COMMENT 'Planned date for the next program performance review.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the program.',
    `priority_level` STRING COMMENT 'Priority assigned to the program based on strategic importance.',
    `program_code` STRING COMMENT 'External business code used to reference the program in reports and external systems.',
    `program_name` STRING COMMENT 'Human‑readable name of the NRW reduction program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.',
    `program_type` STRING COMMENT 'Category of the program indicating the primary focus area for water loss reduction.',
    `region` STRING COMMENT 'Geographic region or service area where the program is applied.',
    `responsible_department` STRING COMMENT 'Internal department accountable for execution of the program.',
    `risk_level` STRING COMMENT 'Risk assessment rating for the program.',
    `start_date` DATE COMMENT 'Date when the program officially begins.',
    `target_nrw_reduction_percent` DECIMAL(18,2) COMMENT 'Planned percentage reduction in non‑revenue water achieved by the program.',
    `target_nrw_reduction_volume_mgd` DECIMAL(18,2) COMMENT 'Target volume of water (million gallons per day) to be saved through the program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    CONSTRAINT pk_nrw_program PRIMARY KEY(`nrw_program_id`)
) COMMENT 'Master reference table for nrw_program. Referenced by nrw_program_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node',
    `dma_id` BIGINT COMMENT 'Demand‑Management Area identifier for the node.',
    `pressure_zone_id` BIGINT COMMENT 'Identifier of the pressure zone to which the node belongs.',
    `network_upstream_node_id` BIGINT COMMENT 'Identifier of the immediate upstream node in the hydraulic flow direction.',
    `pipe_main_id` BIGINT COMMENT 'add column pipe_main_id (BIGINT) with FK to distribution.pipe_main.pipe_main_id - network nodes are endpoints of pipe mains in the network topology',
    `primary_pressure_zone_id` BIGINT COMMENT 'Identifier of the broader network zone containing the node.',
    `primary_upstream_network_node_id` BIGINT COMMENT 'Self-referencing FK on network_node (upstream_network_node_id)',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall condition derived from inspections.',
    `asset_lifecycle_stage` STRING COMMENT 'Current stage of the asset within its lifecycle.',
    `asset_tag` STRING COMMENT 'Physical tag or barcode assigned to the node for inventory.',
    `asset_value_usd` DECIMAL(18,2) COMMENT 'Current book value of the node in US dollars.',
    `commissioning_date` DATE COMMENT 'Date the node entered service after testing and acceptance.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the node.',
    `condition_rating` STRING COMMENT 'Qualitative assessment of the nodes physical condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the node record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the node was permanently removed from service, if applicable.',
    `diameter_in` DECIMAL(18,2) COMMENT 'Internal diameter of the pipe or conduit at the node, inches.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Ground elevation of the node above sea level, meters.',
    `flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity for the node, gallons per minute.',
    `flow_gpm` DECIMAL(18,2) COMMENT 'Average water flow through the node, gallons per minute.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `installation_date` DATE COMMENT 'Date the node was physically installed.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the node is considered critical for service continuity.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the node.',
    `last_maintenance_date` DATE COMMENT 'Date the node most recently underwent scheduled maintenance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the node in decimal degrees.',
    `length_m` DECIMAL(18,2) COMMENT 'Length of pipe segment represented by the node, meters.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the node in decimal degrees.',
    `maintenance_priority` STRING COMMENT 'Priority level for scheduling maintenance activities.',
    `maintenance_schedule` STRING COMMENT 'Standard maintenance frequency for the node.',
    `material` STRING COMMENT 'Construction material of the node (e.g., ductile iron, PVC).',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `node_code` STRING COMMENT 'External or legacy code that uniquely identifies the node within legacy GIS or SCADA systems.',
    `node_name` STRING COMMENT 'Human‑readable name of the node used in operations and reporting.',
    `node_type` STRING COMMENT 'Category of the node describing its functional role in the distribution network.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the node.',
    `owner_department` STRING COMMENT 'Internal department responsible for the nodes operation and maintenance.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Measured hydraulic pressure at the node, pounds per square inch.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum design pressure rating for the node, psi.',
    `sensor_code` STRING COMMENT 'Identifier of the sensor attached to the node, if any.',
    `network_node_status` STRING COMMENT 'Current operational status of the node.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the node record.',
    `water_quality_monitoring` BOOLEAN COMMENT 'Indicates if the node includes a water‑quality sensor.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Master reference table for network_node. Referenced by upstream_node_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_primary_pressure_zone_id` FOREIGN KEY (`primary_pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ADD CONSTRAINT `fk_distribution_network_node_primary_upstream_network_node_id` FOREIGN KEY (`primary_upstream_network_node_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_node`(`network_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Node Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `asset_owner` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `average_daily_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `bedding_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Bedding Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `break_history_count` SET TAGS ('dbx_business_glossary_term' = 'Break History Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `cathodic_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `coating_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Coating Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `condition_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Service Line City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Service Line Connection Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|disconnected|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `curb_stop_installed` SET TAGS ('dbx_business_glossary_term' = 'Curb Stop Valve Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `curb_stop_location` SET TAGS ('dbx_business_glossary_term' = 'Curb Stop Valve Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Service Line Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Line Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `pressure_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `replacement_method` SET TAGS ('dbx_business_glossary_term' = 'Service Line Replacement Method');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `replacement_method` SET TAGS ('dbx_value_regex' = 'open_cut|trenchless|directional_drill|pipe_bursting|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `replacement_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Service Line Replacement Priority Score');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_line_number` SET TAGS ('dbx_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Line Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|fire_service|irrigation');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Service Line State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Service Line Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `prv_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Reducing Valve (PRV) Station Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Inlet Pressure Zone Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Station Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `bypass_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bypass Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `bypass_configuration` SET TAGS ('dbx_value_regex' = 'none|manual|automatic|redundant');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `calibration_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `prv_serial_number` SET TAGS ('dbx_business_glossary_term' = 'PRV Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `rtu_code` SET TAGS ('dbx_business_glossary_term' = 'Remote Terminal Unit (RTU) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `scada_tag_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `scada_tag_inlet_pressure` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Inlet Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `scada_tag_outlet_pressure` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Outlet Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `set_point_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Set Point Pressure (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'PRV Station Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'PRV Station Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'PRV Station Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'inline|vault|above_ground|below_ground|chamber|kiosk');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_value_regex' = 'online|offline|intermittent|not_installed');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ALTER COLUMN `valve_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Valve Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `static_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure in Pounds Per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ALTER COLUMN `valve_turns_to_open` SET TAGS ('dbx_business_glossary_term' = 'Valve Turns Required to Fully Open');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Street Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Street Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_available` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Available');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `backup_generator_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Capacity in Kilowatts (kW)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Number');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_type` SET TAGS ('dbx_business_glossary_term' = 'Tank Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `tank_type` SET TAGS ('dbx_value_regex' = 'elevated|ground_level|standpipe|reservoir|clearwell|hydropneumatic');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ALTER COLUMN `usable_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Usable Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit (F)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `totalizer_reading` SET TAGS ('dbx_business_glossary_term' = 'Totalizer Reading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|corrected');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `network_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Network Reading Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for network_reading');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `leak_detection_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Survey Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ALTER COLUMN `grant_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Main Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` SET TAGS ('dbx_subdomain' = 'field_maintenance');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` SET TAGS ('dbx_subdomain' = 'field_maintenance');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `flushing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Flushing Event Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `traffic_control_required` SET TAGS ('dbx_business_glossary_term' = 'Traffic Control Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `volume_discharged_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Discharged in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `water_quality_sample_collected` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Sample Collected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `hydraulic_model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Run Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `consumption_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consumption Profile Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` SET TAGS ('dbx_subdomain' = 'field_maintenance');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `boil_water_advisory_issued` SET TAGS ('dbx_business_glossary_term' = 'Boil Water Advisory Issued Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `critical_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Critical Customers Affected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ALTER COLUMN `estimated_water_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Water Loss (Gallons)');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` SET TAGS ('dbx_subdomain' = 'field_maintenance');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` SET TAGS ('dbx_association_edges' = 'distribution.dma,workforce.crew');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` SET TAGS ('dbx_association_edges' = 'distribution.pipe_main,supply.procurement_contract');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` SET TAGS ('dbx_association_edges' = 'distribution.pressure_zone,workforce.employee');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`maintenance_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `nrw_program_id` SET TAGS ('dbx_business_glossary_term' = 'Nrw Program Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `predecessor_nrw_program_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Nrw Program Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `predecessor_nrw_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_upstream_node_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Node Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `primary_pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Network Zone Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `primary_upstream_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Network Node Id');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `primary_upstream_network_node_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Psi');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating Psi');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Code');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `network_node_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_node` ALTER COLUMN `water_quality_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Monitoring');
