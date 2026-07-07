-- Schema for Domain: wastewater | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`wastewater` COMMENT 'Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` (
    `sewer_network_id` BIGINT COMMENT 'Unique identifier for the sewer network segment. Primary key for the sewer network master topology. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Sewer segments are installed/rehabilitated via CIP projects. Link enables as-built drawing retrieval, installation year validation, capitalization tracking, and condition assessment baseline establish. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'National Pollutant Discharge Elimination System (NPDES) permit identifier if this segment is subject to specific discharge monitoring or CSO/SSO reporting requirements. Ref: EPA SDWA.',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) to which this sewer segment belongs. Used for I&I (Inflow and Infiltration) monitoring and flow metering analysis. Ref: EPA SDWA.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Major sewer segments meeting capitalization thresholds are tracked as fixed assets for GASB 34 depreciation, net book value calculation, rate base determination, and asset valuation for rate cases. Ref: EPA SDWA.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Sewer rehabilitation projects specify pipe, lining, and grout materials by material master records. Linking segments to installed materials enables accurate inventory forecasting for capital projects,. Ref: EPA SDWA.',
    `manhole_id` BIGINT COMMENT 'Identifier of the manhole or node at the upstream end of the sewer segment. Establishes network topology for hydraulic modeling and GIS routing. Ref: EPA SDWA.',
    `sewershed_basin_id` BIGINT COMMENT 'Identifier of the drainage or sewershed basin that this segment serves. Critical for capacity planning, CSO (Combined Sewer Overflow) and SSO (Sanitary Sewer Overflow) management. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Identifier of the Wastewater Treatment Plant (WWTP) that receives flow from this sewer segment. Supports load allocation and treatment capacity planning. Ref: EPA SDWA.',
    `asset_tag` STRING COMMENT 'Physical asset tag or barcode identifier affixed to the segment or associated manhole for field identification and work order tracking in IBM Maximo.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily wastewater flow through the segment in Million Gallons per Day (MGD). Used for load balancing and treatment plant influent forecasting. Ref: EPA SDWA.',
    `condition_grade` STRING COMMENT 'Current physical condition assessment of the sewer segment based on CCTV inspection, PACP (Pipeline Assessment and Certification Program) scoring, or field evaluation. Drives maintenance and replacement decisions. Ref: EPA SDWA.. Valid values are `excellent|good|fair|poor|critical`',
    `coordinate_system` STRING COMMENT 'Spatial reference system identifier (e.g., EPSG code) for the GIS geometry. Ensures spatial data interoperability and accurate georeferencing. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sewer network record was first created in the system. Supports data lineage and audit trail requirements. Ref: EPA SDWA.',
    `criticality_score` STRING COMMENT 'Risk-based criticality rating (typically 1-100 scale) reflecting consequence of failure, service impact, and environmental risk. Drives capital investment prioritization. Ref: EPA SDWA.',
    `data_source` STRING COMMENT 'Identifier of the source system or data collection method that provided this record (e.g., Esri ArcGIS, field survey, as-built drawings, CCTV inspection). Ref: EPA SDWA.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Hydraulic design capacity of the sewer segment in Million Gallons per Day (MGD). Used for capacity utilization analysis and growth planning. Ref: EPA SDWA.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the sewer pipe in inches. Key hydraulic parameter for capacity analysis and flow modeling in Innovyze InfoWater. Ref: EPA SDWA.',
    `downstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the inside bottom of the pipe at the downstream end in feet above mean sea level. Used with upstream invert to calculate slope and hydraulic capacity. Ref: EPA SDWA.',
    `easement_required_flag` BOOLEAN COMMENT 'Indicates whether a legal easement is required for utility access to the sewer segment. Critical for maintenance planning and right-of-way management. Ref: EPA SDWA.',
    `fog_risk_flag` BOOLEAN COMMENT 'Indicates whether the segment is at elevated risk for FOG (Fats, Oils, and Grease) blockages based on upstream land use (restaurants, food processing). Drives preventive maintenance frequency. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for sewer_network. Ref: EPA SDWA.',
    `gis_geometry_wkt` BOOLEAN COMMENT 'Well-Known Text (WKT) representation of the sewer segment spatial geometry (typically LINESTRING). Authoritative spatial reference for GIS mapping and network analysis in Esri ArcGIS. Ref: EPA SDWA.',
    `hydrogen_sulfide_risk_flag` BOOLEAN COMMENT 'Indicates elevated risk of hydrogen sulfide gas generation and corrosion. Common in force mains and long gravity sewers with low flow velocity. Ref: EPA SDWA.',
    `installation_year` STRING COMMENT 'Year the sewer segment was originally installed. Key attribute for asset age analysis, depreciation schedules, and capital improvement program (CIP) prioritization. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent CCTV or physical inspection of the sewer segment. Supports compliance with regulatory inspection frequency requirements and condition assessment programs. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this sewer network record. Enables change tracking and data quality monitoring. Ref: EPA SDWA.',
    `length_feet` DECIMAL(18,2) COMMENT 'Physical length of the sewer segment in feet measured from upstream to downstream node. Used for asset inventory valuation and hydraulic calculations. Ref: EPA SDWA.',
    `lining_installation_date` DATE COMMENT 'Date when pipe lining or rehabilitation was completed. Resets the effective age for condition assessment and extends asset useful life. Ref: EPA SDWA.',
    `lining_type` STRING COMMENT 'Type of trenchless rehabilitation lining applied to the sewer segment. CIPP (Cured-in-Place Pipe) is a common method for structural renewal without excavation. Ref: EPA SDWA.. Valid values are `none|cipp|spray_on|slip_lining|grout`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on regulatory mandates, risk-based prioritization, or preventive maintenance cycles. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, historical context, or field observations relevant to the sewer segment. Ref: EPA SDWA.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the sewer segment in the collection network. Active segments are in service; abandoned segments are out of service but not removed. Ref: EPA SDWA.. Valid values are `active|inactive|abandoned|planned|under_construction`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the sewer segment. Determines maintenance responsibility, regulatory jurisdiction, and capital funding eligibility. Ref: EPA SDWA.. Valid values are `utility_owned|private|municipal|joint`',
    `peak_flow_gpm` DECIMAL(18,2) COMMENT 'Maximum observed or modeled flow rate in Gallons per Minute (GPM) during peak wet weather or high demand periods. Critical for SSO risk assessment. Ref: EPA SDWA.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the sewer segment in US Dollars. Used for asset valuation, insurance, and capital improvement program (CIP) budgeting. Ref: EPA SDWA.',
    `root_intrusion_flag` BOOLEAN COMMENT 'Indicates whether tree root intrusion has been observed or is a known risk for this segment. Common in older vitrified clay and concrete pipes. Ref: EPA SDWA.',
    `segment_identifier` STRING COMMENT 'Externally-known unique identifier for the sewer segment used in GIS systems, field operations, and regulatory reporting. Aligns with Esri ArcGIS feature identifiers. Ref: EPA SDWA.',
    `segment_type` STRING COMMENT 'Classification of the sewer segment by conveyance method and network hierarchy. Gravity sewers use slope for flow; force mains use pumps; interceptors and trunk lines are major collectors. Ref: EPA SDWA.. Valid values are `gravity_sewer|force_main|interceptor|trunk_line|lateral|service_connection`',
    `slope_percent` DECIMAL(18,2) COMMENT 'Gradient of the sewer pipe expressed as a percentage. Critical for gravity sewer hydraulic performance and self-cleansing velocity calculations. Ref: EPA SDWA.',
    `sso_history_count` STRING COMMENT 'Number of Sanitary Sewer Overflow (SSO) events recorded for this segment. High counts trigger regulatory scrutiny and prioritize capacity upgrades. Ref: EPA SDWA.',
    `traffic_impact_level` STRING COMMENT 'Assessment of traffic disruption risk if the segment requires excavation or repair. High-traffic segments require special permitting and coordination. Ref: EPA SDWA.. Valid values are `none|low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `upstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the inside bottom of the pipe at the upstream end in feet above mean sea level. Essential for hydraulic grade line analysis and I&I (Inflow and Infiltration) assessment. Ref: EPA SDWA.',
    CONSTRAINT pk_sewer_network PRIMARY KEY(`sewer_network_id`)
) COMMENT 'Master topology of the wastewater collection and conveyance network including gravity sewers, force mains, interceptors, and trunk lines. Captures pipe material, diameter, length, slope, invert elevations, installation year, condition grade, and GIS geometry. Each segment is individually identifiable by upstream/downstream manhole nodes. Serves as the authoritative spatial and hydraulic reference for the sewer system, aligned with Esri ArcGIS Utility Network and Innovyze InfoSWMM/ICM hydraulic models.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` (
    `manhole_id` BIGINT COMMENT 'Unique identifier for the manhole structure in the wastewater collection system. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Manholes are constructed/rehabilitated through CIP projects. Link supports installation date validation, as-built documentation access, capital cost tracking, and useful life determination for asset m. Ref: EPA SDWA.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Manholes meeting capitalization policy thresholds are capitalized as fixed assets for GASB compliance, depreciation tracking, condition-based valuation, and comprehensive asset register maintenance. Ref: EPA SDWA.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Manhole rehabilitation uses specific materials (covers, frames, liners, grout) tracked in material master. Linking manholes to material specifications supports maintenance planning, inventory manageme. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Manholes are infrastructure assets requiring inspection scheduling, condition-based maintenance, capital replacement planning, and asset valuation for rate-setting. Integration with asset registry ena. Ref: EPA SDWA.',
    `asset_class_code` STRING COMMENT 'Code identifying the asset class or category to which this manhole belongs in the utilitys asset hierarchy. Used for financial reporting, depreciation, and capital planning. Ref: EPA SDWA.',
    `basin_code` STRING COMMENT 'Code identifying the drainage basin or sewershed that this manhole serves. Used for hydraulic modeling and capacity planning. Ref: EPA SDWA.',
    `city` STRING COMMENT 'City or municipality where the manhole is located. Used for jurisdictional reporting and service area analysis. Ref: EPA SDWA.',
    `confined_space_flag` BOOLEAN COMMENT 'Indicates whether the manhole is classified as a permit-required confined space under OSHA regulations. True if the manhole requires a confined space entry permit; false otherwise. Critical for worker safety and entry procedures.',
    `cover_type` STRING COMMENT 'Type of cover installed on the manhole. Watertight covers prevent Inflow and Infiltration (I&I); bolted covers provide security; vented covers allow gas release; traffic-rated covers support vehicular loads. Ref: EPA SDWA.. Valid values are `standard|watertight|bolted|vented|traffic_rated|solid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this manhole record was first created in the system. Used for data lineage and audit trail. Ref: EPA SDWA.',
    `depth_feet` DECIMAL(18,2) COMMENT 'Total depth of the manhole from rim elevation to invert elevation, measured in feet. Critical for determining access requirements, safety protocols, and confined space entry procedures. Ref: EPA SDWA.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the manhole structure measured in inches. Standard diameters are 48 inches (4 feet) or 60 inches (5 feet) for personnel access. Ref: EPA SDWA.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area (DMA) or pressure zone to which this manhole belongs. Used for network segmentation and performance monitoring. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for manhole. Ref: EPA SDWA.',
    `gis_feature_reference` BOOLEAN COMMENT 'Unique identifier for the manhole feature in the utilitys GIS system. Used to link asset management data with spatial data layers in ArcGIS or other GIS platforms. Ref: EPA SDWA.',
    `inflow_infiltration_flag` BOOLEAN COMMENT 'Indicates whether the manhole has been identified as a source of Inflow and Infiltration (I&I) into the wastewater collection system. True if I&I has been observed or suspected; false otherwise. Used for prioritizing I&I reduction programs. Ref: EPA SDWA.',
    `invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the lowest point inside the manhole where wastewater flows, measured in feet above a reference datum. Critical for calculating pipe slopes and flow gradients. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the manhole. Used to track inspection frequency compliance and schedule future inspections. Ref: EPA SDWA.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance activity was performed on the manhole. Includes cleaning, repairs, or rehabilitation work. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the manhole location in decimal degrees. Used for GIS mapping, spatial analysis, and field navigation. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the manhole location in decimal degrees. Used for GIS mapping, spatial analysis, and field navigation. Ref: EPA SDWA.',
    `macp_score` STRING COMMENT 'Numerical condition score assigned using the NASSCO Manhole Assessment and Certification Program (MACP) methodology. Higher scores indicate worse condition. Used for prioritizing rehabilitation and capital planning. Ref: EPA SDWA.',
    `manhole_number` STRING COMMENT 'Business identifier or asset tag assigned to the manhole for field operations and maintenance tracking. Typically displayed on manhole covers or in field maps. Ref: EPA SDWA.',
    `manhole_status` STRING COMMENT 'Current operational status of the manhole in the wastewater collection system lifecycle. Active manholes are in service; inactive are temporarily out of service; abandoned are no longer used but not removed; planned are in design phase; under construction are being installed; decommissioned are permanently removed from service. Ref: EPA SDWA.. Valid values are `active|inactive|abandoned|planned|under_construction|decommissioned`',
    `manhole_type` STRING COMMENT 'Classification of the manhole based on its function in the wastewater collection network. Standard manholes provide access; drop manholes accommodate elevation changes; junction manholes connect multiple pipes; terminal manholes mark the end of a line; diversion manholes route flow; metering manholes house flow measurement equipment. [ENUM-REF-CANDIDATE: standard|drop|junction|terminal|diversion|metering|special — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next inspection of the manhole. Calculated based on condition rating, criticality, and regulatory requirements. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or special instructions related to the manhole. May include access restrictions, safety concerns, or historical information. Ref: EPA SDWA.',
    `ownership` STRING COMMENT 'Entity that owns the manhole asset. Utility-owned assets are maintained by the water utility; municipal assets may be owned by the city; private assets are on private property; joint ownership involves shared responsibility. Ref: EPA SDWA.. Valid values are `utility|municipal|private|state|federal|joint`',
    `postal_code` STRING COMMENT 'Postal code of the manhole location. Used for geographic segmentation and service area mapping. Ref: EPA SDWA.',
    `rim_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the manhole rim (top of cover) above a reference datum, typically mean sea level, measured in feet. Used for hydraulic modeling and flood risk assessment. Ref: EPA SDWA.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the manhole is equipped with SCADA monitoring equipment for real-time level, flow, or alarm monitoring. True if SCADA-monitored; false otherwise. Ref: EPA SDWA.',
    `sso_history_flag` BOOLEAN COMMENT 'Indicates whether the manhole has a history of Sanitary Sewer Overflows (SSO). True if SSO events have occurred at this location; false otherwise. Used for identifying high-risk locations and prioritizing capacity improvements. Ref: EPA SDWA.',
    `state_province` STRING COMMENT 'State or province where the manhole is located. Used for regulatory reporting to state environmental agencies. Ref: EPA SDWA.',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the manhole is located. Used for work order dispatch and public communication. Ref: EPA SDWA.',
    `traffic_load_rating` STRING COMMENT 'Load rating classification of the manhole cover based on expected vehicular traffic. Light duty for pedestrian areas; medium duty for residential streets; heavy duty for arterial roads; extra heavy duty for highways and industrial areas. Ref: EPA SDWA.. Valid values are `light_duty|medium_duty|heavy_duty|extra_heavy_duty`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this manhole record was last updated in the system. Used for data lineage and audit trail. Ref: EPA SDWA.',
    CONSTRAINT pk_manhole PRIMARY KEY(`manhole_id`)
) COMMENT 'Master record for each manhole structure in the wastewater collection system including rim elevation, invert elevation, depth, material, cover type, condition rating, GIS coordinates, and inspection status. Manholes are key access and junction points in the gravity sewer network and are individually tracked for maintenance and I&I assessment.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` (
    `lift_station_id` BIGINT COMMENT 'Unique identifier for the wastewater lift station (pump station). Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Lift stations are capital assets constructed/rehabilitated through CIP projects. Link supports asset handover tracking, as-built documentation retrieval, warranty period management, and capital cost a. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lift stations incur significant operating costs (electricity, maintenance, repairs) that must be tracked to cost centers for budget management, variance analysis, and rate case justification of collec. Ref: EPA SDWA.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Lift stations are capital assets requiring fixed asset tracking for depreciation, useful life management, replacement cost estimation, rate base inclusion, and GASB 34 infrastructure reporting. Ref: EPA SDWA.',
    `sampling_location_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_location. Business justification: Lift stations are monitored for H2S, volatile organic compounds, and corrosion indicators as part of odor control and asset protection programs. Business process: Corrosion control chemical dosing dec. Ref: EPA SDWA.',
    `point_id` BIGINT COMMENT 'Unique SCADA system point identifier or tag name for the lift station. Used to link real-time telemetry data (flow, level, pump status, alarms) from OSIsoft PI Historian or similar SCADA platforms.',
    `scada_tag_id` BIGINT COMMENT 'Unique SCADA system point identifier or tag name for the lift station. Used to link real-time telemetry data (flow, level, pump status, alarms) from OSIsoft PI Historian or similar SCADA platforms.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Lift stations store critical spare parts (pumps, motors, controls) on-site or at nearby storage facilities for emergency repairs. Linking stations to their parts storage location enables field crews t. Ref: EPA SDWA.',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Estimated annual operating cost of the lift station in USD, including energy, routine maintenance, and labor. Used for budgeting and lifecycle cost analysis. Ref: EPA SDWA.',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Quantitative condition assessment score (typically 0-100 scale) based on physical inspection, performance metrics, and age. Higher scores indicate better condition. Used for capital planning and risk assessment. Ref: EPA SDWA.',
    `backup_power_capacity_kw` DECIMAL(18,2) COMMENT 'Rated capacity of the backup power system in kilowatts (kW). Determines how long the lift station can operate during a utility power outage. Ref: EPA SDWA.',
    `backup_power_type` STRING COMMENT 'Type of backup power system installed at the lift station: generator (diesel or natural gas), battery (UPS), dual feed (redundant utility feeds), or none. Critical for emergency preparedness and SSO prevention. Ref: EPA SDWA.. Valid values are `generator|battery|none|dual_feed`',
    `city` STRING COMMENT 'City or municipality where the lift station is located. Used for jurisdictional reporting and asset management. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lift station record was first created in the system. Used for data lineage and audit trail. Ref: EPA SDWA.',
    `criticality_rating` STRING COMMENT 'Asset criticality classification based on consequence of failure analysis: critical (immediate SSO risk, high population impact), high (significant impact), medium (moderate impact), or low (minimal impact). Used for maintenance prioritization and risk management. Ref: EPA SDWA.. Valid values are `critical|high|medium|low`',
    `design_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum rated pumping capacity of the lift station in gallons per minute (GPM) under design conditions. Critical for hydraulic modeling and capacity planning. Ref: EPA SDWA.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum rated pumping capacity of the lift station in million gallons per day (MGD). Derived from GPM for daily flow planning and regulatory reporting. Ref: EPA SDWA.',
    `expected_useful_life_years` STRING COMMENT 'Estimated useful life of the lift station in years from installation or last major rehabilitation. Used for depreciation schedules and capital improvement program (CIP) planning. Ref: EPA SDWA.',
    `force_main_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the force main (pressurized discharge pipe) in inches that conveys wastewater from the lift station to the downstream collection system or treatment plant. Ref: EPA SDWA.',
    `force_main_length_feet` DECIMAL(18,2) COMMENT 'Total length of the force main in feet from the lift station discharge to the downstream connection point. Used for hydraulic calculations and asset valuation. Ref: EPA SDWA.',
    `force_main_material` STRING COMMENT 'Material composition of the force main pipe: ductile iron (DI), polyvinyl chloride (PVC), high-density polyethylene (HDPE), steel, or concrete. Impacts corrosion resistance, lifespan, and maintenance requirements. Ref: EPA SDWA.. Valid values are `ductile_iron|pvc|hdpe|steel|concrete`',
    `generated` STRING COMMENT 'Auto‑generated attribute for lift_station. Ref: EPA SDWA.',
    `installation_date` DATE COMMENT 'Date when the lift station was originally installed and commissioned for service. Used for asset age calculation, depreciation, and replacement planning. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection of the lift station. Used to track compliance with preventive maintenance schedules and regulatory requirements. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lift station record was last updated. Used for data lineage, audit trail, and change tracking. Ref: EPA SDWA.',
    `last_rehabilitation_date` DATE COMMENT 'Date of the most recent major rehabilitation or upgrade of the lift station. Used to track asset condition and plan future capital improvements. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the lift station in decimal degrees (WGS84). Used for GIS mapping, asset location, and emergency response. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the lift station in decimal degrees (WGS84). Used for GIS mapping, asset location, and emergency response. Ref: EPA SDWA.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for the lift station. Used for work order scheduling and resource planning. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, historical context, or site-specific information about the lift station. Ref: EPA SDWA.',
    `number_of_pumps` STRING COMMENT 'Total count of pumps installed at the lift station, including duty pumps and standby/backup units. Critical for redundancy planning and maintenance scheduling. Ref: EPA SDWA.',
    `operational_status` STRING COMMENT 'Current operational state of the lift station in its lifecycle: active (in service), inactive (temporarily offline), standby (backup), maintenance (under repair), decommissioned (retired), or under construction (not yet commissioned). Ref: EPA SDWA.. Valid values are `active|inactive|standby|maintenance|decommissioned|under_construction`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the lift station: utility owned (owned and operated by the water utility), private (privately owned), developer (owned by developer, pending transfer), municipal (owned by municipality), or joint (shared ownership). Impacts maintenance responsibility and capital planning. Ref: EPA SDWA.. Valid values are `utility_owned|private|developer|municipal|joint`',
    `postal_code` STRING COMMENT 'Postal ZIP code of the lift station location. Used for geographic analysis and service area mapping. Ref: EPA SDWA.',
    `pump_configuration` STRING COMMENT 'Pump redundancy configuration: simplex (1 pump, no backup), duplex (2 pumps, 1 duty + 1 standby), triplex (3 pumps), quadruplex (4 pumps). Determines operational reliability and maintenance flexibility. Ref: EPA SDWA.. Valid values are `duplex|triplex|quadruplex|simplex`',
    `pump_horsepower` DECIMAL(18,2) COMMENT 'Total rated horsepower (HP) of the primary duty pump(s). Used for energy consumption analysis and operational cost estimation. Ref: EPA SDWA.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the lift station in USD. Used for insurance valuation, capital improvement program (CIP) planning, and asset valuation under GASB 34. Ref: EPA SDWA.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the lift station is integrated with the SCADA system for real-time monitoring, control, and alarm management. True if SCADA-enabled, False otherwise. Ref: EPA SDWA.',
    `service_area_name` STRING COMMENT 'Name or designation of the geographic service area or collection basin served by this lift station. Used for operational planning and customer communication. Ref: EPA SDWA.',
    `service_area_population` STRING COMMENT 'Estimated population served by the lift station within its collection basin. Used for capacity planning, regulatory reporting, and capital improvement prioritization. Ref: EPA SDWA.',
    `sso_risk_flag` BOOLEAN COMMENT 'Indicates whether the lift station is identified as high-risk for sanitary sewer overflow (SSO) events due to capacity constraints, equipment age, or historical performance. True if high SSO risk, False otherwise. Ref: EPA SDWA.',
    `state_province` STRING COMMENT 'State or province where the lift station is located. Used for regulatory reporting to state primacy agencies and EPA. Ref: EPA SDWA.',
    `station_code` STRING COMMENT 'Unique alphanumeric code or tag assigned to the lift station for asset tracking, SCADA integration, and maintenance management (CMMS). Ref: EPA SDWA.',
    `station_name` STRING COMMENT 'Business name or designation of the lift station for operational reference and public communication. Ref: EPA SDWA.',
    `station_type` STRING COMMENT 'Classification of the lift station based on pump configuration and design: submersible (pumps submerged in wet well), dry pit (pumps in separate dry chamber), wet pit (pumps in wet well but accessible), pneumatic (air-pressure driven), or grinder (with grinder pumps for solids reduction). Ref: EPA SDWA.. Valid values are `submersible|dry_pit|wet_pit|pneumatic|grinder`',
    `street_address` STRING COMMENT 'Physical street address of the lift station site. Used for field service dispatch, emergency response, and asset documentation. Ref: EPA SDWA.',
    `telemetry_status` STRING COMMENT 'Current status of telemetry communication between the lift station and the central SCADA system: online (active communication), offline (no communication), intermittent (unreliable), or not installed (no telemetry equipment). Ref: EPA SDWA.. Valid values are `online|offline|intermittent|not_installed`',
    `total_dynamic_head_feet` DECIMAL(18,2) COMMENT 'Total dynamic head (TDH) in feet that the pumps must overcome, including static lift, friction losses, and discharge pressure. Critical for pump selection and hydraulic modeling. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `wet_well_volume_gallons` DECIMAL(18,2) COMMENT 'Total storage volume of the wet well (sump) in gallons. Determines pump cycle frequency and emergency storage capacity during power outages or pump failures. Ref: EPA SDWA.',
    CONSTRAINT pk_lift_station PRIMARY KEY(`lift_station_id`)
) COMMENT 'Master record for each wastewater lift station (pump station) including station name, location, design capacity (GPM/MGD), wet well volume, number of pumps, SCADA integration point, telemetry status, service area, and operational status. Lift stations are critical infrastructure nodes that convey wastewater from low-elevation areas to treatment facilities via force mains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` (
    `wwtp_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Capital project. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each wwtp record in the wastewater domain.',
    `cost_center_id` BIGINT COMMENT 'Cost center. Ref: EPA SDWA.',
    `fixed_asset_id` BIGINT COMMENT 'Fixed asset. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the operator in charge employee referenced by each wwtp record in the wastewater domain.',
    `sampling_location_id` BIGINT COMMENT 'Lab sampling location. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Link to asset registry. Ref: EPA SDWA.',
    `wwtp_registry_id` BIGINT COMMENT 'Asset registry. Ref: EPA SDWA.',
    `address_line_1` STRING COMMENT 'Street address. Ref: EPA SDWA.',
    `address_line_2` STRING COMMENT 'Address line 2. Ref: EPA SDWA.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily flow in MGD. Ref: EPA SDWA.',
    `biosolids_class` STRING COMMENT 'Class A or Class B. Ref: EPA SDWA.',
    `biosolids_management_method` STRING COMMENT 'Land application, landfill, incineration. Ref: EPA SDWA.',
    `city` STRING COMMENT 'City. Ref: EPA SDWA.',
    `commissioning_date` DATE COMMENT 'Commissioning date. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Compliance status. Ref: EPA SDWA.',
    `country_code` STRING COMMENT 'ISO country code',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD. Ref: EPA SDWA.',
    `disinfection_method` STRING COMMENT 'Chlorine, UV, ozone, etc. Ref: EPA SDWA.',
    `effluent_discharge_point` STRING COMMENT 'Outfall identifier. Ref: EPA SDWA.',
    `energy_consumption_kwh_per_mg` DECIMAL(18,2) COMMENT 'Energy intensity kWh/MG. Ref: EPA SDWA.',
    `facility_code` STRING COMMENT 'Unique facility code. Ref: EPA SDWA.',
    `facility_email` STRING COMMENT 'Facility email. Ref: EPA SDWA.',
    `facility_name` STRING COMMENT 'WWTP name. Ref: EPA SDWA.',
    `facility_phone` STRING COMMENT 'Facility phone number. Ref: EPA SDWA.',
    `facility_type` STRING COMMENT 'Municipal, industrial, etc. Ref: EPA SDWA.',
    `gis_feature_reference` BOOLEAN COMMENT 'GIS feature reference. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Last inspection date. Ref: EPA SDWA.',
    `last_major_upgrade_date` DATE COMMENT 'Last major upgrade. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes. Ref: EPA SDWA.',
    `npdes_permit_number` STRING COMMENT 'NPDES permit number. Ref: EPA SDWA.',
    `operational_status` STRING COMMENT 'Active, standby, or offline. Ref: EPA SDWA.',
    `operator_certification_level` STRING COMMENT 'Required operator certification level. Ref: EPA SDWA.',
    `operator_certification_required` BOOLEAN COMMENT 'Operator certification required. Ref: EPA SDWA.',
    `peak_flow_mgd` DECIMAL(18,2) COMMENT 'Peak flow in MGD. Ref: EPA SDWA.',
    `permit_effective_date` DATE COMMENT 'Permit effective date. Ref: EPA SDWA.',
    `permit_expiration_date` DATE COMMENT 'Permit expiration date. Ref: EPA SDWA.',
    `postal_code` STRING COMMENT 'Postal code. Ref: EPA SDWA.',
    `receiving_water_body` STRING COMMENT 'Receiving water body name. Ref: EPA SDWA.',
    `receiving_water_classification` STRING COMMENT 'Water body classification. Ref: EPA SDWA.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `regulatory_jurisdiction` STRING COMMENT 'EPA Region or state agency. Ref: EPA SDWA.',
    `scada_system_reference` STRING COMMENT 'SCADA system reference. Ref: EPA SDWA.',
    `state_province` STRING COMMENT 'State or province. Ref: EPA SDWA.',
    `treatment_level` STRING COMMENT 'Primary, secondary, tertiary, advanced. Ref: EPA SDWA.',
    `treatment_process_description` STRING COMMENT 'Treatment process description. Ref: EPA SDWA.',
    CONSTRAINT pk_wwtp PRIMARY KEY(`wwtp_id`)
) COMMENT 'Wastewater treatment plant facility with NPDES permit and discharge monitoring requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` (
    `effluent_discharge_event_id` BIGINT COMMENT 'Unique identifier for the effluent discharge event record. Primary key for tracking individual discharge occurrences from WWTP outfalls. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the NPDES permit under which this discharge event is authorized. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Discharge monitoring, bypass event response, and upset condition mitigation costs are tracked to cost centers for NPDES compliance budgeting and operational cost variance analysis. Ref: EPA SDWA.',
    `outfall_id` BIGINT COMMENT 'Identifier of the specific outfall structure through which treated effluent was discharged to the receiving water body. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Identifier of the wastewater treatment plant from which the effluent was discharged. Ref: EPA SDWA.',
    `bypass_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of an emergency bypass or unauthorized discharge event, as required by NPDES permit conditions. Ref: EPA SDWA.',
    `bypass_reason_code` STRING COMMENT 'Standardized code indicating the reason for a treatment bypass or emergency discharge (e.g., equipment failure, extreme weather, power outage). Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the discharge event relative to NPDES permit limits. Indicates whether discharge met all permit conditions or resulted in violations. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|pending_review|exceedance|violation`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this discharge event record was first created in the system. Ref: EPA SDWA.',
    `discharge_authorization_number` STRING COMMENT 'External authorization or permit number assigned by the regulatory agency for this discharge event or outfall. Ref: EPA SDWA.',
    `discharge_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the discharge event measured in hours. Calculated from start and end timestamps. Ref: EPA SDWA.',
    `discharge_end_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent discharge event ended. Used to calculate total discharge duration and volume. Ref: EPA SDWA.',
    `discharge_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate of effluent discharge measured in gallons per minute during the event. Ref: EPA SDWA.',
    `discharge_point_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the outfall discharge point in decimal degrees. Ref: EPA SDWA.',
    `discharge_point_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the outfall discharge point in decimal degrees. Ref: EPA SDWA.',
    `discharge_start_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent discharge event began. Critical for calculating discharge duration and compliance with permit limits. Ref: EPA SDWA.',
    `discharge_status` STRING COMMENT 'Current operational status of the discharge event indicating whether it was authorized under permit conditions, an emergency bypass, or an unauthorized release. Ref: EPA SDWA.. Valid values are `authorized|unauthorized|emergency|bypass|planned|unplanned`',
    `discharge_type` STRING COMMENT 'Classification of the discharge event based on operational pattern: continuous flow, intermittent release, batch discharge, or bypass event. Ref: EPA SDWA.. Valid values are `continuous|intermittent|batch|emergency_bypass|planned_bypass`',
    `discharge_volume_mgd` DECIMAL(18,2) COMMENT 'Total volume of treated effluent discharged during this event, measured in million gallons per day. Core metric for NPDES permit compliance and DMR reporting. Ref: EPA SDWA.',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period to which this discharge event will be aggregated for regulatory submission. Ref: EPA SDWA.',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this discharge event data was submitted to the regulatory authority. Ref: EPA SDWA.',
    `dmr_submitted_flag` BOOLEAN COMMENT 'Indicates whether this discharge event has been included in a submitted DMR to the regulatory authority. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for effluent_discharge_event. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this discharge event record was last modified or updated. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for operational notes, observations, or additional context regarding the discharge event, including any unusual circumstances or corrective actions taken. Ref: EPA SDWA.',
    `operator_certification_number` STRING COMMENT 'State-issued certification number of the operator responsible for monitoring the discharge event. Ref: EPA SDWA.',
    `operator_name` STRING COMMENT 'Name of the certified wastewater treatment plant operator on duty during the discharge event. Ref: EPA SDWA.',
    `permit_limit_applicable_flag` BOOLEAN COMMENT 'Indicates whether NPDES permit discharge limits apply to this specific discharge event. False for emergency bypasses or non-permitted discharges. Ref: EPA SDWA.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during or immediately preceding the discharge event. Relevant for wet weather discharge analysis and CSO/SSO correlation. Ref: EPA SDWA.',
    `receiving_water_body_classification` STRING COMMENT 'Regulatory classification of the receiving water body (e.g., Class A, Class B, impaired waters, sensitive ecosystem) that determines applicable discharge standards. Ref: EPA SDWA.',
    `receiving_water_body_name` STRING COMMENT 'Name of the river, stream, lake, ocean, or other water body into which the treated effluent was discharged. Ref: EPA SDWA.',
    `scada_event_reference` STRING COMMENT 'Identifier linking this discharge event to the corresponding SCADA system event record for process data correlation. Ref: EPA SDWA.',
    `treatment_level_achieved` STRING COMMENT 'Level of wastewater treatment achieved prior to discharge (primary, secondary, tertiary, advanced, or partial treatment during bypass). Ref: EPA SDWA.. Valid values are `primary|secondary|tertiary|advanced|partial|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `violation_description` STRING COMMENT 'Detailed description of any permit violations or exceedances that occurred during this discharge event, including parameters exceeded and magnitude. Ref: EPA SDWA.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this discharge event resulted in one or more NPDES permit violations or exceedances of discharge limits. Ref: EPA SDWA.',
    `weather_condition` STRING COMMENT 'Description of weather conditions during the discharge event (e.g., dry weather, wet weather, storm event) that may impact discharge characteristics or permit applicability. Ref: EPA SDWA.',
    CONSTRAINT pk_effluent_discharge_event PRIMARY KEY(`effluent_discharge_event_id`)
) COMMENT 'Transactional record of treated effluent discharge events from WWTP outfalls including discharge start/end timestamps, volume discharged, receiving water body, outfall identifier, NPDES permit limit applicability, and discharge authorization status. Core record for NPDES compliance and DMR submission preparation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` (
    `effluent_parameter_result_id` BIGINT COMMENT 'Unique identifier for the effluent parameter measurement result record. Ref: Sensus AMI.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the laboratory analyst who performed the analysis. Ref: Sensus AMI.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this effluent monitoring is conducted. Ref: Sensus AMI.',
    `effluent_discharge_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.effluent_discharge_event. Business justification: effluent_parameter_result represents water quality measurements taken during specific discharge events. The product description states Transactional record of WWTP effluent discharge events and assoc. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who validated and approved this result for regulatory reporting. Ref: Sensus AMI.',
    `lab_accreditation_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the analysis. Ref: Sensus AMI.',
    `lab_sample_id` BIGINT COMMENT 'Reference to the laboratory sample from which this parameter result was derived. Ref: Sensus AMI.',
    `primary_effluent_employee_id` BIGINT COMMENT 'Reference to the laboratory analyst who performed the analysis. Ref: Sensus AMI.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the specific outfall or discharge monitoring point where the sample was collected. Ref: Sensus AMI.',
    `analysis_date` DATE COMMENT 'Date when the laboratory analysis was performed on the sample. Ref: Sensus AMI.',
    `analysis_method` BOOLEAN COMMENT 'EPA-approved analytical method used to measure the parameter (e.g., EPA 405.1 for BOD, EPA 160.2 for TSS, SM 4500-H+ for pH). Ref: Sensus AMI.',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations of exceedances, corrective actions taken, or other relevant information about the result. Ref: Sensus AMI.',
    `compliance_status` STRING COMMENT 'Indicates whether the measured result meets the NPDES permit limit requirement (pass/fail) or if evaluation is not applicable or pending. Ref: Sensus AMI.. Valid values are `pass|fail|not_applicable|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `data_validation_status` STRING COMMENT 'Internal validation status of the result data before regulatory submission (draft, validated by supervisor, approved for submission, or rejected).. Valid values are `draft|validated|approved|rejected`',
    `detection_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that the analytical method can reliably detect for this parameter. Ref: Sensus AMI.',
    `dmr_reporting_period` STRING COMMENT 'Year-month (YYYY-MM) of the DMR reporting period to which this result applies. Ref: Sensus AMI.. Valid values are `^d{4}-d{2}$`',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this result was submitted to the regulatory agency. Ref: Sensus AMI.',
    `dmr_submission_status` STRING COMMENT 'Status of the DMR submission that includes this result (pending, submitted to EPA, accepted by EPA, or rejected). Ref: Sensus AMI.. Valid values are `pending|submitted|accepted|rejected`',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which the measured value exceeds the permit limit, calculated as ((measured_value - permit_limit_value) / permit_limit_value) * 100. Null if result is in compliance. Ref: Sensus AMI.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Effluent discharge flow rate in million gallons per day at the time of sample collection, used for mass loading calculations. Ref: Sensus AMI.',
    `generated` STRING COMMENT 'Auto‑generated attribute for effluent_parameter_result. Ref: Sensus AMI.',
    `laboratory_batch_number` STRING COMMENT 'Laboratory-assigned batch or run number for quality control and traceability purposes. Ref: Sensus AMI.',
    `mass_loading_lbs_per_day` DECIMAL(18,2) COMMENT 'Calculated mass loading of the parameter in pounds per day, derived from concentration and flow rate (concentration * flow * 8.34). Ref: Sensus AMI.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the parameter measurement as determined by laboratory analysis. Ref: Sensus AMI.',
    `parameter_code` STRING COMMENT 'EPA-standardized five-digit code identifying the specific water quality parameter measured (e.g., 00310 for BOD, 00530 for TSS). Ref: Sensus AMI.. Valid values are `^[A-Z0-9]{5}$`',
    `parameter_name` STRING COMMENT 'Full descriptive name of the water quality parameter measured (e.g., Biochemical Oxygen Demand, Total Suspended Solids, pH, Ammonia, Phosphorus, Fecal Coliform, E. coli). Ref: Sensus AMI.',
    `permit_limit_type` STRING COMMENT 'Type of NPDES permit limit against which this result is evaluated (e.g., daily maximum, monthly average, weekly average). Ref: Sensus AMI.. Valid values are `daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average`',
    `permit_limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the NPDES permit limit for this parameter and limit type. Ref: Sensus AMI.',
    `quality_control_flag` BOOLEAN COMMENT 'Indicates the outcome of quality control checks (e.g., duplicate analysis, spike recovery, blank contamination) for this result. Ref: Sensus AMI.',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that the analytical method can reliably quantify with acceptable precision and accuracy. Ref: Sensus AMI.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this effluent parameter result record was first created in the system. Ref: Sensus AMI.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this effluent parameter result record was last modified. Ref: Sensus AMI.',
    `regulatory_agency` STRING COMMENT 'Regulatory authority to which this result is reported (EPA or state primacy agency). Ref: Sensus AMI.. Valid values are `EPA|state_primacy_agency`',
    `result_qualifier` STRING COMMENT 'Laboratory qualifier code indicating special conditions of the result (e.g., < for below detection limit, > for above quantitation limit, J for estimated value). Ref: Sensus AMI.',
    `sample_collection_date` DATE COMMENT 'Date when the effluent sample was collected from the discharge point. Ref: Sensus AMI.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the effluent sample was collected, including time zone. Ref: Sensus AMI.',
    `sample_type` STRING COMMENT 'Method by which the effluent sample was collected (e.g., grab sample, 24-hour composite, flow-weighted composite, continuous monitoring). Ref: Sensus AMI.. Valid values are `grab|composite_24hr|composite_flow_weighted|continuous`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the parameter result is expressed (e.g., mg/L for BOD/TSS, MPN/100mL for bacteria, SU for pH). [ENUM-REF-CANDIDATE: mg/L|ug/L|MPN/100mL|CFU/100mL|SU|NTU|percent|umhos/cm — 8 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Sensus AMI.',
    `validation_date` DATE COMMENT 'Date when the result was validated and approved for regulatory reporting. Ref: Sensus AMI.',
    CONSTRAINT pk_effluent_parameter_result PRIMARY KEY(`effluent_parameter_result_id`)
) COMMENT 'Transactional record of WWTP effluent discharge events and associated water quality parameter measurements for NPDES compliance monitoring. Captures discharge event details (start/end timestamps, volume, receiving water body, outfall identifier, authorization status) and individual parameter results (BOD, COD, TSS, TDS, pH, ammonia, phosphorus, fecal coliform, E. coli) with measured values, units, permit limits (daily max, monthly avg), compliance status, sampling dates, analysis methods, and laboratory references. Core operational record for NPDES compliance evaluation and DMR submission preparation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` (
    `sso_event_id` BIGINT COMMENT 'Unique identifier for the sanitary sewer overflow event. Primary key. Ref: EPA SDWA.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: SSO events trigger customer billing adjustments for service interruptions, property damage credits, late fee waivers during system failures, and goodwill credits. Customer service and billing departme. Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: SSO events trigger formal regulatory violations requiring tracking for enforcement, penalties, DMR reporting, and corrective action plans. Essential for SSO consent decree compliance and EPA enforceme. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: SSO events trigger corrective CIP projects (capacity upgrades, rehabilitation). Tracking this relationship is required for EPA consent decree compliance, demonstrating corrective action effectiveness,. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SSO response costs (emergency crew labor, equipment, cleanup contractors, regulatory penalties) must be charged to cost centers for EPA reporting, insurance claims, and cost recovery analysis. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: SSO events often originate from or impact specific customer properties (private lateral blockages, illegal connections). Linking to customer account enables tracking customer-caused SSOs, coordinating. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Significant SSOs trigger direct enforcement actions (consent orders, administrative orders, civil penalties) under CWA authority. Real process: SSO consent decree enforcement, penalty calculation, and. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: SSO events trigger mandatory post-event water quality sampling of receiving waters per state/EPA requirements. Business process: Environmental impact assessment, public health notification decisions,. Ref: EPA SDWA.',
    `manhole_id` BIGINT COMMENT 'Identifier of the manhole where the overflow occurred, if applicable. Links to asset registry. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the infrastructure asset (pipe, pump station, lift station) associated with the overflow event. Ref: EPA SDWA.',
    `sso_registry_id` BIGINT COMMENT 'Foreign key reference to the infrastructure asset (pipe, pump station, lift station) associated with the overflow event. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: SSO events require immediate water quality sampling of affected surface waters or impacted areas per state/EPA regulations to assess public health risk and pathogen contamination. Links spill event to. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the work order created for corrective or preventive action related to this SSO event. Ref: EPA SDWA.',
    `cause_category` STRING COMMENT 'Primary category of the root cause of the overflow event. [ENUM-REF-CANDIDATE: blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism|inflow_infiltration|structural_failure|maintenance_activity|unknown — promote to reference product]. Ref: EPA SDWA.. Valid values are `blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism`',
    `cause_code` STRING COMMENT 'Detailed cause code identifying the specific reason for the overflow (e.g., grease blockage, root intrusion, pump failure, wet weather overload). Ref: EPA SDWA.',
    `cause_description` STRING COMMENT 'Detailed narrative description of the cause and circumstances of the overflow event. Ref: EPA SDWA.',
    `corrective_action_taken` STRING COMMENT 'Description of immediate corrective actions taken to stop the overflow and mitigate environmental impact (e.g., cleared blockage, repaired pump, deployed vacuum truck). Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SSO event record was first created in the system. Ref: EPA SDWA.',
    `discovered_by` STRING COMMENT 'Source or party that discovered and reported the overflow event. Ref: EPA SDWA.. Valid values are `utility_staff|customer_complaint|routine_inspection|scada_alarm|third_party|other`',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the overflow event was first discovered or reported. Ref: EPA SDWA.',
    `dmr_reported` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow event was included in the monthly Discharge Monitoring Report (DMR) submitted under the NPDES permit. Ref: EPA SDWA.',
    `dmr_reporting_period` STRING COMMENT 'Year-month (YYYY-MM) of the DMR reporting period in which this SSO event was included. Ref: EPA SDWA.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the overflow event in minutes, calculated from start to end timestamp. Ref: EPA SDWA.',
    `enforcement_action_taken` STRING COMMENT 'Type of enforcement action taken by regulatory agencies in response to the overflow event. Ref: EPA SDWA.. Valid values are `none|warning|notice_of_violation|consent_order|penalty|other`',
    `estimated_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of untreated or partially treated wastewater discharged during the SSO event, measured in gallons. Critical metric for regulatory reporting and environmental impact assessment. Ref: EPA SDWA.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the sanitary sewer overflow event was stopped or contained. Ref: EPA SDWA.',
    `event_number` STRING COMMENT 'Externally-known business identifier for the SSO event, typically formatted as SSO-YYYY-NNNNNN for regulatory reporting and tracking. Ref: EPA SDWA.. Valid values are `^SSO-[0-9]{4}-[0-9]{6}$`',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the sanitary sewer overflow event began, representing the principal business event time for regulatory reporting. Ref: EPA SDWA.',
    `event_status` STRING COMMENT 'Current lifecycle status of the SSO event in the incident management workflow. Ref: EPA SDWA.. Valid values are `reported|under_investigation|corrective_action_in_progress|resolved|closed`',
    `generated` STRING COMMENT 'Auto‑generated attribute for sso_event. Ref: EPA SDWA.',
    `location_address` STRING COMMENT 'Street address or nearest address to the overflow location for emergency response and regulatory reporting. Ref: EPA SDWA.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the overflow location in decimal degrees for GIS mapping and spatial analysis. Ref: EPA SDWA.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the overflow location in decimal degrees for GIS mapping and spatial analysis. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SSO event record was last modified or updated. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or comments regarding the overflow event, response, or follow-up actions. Ref: EPA SDWA.',
    `overflow_location_type` STRING COMMENT 'Type of infrastructure asset where the overflow occurred. Ref: EPA SDWA.. Valid values are `manhole|cleanout|pump_station|force_main|gravity_sewer|building_lateral`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by regulatory agencies for the overflow event, in US dollars. Ref: EPA SDWA.',
    `preventive_action_planned` STRING COMMENT 'Description of long-term preventive measures planned to prevent recurrence (e.g., pipe replacement, capacity upgrade, enhanced maintenance). Ref: EPA SDWA.',
    `public_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether public notification (posting, media alert, direct contact) is required based on overflow volume, location, or receiving environment. Ref: EPA SDWA.',
    `public_notification_timestamp` TIMESTAMP COMMENT 'Date and time when public notification was issued regarding the overflow event. Ref: EPA SDWA.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during the 24-hour period preceding the overflow event, used to assess weather-related causation. Ref: EPA SDWA.',
    `reached_surface_water` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow reached a surface water body, triggering enhanced regulatory reporting requirements. Ref: EPA SDWA.',
    `receiving_environment` STRING COMMENT 'Type of environment that received the discharged wastewater: surface water body, storm drainage system, land surface, building interior, or other. Ref: EPA SDWA.. Valid values are `surface_water|storm_drain|land_surface|building_interior|other`',
    `receiving_water_body_name` STRING COMMENT 'Name of the surface water body (river, stream, lake, bay) that received the discharge, if applicable. Ref: EPA SDWA.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow event meets thresholds requiring notification to state or federal regulatory agencies. Ref: EPA SDWA.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the overflow event was reported to the regulatory agency (EPA, state primacy agency), typically required within 24 hours. Ref: EPA SDWA.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when utility personnel arrived on-site to respond to the overflow event. Ref: EPA SDWA.',
    `responsible_party` STRING COMMENT 'Name or identifier of the utility staff member or contractor responsible for managing the response to the overflow event. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `volume_estimation_method` STRING COMMENT 'Method used to determine the spill volume: measured (flow meter), calculated (hydraulic model), or estimated (visual observation). Ref: EPA SDWA.. Valid values are `measured|calculated|estimated`',
    `volume_recovered_gallons` DECIMAL(18,2) COMMENT 'Volume of spilled wastewater that was recovered and returned to the collection system or treatment plant, measured in gallons. Ref: EPA SDWA.',
    `weather_related` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow was caused or exacerbated by wet weather conditions, inflow, or infiltration (I&I). Ref: EPA SDWA.',
    CONSTRAINT pk_sso_event PRIMARY KEY(`sso_event_id`)
) COMMENT 'Transactional record of each Sanitary Sewer Overflow (SSO) event including event date/time, duration, estimated volume spilled, overflow location (manhole or pipe), receiving environment (land, waterway, storm drain), cause code (blockage, capacity exceedance, equipment failure, I&I), corrective actions taken, regulatory notification timestamp, and enforcement status. Mandatory for state and EPA SSO reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` (
    `cso_event_id` BIGINT COMMENT 'Unique identifier for the Combined Sewer Overflow event record. Primary key for the CSO event entity. Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: CSO events exceeding NPDES permit limits or LTCP requirements become formal violations. Critical for consent decree tracking, nine minimum controls compliance, and regulatory reporting to EPA/state ag. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CSO monitoring, post-event sampling, and control measure costs are allocated to cost centers for LTCP financial tracking, consent decree compliance reporting, and capital planning budgets. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: CSO events may impact specific customer properties requiring notification under regulatory requirements. Linking enables tracking which customers received CSO notifications, coordinating with customer. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: CSO events violating LTCP milestones or permit conditions trigger enforcement actions under consent decrees. Real process: CSO consent decree enforcement, stipulated penalty assessment, and long-term. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: CSO events drive Long-Term Control Plan (LTCP) projects mandated by EPA consent decrees. Linking events to the projects designed to eliminate them is required for regulatory reporting, demonstrating c. Ref: EPA SDWA.',
    `outfall_id` BIGINT COMMENT 'Identifier of the specific CSO outfall location where the overflow discharge occurred. Links to the outfall asset registry. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: CSO (Combined Sewer Overflow) events occur at specific locations within the sewer network. Adding sewer_network_id FK links each CSO event to the network segment where the overflow occurred. This is e. Ref: EPA SDWA.',
    `storm_event_id` BIGINT COMMENT 'Identifier linking this CSO event to the broader storm event record that triggered multiple overflows across the system. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: NPDES permits require post-CSO water quality monitoring of receiving waters to assess environmental impact. CSO events trigger mandatory sampling for BOD, TSS, fecal coliform per regulatory protocols. Ref: EPA SDWA.',
    `bod_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured Biochemical Oxygen Demand concentration in milligrams per liter from post-event water quality sampling, indicating organic pollution level. Ref: EPA SDWA.',
    `cause_category` STRING COMMENT 'Primary cause category of the CSO event: wet weather event exceeding system capacity, equipment failure, operational error, or unknown. Ref: EPA SDWA.. Valid values are `wet_weather|equipment_failure|capacity_exceedance|operational_error|unknown`',
    `cause_description` STRING COMMENT 'Detailed narrative description of the root cause and contributing factors that led to the CSO event. Ref: EPA SDWA.',
    `control_measure_active` BOOLEAN COMMENT 'Indicates whether CSO control measures (storage tanks, green infrastructure, real-time control) were operational and active during this event. Ref: EPA SDWA.',
    `control_measure_description` STRING COMMENT 'Description of the CSO control measures that were in place or activated during the event (e.g., storage tank diversion, sewer separation, green infrastructure capture). Ref: EPA SDWA.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions planned or implemented to address the cause of the CSO event and prevent future occurrences. Ref: EPA SDWA.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to prevent recurrence of this type of CSO event. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CSO event record was first created in the system. Ref: EPA SDWA.',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period (YYYY-MM format) in which this CSO event will be included for NPDES compliance reporting. Ref: EPA SDWA.',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this CSO event was submitted to the regulatory agency. Ref: EPA SDWA.',
    `dmr_submitted` BOOLEAN COMMENT 'Indicates whether this CSO event has been included in a submitted DMR to the regulatory agency. Ref: EPA SDWA.',
    `event_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the CSO event in minutes, calculated from start to end timestamp. Ref: EPA SDWA.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the Combined Sewer Overflow event concluded and discharge ceased. Ref: EPA SDWA.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the Combined Sewer Overflow event began, marking the initiation of discharge to the receiving water body. Ref: EPA SDWA.',
    `event_status` STRING COMMENT 'Current processing status of the CSO event record in the regulatory reporting workflow. Ref: EPA SDWA.. Valid values are `reported|under_review|validated|closed`',
    `fecal_coliform_cfu_100ml` DECIMAL(18,2) COMMENT 'Measured fecal coliform bacteria concentration in colony-forming units per 100 milliliters from post-event water quality sampling, indicating sewage contamination. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for cso_event. Ref: EPA SDWA.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this CSO event record. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CSO event record was last updated or modified. Ref: EPA SDWA.',
    `ltcp_reference_code` BIGINT COMMENT 'Identifier linking this CSO event to the relevant Long-Term Control Plan project or mitigation strategy designed to reduce or eliminate overflows at this outfall. Ref: EPA SDWA.',
    `monitoring_sample_date` DATE COMMENT 'Date when post-event water quality samples were collected from the receiving water body. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information about the CSO event recorded by operations or compliance staff. Ref: EPA SDWA.',
    `notification_method` STRING COMMENT 'Method used to notify the regulatory agency of the CSO event (phone call, email, online reporting portal, fax, or automated SCADA notification). Ref: EPA SDWA.. Valid values are `phone|email|online_portal|fax|automated_system`',
    `operator_response_time_minutes` DECIMAL(18,2) COMMENT 'Time in minutes from CSO event detection or alarm to operator acknowledgment and response initiation. Ref: EPA SDWA.',
    `outfall_designation` STRING COMMENT 'Regulatory designation or permit number assigned to the CSO outfall by the state or EPA. Ref: EPA SDWA.',
    `overflow_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated or measured volume of untreated or partially treated wastewater discharged during the CSO event, expressed in gallons. Ref: EPA SDWA.',
    `overflow_volume_mgd` DECIMAL(18,2) COMMENT 'Overflow volume normalized to Million Gallons per Day for regulatory reporting and comparison purposes.',
    `post_event_monitoring_completed` BOOLEAN COMMENT 'Indicates whether required post-event water quality monitoring has been completed and results documented. Ref: EPA SDWA.',
    `post_event_monitoring_required` BOOLEAN COMMENT 'Indicates whether post-event water quality monitoring of the receiving water body is required per permit conditions or LTCP commitments. Ref: EPA SDWA.',
    `precipitation_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall amount in inches recorded during the storm event that triggered the CSO, measured at the nearest rain gauge or weather station. Ref: EPA SDWA.',
    `precipitation_duration_hours` DECIMAL(18,2) COMMENT 'Duration of the precipitation event in hours that contributed to the CSO occurrence. Ref: EPA SDWA.',
    `public_notification_required` BOOLEAN COMMENT 'Indicates whether public notification (beach closure, advisory signage, media alert) was required based on the location and impact of the CSO event.',
    `public_notification_timestamp` TIMESTAMP COMMENT 'Date and time when public notification was issued regarding the CSO event and potential water quality impacts. Ref: EPA SDWA.',
    `receiving_water_body_classification` STRING COMMENT 'State-designated use classification of the receiving water body (e.g., Class A, Class B, recreational, drinking water source) per state water quality standards. Ref: EPA SDWA.',
    `receiving_water_body_name` STRING COMMENT 'Name of the river, stream, lake, or other water body that received the CSO discharge. Ref: EPA SDWA.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this CSO event triggered regulatory notification requirements to EPA or state environmental agency based on volume, duration, or receiving water sensitivity. Ref: EPA SDWA.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory agency was notified of the CSO event occurrence, if notification was required. Ref: EPA SDWA.',
    `scada_alarm_triggered` BOOLEAN COMMENT 'Indicates whether a SCADA system alarm was triggered at the time of the CSO event, alerting operators to the overflow condition. Ref: EPA SDWA.',
    `tss_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured Total Suspended Solids concentration in milligrams per liter from post-event water quality sampling. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `volume_estimation_method` STRING COMMENT 'Method used to determine the overflow volume: measured via flow meter, modeled using hydraulic simulation, estimated from duration and outfall characteristics, or calculated from SCADA data. Ref: EPA SDWA.. Valid values are `measured|modeled|estimated|calculated`',
    `created_by` STRING COMMENT 'Username or identifier of the system user or automated process that created this CSO event record. Ref: EPA SDWA.',
    CONSTRAINT pk_cso_event PRIMARY KEY(`cso_event_id`)
) COMMENT 'Transactional record of each Combined Sewer Overflow (CSO) event including event date/time, outfall identifier, precipitation trigger data, estimated overflow volume, receiving water body, CSO long-term control plan (LTCP) reference, regulatory notification status, and post-event monitoring requirements. Supports CWA and NPDES CSO compliance reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` (
    `ii_monitoring_point_id` BIGINT COMMENT 'Unique identifier for the I&I monitoring point record. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: I/I monitoring points are installed as part of SSES (Sewer System Evaluation Survey) CIP projects. Link supports project deliverable tracking, baseline establishment for rehabilitation effectiveness m. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: I&I monitoring equipment, data analysis, and SSES study costs are allocated to cost centers for rehabilitation program prioritization, capital budget justification, and consent decree compliance cost. Ref: EPA SDWA.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area to which this monitoring point is assigned for I&I analysis and flow balancing. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (manhole, sewer segment, lift station) at which this monitoring point is located. Ref: EPA SDWA.',
    `primary_ii_registry_id` BIGINT COMMENT 'Reference to the physical asset (manhole, sewer segment, lift station) at which this monitoring point is located. Ref: EPA SDWA.',
    `sampling_location_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_location. Business justification: I&I monitoring points are physical sampling locations in the collection system for SSES studies. Business process: Flow monitoring data is supplemented with lab analysis of dry-weather samples to dist. Ref: EPA SDWA.',
    `sses_study_id` BIGINT COMMENT 'Reference to the SSES study or I&I reduction program under which this monitoring point was established. Ref: EPA SDWA.',
    `watershed_id` BIGINT COMMENT 'Reference to the watershed or drainage basin in which this monitoring point is located for hydrologic analysis. Ref: EPA SDWA.',
    `baseline_dry_weather_flow_gpd` DECIMAL(18,2) COMMENT 'Established baseline flow rate during dry weather conditions measured in gallons per day, used as reference for I&I calculations. Ref: EPA SDWA.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the monitoring instrument to ensure data accuracy. Ref: EPA SDWA.',
    `condition_rating` STRING COMMENT 'Overall condition assessment of the sewer infrastructure at the monitoring point based on inspection findings. Ref: EPA SDWA.. Valid values are `excellent|good|fair|poor|critical`',
    `contributing_area_acres` DECIMAL(18,2) COMMENT 'Size of the drainage area contributing flow to this monitoring point measured in acres. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring point record was first created in the system. Ref: EPA SDWA.',
    `data_logger_reference` STRING COMMENT 'Identifier for the data logger or SCADA Remote Terminal Unit (RTU) collecting data from this monitoring point. Ref: EPA SDWA.',
    `defect_count` STRING COMMENT 'Number of structural or operational defects identified at or near the monitoring point during inspections. Ref: EPA SDWA.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the monitoring point above mean sea level in feet, used for hydraulic gradient analysis. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for ii_monitoring_point. Ref: EPA SDWA.',
    `ii_monitoring_point_status` STRING COMMENT 'Current operational status of the monitoring point in the I&I monitoring program. Ref: EPA SDWA.. Valid values are `active|inactive|planned|decommissioned|maintenance`',
    `infiltration_rate_gpd` DECIMAL(18,2) COMMENT 'Estimated infiltration component of I&I measured in gallons per day, representing groundwater entering the sewer system through defects. Ref: EPA SDWA.',
    `inflow_rate_gpd` DECIMAL(18,2) COMMENT 'Estimated inflow component of I&I measured in gallons per day, representing stormwater entering the sewer system through direct connections. Ref: EPA SDWA.',
    `installation_date` DATE COMMENT 'Date when the monitoring point was installed or established in the collection system. Ref: EPA SDWA.',
    `instrument_serial_number` STRING COMMENT 'Manufacturer serial number of the monitoring instrument for asset tracking and calibration management. Ref: EPA SDWA.',
    `instrument_type` STRING COMMENT 'Specific type or model of instrumentation installed at the monitoring point (e.g., ultrasonic flow meter, area-velocity sensor). Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this monitoring point is currently active in the I&I monitoring program. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or data collection event at this monitoring point. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring point location in decimal degrees. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring point location in decimal degrees. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring point record was last updated in the system. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which data is collected or inspections are performed at this monitoring point. Ref: EPA SDWA.. Valid values are `continuous|daily|weekly|monthly|quarterly|event_based`',
    `monitoring_point_code` STRING COMMENT 'Business identifier or code assigned to the monitoring point for operational reference and field reporting. Ref: EPA SDWA.',
    `monitoring_point_name` STRING COMMENT 'Descriptive name or label for the monitoring point, typically referencing location or purpose. Ref: EPA SDWA.',
    `monitoring_point_type` STRING COMMENT 'Classification of the monitoring point by instrumentation or inspection method used to detect or measure inflow and infiltration. Ref: EPA SDWA.. Valid values are `flow_meter|rain_gauge|smoke_test_zone|cctv_inspection_segment|manhole_inspection|pressure_sensor`',
    `next_scheduled_inspection_date` DATE COMMENT 'Planned date for the next inspection or monitoring event at this point. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional observations, special conditions, or operational notes related to the monitoring point. Ref: EPA SDWA.',
    `peak_wet_weather_flow_gpd` DECIMAL(18,2) COMMENT 'Maximum recorded flow rate during wet weather events measured in gallons per day. Ref: EPA SDWA.',
    `pipe_age_years` STRING COMMENT 'Age of the sewer pipe at the monitoring point location measured in years since installation. Ref: EPA SDWA.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the sewer pipe at the monitoring point location measured in inches. Ref: EPA SDWA.',
    `pipe_material` STRING COMMENT 'Material composition of the sewer pipe at the monitoring point (e.g., PVC, concrete, clay, cast iron). Ref: EPA SDWA.',
    `rehabilitation_priority_category` STRING COMMENT 'Categorical classification of rehabilitation priority for capital planning and work scheduling. Ref: EPA SDWA.. Valid values are `critical|high|medium|low|deferred`',
    `rehabilitation_priority_score` STRING COMMENT 'Numerical score (typically 1-100) indicating the priority for rehabilitation or repair based on I&I severity, asset condition, and risk factors. Ref: EPA SDWA.',
    `scada_tag` STRING COMMENT 'SCADA system tag or point identifier used to retrieve real-time or historical data from this monitoring point. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `wet_weather_flow_multiplier` DECIMAL(18,2) COMMENT 'Multiplier factor representing the ratio of wet weather flow to dry weather flow, indicating the severity of inflow and infiltration. Ref: EPA SDWA.',
    CONSTRAINT pk_ii_monitoring_point PRIMARY KEY(`ii_monitoring_point_id`)
) COMMENT 'Master record for each Inflow and Infiltration (I&I) monitoring point and associated flow measurement history in the collection system. Includes monitoring point type (flow meter, rain gauge, smoke test zone, CCTV inspection segment), location, DMA assignment, baseline dry-weather flow, wet-weather flow multiplier, rehabilitation priority score, and time-series flow measurements with rainfall correlation. Supports I&I reduction programs, sewer system evaluation surveys (SSES), and rehabilitation investment prioritization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` (
    `ii_flow_measurement_id` BIGINT COMMENT 'Unique identifier for the I&I flow measurement record. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Reference to the user who validated or reviewed this measurement record. Ref: EPA SDWA.',
    `ii_monitoring_point_id` BIGINT COMMENT 'Reference to the specific I&I monitoring point where this flow measurement was captured. Ref: EPA SDWA.',
    `ii_validated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who validated or reviewed this measurement record. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Reference to the rain gauge station used to capture rainfall data for this measurement. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Reference to the specific sewer network segment (pipe, manhole, or structure) associated with this monitoring point. Ref: EPA SDWA.',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Indicates whether this measurement triggered an alarm condition in the SCADA system due to exceeding thresholds or anomalous patterns. Ref: EPA SDWA.',
    `alarm_type` STRING COMMENT 'Type of alarm triggered by this measurement: high flow, low flow, sensor fault, communication loss, or none. Ref: EPA SDWA.. Valid values are `high_flow|low_flow|sensor_fault|communication_loss|none`',
    `average_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate over the measurement period, expressed in gallons per minute. Ref: EPA SDWA.',
    `calculated_ii_volume_gallons` DECIMAL(18,2) COMMENT 'Calculated volume of inflow and infiltration for the measurement period, derived by subtracting the dry weather baseline from the measured flow and integrating over time. Ref: EPA SDWA.',
    `calibration_date` DATE COMMENT 'Date when the flow sensor was last calibrated prior to this measurement, ensuring measurement accuracy. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_quality_flag` BOOLEAN COMMENT 'Quality indicator for the measurement data: valid (passed all checks), suspect (questionable but usable), invalid (failed validation), estimated (imputed value), or missing (no data captured). Ref: EPA SDWA.',
    `data_quality_notes` STRING COMMENT 'Free-text notes explaining data quality issues, sensor malfunctions, calibration events, or other factors affecting measurement reliability. Ref: EPA SDWA.',
    `data_source` STRING COMMENT 'Origin of the measurement data: SCADA system, manual field reading, mobile device, or third-party monitoring service. Ref: EPA SDWA.. Valid values are `scada|manual|mobile|third_party`',
    `dry_weather_baseline_gpm` DECIMAL(18,2) COMMENT 'Established baseline flow rate during dry weather conditions at this monitoring point, used as the reference for calculating I&I contributions. Ref: EPA SDWA.',
    `flow_velocity_fps` DECIMAL(18,2) COMMENT 'Measured velocity of wastewater flow at the monitoring point, expressed in feet per second. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for ii_flow_measurement. Ref: EPA SDWA.',
    `ii_type` STRING COMMENT 'Classification of the I&I contribution type: infiltration (groundwater seepage), inflow (direct stormwater entry), combined (both), or unknown. Ref: EPA SDWA.. Valid values are `infiltration|inflow|combined|unknown`',
    `measured_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Instantaneous flow rate measured at the monitoring point expressed in gallons per minute. Ref: EPA SDWA.',
    `measured_flow_rate_mgd` DECIMAL(18,2) COMMENT 'Instantaneous flow rate measured at the monitoring point expressed in million gallons per day. Ref: EPA SDWA.',
    `measurement_duration_minutes` STRING COMMENT 'Duration over which the flow measurement was averaged or integrated, expressed in minutes. Ref: EPA SDWA.',
    `measurement_method` STRING COMMENT 'Technology or method used to capture the flow measurement: ultrasonic, magnetic flow meter, weir, flume, or manual reading. Ref: EPA SDWA.. Valid values are `ultrasonic|magnetic|weir|flume|manual`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the flow measurement was recorded at the monitoring point. Ref: EPA SDWA.',
    `minimum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Minimum instantaneous flow rate observed during the measurement period, expressed in gallons per minute. Ref: EPA SDWA.',
    `peak_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum instantaneous flow rate observed during the measurement period, expressed in gallons per minute. Ref: EPA SDWA.',
    `pipe_depth_fill_percent` DECIMAL(18,2) COMMENT 'Percentage of pipe cross-sectional area filled with wastewater at the time of measurement, indicating hydraulic loading. Ref: EPA SDWA.',
    `rain_gauge_reference` BIGINT COMMENT 'Reference to the rain gauge station used to capture rainfall data for this measurement. Ref: EPA SDWA.',
    `rainfall_depth_inches` DECIMAL(18,2) COMMENT 'Cumulative rainfall depth recorded at the nearest rain gauge corresponding to the measurement timestamp, used to correlate wet-weather flow contributions. Ref: EPA SDWA.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement record was first created in the system. Ref: EPA SDWA.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement record was last modified. Ref: EPA SDWA.',
    `rehabilitation_priority_score` STRING COMMENT 'Calculated priority score for infrastructure rehabilitation investment based on I&I volume, frequency, and impact, used to rank capital improvement projects. Ref: EPA SDWA.',
    `scada_system_reference` BIGINT COMMENT 'Reference to the SCADA system that collected and transmitted this measurement data. Ref: EPA SDWA.',
    `sensor_reference` BIGINT COMMENT 'Reference to the flow sensor or metering device that captured this measurement. Ref: EPA SDWA.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the wastewater at the monitoring point, expressed in degrees Fahrenheit. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `validation_status` STRING COMMENT 'Current validation status of the measurement record: pending (awaiting review), validated (approved for use), rejected (excluded from analysis), or under review (being evaluated). Ref: EPA SDWA.. Valid values are `pending|validated|rejected|under_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement record was validated or reviewed. Ref: EPA SDWA.',
    `weather_condition` STRING COMMENT 'Weather condition classification at the time of measurement to contextualize flow patterns. Ref: EPA SDWA.. Valid values are `dry|wet|storm|post-storm`',
    CONSTRAINT pk_ii_flow_measurement PRIMARY KEY(`ii_flow_measurement_id`)
) COMMENT 'Transactional record of flow measurements at I&I monitoring points capturing date/time, measured flow rate (GPM/MGD), rainfall depth at nearest gauge, dry-weather baseline comparison, calculated I&I volume, and data quality flag. Used to quantify infiltration and inflow contributions and prioritize rehabilitation investments.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` (
    `industrial_user_permit_id` BIGINT COMMENT 'Unique identifier for the industrial user permit record. Primary key for the IUP registry. Ref: EPA SDWA.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Industrial pretreatment programs require linking discharge permits to service agreements for coordinated billing, service delivery, and compliance enforcement. Water utilities bill industrial users fo. Ref: EPA SDWA.',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Industrial user permit fees, surcharges, and penalty assessments generate AR transactions for revenue recognition, aging analysis, collections management, and pretreatment program cost recovery report. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Industrial users are commercial/industrial customers with billing accounts. Pretreatment program management requires linking permits to customer accounts for billing industrial wastewater charges, tra. Ref: EPA SDWA.',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Industrial pretreatment permits require discharge volume monitoring for compliance and flow-based surcharge calculations. Utilities install dedicated wastewater discharge meters at industrial faciliti. Ref: EPA SDWA.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Industrial user permits are tied to specific facility locations for inspection scheduling, compliance tracking, and enforcement actions. Asset location integration enables spatial analysis of pretreat. Ref: EPA SDWA.',
    `industrial_user_id` BIGINT COMMENT 'FK to compliance.industrial_user. Ref: EPA SDWA.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Each industrial user permit requires a specific sampling plan defining monitoring frequency, parameters, and analytical methods per 40 CFR 403 categorical standards. Business process: Pretreatment pro. Ref: EPA SDWA.',
    `bod_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of BOD in milligrams per liter that the industrial user may discharge to the wastewater collection system. Ref: EPA SDWA.',
    `cadmium_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of cadmium in milligrams per liter. Heavy metal limit for metal finishing and plating industries. Ref: EPA SDWA.',
    `categorical_standard_applicable` BOOLEAN COMMENT 'Indicates whether federal categorical pretreatment standards apply to this industrial user based on SIC code and discharge characteristics. Ref: EPA SDWA.',
    `categorical_standard_citation` STRING COMMENT 'Specific CFR citation for the applicable categorical pretreatment standard (e.g., 40 CFR Part 433 for Metal Finishing). Null if non-categorical. Ref: EPA SDWA.',
    `chromium_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total chromium in milligrams per liter. Heavy metal limit for metal finishing and plating industries. Ref: EPA SDWA.',
    `cod_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of COD in milligrams per liter that the industrial user may discharge to the wastewater collection system. Ref: EPA SDWA.',
    `compliance_schedule_final_date` DATE COMMENT 'Final date by which the industrial user must achieve full compliance with all permit discharge limits. Null if no compliance schedule is required. Ref: EPA SDWA.',
    `compliance_schedule_required` BOOLEAN COMMENT 'Indicates whether the permit includes a compliance schedule with milestones for achieving full compliance with discharge limits. Ref: EPA SDWA.',
    `copper_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of copper in milligrams per liter. Heavy metal limit for metal finishing and plating industries. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user permit record was first created in the system. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Date on which the industrial user permit becomes legally binding and enforceable. Ref: EPA SDWA.',
    `expiration_date` DATE COMMENT 'Date on which the industrial user permit expires and must be renewed or reissued. Nullable for indefinite permits subject to periodic review. Ref: EPA SDWA.',
    `flow_limit_gpd` DECIMAL(18,2) COMMENT 'Maximum permitted daily discharge flow rate in gallons per day (GPD) that the industrial user may discharge to the wastewater collection system. Ref: EPA SDWA.',
    `fog_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of FOG in milligrams per liter that the industrial user may discharge. Critical for food service and processing facilities. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for industrial_user_permit. Ref: EPA SDWA.',
    `inspection_frequency` STRING COMMENT 'Required frequency at which the pretreatment authority will conduct on-site inspections of the industrial facility and pretreatment system. Ref: EPA SDWA.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed`',
    `issuance_date` DATE COMMENT 'Date on which the permit was officially issued by the pretreatment authority. Ref: EPA SDWA.',
    `issuing_authority` STRING COMMENT 'Name of the governmental or utility entity that issued the industrial user permit (e.g., municipal wastewater utility, state environmental agency). Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent on-site inspection conducted by the pretreatment authority. Ref: EPA SDWA.',
    `lead_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of lead in milligrams per liter. Heavy metal limit for metal finishing and plating industries. Ref: EPA SDWA.',
    `mercury_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of mercury in milligrams per liter. Heavy metal limit for dental and medical facilities. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user permit record was last updated in the system. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'Required frequency at which the industrial user must conduct self-monitoring and submit discharge monitoring reports (DMR) to the pretreatment authority. Ref: EPA SDWA.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `naics_code` STRING COMMENT 'Six-digit NAICS code providing additional industry classification for the industrial user. Ref: EPA SDWA.. Valid values are `^d{6}$`',
    `nickel_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of nickel in milligrams per liter. Heavy metal limit for metal finishing and plating industries. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'Externally-known unique permit number assigned to the industrial user under the pretreatment program. Business identifier for regulatory tracking and compliance reporting. Ref: EPA SDWA.. Valid values are `^IUP-[A-Z0-9]{6,12}$`',
    `permit_status` STRING COMMENT 'Current lifecycle status of the industrial user permit. Active permits are in force; expired permits require renewal; suspended or revoked permits indicate enforcement action. Ref: EPA SDWA.. Valid values are `active|expired|suspended|revoked|pending_renewal|terminated`',
    `permit_type` STRING COMMENT 'Classification of the permit based on discharge characteristics and regulatory applicability. Categorical users are subject to federal categorical pretreatment standards; non-categorical users are subject to local limits only. Ref: EPA SDWA.. Valid values are `categorical|non-categorical|significant_industrial_user|minor_industrial_user`',
    `ph_maximum` DECIMAL(18,2) COMMENT 'Maximum permitted pH level for industrial discharge. Typically 9.0 to 12.5 per local limits. Ref: EPA SDWA.',
    `ph_minimum` DECIMAL(18,2) COMMENT 'Minimum permitted pH level for industrial discharge. Typically 5.0 to 6.0 per local limits. Ref: EPA SDWA.',
    `pretreatment_required` BOOLEAN COMMENT 'Indicates whether the industrial user is required to install and operate an on-site pretreatment system to meet discharge limits. Ref: EPA SDWA.',
    `pretreatment_system_description` STRING COMMENT 'Description of the on-site pretreatment system installed by the industrial user (e.g., oil-water separator, pH neutralization, metals precipitation). Null if no pretreatment is required. Ref: EPA SDWA.',
    `sic_code` STRING COMMENT 'Four-digit SIC code classifying the industrial users primary business activity. Used to determine categorical pretreatment standard applicability. Ref: EPA SDWA.. Valid values are `^d{4}$`',
    `silver_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of silver in milligrams per liter. Heavy metal limit for photographic and metal finishing industries. Ref: EPA SDWA.',
    `total_nitrogen_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total nitrogen in milligrams per liter that the industrial user may discharge. Ref: EPA SDWA.',
    `total_phosphorus_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total phosphorus in milligrams per liter that the industrial user may discharge. Ref: EPA SDWA.',
    `tss_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of TSS in milligrams per liter that the industrial user may discharge to the wastewater collection system. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `zinc_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of zinc in milligrams per liter. Heavy metal limit for metal finishing and plating industries. Ref: EPA SDWA.',
    CONSTRAINT pk_industrial_user_permit PRIMARY KEY(`industrial_user_permit_id`)
) COMMENT 'Master record for each Industrial User Permit (IUP) issued under the pretreatment program including permit number, industrial user name, SIC code, permitted discharge limits (BOD, COD, TSS, heavy metals, pH, FOG), permit effective and expiration dates, categorical pretreatment standard applicability, compliance schedule milestones, and issuing authority. Authoritative IUP registry for CWA pretreatment compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` (
    `iup_compliance_sample_id` BIGINT COMMENT 'Unique identifier for the compliance sampling event record. Primary key for the IUP compliance sample entity. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor who collected the sample. Links to workforce registry for certification and training tracking. Ref: LabWare LIMS.',
    `iup_sampler_employee_id` BIGINT COMMENT 'Reference to the employee or contractor who collected the sample. Links to workforce registry for certification and training tracking. Ref: LabWare LIMS.',
    `lab_accreditation_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the analysis. Links to laboratory registry for accreditation and quality assurance tracking. Ref: LabWare LIMS.',
    `industrial_user_permit_id` BIGINT COMMENT 'Reference to the industrial user permit under which this compliance sample was collected. Links the sample to the specific permit being monitored. Ref: LabWare LIMS.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the designated sampling point or monitoring location as defined in the IUP permit conditions. Ref: LabWare LIMS.',
    `analytical_method` STRING COMMENT 'The EPA-approved analytical method used to analyze the parameter (e.g., EPA 405.1 for BOD, EPA 160.2 for TSS, EPA 200.7 for metals). Ref: LabWare LIMS.',
    `chain_of_custody_number` STRING COMMENT 'The unique identifier for the chain of custody documentation that tracks sample handling from collection through analysis. Critical for legal defensibility. Ref: LabWare LIMS.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the sample collection, analysis, or compliance determination. Ref: LabWare LIMS.',
    `compliance_status` STRING COMMENT 'Determination of whether the measured value meets the permit limit requirements. Core field for pretreatment program enforcement and violation tracking. Ref: LabWare LIMS.. Valid values are `compliant|violation|exceedance|not_applicable|pending_review`',
    `composite_duration_hours` DECIMAL(18,2) COMMENT 'For composite samples, the total duration in hours over which the sample was collected (e.g., 24-hour composite). Null for grab samples. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance sample record was first created in the system. Used for audit trail and data lineage tracking. Ref: LabWare LIMS.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of the parameter that the analytical method can reliably detect. Used to interpret non-detect results. Ref: LabWare LIMS.',
    `enforcement_action_required` BOOLEAN COMMENT 'Indicates whether formal enforcement action is required based on the severity or frequency of the violation. True if enforcement action is warranted. Ref: LabWare LIMS.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage by which the measured value exceeds the permit limit, calculated as ((measured_value - permit_limit) / permit_limit) * 100. Null if compliant. Ref: LabWare LIMS.',
    `flow_rate_at_sampling` DECIMAL(18,2) COMMENT 'The wastewater flow rate at the time of sample collection, expressed in gallons per minute (GPM) or million gallons per day (MGD). Used for load calculations. Ref: LabWare LIMS.',
    `flow_rate_unit` DECIMAL(18,2) COMMENT 'The unit of measure for the flow rate (gallons per minute, million gallons per day, liters per minute, cubic meters per day). Ref: LabWare LIMS.',
    `generated` STRING COMMENT 'Auto‑generated attribute for iup_compliance_sample. Ref: LabWare LIMS.',
    `laboratory_report_number` STRING COMMENT 'The unique report or case number assigned by the laboratory to the analytical results. Used for traceability and audit purposes. Ref: LabWare LIMS.',
    `measured_value` DECIMAL(18,2) COMMENT 'The quantitative result of the laboratory analysis for the specified parameter. Represents the concentration or level detected in the sample. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance sample record was last modified. Used for audit trail and change tracking. Ref: LabWare LIMS.',
    `parameter_code` STRING COMMENT 'Standardized code identifying the pollutant or water quality parameter analyzed in this sample (e.g., BOD, TSS, pH, heavy metals). Ref: LabWare LIMS.',
    `parameter_name` STRING COMMENT 'Full name of the pollutant or water quality parameter analyzed (e.g., Biochemical Oxygen Demand, Total Suspended Solids, Cadmium). Ref: LabWare LIMS.',
    `permit_limit` DECIMAL(18,2) COMMENT 'The maximum allowable concentration or discharge limit for this parameter as specified in the industrial user permit. Used to determine compliance status. Ref: LabWare LIMS.',
    `permit_limit_type` STRING COMMENT 'The type of permit limit being evaluated (e.g., daily maximum, monthly average). Defines the averaging period and compliance calculation method. Ref: LabWare LIMS.. Valid values are `daily_maximum|monthly_average|instantaneous|annual_average`',
    `quantification_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of the parameter that can be quantitatively measured with acceptable precision and accuracy. Ref: LabWare LIMS.',
    `result_qualifier` STRING COMMENT 'Laboratory qualifier code indicating special conditions of the result (e.g., J=estimated, U=undetected, ND=non-detect, <MDL=below detection limit). Ref: LabWare LIMS.',
    `review_date` DATE COMMENT 'The date on which the compliance determination was reviewed and approved by pretreatment program staff. Ref: LabWare LIMS.',
    `reviewed_by` STRING COMMENT 'Name of the pretreatment program staff member who reviewed and validated the compliance determination for this sample. Ref: LabWare LIMS.',
    `sample_date` DATE COMMENT 'The date on which the compliance sample was physically collected from the industrial user facility. Ref: LabWare LIMS.',
    `sample_location` STRING COMMENT 'Description of the specific sampling point or location within the industrial facility where the sample was collected (e.g., final discharge point, process outfall). Ref: LabWare LIMS.',
    `sample_number` STRING COMMENT 'Externally-known unique identifier or tracking number assigned to this compliance sample for laboratory and regulatory reference. Ref: LabWare LIMS.',
    `sample_temperature` DECIMAL(18,2) COMMENT 'The temperature of the sample at the time of collection, typically in degrees Celsius. Important for certain parameter analyses and quality control. Ref: LabWare LIMS.',
    `sample_time` TIMESTAMP COMMENT 'The precise timestamp when the compliance sample was collected, including time of day. Critical for composite sample timing and chain of custody. Ref: LabWare LIMS.',
    `sample_type` STRING COMMENT 'The method of sample collection. Grab samples are instantaneous, composite samples are time- or flow-weighted averages over a collection period. Ref: LabWare LIMS.. Valid values are `grab|composite|integrated|continuous`',
    `sample_volume` DECIMAL(18,2) COMMENT 'The volume of sample collected, typically expressed in milliliters or liters. Required for composite sample calculations and quality control. Ref: LabWare LIMS.',
    `sample_volume_unit` STRING COMMENT 'The unit of measure for the sample volume (milliliters, liters, gallons). Ref: LabWare LIMS.. Valid values are `mL|L|gal`',
    `sampler_name` STRING COMMENT 'Name of the individual who collected the sample. Required for chain of custody and quality assurance documentation. Ref: LabWare LIMS.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., mg/L, µg/L, pH units, standard units). Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: LabWare LIMS.',
    `violation_notice_date` DATE COMMENT 'The date on which the notice of violation was issued to the industrial user. Null if no violation notice was issued. Ref: LabWare LIMS.',
    `violation_notice_issued` BOOLEAN COMMENT 'Indicates whether a notice of violation (NOV) was issued to the industrial user as a result of this sample exceedance. True if NOV issued, false otherwise. Ref: LabWare LIMS.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sampling (e.g., dry, rain, snow). Relevant for evaluating potential dilution or inflow and infiltration impacts. Ref: LabWare LIMS.',
    CONSTRAINT pk_iup_compliance_sample PRIMARY KEY(`iup_compliance_sample_id`)
) COMMENT 'Transactional record of each compliance sampling event conducted at an industrial user facility including sample date, sample type (grab, composite), parameters analyzed, measured values, permit limits, compliance determination (compliant/violation), chain of custody reference, and laboratory report reference. Core record for pretreatment program enforcement and annual pretreatment report.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` (
    `fog_source_id` BIGINT COMMENT 'Unique identifier for the FOG generating establishment enrolled in the FOG control program. Ref: EPA SDWA.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: FOG-generating establishments are wastewater service customers. Utilities bill for grease interceptor inspections, pumping requirements, and FOG program compliance through service agreements. Links FO. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: FOG control infrastructure (grease interceptors, traps) may be installed via CIP projects (municipal FOG program implementation). Link supports asset tracking, capital cost recovery from establishment. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: FOG program establishments (restaurants, food service facilities) are commercial customers with utility accounts. FOG program management requires linking to customer accounts for billing inspection fe. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: FOG establishments contract licensed waste haulers for grease interceptor pumping. Linking to vendor master enables manifest verification, service frequency compliance monitoring, hauler performance t. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Grease interceptors at FOG sources are physical assets requiring maintenance tracking, pumping schedules, condition assessments, and replacement planning. Asset registry integration enables preventive. Ref: EPA SDWA.',
    `address_line1` STRING COMMENT 'Primary street address of the FOG generating establishment. Ref: EPA SDWA.',
    `address_line2` STRING COMMENT 'Secondary address information such as suite, unit, or building number for the FOG establishment. Ref: EPA SDWA.',
    `best_management_practices_required` STRING COMMENT 'Description of specific best management practices required for the establishment to control FOG discharge and prevent sewer blockages. Ref: EPA SDWA.',
    `city` STRING COMMENT 'City where the FOG generating establishment is located. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Current compliance status of the establishment with FOG program requirements and permit conditions. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|warning|violation`',
    `contact_email` STRING COMMENT 'Email address for the establishment contact responsible for FOG program compliance and communications. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person responsible for FOG program compliance at the establishment. Ref: EPA SDWA.',
    `contact_phone` STRING COMMENT 'Primary phone number for the establishment contact responsible for FOG compliance. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the FOG source record was first created in the system. Ref: EPA SDWA.',
    `enrollment_date` DATE COMMENT 'Date when the establishment was enrolled in the FOG control program. Ref: EPA SDWA.',
    `establishment_name` STRING COMMENT 'Legal or trade name of the FOG generating establishment (restaurant, food processor, institutional kitchen). Ref: EPA SDWA.',
    `establishment_type` STRING COMMENT 'Classification of the FOG generating establishment based on business operations and FOG generation profile. Ref: EPA SDWA.. Valid values are `restaurant|food_processor|institutional_kitchen|commercial_kitchen|bakery|other`',
    `generated` STRING COMMENT 'Auto‑generated attribute for fog_source. Ref: EPA SDWA.',
    `inspection_frequency_days` STRING COMMENT 'Scheduled frequency in days for regulatory inspections of the FOG establishment and grease interceptor. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent FOG program compliance inspection conducted at the establishment. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the FOG establishment for GIS mapping and spatial analysis. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the FOG establishment for GIS mapping and spatial analysis. Ref: EPA SDWA.',
    `next_inspection_date` DATE COMMENT 'Date when the next FOG program compliance inspection is scheduled for the establishment. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the FOG establishment and program management. Ref: EPA SDWA.',
    `permit_expiration_date` DATE COMMENT 'Date when the current FOG permit expires and requires renewal. Ref: EPA SDWA.',
    `permit_issue_date` DATE COMMENT 'Date when the FOG permit was originally issued to the establishment. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'Unique permit number issued to the establishment for FOG discharge and control program enrollment. Ref: EPA SDWA.',
    `permit_status` STRING COMMENT 'Current status of the FOG permit indicating compliance standing and authorization to discharge. Ref: EPA SDWA.. Valid values are `active|expired|suspended|revoked|pending|inactive`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the FOG generating establishment location. Ref: EPA SDWA.',
    `required_pumping_frequency_days` STRING COMMENT 'Mandated frequency in days for pumping and cleaning the grease interceptor to prevent FOG buildup and sewer blockages. Ref: EPA SDWA.',
    `risk_rating` STRING COMMENT 'Risk classification of the establishment based on FOG generation volume, compliance history, and potential for sewer blockages. Ref: EPA SDWA.. Valid values are `low|medium|high|critical`',
    `sso_contribution_flag` BOOLEAN COMMENT 'Indicator of whether the establishment has been identified as a contributing source to a sanitary sewer overflow event. Ref: EPA SDWA.',
    `state` STRING COMMENT 'State or province where the FOG generating establishment is located. Ref: EPA SDWA.',
    `termination_date` DATE COMMENT 'Date when the establishment was removed from the FOG control program due to closure, permit revocation, or other reasons. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the FOG source record was last modified in the system. Ref: EPA SDWA.',
    `violation_count` STRING COMMENT 'Total number of FOG program violations recorded for the establishment since enrollment. Ref: EPA SDWA.',
    CONSTRAINT pk_fog_source PRIMARY KEY(`fog_source_id`)
) COMMENT 'Master record for each Fats, Oils, and Grease (FOG) generating establishment and associated inspection history under the FOG control program. Includes business name, address, establishment type (restaurant, food processor, institutional kitchen), grease interceptor size, pumping frequency requirement, permit status, inspection schedule, and inspection event records capturing interceptor condition, grease depth measurements, pumping manifest verification, compliance status, and corrective actions. Supports FOG program management, enforcement documentation, and SSO prevention.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` (
    `fog_inspection_id` BIGINT COMMENT 'Unique identifier for the FOG inspection record. Primary key for the fog_inspection product. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FOG program costs (inspector salaries, vehicle expenses, enforcement actions) are tracked to cost centers for program cost recovery analysis, permit fee setting, and rate design justification. Ref: EPA SDWA.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: FOG inspection programs often deploy field crews for route-based inspections of multiple establishments per day. Supports crew scheduling, route optimization, daily inspection quotas, and distinguishe. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: FOG inspections finding violations trigger enforcement actions (NOVs, administrative orders, penalties) under pretreatment program authority. Real process: FOG ordinance enforcement workflow from insp. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Identifier of the utility employee or contractor who performed the FOG inspection. Ref: EPA SDWA.',
    `grease_interceptor_id` BIGINT COMMENT 'Identifier or tag number of the grease interceptor (grease trap) inspected at the establishment. Ref: EPA SDWA.',
    `inspector_employee_id` BIGINT COMMENT 'Identifier of the utility employee or contractor who performed the FOG inspection. Ref: EPA SDWA.',
    `fog_source_id` BIGINT COMMENT 'Identifier of the grease-generating establishment (food service establishment, restaurant, commercial kitchen) being inspected under the FOG program. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Identifier or tag number of the grease interceptor (grease trap) inspected at the establishment. Ref: EPA SDWA.',
    `best_management_practices_compliant` BOOLEAN COMMENT 'Indicates whether the establishment is following FOG best management practices including proper waste disposal, employee training, and grease minimization procedures. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the establishment based on this inspection: compliant with FOG regulations, non-compliant with violations noted, conditional compliance pending corrective action, or pending review. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|conditional|pending_review`',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions required to achieve compliance, including specific steps the establishment must take. Ref: EPA SDWA.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the establishment must complete required corrective actions to avoid enforcement action. Ref: EPA SDWA.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the establishment is required to take corrective action to address violations or deficiencies identified during the inspection. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG inspection record was first created in the system. Ref: EPA SDWA.',
    `enforcement_action_recommended` BOOLEAN COMMENT 'Indicates whether the inspector recommends formal enforcement action (notice of violation, administrative order, penalty) based on inspection findings. Ref: EPA SDWA.',
    `enforcement_action_type` STRING COMMENT 'Type of enforcement action recommended: warning letter, notice of violation, administrative order, civil penalty assessment, or permit suspension. Ref: EPA SDWA.. Valid values are `warning|notice_of_violation|administrative_order|civil_penalty|permit_suspension`',
    `establishment_contact_name` STRING COMMENT 'Name of the establishment representative (owner, manager, or designated contact) present during the inspection. Ref: EPA SDWA.',
    `establishment_contact_signature` STRING COMMENT 'Digital signature or acknowledgment indicator from the establishment contact confirming receipt of inspection findings and corrective action requirements. Ref: EPA SDWA.',
    `follow_up_required` BOOLEAN COMMENT 'follow up required. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for fog_inspection. Ref: EPA SDWA.',
    `grease_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth of accumulated grease layer in the interceptor in inches. Excessive depth indicates need for pumping and cleaning. Ref: EPA SDWA.',
    `grease_depth_percentage` DECIMAL(18,2) COMMENT 'Grease accumulation as a percentage of total interceptor capacity. Regulatory thresholds typically require pumping at 25% accumulation. Ref: EPA SDWA.',
    `hauler_license_number` STRING COMMENT 'License number of the grease hauling contractor used by the establishment for interceptor pumping and waste disposal. Ref: EPA SDWA.',
    `inspection_date` DATE COMMENT 'Date when the FOG inspection was conducted at the establishment. Ref: EPA SDWA.',
    `inspection_notes` STRING COMMENT 'Free-form notes and observations recorded by the inspector during the FOG inspection, including additional context not captured in structured fields. Ref: EPA SDWA.',
    `inspection_number` STRING COMMENT 'Business-facing unique inspection number assigned to this FOG inspection for tracking and reference purposes. Ref: EPA SDWA.',
    `inspection_result` STRING COMMENT 'inspection result. Ref: EPA SDWA.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the FOG inspection: scheduled, in progress, completed, cancelled, or failed to complete. Ref: EPA SDWA.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `inspection_time` TIMESTAMP COMMENT 'Precise timestamp when the FOG inspection began, including time of day. Ref: EPA SDWA.',
    `inspection_type` STRING COMMENT 'Classification of the FOG inspection type: routine scheduled inspection, follow-up after violation, complaint-driven, pre-permit issuance, annual compliance, or re-inspection after corrective action. Ref: EPA SDWA.. Valid values are `routine|follow_up|complaint_driven|pre_permit|annual|re_inspection`',
    `inspector_name` STRING COMMENT 'Full name of the inspector who conducted the FOG inspection. Ref: EPA SDWA.',
    `interceptor_capacity_gallons` DECIMAL(18,2) COMMENT 'Rated capacity of the grease interceptor in gallons, indicating the volume of wastewater it can process. Ref: EPA SDWA.',
    `interceptor_condition` STRING COMMENT 'Physical condition assessment of the grease interceptor at time of inspection: good working order, fair with minor issues, poor requiring maintenance, critical requiring immediate action, or not accessible for inspection. Ref: EPA SDWA.. Valid values are `good|fair|poor|critical|not_accessible`',
    `interceptor_type` STRING COMMENT 'Type of grease interceptor installed: gravity interceptor, hydromechanical grease interceptor, automatic grease removal device, or passive grease trap. Ref: EPA SDWA.. Valid values are `gravity|hydromechanical|automatic|passive`',
    `last_pumping_date` DATE COMMENT 'Date when the grease interceptor was last pumped and cleaned, as reported by the establishment or verified from manifest records. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG inspection record was last modified or updated. Ref: EPA SDWA.',
    `photo_count` STRING COMMENT 'Number of photographs taken during the inspection and attached to the inspection record. Ref: EPA SDWA.',
    `photos_taken` BOOLEAN COMMENT 'Indicates whether photographic documentation was captured during the inspection for evidence and record-keeping purposes. Ref: EPA SDWA.',
    `pumping_frequency_days` STRING COMMENT 'Required or observed frequency of grease interceptor pumping in days, based on establishment type and grease generation rate. Ref: EPA SDWA.',
    `pumping_manifest_verified` BOOLEAN COMMENT 'Indicates whether the inspector verified the pumping manifest documentation from a licensed hauler for the most recent grease interceptor pumping event. Ref: EPA SDWA.',
    `re_inspection_date` DATE COMMENT 'Scheduled date for the follow-up re-inspection to verify corrective action completion. Ref: EPA SDWA.',
    `re_inspection_required` BOOLEAN COMMENT 'Indicates whether a follow-up re-inspection is required to verify corrective action completion and compliance restoration. Ref: EPA SDWA.',
    `solids_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth of settled solids at the bottom of the interceptor in inches. Ref: EPA SDWA.',
    `sso_risk_assessment` STRING COMMENT 'Inspector assessment of the risk that this establishments FOG discharge practices pose to causing a sanitary sewer overflow event: low, moderate, high, or imminent risk. Ref: EPA SDWA.. Valid values are `low|moderate|high|imminent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `violation_count` STRING COMMENT 'Number of distinct FOG program violations identified during this inspection. Ref: EPA SDWA.',
    `violation_description` STRING COMMENT 'Detailed description of all FOG program violations noted during the inspection, including specific regulatory requirements not met. Ref: EPA SDWA.',
    `violation_found_flag` BOOLEAN COMMENT 'violation found flag. Ref: EPA SDWA.',
    `violation_severity` STRING COMMENT 'Severity classification of the most serious violation identified: minor administrative issue, moderate operational deficiency, major compliance failure, or critical risk to sewer system. Ref: EPA SDWA.. Valid values are `minor|moderate|major|critical`',
    `violations_noted` BOOLEAN COMMENT 'Indicates whether any FOG program violations were identified during this inspection. Ref: EPA SDWA.',
    CONSTRAINT pk_fog_inspection PRIMARY KEY(`fog_inspection_id`)
) COMMENT 'Transactional record of each FOG program inspection at a grease-generating establishment including inspection date, inspector, interceptor condition, grease depth measurement, pumping manifest verification, compliance status, violations noted, corrective action required, and re-inspection date. Supports FOG enforcement and SSO prevention program documentation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` (
    `biosolids_batch_id` BIGINT COMMENT 'Unique identifier for the biosolids production batch. Primary key for the biosolids batch record. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Biosolids treatment facilities/upgrades are delivered via CIP projects. Linking batches to the project that commissioned the treatment infrastructure supports performance validation, regulatory compli. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this biosolids batch was produced. Links batch to permit limits and reporting requirements. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Biosolids treatment and disposal costs (dewatering, hauling, testing, land application) are tracked to cost centers for unit cost analysis, budget planning, and rate case support of biosolids manageme. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Biosolids hauling and land application services are contracted to specialized vendors. Regulatory traceability requires linking each batch to the licensed hauler for manifest compliance (40 CFR 503),. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Every biosolids batch requires pathogen and metals analysis before land application per 40 CFR Part 503. Business process: Class A/B certification, exceptional quality determination, and land applicat. Ref: EPA SDWA.',
    `process_unit_id` BIGINT COMMENT 'Reference to the specific treatment process unit (digester, dewatering equipment, stabilization system) that produced this batch. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Biosolids processing operations generate maintenance work orders when equipment (centrifuges, belt presses, dryers) fails during batch processing. Work order linkage enables equipment failure cost all. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Reference to the wastewater treatment plant where this biosolids batch was produced. Ref: EPA SDWA.',
    `arsenic_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Arsenic concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 75 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `batch_date` DATE COMMENT 'The date when this biosolids batch was produced and removed from the treatment process. Critical for regulatory compliance and shelf-life tracking. Ref: EPA SDWA.',
    `batch_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the biosolids batch production process was completed and the material was ready for disposition. Ref: EPA SDWA.',
    `batch_number` STRING COMMENT 'Business-assigned unique batch number or identifier for tracking and traceability purposes. Used in regulatory reporting and chain-of-custody documentation. Ref: EPA SDWA.',
    `batch_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the biosolids batch production process began, including dewatering or stabilization initiation. Ref: EPA SDWA.',
    `biosolids_class` STRING COMMENT 'biosolids class. Ref: EPA SDWA.',
    `cadmium_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Cadmium concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 85 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `copper_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Copper concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 4,300 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this biosolids batch record was first created in the system. Used for audit trail and data lineage tracking. Ref: EPA SDWA.',
    `disposition_date` DATE COMMENT 'The date when this biosolids batch was disposed of, applied to land, or transferred for beneficial reuse. Required for regulatory tracking and chain-of-custody documentation. Ref: EPA SDWA.',
    `disposition_method` STRING COMMENT 'The final disposition method for this biosolids batch. Determines applicable regulatory requirements under 40 CFR Part 503 Subparts B, C, D, or E. Ref: EPA SDWA.. Valid values are `land_application|landfill|incineration|beneficial_reuse|composting|surface_disposal`',
    `disposition_site_name` STRING COMMENT 'Name of the land application site, landfill, incinerator, or beneficial reuse facility where this batch was sent. Ref: EPA SDWA.',
    `disposition_site_permit_number` STRING COMMENT 'Regulatory permit number for the disposition site (land application permit, landfill permit, incinerator air permit, etc.). Ref: EPA SDWA.',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period (YYYY-MM format) to which this batch should be included. Used for automated DMR preparation. Ref: EPA SDWA.',
    `dry_tons` DECIMAL(18,2) COMMENT 'dry tons. Ref: EPA SDWA.',
    `dry_weight_tons` DECIMAL(18,2) COMMENT 'Total dry weight of the biosolids batch in US tons (2,000 lbs). Used for regulatory reporting, disposal tracking, and beneficial use application rate calculations. Ref: EPA SDWA.',
    `exceptional_quality_flag` BOOLEAN COMMENT 'Indicates whether this batch meets Exceptional Quality criteria (Class A pathogen reduction, pollutant concentration limits per Table 3, and vector attraction reduction). EQ biosolids have no federal land application restrictions. Ref: EPA SDWA.',
    `fecal_coliform_density_mpn_per_gram` DECIMAL(18,2) COMMENT 'Fecal coliform density in MPN per gram of total solids (dry weight basis). Class A requires <1,000 MPN/g; Class B requires <2,000,000 MPN/g. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for biosolids_batch. Ref: EPA SDWA.',
    `laboratory_analysis_date` DATE COMMENT 'Date when laboratory analysis of this batch was completed. Used to verify compliance with monitoring frequency requirements. Ref: EPA SDWA.',
    `lead_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Lead concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 840 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `mercury_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Mercury concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 57 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `nickel_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Nickel concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 420 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes regarding batch production, quality issues, special handling requirements, or other operational observations. Ref: EPA SDWA.',
    `pathogen_class` STRING COMMENT 'Classification of pathogen reduction achieved: Class A (unrestricted use, meets PFRP requirements) or Class B (restricted use, meets PSRP requirements) per 40 CFR Part 503. Ref: EPA SDWA.. Valid values are `class_a|class_b`',
    `percent_solids` DECIMAL(18,2) COMMENT 'Percentage of total solids content in the biosolids batch. Typical range: 15-30% for dewatered cake, 90%+ for dried pellets. Critical for vector attraction reduction Option 7 (75% solids minimum). Ref: EPA SDWA.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the biosolids batch. Required for alkaline stabilization processes (pH 12+ for 2 hours minimum per vector attraction reduction Option 6). Ref: EPA SDWA.',
    `production_date` TIMESTAMP COMMENT 'production date. Ref: EPA SDWA.',
    `salmonella_density_mpn_per_4_grams` DECIMAL(18,2) COMMENT 'Salmonella sp. bacteria density in MPN per 4 grams of total solids (dry weight basis). Class A requires <3 MPN/4g. Ref: EPA SDWA.',
    `selenium_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Selenium concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 100 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    `stabilization_method` STRING COMMENT 'stabilization method. Ref: EPA SDWA.',
    `total_nitrogen_percent` DECIMAL(18,2) COMMENT 'Total nitrogen content as percentage of dry weight. Important for agronomic application rate calculations and nutrient management planning. Ref: EPA SDWA.',
    `total_phosphorus_percent` DECIMAL(18,2) COMMENT 'Total phosphorus content as percentage of dry weight. Critical for land application planning and nutrient management compliance. Ref: EPA SDWA.',
    `total_potassium_percent` DECIMAL(18,2) COMMENT 'Total potassium content as percentage of dry weight. Used for fertilizer value assessment and agronomic rate calculations. Ref: EPA SDWA.',
    `treatment_process` STRING COMMENT 'treatment process. Ref: EPA SDWA.',
    `treatment_process_type` STRING COMMENT 'The primary treatment process used to stabilize this biosolids batch. Determines pathogen reduction and vector attraction reduction requirements. Ref: EPA SDWA.. Valid values are `anaerobic_digestion|aerobic_digestion|lime_stabilization|composting|heat_drying|alkaline_stabilization`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `vector_attraction_reduction_method` TIMESTAMP COMMENT 'The specific vector attraction reduction option (1-10) applied per 40 CFR Part 503.33. Options include volatile solids reduction, digestion, pH adjustment, moisture reduction, and others. Ref: EPA SDWA.',
    `volatile_solids_reduction_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in volatile solids achieved during treatment. Required for vector attraction reduction Options 1 and 2 (38% minimum reduction). Ref: EPA SDWA.',
    `wet_weight_tons` DECIMAL(18,2) COMMENT 'Total wet weight (as-hauled) of the biosolids batch in US tons. Used for transportation logistics and disposal facility invoicing. Ref: EPA SDWA.',
    `zinc_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Zinc concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 7,500 mg/kg per 40 CFR Part 503 Table 1. Ref: EPA SDWA.',
    CONSTRAINT pk_biosolids_batch PRIMARY KEY(`biosolids_batch_id`)
) COMMENT 'Transactional record of each biosolids production batch and its final disposition including land application events. Captures batch production details (date, source WWTP, treatment process, dry weight tonnage, pathogen reduction class per 40 CFR Part 503, vector attraction reduction method, pollutant concentrations) and disposition records including land application specifics (site identifier, field acreage, application rate, cumulative pollutant loading, agronomic rate justification, buffer zone compliance). Supports complete biosolids chain-of-custody from production through beneficial reuse or disposal per Part 503 requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` (
    `biosolids_land_application_id` BIGINT COMMENT 'Unique identifier for the biosolids land application event. Primary key for this transactional record. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EPA Part 503 and state biosolids regulations require certified applicator tracking for land application events. Links enable certification verification (applicator_certification_number validation), tr. Ref: EPA SDWA.',
    `biosolids_batch_id` BIGINT COMMENT 'Reference to the specific biosolids batch or lot applied, linking to quality testing and characterization data. Ref: EPA SDWA.',
    `biosolids_land_application_site_id` BIGINT COMMENT 'land application site id. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the regulatory permit authorizing biosolids land application at this site. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Land application program costs (hauling, spreading equipment, site monitoring, agronomic testing) are allocated to cost centers for biosolids disposal cost analysis and beneficial reuse program budget. Ref: EPA SDWA.',
    `land_application_site_id` BIGINT COMMENT 'Reference to the approved land application site where biosolids were applied. Ref: EPA SDWA.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Land application events require annual Part 503 reports to EPA/state. Linking enables biosolids program submission tracking, agency acknowledgment, deficiency management, and cumulative pollutant load. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Reference to the wastewater treatment plant that produced the biosolids being applied. Ref: EPA SDWA.',
    `agronomic_rate_compliance_flag` BOOLEAN COMMENT 'agronomic rate compliance flag. Ref: EPA SDWA.',
    `agronomic_rate_justification` DECIMAL(18,2) COMMENT 'Documentation explaining how the application rate meets agronomic requirements based on crop nitrogen needs and soil conditions. Ref: EPA SDWA.',
    `application_date` DATE COMMENT 'The date on which biosolids were applied to the land. Principal business event timestamp for this transaction. Ref: EPA SDWA.',
    `application_method` STRING COMMENT 'Method used to apply biosolids to the land (surface spreading, subsurface injection, or incorporation). Ref: EPA SDWA.. Valid values are `surface_spread|injection|incorporation`',
    `application_number` STRING COMMENT 'Business identifier for the land application event, used for external tracking and reporting. Ref: EPA SDWA.',
    `application_rate_dry_tons_per_acre` DECIMAL(18,2) COMMENT 'Rate at which biosolids were applied to the field, measured in dry tons per acre. Ref: EPA SDWA.',
    `application_status` STRING COMMENT 'Current lifecycle status of the land application event in the operational workflow. Ref: EPA SDWA.. Valid values are `planned|in_progress|completed|cancelled|suspended`',
    `applicator_certification_number` STRING COMMENT 'State-issued certification or license number of the biosolids applicator. Ref: EPA SDWA.',
    `arsenic_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative arsenic loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `biosolids_class` STRING COMMENT 'EPA classification of the biosolids applied (Class A, Class B, or Exceptional Quality) based on pathogen reduction and vector attraction reduction requirements. Ref: EPA SDWA.. Valid values are `class_a|class_b|exceptional_quality`',
    `buffer_zone_compliant` BOOLEAN COMMENT 'Indicates whether the application maintained required buffer distances from water bodies, property lines, and other sensitive areas. Ref: EPA SDWA.',
    `cadmium_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative cadmium loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `copper_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative copper loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this land application record was first created in the system. Ref: EPA SDWA.',
    `crop_type` STRING COMMENT 'Type of crop grown or planned for the field receiving biosolids application. Ref: EPA SDWA.',
    `cumulative_pollutant_loading_rate_compliant` DECIMAL(18,2) COMMENT 'Indicates whether the cumulative pollutant loading rates for heavy metals remain within EPA limits after this application. Ref: EPA SDWA.',
    `dry_tons_applied` DECIMAL(18,2) COMMENT 'dry tons applied. Ref: EPA SDWA.',
    `field_acreage` DECIMAL(18,2) COMMENT 'Total acreage of the field receiving biosolids application, measured in acres. Ref: EPA SDWA.',
    `field_identifier` STRING COMMENT 'Specific field or parcel identifier within the land application site where biosolids were applied. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for biosolids_land_application. Ref: EPA SDWA.',
    `hauler_company_name` STRING COMMENT 'Name of the company or contractor responsible for transporting and applying the biosolids. Ref: EPA SDWA.',
    `lead_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative lead loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `mercury_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative mercury loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `nickel_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative nickel loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `nitrogen_content_percent` DECIMAL(18,2) COMMENT 'Total nitrogen content of the biosolids as a percentage of dry weight, used for agronomic rate calculations. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes or observations recorded during the land application event. Ref: EPA SDWA.',
    `pathogen_reduction_method` STRING COMMENT 'EPA-approved method used to reduce pathogens in the biosolids to meet Class A or Class B requirements. Ref: EPA SDWA.',
    `percent_solids` DECIMAL(18,2) COMMENT 'Percent solids content of the biosolids at the time of application, used to convert between wet and dry weight. Ref: EPA SDWA.',
    `plant_available_nitrogen_lbs_per_acre` DECIMAL(18,2) COMMENT 'Estimated plant-available nitrogen applied per acre, accounting for mineralization rates and crop uptake. Ref: EPA SDWA.',
    `selenium_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative selenium loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    `site_access_restriction_end_date` DATE COMMENT 'Date when site access restrictions expire and public access is permitted. Ref: EPA SDWA.',
    `site_access_restriction_period_days` STRING COMMENT 'Number of days that public access to the site must be restricted following biosolids application. Ref: EPA SDWA.',
    `site_access_restriction_required` BOOLEAN COMMENT 'Indicates whether site access restrictions are required following application based on biosolids class and pathogen reduction level. Ref: EPA SDWA.',
    `total_dry_tons_applied` DECIMAL(18,2) COMMENT 'Total quantity of biosolids applied during this event, measured in dry metric tons. Ref: EPA SDWA.',
    `total_wet_tons_applied` DECIMAL(18,2) COMMENT 'Total quantity of biosolids applied during this event, measured in wet (as-applied) metric tons. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this land application record was last modified in the system. Ref: EPA SDWA.',
    `vector_attraction_reduction_method` TIMESTAMP COMMENT 'EPA-approved method used to reduce vector attraction (insects, rodents) in the biosolids, identified by 40 CFR 503.33 option number. Ref: EPA SDWA.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of application, relevant for runoff and odor management. Ref: EPA SDWA.',
    `zinc_loading_kg_per_hectare` DECIMAL(18,2) COMMENT 'Cumulative zinc loading on the site after this application, measured in kilograms per hectare. Ref: EPA SDWA.',
    CONSTRAINT pk_biosolids_land_application PRIMARY KEY(`biosolids_land_application_id`)
) COMMENT 'Transactional record of each biosolids land application event including application date, site identifier, field acreage, biosolids batch reference, application rate (dry tons/acre), cumulative pollutant loading calculations, agronomic rate justification, buffer zone compliance, and site access restrictions. Required for 40 CFR Part 503 land application recordkeeping and annual reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` (
    `sewer_inspection_id` BIGINT COMMENT 'Unique identifier for each sewer inspection event. Primary key for the sewer inspection data product. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: CCTV inspections conducted as part of CIP projects (pre-construction baseline, post-construction acceptance) must be linked to the project for deliverable tracking, payment certification, warranty bas. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CCTV inspection program costs (contractor fees, equipment depreciation, staff time) are allocated to cost centers for capital planning budgets, asset management program funding, and rate case support. Ref: EPA SDWA.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Large-scale CCTV/PACP sewer inspections are crew-based operations requiring equipment operators, traffic control, and technicians. Enables crew scheduling, resource planning, certification verificatio. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'employee id. Ref: EPA SDWA.',
    `manhole_id` BIGINT COMMENT 'Foreign key reference to the manhole inspected, when the asset type is manhole. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key reference to the sewer pipe segment inspected, when the asset type is pipe. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Sewer CCTV/PACP inspections routinely collect water samples during field work to analyze infiltration water quality, identify contamination sources, or assess groundwater intrusion chemistry. Links in. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the maintenance work order or service request that triggered this inspection, linking inspection to asset management workflows. Ref: EPA SDWA.',
    `asset_identifier` STRING COMMENT 'Business-facing identifier or tag of the specific asset inspected (pipe segment number, manhole number, etc.), used for field reference and reporting. Ref: EPA SDWA.',
    `asset_type` STRING COMMENT 'The type of sewer infrastructure asset being inspected, distinguishing between pipes, manholes, and other components. Ref: EPA SDWA.. Valid values are `pipe|manhole|lateral|junction|cleanout`',
    `condition_grade` STRING COMMENT 'Overall structural condition rating of the inspected asset based on NASSCO PACP or MACP grading scale (1=excellent, 5=imminent failure). Primary output of the inspection. Ref: EPA SDWA.. Valid values are `1|2|3|4|5`',
    `contractor_name` STRING COMMENT 'Name of the third-party contractor or vendor who performed the inspection, if the work was outsourced. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system, for audit trail and data lineage tracking. Ref: EPA SDWA.',
    `critical_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether any critical or high-severity defects were identified that require immediate attention or emergency repair. Ref: EPA SDWA.',
    `defect_codes` STRING COMMENT 'Comma-separated list of NASSCO defect codes identified during the inspection (e.g., CL for crack longitudinal, RB for roots, DP for deformed pipe), used for detailed condition analysis. Ref: EPA SDWA.',
    `defect_count` STRING COMMENT 'Total number of discrete defects identified during the inspection, used as a quick indicator of asset condition complexity. Ref: EPA SDWA.',
    `downstream_manhole_number` STRING COMMENT 'Identifier of the downstream manhole for pipe segment inspections, establishing the ending point of the inspection run. Ref: EPA SDWA.',
    `estimated_repair_cost_usd` DECIMAL(18,2) COMMENT 'Preliminary cost estimate in US dollars for the recommended repair or rehabilitation action, used for capital planning and budget forecasting. Ref: EPA SDWA.',
    `flow_condition` STRING COMMENT 'Flow level observed in the pipe during inspection, impacting visibility and the ability to assess certain defects. Ref: EPA SDWA.. Valid values are `dry|low|medium|high|surcharge`',
    `fog_accumulation_flag` BOOLEAN COMMENT 'Boolean indicator of whether FOG buildup was observed, requiring cleaning and potentially indicating FOG program enforcement needs. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for sewer_inspection. Ref: EPA SDWA.',
    `infiltration_observed_flag` BOOLEAN COMMENT 'Boolean indicator of whether infiltration or inflow was observed during the inspection, contributing to non-revenue water and treatment plant overload. Ref: EPA SDWA.',
    `inspection_date` DATE COMMENT 'The date on which the sewer inspection was performed. Principal business event timestamp for this transaction. Ref: EPA SDWA.',
    `inspection_direction` STRING COMMENT 'Direction of travel during the inspection relative to flow direction, relevant for CCTV and sonar inspections of pipe segments. Ref: EPA SDWA.. Valid values are `upstream|downstream`',
    `inspection_length_feet` DECIMAL(18,2) COMMENT 'Total length of pipe segment inspected, measured in feet, used to calculate condition per linear foot and prioritize rehabilitation. Ref: EPA SDWA.',
    `inspection_method` STRING COMMENT 'The technology or technique used to perform the inspection. CCTV is the most common method for pipe condition assessment. Ref: EPA SDWA.. Valid values are `CCTV|sonar|smoke_test|dye_test|visual|laser_profiling`',
    `inspection_number` STRING COMMENT 'Business-facing unique identifier or work order number assigned to this inspection event for tracking and reference purposes. Ref: EPA SDWA.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record, tracking workflow from scheduling through final approval and integration into asset records. Ref: EPA SDWA.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `inspection_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection commenced, including time of day for scheduling and operational tracking. Ref: EPA SDWA.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose or trigger, distinguishing between scheduled maintenance, reactive response, and compliance-driven inspections. Ref: EPA SDWA.. Valid values are `routine|emergency|post_repair|pre_construction|complaint_driven|regulatory`',
    `inspector_certification_number` STRING COMMENT 'Professional certification number of the inspector, typically NASSCO PACP or MACP certification, ensuring qualified personnel perform assessments. Ref: EPA SDWA.',
    `inspector_name` STRING COMMENT 'Name of the individual technician or engineer who performed the inspection, for accountability and quality assurance. Ref: EPA SDWA.',
    `macp_score` STRING COMMENT 'Numeric MACP score calculated from defect observations, representing the overall structural and operational condition of the manhole. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional observations, context, or special conditions noted during the inspection that do not fit structured fields. Ref: EPA SDWA.',
    `operational_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether operational defects (roots, grease, debris, infiltration, exfiltration) were observed, impacting flow capacity. Ref: EPA SDWA.',
    `pacp_score` STRING COMMENT 'Numeric PACP score calculated from defect observations, representing the overall structural and operational condition of the pipe segment. Ref: EPA SDWA.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the pipe inspected, measured in inches, relevant for capacity and defect severity assessment. Ref: EPA SDWA.',
    `pipe_material` STRING COMMENT 'Material composition of the pipe inspected (e.g., vitrified clay, PVC, concrete, cast iron), influencing defect types and rehabilitation methods. Ref: EPA SDWA.',
    `recommended_action` STRING COMMENT 'Recommended maintenance or capital action based on inspection findings, guiding asset management and CIP prioritization decisions. Ref: EPA SDWA.. Valid values are `no_action|monitor|cleaning|spot_repair|rehabilitation|replacement`',
    `rehabilitation_method` STRING COMMENT 'Specific rehabilitation technique recommended if repair or renewal is needed (e.g., CIPP lining, pipe bursting, open-cut replacement, spot repair, manhole lining). Ref: EPA SDWA.',
    `rehabilitation_recommended_flag` BOOLEAN COMMENT 'rehabilitation recommended flag. Ref: EPA SDWA.',
    `report_file_path` STRING COMMENT 'File system path or URL to the formal inspection report document, typically in PDF format, for regulatory and asset management records. Ref: EPA SDWA.',
    `review_date` DATE COMMENT 'Date on which the inspection report was reviewed and approved by qualified personnel, completing the quality assurance process. Ref: EPA SDWA.',
    `reviewed_by` STRING COMMENT 'Name of the engineer or supervisor who reviewed and validated the inspection findings, ensuring quality control and technical accuracy.',
    `root_intrusion_flag` BOOLEAN COMMENT 'Boolean indicator of whether tree root intrusion was observed, a common cause of blockages and structural damage in gravity sewers. Ref: EPA SDWA.',
    `structural_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether structural defects (cracks, fractures, collapse, deformation) were observed, impacting asset integrity. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last modified, supporting change tracking and audit compliance. Ref: EPA SDWA.',
    `upstream_manhole_number` STRING COMMENT 'Identifier of the upstream manhole for pipe segment inspections, establishing the starting point of the inspection run. Ref: EPA SDWA.',
    `urgency_classification` STRING COMMENT 'Priority level assigned to the recommended action, used to sequence capital projects and maintenance work in the CIP and O&M budgets. Ref: EPA SDWA.. Valid values are `immediate|high|medium|low|routine`',
    `video_file_path` STRING COMMENT 'File system path or URL to the recorded CCTV or sonar video file, enabling review and validation of inspection findings. Ref: EPA SDWA.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection (dry, wet, recent rain), relevant for interpreting infiltration and flow observations. Ref: EPA SDWA.',
    CONSTRAINT pk_sewer_inspection PRIMARY KEY(`sewer_inspection_id`)
) COMMENT 'Transactional record of each sewer pipe or manhole inspection event including inspection date, inspection method (CCTV, sonar, smoke test, dye test), inspector or contractor, pipe segment or manhole inspected, condition grade (NASSCO PACP/MACP rating), defect codes identified, recommended rehabilitation method (CIPP, pipe bursting, spot repair), and urgency classification. Feeds asset renewal planning and CIP prioritization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` (
    `collection_system_blockage_id` BIGINT COMMENT 'Unique identifier for each sewer blockage or stoppage event in the collection system. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Chronic blockage locations trigger rehabilitation CIP projects. Tracking this relationship justifies capital investment (demonstrating O&M cost avoidance), measures project effectiveness (blockage rec. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Blockage response costs (crew overtime, equipment rental, emergency repairs) are charged to cost centers for O&M budget tracking, performance metrics, and preventive maintenance program justification. Ref: EPA SDWA.',
    `crew_id` BIGINT COMMENT 'Reference to the maintenance crew or team that responded to and cleared the blockage. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Collection system blockages often originate from customer properties (FOG, improper disposal, lateral defects) or impact customers through service disruptions and backups. Linking enables tracking cus. Ref: EPA SDWA.',
    `manhole_id` BIGINT COMMENT 'Reference to the manhole location associated with the blockage event if applicable. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Blockages often occur at specific assets (valves, cleanouts, pump stations) requiring failure tracking for reliability-centered maintenance. Asset-level failure records enable MTBF/MTTR analysis, root. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Emergency blockage response requires individual technician accountability beyond crew_id for certification verification (confined space entry, vactor operation), training compliance, and performance m. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Reference to the specific pipe segment where the blockage occurred. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Blockage investigations may trigger water quality sampling when cross-connection, contamination, or illicit discharge is suspected during root cause analysis. Links blockage event to investigative sam. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to respond to and clear the blockage. Ref: EPA SDWA.',
    `basin_code` STRING COMMENT 'Code identifying the wastewater collection basin or drainage area where the blockage occurred. Ref: EPA SDWA.',
    `blockage_cause` STRING COMMENT 'Primary cause of the blockage event. FOG = Fats, Oils, and Grease; I&I = Inflow and Infiltration. [ENUM-REF-CANDIDATE: FOG|roots|debris|structural_collapse|grease_buildup|foreign_object|sediment|pipe_defect|I&I|unknown — 10 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `blockage_number` STRING COMMENT 'Externally-known unique identifier or ticket number assigned to this blockage event for tracking and reporting purposes. Ref: EPA SDWA.',
    `blockage_severity` STRING COMMENT 'Severity classification of the blockage based on impact to service and risk of overflow. Ref: EPA SDWA.. Valid values are `minor|moderate|major|critical`',
    `blockage_type` STRING COMMENT 'Indicates whether the blockage was partial (reduced flow) or complete (no flow). Ref: EPA SDWA.. Valid values are `partial|complete`',
    `clearance_method` STRING COMMENT 'Method or technique used by the crew to clear the blockage and restore flow. Ref: EPA SDWA.. Valid values are `hydro_jetting|rodding|excavation|chemical_treatment|vacuum_truck|manual_removal`',
    `clearance_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from crew arrival to successful clearance of the blockage. Ref: EPA SDWA.',
    `clearance_timestamp` TIMESTAMP COMMENT 'Date and time when the blockage was successfully cleared and flow was restored. Ref: EPA SDWA.',
    `cleared_timestamp` TIMESTAMP COMMENT 'The cleared timestamp associated with each collection system blockage record in the wastewater domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blockage record was first created in the system. Ref: EPA SDWA.',
    `customer_complaint_count` STRING COMMENT 'Number of customer complaints received related to this blockage event. Ref: EPA SDWA.',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether the blockage event impacted customer service (e.g., backup into property, service disruption). Ref: EPA SDWA.',
    `discovery_timestamp` TIMESTAMP COMMENT 'The discovery timestamp associated with each collection system blockage record in the wastewater domain.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area where the blockage occurred for performance tracking and analysis. Ref: EPA SDWA.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the blockage event resulted in environmental impact requiring regulatory notification. Ref: EPA SDWA.',
    `equipment_used` STRING COMMENT 'Description of equipment or tools used to clear the blockage (e.g., hydro-jetter model, vacuum truck). Ref: EPA SDWA.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in US dollars to respond to and clear the blockage including labor, equipment, and materials. Ref: EPA SDWA.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the blockage or stoppage event was first detected or reported. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for collection_system_blockage. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the blockage location in decimal degrees. Ref: EPA SDWA.',
    `location_latitude` DECIMAL(18,2) COMMENT 'location latitude. Ref: EPA SDWA.',
    `location_longitude` DECIMAL(18,2) COMMENT 'location longitude. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the blockage location in decimal degrees. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional free-text notes or observations about the blockage event, clearance activities, or site conditions. Ref: EPA SDWA.',
    `preventive_maintenance_recommendation` STRING COMMENT 'Recommended preventive maintenance actions to reduce future blockage risk at this location (e.g., scheduled cleaning, root treatment, pipe rehabilitation). Ref: EPA SDWA.',
    `previous_blockage_count` STRING COMMENT 'Number of previous blockage events recorded at this location within the past 12 months. Ref: EPA SDWA.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Measured rainfall amount in inches during the 24-hour period preceding the blockage event. Ref: EPA SDWA.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory notification to EPA or state agency was required for this blockage event. Ref: EPA SDWA.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory notification was submitted to the appropriate agency. Ref: EPA SDWA.',
    `repeat_blockage_flag` BOOLEAN COMMENT 'Indicates whether this location has experienced previous blockage events within a defined time period. Ref: EPA SDWA.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the blockage was reported to the utility by customer, field crew, or monitoring system. Ref: EPA SDWA.',
    `response_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from when the blockage was reported to when the crew arrived on site. Ref: EPA SDWA.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the response crew arrived on site to address the blockage. Ref: EPA SDWA.',
    `resulted_in_sso_flag` BOOLEAN COMMENT 'The resulted in sso flag value recorded for each collection system blockage in the wastewater domain.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis was completed for this blockage event. Ref: EPA SDWA.',
    `sso_location_description` STRING COMMENT 'Description of the location where the SSO occurred (e.g., street, property, receiving water body). Ref: EPA SDWA.',
    `sso_occurred_flag` BOOLEAN COMMENT 'Indicates whether a Sanitary Sewer Overflow occurred as a result of this blockage event. Ref: EPA SDWA.',
    `sso_resulted_flag` BOOLEAN COMMENT 'sso resulted flag. Ref: EPA SDWA.',
    `sso_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of wastewater overflow in gallons if an SSO occurred due to the blockage. Ref: EPA SDWA.',
    `street_address` STRING COMMENT 'Street address or nearest address to the blockage location for field crew navigation and reporting. Ref: EPA SDWA.',
    `total_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from blockage detection to clearance completion. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this blockage record was last modified in the system. Ref: EPA SDWA.',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of the blockage event (e.g., heavy rain, dry, snow) that may have contributed to the event. Ref: EPA SDWA.',
    CONSTRAINT pk_collection_system_blockage PRIMARY KEY(`collection_system_blockage_id`)
) COMMENT 'Transactional record of each sewer blockage or stoppage event in the collection system including event date/time, location (pipe segment, manhole), blockage cause (FOG, roots, debris, structural collapse, I&I), response crew, clearance method (hydro-jetting, rodding, excavation), time to clear, downstream SSO occurrence flag, and preventive maintenance recommendation. Supports O&M performance tracking and SSO root cause analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` (
    `sewer_service_connection_id` BIGINT COMMENT 'Unique identifier for the sewer service connection (lateral) record. Primary key for this entity. Ref: EPA SDWA.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with this sewer service connection. Links the physical infrastructure to the customer billing relationship. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service connections are installed/replaced via CIP projects (new development, rehabilitation). Link enables developer contribution tracking, capital cost allocation, system capacity planning, and conn. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each sewer service connection record in the wastewater domain.',
    `manhole_id` BIGINT COMMENT 'Reference to the nearest manhole or connection point where the service lateral ties into the public sewer system, if applicable. Ref: EPA SDWA.',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Water utilities coordinate water and sewer service at customer premises. Service activation/deactivation, combined billing, and account management require linking the water meter to the corresponding. Ref: EPA SDWA.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Sewer laterals physically connect to properties where water service points exist. Combined water/wastewater utilities require this link for coordinated service delivery, unified billing, infrastructur. Ref: EPA SDWA.',
    `premise_id` BIGINT COMMENT 'Reference to the premise (property or building) served by this sewer lateral connection. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'registry id. Ref: EPA SDWA.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Utilities manage combined water/sewer service at same premise for coordinated billing, joint service orders, coordinated shutoffs, infrastructure replacement planning, and regulatory lead service line. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Reference to the public sewer main segment to which this service lateral connects. Establishes the topology link between customer service and the collection network. Ref: EPA SDWA.',
    `abandonment_date` DATE COMMENT 'Date when the service connection was permanently abandoned and removed from active service. Abandoned connections are typically capped or filled. Ref: EPA SDWA.',
    `activation_date` DATE COMMENT 'Date when the service connection was activated and began receiving wastewater service. May differ from installation date if there was a delay between construction and service commencement. Ref: EPA SDWA.',
    `backflow_prevention_flag` BOOLEAN COMMENT 'backflow prevention flag. Ref: EPA SDWA.',
    `backwater_valve_installed_flag` BOOLEAN COMMENT 'Indicates whether a backwater valve (backflow preventer) is installed on the service lateral to prevent sewage backup into the premise during system surcharge events. Ref: EPA SDWA.',
    `cleanout_available_flag` BOOLEAN COMMENT 'Indicates whether a cleanout access point is available on the service lateral for maintenance and inspection purposes. Cleanouts facilitate camera inspection and clearing blockages. Ref: EPA SDWA.',
    `condition_rating` STRING COMMENT 'Current physical condition assessment of the service lateral based on inspection findings, age, material, and maintenance history. Ratings guide rehabilitation and replacement prioritization. Ref: EPA SDWA.. Valid values are `excellent|good|fair|poor|critical|unknown`',
    `connection_date` TIMESTAMP COMMENT 'The connection date associated with each sewer service connection record in the wastewater domain.',
    `connection_number` STRING COMMENT 'connection number. Ref: EPA SDWA.',
    `connection_status` STRING COMMENT 'The connection status value recorded for each sewer service connection in the wastewater domain.',
    `connection_type` STRING COMMENT 'Type of sewer service connection based on conveyance method. Gravity connections rely on slope; grinder pump and ejector pump connections serve properties below the sewer main elevation; low-pressure and vacuum systems are specialized collection methods. Ref: EPA SDWA.. Valid values are `gravity|grinder_pump|ejector_pump|low_pressure|vacuum`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service connection record was first created in the system. Used for data lineage, audit trails, and compliance reporting. Ref: EPA SDWA.',
    `criticality_rating` STRING COMMENT 'Business criticality or risk rating of this service connection based on factors such as customer type, service area sensitivity, backup risk, and consequence of failure. Guides prioritization of maintenance and capital investment. Ref: EPA SDWA.. Valid values are `critical|high|medium|low`',
    `deactivation_date` DATE COMMENT 'Date when the service connection was deactivated or taken out of service, either temporarily or permanently. Ref: EPA SDWA.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'diameter inches. Ref: EPA SDWA.',
    `fog_risk_flag` BOOLEAN COMMENT 'Indicates whether this service connection serves a food service establishment or other FOG-generating source, requiring special monitoring and maintenance under the utility FOG program. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for sewer_service_connection. Ref: EPA SDWA.',
    `gis_feature_reference` BOOLEAN COMMENT 'Unique identifier for this service connection in the utility GIS system. Enables integration with spatial analysis, network modeling, and asset mapping applications. Ref: EPA SDWA.',
    `grinder_pump_installation_date` DATE COMMENT 'Date when the grinder pump was installed at this service connection. Used for warranty tracking and lifecycle management. Ref: EPA SDWA.',
    `grinder_pump_manufacturer` STRING COMMENT 'Manufacturer name of the grinder pump installed at this service connection, if applicable. Ref: EPA SDWA.',
    `grinder_pump_model` STRING COMMENT 'Model number or designation of the grinder pump installed at this service connection, if applicable. Ref: EPA SDWA.',
    `grinder_pump_serial_number` STRING COMMENT 'Manufacturer serial number of the grinder pump installed at this service connection, if applicable. Used for warranty tracking, maintenance scheduling, and parts ordering. Ref: EPA SDWA.',
    `industrial_user_flag` BOOLEAN COMMENT 'Indicates whether this service connection serves an industrial user subject to pretreatment requirements and Industrial User Permit (IUP) regulations under the Clean Water Act. Ref: EPA SDWA.',
    `installation_date` DATE COMMENT 'Date when the sewer service connection was originally installed and placed into service. Used for age-based asset management, depreciation, and replacement planning. Ref: EPA SDWA.',
    `installation_year` STRING COMMENT 'Year when the sewer service connection was installed. Provided separately for cases where only the year is known, supporting age-based analysis and cohort studies. Ref: EPA SDWA.',
    `iup_permit_number` STRING COMMENT 'Permit number for the Industrial User Permit associated with this service connection, if the connection serves a significant industrial user subject to pretreatment requirements. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or condition assessment of the service lateral. Inspections may include camera surveys, smoke testing, or visual examination. Ref: EPA SDWA.',
    `lateral_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the service lateral pipe measured in inches. Typical residential laterals range from 4 to 6 inches; commercial and industrial connections may be larger. Ref: EPA SDWA.',
    `lateral_length_feet` DECIMAL(18,2) COMMENT 'Total length of the service lateral pipe from the premise connection point to the public sewer main, measured in feet. Used for capacity analysis, maintenance planning, and replacement cost estimation. Ref: EPA SDWA.',
    `lateral_material` STRING COMMENT 'lateral material. Ref: EPA SDWA.',
    `lateral_ownership` STRING COMMENT 'lateral ownership. Ref: EPA SDWA.',
    `lateral_pipe_material` STRING COMMENT 'Material composition of the service lateral pipe. Common materials include PVC (polyvinyl chloride), vitrified clay, cast iron, ductile iron, concrete, Orangeburg (bituminized fiber), ABS (acrylonitrile butadiene styrene), and HDPE (high-density polyethylene). Material affects durability, corrosion resistance, and maintenance needs. [ENUM-REF-CANDIDATE: pvc|vitrified_clay|cast_iron|ductile_iron|concrete|orangeburg|abs|hdpe — 8 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service connection point or premise location in decimal degrees. Used for GIS mapping and spatial analysis. Ref: EPA SDWA.',
    `length_feet` DECIMAL(18,2) COMMENT 'length feet. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service connection point or premise location in decimal degrees. Used for GIS mapping and spatial analysis. Ref: EPA SDWA.',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for maintenance and repair of the service lateral. May differ from ownership; for example, a private lateral may have utility maintenance responsibility under certain programs. Ref: EPA SDWA.. Valid values are `utility|customer|shared|unknown`',
    `material` STRING COMMENT 'material. Ref: EPA SDWA.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next inspection or condition assessment of the service lateral, based on regulatory requirements, risk rating, or preventive maintenance schedules. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special conditions, maintenance history notes, or other relevant information about the service connection. Ref: EPA SDWA.',
    `ownership_type` STRING COMMENT 'Ownership responsibility for the service lateral. Utility-owned laterals are maintained by the wastewater utility; private laterals are the property owners responsibility; shared ownership may apply to portions of the lateral; municipal ownership applies to public properties. Ref: EPA SDWA.. Valid values are `utility|private|shared|municipal|unknown`',
    `parcel_identifier` STRING COMMENT 'Tax parcel number or assessor parcel number (APN) for the property served by this connection. Used for cross-referencing with municipal tax and GIS records. Ref: EPA SDWA.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the service lateral in US dollars, used for capital planning, insurance valuation, and asset management financial analysis. Ref: EPA SDWA.',
    `service_address_line1` STRING COMMENT 'Primary street address line of the premise served by this sewer connection. Organizational contact data classified as confidential. Ref: EPA SDWA.',
    `service_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the premise served by this sewer connection. Organizational contact data classified as confidential. Ref: EPA SDWA.',
    `service_city` STRING COMMENT 'City or municipality where the served premise is located. Organizational contact data classified as confidential. Ref: EPA SDWA.',
    `service_connection_number` STRING COMMENT 'Business identifier for the sewer service connection, typically used in field operations, customer service, and billing. May follow utility-specific numbering conventions. Ref: EPA SDWA.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code for the service address. Organizational contact data classified as confidential. Ref: EPA SDWA.',
    `service_state_province` STRING COMMENT 'State or province code for the service address location. Ref: EPA SDWA.',
    `service_status` STRING COMMENT 'Current operational status of the sewer service connection. Active connections are in use; inactive connections are temporarily out of service; abandoned connections are permanently closed; capped connections are physically sealed; pending activation connections are installed but not yet in service. Ref: EPA SDWA.. Valid values are `active|inactive|abandoned|capped|pending_activation`',
    `sso_history_flag` BOOLEAN COMMENT 'Indicates whether this service connection has a documented history of sanitary sewer overflows or backups. Used for risk assessment and targeted maintenance programs. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service connection record was last modified. Used for change tracking, data quality monitoring, and audit trails. Ref: EPA SDWA.',
    CONSTRAINT pk_sewer_service_connection PRIMARY KEY(`sewer_service_connection_id`)
) COMMENT 'Master record for each individual sewer service connection (lateral) linking a customer premise to the public sewer main including connection address, parcel identifier, lateral pipe material, diameter, length, connection type (gravity, grinder pump), installation date, condition, and service status (active, inactive, abandoned). Bridges the wastewater network topology to customer service accounts.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` (
    `dmr_submission_id` BIGINT COMMENT 'Unique identifier for the DMR submission record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key reference to the NPDES permit under which this DMR is submitted. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DMR preparation costs (laboratory analysis, staff time, consultant fees, NetDMR subscription) are charged to cost centers for NPDES compliance budget tracking and regulatory program cost analysis. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: NPDES DMR submissions require certified operator signature with operator license verification. FK enables validation of signatory_certification_date against operator_license expiration, audit trail fo. Ref: EPA SDWA.',
    `dmr_submitted_by_employee_id` BIGINT COMMENT 'submitted by employee id. Ref: EPA SDWA.',
    `primary_original_submission_dmr_submission_id` BIGINT COMMENT 'If this is an amended or corrected DMR, this field references the dmr_submission_id of the original submission being replaced. Ref: EPA SDWA.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: DMR submissions are specific instances of regulatory submissions. Linking enables unified submission tracking, agency correspondence management, acknowledgment tracking, and deficiency response workfl. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Foreign key reference to the wastewater treatment plant facility submitting this DMR. Ref: EPA SDWA.',
    `acceptance_date` DATE COMMENT 'The date on which the regulatory authority formally accepted this DMR submission as complete and compliant with reporting requirements. Ref: EPA SDWA.',
    `attachment_count` STRING COMMENT 'The number of supporting documents or attachments included with the DMR submission. Ref: EPA SDWA.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'The average daily flow rate in million gallons per day for the reporting period, calculated as the total flow divided by the number of days in the period. Ref: EPA SDWA.',
    `bypass_event_flag` BOOLEAN COMMENT 'Indicates whether an intentional diversion of waste streams from any portion of the treatment facility occurred during this reporting period, as defined in 40 CFR 122.41(m). Ref: EPA SDWA.',
    `certification_statement` STRING COMMENT 'The regulatory-required certification statement signed by the authorized signatory attesting to the accuracy of the DMR data. Ref: EPA SDWA.',
    `certified_by_name` STRING COMMENT 'certified by name. Ref: EPA SDWA.',
    `comments` STRING COMMENT 'Free-text field for additional comments, explanations, or context provided by the facility regarding this DMR submission, such as explanations for exceedances or operational issues. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the reporting period based on all monitored parameters and permit conditions. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|conditional_compliant`',
    `correction_due_date` DATE COMMENT 'The deadline by which deficiencies must be corrected and a revised DMR must be resubmitted to the regulatory authority. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this DMR submission record was first created in the system. Ref: EPA SDWA.',
    `cso_event_flag` BOOLEAN COMMENT 'Indicates whether one or more Combined Sewer Overflow events occurred during this reporting period, applicable to facilities with combined sewer systems. Ref: EPA SDWA.',
    `days_late` STRING COMMENT 'The number of calendar days by which this DMR submission exceeded the permit-required deadline. Zero or null indicates on-time submission. Ref: EPA SDWA.',
    `deficiency_description` STRING COMMENT 'A detailed description of the deficiencies identified by the regulatory authority, including specific parameters, data quality issues, or missing information that must be addressed. Ref: EPA SDWA.',
    `deficiency_notice_date` DATE COMMENT 'The date on which the regulatory authority issued a deficiency notice for this DMR submission, indicating missing or incorrect data that must be corrected. Ref: EPA SDWA.',
    `dmr_number` STRING COMMENT 'dmr number. Ref: EPA SDWA.',
    `dmr_submission_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this DMR submission, often assigned by the regulatory authority or NetDMR system. Ref: EPA SDWA.',
    `due_date` DATE COMMENT 'The regulatory deadline by which the DMR must be submitted, typically the 28th day of the month following the reporting period. Ref: EPA SDWA.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether this DMR submission triggered or is associated with a regulatory enforcement action due to violations, late submission, or data quality issues. Ref: EPA SDWA.',
    `facility_name` STRING COMMENT 'The official name of the wastewater treatment facility submitting the DMR. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for dmr_submission. Ref: EPA SDWA.',
    `late_submission_flag` BOOLEAN COMMENT 'Indicates whether this DMR was submitted after the permit-required deadline, which may result in enforcement action or penalties. Ref: EPA SDWA.',
    `maximum_daily_flow_mgd` DECIMAL(18,2) COMMENT 'The highest single-day flow rate in million gallons per day recorded during the reporting period. Ref: EPA SDWA.',
    `netdmr_confirmation_number` STRING COMMENT 'netdmr confirmation number. Ref: EPA SDWA.',
    `netdmr_transaction_code` STRING COMMENT 'The unique transaction identifier assigned by the EPA NetDMR system upon successful electronic submission. Used for tracking and audit purposes. Ref: EPA SDWA.',
    `no_discharge_flag` BOOLEAN COMMENT 'Indicates whether the facility had no discharge during this reporting period. If true, monitoring data may not be required depending on permit conditions. Ref: EPA SDWA.',
    `nodi_flag` BOOLEAN COMMENT 'Indicates whether the facility had no discharge during the reporting period. Ref: EPA SDWA.',
    `nodi_submitted_flag` BOOLEAN COMMENT 'Indicates whether a Notice of Discharge Intent (NODI) or No Discharge (NODI) certification was submitted for this reporting period, typically used when no discharge occurred. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `outfall_count` STRING COMMENT 'The number of discharge outfalls included in this DMR submission. Ref: EPA SDWA.',
    `outfall_identifier` STRING COMMENT 'The unique identifier for the discharge outfall as specified in the NPDES permit (e.g., Outfall 001, Outfall 002). Each outfall may require separate DMR submissions. Ref: EPA SDWA.',
    `parameter_count` STRING COMMENT 'The total number of water quality parameters reported in this DMR submission. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'The official NPDES permit number under which discharge monitoring is conducted and reported. Ref: EPA SDWA.',
    `prepared_by_email` STRING COMMENT 'The email address of the staff member or consultant who prepared this DMR submission. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `prepared_by_name` STRING COMMENT 'The name of the staff member or consultant who prepared this DMR submission, distinct from the authorized signatory. Ref: EPA SDWA.',
    `preparer_email` STRING COMMENT 'The email address of the individual who prepared the DMR submission. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'The name of the individual who prepared the DMR submission. Ref: EPA SDWA.',
    `preparer_phone` STRING COMMENT 'The contact phone number of the individual who prepared the DMR submission. Ref: EPA SDWA.',
    `regulatory_agency` STRING COMMENT 'The name of the regulatory authority receiving the DMR submission (EPA or state primacy agency). Ref: EPA SDWA.',
    `regulatory_agency_code` STRING COMMENT 'The standardized code identifying the regulatory authority (e.g., EPA Region number or state agency code). Ref: EPA SDWA.',
    `regulatory_authority` STRING COMMENT 'The name of the regulatory agency to which this DMR was submitted (e.g., EPA Region 5, State Department of Environmental Quality). Identifies whether the state has primacy or EPA is the permitting authority. Ref: EPA SDWA.',
    `regulatory_contact_email` STRING COMMENT 'The email address of the regulatory authority contact or inspector responsible for reviewing this DMR submission. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `rejection_date` DATE COMMENT 'The date on which the regulatory authority rejected the DMR submission due to incompleteness or errors. Ref: EPA SDWA.',
    `rejection_reason` STRING COMMENT 'The explanation provided by the regulatory authority for rejecting the DMR submission. Ref: EPA SDWA.',
    `reporting_period` STRING COMMENT 'reporting period. Ref: EPA SDWA.',
    `reporting_period_end` DATE COMMENT 'The reporting period end value recorded for each dmr submission in the wastewater domain.',
    `reporting_period_end_date` DATE COMMENT 'The last day of the monitoring period covered by this DMR submission, typically the last day of the calendar month. Ref: EPA SDWA.',
    `reporting_period_start` DATE COMMENT 'The reporting period start value recorded for each dmr submission in the wastewater domain.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the monitoring period covered by this DMR submission, typically the first day of the calendar month. Ref: EPA SDWA.',
    `resubmission_flag` BOOLEAN COMMENT 'Indicates whether this DMR is a resubmission of a previously rejected or corrected report. Ref: EPA SDWA.',
    `signatory_certification_date` DATE COMMENT 'The date on which the authorized signatory certified the accuracy and completeness of the DMR data under penalty of law. Ref: EPA SDWA.',
    `signatory_date` DATE COMMENT 'The date on which the authorized signatory certified the DMR submission. Ref: EPA SDWA.',
    `signatory_title` STRING COMMENT 'The official title or position of the authorized signatory (e.g., Plant Manager, Director of Public Works, Chief Operator). Ref: EPA SDWA.',
    `sso_event_flag` BOOLEAN COMMENT 'Indicates whether one or more Sanitary Sewer Overflow events occurred during this reporting period that may have impacted treatment plant performance or discharge quality. Ref: EPA SDWA.',
    `submission_date` DATE COMMENT 'The date on which this DMR was submitted to the regulatory authority. Must be within the permit-specified deadline (typically by the 28th of the following month). Ref: EPA SDWA.',
    `submission_method` STRING COMMENT 'The method by which this DMR was submitted to the regulatory authority. NetDMR is the EPAs electronic reporting system and is required in most states. Ref: EPA SDWA.. Valid values are `NetDMR|paper|email|portal|hand_delivery`',
    `submission_number` STRING COMMENT 'Business identifier for the DMR submission, typically assigned by the regulatory agency or internal tracking system. Ref: EPA SDWA.',
    `submission_status` STRING COMMENT 'The current lifecycle status of this DMR submission in the regulatory review process. Ref: EPA SDWA.. Valid values are `draft|submitted|accepted|deficient|rejected|resubmitted`',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when this DMR was submitted to the regulatory authority, including time zone information. Ref: EPA SDWA.',
    `submission_type` STRING COMMENT 'Indicates whether this is an original DMR submission or a corrected/amended version of a previously submitted report. Ref: EPA SDWA.. Valid values are `original|amended|corrected|resubmission`',
    `total_flow_volume_mg` DECIMAL(18,2) COMMENT 'The total volume of wastewater discharged during the reporting period, measured in million gallons. Ref: EPA SDWA.',
    `total_parameter_exceedances` STRING COMMENT 'The total count of permit limit exceedances reported in this DMR submission across all monitored parameters. Zero indicates full compliance for the reporting period. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this DMR submission record was last modified in the system. Ref: EPA SDWA.',
    `upset_event_flag` BOOLEAN COMMENT 'Indicates whether an exceptional incident occurred during this reporting period that caused temporary noncompliance with permit effluent limitations, as defined in 40 CFR 122.41(n). Ref: EPA SDWA.',
    `violation_count` STRING COMMENT 'The number of permit limit violations reported in this DMR submission. Ref: EPA SDWA.',
    `violation_flag` BOOLEAN COMMENT 'The violation flag value recorded for each dmr submission in the wastewater domain.',
    CONSTRAINT pk_dmr_submission PRIMARY KEY(`dmr_submission_id`)
) COMMENT 'Master reference table for dmr_submission. Referenced by: compliance.dmr_result.dmr_submission_id';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` (
    `facility_grant_allocation_id` BIGINT COMMENT 'Unique identifier for this facility-grant allocation record. Primary key. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'cost center id. Ref: EPA SDWA.',
    `grant_allocation_id` BIGINT COMMENT 'grant allocation id. Ref: EPA SDWA.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant award providing funding to the facility. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to the wastewater treatment plant facility receiving grant funding. Ref: EPA SDWA.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'allocated amount. Ref: EPA SDWA.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds allocated to this specific facility from the total grant award. Sum of all facility allocations should not exceed the grant award_amount. Ref: EPA SDWA.',
    `allocation_amount_usd` DECIMAL(18,2) COMMENT 'The allocation amount usd value recorded for each facility grant allocation in the wastewater domain.',
    `allocation_date` TIMESTAMP COMMENT 'The allocation date associated with each facility grant allocation record in the wastewater domain.',
    `allocation_end_date` DATE COMMENT 'Date by which all allocated grant funds for this facility must be expended or obligated. May differ from the grant period_of_performance_end_date if allocations are phased. Ref: EPA SDWA.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'allocation percentage. Ref: EPA SDWA.',
    `allocation_start_date` DATE COMMENT 'Date on which grant funding became available for expenditure on this facility. May differ from the grant period_of_performance_start_date if allocations are phased. Ref: EPA SDWA.',
    `allocation_status` STRING COMMENT 'The allocation status value recorded for each facility grant allocation in the wastewater domain.',
    `compliance_status` STRING COMMENT 'Current compliance status of this facility-grant allocation with grantor requirements and special conditions. Values: compliant, non_compliant, under_review, corrective_action, closed. Ref: EPA SDWA.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this facility-grant allocation record was created in the system. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each facility grant allocation record in the wastewater domain.',
    `eligible_cost_categories` DECIMAL(18,2) COMMENT 'Specific cost categories that are eligible for reimbursement from this grant allocation for this facility (e.g., Equipment, Labor, Materials, Engineering). May be a subset of the grants overall allowable_cost_categories. Ref: EPA SDWA.',
    `expenditure_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of grant funds expended on this facility as of the last reporting period. Used for drawdown requests and federal financial reporting. Ref: EPA SDWA.',
    `facility_project_manager_name` STRING COMMENT 'Name of the utility employee responsible for managing the grant-funded project at this specific facility. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for facility_grant_allocation. Ref: EPA SDWA.',
    `last_drawdown_date` DATE COMMENT 'Date of the most recent drawdown request submitted for this facility-grant allocation. Ref: EPA SDWA.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this facility-grant allocation record was last updated. Ref: EPA SDWA.',
    `matching_funds_contributed` DECIMAL(18,2) COMMENT 'Dollar amount of local matching funds contributed by the utility for this facility-grant allocation, tracked separately to demonstrate compliance with matching requirements. Ref: EPA SDWA.',
    `next_reporting_due_date` DATE COMMENT 'Date by which the next progress or financial report is due to the grantor for this facility-grant allocation. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes documenting special conditions, variances, or issues specific to this facility-grant allocation. Ref: EPA SDWA.',
    `project_phase` STRING COMMENT 'Current phase of the grant-funded project at this facility. Values: planning, design, construction, commissioning, closeout. Ref: EPA SDWA.',
    `reporting_period` STRING COMMENT 'Fiscal period or quarter for which expenditures and compliance are being tracked and reported to the grantor (e.g., Q1 FY2024, January 2024). Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_facility_grant_allocation PRIMARY KEY(`facility_grant_allocation_id`)
) COMMENT 'This association product represents the allocation of grant funding to specific wastewater treatment plant facilities. It captures the financial relationship between a grant award and the facilities it funds, tracking allocation amounts, expenditures, compliance status, and reporting periods for each facility-grant combination. Each record links one WWTP to one grant with attributes that exist only in the context of this funding relationship, supporting federal grant reporting (SF-425, FFR), GASB compliance, and single audit requirements.. Existence Justification: In water utility operations, a single wastewater treatment plant can receive funding from multiple concurrent grant programs (EPA Clean Water SRF for nutrient removal upgrades, USDA Rural Development for energy efficiency, state grants for biosolids management), and each grant award typically funds capital improvements or compliance projects across multiple facilities within the utilitys service area. The utility must track allocation amounts, expenditures, compliance status, and reporting periods for each facility-grant pair to support federal financial reporting (SF-425, Federal Financial Report), single audit SEFA schedules, and grantor-specific compliance requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` (
    `sewer_repair_id` BIGINT COMMENT 'Unique identifier for this sewer segment repair record. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'cip project id. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'cost center id. Ref: EPA SDWA.',
    `crew_id` BIGINT COMMENT 'crew id. Ref: EPA SDWA.',
    `manhole_id` BIGINT COMMENT 'manhole id. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to the sewer network segment that was repaired or maintained in this work order. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to the work order that performed maintenance on this sewer segment. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `defect_codes_addressed` STRING COMMENT 'Comma-separated list of NASSCO PACP defect codes that this repair addressed for this segment (e.g., CL-Crack Longitudinal, DL-Deformed, RB-Roots at Joint). Links repair activity to specific observed defects from CCTV inspection. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for sewer_repair. Ref: EPA SDWA.',
    `length_repaired_feet` DECIMAL(18,2) COMMENT 'length repaired feet. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `post_repair_condition_grade` STRING COMMENT 'The condition assessment grade of the sewer segment after this repair work was completed. Captured from post-repair CCTV inspection. Used to validate repair effectiveness and reset asset condition for predictive maintenance models. Ref: EPA SDWA.',
    `pre_repair_condition_grade` STRING COMMENT 'The condition assessment grade of the sewer segment immediately before this repair work was performed. Captured from CCTV inspection. Used to track condition improvement and validate repair effectiveness. Follows NASSCO PACP grading (Grade 1=Excellent to Grade 5=Imminent Failure). Ref: EPA SDWA.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this repair was performed to address a regulatory compliance issue (e.g., consent decree requirement, EPA administrative order, state environmental violation). Used for regulatory reporting and consent decree tracking. Ref: EPA SDWA.',
    `repair_completion_date` DATE COMMENT 'The date when repair work on this specific sewer segment was completed. May differ from the overall work order completion date if the work order addressed multiple segments sequentially. Used for segment-specific maintenance history and warranty tracking. Ref: EPA SDWA.',
    `repair_cost_allocation_percent` DECIMAL(18,2) COMMENT 'The percentage of the total work order cost allocated to this specific sewer segment. Used when a single work order addresses multiple segments (e.g., CIPP lining across 5 pipe runs). Enables accurate per-segment cost tracking for asset valuation and rate case justification. Sum across all segments for a work order should equal 100%. Ref: EPA SDWA.',
    `repair_cost_usd` DECIMAL(18,2) COMMENT 'The repair cost usd value recorded for each sewer repair in the wastewater domain.',
    `repair_date` TIMESTAMP COMMENT 'repair date. Ref: EPA SDWA.',
    `repair_end_station` DECIMAL(18,2) COMMENT 'The ending station or offset in feet from the upstream end of the sewer segment where repair work concluded. Used with repair_start_station to define the precise spatial extent of the repair within the segment. Ref: EPA SDWA.',
    `repair_method` STRING COMMENT 'The specific maintenance or repair technique applied to this sewer segment in this work order. Examples: CIPP Lining, Point Repair, Pipe Bursting, Open Cut Replacement, Grouting, Root Removal, Cleaning, CCTV Inspection. Essential for tracking rehabilitation methods and effectiveness analysis. Ref: EPA SDWA.',
    `repair_number` STRING COMMENT 'repair number. Ref: EPA SDWA.',
    `repair_segment_length_feet` DECIMAL(18,2) COMMENT 'The length in feet of the sewer segment portion addressed by this work order. May be less than the full segment length if only a section was repaired. Critical for cost-per-foot analysis and partial segment rehabilitation tracking. Ref: EPA SDWA.',
    `repair_start_date` TIMESTAMP COMMENT 'The repair start date associated with each sewer repair record in the wastewater domain.',
    `repair_start_station` DECIMAL(18,2) COMMENT 'The starting station or offset in feet from the upstream end of the sewer segment where repair work began. Used for partial segment repairs to precisely locate the repair extent within the segment. Supports spatial analysis and future work planning. Ref: EPA SDWA.',
    `repair_status` STRING COMMENT 'The repair status value recorded for each sewer repair in the wastewater domain.',
    `repair_type` STRING COMMENT 'repair type. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `warranty_expiration_date` DATE COMMENT 'The date when the contractor warranty for this specific repair expires. Typically 1-5 years from repair completion depending on repair method and contract terms. Critical for warranty claim management and contractor performance tracking. Ref: EPA SDWA.',
    CONSTRAINT pk_sewer_repair PRIMARY KEY(`sewer_repair_id`)
) COMMENT 'This association product represents the maintenance work performed on specific sewer network segments. It captures the operational relationship between work orders and the sewer segments they address, including repair scope, method, cost allocation, and spatial extent. Each record links one work order to one sewer segment with attributes that exist only in the context of this specific repair or maintenance activity. Essential for tracking maintenance history per segment, cost allocation across multi-segment work orders, and regulatory compliance reporting.. Existence Justification: In water utility operations, a single work order routinely addresses multiple sewer segments (e.g., CIPP lining project across 5 contiguous pipe runs, or a cleaning route covering 20 segments), and each sewer segment receives multiple work orders over its lifecycle (inspections, cleanings, point repairs, rehabilitation, emergency repairs). The relationship is actively managed by maintenance planners who allocate costs, track repair extent, and maintain segment-specific maintenance history for regulatory compliance and asset management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` (
    `facility_vendor_contract_id` BIGINT COMMENT 'Unique identifier for this facility-vendor contract relationship. Primary key. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'cost center id. Ref: EPA SDWA.',
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract referenced by each facility vendor contract record in the wastewater domain.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing goods or services under this contract. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to the wastewater treatment plant facility that is party to this vendor contract. Ref: EPA SDWA.',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Estimated or committed annual spend for this vendor at this specific facility under this contract. Ref: EPA SDWA.',
    `compliance_requirements` STRING COMMENT 'Facility-specific regulatory, safety, or operational compliance requirements the vendor must meet when providing services to this WWTP (e.g., NPDES permit conditions, safety certifications, background checks). Ref: EPA SDWA.',
    `contract_end_date` TIMESTAMP COMMENT 'The contract end date associated with each facility vendor contract record in the wastewater domain.',
    `contract_number` STRING COMMENT 'Business identifier for the contract or purchase agreement governing this facility-vendor relationship. Referenced in procurement systems and invoices. Ref: EPA SDWA.',
    `contract_start_date` TIMESTAMP COMMENT 'The contract start date associated with each facility vendor contract record in the wastewater domain.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this facility-vendor contract indicating whether services are actively being provided. Ref: EPA SDWA.',
    `contract_type` STRING COMMENT 'contract type. Ref: EPA SDWA.',
    `contract_value_usd` DECIMAL(18,2) COMMENT 'The contract value usd value recorded for each facility vendor contract in the wastewater domain.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this facility-vendor contract record was created in the system. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Date on which this contract or service agreement became active and enforceable for this facility-vendor pairing. Ref: EPA SDWA.',
    `emergency_contact_available` BOOLEAN COMMENT 'Indicates whether this vendor provides 24/7 emergency response services to this facility under this contract. Ref: EPA SDWA.',
    `end_date` DATE COMMENT 'end date. Ref: EPA SDWA.',
    `expiration_date` DATE COMMENT 'Date on which this contract expires or requires renewal for continued vendor services to this facility. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for facility_vendor_contract. Ref: EPA SDWA.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance evaluation conducted for this vendor at this facility. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `performance_rating` STRING COMMENT 'Facility-specific performance assessment of the vendor under this contract, reflecting delivery timeliness, quality, compliance, and responsiveness for this particular WWTP. Ref: EPA SDWA.',
    `primary_contact_name` STRING COMMENT 'Name of the vendor representative assigned to service this specific facility under this contract. Ref: EPA SDWA.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the vendor contact assigned to this facility. Ref: EPA SDWA.',
    `service_description` STRING COMMENT 'service description. Ref: EPA SDWA.',
    `service_type` STRING COMMENT 'Classification of the primary goods or services provided by the vendor to this specific facility under this contract. Ref: EPA SDWA.',
    `start_date` DATE COMMENT 'start date. Ref: EPA SDWA.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this facility-vendor contract record was last modified. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_facility_vendor_contract PRIMARY KEY(`facility_vendor_contract_id`)
) COMMENT 'This association product represents the contractual relationship between a wastewater treatment plant facility and a vendor supplying goods or services. It captures procurement contracts, service agreements, and supply arrangements specific to each WWTP-vendor pairing. Each record links one WWTP to one vendor with contract-specific terms, service scope, performance metrics, and compliance requirements that exist only in the context of this relationship.. Existence Justification: In water utility operations, wastewater treatment plants maintain simultaneous contractual relationships with multiple vendors for different services (chemical suppliers for chlorine and polymers, equipment maintenance contractors, biosolids haulers, laboratory services, SCADA support). Conversely, vendors serve multiple WWTP facilities across the utilitys service territory, often with facility-specific contract terms, delivery schedules, performance requirements, and compliance obligations. The business actively manages these contracts as distinct operational relationships.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` (
    `outfall_id` BIGINT COMMENT 'Primary key for outfall. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'compliance permit id. Ref: EPA SDWA.',
    `primary_outfall_id` BIGINT COMMENT 'Self-referencing FK on outfall (primary_outfall_id). Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'registry id. Ref: EPA SDWA.',
    `watershed_id` BIGINT COMMENT 'watershed id. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Unique identifier for the wwtp referenced by each outfall record in the wastewater domain.',
    `actual_flow_cms` DECIMAL(18,2) COMMENT 'Most recent measured flow rate at the outfall. Ref: EPA SDWA.',
    `outfall_code` STRING COMMENT 'External identifier or code assigned to the outfall by the utility or regulatory agency. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status based on latest monitoring. Ref: EPA SDWA.',
    `construction_year` STRING COMMENT 'Year the outfall infrastructure was constructed. Ref: EPA SDWA.',
    `county` STRING COMMENT 'County where the outfall is located. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outfall record was first created in the system. Ref: EPA SDWA.',
    `outfall_description` STRING COMMENT 'Free‑text description of the outfall, including any special characteristics. Ref: EPA SDWA.',
    `design_capacity_cms` DECIMAL(18,2) COMMENT 'Maximum designed flow rate the outfall can safely convey. Ref: EPA SDWA.',
    `designation` STRING COMMENT 'The designation value recorded for each outfall in the wastewater domain.',
    `discharge_flow_rate_mgd` DECIMAL(18,2) COMMENT 'discharge flow rate mgd. Ref: EPA SDWA.',
    `discharge_point_type` STRING COMMENT 'Indicates whether the outfall is a point source or diffuse source. Ref: EPA SDWA.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Elevation of the outfall above mean sea level. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for outfall. Ref: EPA SDWA.',
    `hydraulic_retention_time_seconds` STRING COMMENT 'Time water spends in the outfall conveyance system. Ref: EPA SDWA.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection. Ref: EPA SDWA.',
    `is_monitored` BOOLEAN COMMENT 'Indicates whether the outfall is subject to routine monitoring. Ref: EPA SDWA.',
    `is_public_access` BOOLEAN COMMENT 'Indicates whether the outfall location is publicly accessible. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection. Ref: EPA SDWA.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity. Ref: EPA SDWA.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the outfall location. Ref: EPA SDWA.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the outfall location. Ref: EPA SDWA.',
    `maintenance_status` STRING COMMENT 'Current maintenance condition of the outfall. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'How often the outfall is monitored for water quality. Ref: EPA SDWA.',
    `outfall_name` STRING COMMENT 'Human‑readable name of the outfall location. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `npdes_permit_number` STRING COMMENT 'National Pollutant Discharge Elimination System permit identifier. Ref: EPA SDWA.',
    `outfall_number` STRING COMMENT 'outfall number. Ref: EPA SDWA.',
    `outfall_type` STRING COMMENT 'Category describing the nature of the outfall discharge point. Ref: EPA SDWA.',
    `permit_effective_date` DATE COMMENT 'Date when the NPDES permit became effective. Ref: EPA SDWA.',
    `permit_expiration_date` DATE COMMENT 'Date when the NPDES permit expires. Ref: EPA SDWA.',
    `permitted_flag` BOOLEAN COMMENT 'permitted flag. Ref: EPA SDWA.',
    `receiving_water_body_name` STRING COMMENT 'The receiving water body name used to identify each outfall record in the wastewater domain.',
    `receiving_water_classification` STRING COMMENT 'receiving water classification. Ref: EPA SDWA.',
    `state` STRING COMMENT 'State jurisdiction of the outfall. Ref: EPA SDWA.',
    `outfall_status` STRING COMMENT 'Current operational status of the outfall. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the outfall record. Ref: EPA SDWA.',
    `water_quality_parameter` STRING COMMENT 'Primary water quality metric monitored at the outfall. Ref: EPA SDWA.',
    CONSTRAINT pk_outfall PRIMARY KEY(`outfall_id`)
) COMMENT 'Master reference table for outfall. Referenced by outfall_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` (
    `grease_interceptor_id` BIGINT COMMENT 'Primary key for grease_interceptor. Ref: EPA SDWA.',
    `fog_source_id` BIGINT COMMENT 'Unique identifier for the fog source referenced by each grease interceptor record in the wastewater domain.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location record where the interceptor is sited. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'registry id. Ref: EPA SDWA.',
    `upstream_grease_interceptor_id` BIGINT COMMENT 'Self-referencing FK on grease_interceptor (upstream_grease_interceptor_id). Ref: EPA SDWA.',
    `asset_tag` STRING COMMENT 'Internal asset tag or serial number assigned to the interceptor. Ref: EPA SDWA.',
    `capacity_gallons` DECIMAL(18,2) COMMENT 'Design capacity of the interceptor in gallons. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'compliance status. Ref: EPA SDWA.',
    `condition_rating` STRING COMMENT 'Overall condition assessment of the interceptor. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each grease interceptor record in the wastewater domain.',
    `decommission_date` DATE COMMENT 'Date the interceptor was removed from service, if applicable. Ref: EPA SDWA.',
    `diameter_inch` DECIMAL(18,2) COMMENT 'Internal inlet diameter of the interceptor in inches. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for grease_interceptor. Ref: EPA SDWA.',
    `inspection_status` STRING COMMENT 'Result of the most recent regulatory or internal inspection. Ref: EPA SDWA.',
    `installation_date` DATE COMMENT 'Date the interceptor was installed. Ref: EPA SDWA.',
    `interceptor_number` STRING COMMENT 'interceptor number. Ref: EPA SDWA.',
    `interceptor_status` STRING COMMENT 'The interceptor status value recorded for each grease interceptor in the wastewater domain.',
    `interceptor_type` STRING COMMENT 'Classification of the interceptor based on design and operation. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date the most recent inspection was conducted. Ref: EPA SDWA.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance was performed. Ref: EPA SDWA.',
    `last_pumping_date` TIMESTAMP COMMENT 'The last pumping date associated with each grease interceptor record in the wastewater domain.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the interceptor location. Ref: EPA SDWA.',
    `length_ft` DECIMAL(18,2) COMMENT 'Overall length of the interceptor in feet. Ref: EPA SDWA.',
    `location_description` STRING COMMENT 'location description. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the interceptor location. Ref: EPA SDWA.',
    `maintenance_frequency_days` STRING COMMENT 'Scheduled interval between routine maintenance activities, expressed in days. Ref: EPA SDWA.',
    `material` STRING COMMENT 'Primary material from which the interceptor is constructed. Ref: EPA SDWA.',
    `grease_interceptor_name` STRING COMMENT 'Human‑readable name of the grease interceptor. Ref: EPA SDWA.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations. Ref: EPA SDWA.',
    `number_of_compartments` STRING COMMENT 'number of compartments. Ref: EPA SDWA.',
    `owner_organization` STRING COMMENT 'Organization responsible for operation and maintenance of the interceptor. Ref: EPA SDWA.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system. Ref: EPA SDWA.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record. Ref: EPA SDWA.',
    `required_pumping_frequency_days` STRING COMMENT 'required pumping frequency days. Ref: EPA SDWA.',
    `grease_interceptor_status` STRING COMMENT 'Current operational status of the interceptor. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_grease_interceptor PRIMARY KEY(`grease_interceptor_id`)
) COMMENT 'Master reference table for grease_interceptor. Referenced by interceptor_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` (
    `land_application_site_id` BIGINT COMMENT 'Primary key for land_application_site. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each land application site record in the wastewater domain.',
    `parent_land_application_site_id` BIGINT COMMENT 'Self-referencing FK on land_application_site (parent_land_application_site_id). Ref: EPA SDWA.',
    `address_line1` STRING COMMENT 'Primary street address of the land application site. Ref: EPA SDWA.',
    `application_method` STRING COMMENT 'Technique used to apply biosolids at the site. Ref: EPA SDWA.',
    `area_acres` DECIMAL(18,2) COMMENT 'Total land area of the site expressed in acres. Ref: EPA SDWA.',
    `city` STRING COMMENT 'City where the site is located. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the site with applicable regulations. Ref: EPA SDWA.',
    `county` STRING COMMENT 'County jurisdiction containing the site. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the site record was first created in the system. Ref: EPA SDWA.',
    `crop_type` STRING COMMENT 'crop type. Ref: EPA SDWA.',
    `land_application_site_description` STRING COMMENT 'Free‑form textual description of the site characteristics and purpose. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for land_application_site. Ref: EPA SDWA.',
    `groundwater_depth_feet` DECIMAL(18,2) COMMENT 'Depth to the water table measured from ground surface at the site. Ref: EPA SDWA.',
    `is_public_access` BOOLEAN COMMENT 'Indicates whether the site is accessible to the public (true) or restricted (false). Ref: EPA SDWA.',
    `land_use_category` STRING COMMENT 'Primary land‑use designation for the site. Ref: EPA SDWA.',
    `last_application_date` DATE COMMENT 'Date of the most recent biosolids application. Ref: EPA SDWA.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site center point. Ref: EPA SDWA.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site center point. Ref: EPA SDWA.',
    `max_application_rate_tons_per_acre` DECIMAL(18,2) COMMENT 'Regulatory maximum biosolids loading rate for the site. Ref: EPA SDWA.',
    `monitoring_required` BOOLEAN COMMENT 'True if the site is subject to ongoing environmental monitoring. Ref: EPA SDWA.',
    `next_allowed_application_date` DATE COMMENT 'Earliest date the site may receive another application based on regulatory intervals. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional remarks, observations, or operational notes. Ref: EPA SDWA.',
    `owner_contact_email` STRING COMMENT 'Primary email address for the site owner. Ref: EPA SDWA.',
    `owner_contact_phone` STRING COMMENT 'Primary telephone number for the site owner. Ref: EPA SDWA.',
    `owner_name` STRING COMMENT 'Legal name of the entity that owns the land. Ref: EPA SDWA.',
    `permit_effective_date` DATE COMMENT 'Date when the permit became effective. Ref: EPA SDWA.',
    `permit_expiration_date` DATE COMMENT 'Date when the permit expires or must be renewed. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'Official permit identifier issued by the regulatory agency for biosolids application. Ref: EPA SDWA.',
    `permit_status` STRING COMMENT 'Current status of the regulatory permit. Ref: EPA SDWA.',
    `permitted_flag` BOOLEAN COMMENT 'permitted flag. Ref: EPA SDWA.',
    `regulatory_agency` STRING COMMENT 'Agency responsible for issuing and overseeing the permit. Ref: EPA SDWA.',
    `site_acreage` DECIMAL(18,2) COMMENT 'The site acreage value recorded for each land application site in the wastewater domain.',
    `site_code` STRING COMMENT 'Internal alphanumeric code used to uniquely identify the site within the utility. Ref: EPA SDWA.',
    `site_name` STRING COMMENT 'Human‑readable name of the land application site. Ref: EPA SDWA.',
    `site_number` STRING COMMENT 'site number. Ref: EPA SDWA.',
    `site_permit_number` STRING COMMENT 'site permit number. Ref: EPA SDWA.',
    `site_status` STRING COMMENT 'The site status value recorded for each land application site in the wastewater domain.',
    `site_type` STRING COMMENT 'Classification of the site based on its primary land‑use purpose for biosolids application. Ref: EPA SDWA.',
    `soil_type` STRING COMMENT 'Dominant soil classification of the site. Ref: EPA SDWA.',
    `state` STRING COMMENT 'State or province of the site location. Ref: EPA SDWA.',
    `land_application_site_status` STRING COMMENT 'Current operational status of the site in its lifecycle. Ref: EPA SDWA.',
    `total_acreage` DECIMAL(18,2) COMMENT 'total acreage. Ref: EPA SDWA.',
    `total_acres` DECIMAL(18,2) COMMENT 'total acres. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the site record. Ref: EPA SDWA.',
    `water_body_proximity_miles` DECIMAL(18,2) COMMENT 'Straight‑line distance from the site to the nearest surface water body. Ref: EPA SDWA.',
    `zip_code` STRING COMMENT 'Postal (ZIP) code for the site address. Ref: EPA SDWA.',
    CONSTRAINT pk_land_application_site PRIMARY KEY(`land_application_site_id`)
) COMMENT 'Master reference table for land_application_site. Referenced by site_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` (
    `storm_event_id` BIGINT COMMENT 'Primary key for storm_event. Ref: EPA SDWA.',
    `preceding_storm_event_id` BIGINT COMMENT 'Self-referencing FK on storm_event (preceding_storm_event_id). Ref: EPA SDWA.',
    `watershed_id` BIGINT COMMENT 'Unique identifier for the watershed referenced by each storm event record in the wastewater domain.',
    `affected_area_sqkm` DECIMAL(18,2) COMMENT 'Geographic area impacted by the storm in square kilometers. Ref: EPA SDWA.',
    `alert_level` STRING COMMENT 'Public alert level assigned to the storm event. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storm event record was first created in the system. Ref: EPA SDWA.',
    `storm_event_description` STRING COMMENT 'Narrative description of the storm event and its impacts. Ref: EPA SDWA.',
    `duration_hours` DECIMAL(18,2) COMMENT 'duration hours. Ref: EPA SDWA.',
    `duration_minutes` STRING COMMENT 'Total duration of the storm event in minutes. Ref: EPA SDWA.',
    `event_category` STRING COMMENT 'Broad category indicating cause of the storm event. Ref: EPA SDWA.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the storm event ended. Ref: EPA SDWA.',
    `event_name` STRING COMMENT 'event name. Ref: EPA SDWA.',
    `event_start_timestamp` TIMESTAMP COMMENT 'The event start timestamp associated with each storm event record in the wastewater domain.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the storm event began. Ref: EPA SDWA.',
    `event_type` STRING COMMENT 'Classification of the storm event type. Ref: EPA SDWA.',
    `flood_depth_cm` DECIMAL(18,2) COMMENT 'Maximum flood depth measured during the event in centimeters. Ref: EPA SDWA.',
    `forecast_timestamp` TIMESTAMP COMMENT 'Date and time when the precipitation forecast was generated. Ref: EPA SDWA.',
    `forecasted_precipitation_mm` DECIMAL(18,2) COMMENT 'Predicted total precipitation for the event in millimeters. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for storm_event. Ref: EPA SDWA.',
    `is_flooding` BOOLEAN COMMENT 'Flag indicating whether flooding occurred as a result of the storm. Ref: EPA SDWA.',
    `location_name` STRING COMMENT 'Name of the primary location or watershed affected by the storm. Ref: EPA SDWA.',
    `noaa_event_reference` STRING COMMENT 'noaa event reference. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `nwp_model_used` STRING COMMENT 'Name of the NWP model used for forecasting the storm. Ref: EPA SDWA.',
    `peak_flow_cfs` DECIMAL(18,2) COMMENT 'Maximum flow rate recorded during the storm in cubic feet per second. Ref: EPA SDWA.',
    `peak_intensity_in_per_hr` DECIMAL(18,2) COMMENT 'peak intensity in per hr. Ref: EPA SDWA.',
    `peak_intensity_inches_per_hour` DECIMAL(18,2) COMMENT 'The peak intensity inches per hour value recorded for each storm event in the wastewater domain.',
    `peak_rainfall_intensity_in_hr` DECIMAL(18,2) COMMENT 'peak rainfall intensity in hr. Ref: EPA SDWA.',
    `regulatory_report_flag` BOOLEAN COMMENT 'Indicates if the storm event was reported to regulatory agencies. Ref: EPA SDWA.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the storm event was reported. Ref: EPA SDWA.',
    `reported_by` STRING COMMENT 'Name of the person or entity that reported the storm event. Ref: EPA SDWA.',
    `return_period_years` STRING COMMENT 'The return period years value recorded for each storm event in the wastewater domain.',
    `severity` STRING COMMENT 'Severity level of the storm event based on impact. Ref: EPA SDWA.',
    `storm_event_status` STRING COMMENT 'Current lifecycle status of the storm event record. Ref: EPA SDWA.',
    `total_precipitation_mm` DECIMAL(18,2) COMMENT 'Total measured precipitation during the event in millimeters. Ref: EPA SDWA.',
    `total_rainfall_inches` DECIMAL(18,2) COMMENT 'The total rainfall inches value recorded for each storm event in the wastewater domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the storm event record. Ref: EPA SDWA.',
    CONSTRAINT pk_storm_event PRIMARY KEY(`storm_event_id`)
) COMMENT 'Master reference table for storm_event. Referenced by storm_event_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` (
    `sses_study_id` BIGINT COMMENT 'Primary key for sses_study. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each sses study record in the wastewater domain.',
    `cost_center_id` BIGINT COMMENT 'cost center id. Ref: EPA SDWA.',
    `predecessor_sses_study_id` BIGINT COMMENT 'Self-referencing FK on sses_study (predecessor_sses_study_id). Ref: EPA SDWA.',
    `sewershed_basin_id` BIGINT COMMENT 'basin id. Ref: EPA SDWA.',
    `sses_sewershed_basin_id` BIGINT COMMENT 'Unique identifier for the sses sewershed basin referenced by each sses study record in the wastewater domain.',
    `author_name` STRING COMMENT 'Name of the individual who authored the study. Ref: EPA SDWA.',
    `completion_date` TIMESTAMP COMMENT 'completion date. Ref: EPA SDWA.',
    `consultant_name` STRING COMMENT 'consultant name. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study record was first created in the system. Ref: EPA SDWA.',
    `data_source` STRING COMMENT 'Source system or dataset from which study data originates. Ref: EPA SDWA.',
    `sses_study_description` STRING COMMENT 'Detailed description of the study objectives, scope, and methodology. Ref: EPA SDWA.',
    `effective_from` DATE COMMENT 'Date when the study becomes effective or valid. Ref: EPA SDWA.',
    `effective_until` DATE COMMENT 'Date when the study expires or is no longer valid. Ref: EPA SDWA.',
    `estimated_ii_reduction_gpd` DECIMAL(18,2) COMMENT 'The estimated ii reduction gpd value recorded for each sses study in the wastewater domain.',
    `estimated_rehab_cost_usd` DECIMAL(18,2) COMMENT 'estimated rehab cost usd. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for sses_study. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional free‑form notes related to the study. Ref: EPA SDWA.',
    `regulatory_requirement` STRING COMMENT 'Regulatory framework the study addresses. Ref: EPA SDWA.',
    `revision_number` STRING COMMENT 'Sequential revision number of the study. Ref: EPA SDWA.',
    `sponsor_organization` STRING COMMENT 'Organization sponsoring or funding the study. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'start date. Ref: EPA SDWA.',
    `sses_study_status` STRING COMMENT 'Current lifecycle status of the study. Ref: EPA SDWA.',
    `study_area_acres` DECIMAL(18,2) COMMENT 'Geographic area covered by the study in acres. Ref: EPA SDWA.',
    `study_code` STRING COMMENT 'External reference code for the study used in regulatory filings. Ref: EPA SDWA.',
    `study_completion_date` TIMESTAMP COMMENT 'The study completion date associated with each sses study record in the wastewater domain.',
    `study_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of conducting the study in US dollars. Ref: EPA SDWA.',
    `study_name` STRING COMMENT 'Human‑readable name of the study. Ref: EPA SDWA.',
    `study_number` STRING COMMENT 'study number. Ref: EPA SDWA.',
    `study_start_date` TIMESTAMP COMMENT 'The study start date associated with each sses study record in the wastewater domain.',
    `study_status` STRING COMMENT 'The study status value recorded for each sses study in the wastewater domain.',
    `study_type` STRING COMMENT 'Category of the study indicating its primary focus. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the study record. Ref: EPA SDWA.',
    `version` STRING COMMENT 'Version identifier of the study document. Ref: EPA SDWA.',
    CONSTRAINT pk_sses_study PRIMARY KEY(`sses_study_id`)
) COMMENT 'Master reference table for sses_study. Referenced by sses_study_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` (
    `watershed_id` BIGINT COMMENT 'Unique identifier for the watershed referenced by each watershed record in the wastewater domain.',
    `parent_watershed_id` BIGINT COMMENT 'Unique identifier for the parent watershed referenced by each watershed record in the wastewater domain.',
    `area_sq_km` DECIMAL(18,2) COMMENT 'The area sq km value recorded for each watershed in the wastewater domain.',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'watershed area sq miles. Ref: EPA SDWA.',
    `average_precipitation_mm` DECIMAL(18,2) COMMENT 'The average precipitation mm value recorded for each watershed in the wastewater domain.',
    `climate_zone` STRING COMMENT 'The climate zone value recorded for each watershed in the wastewater domain.',
    `watershed_code` STRING COMMENT 'The watershed code value recorded for each watershed in the wastewater domain.',
    `connections_count` STRING COMMENT 'The connections count value recorded for each watershed in the wastewater domain.',
    `county` STRING COMMENT 'The county component of the address for each watershed record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each watershed record in the wastewater domain.',
    `creation_timestamp` TIMESTAMP COMMENT 'The creation timestamp associated with each watershed record in the wastewater domain.',
    `data_source` STRING COMMENT 'The data source value recorded for each watershed in the wastewater domain.',
    `watershed_description` STRING COMMENT 'The watershed description value recorded for each watershed in the wastewater domain.',
    `drainage_area_acres` DECIMAL(18,2) COMMENT 'The drainage area acres value recorded for each watershed in the wastewater domain.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with each watershed record in the wastewater domain.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with each watershed record in the wastewater domain.',
    `generated` STRING COMMENT 'Auto‑generated attribute for watershed. Ref: EPA SDWA.',
    `geometry_wkt` STRING COMMENT 'The geometry wkt value recorded for each watershed in the wastewater domain.',
    `huc_code` STRING COMMENT 'The huc code value recorded for each watershed in the wastewater domain.',
    `impaired_water_flag` BOOLEAN COMMENT 'impaired water flag. Ref: EPA SDWA.',
    `land_use_category` STRING COMMENT 'The land use category value recorded for each watershed in the wastewater domain.',
    `last_inspection_date` DATE COMMENT 'The last inspection date associated with each watershed record in the wastewater domain.',
    `last_inspection_result` STRING COMMENT 'The last inspection result value recorded for each watershed in the wastewater domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp associated with each watershed record in the wastewater domain.',
    `latitude` DECIMAL(18,2) COMMENT 'latitude. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'longitude. Ref: EPA SDWA.',
    `management_agency` STRING COMMENT 'The management agency value recorded for each watershed in the wastewater domain.',
    `watershed_name` STRING COMMENT 'The watershed name used to identify each watershed record in the wastewater domain.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `pollution_level` STRING COMMENT 'The pollution level value recorded for each watershed in the wastewater domain.',
    `population_served` STRING COMMENT 'The population served value recorded for each watershed in the wastewater domain.',
    `primary_receiving_water_body` STRING COMMENT 'primary receiving water body. Ref: EPA SDWA.',
    `primary_river` STRING COMMENT 'The primary river value recorded for each watershed in the wastewater domain.',
    `protected_status` STRING COMMENT 'The protected status value recorded for each watershed in the wastewater domain.',
    `receiving_water_body_name` STRING COMMENT 'The receiving water body name used to identify each watershed record in the wastewater domain.',
    `region` STRING COMMENT 'The region value recorded for each watershed in the wastewater domain.',
    `state` STRING COMMENT 'The state component of the address for each watershed record.',
    `watershed_status` STRING COMMENT 'The watershed status value recorded for each watershed in the wastewater domain.',
    `tmdl_applicable_flag` BOOLEAN COMMENT 'tmdl applicable flag. Ref: EPA SDWA.',
    `total_flow_cfs` DECIMAL(18,2) COMMENT 'The total flow cfs value recorded for each watershed in the wastewater domain.',
    `watershed_type` STRING COMMENT 'The watershed type value recorded for each watershed in the wastewater domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'updated timestamp. Ref: EPA SDWA.',
    `water_quality_index` STRING COMMENT 'The water quality index value recorded for each watershed in the wastewater domain.',
    CONSTRAINT pk_watershed PRIMARY KEY(`watershed_id`)
) COMMENT 'Master reference table for watershed. Referenced by watershed_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` (
    `sewershed_basin_id` BIGINT COMMENT 'Primary key for sewershed_basin. Ref: EPA SDWA.',
    `parent_sewershed_basin_id` BIGINT COMMENT 'Self-referencing FK on sewershed_basin (parent_sewershed_basin_id). Ref: EPA SDWA.',
    `watershed_id` BIGINT COMMENT 'Identifier of the larger watershed that contains the basin. Ref: EPA SDWA.',
    `wwtp_id` BIGINT COMMENT 'Unique identifier for the wwtp referenced by each sewershed basin record in the wastewater domain.',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Total surface area of the basin in square kilometers. Ref: EPA SDWA.',
    `average_annual_precipitation_mm` DECIMAL(18,2) COMMENT 'Mean yearly precipitation measured within the basin. Ref: EPA SDWA.',
    `average_annual_temperature_c` DECIMAL(18,2) COMMENT 'Mean yearly air temperature for the basin area. Ref: EPA SDWA.',
    `average_dry_weather_flow_mgd` DECIMAL(18,2) COMMENT 'average dry weather flow mgd. Ref: EPA SDWA.',
    `average_flow_cfs` DECIMAL(18,2) COMMENT 'Mean daily flow rate for the basin. Ref: EPA SDWA.',
    `basin_code` STRING COMMENT 'External or legacy code used to identify the basin in operational systems. Ref: EPA SDWA.',
    `basin_manager_email` STRING COMMENT 'Email address of the basin manager. Ref: EPA SDWA.',
    `basin_manager_name` STRING COMMENT 'Name of the person responsible for managing the basin. Ref: EPA SDWA.',
    `basin_manager_phone` STRING COMMENT 'Contact phone number for the basin manager. Ref: EPA SDWA.',
    `basin_name` STRING COMMENT 'Human‑readable name of the sewershed basin. Ref: EPA SDWA.',
    `basin_type` STRING COMMENT 'Classification of the basin based on sewer system design. Ref: EPA SDWA.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude of the geographic centroid of the basin. Ref: EPA SDWA.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude of the geographic centroid of the basin. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each sewershed basin record in the wastewater domain.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the basin record was first created in the system. Ref: EPA SDWA.',
    `design_capacity_cfs` DECIMAL(18,2) COMMENT 'Engineered maximum flow capacity of the basin in cubic feet per second. Ref: EPA SDWA.',
    `downstream_basin_codes` STRING COMMENT 'Comma‑separated list of basin codes that receive flow from this basin. Ref: EPA SDWA.',
    `drainage_area_acres` DECIMAL(18,2) COMMENT 'The drainage area acres value recorded for each sewershed basin in the wastewater domain.',
    `flood_risk_level` STRING COMMENT 'Categorized flood risk for the basin based on FEMA guidelines. Ref: EPA SDWA.',
    `generated` STRING COMMENT 'Auto‑generated attribute for sewershed_basin. Ref: EPA SDWA.',
    `impervious_percent` DECIMAL(18,2) COMMENT 'Percentage of basin area covered by impervious surfaces. Ref: EPA SDWA.',
    `infiltration_rate_lps` DECIMAL(18,2) COMMENT 'Average rate at which groundwater infiltrates into the sewer system. Ref: EPA SDWA.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection. Ref: EPA SDWA.',
    `land_use` STRING COMMENT 'Primary land‑use category for the basin. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection. Ref: EPA SDWA.',
    `last_maintenance_date` DATE COMMENT 'Date when the basin last underwent scheduled maintenance. Ref: EPA SDWA.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the basin record. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'latitude. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'longitude. Ref: EPA SDWA.',
    `maintenance_schedule` STRING COMMENT 'Description of the routine maintenance schedule for the basin. Ref: EPA SDWA.',
    `maintenance_status` STRING COMMENT 'Current status of maintenance activities. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'notes. Ref: EPA SDWA.',
    `npdes_permit_number` STRING COMMENT 'National Pollutant Discharge Elimination System permit identifier for the basin. Ref: EPA SDWA.',
    `peak_flow_cfs` DECIMAL(18,2) COMMENT 'Observed maximum flow rate recorded for the basin. Ref: EPA SDWA.',
    `peak_wet_weather_flow_mgd` DECIMAL(18,2) COMMENT 'peak wet weather flow mgd. Ref: EPA SDWA.',
    `permit_expiration_date` DATE COMMENT 'Date the NPDES permit expires. Ref: EPA SDWA.',
    `permit_issue_date` DATE COMMENT 'Date the NPDES permit was issued. Ref: EPA SDWA.',
    `permit_status` STRING COMMENT 'Current compliance status of the NPDES permit. Ref: EPA SDWA.',
    `pollutant_load_kg_per_day` DECIMAL(18,2) COMMENT 'Total mass of regulated pollutants discharged from the basin per day. Ref: EPA SDWA.',
    `population_served` BIGINT COMMENT 'Estimated number of people residing within the basin boundaries. Ref: EPA SDWA.',
    `regulatory_region` STRING COMMENT 'Regulatory jurisdiction or region governing the basin. Ref: EPA SDWA.',
    `service_population` STRING COMMENT 'The service population value recorded for each sewershed basin in the wastewater domain.',
    `soil_type` STRING COMMENT 'Dominant soil composition within the basin. Ref: EPA SDWA.',
    `sewershed_basin_status` STRING COMMENT 'Current operational lifecycle status of the basin. Ref: EPA SDWA.',
    `total_area_acres` DECIMAL(18,2) COMMENT 'total area acres. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `upstream_basin_codes` STRING COMMENT 'Comma‑separated list of basin codes that drain into this basin. Ref: EPA SDWA.',
    CONSTRAINT pk_sewershed_basin PRIMARY KEY(`sewershed_basin_id`)
) COMMENT 'Master reference table for sewershed_basin. Referenced by basin_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_sewershed_basin_id` FOREIGN KEY (`sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_effluent_discharge_event_id` FOREIGN KEY (`effluent_discharge_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event`(`effluent_discharge_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`storm_event`(`storm_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_sses_study_id` FOREIGN KEY (`sses_study_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sses_study`(`sses_study_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_watershed_id` FOREIGN KEY (`watershed_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`watershed`(`watershed_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_ii_monitoring_point_id` FOREIGN KEY (`ii_monitoring_point_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point`(`ii_monitoring_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_grease_interceptor_id` FOREIGN KEY (`grease_interceptor_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor`(`grease_interceptor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_fog_source_id` FOREIGN KEY (`fog_source_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`fog_source`(`fog_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_biosolids_batch_id` FOREIGN KEY (`biosolids_batch_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch`(`biosolids_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_biosolids_land_application_site_id` FOREIGN KEY (`biosolids_land_application_site_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`land_application_site`(`land_application_site_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_land_application_site_id` FOREIGN KEY (`land_application_site_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`land_application_site`(`land_application_site_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_primary_original_submission_dmr_submission_id` FOREIGN KEY (`primary_original_submission_dmr_submission_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`dmr_submission`(`dmr_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ADD CONSTRAINT `fk_wastewater_facility_grant_allocation_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ADD CONSTRAINT `fk_wastewater_facility_vendor_contract_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_primary_outfall_id` FOREIGN KEY (`primary_outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_watershed_id` FOREIGN KEY (`watershed_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`watershed`(`watershed_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ADD CONSTRAINT `fk_wastewater_grease_interceptor_fog_source_id` FOREIGN KEY (`fog_source_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`fog_source`(`fog_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ADD CONSTRAINT `fk_wastewater_grease_interceptor_upstream_grease_interceptor_id` FOREIGN KEY (`upstream_grease_interceptor_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor`(`grease_interceptor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ADD CONSTRAINT `fk_wastewater_land_application_site_parent_land_application_site_id` FOREIGN KEY (`parent_land_application_site_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`land_application_site`(`land_application_site_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ADD CONSTRAINT `fk_wastewater_storm_event_preceding_storm_event_id` FOREIGN KEY (`preceding_storm_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`storm_event`(`storm_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ADD CONSTRAINT `fk_wastewater_storm_event_watershed_id` FOREIGN KEY (`watershed_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`watershed`(`watershed_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ADD CONSTRAINT `fk_wastewater_sses_study_predecessor_sses_study_id` FOREIGN KEY (`predecessor_sses_study_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sses_study`(`sses_study_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ADD CONSTRAINT `fk_wastewater_sses_study_sewershed_basin_id` FOREIGN KEY (`sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ADD CONSTRAINT `fk_wastewater_sses_study_sses_sewershed_basin_id` FOREIGN KEY (`sses_sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` ADD CONSTRAINT `fk_wastewater_watershed_parent_watershed_id` FOREIGN KEY (`parent_watershed_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`watershed`(`watershed_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ADD CONSTRAINT `fk_wastewater_sewershed_basin_parent_sewershed_basin_id` FOREIGN KEY (`parent_sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ADD CONSTRAINT `fk_wastewater_sewershed_basin_watershed_id` FOREIGN KEY (`watershed_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`watershed`(`watershed_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ADD CONSTRAINT `fk_wastewater_sewershed_basin_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_domain' = 'wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'NPDES (National Pollutant Discharge Elimination System) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Drainage Basin ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow (MGD - Million Gallons per Day)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Criticality Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (MGD - Million Gallons per Day)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `downstream_invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Downstream Invert Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `easement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Easement Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `fog_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'FOG (Fats Oils and Grease) Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `gis_geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Geometry (WKT)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `hydrogen_sulfide_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `length_feet` SET TAGS ('dbx_business_glossary_term' = 'Segment Length (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `lining_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Lining Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `lining_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Lining Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `lining_type` SET TAGS ('dbx_value_regex' = 'none|cipp|spray_on|slip_lining|grout');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|planned|under_construction');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|private|municipal|joint');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `peak_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow (GPM - Gallons per Min)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `root_intrusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Intrusion Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `segment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Segment Business Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'gravity_sewer|force_main|interceptor|trunk_line|lateral|service_connection');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `slope_percent` SET TAGS ('dbx_business_glossary_term' = 'Pipe Slope (Percent)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sso_history_count` SET TAGS ('dbx_business_glossary_term' = 'SSO (Sanitary Sewer Overflow) History Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Traffic Impact Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `upstream_invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Upstream Invert Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Drainage Basin Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `cover_type` SET TAGS ('dbx_business_glossary_term' = 'Manhole Cover Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `cover_type` SET TAGS ('dbx_value_regex' = 'standard|watertight|bolted|vented|traffic_rated|solid');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Manhole Depth (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Manhole Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `inflow_infiltration_flag` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Invert Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `macp_score` SET TAGS ('dbx_business_glossary_term' = 'Manhole Assessment and Certification Program (MACP) Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Manhole Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_status` SET TAGS ('dbx_business_glossary_term' = 'Manhole Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|planned|under_construction|decommissioned');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_type` SET TAGS ('dbx_business_glossary_term' = 'Manhole Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `ownership` SET TAGS ('dbx_business_glossary_term' = 'Ownership');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `ownership` SET TAGS ('dbx_value_regex' = 'utility|municipal|private|state|federal|joint');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `rim_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Rim Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `scada_monitored_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitored Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `sso_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) History Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_business_glossary_term' = 'Traffic Load Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_value_regex' = 'light_duty|medium_duty|heavy_duty|extra_heavy_duty');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `lift_station_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost in United States Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Capacity in Kilowatts (kW)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_value_regex' = 'generator|battery|none|dual_feed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `design_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity in Million Gallons Per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Force Main Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Force Main Length in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_material` SET TAGS ('dbx_business_glossary_term' = 'Force Main Material');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_material` SET TAGS ('dbx_value_regex' = 'ductile_iron|pvc|hdpe|steel|concrete');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `last_rehabilitation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rehabilitation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `number_of_pumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Pumps');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|standby|maintenance|decommissioned|under_construction');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|private|developer|municipal|joint');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `pump_configuration` SET TAGS ('dbx_business_glossary_term' = 'Pump Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `pump_configuration` SET TAGS ('dbx_value_regex' = 'duplex|triplex|quadruplex|simplex');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `pump_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Pump Horsepower (HP)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost in United States Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `service_area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `service_area_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `service_area_population` SET TAGS ('dbx_business_glossary_term' = 'Service Area Population');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `sso_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'submersible|dry_pit|wet_pit|pneumatic|grinder');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_value_regex' = 'online|offline|intermittent|not_installed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `total_dynamic_head_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Dynamic Head (TDH) in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `wet_well_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Wet Well Volume in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_facility' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_treatment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'WWTP Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_management_method` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Management');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `effluent_discharge_point` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `energy_consumption_kwh_per_mg` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_business_glossary_term' = 'Facility Email');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Upgrade Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `peak_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `permit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_classification` SET TAGS ('dbx_business_glossary_term' = 'Water Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'SCADA System');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `bypass_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bypass Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `bypass_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Bypass Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exceedance|violation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Authorization Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Discharge Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Discharge Flow Rate Gallons per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_status` SET TAGS ('dbx_value_regex' = 'authorized|unauthorized|emergency|bypass|planned|unplanned');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|batch|emergency_bypass|planned_bypass');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Discharge Volume Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `dmr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `dmr_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Discharge Event Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `permit_limit_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `rainfall_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Amount (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `receiving_water_body_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `scada_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|advanced|partial|none');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_parameter_result_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Parameter Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `lab_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `primary_effluent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `primary_effluent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `primary_effluent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analysis Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `data_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Data Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `data_validation_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_value_regex' = '^d{4}-d{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `dmr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `dmr_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `dmr_submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `laboratory_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `mass_loading_lbs_per_day` SET TAGS ('dbx_business_glossary_term' = 'Mass Loading Pounds per Day');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_value_regex' = 'daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `quantitation_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantitation Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'EPA|state_primacy_agency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `result_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Time');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite_24hr|composite_flow_weighted|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Post Event Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `sso_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'SSO Cause Category');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_value_regex' = 'blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'SSO Cause Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'SSO Cause Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `discovered_by` SET TAGS ('dbx_business_glossary_term' = 'Discovered By');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `discovered_by` SET TAGS ('dbx_value_regex' = 'utility_staff|customer_complaint|routine_inspection|scada_alarm|third_party|other');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `dmr_reported` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reported Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'DMR Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'SSO Duration (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Taken');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_value_regex' = 'none|warning|notice_of_violation|consent_order|penalty|other');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `estimated_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Spill Volume (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SSO Event End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^SSO-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|corrective_action_in_progress|resolved|closed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Overflow Location Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `overflow_location_type` SET TAGS ('dbx_business_glossary_term' = 'Overflow Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `overflow_location_type` SET TAGS ('dbx_value_regex' = 'manhole|cleanout|pump_station|force_main|gravity_sewer|building_lateral');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `preventive_action_planned` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Planned');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `public_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `rainfall_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Amount (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `reached_surface_water` SET TAGS ('dbx_business_glossary_term' = 'Reached Surface Water Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `receiving_environment` SET TAGS ('dbx_business_glossary_term' = 'Receiving Environment');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `receiving_environment` SET TAGS ('dbx_value_regex' = 'surface_water|storm_drain|land_surface|building_interior|other');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Volume Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_value_regex' = 'measured|calculated|estimated');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `volume_recovered_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Recovered (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `weather_related` SET TAGS ('dbx_business_glossary_term' = 'Weather-Related SSO Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `cso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Combined Sewer Overflow (CSO) Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ltcp Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Post Event Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `bod_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand (BOD) Concentration (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'Cause Category');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_value_regex' = 'wet_weather|equipment_failure|capacity_exceedance|operational_error|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `control_measure_active` SET TAGS ('dbx_business_glossary_term' = 'Control Measure Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `control_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Control Measure Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `dmr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `dmr_submitted` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `event_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|validated|closed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `fecal_coliform_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform (CFU/100mL)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `ltcp_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Control Plan (LTCP) Reference ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `monitoring_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|online_portal|fax|automated_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `operator_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `outfall_designation` SET TAGS ('dbx_business_glossary_term' = 'Outfall Designation Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `overflow_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Overflow Volume (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `overflow_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Overflow Volume Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `post_event_monitoring_completed` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Monitoring Completed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `post_event_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Monitoring Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `precipitation_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Amount (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `precipitation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `public_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `receiving_water_body_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `scada_alarm_triggered` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Alarm Triggered Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `tss_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Concentration (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Volume Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_value_regex' = 'measured|modeled|estimated|calculated');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `ii_monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Monitoring Point Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `primary_ii_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `sses_study_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer System Evaluation Survey (SSES) Study Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `watershed_id` SET TAGS ('dbx_business_glossary_term' = 'Watershed Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `baseline_dry_weather_flow_gpd` SET TAGS ('dbx_business_glossary_term' = 'Baseline Dry Weather Flow in Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `contributing_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Contributing Area in Acres');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `data_logger_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Logger Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `ii_monitoring_point_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `ii_monitoring_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `infiltration_rate_gpd` SET TAGS ('dbx_business_glossary_term' = 'Infiltration Rate in Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `inflow_rate_gpd` SET TAGS ('dbx_business_glossary_term' = 'Inflow Rate in Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|quarterly|event_based');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_name` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_type` SET TAGS ('dbx_value_regex' = 'flow_meter|rain_gauge|smoke_test_zone|cctv_inspection_segment|manhole_inspection|pressure_sensor');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `peak_wet_weather_flow_gpd` SET TAGS ('dbx_business_glossary_term' = 'Peak Wet Weather Flow in Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `pipe_age_years` SET TAGS ('dbx_business_glossary_term' = 'Pipe Age in Years');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `rehabilitation_priority_category` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Priority Category');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `rehabilitation_priority_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `rehabilitation_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Priority Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `wet_weather_flow_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Wet Weather Flow Multiplier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_flow_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Flow Measurement ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_validated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_validated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_validated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Rain Gauge ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Segment ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'high_flow|low_flow|sensor_fault|communication_loss|none');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `average_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `calculated_ii_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Calculated Inflow and Infiltration (I&I) Volume in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual|mobile|third_party');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `dry_weather_baseline_gpm` SET TAGS ('dbx_business_glossary_term' = 'Dry Weather Baseline Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `flow_velocity_fps` SET TAGS ('dbx_business_glossary_term' = 'Flow Velocity in Feet Per Second (FPS)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_type` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_type` SET TAGS ('dbx_value_regex' = 'infiltration|inflow|combined|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measured_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Measured Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measured_flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Measured Flow Rate in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Duration in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'ultrasonic|magnetic|weir|flume|manual');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `minimum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `peak_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `pipe_depth_fill_percent` SET TAGS ('dbx_business_glossary_term' = 'Pipe Depth Fill Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `rain_gauge_reference` SET TAGS ('dbx_business_glossary_term' = 'Rain Gauge ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `rainfall_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Depth in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `rehabilitation_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Priority Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `sensor_reference` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'dry|wet|storm|post-storm');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Metering Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `bod_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand (BOD) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `cadmium_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Cadmium (Cd) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `categorical_standard_applicable` SET TAGS ('dbx_business_glossary_term' = 'Categorical Pretreatment Standard Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `categorical_standard_citation` SET TAGS ('dbx_business_glossary_term' = 'Categorical Standard Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `chromium_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Chromium (Cr) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `cod_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Chemical Oxygen Demand (COD) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_schedule_final_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Final Milestone Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_schedule_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `copper_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Copper (Cu) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `flow_limit_gpd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discharge Flow Limit (Gallons Per Day - GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `fog_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_needed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuing Authority');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Facility Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `lead_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Lead (Pb) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `mercury_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Self-Monitoring Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `nickel_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Nickel (Ni) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_value_regex' = '^IUP-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Lifecycle Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|terminated');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'categorical|non-categorical|significant_industrial_user|minor_industrial_user');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `ph_maximum` SET TAGS ('dbx_business_glossary_term' = 'pH Maximum Discharge Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `ph_minimum` SET TAGS ('dbx_business_glossary_term' = 'pH Minimum Discharge Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `pretreatment_required` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment System Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `pretreatment_system_description` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment System Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `silver_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Silver (Ag) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `total_nitrogen_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `total_phosphorus_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Phosphorus Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `tss_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `zinc_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Zinc (Zn) Discharge Limit (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `iup_compliance_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Compliance Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampler ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `iup_sampler_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampler ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `iup_sampler_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `iup_sampler_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `lab_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Sample Comments');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|violation|exceedance|not_applicable|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `composite_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Composite Duration Hours');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `enforcement_action_required` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `flow_rate_at_sampling` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate at Sampling');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Unit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `laboratory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Report Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `parameter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `permit_limit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_value_regex' = 'daily_maximum|monthly_average|instantaneous|annual_average');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `quantification_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantification Limit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `result_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Location');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_temperature` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Time');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|integrated|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_volume` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume Unit');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_volume_unit` SET TAGS ('dbx_value_regex' = 'mL|L|gal');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Sampler Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sampler_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sampler_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `violation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `violation_notice_issued` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Issued');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_id` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Source Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Establishment Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Establishment Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `best_management_practices_required` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Establishment City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|warning|violation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'FOG Program Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `establishment_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Business Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `establishment_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `establishment_type` SET TAGS ('dbx_business_glossary_term' = 'Establishment Type Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `establishment_type` SET TAGS ('dbx_value_regex' = 'restaurant|food_processor|institutional_kitchen|commercial_kitchen|bakery|other');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Days');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Establishment Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Establishment Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'FOG Source Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|inactive');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Establishment Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `required_pumping_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Required Pumping Frequency in Days');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Risk Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `sso_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Contribution Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Establishment State');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'FOG Program Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'FOG Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `fog_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `grease_interceptor_id` SET TAGS ('dbx_business_glossary_term' = 'Grease Interceptor ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `fog_source_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Grease Interceptor ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `best_management_practices_compliant` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Recommended');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_value_regex' = 'warning|notice_of_violation|administrative_order|civil_penalty|permit_suspension');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_signature` SET TAGS ('dbx_business_glossary_term' = 'Establishment Contact Signature');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `grease_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Grease Depth (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `grease_depth_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grease Depth Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `hauler_license_number` SET TAGS ('dbx_business_glossary_term' = 'Hauler License Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Time');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow_up|complaint_driven|pre_permit|annual|re_inspection');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Capacity (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_condition` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical|not_accessible');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_type` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_type` SET TAGS ('dbx_value_regex' = 'gravity|hydromechanical|automatic|passive');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `last_pumping_date` SET TAGS ('dbx_business_glossary_term' = 'Last Pumping Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `photos_taken` SET TAGS ('dbx_business_glossary_term' = 'Photos Taken');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `pumping_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Pumping Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `pumping_manifest_verified` SET TAGS ('dbx_business_glossary_term' = 'Pumping Manifest Verified');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `re_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `re_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `solids_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Solids Depth (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `sso_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Risk Assessment');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `sso_risk_assessment` SET TAGS ('dbx_value_regex' = 'low|moderate|high|imminent');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ALTER COLUMN `violations_noted` SET TAGS ('dbx_business_glossary_term' = 'Violations Noted');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `biosolids_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Batch Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Unit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `arsenic_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Arsenic (As) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Production Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `cadmium_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Cadmium (Cd) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `copper_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Copper (Cu) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'Disposition Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'land_application|landfill|incineration|beneficial_reuse|composting|surface_disposal');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_site_name` SET TAGS ('dbx_business_glossary_term' = 'Disposition Site Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_site_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_site_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Disposition Site Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `dry_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Dry Weight Tonnage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `exceptional_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceptional Quality (EQ) Biosolids Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `fecal_coliform_density_mpn_per_gram` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform Density Most Probable Number (MPN) per Gram Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `laboratory_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `lead_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Lead (Pb) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `mercury_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `nickel_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Nickel (Ni) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `pathogen_class` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Reduction Class');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `pathogen_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `percent_solids` SET TAGS ('dbx_business_glossary_term' = 'Percent Solids');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Value');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `salmonella_density_mpn_per_4_grams` SET TAGS ('dbx_business_glossary_term' = 'Salmonella Density Most Probable Number (MPN) per 4 Grams Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `selenium_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Selenium (Se) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `total_nitrogen_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen (N) Percent Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `total_phosphorus_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Phosphorus (P) Percent Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `total_potassium_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Potassium (K) Percent Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_value_regex' = 'anaerobic_digestion|aerobic_digestion|lime_stabilization|composting|heat_drying|alkaline_stabilization');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `vector_attraction_reduction_method` SET TAGS ('dbx_business_glossary_term' = 'Vector Attraction Reduction (VAR) Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `volatile_solids_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Volatile Solids (VS) Reduction Percent');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `wet_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Wet Weight Tonnage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `zinc_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Zinc (Zn) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `biosolids_land_application_id` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Land Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applicator Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `biosolids_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `land_application_site_id` SET TAGS ('dbx_business_glossary_term' = 'Land Application Site ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `agronomic_rate_justification` SET TAGS ('dbx_business_glossary_term' = 'Agronomic Rate Justification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'surface_spread|injection|incorporation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_rate_dry_tons_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Application Rate (Dry Tons per Acre)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `applicator_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Applicator Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `arsenic_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Arsenic Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|exceptional_quality');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `buffer_zone_compliant` SET TAGS ('dbx_business_glossary_term' = 'Buffer Zone Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `cadmium_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Cadmium Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `copper_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Copper Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `crop_type` SET TAGS ('dbx_business_glossary_term' = 'Crop Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `cumulative_pollutant_loading_rate_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Pollutant Loading Rate (CPLR) Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `field_acreage` SET TAGS ('dbx_business_glossary_term' = 'Field Acreage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `field_identifier` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `hauler_company_name` SET TAGS ('dbx_business_glossary_term' = 'Hauler Company Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `hauler_company_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `lead_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Lead Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `mercury_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Mercury Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `nickel_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Nickel Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `nitrogen_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Content (Percent)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `pathogen_reduction_method` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Reduction Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `percent_solids` SET TAGS ('dbx_business_glossary_term' = 'Percent Solids');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `plant_available_nitrogen_lbs_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Plant Available Nitrogen (Pounds per Acre)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `selenium_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Selenium Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `site_access_restriction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Site Access Restriction End Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `site_access_restriction_period_days` SET TAGS ('dbx_business_glossary_term' = 'Site Access Restriction Period (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `site_access_restriction_required` SET TAGS ('dbx_business_glossary_term' = 'Site Access Restriction Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `total_dry_tons_applied` SET TAGS ('dbx_business_glossary_term' = 'Total Dry Tons Applied');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `total_wet_tons_applied` SET TAGS ('dbx_business_glossary_term' = 'Total Wet Tons Applied');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `vector_attraction_reduction_method` SET TAGS ('dbx_business_glossary_term' = 'Vector Attraction Reduction (VAR) Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ALTER COLUMN `zinc_loading_kg_per_hectare` SET TAGS ('dbx_business_glossary_term' = 'Zinc Loading (Kilograms per Hectare)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `sewer_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'pipe|manhole|lateral|junction|cleanout');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `critical_defect_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `defect_codes` SET TAGS ('dbx_business_glossary_term' = 'Defect Codes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `downstream_manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Downstream Manhole Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `estimated_repair_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `estimated_repair_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `flow_condition` SET TAGS ('dbx_business_glossary_term' = 'Flow Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `flow_condition` SET TAGS ('dbx_value_regex' = 'dry|low|medium|high|surcharge');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `fog_accumulation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fats Oils and Grease (FOG) Accumulation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `infiltration_observed_flag` SET TAGS ('dbx_business_glossary_term' = 'Infiltration and Inflow (I&I) Observed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_direction` SET TAGS ('dbx_business_glossary_term' = 'Inspection Direction');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_direction` SET TAGS ('dbx_value_regex' = 'upstream|downstream');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Inspection Length (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'CCTV|sonar|smoke_test|dye_test|visual|laser_profiling');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|reviewed|approved|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Time');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|emergency|post_repair|pre_construction|complaint_driven|regulatory');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `macp_score` SET TAGS ('dbx_business_glossary_term' = 'Manhole Assessment and Certification Program (MACP) Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `operational_defect_flag` SET TAGS ('dbx_business_glossary_term' = 'Operational Defect Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `pacp_score` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Assessment and Certification Program (PACP) Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'no_action|monitor|cleaning|spot_repair|rehabilitation|replacement');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `rehabilitation_method` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `report_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report File Path');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `root_intrusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Intrusion Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `structural_defect_flag` SET TAGS ('dbx_business_glossary_term' = 'Structural Defect Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `upstream_manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Upstream Manhole Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_business_glossary_term' = 'Urgency Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_value_regex' = 'immediate|high|medium|low|routine');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `video_file_path` SET TAGS ('dbx_business_glossary_term' = 'Video File Path');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `collection_system_blockage_id` SET TAGS ('dbx_business_glossary_term' = 'Collection System Blockage ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Response Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responding Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Basin Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `blockage_cause` SET TAGS ('dbx_business_glossary_term' = 'Blockage Cause');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `blockage_number` SET TAGS ('dbx_business_glossary_term' = 'Blockage Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `blockage_severity` SET TAGS ('dbx_business_glossary_term' = 'Blockage Severity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `blockage_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `blockage_type` SET TAGS ('dbx_business_glossary_term' = 'Blockage Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `blockage_type` SET TAGS ('dbx_value_regex' = 'partial|complete');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `clearance_method` SET TAGS ('dbx_business_glossary_term' = 'Clearance Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `clearance_method` SET TAGS ('dbx_value_regex' = 'hydro_jetting|rodding|excavation|chemical_treatment|vacuum_truck|manual_removal');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `clearance_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearance Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `customer_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blockage Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `preventive_maintenance_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Recommendation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `previous_blockage_count` SET TAGS ('dbx_business_glossary_term' = 'Previous Blockage Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `rainfall_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Amount (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `repeat_blockage_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Blockage Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `sso_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `sso_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Occurred Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `sso_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Volume (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `street_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `total_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Duration (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Segment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `backwater_valve_installed_flag` SET TAGS ('dbx_business_glossary_term' = 'Backwater Valve Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `cleanout_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Cleanout Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'gravity|grinder_pump|ejector_pump|low_pressure|vacuum');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `fog_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Fats Oils and Grease (FOG) Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `grinder_pump_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Grinder Pump Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `grinder_pump_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Grinder Pump Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `grinder_pump_model` SET TAGS ('dbx_business_glossary_term' = 'Grinder Pump Model');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `grinder_pump_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Grinder Pump Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `industrial_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `iup_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `lateral_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Lateral Diameter in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `lateral_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Lateral Length in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `lateral_pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Lateral Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'utility|customer|shared|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility|private|shared|municipal|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `parcel_identifier` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost in United States Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_connection_number` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_state_province` SET TAGS ('dbx_business_glossary_term' = 'Service State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|capped|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sso_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) History Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `primary_original_submission_dmr_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `bypass_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Bypass Event Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional_compliant');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `correction_due_date` SET TAGS ('dbx_business_glossary_term' = 'Correction Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `cso_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Combined Sewer Overflow (CSO) Event Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `days_late` SET TAGS ('dbx_business_glossary_term' = 'Days Late');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `deficiency_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'DMR Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `facility_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `maximum_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `netdmr_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'NetDMR Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `no_discharge_flag` SET TAGS ('dbx_business_glossary_term' = 'No Discharge Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `nodi_flag` SET TAGS ('dbx_business_glossary_term' = 'No Discharge (NODI) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `nodi_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Notice of Discharge Intent (NODI) Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `outfall_count` SET TAGS ('dbx_business_glossary_term' = 'Outfall Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `outfall_identifier` SET TAGS ('dbx_business_glossary_term' = 'Outfall Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `parameter_count` SET TAGS ('dbx_business_glossary_term' = 'Parameter Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_email` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Email');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `resubmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `signatory_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Signatory Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `signatory_date` SET TAGS ('dbx_business_glossary_term' = 'Signatory Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `sso_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'NetDMR|paper|email|portal|hand_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'DMR Submission Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|deficient|rejected|resubmitted');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'original|amended|corrected|resubmission');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `total_flow_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Total Flow Volume Million Gallons (MG)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `total_parameter_exceedances` SET TAGS ('dbx_business_glossary_term' = 'Total Parameter Exceedances');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `upset_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Upset Event Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` SET TAGS ('dbx_association_edges' = 'wastewater.wwtp,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `facility_grant_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Grant Allocation Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Grant Allocation - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Grant Allocation - Wwtp Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `eligible_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Categories');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure to Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `facility_project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Project Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `facility_project_manager_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `last_drawdown_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drawdown Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `matching_funds_contributed` SET TAGS ('dbx_business_glossary_term' = 'Matching Funds Contributed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `next_reporting_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reporting Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` SET TAGS ('dbx_association_edges' = 'wastewater.sewer_network,asset.work_order');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `sewer_repair_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Repair Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Repair - Sewer Network Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Repair - Work Order Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `defect_codes_addressed` SET TAGS ('dbx_business_glossary_term' = 'Defect Codes Addressed');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `defect_codes_addressed` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `post_repair_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Post-Repair Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `pre_repair_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Pre-Repair Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `repair_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `repair_cost_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost Allocation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `repair_end_station` SET TAGS ('dbx_business_glossary_term' = 'Repair End Station');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `repair_method` SET TAGS ('dbx_business_glossary_term' = 'Repair Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `repair_segment_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Repair Segment Length');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `repair_start_station` SET TAGS ('dbx_business_glossary_term' = 'Repair Start Station');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` SET TAGS ('dbx_association_edges' = 'wastewater.wwtp,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `facility_vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Vendor Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Vendor Contract - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Vendor Contract - Wwtp Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `emergency_contact_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Available');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `primary_outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Outfall Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `primary_outfall_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `actual_flow_cms` SET TAGS ('dbx_business_glossary_term' = 'Actual Flow Cms');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_code` SET TAGS ('dbx_business_glossary_term' = 'Outfall Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `design_capacity_cms` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Cms');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `discharge_point_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation Meters');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `hydraulic_retention_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Retention Time Seconds');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `is_monitored` SET TAGS ('dbx_business_glossary_term' = 'Is Monitored');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `is_public_access` SET TAGS ('dbx_business_glossary_term' = 'Is Public Access');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_name` SET TAGS ('dbx_business_glossary_term' = 'Outfall Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Npdes Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_type` SET TAGS ('dbx_business_glossary_term' = 'Outfall Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `permit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `water_quality_parameter` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Parameter');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_id` SET TAGS ('dbx_business_glossary_term' = 'Grease Interceptor Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `upstream_grease_interceptor_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Grease Interceptor Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `upstream_grease_interceptor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Capacity Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `diameter_inch` SET TAGS ('dbx_business_glossary_term' = 'Diameter Inch');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `interceptor_type` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Length Ft');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Days');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `land_application_site_id` SET TAGS ('dbx_business_glossary_term' = 'Land Application Site Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `parent_land_application_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Land Application Site Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `parent_land_application_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `area_acres` SET TAGS ('dbx_business_glossary_term' = 'Area Acres');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `county` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `land_application_site_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `groundwater_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Depth Feet');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `is_public_access` SET TAGS ('dbx_business_glossary_term' = 'Is Public Access');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `land_use_category` SET TAGS ('dbx_business_glossary_term' = 'Land Use Category');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `last_application_date` SET TAGS ('dbx_business_glossary_term' = 'Last Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `max_application_rate_tons_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Max Application Rate Tons Per Acre');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `next_allowed_application_date` SET TAGS ('dbx_business_glossary_term' = 'Next Allowed Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `owner_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `permit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `site_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `soil_type` SET TAGS ('dbx_business_glossary_term' = 'Soil Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `land_application_site_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `water_body_proximity_miles` SET TAGS ('dbx_business_glossary_term' = 'Water Body Proximity Miles');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` SET TAGS ('dbx_subdomain' = 'watershed_management');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `preceding_storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Storm Event Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `preceding_storm_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `affected_area_sqkm` SET TAGS ('dbx_business_glossary_term' = 'Affected Area Sqkm');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `alert_level` SET TAGS ('dbx_business_glossary_term' = 'Alert Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `storm_event_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `flood_depth_cm` SET TAGS ('dbx_business_glossary_term' = 'Flood Depth Cm');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `forecast_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `forecasted_precipitation_mm` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Precipitation Mm');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `is_flooding` SET TAGS ('dbx_business_glossary_term' = 'Is Flooding');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `location_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `nwp_model_used` SET TAGS ('dbx_business_glossary_term' = 'Nwp Model Used');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `peak_flow_cfs` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow Cfs');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `storm_event_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `total_precipitation_mm` SET TAGS ('dbx_business_glossary_term' = 'Total Precipitation Mm');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`storm_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` SET TAGS ('dbx_subdomain' = 'collection_system');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `sses_study_id` SET TAGS ('dbx_business_glossary_term' = 'Sses Study Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `predecessor_sses_study_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Sses Study Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `predecessor_sses_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `author_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `sses_study_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `sponsor_organization` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `sses_study_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `study_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Study Area Acres');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `study_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Study Cost Usd');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `study_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` SET TAGS ('dbx_subdomain' = 'watershed_management');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` SET TAGS ('dbx_wastewater_core' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`watershed` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_subdomain' = 'watershed_management');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sewershed Basin Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `parent_sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sewershed Basin Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `parent_sewershed_basin_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `watershed_id` SET TAGS ('dbx_business_glossary_term' = 'Watershed Id');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Area Sq Km');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `average_annual_precipitation_mm` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Precipitation Mm');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `average_annual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Temperature C');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `average_flow_cfs` SET TAGS ('dbx_business_glossary_term' = 'Average Flow Cfs');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Basin Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Basin Manager Email');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Basin Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Basin Manager Phone');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_manager_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_name` SET TAGS ('dbx_business_glossary_term' = 'Basin Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `basin_type` SET TAGS ('dbx_business_glossary_term' = 'Basin Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `design_capacity_cfs` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Cfs');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `downstream_basin_codes` SET TAGS ('dbx_business_glossary_term' = 'Downstream Basin Codes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `flood_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Flood Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `impervious_percent` SET TAGS ('dbx_business_glossary_term' = 'Impervious Percent');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `infiltration_rate_lps` SET TAGS ('dbx_business_glossary_term' = 'Infiltration Rate Lps');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `land_use` SET TAGS ('dbx_business_glossary_term' = 'Land Use');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Npdes Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `peak_flow_cfs` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow Cfs');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `pollutant_load_kg_per_day` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Load Kg Per Day');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `soil_type` SET TAGS ('dbx_business_glossary_term' = 'Soil Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `upstream_basin_codes` SET TAGS ('dbx_business_glossary_term' = 'Upstream Basin Codes');
