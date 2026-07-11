-- Schema for Domain: quality | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`quality` COMMENT 'Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` (
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the water quality sampling location. Primary key for the sampling point registry.',
    `compliance_permit_id` BIGINT COMMENT 'The NPDES permit number, SDWA public water system ID, or Industrial User Permit (IUP) number associated with this sampling point for regulatory compliance tracking.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMAs are the primary operational units for water quality monitoring and NRW/water quality correlation. quality_sampling_point carries a denormalized dma_code text column; a proper FK enables DMA-lev',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility (WTP, WWTP, pump station, reservoir) where this sampling point is located, if applicable.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Quality sampling points co-located with meters require flow-rate and pressure context at sample time for regulatory site characterization. The quality_sampling_point already stores flow_rate_gpm as a ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Sampling points are established or modified during CIP projects (new treatment plants, distribution expansions). Project closeout requires documenting new sampling points per regulatory permit conditi',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: TTHM/HAA5 and DBP monitoring regulations require representative sampling across pressure zones. quality_sampling_point carries a denormalized plain-text pressure_zone column; replacing it with a pro',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Sampling points are designated under specific regulatory requirements (e.g., RTCR entry points, LCR tier 1 sites, SWTR filter effluent points). Compliance staff must trace which regulatory requirement',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Sampling points are geographically located within service territories for regulatory zone compliance reporting, CCR preparation, and operational monitoring jurisdiction. Water utilities organize sampl',
    `access_type` STRING COMMENT 'Classification of physical access requirements for sampling personnel. Public = open access; restricted = requires authorization; private property = requires owner permission; confined space = requires confined space entry procedures; remote = difficult to reach, may require special equipment.. Valid values are `public|restricted|private_property|confined_space|remote`',
    `ccr_reporting_flag` BOOLEAN COMMENT 'Indicates whether water quality results from this sampling point must be included in the annual Consumer Confidence Report (CCR) to customers. True = included in CCR; False = not included.',
    `sampling_point_code` STRING COMMENT 'Externally-known unique business identifier for the sampling location, used in regulatory reporting and laboratory requisitions. Typically follows EPA or state-specific coding conventions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `comments` STRING COMMENT 'Additional notes, historical context, or operational observations about this sampling point that do not fit other structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sampling point record was first created in the system.',
    `decommission_date` DATE COMMENT 'The date when this sampling point was permanently retired from service. Null if still active or temporarily suspended.',
    `dmr_reporting_flag` BOOLEAN COMMENT 'Indicates whether effluent quality results from this sampling point must be included in monthly Discharge Monitoring Reports (DMR) submitted to EPA or state agencies. True = included in DMR; False = not included.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the sampling point above sea level in feet. Used for hydraulic gradient analysis and pressure zone validation.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The typical or design flow rate in gallons per minute (GPM) at this sampling location. Used for composite sampling calculations and hydraulic modeling correlation.',
    `gis_feature_code` STRING COMMENT 'The unique feature identifier in the Esri ArcGIS or other GIS system that represents this sampling point. Used for spatial analysis, network tracing, and map visualization.',
    `installation_date` DATE COMMENT 'The date when this sampling point was first established and became operational for water quality monitoring.',
    `last_sample_date` DATE COMMENT 'The most recent date on which a sample was collected from this sampling point. Used to track compliance with sampling schedules and identify overdue sampling locations.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the sampling point location for GIS mapping and spatial analysis.',
    `location_type` STRING COMMENT 'Classification of the sampling point by its position in the water system lifecycle. Entry point = water entering distribution; distribution system = points within the network; source water = raw intake; WTP/WWTP process = treatment plant intermediate stages; effluent discharge = final discharge point; customer tap = end-user location. [ENUM-REF-CANDIDATE: entry_point|distribution_system|source_water|wtp_process|wwtp_process|effluent_discharge|customer_tap — 7 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the sampling point location for GIS mapping and spatial analysis.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified this sampling point record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this sampling point record was last updated or modified.',
    `sampling_point_name` STRING COMMENT 'Human-readable name or label for the sampling location (e.g., Main Street Entry Point, WTP Clearwell Outlet, WWTP Final Effluent).',
    `next_scheduled_sample_date` DATE COMMENT 'The next planned date for sample collection at this location based on the regulatory or operational sampling schedule.',
    `primary_contaminant_group` STRING COMMENT 'The primary category of contaminants monitored at this sampling point (e.g., Microbiological, Disinfection Byproducts, Inorganic Chemicals, Organic Chemicals, Radionuclides, Nutrients, Metals). Used to organize sampling schedules and laboratory workflows.',
    `regulatory_zone` STRING COMMENT 'The regulatory monitoring zone or district to which this sampling point is assigned for compliance reporting purposes. Used to aggregate results for Consumer Confidence Report (CCR) and Discharge Monitoring Report (DMR).',
    `residence_time_hours` DECIMAL(18,2) COMMENT 'The estimated water residence time in hours from the treatment plant to this sampling point in the distribution system. Critical for disinfection Contact Time (CT) calculations and Disinfection Byproduct (DBP) formation analysis.',
    `responsible_department` STRING COMMENT 'The internal department or division responsible for sampling at this location (e.g., Water Quality Lab, Distribution Operations, Wastewater Operations, Compliance).',
    `safety_notes` STRING COMMENT 'Safety considerations and hazards specific to this sampling location (e.g., confined space, traffic hazards, chemical exposure, biological hazards, electrical equipment).',
    `sample_collection_method` STRING COMMENT 'The method by which samples are collected at this point. Grab = single point-in-time sample; composite = time- or flow-weighted composite over a period; continuous monitor = automated real-time sensor; passive sampler = diffusion-based accumulation.. Valid values are `grab|composite|continuous_monitor|passive_sampler`',
    `sampler_name` STRING COMMENT 'The name of the primary field technician or automated sampler equipment responsible for routine sample collection at this location. Used for quality assurance and chain-of-custody tracking.',
    `sampling_frequency` STRING COMMENT 'The regulatory or operational frequency at which samples must be collected from this location. Continuous = real-time monitoring (e.g., SCADA); event-based = triggered by specific conditions (e.g., storm events, process upsets). [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual|event_based — 8 candidates stripped; promote to reference product]',
    `sampling_instructions` STRING COMMENT 'Detailed field instructions for sample collection at this location, including access directions, safety precautions, flushing procedures, bottle types, preservation requirements, and any site-specific protocols.',
    `sampling_point_status` STRING COMMENT 'Current operational status of the sampling point. Active = in regular use; inactive = not currently sampled but may be reactivated; temporarily suspended = short-term pause (e.g., construction); decommissioned = permanently retired.. Valid values are `active|inactive|temporarily_suspended|decommissioned`',
    `scada_tag` STRING COMMENT 'The SCADA system tag or point identifier for continuous monitoring instruments at this sampling location. Used to link laboratory results with real-time process data from OSIsoft PI Historian or similar systems.',
    `treatment_stage` STRING COMMENT 'For WTP or WWTP process sampling points, the specific treatment stage being monitored (e.g., Raw Intake, Coagulation, Sedimentation, Filtration, Disinfection, Clearwell, Primary Treatment, Secondary Treatment, Tertiary Treatment, UV Disinfection, Reverse Osmosis). Null for distribution or source sampling points.',
    `water_source_type` STRING COMMENT 'The type of water source from which this sampling point draws or monitors. Surface water = rivers, lakes, reservoirs; groundwater = wells, aquifers; groundwater under influence = groundwater influenced by surface water; blended = mix of sources; purchased = water bought from another utility; recycled = reclaimed wastewater.. Valid values are `surface_water|groundwater|groundwater_under_influence|blended|purchased|recycled`',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this sampling point record.',
    CONSTRAINT pk_sampling_point PRIMARY KEY(`sampling_point_id`)
) COMMENT 'Master registry of all approved water quality sampling locations across the utilitys infrastructure including distribution system sites, source water intakes, WTP/WWTP process points, and wastewater effluent discharge outfalls. Captures location type (entry point, distribution, source, effluent, customer tap), GIS coordinates, regulatory monitoring zone classification, DMA assignment, pressure zone, LCRR tier classification for tap sites, associated permit or CCR reporting requirements, and activation/deactivation status. Serves as the authoritative SSOT for where samples are collected and links to sampling_schedule for monitoring requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` (
    `sampling_schedule_id` BIGINT COMMENT 'Unique identifier for the sampling schedule record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Sampling schedules operationalize compliance obligations (permit monitoring requirements, consent order milestones). This link connects operational monitoring plans to formal compliance commitments, e',
    `location_id` BIGINT COMMENT 'Reference to the physical location where samples are collected (e.g., treatment plant, distribution point, discharge point).',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Sampling schedules are mandated by specific permit conditions (monitoring frequency, location, method requirements). Compliance staff set up schedules directly from permit condition requirements. samp',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Sampling schedules are driven by specific regulatory requirements (SDWA monitoring frequencies, RTCR rules, LCR sampling). This link documents the regulatory basis for each monitoring schedule, essent',
    `sampling_point_id` BIGINT COMMENT 'Reference to the physical location where samples are collected (e.g., treatment plant, distribution point, discharge point).',
    `annual_budget_allocation` DECIMAL(18,2) COMMENT 'Total budget allocated in USD for this sampling schedule for the fiscal year.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this sampling schedule (e.g., Compliance Manager, Lab Director).',
    `approved_date` DATE COMMENT 'Date when this sampling schedule was formally approved for execution.',
    `compliance_deadline_date` DATE COMMENT 'Regulatory deadline by which all samples for this schedule must be collected and analyzed to avoid violation.',
    `compliance_status` STRING COMMENT 'Current compliance status of this schedule: compliant (all samples collected on time), at risk (approaching deadline or missed samples), non-compliant (violation occurred), pending review (awaiting regulatory determination).. Valid values are `compliant|at_risk|non_compliant|pending_review`',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'Estimated or contracted cost in USD for each sample collection and analysis event under this schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling schedule record was first created in the system.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis, per regulatory or method requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling schedule record was last updated.',
    `last_sample_collected_date` DATE COMMENT 'Date when the most recent sample was collected under this schedule. Used to track compliance gaps.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this record.',
    `monitoring_period_end_date` DATE COMMENT 'End date of the monitoring period covered by this schedule. Null for ongoing/perpetual schedules.',
    `monitoring_period_start_date` DATE COMMENT 'Start date of the monitoring period covered by this schedule.',
    `next_scheduled_sample_date` DATE COMMENT 'Date when the next sample is scheduled to be collected under this schedule.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or operational notes related to this sampling schedule.',
    `notification_lead_time_days` STRING COMMENT 'Number of days in advance that field crews and labs should be notified before scheduled sampling events.',
    `preservation_method` STRING COMMENT 'Required preservation technique for samples (e.g., refrigerate to 4°C, acidify to pH<2 with HNO3, add sodium thiosulfate, no preservation required).',
    `priority_level` STRING COMMENT 'Business priority of this schedule: critical (regulatory mandate with enforcement risk), high (compliance-sensitive), medium (operational importance), low (discretionary monitoring).. Valid values are `critical|high|medium|low`',
    `regulatory_rule` STRING COMMENT 'The specific regulatory rule or permit condition driving this schedule (e.g., LCRR, DBP Stage 2 Rule, NPDES Permit CA0012345, PFAS Monitoring Advisory, SDWA Coliform Rule).',
    `reporting_requirement` STRING COMMENT 'Description of the reporting obligation associated with this schedule (e.g., Monthly Operating Report (MOR), Discharge Monitoring Report (DMR), Consumer Confidence Report (CCR), quarterly summary to state primacy agency).',
    `sample_type` STRING COMMENT 'Type of sample to be collected: grab (single point-in-time), composite (time- or flow-weighted over period), continuous (automated real-time), or integrated (multiple grabs combined).. Valid values are `grab|composite|continuous|integrated`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Required sample volume in milliliters for each collection event.',
    `samples_collected_ytd` STRING COMMENT 'Count of samples collected under this schedule in the current calendar or fiscal year.',
    `samples_per_period` STRING COMMENT 'Number of samples required per monitoring period (e.g., 4 samples per month for DBP monitoring in a large system).',
    `samples_required_ytd` STRING COMMENT 'Count of samples required to be collected under this schedule by this point in the calendar or fiscal year.',
    `sampling_frequency` STRING COMMENT 'Required frequency of sample collection: daily, weekly, biweekly, monthly, quarterly, semiannual, annual, on-demand (event-driven), or continuous (automated monitoring). [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|semiannual|annual|on_demand|continuous — 9 candidates stripped; promote to reference product]',
    `sampling_method` STRING COMMENT 'Standard method or protocol for sample collection (e.g., EPA Method 1694, Standard Methods 9060A, grab sample, composite 24-hour).',
    `schedule_name` STRING COMMENT 'Business-friendly name or identifier for the sampling schedule (e.g., Q1 2024 DBP Monitoring - Plant A).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the sampling schedule: active (in effect), suspended (temporarily paused), completed (monitoring period ended), cancelled (no longer required), pending approval (awaiting regulatory or management sign-off), or expired (past end date).. Valid values are `active|suspended|completed|cancelled|pending_approval|expired`',
    `schedule_type` STRING COMMENT 'Classification of the sampling schedule purpose: regulatory (mandated by permit/rule), operational (internal monitoring), investigational (response to incident), special study (research/optimization), compliance verification, or routine.. Valid values are `regulatory|operational|investigational|special_study|compliance_verification|routine`',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this schedule has seasonal variations in frequency or parameters (e.g., increased DBP monitoring in summer months).',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this schedule has triggered a monitoring or reporting violation.',
    CONSTRAINT pk_sampling_schedule PRIMARY KEY(`sampling_schedule_id`)
) COMMENT 'Defines the regulatory and operational sampling schedules for each monitoring location and contaminant group. Captures required sampling frequency (daily, weekly, monthly, quarterly, annual), applicable rule (LCRR, DBP Stage 2, PFAS, NPDES), monitoring period start/end dates, responsible lab or field crew, and schedule status. Drives compliance calendar and ensures no monitoring gaps that could trigger violations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` (
    `water_sample_id` BIGINT COMMENT 'Unique identifier for each water or wastewater sample collected. Primary key for the water sample transactional record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Water samples collected at customer service points for lead/copper compliance, customer complaint investigations, or service quality verification require linkage to the active service agreement for cu',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: LCR and RTCR compliance require correlating water samples with real-time AMI consumption/stagnation data at the sampled premise. Zero-consumption periods detected by AMI indicate stagnation risk. A wa',
    `point_id` BIGINT COMMENT 'Reference to the regulatory compliance monitoring point associated with this sample, if applicable. Links sample to specific permit or regulatory obligation.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Water samples in LIMS systems are directly associated with the treatment facility where they are collected or processed. DMR submissions, CCR reporting, and facility-level compliance tracking require ',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Main breaks trigger mandatory post-repair bacteriological sampling under RTCR and boil water advisory protocols. Water utilities must track samples collected after main break repairs to confirm water ',
    `order_id` BIGINT COMMENT 'Foreign key linking to service.order. Business justification: Service orders initiate water sample collection events (re-sampling after violations, new connection quality checks, customer complaint investigations). Linking water_sample to the triggering service.',
    `parent_sample_water_sample_id` BIGINT COMMENT 'For duplicate or split samples, reference to the original parent sample from which this sample was derived. Null for primary samples.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: A water sample is collected in fulfillment of a specific sampling schedule. bacteriological_result and lead_copper_result both carry sampling_schedule_id, but the parent water_sample record lacks this',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Water samples collected at customer premises for compliance monitoring (lead/copper rule, bacteriological sampling, customer complaint investigations). Required for customer notification and site-spec',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Commissioning and construction acceptance require project-specific water sampling (disinfection validation, bacteriological clearance before placing new mains in service). Project managers must track',
    `analysis_due_timestamp` TIMESTAMP COMMENT 'Calculated deadline by which analysis must be completed to meet hold-time requirements. Derived from collection timestamp plus hold time hours.',
    `collection_notes` STRING COMMENT 'Free-text field for collector to record observations, anomalies, or special conditions at the time of collection (e.g., visible discoloration, odor, nearby construction activity, equipment malfunction).',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was physically collected, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Critical for regulatory compliance and hold-time calculations.',
    `composite_duration_hours` STRING COMMENT 'For composite samples, the total time period over which the sample was collected (e.g., 24-hour composite). Null for grab samples.',
    `composite_interval_minutes` STRING COMMENT 'For composite samples, the time interval between individual aliquot collections (e.g., every 15 minutes, every 60 minutes). Null for grab samples.',
    `container_type` STRING COMMENT 'Type and material of the container used for sample collection (e.g., sterile plastic bottle, amber glass bottle, HDPE bottle). Must match EPA method requirements for the target analytes.',
    `container_volume_ml` STRING COMMENT 'Volume capacity of the sample container in milliliters (e.g., 125 mL, 500 mL, 1000 mL).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this sample record was first created in the database. Audit trail for data governance.',
    `field_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Free or total chlorine residual measured at the time of sample collection in mg/L. Critical for disinfection monitoring and compliance with Safe Drinking Water Act (SDWA) requirements.',
    `field_conductivity_us_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity measured at the time of sample collection in microsiemens per centimeter (µS/cm). Indicates total dissolved solids (TDS) and ionic content.',
    `field_dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration measured at the time of sample collection in mg/L. Important for wastewater treatment process control and aquatic life support.',
    `field_ph` DECIMAL(18,2) COMMENT 'pH level measured at the time of sample collection using a calibrated field meter. Indicates acidity or alkalinity on a scale of 0-14.',
    `field_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature measured at the time of sample collection in degrees Celsius. Field measurement recorded on-site.',
    `field_turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measured at the time of sample collection in Nephelometric Turbidity Units (NTU) using a field turbidimeter. Indicates water clarity and particulate matter.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate at the sampling point at the time of collection, measured in gallons per minute (GPM). Important for composite sampling and process control samples.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the sample collection point in decimal degrees. Enables spatial analysis and mapping of water quality data.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the sample collection point in decimal degrees. Enables spatial analysis and mapping of water quality data.',
    `hold_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis completion, as specified by EPA methods. Critical for ensuring analytical validity and regulatory compliance.',
    `lims_submission_code` STRING COMMENT 'Reference identifier assigned by the LIMS when the sample is logged into the laboratory system for analysis. Links field sample to laboratory test results.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this sample record was last updated. Audit trail for data governance and change tracking.',
    `preservation_method` STRING COMMENT 'Method used to preserve the sample integrity during transport and storage (e.g., refrigeration at 4°C, acidification with HNO3, sodium thiosulfate for dechlorination, no preservation). Critical for maintaining analyte stability.',
    `quality_control_flag` BOOLEAN COMMENT 'Indicates whether this sample is a quality control sample (field blank, duplicate, split, trip blank) rather than a routine environmental sample. True for QC samples, false for routine samples.',
    `regulatory_program` STRING COMMENT 'The regulatory program or permit under which the sample is collected (e.g., SDWA compliance, NPDES discharge monitoring, Lead and Copper Rule Revisions (LCRR), Disinfection Byproduct (DBP) monitoring, Per- and Polyfluoroalkyl Substances (PFAS) testing).',
    `requested_analysis_group` STRING COMMENT 'The suite or panel of tests requested for this sample (e.g., bacteriological, inorganic chemicals, volatile organic compounds (VOCs), Disinfection Byproducts (DBPs), metals, nutrients). May reference a predefined test package.',
    `sample_location_description` STRING COMMENT 'Free-text description of the sample collection location, including address, facility name, or geographic reference. Supplements the sampling point reference with human-readable context.',
    `sample_matrix` STRING COMMENT 'The type of water or wastewater being sampled: drinking water (finished), raw water (source), treated water (post-treatment), distribution water (in-network), wastewater influent (incoming), or wastewater effluent (discharge).. Valid values are `drinking_water|raw_water|treated_water|distribution_water|wastewater_influent|wastewater_effluent`',
    `sample_number` STRING COMMENT 'Business-facing unique sample identifier or barcode assigned at collection time, used for tracking and chain-of-custody documentation.',
    `sample_purpose` STRING COMMENT 'Business reason for collecting the sample (e.g., routine compliance monitoring, customer complaint investigation, process control, special study, Consumer Confidence Report (CCR) preparation, National Pollutant Discharge Elimination System (NPDES) permit monitoring).',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample: collected (in field), in transit (being transported), received by lab (logged into LIMS), in analysis (testing underway), analysis complete (results available), results reported (delivered to stakeholders), or voided (invalidated). [ENUM-REF-CANDIDATE: collected|in_transit|received_by_lab|in_analysis|analysis_complete|results_reported|voided — 7 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the sample collection method: grab (single point-in-time), composite (time- or flow-weighted composite), field blank (quality control), duplicate (replicate for precision), split (divided for multiple labs), or trip blank (contamination control).. Valid values are `grab|composite|field_blank|duplicate|split|trip_blank`',
    `sampler_equipment_code` BIGINT COMMENT 'Reference to the automatic sampler or field equipment used to collect the sample, if applicable. Supports equipment calibration tracking and quality assurance.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection (e.g., clear, rain, snow, storm). Relevant for source water and stormwater-influenced samples.',
    CONSTRAINT pk_water_sample PRIMARY KEY(`water_sample_id`)
) COMMENT 'Transactional record of each individual water or wastewater sample collected in the field or at a process point. Captures sample collection date/time, collector identity, sampling point, sample type (grab, composite, field blank, duplicate), preservation method, container type, chain-of-custody number, field measurements (temperature, pH, residual chlorine, turbidity in NTU), and LIMS submission reference. This is the primary event record for all quality monitoring activity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` (
    `analytical_result_id` BIGINT COMMENT 'Unique identifier for the laboratory analytical result record. Primary key.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: analytical_result currently has analyte_name and cas_number as free-text attributes. These should reference the contaminant master table for standardization, regulatory alignment, and to enable proper',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: Lab analytical results are compared against applicable regulatory limits for compliance determination. Links result to specific limit used for MCL/AL exceedance evaluation, public notification trigger',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Analytical results are evaluated against specific permit conditions (numeric limits, parameter codes, monitoring location requirements). Compliance staff must demonstrate each result satisfies each ap',
    `analysis_date` DATE COMMENT 'Date on which the laboratory analysis was performed. Used to verify compliance with method-specific hold-time requirements.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory analysis was completed. Provides full temporal resolution for hold-time verification and audit trails.',
    `analytical_method` STRING COMMENT 'EPA or standard method number used for the analysis (e.g., EPA 200.8, EPA 300.0, SM 2320B, ASTM D1067). Defines the laboratory procedure and instrumentation.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the instrument used for this analysis. Ensures measurement accuracy and traceability.',
    `compliance_exceeded` BOOLEAN COMMENT 'Indicates whether the result value exceeds the applicable MCL or permit limit. Triggers regulatory notification and corrective action workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this analytical result record was first created in the system. Audit trail field.',
    `data_validation_level` STRING COMMENT 'Level of data validation review applied to this result. Higher levels indicate more rigorous QA/QC review, typically required for regulatory or litigation purposes.. Valid values are `level_1|level_2|level_3|level_4`',
    `detection_limit` DECIMAL(18,2) COMMENT 'Minimum concentration of a substance that can be measured and reported with 99% confidence that the analyte concentration is greater than zero. Also known as MDL or MRL (Method Reporting Limit).',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Factor by which the sample was diluted prior to analysis. Result value is typically reported after applying the dilution factor. A value of 1.0 indicates no dilution.',
    `hold_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the method-specified hold time from collection to analysis. Non-compliance may affect result validity.',
    `hold_time_hours` STRING COMMENT 'Elapsed time in hours between sample collection and analysis. Used to verify compliance with method-specific hold-time requirements.',
    `laboratory_accreditation_number` STRING COMMENT 'State or EPA certification number for the laboratory. Required for regulatory compliance reporting under SDWA and CWA.',
    `lims_result_code` STRING COMMENT 'Original result identifier from the source LIMS system (LabWare or similar). Used for traceability and reconciliation with source system.',
    `mcl_value` DECIMAL(18,2) COMMENT 'Regulatory maximum contaminant level for this analyte as defined by EPA or state primacy agency. Used for automated compliance comparison.',
    `mclg_value` DECIMAL(18,2) COMMENT 'Non-enforceable health goal for this analyte. Represents the level at which no known or anticipated adverse health effects occur, with an adequate margin of safety.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this analytical result record was last modified. Audit trail field for tracking changes and corrections.',
    `percent_recovery` DECIMAL(18,2) COMMENT 'Quality control metric indicating the percentage of analyte recovered in matrix spike or laboratory control sample. Acceptable ranges are method-specific.',
    `qualifier_code` STRING COMMENT 'Data qualifier flag indicating special conditions (e.g., U=non-detect, J=estimated, H=hold-time exceeded, B=blank contamination, E=exceeds calibration range, Q=QC failure). Pipe-separated if multiple qualifiers apply.',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'Minimum concentration at which the analyte can be reliably quantified with a specified level of accuracy and precision. Typically higher than the detection limit.',
    `relative_percent_difference` DECIMAL(18,2) COMMENT 'Quality control metric comparing duplicate sample results. Measures precision and reproducibility of the analytical method.',
    `reporting_required` BOOLEAN COMMENT 'Indicates whether this result must be included in regulatory reports such as CCR, DMR, or MOR. Based on analyte type, sample location, and regulatory schedule.',
    `result_comment` STRING COMMENT 'Free-text notes from the analyst or validator regarding special conditions, anomalies, or interpretation guidance for this result.',
    `result_status` STRING COMMENT 'Current status of the analytical result in the laboratory workflow. Indicates whether the result has been validated and approved for regulatory reporting.. Valid values are `preliminary|final|approved|rejected|cancelled`',
    `result_value` DECIMAL(18,2) COMMENT 'Numerical value of the analytical result as measured by the laboratory. May be null if result is non-detect or qualitative.',
    `sample_matrix` STRING COMMENT 'Type of water or wastewater matrix from which the sample was collected. Affects method selection, detection limits, and regulatory applicability. [ENUM-REF-CANDIDATE: drinking_water|raw_water|treated_water|distribution_system|wastewater_influent|wastewater_effluent|groundwater|surface_water|biosolids — 9 candidates stripped; promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Unit in which the result is expressed (e.g., mg/L, ug/L, NTU, CFU/100mL, pH units, MPN/100mL, pCi/L). Critical for interpretation and compliance comparison.',
    `validated_by` STRING COMMENT 'Identifier of the quality assurance officer or supervisor who validated and approved this result for reporting.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the result was validated and approved. Marks the transition from preliminary to final status.',
    CONSTRAINT pk_analytical_result PRIMARY KEY(`analytical_result_id`)
) COMMENT 'Laboratory and field analytical result for each parameter tested on a collected water sample or measured by a continuous online instrument. Captures analyte/contaminant reference, CAS number, analytical method (EPA method number), result value, unit of measure, detection limit (MDL/MRL), qualifier flags (non-detect, estimated, hold-time exceeded, presence/absence), result type (grab, composite, continuous, calculated), measurement source (laboratory, field, SCADA/online), laboratory accreditation number, analyst ID, analysis date/time, QA/QC batch reference, instrument ID for online readings, and monitoring period context. Supports all parameter types including conventional chemistry, DBP species, PFAS compounds, bacteriological presence/absence, turbidity NTU, chlorine residuals, and CT calculations. Links to water_sample for discrete samples and online_instrument for continuous readings. Sourced from LIMS (LabWare) and OSIsoft PI Historian.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` (
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant record. Primary key for the contaminant reference master.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contaminants are defined and regulated by specific regulatory requirements (EPA establishes MCLs, MCLGs, monitoring rules). This link connects contaminant definitions to their authoritative regulatory',
    `action_level_unit` STRING COMMENT 'Unit of measure for the action level value. Common units: mg/L, ug/L.',
    `action_level_value` DECIMAL(18,2) COMMENT 'The concentration of a contaminant which, if exceeded, triggers treatment or other requirements. Primarily used for lead and copper under the Lead and Copper Rule Revisions (LCRR).',
    `analytical_method_code` STRING COMMENT 'EPA-approved analytical method code(s) for laboratory testing of this contaminant. Examples: EPA 200.8 (metals), EPA 524.2 (volatile organics), SM 9223B (coliform).',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to chemical substances. Used for precise identification of chemical contaminants.',
    `ccr_language_template` STRING COMMENT 'Standard EPA-approved language template for describing this contaminant and its health effects in the Consumer Confidence Report. Ensures consistent public communication.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether detection of this contaminant must be reported in the annual Consumer Confidence Report distributed to customers.',
    `contaminant_code` STRING COMMENT 'Standardized short code or abbreviation for the contaminant used in laboratory and reporting systems. Examples: PB, TC, TTHM, PFOA.',
    `contaminant_status` STRING COMMENT 'Current regulatory status of the contaminant in the enterprise taxonomy. Active contaminants are currently monitored; inactive are no longer required; proposed are under rulemaking; withdrawn were removed from regulations.. Valid values are `active|inactive|proposed|withdrawn`',
    `contaminant_type` STRING COMMENT 'Regulatory status indicating whether the contaminant has enforceable standards (regulated), is monitored without enforceable limits (unregulated), is under evaluation (emerging), or has non-enforceable guidelines (secondary).. Valid values are `regulated|unregulated|emerging|secondary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant record was first created in the system.',
    `detection_limit_unit` STRING COMMENT 'Unit of measure for the method detection limit value.',
    `detection_limit_value` DECIMAL(18,2) COMMENT 'The minimum concentration of a substance that can be measured and reported with 99% confidence that the analyte concentration is greater than zero. Laboratory capability threshold.',
    `effective_date` DATE COMMENT 'Date when the current regulatory requirements for this contaminant became or will become effective. Used to track regulatory changes over time.',
    `health_effect_category` STRING COMMENT 'Classification of the primary health impact associated with exposure to this contaminant. Acute effects occur shortly after exposure; chronic effects develop over long-term exposure; carcinogenic contaminants may cause cancer.. Valid values are `acute|chronic|carcinogenic|non_carcinogenic|aesthetic|unknown`',
    `health_effect_description` STRING COMMENT 'Detailed description of known or potential health effects from exposure to this contaminant. Used in Consumer Confidence Reports (CCR) and public communication.',
    `mcl_unit` STRING COMMENT 'Unit of measure for the MCL value. Common units: mg/L (milligrams per liter), ug/L (micrograms per liter), pCi/L (picocuries per liter), MFL (million fibers per liter), NTU (Nephelometric Turbidity Units).',
    `mcl_value` DECIMAL(18,2) COMMENT 'The highest level of a contaminant that is allowed in drinking water. Enforceable standard set by EPA or state primacy agency. Null if no MCL is established.',
    `mclg_unit` STRING COMMENT 'Unit of measure for the MCLG value. Typically matches MCL unit for consistency in comparison.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The level of a contaminant in drinking water below which there is no known or expected risk to health. Non-enforceable public health goal. May be zero for carcinogens.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant record was last modified.',
    `monitoring_frequency_code` STRING COMMENT 'Standard frequency at which this contaminant must be monitored under regulatory requirements. Actual frequency may vary based on system size, source water type, and previous results. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|triennial|variable|not_required — 8 candidates stripped; promote to reference product]',
    `monitoring_location_type` STRING COMMENT 'Standard location(s) in the water system where monitoring for this contaminant is required. Determines sampling point selection for compliance.. Valid values are `source|entry_point|distribution|consumer_tap|treatment_plant|multiple`',
    `contaminant_name` STRING COMMENT 'Official name of the contaminant as recognized by regulatory agencies (EPA, state programs). Examples: Lead, Total Coliform, Trihalomethanes, PFOA.',
    `notes` STRING COMMENT 'Additional notes, special considerations, or clarifications regarding the contaminant, its monitoring requirements, or regulatory interpretation. Free-text field for operational guidance.',
    `npdes_effluent_limit_unit` STRING COMMENT 'Unit of measure for the NPDES effluent limit value.',
    `npdes_effluent_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable concentration in wastewater effluent discharge under NPDES permit requirements. Null if not applicable to wastewater.',
    `public_notification_tier` STRING COMMENT 'EPA public notification tier classification determining the urgency and method of public notification required when violations occur. Tier 1 (most urgent, 24 hours), Tier 2 (30 days), Tier 3 (1 year).. Valid values are `tier_1|tier_2|tier_3|not_applicable`',
    `regulatory_program` STRING COMMENT 'Primary federal or state regulatory program under which this contaminant is monitored and regulated. Determines applicable compliance requirements.. Valid values are `sdwa|cwa|npdes|state_specific|none`',
    `reporting_threshold_unit` STRING COMMENT 'Unit of measure for the reporting threshold value.',
    `reporting_threshold_value` DECIMAL(18,2) COMMENT 'The minimum concentration level at which detection and reporting to regulatory agencies is required. Also known as reporting limit or detection limit for regulatory purposes.',
    `revision_date` DATE COMMENT 'Date when the contaminant record was last revised to reflect regulatory updates, new scientific findings, or data corrections.',
    `source_category` STRING COMMENT 'Primary origin or source of the contaminant in water systems. Helps identify root causes and appropriate mitigation strategies. [ENUM-REF-CANDIDATE: naturally_occurring|industrial|agricultural|municipal|treatment_process|distribution_system|multiple — 7 candidates stripped; promote to reference product]',
    `source_description` STRING COMMENT 'Detailed description of how the contaminant enters water systems. Examples: erosion of natural deposits, discharge from factories, runoff from agricultural operations, byproduct of disinfection, corrosion of household plumbing.',
    `subgroup` STRING COMMENT 'Secondary classification providing more granular categorization within the contaminant group. Examples: THM (within DBP), volatile organic compounds (within organic), coliforms (within microbiological).',
    `treatment_technique_description` STRING COMMENT 'Description of the required treatment technique or process. Examples: filtration, disinfection, corrosion control, specific removal efficiency requirements.',
    `treatment_technique_required` BOOLEAN COMMENT 'Indicates whether a treatment technique is required in lieu of or in addition to an MCL. True if EPA requires specific treatment processes rather than or alongside a numeric limit.',
    `violation_trigger_logic` STRING COMMENT 'Business rule describing when exceedances of limits constitute a regulatory violation. Examples: single sample exceeds MCL, running annual average exceeds MCL, 90th percentile exceeds action level.',
    `wastewater_parameter` BOOLEAN COMMENT 'Indicates whether this contaminant is also monitored as a wastewater effluent parameter under NPDES permits or state discharge requirements.',
    CONSTRAINT pk_contaminant PRIMARY KEY(`contaminant_id`)
) COMMENT 'Reference master for all regulated and monitored water quality parameters including drinking water contaminants, wastewater effluent parameters, and emerging contaminants. Captures contaminant name, CAS number, contaminant group (microbiological, inorganic, organic, radiological, DBP, PFAS), regulatory program (SDWA, CWA, NPDES), applicable limits by regulatory context (MCL, MCLG, action level, treatment technique, permit-specific effluent limits with daily max and monthly average), limit effective and superseded dates, jurisdiction (federal, state primacy agency), reporting threshold, and monitoring frequency requirements. Serves as the enterprise-wide contaminant and parameter taxonomy with versioned regulatory limits.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` (
    `contaminant_limit_id` BIGINT COMMENT 'Unique identifier for the contaminant limit record. Primary key for the contaminant_limit product.',
    `contaminant_id` BIGINT COMMENT 'Reference to the specific contaminant (e.g., lead, arsenic, THM, HAA5, PFAS) for which this limit applies.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Contaminant limits are derived from or enforced under specific permit conditions. Compliance staff must trace which permit condition establishes a given numeric limit for DMR reporting and permit comp',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contaminant limits are set by specific regulatory requirements (e.g., Stage 2 DBPR MCLs, LCR action levels, SWTR turbidity limits). Compliance staff must trace which regulatory requirement establishes',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Regulatory contaminant limits (MCLs, discharge limits) are specified in treatment/discharge permits. Links specific numeric limit to authorizing permit for compliance tracking, permit renewal, and var',
    `analytical_method_required` STRING COMMENT 'EPA-approved analytical method(s) required for measuring this contaminant. Examples: EPA Method 200.8 (metals by ICP-MS), EPA Method 524.2 (VOCs), EPA Method 537.1 (PFAS), Standard Method 2320 (alkalinity), EPA Method 1664A (oil and grease).',
    `applicable_regulation` STRING COMMENT 'Citation of the regulation or rule establishing this limit. Examples: 40 CFR 141.80 (Stage 2 DBPR), 40 CFR 141.51 (MCLs for inorganic contaminants), LCRR 40 CFR 141.80-141.91, state-specific regulation citation, or facility NPDES permit number.',
    `averaging_period` STRING COMMENT 'Time period over which the limit is calculated or averaged. Instantaneous = single sample, daily_max = maximum value in a day, monthly_avg = average over calendar month, quarterly_avg = average over quarter, annual_avg = average over calendar year, running_annual_avg = rolling 12-month average, locational_running_annual_avg = running annual average at specific sampling location (e.g., for DBPs under Stage 2 DBPR). [ENUM-REF-CANDIDATE: instantaneous|daily_max|monthly_avg|quarterly_avg|annual_avg|running_annual_avg|locational_running_annual_avg — 7 candidates stripped; promote to reference product]',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether this contaminant must be included in the annual Consumer Confidence Report (CCR) distributed to drinking water customers. True = must report in CCR, False = not required in CCR.',
    `compliance_status` STRING COMMENT 'Current status of this limit record. Active = currently enforceable, superseded = replaced by newer limit, pending = future effective date not yet reached, suspended = temporarily not enforced due to variance or waiver.. Valid values are `active|superseded|pending|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant limit record was first created in the system. Used for audit trail and data lineage tracking.',
    `detection_limit_required` DECIMAL(18,2) COMMENT 'Minimum detection limit (MDL) or practical quantitation limit (PQL) required for the analytical method. Laboratory results must meet or exceed this sensitivity. Expressed in same unit_of_measure as limit_value.',
    `effective_date` DATE COMMENT 'Date when this contaminant limit became or will become enforceable. Critical for compliance tracking and historical analysis.',
    `exceedance_action_required` STRING COMMENT 'Description of required actions when this limit is exceeded. Examples: Public notification within 24 hours, Implement corrosion control treatment, Increase monitoring frequency, Submit corrective action plan within 30 days, Immediate discharge cessation.',
    `health_effect_category` STRING COMMENT 'Primary health effect category associated with this contaminant. Acute = immediate health impact, chronic = long-term exposure health impact, carcinogen = cancer-causing, developmental = impacts fetal/child development, reproductive = impacts reproductive health, aesthetic = non-health impact (taste, odor, color).. Valid values are `acute|chronic|carcinogen|developmental|reproductive|aesthetic`',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction imposing this limit. Federal = EPA national standard, state = state primacy agency standard (may be more stringent than federal), local = municipal or county requirement, permit_specific = facility-specific limit in NPDES or discharge permit.. Valid values are `federal|state|local|permit_specific`',
    `jurisdiction_authority` STRING COMMENT 'Name of the regulatory authority or agency that issued this limit. Examples: U.S. EPA, California State Water Resources Control Board, Ohio EPA, Local Municipal Authority, or specific permit-issuing agency.',
    `limit_type` STRING COMMENT 'Type of regulatory or operational limit. MCL = Maximum Contaminant Level (enforceable), MCLG = Maximum Contaminant Level Goal (non-enforceable health goal), action_level = threshold triggering corrective action (e.g., Lead and Copper Rule), treatment_technique = required treatment process standard, permit_limit = facility-specific NPDES or discharge permit limit.. Valid values are `mcl|mclg|action_level|treatment_technique|permit_limit`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric threshold value for the contaminant limit. For example, MCL for lead is 0.015 mg/L. Null if limit is qualitative (e.g., treatment technique with no numeric threshold).',
    `monitoring_frequency_required` STRING COMMENT 'Required sampling and analysis frequency for this contaminant at this context. Examples: Quarterly, Monthly, Weekly, Daily, Continuous, Every 3 years, Per compliance schedule. May reference a compliance_schedule record for complex schedules.',
    `notes` STRING COMMENT 'Additional context, clarifications, or special conditions related to this contaminant limit. May include information about seasonal variations, conditional applicability, calculation methods, or references to related compliance obligations.',
    `public_notification_tier` STRING COMMENT 'Public notification tier required when this limit is violated (drinking water only). Tier_1 = immediate notice (within 24 hours) for acute health risk, tier_2 = notice within 30 days for chronic health risk, tier_3 = notice within 1 year for monitoring/reporting violations, not_applicable = no public notification required (e.g., for wastewater limits).. Valid values are `tier_1|tier_2|tier_3|not_applicable`',
    `sample_location_type` STRING COMMENT 'Type of location where samples are collected for comparison against this limit. Entry_point = water entering distribution system, distribution_system = within distribution network, consumer_tap = at customer premise, source_water = raw water intake, effluent_discharge = treated wastewater discharge point, process_intermediate = within treatment process.. Valid values are `entry_point|distribution_system|consumer_tap|source_water|effluent_discharge|process_intermediate`',
    `superseded_date` DATE COMMENT 'Date when this limit was replaced by a newer regulation or permit condition. Null if the limit is currently active. Used for historical compliance analysis and regulatory change tracking.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the limit value. Common units: mg/L (milligrams per liter), ug/L (micrograms per liter), ppm (parts per million), ppb (parts per billion), ppt (parts per trillion), CFU/100mL (colony forming units per 100 milliliters for bacteriological), NTU (Nephelometric Turbidity Units), SU (standard units for pH), mrem/year (millirem per year for radionuclides). [ENUM-REF-CANDIDATE: mg/l|ug/l|ppm|ppb|ppt|cfu/100ml|ntu|su|mrem/year — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant limit record was last modified. Used for audit trail and change tracking.',
    `variance_expiration_date` DATE COMMENT 'Date when the variance or waiver expires and standard limit enforcement resumes. Null if no variance is in effect or if variance is indefinite (subject to periodic review).',
    `variance_waiver_flag` BOOLEAN COMMENT 'Indicates whether a variance or waiver has been granted for this limit at this monitoring context. True = variance/waiver in effect (limit may be temporarily relaxed or monitoring reduced), False = standard limit applies without exception.',
    CONSTRAINT pk_contaminant_limit PRIMARY KEY(`contaminant_limit_id`)
) COMMENT 'Regulatory and operational limits for each contaminant at each applicable monitoring context (drinking water, effluent discharge, source water). Captures MCL, MCLG, action level, treatment technique standard, permit-specific effluent limit (daily max, monthly average), applicable regulation citation, effective date, superseded date, and jurisdiction (federal, state primacy agency). Enables automated compliance comparison against analytical_result values.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` (
    `exceedance_id` BIGINT COMMENT 'Primary key for exceedance',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: MCL exceedances are detected from specific analytical results. Currently has sample_id linking to water_sample, but should also link to the specific analytical_result that triggered the exceedance. Th',
    `contaminant_id` BIGINT COMMENT 'add column contaminant_id (BIGINT) with FK to quality.contaminant.contaminant_id - exceedances are for specific contaminants and direct linkage avoids traversing through analytical_result',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: An exceedance is by definition a violation of a specific regulatory or operational limit. The exceedance record already links to contaminant_id and analytical_result_id (which carries contaminant_limi',
    `lead_copper_result_id` BIGINT COMMENT 'Foreign key linking to quality.lead_copper_result. Business justification: Lead and Copper Rule (LCR/LCRR) exceedances are triggered by lead_copper_result records when the 90th percentile action level is exceeded. The current exceedance model only links to analytical_result,',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: An exceedance is a violation of a specific permit conditions numeric limit or monitoring requirement. Compliance staff must trace which permit condition was exceeded to determine reporting obligation',
    `sampling_point_id` BIGINT COMMENT 'add column quality_sampling_point_id (BIGINT) with FK to quality.quality_sampling_point.quality_sampling_point_id - exceedances occur at specific sampling points and this is needed for spatial analysis',
    CONSTRAINT pk_exceedance PRIMARY KEY(`exceedance_id`)
) COMMENT 'Transactional record of each confirmed MCL, action level, or permit limit exceedance detected from analytical results. Captures exceedance date, contaminant, sampling point, measured value, applicable limit, exceedance magnitude, regulatory notification deadline, public notification requirement flag, corrective action required, and resolution status. This is the primary operational record driving regulatory response workflows and violation tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` (
    `bacteriological_result_id` BIGINT COMMENT 'Unique identifier for the bacteriological test result record.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: RTCR requires utilities to assess coliform occurrence in context of system conditions. AMI endpoint data identifies zero-consumption (stagnation) periods that elevate coliform risk. Linking bacteriolo',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Bacteriological results are for specific contaminants (total coliform, E. coli, fecal coliform, enterococci, HPC). This FK identifies which contaminant the result applies to, enabling proper linkage t',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: bacteriological_result carries mcl_exceeded_flag and compliance_status but has no direct reference to the specific contaminant_limit that defines the MCL being evaluated. Adding contaminant_limit_id l',
    `sampling_point_id` BIGINT COMMENT 'Reference to the location where the sample was collected (distribution system tap, treatment plant, reservoir, etc.).',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Bacteriological samples (total coliform, E. coli) are collected per RTCR-mandated sampling schedules. Links result to regulatory schedule for compliance tracking, repeat sample triggering, and assessm',
    `water_sample_id` BIGINT COMMENT 'Reference to the water quality sample that was tested.',
    `analysis_completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the bacteriological analysis was completed and results were finalized.',
    `analysis_date` DATE COMMENT 'Date when the bacteriological analysis was performed in the laboratory.',
    `analytical_method` STRING COMMENT 'Laboratory analytical method used for bacteriological testing (Membrane Filtration, Colilert, Colisure, MUG, EC-MUG, Multiple Tube Fermentation, Presence-Absence). [ENUM-REF-CANDIDATE: membrane_filtration|colilert|colisure|mug|ec_mug|multiple_tube_fermentation|presence_absence — 7 candidates stripped; promote to reference product]',
    `chain_of_custody_number` STRING COMMENT 'Chain of custody tracking number for the sample from collection through analysis, ensuring sample integrity and traceability.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the result (compliant, non-compliant, exceeds MCL, requires repeat sampling, RTCR assessment triggered).. Valid values are `compliant|non_compliant|exceeds_mcl|requires_repeat|assessment_triggered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bacteriological result record was first created in the system.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Dilution factor applied to the sample during analysis, used to calculate final concentration from raw counts.',
    `e_coli_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for E. coli bacteria expressed as Colony Forming Units per 100 mL when membrane filtration method is used.',
    `e_coli_mpn` DECIMAL(18,2) COMMENT 'Quantitative result for E. coli bacteria expressed as Most Probable Number per 100 mL when enumeration method is used.',
    `e_coli_result` STRING COMMENT 'Presence or absence result for E. coli bacteria in the sample.. Valid values are `present|absent`',
    `enterococci_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for enterococci bacteria expressed as Colony Forming Units per 100 mL.',
    `enterococci_result` STRING COMMENT 'Presence or absence result for enterococci bacteria, typically used for wastewater and recreational water monitoring.. Valid values are `present|absent`',
    `fecal_coliform_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for fecal coliform bacteria expressed as Colony Forming Units per 100 mL.',
    `fecal_coliform_result` STRING COMMENT 'Presence or absence result for fecal coliform bacteria in the sample (legacy parameter, replaced by E. coli under RTCR).. Valid values are `present|absent`',
    `hpc_result` DECIMAL(18,2) COMMENT 'Quantitative result for Heterotrophic Plate Count expressed as Colony Forming Units per milliliter (CFU/mL), used to assess general bacterial population and treatment effectiveness.',
    `incubation_duration_hours` DECIMAL(18,2) COMMENT 'Duration in hours for which the sample was incubated during analysis (typically 24 or 48 hours depending on method).',
    `incubation_temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius at which the sample was incubated during analysis (typically 35°C or 44.5°C depending on test type).',
    `invalidation_reason` STRING COMMENT 'Reason for invalidating the test result if result_status is invalidated (e.g., contamination, procedural error, equipment failure).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bacteriological result record was last modified or updated.',
    `mcl_exceeded_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the result exceeded the Maximum Contaminant Level for the tested parameter.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result triggers a public notification requirement under SDWA.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result must be included in regulatory compliance reporting to EPA or state primacy agency.',
    `repeat_sample_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether RTCR requires repeat sampling due to a positive total coliform result.',
    `result_comments` STRING COMMENT 'Free-text comments from the analyst regarding the test result, including observations, anomalies, or special conditions.',
    `result_status` STRING COMMENT 'Current status of the bacteriological test result in the laboratory workflow (preliminary, final, verified, invalidated, pending review).. Valid values are `preliminary|final|verified|invalidated|pending_review`',
    `rtcr_assessment_level` STRING COMMENT 'RTCR assessment level triggered by the result (none, Level 1 Assessment, Level 2 Assessment) based on coliform detection patterns.. Valid values are `none|level_1|level_2`',
    `sample_collection_date` DATE COMMENT 'Date when the water sample was collected from the sampling point.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the water sample was collected, including time of day.',
    `sample_type` STRING COMMENT 'Classification of the sample within the monitoring program (routine, repeat, triggered, investigative, special).. Valid values are `routine|repeat|triggered|investigative|special`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the water sample in milliliters that was analyzed.',
    `test_type` STRING COMMENT 'Type of bacteriological test performed (Total Coliform, E. coli, Fecal Coliform, Heterotrophic Plate Count, Enterococci, or Combined TCR/RTCR).. Valid values are `total_coliform|e_coli|fecal_coliform|hpc|enterococci|combined_tcr`',
    `total_coliform_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for total coliform bacteria expressed as Colony Forming Units per 100 mL when membrane filtration method is used.',
    `total_coliform_mpn` DECIMAL(18,2) COMMENT 'Quantitative result for total coliform bacteria expressed as Most Probable Number per 100 mL when enumeration method is used.',
    `total_coliform_result` STRING COMMENT 'Presence or absence result for total coliform bacteria in the sample.. Valid values are `present|absent`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the result was verified and approved by quality assurance personnel.',
    CONSTRAINT pk_bacteriological_result PRIMARY KEY(`bacteriological_result_id`)
) COMMENT 'Specialized transactional record for bacteriological testing results including Total Coliform Rule (TCR), Revised Total Coliform Rule (RTCR), and E. coli monitoring. Captures sample date, sampling point, total coliform presence/absence or MPN count, E. coli presence/absence, fecal coliform result, HPC (Heterotrophic Plate Count), analytical method (membrane filtration, Colilert), incubation temperature/time, and triggered repeat sampling requirement. Distinct from general analytical_result due to presence/absence reporting and RTCR Level 1/Level 2 assessment triggers.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` (
    `lead_copper_result_id` BIGINT COMMENT 'Unique identifier for the lead and copper sampling result record.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: LCR first-draw sampling requires documented stagnation time. AMI endpoint interval data provides actual consumption history to validate stagnation_time_hours on lead_copper_result. Regulators expect u',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Lead and copper results are for specific contaminants (lead or copper). This FK identifies which contaminant the result applies to, enabling proper linkage to contaminant limits and regulatory require',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: lead_copper_result carries lead_action_level_exceeded and copper_action_level_exceeded boolean flags but has no direct reference to the specific contaminant_limit defining those action levels. Adding ',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lead and Copper Rule explicitly requires sampling at customer taps with documented service line materials. Meter installation is the sampling location for tier classification, 90th percentile calculat',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Lead and Copper Rule requires sampling at customer taps (service points) with specific site selection criteria based on service line material and building age. Service point linkage is mandatory for 9',
    `sampling_point_id` BIGINT COMMENT 'Reference to the customer tap location selected for Lead and Copper Rule monitoring.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Lead/copper monitoring follows LCR sampling rounds with specific site selection and frequency requirements. Links result to regulatory schedule for 90th percentile calculation, action level exceedance',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Lead/copper sampling requires precise service address tracking for tier site selection, customer notification within 30 days of result, and LCRR compliance documentation. Already has customer_account_',
    `analysis_date` DATE COMMENT 'Date when the laboratory completed the lead and copper analysis.',
    `analysis_method` STRING COMMENT 'EPA-approved analytical method used for lead and copper determination (e.g., EPA 200.8 ICP-MS, EPA 200.9 ICP-AES).. Valid values are `EPA_200.8|EPA_200.9|ASTM_D3559`',
    `copper_action_level_exceeded` BOOLEAN COMMENT 'Indicates whether the copper result exceeds the EPA action level of 1300 ppb (1.3 mg/L), triggering potential corrosion control treatment requirements.',
    `copper_result_ppb` DECIMAL(18,2) COMMENT 'Measured concentration of copper in the water sample expressed in parts per billion (ppb or µg/L). Used for 90th percentile calculation and action level comparison.',
    `corrosion_control_treatment_status` STRING COMMENT 'Status of corrosion control treatment optimization at the time of sampling, indicating whether the water system has optimized corrosion control per LCRR requirements.. Valid values are `optimal|suboptimal|not_optimized|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead and copper result record was first created in the system.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified of their individual lead and copper sample result.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether the customer was notified of their individual sample result as required by LCRR within 30 days of receiving results.',
    `detection_limit_copper_ppb` DECIMAL(18,2) COMMENT 'Minimum concentration of copper that the analytical method can reliably detect and quantify for this sample.',
    `detection_limit_lead_ppb` DECIMAL(18,2) COMMENT 'Minimum concentration of lead that the analytical method can reliably detect and quantify for this sample.',
    `holding_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the EPA-required holding time (6 months for metals) from collection to analysis.',
    `included_in_90th_percentile` BOOLEAN COMMENT 'Indicates whether this result was included in the 90th percentile calculation for LCRR compliance determination. Invalid or QC-failed samples are excluded.',
    `lead_action_level_exceeded` BOOLEAN COMMENT 'Indicates whether the lead result exceeds the EPA action level of 15 ppb, triggering potential corrosion control treatment requirements.',
    `lead_result_ppb` DECIMAL(18,2) COMMENT 'Measured concentration of lead in the water sample expressed in parts per billion (ppb or µg/L). Used for 90th percentile calculation and action level comparison.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead and copper result record was last updated in the system.',
    `quality_control_status` STRING COMMENT 'Laboratory quality control status indicating whether the sample result passed all QC checks including blanks, duplicates, and spike recoveries.. Valid values are `passed|failed|pending`',
    `regulatory_reporting_status` STRING COMMENT 'Status of this result in the regulatory reporting workflow to state primacy agency and EPA.. Valid values are `pending|submitted|accepted|rejected`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the sample collection or analysis.',
    `sample_collection_date` DATE COMMENT 'Date when the first-draw water sample was collected at the customer tap.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the first-draw water sample was collected, including time of day to verify minimum stagnation period compliance.',
    `sample_ph` DECIMAL(18,2) COMMENT 'pH measurement of the water sample at collection, relevant for corrosion control assessment.',
    `sample_preservation_method` STRING COMMENT 'Method used to preserve the sample for metals analysis, typically acidification with nitric acid to pH < 2.. Valid values are `nitric_acid|unpreserved`',
    `sample_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature at the time of sample collection, recorded to document field conditions.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the first-draw water sample collected, typically 1 liter (1000 mL) per LCRR protocol.',
    `service_line_material` STRING COMMENT 'Material composition of the customer service line as classified under LCRR for site selection and tiering. [ENUM-REF-CANDIDATE: lead|galvanized_requiring_replacement|lead_status_unknown|non_lead|copper|plastic|steel|iron|unknown — promote to reference product]',
    `site_tier` STRING COMMENT 'LCRR-mandated tier classification of the sampling site based on service line material and building construction date (Tier 1: lead service lines, Tier 2: lead status unknown, Tier 3: non-lead).. Valid values are `tier_1|tier_2|tier_3`',
    `stagnation_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours that water remained stagnant in the service line prior to sample collection. LCRR requires minimum 6-hour stagnation for first-draw samples.',
    CONSTRAINT pk_lead_copper_result PRIMARY KEY(`lead_copper_result_id`)
) COMMENT 'Specialized transactional record for Lead and Copper Rule (LCR/LCRR) monitoring at customer tap sampling sites. Captures sampling round (6-month period), customer service line material classification (lead, galvanized, copper, unknown), first-draw sample result (lead ppb, copper ppb), 90th percentile calculation inputs, action level exceedance flag (lead >15 ppb, copper >1300 ppb), tier classification of sampling site, and corrosion control treatment optimization status. Distinct from general analytical_result due to LCRR-specific site selection, tiering, and 90th percentile compliance methodology.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_parent_sample_water_sample_id` FOREIGN KEY (`parent_sample_water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_lead_copper_result_id` FOREIGN KEY (`lead_copper_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`lead_copper_result`(`lead_copper_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'public|restricted|private_property|confined_space|remote');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `ccr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `dmr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Gallons Per Minute - GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `last_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_name` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `primary_contaminant_group` SET TAGS ('dbx_business_glossary_term' = 'Primary Contaminant Group');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Monitoring Zone');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `residence_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Residence Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `safety_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous_monitor|passive_sampler');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Sampler Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Sampling Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_status` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_suspended|decommissioned');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Stage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|groundwater_under_influence|blended|purchased|recycled');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `annual_budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Allocation (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `annual_budget_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|at_risk|non_compliant|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Sample (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `last_sample_collected_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collected Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `regulatory_rule` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rule');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous|integrated');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (mL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `samples_collected_ytd` SET TAGS ('dbx_business_glossary_term' = 'Samples Collected Year-to-Date (YTD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `samples_per_period` SET TAGS ('dbx_business_glossary_term' = 'Samples Per Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `samples_required_ytd` SET TAGS ('dbx_business_glossary_term' = 'Samples Required Year-to-Date (YTD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|completed|cancelled|pending_approval|expired');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'regulatory|operational|investigational|special_study|compliance_verification|routine');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `seasonal_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `parent_sample_water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sample Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `analysis_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Due Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `composite_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Composite Sample Duration in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `composite_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Composite Sample Interval in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `container_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Container Volume in Milliliters (mL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `field_chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Chlorine Residual in Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `field_conductivity_us_cm` SET TAGS ('dbx_business_glossary_term' = 'Field Conductivity in Microsiemens per Centimeter (µS/cm)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `field_dissolved_oxygen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Dissolved Oxygen (DO) in Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `field_ph` SET TAGS ('dbx_business_glossary_term' = 'Field Potential of Hydrogen (pH)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `field_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Field Temperature in Celsius (°C)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `field_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Field Turbidity in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Gallons per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `hold_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Sample Hold Time in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `lims_submission_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Submission Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `requested_analysis_group` SET TAGS ('dbx_business_glossary_term' = 'Requested Analysis Group');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_value_regex' = 'drinking_water|raw_water|treated_water|distribution_water|wastewater_influent|wastewater_effluent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_purpose` SET TAGS ('dbx_business_glossary_term' = 'Sample Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|field_blank|duplicate|split|trip_blank');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sampler_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Sampler Equipment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Collection');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `compliance_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Compliance Limit Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `data_validation_level` SET TAGS ('dbx_business_glossary_term' = 'Data Validation Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `data_validation_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `hold_time_compliant` SET TAGS ('dbx_business_glossary_term' = 'Hold Time Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `hold_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Time Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `lims_result_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Percent Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `qualifier_code` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `quantitation_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Quantitation Limit (MQL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Relative Percent Difference (RPD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|approved|rejected|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `validated_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `action_level_unit` SET TAGS ('dbx_business_glossary_term' = 'Action Level Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `action_level_value` SET TAGS ('dbx_business_glossary_term' = 'Action Level Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `analytical_method_code` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `ccr_language_template` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Language Template');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_code` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_status` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|proposed|withdrawn');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_type` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_type` SET TAGS ('dbx_value_regex' = 'regulated|unregulated|emerging|secondary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `detection_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `detection_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_value_regex' = 'acute|chronic|carcinogenic|non_carcinogenic|aesthetic|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `mcl_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `mclg_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `monitoring_frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `monitoring_location_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `monitoring_location_type` SET TAGS ('dbx_value_regex' = 'source|entry_point|distribution|consumer_tap|treatment_plant|multiple');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `npdes_effluent_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Effluent Limit Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `npdes_effluent_limit_value` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Effluent Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Tier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_value_regex' = 'sdwa|cwa|npdes|state_specific|none');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `reporting_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `reporting_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Source Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `source_description` SET TAGS ('dbx_business_glossary_term' = 'Source Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `subgroup` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Subgroup');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `violation_trigger_logic` SET TAGS ('dbx_business_glossary_term' = 'Violation Trigger Logic');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `wastewater_parameter` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Parameter Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `analytical_method_required` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `averaging_period` SET TAGS ('dbx_business_glossary_term' = 'Averaging Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'active|superseded|pending|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `detection_limit_required` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `exceedance_action_required` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_value_regex' = 'acute|chronic|carcinogen|developmental|reproductive|aesthetic');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|local|permit_specific');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `jurisdiction_authority` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Authority');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'mcl|mclg|action_level|treatment_technique|permit_limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `monitoring_frequency_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Tier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `sample_location_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `sample_location_type` SET TAGS ('dbx_value_regex' = 'entry_point|distribution_system|consumer_tap|source_water|effluent_discharge|process_intermediate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `variance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Variance Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `variance_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance or Waiver Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `exceedance_id` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `lead_copper_result_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Copper Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `bacteriological_result_id` SET TAGS ('dbx_business_glossary_term' = 'Bacteriological Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `analysis_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exceeds_mcl|requires_repeat|assessment_triggered');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `e_coli_cfu` SET TAGS ('dbx_business_glossary_term' = 'E. coli Colony Forming Units (CFU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `e_coli_mpn` SET TAGS ('dbx_business_glossary_term' = 'E. coli Most Probable Number (MPN)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `e_coli_result` SET TAGS ('dbx_business_glossary_term' = 'E. coli Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `e_coli_result` SET TAGS ('dbx_value_regex' = 'present|absent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `enterococci_cfu` SET TAGS ('dbx_business_glossary_term' = 'Enterococci Colony Forming Units (CFU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `enterococci_result` SET TAGS ('dbx_business_glossary_term' = 'Enterococci Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `enterococci_result` SET TAGS ('dbx_value_regex' = 'present|absent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `fecal_coliform_cfu` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform Colony Forming Units (CFU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `fecal_coliform_result` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `fecal_coliform_result` SET TAGS ('dbx_value_regex' = 'present|absent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `hpc_result` SET TAGS ('dbx_business_glossary_term' = 'Heterotrophic Plate Count (HPC) Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `incubation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Incubation Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `incubation_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Incubation Temperature (Celsius)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `invalidation_reason` SET TAGS ('dbx_business_glossary_term' = 'Invalidation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `mcl_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `repeat_sample_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Sample Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `result_comments` SET TAGS ('dbx_business_glossary_term' = 'Result Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|verified|invalidated|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `rtcr_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Revised Total Coliform Rule (RTCR) Assessment Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `rtcr_assessment_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Time');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'routine|repeat|triggered|investigative|special');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (Milliliters)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'total_coliform|e_coli|fecal_coliform|hpc|enterococci|combined_tcr');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `total_coliform_cfu` SET TAGS ('dbx_business_glossary_term' = 'Total Coliform Colony Forming Units (CFU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `total_coliform_mpn` SET TAGS ('dbx_business_glossary_term' = 'Total Coliform Most Probable Number (MPN)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `total_coliform_result` SET TAGS ('dbx_business_glossary_term' = 'Total Coliform Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `total_coliform_result` SET TAGS ('dbx_value_regex' = 'present|absent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_copper_result_id` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_value_regex' = 'EPA_200.8|EPA_200.9|ASTM_D3559');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `copper_action_level_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Copper Action Level Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `copper_result_ppb` SET TAGS ('dbx_business_glossary_term' = 'Copper Concentration Result (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Control Treatment Optimization Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_value_regex' = 'optimal|suboptimal|not_optimized|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `detection_limit_copper_ppb` SET TAGS ('dbx_business_glossary_term' = 'Copper Method Detection Limit (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `detection_limit_lead_ppb` SET TAGS ('dbx_business_glossary_term' = 'Lead Method Detection Limit (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `holding_time_compliant` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `included_in_90th_percentile` SET TAGS ('dbx_business_glossary_term' = 'Included in 90th Percentile Calculation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_action_level_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Lead Action Level Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_result_ppb` SET TAGS ('dbx_business_glossary_term' = 'Lead Concentration Result (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Sample Result Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_ph` SET TAGS ('dbx_business_glossary_term' = 'Sample pH (Potential of Hydrogen)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_preservation_method` SET TAGS ('dbx_value_regex' = 'nitric_acid|unpreserved');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature (Celsius)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (Milliliters)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_line_material` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `stagnation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Water Stagnation Time (Hours)');
