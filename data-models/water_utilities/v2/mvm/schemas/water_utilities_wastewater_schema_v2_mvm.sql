-- Schema for Domain: wastewater | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`wastewater` COMMENT 'Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` (
    `sewer_network_id` BIGINT COMMENT 'Unique identifier for the sewer network segment. Primary key for the sewer network master topology. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'National Pollutant Discharge Elimination System (NPDES) permit identifier if this segment is subject to specific discharge monitoring or CSO/SSO reporting requirements. Ref: EPA SDWA.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` (
    `wwtp_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each wwtp record in the wastewater domain.',
    `registry_id` BIGINT COMMENT 'Asset registry. Ref: EPA SDWA.',
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
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Effluent discharge events occur at permitted discharge points that are registered locations. Role-prefix discharge_ used because effluent_discharge_event has inline lat/lon but no location FK. Named',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: NPDES regulations require receiving water body sampling when effluent discharge or bypass events occur. Linking effluent_discharge_event to the triggered water_sample supports DMR reporting and enviro',
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
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this effluent monitoring is conducted. Ref: Sensus AMI.',
    `effluent_discharge_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.effluent_discharge_event. Business justification: effluent_parameter_result represents water quality measurements taken during specific discharge events. The product description states Transactional record of WWTP effluent discharge events and assoc. Ref: Sensus AMI.',
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
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: SSO events occur at specific geographic locations registered in asset.location. location_address, location_latitude, location_longitude on sso_event are denormalized location data. Named process: SSO ',
    `manhole_id` BIGINT COMMENT 'Identifier of the manhole where the overflow occurred, if applicable. Links to asset registry. Ref: EPA SDWA.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: An SSO event occurs at a specific location within the sewer collection network. Linking sso_event to the sewer_network segment where the overflow occurred enables network-level SSO analysis, I&I monit',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the infrastructure asset (pipe, pump station, lift station) associated with the overflow event. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: SSO events require immediate water quality sampling of affected surface waters or impacted areas per state/EPA regulations to assess public health risk and pathogen contamination. Links spill event to. Ref: EPA SDWA.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` (
    `industrial_user_permit_id` BIGINT COMMENT 'Unique identifier for the industrial user permit record. Primary key for the IUP registry. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial user permits are issued under the WWTPs NPDES pretreatment compliance permit authority (40 CFR Part 403). Pretreatment coordinators must link each IUP to the authorizing compliance permit ',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Industrial users are commercial/industrial customers with billing accounts. Pretreatment program management requires linking permits to customer accounts for billing industrial wastewater charges, tra. Ref: EPA SDWA.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Industrial pretreatment permits require discharge volume monitoring for compliance and flow-based surcharge calculations. Utilities install dedicated wastewater discharge meters at industrial faciliti. Ref: EPA SDWA.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Industrial user permits are tied to specific facility locations for inspection scheduling, compliance tracking, and enforcement actions. Asset location integration enables spatial analysis of pretreat. Ref: EPA SDWA.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Pretreatment program regulations require each industrial user permit to have an associated monitoring/sampling schedule. Linking industrial_user_permit to sampling_schedule enables tracking of IU comp',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Industrial User Permits are issued under the pretreatment program administered by a specific WWTP — the receiving facility that accepts the industrial discharge. Linking industrial_user_permit to wwtp',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` (
    `biosolids_batch_id` BIGINT COMMENT 'Unique identifier for the biosolids production batch. Primary key for the biosolids batch record. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this biosolids batch was produced. Links batch to permit limits and reporting requirements. Ref: EPA SDWA.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Biosolids disposition sites (land application fields, composting facilities, landfills) are registered locations. disposition_site_name is a denormalized location reference. Role-prefix disposition_',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` (
    `sewer_service_connection_id` BIGINT COMMENT 'Unique identifier for the sewer service connection (lateral) record. Primary key for this entity. Ref: EPA SDWA.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with this sewer service connection. Links the physical infrastructure to the customer billing relationship. Ref: EPA SDWA.',
    `industrial_user_permit_id` BIGINT COMMENT 'Foreign key linking to wastewater.industrial_user_permit. Business justification: sewer_service_connection has industrial_user_flag and iup_permit_number attributes, indicating a denormalized reference to the industrial_user_permit table. Normalizing this with a proper FK industria',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Service connection service address fields are denormalized location data already managed in asset.location. Named process: service connection GIS management and field crew dispatch require standardize',
    `manhole_id` BIGINT COMMENT 'Reference to the nearest manhole or connection point where the service lateral ties into the public sewer system, if applicable. Ref: EPA SDWA.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Water utilities coordinate water and sewer service at customer premises. Service activation/deactivation, combined billing, and account management require linking the water meter to the corresponding. Ref: EPA SDWA.',
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
    `service_connection_number` STRING COMMENT 'Business identifier for the sewer service connection, typically used in field operations, customer service, and billing. May follow utility-specific numbering conventions. Ref: EPA SDWA.',
    `service_status` STRING COMMENT 'Current operational status of the sewer service connection. Active connections are in use; inactive connections are temporarily out of service; abandoned connections are permanently closed; capped connections are physically sealed; pending activation connections are installed but not yet in service. Ref: EPA SDWA.. Valid values are `active|inactive|abandoned|capped|pending_activation`',
    `sso_history_flag` BOOLEAN COMMENT 'Indicates whether this service connection has a documented history of sanitary sewer overflows or backups. Used for risk assessment and targeted maintenance programs. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service connection record was last modified. Used for change tracking, data quality monitoring, and audit trails. Ref: EPA SDWA.',
    CONSTRAINT pk_sewer_service_connection PRIMARY KEY(`sewer_service_connection_id`)
) COMMENT 'Master record for each individual sewer service connection (lateral) linking a customer premise to the public sewer main including connection address, parcel identifier, lateral pipe material, diameter, length, connection type (gravity, grinder pump), installation date, condition, and service status (active, inactive, abandoned). Bridges the wastewater network topology to customer service accounts.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_effluent_discharge_event_id` FOREIGN KEY (`effluent_discharge_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event`(`effluent_discharge_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_domain' = 'wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'NPDES (National Pollutant Discharge Elimination System) Permit ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Identifier');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'WWTP Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_parameter_result_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Parameter Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Metering Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `biosolids_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Batch Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Disposition Location Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Metering Meter Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_connection_number` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|capped|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sso_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) History Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
