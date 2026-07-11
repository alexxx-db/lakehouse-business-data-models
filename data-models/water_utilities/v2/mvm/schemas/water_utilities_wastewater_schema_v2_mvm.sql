-- Schema for Domain: wastewater | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`wastewater` COMMENT 'Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` (
    `sewer_network_id` BIGINT COMMENT 'Unique identifier for the sewer network segment. Primary key for the sewer network master topology.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Major sewer segments meeting capitalization thresholds are tracked as fixed assets for GASB 34 depreciation, net book value calculation, rate base determination, and asset valuation for rate cases.',
    `compliance_permit_id` BIGINT COMMENT 'National Pollutant Discharge Elimination System (NPDES) permit identifier if this segment is subject to specific discharge monitoring or CSO/SSO reporting requirements.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Sewer rehabilitation projects specify pipe, lining, and grout materials by material master records. Linking segments to installed materials enables accurate inventory forecasting for capital projects',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Sewer network segments require a location record in the asset location hierarchy for GIS-based field dispatch, capital planning, and spatial asset management. A water utility asset manager expects eve',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Sewer network segments are assigned PM schedules for cleaning frequency, CCTV inspection cycles, and root control programs. PM schedules drive automated work order generation for sewer maintenance — a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Sewer segments are installed/rehabilitated via CIP projects. Link enables as-built drawing retrieval, installation year validation, capitalization tracking, and condition assessment baseline establish',
    `wwtp_id` BIGINT COMMENT 'Identifier of the Wastewater Treatment Plant (WWTP) that receives flow from this sewer segment. Supports load allocation and treatment capacity planning.',
    `asset_tag` STRING COMMENT 'Physical asset tag or barcode identifier affixed to the segment or associated manhole for field identification and work order tracking in IBM Maximo.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily wastewater flow through the segment in Million Gallons per Day (MGD). Used for load balancing and treatment plant influent forecasting.',
    `condition_grade` STRING COMMENT 'Current physical condition assessment of the sewer segment based on CCTV inspection, PACP (Pipeline Assessment and Certification Program) scoring, or field evaluation. Drives maintenance and replacement decisions.. Valid values are `excellent|good|fair|poor|critical`',
    `coordinate_system` STRING COMMENT 'Spatial reference system identifier (e.g., EPSG code) for the GIS geometry. Ensures spatial data interoperability and accurate georeferencing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sewer network record was first created in the system. Supports data lineage and audit trail requirements.',
    `criticality_score` STRING COMMENT 'Risk-based criticality rating (typically 1-100 scale) reflecting consequence of failure, service impact, and environmental risk. Drives capital investment prioritization.',
    `data_source` STRING COMMENT 'Identifier of the source system or data collection method that provided this record (e.g., Esri ArcGIS, field survey, as-built drawings, CCTV inspection).',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Hydraulic design capacity of the sewer segment in Million Gallons per Day (MGD). Used for capacity utilization analysis and growth planning.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the sewer pipe in inches. Key hydraulic parameter for capacity analysis and flow modeling in Innovyze InfoWater.',
    `downstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the inside bottom of the pipe at the downstream end in feet above mean sea level. Used with upstream invert to calculate slope and hydraulic capacity.',
    `easement_required_flag` BOOLEAN COMMENT 'Indicates whether a legal easement is required for utility access to the sewer segment. Critical for maintenance planning and right-of-way management.',
    `fog_risk_flag` BOOLEAN COMMENT 'Indicates whether the segment is at elevated risk for FOG (Fats, Oils, and Grease) blockages based on upstream land use (restaurants, food processing). Drives preventive maintenance frequency.',
    `gis_geometry_wkt` STRING COMMENT 'Well-Known Text (WKT) representation of the sewer segment spatial geometry (typically LINESTRING). Authoritative spatial reference for GIS mapping and network analysis in Esri ArcGIS.',
    `hydrogen_sulfide_risk_flag` BOOLEAN COMMENT 'Indicates elevated risk of hydrogen sulfide gas generation and corrosion. Common in force mains and long gravity sewers with low flow velocity.',
    `installation_year` STRING COMMENT 'Year the sewer segment was originally installed. Key attribute for asset age analysis, depreciation schedules, and capital improvement program (CIP) prioritization.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent CCTV or physical inspection of the sewer segment. Supports compliance with regulatory inspection frequency requirements and condition assessment programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this sewer network record. Enables change tracking and data quality monitoring.',
    `length_feet` DECIMAL(18,2) COMMENT 'Physical length of the sewer segment in feet measured from upstream to downstream node. Used for asset inventory valuation and hydraulic calculations.',
    `lining_installation_date` DATE COMMENT 'Date when pipe lining or rehabilitation was completed. Resets the effective age for condition assessment and extends asset useful life.',
    `lining_type` STRING COMMENT 'Type of trenchless rehabilitation lining applied to the sewer segment. CIPP (Cured-in-Place Pipe) is a common method for structural renewal without excavation.. Valid values are `none|cipp|spray_on|slip_lining|grout`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on regulatory mandates, risk-based prioritization, or preventive maintenance cycles.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, historical context, or field observations relevant to the sewer segment.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the sewer segment in the collection network. Active segments are in service; abandoned segments are out of service but not removed.. Valid values are `active|inactive|abandoned|planned|under_construction`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the sewer segment. Determines maintenance responsibility, regulatory jurisdiction, and capital funding eligibility.. Valid values are `utility_owned|private|municipal|joint`',
    `peak_flow_gpm` DECIMAL(18,2) COMMENT 'Maximum observed or modeled flow rate in Gallons per Minute (GPM) during peak wet weather or high demand periods. Critical for SSO risk assessment.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the sewer segment in US Dollars. Used for asset valuation, insurance, and capital improvement program (CIP) budgeting.',
    `root_intrusion_flag` BOOLEAN COMMENT 'Indicates whether tree root intrusion has been observed or is a known risk for this segment. Common in older vitrified clay and concrete pipes.',
    `segment_identifier` STRING COMMENT 'Externally-known unique identifier for the sewer segment used in GIS systems, field operations, and regulatory reporting. Aligns with Esri ArcGIS feature identifiers.',
    `segment_type` STRING COMMENT 'Classification of the sewer segment by conveyance method and network hierarchy. Gravity sewers use slope for flow; force mains use pumps; interceptors and trunk lines are major collectors.. Valid values are `gravity_sewer|force_main|interceptor|trunk_line|lateral|service_connection`',
    `slope_percent` DECIMAL(18,2) COMMENT 'Gradient of the sewer pipe expressed as a percentage. Critical for gravity sewer hydraulic performance and self-cleansing velocity calculations.',
    `sso_history_count` STRING COMMENT 'Number of Sanitary Sewer Overflow (SSO) events recorded for this segment. High counts trigger regulatory scrutiny and prioritize capacity upgrades.',
    `traffic_impact_level` STRING COMMENT 'Assessment of traffic disruption risk if the segment requires excavation or repair. High-traffic segments require special permitting and coordination.. Valid values are `none|low|medium|high|critical`',
    `upstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the inside bottom of the pipe at the upstream end in feet above mean sea level. Essential for hydraulic grade line analysis and I&I (Inflow and Infiltration) assessment.',
    CONSTRAINT pk_sewer_network PRIMARY KEY(`sewer_network_id`)
) COMMENT 'Master topology of the wastewater collection and conveyance network including gravity sewers, force mains, interceptors, and trunk lines. Captures pipe material, diameter, length, slope, invert elevations, installation year, condition grade, and GIS geometry. Each segment is individually identifiable by upstream/downstream manhole nodes. Serves as the authoritative spatial and hydraulic reference for the sewer system, aligned with Esri ArcGIS Utility Network and Innovyze InfoSWMM/ICM hydraulic models.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` (
    `manhole_id` BIGINT COMMENT 'Unique identifier for the manhole structure in the wastewater collection system. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Manholes meeting capitalization policy thresholds are capitalized as fixed assets for GASB compliance, depreciation tracking, condition-based valuation, and comprehensive asset register maintenance.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Manholes require a location record in the asset location hierarchy for field crew dispatch, confined space entry planning, and GIS-based asset management. Every utility asset management system links m',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Manholes are assigned PM schedules for cleaning, inspection, and cover/frame maintenance. PM schedules drive automated work order generation for manhole maintenance programs — standard EAM practice fo',
    `basin_code` STRING COMMENT 'Code identifying the drainage basin or sewershed that this manhole serves. Used for hydraulic modeling and capacity planning.',
    `city` STRING COMMENT 'City or municipality where the manhole is located. Used for jurisdictional reporting and service area analysis.',
    `confined_space_flag` BOOLEAN COMMENT 'Indicates whether the manhole is classified as a permit-required confined space under OSHA regulations. True if the manhole requires a confined space entry permit; false otherwise. Critical for worker safety and entry procedures.',
    `cover_type` STRING COMMENT 'Type of cover installed on the manhole. Watertight covers prevent Inflow and Infiltration (I&I); bolted covers provide security; vented covers allow gas release; traffic-rated covers support vehicular loads.. Valid values are `standard|watertight|bolted|vented|traffic_rated|solid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this manhole record was first created in the system. Used for data lineage and audit trail.',
    `depth_feet` DECIMAL(18,2) COMMENT 'Total depth of the manhole from rim elevation to invert elevation, measured in feet. Critical for determining access requirements, safety protocols, and confined space entry procedures.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the manhole structure measured in inches. Standard diameters are 48 inches (4 feet) or 60 inches (5 feet) for personnel access.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area (DMA) or pressure zone to which this manhole belongs. Used for network segmentation and performance monitoring.',
    `gis_feature_reference` STRING COMMENT 'Unique identifier for the manhole feature in the utilitys GIS system. Used to link asset management data with spatial data layers in ArcGIS or other GIS platforms.',
    `inflow_infiltration_flag` BOOLEAN COMMENT 'Indicates whether the manhole has been identified as a source of Inflow and Infiltration (I&I) into the wastewater collection system. True if I&I has been observed or suspected; false otherwise. Used for prioritizing I&I reduction programs.',
    `invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the lowest point inside the manhole where wastewater flows, measured in feet above a reference datum. Critical for calculating pipe slopes and flow gradients.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the manhole. Used to track inspection frequency compliance and schedule future inspections.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance activity was performed on the manhole. Includes cleaning, repairs, or rehabilitation work.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the manhole location in decimal degrees. Used for GIS mapping, spatial analysis, and field navigation.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the manhole location in decimal degrees. Used for GIS mapping, spatial analysis, and field navigation.',
    `macp_score` STRING COMMENT 'Numerical condition score assigned using the NASSCO Manhole Assessment and Certification Program (MACP) methodology. Higher scores indicate worse condition. Used for prioritizing rehabilitation and capital planning.',
    `manhole_number` STRING COMMENT 'Business identifier or asset tag assigned to the manhole for field operations and maintenance tracking. Typically displayed on manhole covers or in field maps.',
    `manhole_status` STRING COMMENT 'Current operational status of the manhole in the wastewater collection system lifecycle. Active manholes are in service; inactive are temporarily out of service; abandoned are no longer used but not removed; planned are in design phase; under construction are being installed; decommissioned are permanently removed from service.. Valid values are `active|inactive|abandoned|planned|under_construction|decommissioned`',
    `manhole_type` STRING COMMENT 'Classification of the manhole based on its function in the wastewater collection network. Standard manholes provide access; drop manholes accommodate elevation changes; junction manholes connect multiple pipes; terminal manholes mark the end of a line; diversion manholes route flow; metering manholes house flow measurement equipment. [ENUM-REF-CANDIDATE: standard|drop|junction|terminal|diversion|metering|special — 7 candidates stripped; promote to reference product]',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next inspection of the manhole. Calculated based on condition rating, criticality, and regulatory requirements.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or special instructions related to the manhole. May include access restrictions, safety concerns, or historical information.',
    `ownership` STRING COMMENT 'Entity that owns the manhole asset. Utility-owned assets are maintained by the water utility; municipal assets may be owned by the city; private assets are on private property; joint ownership involves shared responsibility.. Valid values are `utility|municipal|private|state|federal|joint`',
    `postal_code` STRING COMMENT 'Postal code of the manhole location. Used for geographic segmentation and service area mapping.',
    `rim_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the manhole rim (top of cover) above a reference datum, typically mean sea level, measured in feet. Used for hydraulic modeling and flood risk assessment.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the manhole is equipped with SCADA monitoring equipment for real-time level, flow, or alarm monitoring. True if SCADA-monitored; false otherwise.',
    `sso_history_flag` BOOLEAN COMMENT 'Indicates whether the manhole has a history of Sanitary Sewer Overflows (SSO). True if SSO events have occurred at this location; false otherwise. Used for identifying high-risk locations and prioritizing capacity improvements.',
    `state_province` STRING COMMENT 'State or province where the manhole is located. Used for regulatory reporting to state environmental agencies.',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the manhole is located. Used for work order dispatch and public communication.',
    `traffic_load_rating` STRING COMMENT 'Load rating classification of the manhole cover based on expected vehicular traffic. Light duty for pedestrian areas; medium duty for residential streets; heavy duty for arterial roads; extra heavy duty for highways and industrial areas.. Valid values are `light_duty|medium_duty|heavy_duty|extra_heavy_duty`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this manhole record was last updated in the system. Used for data lineage and audit trail.',
    CONSTRAINT pk_manhole PRIMARY KEY(`manhole_id`)
) COMMENT 'Master record for each manhole structure in the wastewater collection system including rim elevation, invert elevation, depth, material, cover type, condition rating, GIS coordinates, and inspection status. Manholes are key access and junction points in the gravity sewer network and are individually tracked for maintenance and I&I assessment.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` (
    `wwtp_id` BIGINT COMMENT 'Unique identifier for the wastewater treatment plant facility. Primary key for the WWTP master registry.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: WWTP facilities are major capital assets requiring fixed asset tracking for GASB reporting, depreciation calculation, net book value determination, rate base inclusion, and regulatory asset valuation.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Every WWTP operates under an NPDES compliance permit — the foundational regulatory relationship in wastewater. This FK enables permit-driven reporting, inspection scheduling, and DMR generation. npdes',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: WWTPs maintain on-site chemical and spare parts inventory requiring storage location tracking for regulatory chemical storage compliance, inventory reorder triggers, and stock audits. Water-utilities',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: WWTPs require a location record in the asset location hierarchy for facility management, field operations coordination, and regulatory reporting. Every utility asset management system links treatment ',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: WWTPs have facility-level PM schedules for process equipment maintenance, regulatory compliance activities, and safety inspections. PM schedules drive automated work order generation for treatment pla',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: SDWA source water assessment regulations require utilities to identify when a WWTP discharges into a water body that is also a drinking water source. This link enables cross-domain source water protec',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: WWTPs are regulated by a specific agency (EPA region, state primacy agency). Knowing which agency regulates each WWTP is essential for inspection scheduling, enforcement tracking, and regulatory repor',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: WWTPs are delivered/upgraded via CIP projects. Linking enables asset lifecycle tracking, capitalization date validation, warranty management, and regulatory permit compliance tied to project completio',
    `address_line_1` STRING COMMENT 'Primary street address of the wastewater treatment plant facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, suite, or unit designation.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Actual average daily flow processed by the facility over the most recent reporting period, measured in million gallons per day. Used for capacity utilization analysis.',
    `biosolids_class` STRING COMMENT 'EPA classification of biosolids quality based on pathogen reduction and vector attraction reduction requirements.. Valid values are `class_a|class_b|exceptional_quality|not_applicable`',
    `biosolids_management_method` STRING COMMENT 'Primary method used for disposal or beneficial reuse of biosolids (treated sewage sludge) generated by the treatment process.. Valid values are `land_application|incineration|landfill|composting|beneficial_reuse`',
    `city` STRING COMMENT 'City or municipality where the facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the facility was originally placed into service and began treating wastewater.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the facility with respect to NPDES permit limits and reporting requirements.. Valid values are `compliant|non_compliant|consent_decree|administrative_order`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the facility location.. Valid values are `USA|CAN|MEX`',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum rated treatment capacity of the facility in million gallons per day as designed and permitted. Critical for capacity planning and regulatory compliance.',
    `disinfection_method` STRING COMMENT 'Primary disinfection technology used to reduce pathogen levels in treated effluent before discharge.. Valid values are `chlorine|uv|ozone|none`',
    `effluent_discharge_point` STRING COMMENT 'Geographic or infrastructure identifier for the outfall location where treated effluent is discharged from the facility.',
    `energy_consumption_kwh_per_mg` DECIMAL(18,2) COMMENT 'Average energy intensity of the treatment process measured in kilowatt-hours per million gallons treated. Key performance indicator for operational efficiency.',
    `facility_email` STRING COMMENT 'Primary email address for facility operations and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_phone` STRING COMMENT 'Primary contact phone number for the wastewater treatment plant operations center.',
    `facility_type` STRING COMMENT 'Classification of the wastewater treatment facility based on service area and ownership model.. Valid values are `municipal|industrial|combined|satellite`',
    `gis_feature_reference` STRING COMMENT 'Unique identifier for the facility in the enterprise GIS system, enabling spatial analysis and network modeling.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or compliance audit conducted by the primacy agency.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major capital improvement or process upgrade to the facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility location in decimal degrees (WGS84 datum).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility location in decimal degrees (WGS84 datum).',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or facility-specific information not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current operational state of the wastewater treatment plant in its lifecycle.. Valid values are `active|inactive|standby|decommissioned|under_construction`',
    `operator_certification_level` STRING COMMENT 'Minimum operator certification level or class required to operate this facility (e.g., Class I, Class II, Class III, Class IV).',
    `operator_certification_required` BOOLEAN COMMENT 'Indicates whether state-certified operators are required to manage this facility per regulatory requirements.',
    `peak_flow_mgd` DECIMAL(18,2) COMMENT 'Maximum instantaneous or daily flow capacity the facility can handle during wet weather or peak demand events.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility location.',
    `receiving_water_body` STRING COMMENT 'Name of the river, stream, lake, ocean, or other water body that receives the treated effluent discharge.',
    `receiving_water_classification` STRING COMMENT 'Regulatory classification of the receiving water body (e.g., Class A, Class B, impaired, sensitive) that determines discharge limits.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last modified in the system.',
    `scada_system_reference` STRING COMMENT 'Identifier linking this facility to the SCADA system for real-time process monitoring and control data integration.',
    `state_province` STRING COMMENT 'State or province code where the facility is located (two-letter abbreviation for US states).',
    `treatment_level` STRING COMMENT 'Highest level of treatment provided by the facility process train, indicating the degree of pollutant removal achieved.. Valid values are `preliminary|primary|secondary|tertiary|advanced`',
    `treatment_process_description` STRING COMMENT 'Detailed description of the treatment process train including primary, secondary, and tertiary treatment technologies employed (e.g., activated sludge, trickling filter, membrane bioreactor, UV disinfection).',
    CONSTRAINT pk_wwtp PRIMARY KEY(`wwtp_id`)
) COMMENT 'Master record for each Wastewater Treatment Plant (WWTP) or Sewage Treatment Plant (STP) including facility name, NPDES permit number, design capacity (MGD), actual average daily flow, treatment process train (primary, secondary, tertiary), effluent discharge point, receiving water body, regulatory jurisdiction, and operational status. The authoritative facility registry for wastewater treatment operations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` (
    `effluent_discharge_event_id` BIGINT COMMENT 'Unique identifier for the effluent discharge event record. Primary key for tracking individual discharge occurrences from WWTP outfalls.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the NPDES permit under which this discharge event is authorized.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Discharge events are associated with specific outfall structures and discharge point assets registered in the asset registry. Role-prefix discharge_ used because effluent_discharge_event may referen',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: NPDES regulations require water sampling at the discharge point during effluent discharge events (especially bypasses) to assess receiving water body impact. Compliance officers and regulators expect ',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: NPDES/DMR regulatory compliance requires identifying the specific flow meter used to measure effluent discharge volume. The measured discharge_volume_mgd and discharge_flow_rate_gpm must be traceable ',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Effluent discharge events, particularly bypasses, represent treatment process failures that must be recorded in the asset failure tracking system for MTBF analysis, root cause investigation, and regul',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Effluent discharge events occur at specific physical discharge points that must reference the asset location hierarchy for NPDES regulatory reporting, environmental impact assessment, and GIS-based di',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Effluent discharge events that exceed permit limits or constitute unauthorized bypasses generate compliance violations. Directly linking discharge events to the resulting compliance_violation enables ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Effluent discharge events (especially bypasses) trigger corrective work orders for equipment repair and process restoration. Linking discharge events to work orders enables regulatory-required correct',
    `wwtp_id` BIGINT COMMENT 'Identifier of the wastewater treatment plant from which the effluent was discharged.',
    `bypass_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of an emergency bypass or unauthorized discharge event, as required by NPDES permit conditions.',
    `bypass_reason_code` STRING COMMENT 'Standardized code indicating the reason for a treatment bypass or emergency discharge (e.g., equipment failure, extreme weather, power outage).',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the discharge event relative to NPDES permit limits. Indicates whether discharge met all permit conditions or resulted in violations.. Valid values are `compliant|non_compliant|pending_review|exceedance|violation`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this discharge event record was first created in the system.',
    `discharge_authorization_number` STRING COMMENT 'External authorization or permit number assigned by the regulatory agency for this discharge event or outfall.',
    `discharge_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the discharge event measured in hours. Calculated from start and end timestamps.',
    `discharge_end_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent discharge event ended. Used to calculate total discharge duration and volume.',
    `discharge_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate of effluent discharge measured in gallons per minute during the event.',
    `discharge_point_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the outfall discharge point in decimal degrees.',
    `discharge_point_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the outfall discharge point in decimal degrees.',
    `discharge_start_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent discharge event began. Critical for calculating discharge duration and compliance with permit limits.',
    `discharge_status` STRING COMMENT 'Current operational status of the discharge event indicating whether it was authorized under permit conditions, an emergency bypass, or an unauthorized release.. Valid values are `authorized|unauthorized|emergency|bypass|planned|unplanned`',
    `discharge_type` STRING COMMENT 'Classification of the discharge event based on operational pattern: continuous flow, intermittent release, batch discharge, or bypass event.. Valid values are `continuous|intermittent|batch|emergency_bypass|planned_bypass`',
    `discharge_volume_mgd` DECIMAL(18,2) COMMENT 'Total volume of treated effluent discharged during this event, measured in million gallons per day. Core metric for NPDES permit compliance and DMR reporting.',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period to which this discharge event will be aggregated for regulatory submission.',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this discharge event data was submitted to the regulatory authority.',
    `dmr_submitted_flag` BOOLEAN COMMENT 'Indicates whether this discharge event has been included in a submitted DMR to the regulatory authority.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this discharge event record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for operational notes, observations, or additional context regarding the discharge event, including any unusual circumstances or corrective actions taken.',
    `operator_certification_number` STRING COMMENT 'State-issued certification number of the operator responsible for monitoring the discharge event.',
    `operator_name` STRING COMMENT 'Name of the certified wastewater treatment plant operator on duty during the discharge event.',
    `permit_limit_applicable_flag` BOOLEAN COMMENT 'Indicates whether NPDES permit discharge limits apply to this specific discharge event. False for emergency bypasses or non-permitted discharges.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during or immediately preceding the discharge event. Relevant for wet weather discharge analysis and CSO/SSO correlation.',
    `receiving_water_body_classification` STRING COMMENT 'Regulatory classification of the receiving water body (e.g., Class A, Class B, impaired waters, sensitive ecosystem) that determines applicable discharge standards.',
    `scada_event_reference` STRING COMMENT 'Identifier linking this discharge event to the corresponding SCADA system event record for process data correlation.',
    `treatment_level_achieved` STRING COMMENT 'Level of wastewater treatment achieved prior to discharge (primary, secondary, tertiary, advanced, or partial treatment during bypass).. Valid values are `primary|secondary|tertiary|advanced|partial|none`',
    `violation_description` STRING COMMENT 'Detailed description of any permit violations or exceedances that occurred during this discharge event, including parameters exceeded and magnitude.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this discharge event resulted in one or more NPDES permit violations or exceedances of discharge limits.',
    `weather_condition` STRING COMMENT 'Description of weather conditions during the discharge event (e.g., dry weather, wet weather, storm event) that may impact discharge characteristics or permit applicability.',
    CONSTRAINT pk_effluent_discharge_event PRIMARY KEY(`effluent_discharge_event_id`)
) COMMENT 'Transactional record of treated effluent discharge events from WWTP outfalls including discharge start/end timestamps, volume discharged, receiving water body, outfall identifier, NPDES permit limit applicability, and discharge authorization status. Core record for NPDES compliance and DMR submission preparation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` (
    `effluent_parameter_result_id` BIGINT COMMENT 'Unique identifier for the effluent parameter measurement result record.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this effluent monitoring is conducted.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Each effluent parameter result measures a specific regulated contaminant. parameter_name and parameter_code are denormalized representations of the contaminant entity. Linking to quality.contaminant n',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: Each effluent parameter result is evaluated against a specific permit limit for compliance determination. permit_limit_value and permit_limit_type are denormalized from contaminant_limit. Linking to q',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Effluent parameter results are associated with specific outfall/discharge assets in the registry for NPDES DMR reporting and asset performance tracking. Role-prefix discharge_ used to distinguish fr',
    `effluent_discharge_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.effluent_discharge_event. Business justification: effluent_parameter_result represents water quality measurements taken during specific discharge events. The product description states Transactional record of WWTP effluent discharge events and assoc',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Effluent parameter results are collected at specific discharge locations in the asset location hierarchy. DMR regulatory submissions require results to be tied to specific permitted discharge location',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Effluent parameter results are measured against specific permit condition limits (numeric_limit, parameter_code in permit_condition). Linking results to the specific permit condition enables automated',
    `sampling_point_id` BIGINT COMMENT 'Reference to the specific outfall or discharge monitoring point where the sample was collected.',
    `analysis_date` DATE COMMENT 'Date when the laboratory analysis was performed on the sample.',
    `analysis_method` STRING COMMENT 'EPA-approved analytical method used to measure the parameter (e.g., EPA 405.1 for BOD, EPA 160.2 for TSS, SM 4500-H+ for pH).',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations of exceedances, corrective actions taken, or other relevant information about the result.',
    `compliance_status` STRING COMMENT 'Indicates whether the measured result meets the NPDES permit limit requirement (pass/fail) or if evaluation is not applicable or pending.. Valid values are `pass|fail|not_applicable|pending_review`',
    `data_validation_status` STRING COMMENT 'Internal validation status of the result data before regulatory submission (draft, validated by supervisor, approved for submission, or rejected).. Valid values are `draft|validated|approved|rejected`',
    `detection_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that the analytical method can reliably detect for this parameter.',
    `dmr_reporting_period` STRING COMMENT 'Year-month (YYYY-MM) of the DMR reporting period to which this result applies.. Valid values are `^d{4}-d{2}$`',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this result was submitted to the regulatory agency.',
    `dmr_submission_status` STRING COMMENT 'Status of the DMR submission that includes this result (pending, submitted to EPA, accepted by EPA, or rejected).. Valid values are `pending|submitted|accepted|rejected`',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which the measured value exceeds the permit limit, calculated as ((measured_value - permit_limit_value) / permit_limit_value) * 100. Null if result is in compliance.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Effluent discharge flow rate in million gallons per day at the time of sample collection, used for mass loading calculations.',
    `laboratory_batch_number` STRING COMMENT 'Laboratory-assigned batch or run number for quality control and traceability purposes.',
    `mass_loading_lbs_per_day` DECIMAL(18,2) COMMENT 'Calculated mass loading of the parameter in pounds per day, derived from concentration and flow rate (concentration * flow * 8.34).',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the parameter measurement as determined by laboratory analysis.',
    `quality_control_flag` BOOLEAN COMMENT 'Indicates the outcome of quality control checks (e.g., duplicate analysis, spike recovery, blank contamination) for this result.',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that the analytical method can reliably quantify with acceptable precision and accuracy.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this effluent parameter result record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this effluent parameter result record was last modified.',
    `regulatory_agency` STRING COMMENT 'Regulatory authority to which this result is reported (EPA or state primacy agency).. Valid values are `EPA|state_primacy_agency`',
    `result_qualifier` STRING COMMENT 'Laboratory qualifier code indicating special conditions of the result (e.g., < for below detection limit, > for above quantitation limit, J for estimated value).',
    `sample_collection_date` DATE COMMENT 'Date when the effluent sample was collected from the discharge point.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the effluent sample was collected, including time zone.',
    `sample_type` STRING COMMENT 'Method by which the effluent sample was collected (e.g., grab sample, 24-hour composite, flow-weighted composite, continuous monitoring).. Valid values are `grab|composite_24hr|composite_flow_weighted|continuous`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the parameter result is expressed (e.g., mg/L for BOD/TSS, MPN/100mL for bacteria, SU for pH). [ENUM-REF-CANDIDATE: mg/L|ug/L|MPN/100mL|CFU/100mL|SU|NTU|percent|umhos/cm — 8 candidates stripped; promote to reference product]',
    `validation_date` DATE COMMENT 'Date when the result was validated and approved for regulatory reporting.',
    CONSTRAINT pk_effluent_parameter_result PRIMARY KEY(`effluent_parameter_result_id`)
) COMMENT 'Transactional record of WWTP effluent discharge events and associated water quality parameter measurements for NPDES compliance monitoring. Captures discharge event details (start/end timestamps, volume, receiving water body, outfall identifier, authorization status) and individual parameter results (BOD, COD, TSS, TDS, pH, ammonia, phosphorus, fecal coliform, E. coli) with measured values, units, permit limits (daily max, monthly avg), compliance status, sampling dates, analysis methods, and laboratory references. Core operational record for NPDES compliance evaluation and DMR submission preparation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` (
    `sso_event_id` BIGINT COMMENT 'Unique identifier for the sanitary sewer overflow event. Primary key.',
    `collection_system_blockage_id` BIGINT COMMENT 'Foreign key linking to wastewater.collection_system_blockage. Business justification: A collection system blockage is a primary cause of SSO events. The collection_system_blockage table has sso_occurred_flag and sso_volume_gallons fields indicating the blockage-to-SSO causal relationsh',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: SSO events must be reported under the facilitys NPDES permit (40 CFR 122.41(l)). The compliance_permit governs SSO reporting requirements, notification deadlines, and volume thresholds. This FK enabl',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: SSO events often originate from or impact specific customer properties (private lateral blockages, illegal connections). Linking to customer account enables tracking customer-caused SSOs, coordinating',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: SSO events are asset failures requiring failure records for root cause analysis, MTBF tracking, and regulatory reporting. The failure_record.sso_event_flag exists but no FK links back to sso_event — t',
    `manhole_id` BIGINT COMMENT 'Identifier of the manhole where the overflow occurred, if applicable. Links to asset registry.',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the infrastructure asset (pipe, pump station, lift station) associated with the overflow event.',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: SSO regulatory notifications must identify impacted water bodies; when those are drinking water sources, treatment facilities must be alerted per EPA SSO reporting rules. This FK replaces the denormal',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: An SSO event occurs at a specific sewer segment in the collection system. Linking sso_event to sewer_network enables direct traceability from overflow events to the pipe segment where the overflow ori',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: SSO events trigger corrective CIP projects (capacity upgrades, rehabilitation). Tracking this relationship is required for EPA consent decree compliance, demonstrating corrective action effectiveness',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: SSO events trigger formal regulatory violations requiring tracking for enforcement, penalties, DMR reporting, and corrective action plans. Essential for SSO consent decree compliance and EPA enforceme',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the work order created for corrective or preventive action related to this SSO event.',
    `cause_category` STRING COMMENT 'Primary category of the root cause of the overflow event. [ENUM-REF-CANDIDATE: blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism|inflow_infiltration|structural_failure|maintenance_activity|unknown — promote to reference product]. Valid values are `blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism`',
    `cause_code` STRING COMMENT 'Detailed cause code identifying the specific reason for the overflow (e.g., grease blockage, root intrusion, pump failure, wet weather overload).',
    `cause_description` STRING COMMENT 'Detailed narrative description of the cause and circumstances of the overflow event.',
    `corrective_action_taken` STRING COMMENT 'Description of immediate corrective actions taken to stop the overflow and mitigate environmental impact (e.g., cleared blockage, repaired pump, deployed vacuum truck).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SSO event record was first created in the system.',
    `discovered_by` STRING COMMENT 'Source or party that discovered and reported the overflow event.. Valid values are `utility_staff|customer_complaint|routine_inspection|scada_alarm|third_party|other`',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the overflow event was first discovered or reported.',
    `dmr_reported` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow event was included in the monthly Discharge Monitoring Report (DMR) submitted under the NPDES permit.',
    `dmr_reporting_period` STRING COMMENT 'Year-month (YYYY-MM) of the DMR reporting period in which this SSO event was included.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the overflow event in minutes, calculated from start to end timestamp.',
    `enforcement_action_taken` STRING COMMENT 'Type of enforcement action taken by regulatory agencies in response to the overflow event.. Valid values are `none|warning|notice_of_violation|consent_order|penalty|other`',
    `estimated_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of untreated or partially treated wastewater discharged during the SSO event, measured in gallons. Critical metric for regulatory reporting and environmental impact assessment.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the sanitary sewer overflow event was stopped or contained.',
    `event_number` STRING COMMENT 'Externally-known business identifier for the SSO event, typically formatted as SSO-YYYY-NNNNNN for regulatory reporting and tracking.. Valid values are `^SSO-[0-9]{4}-[0-9]{6}$`',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the sanitary sewer overflow event began, representing the principal business event time for regulatory reporting.',
    `event_status` STRING COMMENT 'Current lifecycle status of the SSO event in the incident management workflow.. Valid values are `reported|under_investigation|corrective_action_in_progress|resolved|closed`',
    `location_address` STRING COMMENT 'Street address or nearest address to the overflow location for emergency response and regulatory reporting.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the overflow location in decimal degrees for GIS mapping and spatial analysis.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the overflow location in decimal degrees for GIS mapping and spatial analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SSO event record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or comments regarding the overflow event, response, or follow-up actions.',
    `overflow_location_type` STRING COMMENT 'Type of infrastructure asset where the overflow occurred.. Valid values are `manhole|cleanout|pump_station|force_main|gravity_sewer|building_lateral`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by regulatory agencies for the overflow event, in US dollars.',
    `preventive_action_planned` STRING COMMENT 'Description of long-term preventive measures planned to prevent recurrence (e.g., pipe replacement, capacity upgrade, enhanced maintenance).',
    `public_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether public notification (posting, media alert, direct contact) is required based on overflow volume, location, or receiving environment.',
    `public_notification_timestamp` TIMESTAMP COMMENT 'Date and time when public notification was issued regarding the overflow event.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during the 24-hour period preceding the overflow event, used to assess weather-related causation.',
    `reached_surface_water` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow reached a surface water body, triggering enhanced regulatory reporting requirements.',
    `receiving_environment` STRING COMMENT 'Type of environment that received the discharged wastewater: surface water body, storm drainage system, land surface, building interior, or other.. Valid values are `surface_water|storm_drain|land_surface|building_interior|other`',
    `regulatory_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow event meets thresholds requiring notification to state or federal regulatory agencies.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the overflow event was reported to the regulatory agency (EPA, state primacy agency), typically required within 24 hours.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when utility personnel arrived on-site to respond to the overflow event.',
    `responsible_party` STRING COMMENT 'Name or identifier of the utility staff member or contractor responsible for managing the response to the overflow event.',
    `volume_estimation_method` STRING COMMENT 'Method used to determine the spill volume: measured (flow meter), calculated (hydraulic model), or estimated (visual observation).. Valid values are `measured|calculated|estimated`',
    `volume_recovered_gallons` DECIMAL(18,2) COMMENT 'Volume of spilled wastewater that was recovered and returned to the collection system or treatment plant, measured in gallons.',
    `weather_related` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow was caused or exacerbated by wet weather conditions, inflow, or infiltration (I&I).',
    CONSTRAINT pk_sso_event PRIMARY KEY(`sso_event_id`)
) COMMENT 'Transactional record of each Sanitary Sewer Overflow (SSO) event including event date/time, duration, estimated volume spilled, overflow location (manhole or pipe), receiving environment (land, waterway, storm drain), cause code (blockage, capacity exceedance, equipment failure, I&I), corrective actions taken, regulatory notification timestamp, and enforcement status. Mandatory for state and EPA SSO reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` (
    `industrial_user_permit_id` BIGINT COMMENT 'Unique identifier for the industrial user permit record. Primary key for the IUP registry.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial user permits are issued under the WWTPs NPDES pretreatment compliance permit. Linking IU permits to the parent compliance permit enables pretreatment program compliance reporting, DMR aggr',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Industrial pretreatment permits require discharge volume monitoring for compliance and flow-based surcharge calculations. Utilities install dedicated wastewater discharge meters at industrial faciliti',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Industrial user permits are tied to specific facility locations for inspection scheduling, compliance tracking, and enforcement actions. Asset location integration enables spatial analysis of pretreat',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: IU permits are issued by a specific regulatory authority (Control Authority or Approval Authority under pretreatment regulations). issuing_authority is a denormalized text field; a proper FK to regula',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: An Industrial User Permit (IUP) governs discharge from an industrial facility into a specific sewer segment of the collection system. Linking industrial_user_permit to sewer_network enables pretreatme',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Each IUP is issued under the pretreatment program administered by a specific WWTP (the Control Authority). The WWTP receiving the industrial discharge is the regulatory authority for the IUP, and NPDE',
    `bod_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of BOD in milligrams per liter that the industrial user may discharge to the wastewater collection system.',
    `cadmium_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of cadmium in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `categorical_standard_applicable` BOOLEAN COMMENT 'Indicates whether federal categorical pretreatment standards apply to this industrial user based on SIC code and discharge characteristics.',
    `categorical_standard_citation` STRING COMMENT 'Specific CFR citation for the applicable categorical pretreatment standard (e.g., 40 CFR Part 433 for Metal Finishing). Null if non-categorical.',
    `chromium_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total chromium in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `cod_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of COD in milligrams per liter that the industrial user may discharge to the wastewater collection system.',
    `compliance_schedule_final_date` DATE COMMENT 'Final date by which the industrial user must achieve full compliance with all permit discharge limits. Null if no compliance schedule is required.',
    `compliance_schedule_required` BOOLEAN COMMENT 'Indicates whether the permit includes a compliance schedule with milestones for achieving full compliance with discharge limits.',
    `copper_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of copper in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user permit record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the industrial user permit becomes legally binding and enforceable.',
    `expiration_date` DATE COMMENT 'Date on which the industrial user permit expires and must be renewed or reissued. Nullable for indefinite permits subject to periodic review.',
    `flow_limit_gpd` DECIMAL(18,2) COMMENT 'Maximum permitted daily discharge flow rate in gallons per day (GPD) that the industrial user may discharge to the wastewater collection system.',
    `fog_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of FOG in milligrams per liter that the industrial user may discharge. Critical for food service and processing facilities.',
    `inspection_frequency` STRING COMMENT 'Required frequency at which the pretreatment authority will conduct on-site inspections of the industrial facility and pretreatment system.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed`',
    `issuance_date` DATE COMMENT 'Date on which the permit was officially issued by the pretreatment authority.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent on-site inspection conducted by the pretreatment authority.',
    `lead_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of lead in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `mercury_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of mercury in milligrams per liter. Heavy metal limit for dental and medical facilities.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user permit record was last updated in the system.',
    `monitoring_frequency` STRING COMMENT 'Required frequency at which the industrial user must conduct self-monitoring and submit discharge monitoring reports (DMR) to the pretreatment authority.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `naics_code` STRING COMMENT 'Six-digit NAICS code providing additional industry classification for the industrial user.. Valid values are `^d{6}$`',
    `nickel_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of nickel in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `permit_number` STRING COMMENT 'Externally-known unique permit number assigned to the industrial user under the pretreatment program. Business identifier for regulatory tracking and compliance reporting.. Valid values are `^IUP-[A-Z0-9]{6,12}$`',
    `permit_status` STRING COMMENT 'Current lifecycle status of the industrial user permit. Active permits are in force; expired permits require renewal; suspended or revoked permits indicate enforcement action.. Valid values are `active|expired|suspended|revoked|pending_renewal|terminated`',
    `permit_type` STRING COMMENT 'Classification of the permit based on discharge characteristics and regulatory applicability. Categorical users are subject to federal categorical pretreatment standards; non-categorical users are subject to local limits only.. Valid values are `categorical|non-categorical|significant_industrial_user|minor_industrial_user`',
    `ph_maximum` DECIMAL(18,2) COMMENT 'Maximum permitted pH level for industrial discharge. Typically 9.0 to 12.5 per local limits.',
    `ph_minimum` DECIMAL(18,2) COMMENT 'Minimum permitted pH level for industrial discharge. Typically 5.0 to 6.0 per local limits.',
    `pretreatment_required` BOOLEAN COMMENT 'Indicates whether the industrial user is required to install and operate an on-site pretreatment system to meet discharge limits.',
    `pretreatment_system_description` STRING COMMENT 'Description of the on-site pretreatment system installed by the industrial user (e.g., oil-water separator, pH neutralization, metals precipitation). Null if no pretreatment is required.',
    `sic_code` STRING COMMENT 'Four-digit SIC code classifying the industrial users primary business activity. Used to determine categorical pretreatment standard applicability.. Valid values are `^d{4}$`',
    `silver_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of silver in milligrams per liter. Heavy metal limit for photographic and metal finishing industries.',
    `total_nitrogen_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total nitrogen in milligrams per liter that the industrial user may discharge.',
    `total_phosphorus_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total phosphorus in milligrams per liter that the industrial user may discharge.',
    `tss_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of TSS in milligrams per liter that the industrial user may discharge to the wastewater collection system.',
    `zinc_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of zinc in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    CONSTRAINT pk_industrial_user_permit PRIMARY KEY(`industrial_user_permit_id`)
) COMMENT 'Master record for each Industrial User Permit (IUP) issued under the pretreatment program including permit number, industrial user name, SIC code, permitted discharge limits (BOD, COD, TSS, heavy metals, pH, FOG), permit effective and expiration dates, categorical pretreatment standard applicability, compliance schedule milestones, and issuing authority. Authoritative IUP registry for CWA pretreatment compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` (
    `sewer_inspection_id` BIGINT COMMENT 'Unique identifier for each sewer inspection event. Primary key for the sewer inspection data product.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: NPDES and SSO permits mandate collection system inspection programs with specific frequencies and methods. Linking sewer_inspection to compliance_permit enables permit-driven inspection scheduling, co',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Sewer CCTV and PACP inspections should be linked to the unified asset inspection event record for cross-asset inspection program scheduling, regulatory compliance reporting, and inspection history con',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Sewer inspections occur at specific locations in the asset location hierarchy for field crew dispatch, GIS-based inspection program management, and spatial reporting. No existing FK from sewer_inspect',
    `manhole_id` BIGINT COMMENT 'Foreign key reference to the manhole inspected, when the asset type is manhole.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Sewer lateral inspections are conducted at specific customer premises. Linking inspection records to premises enables premise-level inspection history reporting, compliance scheduling, and maintenance',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspectors identify deficiencies that trigger utility-conducted sewer inspections as follow-up. Linking the internal sewer_inspection to the triggering regulatory_inspection enables trackin',
    `sewer_network_id` BIGINT COMMENT 'Foreign key reference to the sewer pipe segment inspected, when the asset type is pipe.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: CCTV inspections conducted as part of CIP projects (pre-construction baseline, post-construction acceptance) must be linked to the project for deliverable tracking, payment certification, warranty bas',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the maintenance work order or service request that triggered this inspection, linking inspection to asset management workflows.',
    `asset_identifier` STRING COMMENT 'Business-facing identifier or tag of the specific asset inspected (pipe segment number, manhole number, etc.), used for field reference and reporting.',
    `asset_type` STRING COMMENT 'The type of sewer infrastructure asset being inspected, distinguishing between pipes, manholes, and other components.. Valid values are `pipe|manhole|lateral|junction|cleanout`',
    `condition_grade` STRING COMMENT 'Overall structural condition rating of the inspected asset based on NASSCO PACP or MACP grading scale (1=excellent, 5=imminent failure). Primary output of the inspection.. Valid values are `1|2|3|4|5`',
    `contractor_name` STRING COMMENT 'Name of the third-party contractor or vendor who performed the inspection, if the work was outsourced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system, for audit trail and data lineage tracking.',
    `critical_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether any critical or high-severity defects were identified that require immediate attention or emergency repair.',
    `defect_codes` STRING COMMENT 'Comma-separated list of NASSCO defect codes identified during the inspection (e.g., CL for crack longitudinal, RB for roots, DP for deformed pipe), used for detailed condition analysis.',
    `defect_count` STRING COMMENT 'Total number of discrete defects identified during the inspection, used as a quick indicator of asset condition complexity.',
    `downstream_manhole_number` STRING COMMENT 'Identifier of the downstream manhole for pipe segment inspections, establishing the ending point of the inspection run.',
    `estimated_repair_cost_usd` DECIMAL(18,2) COMMENT 'Preliminary cost estimate in US dollars for the recommended repair or rehabilitation action, used for capital planning and budget forecasting.',
    `flow_condition` STRING COMMENT 'Flow level observed in the pipe during inspection, impacting visibility and the ability to assess certain defects.. Valid values are `dry|low|medium|high|surcharge`',
    `fog_accumulation_flag` BOOLEAN COMMENT 'Boolean indicator of whether FOG buildup was observed, requiring cleaning and potentially indicating FOG program enforcement needs.',
    `infiltration_observed_flag` BOOLEAN COMMENT 'Boolean indicator of whether infiltration or inflow was observed during the inspection, contributing to non-revenue water and treatment plant overload.',
    `inspection_date` DATE COMMENT 'The date on which the sewer inspection was performed. Principal business event timestamp for this transaction.',
    `inspection_direction` STRING COMMENT 'Direction of travel during the inspection relative to flow direction, relevant for CCTV and sonar inspections of pipe segments.. Valid values are `upstream|downstream`',
    `inspection_length_feet` DECIMAL(18,2) COMMENT 'Total length of pipe segment inspected, measured in feet, used to calculate condition per linear foot and prioritize rehabilitation.',
    `inspection_method` STRING COMMENT 'The technology or technique used to perform the inspection. CCTV is the most common method for pipe condition assessment.. Valid values are `CCTV|sonar|smoke_test|dye_test|visual|laser_profiling`',
    `inspection_number` STRING COMMENT 'Business-facing unique identifier or work order number assigned to this inspection event for tracking and reference purposes.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record, tracking workflow from scheduling through final approval and integration into asset records.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `inspection_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection commenced, including time of day for scheduling and operational tracking.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose or trigger, distinguishing between scheduled maintenance, reactive response, and compliance-driven inspections.. Valid values are `routine|emergency|post_repair|pre_construction|complaint_driven|regulatory`',
    `inspector_certification_number` STRING COMMENT 'Professional certification number of the inspector, typically NASSCO PACP or MACP certification, ensuring qualified personnel perform assessments.',
    `inspector_name` STRING COMMENT 'Name of the individual technician or engineer who performed the inspection, for accountability and quality assurance.',
    `macp_score` STRING COMMENT 'Numeric MACP score calculated from defect observations, representing the overall structural and operational condition of the manhole.',
    `notes` STRING COMMENT 'Free-text field for additional observations, context, or special conditions noted during the inspection that do not fit structured fields.',
    `operational_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether operational defects (roots, grease, debris, infiltration, exfiltration) were observed, impacting flow capacity.',
    `pacp_score` STRING COMMENT 'Numeric PACP score calculated from defect observations, representing the overall structural and operational condition of the pipe segment.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the pipe inspected, measured in inches, relevant for capacity and defect severity assessment.',
    `pipe_material` STRING COMMENT 'Material composition of the pipe inspected (e.g., vitrified clay, PVC, concrete, cast iron), influencing defect types and rehabilitation methods.',
    `recommended_action` STRING COMMENT 'Recommended maintenance or capital action based on inspection findings, guiding asset management and CIP prioritization decisions.. Valid values are `no_action|monitor|cleaning|spot_repair|rehabilitation|replacement`',
    `rehabilitation_method` STRING COMMENT 'Specific rehabilitation technique recommended if repair or renewal is needed (e.g., CIPP lining, pipe bursting, open-cut replacement, spot repair, manhole lining).',
    `report_file_path` STRING COMMENT 'File system path or URL to the formal inspection report document, typically in PDF format, for regulatory and asset management records.',
    `review_date` DATE COMMENT 'Date on which the inspection report was reviewed and approved by qualified personnel, completing the quality assurance process.',
    `reviewed_by` STRING COMMENT 'Name of the engineer or supervisor who reviewed and validated the inspection findings, ensuring quality control and technical accuracy.',
    `root_intrusion_flag` BOOLEAN COMMENT 'Boolean indicator of whether tree root intrusion was observed, a common cause of blockages and structural damage in gravity sewers.',
    `structural_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether structural defects (cracks, fractures, collapse, deformation) were observed, impacting asset integrity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last modified, supporting change tracking and audit compliance.',
    `upstream_manhole_number` STRING COMMENT 'Identifier of the upstream manhole for pipe segment inspections, establishing the starting point of the inspection run.',
    `urgency_classification` STRING COMMENT 'Priority level assigned to the recommended action, used to sequence capital projects and maintenance work in the CIP and O&M budgets.. Valid values are `immediate|high|medium|low|routine`',
    `video_file_path` STRING COMMENT 'File system path or URL to the recorded CCTV or sonar video file, enabling review and validation of inspection findings.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection (dry, wet, recent rain), relevant for interpreting infiltration and flow observations.',
    CONSTRAINT pk_sewer_inspection PRIMARY KEY(`sewer_inspection_id`)
) COMMENT 'Transactional record of each sewer pipe or manhole inspection event including inspection date, inspection method (CCTV, sonar, smoke test, dye test), inspector or contractor, pipe segment or manhole inspected, condition grade (NASSCO PACP/MACP rating), defect codes identified, recommended rehabilitation method (CIPP, pipe bursting, spot repair), and urgency classification. Feeds asset renewal planning and CIP prioritization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` (
    `collection_system_blockage_id` BIGINT COMMENT 'Unique identifier for each sewer blockage or stoppage event in the collection system.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Collection system blockages often originate from customer properties (FOG, improper disposal, lateral defects) or impact customers through service disruptions and backups. Linking enables tracking cus',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Integrated I&I (inflow/infiltration) analysis correlates sewer blockage frequency and severity with distribution DMAs — a standard operational practice in combined utilities. The dma_code plain attrib',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Collection system blockages are asset failures requiring failure records for MTBF analysis, root cause tracking, and capital planning. Linking blockages to failure records enables collection system re',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Collection system blockages trigger post-clearance inspections (CCTV, smoke testing) tracked in asset.inspection_event. Linking blockages to inspection events enables root cause verification, repeat b',
    `location_id` BIGINT COMMENT 'Reference to the maintenance crew or team that responded to and cleared the blockage.',
    `manhole_id` BIGINT COMMENT 'Reference to the manhole location associated with the blockage event if applicable.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: A sewer lateral blockage is directly associated with the customer premise whose lateral caused or was affected. Utilities track premise-level blockage history to determine maintenance responsibility, ',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Blockages often occur at specific assets (valves, cleanouts, pump stations) requiring failure tracking for reliability-centered maintenance. Asset-level failure records enable MTBF/MTTR analysis, root',
    `sewer_network_id` BIGINT COMMENT 'Reference to the specific pipe segment where the blockage occurred.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Blockage investigations may trigger water quality sampling when cross-connection, contamination, or illicit discharge is suspected during root cause analysis. Links blockage event to investigative sam',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to respond to and clear the blockage.',
    `basin_code` STRING COMMENT 'Code identifying the wastewater collection basin or drainage area where the blockage occurred.',
    `blockage_cause` STRING COMMENT 'Primary cause of the blockage event. FOG = Fats, Oils, and Grease; I&I = Inflow and Infiltration. [ENUM-REF-CANDIDATE: FOG|roots|debris|structural_collapse|grease_buildup|foreign_object|sediment|pipe_defect|I&I|unknown — 10 candidates stripped; promote to reference product]',
    `blockage_number` STRING COMMENT 'Externally-known unique identifier or ticket number assigned to this blockage event for tracking and reporting purposes.',
    `blockage_severity` STRING COMMENT 'Severity classification of the blockage based on impact to service and risk of overflow.. Valid values are `minor|moderate|major|critical`',
    `blockage_type` STRING COMMENT 'Indicates whether the blockage was partial (reduced flow) or complete (no flow).. Valid values are `partial|complete`',
    `clearance_method` STRING COMMENT 'Method or technique used by the crew to clear the blockage and restore flow.. Valid values are `hydro_jetting|rodding|excavation|chemical_treatment|vacuum_truck|manual_removal`',
    `clearance_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from crew arrival to successful clearance of the blockage.',
    `clearance_timestamp` TIMESTAMP COMMENT 'Date and time when the blockage was successfully cleared and flow was restored.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blockage record was first created in the system.',
    `customer_complaint_count` STRING COMMENT 'Number of customer complaints received related to this blockage event.',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether the blockage event impacted customer service (e.g., backup into property, service disruption).',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the blockage event resulted in environmental impact requiring regulatory notification.',
    `equipment_used` STRING COMMENT 'Description of equipment or tools used to clear the blockage (e.g., hydro-jetter model, vacuum truck).',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in US dollars to respond to and clear the blockage including labor, equipment, and materials.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the blockage or stoppage event was first detected or reported.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the blockage location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the blockage location in decimal degrees.',
    `notes` STRING COMMENT 'Additional free-text notes or observations about the blockage event, clearance activities, or site conditions.',
    `preventive_maintenance_recommendation` STRING COMMENT 'Recommended preventive maintenance actions to reduce future blockage risk at this location (e.g., scheduled cleaning, root treatment, pipe rehabilitation).',
    `previous_blockage_count` STRING COMMENT 'Number of previous blockage events recorded at this location within the past 12 months.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Measured rainfall amount in inches during the 24-hour period preceding the blockage event.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory notification to EPA or state agency was required for this blockage event.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory notification was submitted to the appropriate agency.',
    `repeat_blockage_flag` BOOLEAN COMMENT 'Indicates whether this location has experienced previous blockage events within a defined time period.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the blockage was reported to the utility by customer, field crew, or monitoring system.',
    `response_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from when the blockage was reported to when the crew arrived on site.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the response crew arrived on site to address the blockage.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis was completed for this blockage event.',
    `sso_location_description` STRING COMMENT 'Description of the location where the SSO occurred (e.g., street, property, receiving water body).',
    `sso_occurred_flag` BOOLEAN COMMENT 'Indicates whether a Sanitary Sewer Overflow occurred as a result of this blockage event.',
    `sso_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of wastewater overflow in gallons if an SSO occurred due to the blockage.',
    `street_address` STRING COMMENT 'Street address or nearest address to the blockage location for field crew navigation and reporting.',
    `total_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from blockage detection to clearance completion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this blockage record was last modified in the system.',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of the blockage event (e.g., heavy rain, dry, snow) that may have contributed to the event.',
    CONSTRAINT pk_collection_system_blockage PRIMARY KEY(`collection_system_blockage_id`)
) COMMENT 'Transactional record of each sewer blockage or stoppage event in the collection system including event date/time, location (pipe segment, manhole), blockage cause (FOG, roots, debris, structural collapse, I&I), response crew, clearance method (hydro-jetting, rodding, excavation), time to clear, downstream SSO occurrence flag, and preventive maintenance recommendation. Supports O&M performance tracking and SSO root cause analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` (
    `sewer_service_connection_id` BIGINT COMMENT 'Unique identifier for the sewer service connection (lateral) record. Primary key for this entity.',
    `industrial_user_permit_id` BIGINT COMMENT 'Foreign key linking to wastewater.industrial_user_permit. Business justification: sewer_service_connection has industrial_user_flag (boolean) and iup_permit_number (STRING) fields indicating that some service connections belong to permitted industrial users. The iup_permit_number s',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Sewer service connections have a physical location in the asset location hierarchy for field crew dispatch, GIS-based asset management, and spatial reporting. No existing FK from sewer_service_connect',
    `manhole_id` BIGINT COMMENT 'Reference to the nearest manhole or connection point where the service lateral ties into the public sewer system, if applicable.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Water utilities coordinate water and sewer service at customer premises. Service activation/deactivation, combined billing, and account management require linking the water meter to the corresponding',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Sewer charges are calculated from water consumption measured at the specific meter installation paired to the service connection. Billing reconciliation, sewer rate adjustments, and field crew coordin',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Sewer laterals physically connect to properties where water service points exist. Combined water/wastewater utilities require this link for coordinated service delivery, unified billing, infrastructur',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: A sewer service connection is established under a customer service agreement governing wastewater service terms. Utilities need this link for service disconnection processing, billing reconciliation, ',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Sewer service connections are classified (residential, commercial, significant industrial user) per service class, which drives tariff application, DMR regulatory reporting categories, and billing cyc',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Utilities manage combined water/sewer service at same premise for coordinated billing, joint service orders, coordinated shutoffs, infrastructure replacement planning, and regulatory lead service line',
    `sewer_network_id` BIGINT COMMENT 'Reference to the public sewer main segment to which this service lateral connects. Establishes the topology link between customer service and the collection network.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service connections are installed/replaced via CIP projects (new development, rehabilitation). Link enables developer contribution tracking, capital cost allocation, system capacity planning, and conn',
    `abandonment_date` DATE COMMENT 'Date when the service connection was permanently abandoned and removed from active service. Abandoned connections are typically capped or filled.',
    `activation_date` DATE COMMENT 'Date when the service connection was activated and began receiving wastewater service. May differ from installation date if there was a delay between construction and service commencement.',
    `backwater_valve_installed_flag` BOOLEAN COMMENT 'Indicates whether a backwater valve (backflow preventer) is installed on the service lateral to prevent sewage backup into the premise during system surcharge events.',
    `cleanout_available_flag` BOOLEAN COMMENT 'Indicates whether a cleanout access point is available on the service lateral for maintenance and inspection purposes. Cleanouts facilitate camera inspection and clearing blockages.',
    `condition_rating` STRING COMMENT 'Current physical condition assessment of the service lateral based on inspection findings, age, material, and maintenance history. Ratings guide rehabilitation and replacement prioritization.. Valid values are `excellent|good|fair|poor|critical|unknown`',
    `connection_type` STRING COMMENT 'Type of sewer service connection based on conveyance method. Gravity connections rely on slope; grinder pump and ejector pump connections serve properties below the sewer main elevation; low-pressure and vacuum systems are specialized collection methods.. Valid values are `gravity|grinder_pump|ejector_pump|low_pressure|vacuum`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service connection record was first created in the system. Used for data lineage, audit trails, and compliance reporting.',
    `criticality_rating` STRING COMMENT 'Business criticality or risk rating of this service connection based on factors such as customer type, service area sensitivity, backup risk, and consequence of failure. Guides prioritization of maintenance and capital investment.. Valid values are `critical|high|medium|low`',
    `deactivation_date` DATE COMMENT 'Date when the service connection was deactivated or taken out of service, either temporarily or permanently.',
    `fog_risk_flag` BOOLEAN COMMENT 'Indicates whether this service connection serves a food service establishment or other FOG-generating source, requiring special monitoring and maintenance under the utility FOG program.',
    `gis_feature_reference` STRING COMMENT 'Unique identifier for this service connection in the utility GIS system. Enables integration with spatial analysis, network modeling, and asset mapping applications.',
    `grinder_pump_installation_date` DATE COMMENT 'Date when the grinder pump was installed at this service connection. Used for warranty tracking and lifecycle management.',
    `grinder_pump_manufacturer` STRING COMMENT 'Manufacturer name of the grinder pump installed at this service connection, if applicable.',
    `grinder_pump_model` STRING COMMENT 'Model number or designation of the grinder pump installed at this service connection, if applicable.',
    `grinder_pump_serial_number` STRING COMMENT 'Manufacturer serial number of the grinder pump installed at this service connection, if applicable. Used for warranty tracking, maintenance scheduling, and parts ordering.',
    `industrial_user_flag` BOOLEAN COMMENT 'Indicates whether this service connection serves an industrial user subject to pretreatment requirements and Industrial User Permit (IUP) regulations under the Clean Water Act.',
    `installation_date` DATE COMMENT 'Date when the sewer service connection was originally installed and placed into service. Used for age-based asset management, depreciation, and replacement planning.',
    `installation_year` STRING COMMENT 'Year when the sewer service connection was installed. Provided separately for cases where only the year is known, supporting age-based analysis and cohort studies.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or condition assessment of the service lateral. Inspections may include camera surveys, smoke testing, or visual examination.',
    `lateral_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the service lateral pipe measured in inches. Typical residential laterals range from 4 to 6 inches; commercial and industrial connections may be larger.',
    `lateral_length_feet` DECIMAL(18,2) COMMENT 'Total length of the service lateral pipe from the premise connection point to the public sewer main, measured in feet. Used for capacity analysis, maintenance planning, and replacement cost estimation.',
    `lateral_pipe_material` STRING COMMENT 'Material composition of the service lateral pipe. Common materials include PVC (polyvinyl chloride), vitrified clay, cast iron, ductile iron, concrete, Orangeburg (bituminized fiber), ABS (acrylonitrile butadiene styrene), and HDPE (high-density polyethylene). Material affects durability, corrosion resistance, and maintenance needs. [ENUM-REF-CANDIDATE: pvc|vitrified_clay|cast_iron|ductile_iron|concrete|orangeburg|abs|hdpe — 8 candidates stripped; promote to reference product]',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service connection point or premise location in decimal degrees. Used for GIS mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service connection point or premise location in decimal degrees. Used for GIS mapping and spatial analysis.',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for maintenance and repair of the service lateral. May differ from ownership; for example, a private lateral may have utility maintenance responsibility under certain programs.. Valid values are `utility|customer|shared|unknown`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next inspection or condition assessment of the service lateral, based on regulatory requirements, risk rating, or preventive maintenance schedules.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special conditions, maintenance history notes, or other relevant information about the service connection.',
    `ownership_type` STRING COMMENT 'Ownership responsibility for the service lateral. Utility-owned laterals are maintained by the wastewater utility; private laterals are the property owners responsibility; shared ownership may apply to portions of the lateral; municipal ownership applies to public properties.. Valid values are `utility|private|shared|municipal|unknown`',
    `parcel_identifier` STRING COMMENT 'Tax parcel number or assessor parcel number (APN) for the property served by this connection. Used for cross-referencing with municipal tax and GIS records.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the service lateral in US dollars, used for capital planning, insurance valuation, and asset management financial analysis.',
    `service_address_line1` STRING COMMENT 'Primary street address line of the premise served by this sewer connection. Organizational contact data classified as confidential.',
    `service_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the premise served by this sewer connection. Organizational contact data classified as confidential.',
    `service_city` STRING COMMENT 'City or municipality where the served premise is located. Organizational contact data classified as confidential.',
    `service_connection_number` STRING COMMENT 'Business identifier for the sewer service connection, typically used in field operations, customer service, and billing. May follow utility-specific numbering conventions.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code for the service address. Organizational contact data classified as confidential.',
    `service_state_province` STRING COMMENT 'State or province code for the service address location.',
    `service_status` STRING COMMENT 'Current operational status of the sewer service connection. Active connections are in use; inactive connections are temporarily out of service; abandoned connections are permanently closed; capped connections are physically sealed; pending activation connections are installed but not yet in service.. Valid values are `active|inactive|abandoned|capped|pending_activation`',
    `sso_history_flag` BOOLEAN COMMENT 'Indicates whether this service connection has a documented history of sanitary sewer overflows or backups. Used for risk assessment and targeted maintenance programs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service connection record was last modified. Used for change tracking, data quality monitoring, and audit trails.',
    CONSTRAINT pk_sewer_service_connection PRIMARY KEY(`sewer_service_connection_id`)
) COMMENT 'Master record for each individual sewer service connection (lateral) linking a customer premise to the public sewer main including connection address, parcel identifier, lateral pipe material, diameter, length, connection type (gravity, grinder pump), installation date, condition, and service status (active, inactive, abandoned). Bridges the wastewater network topology to customer service accounts.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_effluent_discharge_event_id` FOREIGN KEY (`effluent_discharge_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event`(`effluent_discharge_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_collection_system_blockage_id` FOREIGN KEY (`collection_system_blockage_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`(`collection_system_blockage_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_domain' = 'wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'NPDES (National Pollutant Discharge Elimination System) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Drainage Basin Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_business_glossary_term' = 'Traffic Load Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_value_regex' = 'light_duty|medium_duty|heavy_duty|extra_heavy_duty');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|exceptional_quality|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_management_method` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Management Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_management_method` SET TAGS ('dbx_value_regex' = 'land_application|incineration|landfill|composting|beneficial_reuse');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|consent_decree|administrative_order');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_value_regex' = 'chlorine|uv|ozone|none');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `effluent_discharge_point` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Point');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `energy_consumption_kwh_per_mg` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kilowatt-Hours per Million Gallons (kWh/MG)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_business_glossary_term' = 'Facility Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'municipal|industrial|combined|satellite');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|standby|decommissioned|under_construction');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `peak_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_value_regex' = 'preliminary|primary|secondary|tertiary|advanced');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `permit_limit_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `rainfall_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Amount (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `receiving_water_body_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `scada_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|advanced|partial|none');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_parameter_result_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Parameter Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Point ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `collection_system_blockage_id` SET TAGS ('dbx_business_glossary_term' = 'Collection System Blockage Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Volume Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_value_regex' = 'measured|calculated|estimated');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `volume_recovered_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Recovered (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ALTER COLUMN `weather_related` SET TAGS ('dbx_business_glossary_term' = 'Weather-Related SSO Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Metering Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `sewer_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'pipe|manhole|lateral|junction|cleanout');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `collection_system_blockage_id` SET TAGS ('dbx_business_glossary_term' = 'Collection System Blockage ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Response Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blockage Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `total_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Duration (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Segment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_connection_number` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_state_province` SET TAGS ('dbx_business_glossary_term' = 'Service State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|capped|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `sso_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) History Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
