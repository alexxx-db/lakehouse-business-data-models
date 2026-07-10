-- Schema for Domain: quality | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`quality` COMMENT 'Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` (
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the water quality sampling location. Primary key for the sampling point registry.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Sampling points are established or modified during CIP projects (new treatment plants, distribution expansions). Project closeout requires documenting new sampling points per regulatory permit conditi',
    `compliance_permit_id` BIGINT COMMENT 'The NPDES permit number, SDWA public water system ID, or Industrial User Permit (IUP) number associated with this sampling point for regulatory compliance tracking.',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility (WTP, WWTP, pump station, reservoir) where this sampling point is located, if applicable.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Permanent sampling points (stations, buildings, infrastructure) are capital assets requiring depreciation and inclusion in utility rate base for rate case proceedings—essential for capital asset track',
    `registry_id` BIGINT COMMENT 'Reference to the specific physical asset (pipe segment, valve, tank, treatment unit) at which sampling occurs, if applicable. Links to asset registry for maintenance correlation.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Sampling points are physically located at customer service addresses for distribution system monitoring, lead/copper compliance sampling, and RTCR investigations. SDWA regulatory requirement for site-',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Sampling points are geographically located within service territories for regulatory zone compliance reporting, CCR preparation, and operational monitoring jurisdiction. Water utilities organize sampl',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: A sampling point belongs to a single water system; linking provides hierarchy for reporting and compliance tracking.',
    `asset_sampling_point_id` BIGINT COMMENT '',
    `access_type` STRING COMMENT 'Classification of physical access requirements for sampling personnel. Public = open access; restricted = requires authorization; private property = requires owner permission; confined space = requires confined space entry procedures; remote = difficult to reach, may require special equipment.. Valid values are `public|restricted|private_property|confined_space|remote`',
    `ccr_reporting_flag` BOOLEAN COMMENT 'Indicates whether water quality results from this sampling point must be included in the annual Consumer Confidence Report (CCR) to customers. True = included in CCR; False = not included.',
    `comments` STRING COMMENT 'Additional notes, historical context, or operational observations about this sampling point that do not fit other structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sampling point record was first created in the system.',
    `decommission_date` DATE COMMENT 'The date when this sampling point was permanently retired from service. Null if still active or temporarily suspended.',
    `dma_code` STRING COMMENT 'The District Metered Area (DMA) code to which this sampling point belongs, used for Non-Revenue Water (NRW) analysis and pressure zone management.',
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
    `next_scheduled_sample_date` DATE COMMENT 'The next planned date for sample collection at this location based on the regulatory or operational sampling schedule.',
    `pressure_zone` STRING COMMENT 'The hydraulic pressure zone within the distribution network where this sampling point is located. Used for hydraulic modeling and water quality correlation analysis.',
    `primary_contaminant_group` STRING COMMENT 'The primary category of contaminants monitored at this sampling point (e.g., Microbiological, Disinfection Byproducts, Inorganic Chemicals, Organic Chemicals, Radionuclides, Nutrients, Metals). Used to organize sampling schedules and laboratory workflows.',
    `regulatory_zone` STRING COMMENT 'The regulatory monitoring zone or district to which this sampling point is assigned for compliance reporting purposes. Used to aggregate results for Consumer Confidence Report (CCR) and Discharge Monitoring Report (DMR).',
    `residence_time_hours` DECIMAL(18,2) COMMENT 'The estimated water residence time in hours from the treatment plant to this sampling point in the distribution system. Critical for disinfection Contact Time (CT) calculations and Disinfection Byproduct (DBP) formation analysis.',
    `responsible_department` STRING COMMENT 'The internal department or division responsible for sampling at this location (e.g., Water Quality Lab, Distribution Operations, Wastewater Operations, Compliance).',
    `safety_notes` STRING COMMENT 'Safety considerations and hazards specific to this sampling location (e.g., confined space, traffic hazards, chemical exposure, biological hazards, electrical equipment).',
    `sample_collection_method` STRING COMMENT 'The method by which samples are collected at this point. Grab = single point-in-time sample; composite = time- or flow-weighted composite over a period; continuous monitor = automated real-time sensor; passive sampler = diffusion-based accumulation.. Valid values are `grab|composite|continuous_monitor|passive_sampler`',
    `sampler_name` STRING COMMENT 'The name of the primary field technician or automated sampler equipment responsible for routine sample collection at this location. Used for quality assurance and chain-of-custody tracking.',
    `sampling_frequency` STRING COMMENT 'The regulatory or operational frequency at which samples must be collected from this location. Continuous = real-time monitoring (e.g., SCADA); event-based = triggered by specific conditions (e.g., storm events, process upsets). [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual|event_based — 8 candidates stripped; promote to reference product]',
    `sampling_instructions` STRING COMMENT 'Detailed field instructions for sample collection at this location, including access directions, safety precautions, flushing procedures, bottle types, preservation requirements, and any site-specific protocols.',
    `sampling_point_code` STRING COMMENT 'Externally-known unique business identifier for the sampling location, used in regulatory reporting and laboratory requisitions. Typically follows EPA or state-specific coding conventions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sampling_point_name` STRING COMMENT 'Human-readable name or label for the sampling location (e.g., Main Street Entry Point, WTP Clearwell Outlet, WWTP Final Effluent).',
    `sampling_point_status` STRING COMMENT 'Current operational status of the sampling point. Active = in regular use; inactive = not currently sampled but may be reactivated; temporarily suspended = short-term pause (e.g., construction); decommissioned = permanently retired.. Valid values are `active|inactive|temporarily_suspended|decommissioned`',
    `scada_tag` STRING COMMENT 'The SCADA system tag or point identifier for continuous monitoring instruments at this sampling location. Used to link laboratory results with real-time process data from OSIsoft PI Historian or similar systems.',
    `treatment_stage` STRING COMMENT 'For WTP or WWTP process sampling points, the specific treatment stage being monitored (e.g., Raw Intake, Coagulation, Sedimentation, Filtration, Disinfection, Clearwell, Primary Treatment, Secondary Treatment, Tertiary Treatment, UV Disinfection, Reverse Osmosis). Null for distribution or source sampling points.',
    `water_source_type` STRING COMMENT 'The type of water source from which this sampling point draws or monitors. Surface water = rivers, lakes, reservoirs; groundwater = wells, aquifers; groundwater under influence = groundwater influenced by surface water; blended = mix of sources; purchased = water bought from another utility; recycled = reclaimed wastewater.. Valid values are `surface_water|groundwater|groundwater_under_influence|blended|purchased|recycled`',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this sampling point record.',
    CONSTRAINT pk_quality_sampling_point PRIMARY KEY(`quality_sampling_point_id`)
) COMMENT 'Master registry of all approved water quality sampling locations across the utilitys infrastructure including distribution system sites, source water intakes, WTP/WWTP process points, and wastewater effluent discharge outfalls. Captures location type (entry point, distribution, source, effluent, customer tap), GIS coordinates, regulatory monitoring zone classification, DMA assignment, pressure zone, LCRR tier classification for tap sites, associated permit or CCR reporting requirements, and activation/deactivation status. Serves as the authoritative SSOT for where samples are collected and links to sampling_schedule for monitoring requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` (
    `sampling_schedule_id` BIGINT COMMENT 'Unique identifier for the sampling schedule record. Primary key.',
    `contaminant_group_id` BIGINT COMMENT 'Reference to the contaminant or parameter group being monitored (e.g., DBPs, PFAS, bacteriological, metals, nutrients).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sampling schedules track annual_budget_allocation and cost_per_sample; linking to cost_center enables budget variance analysis and cost allocation for regulatory monitoring programs—essential for comp',
    `location_id` BIGINT COMMENT 'Reference to the physical location where samples are collected (e.g., treatment plant, distribution point, discharge point).',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Sampling schedules operationalize compliance obligations (permit monitoring requirements, consent order milestones). This link connects operational monitoring plans to formal compliance commitments, e',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the physical location where samples are collected (e.g., treatment plant, distribution point, discharge point).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Sampling schedules are driven by specific regulatory requirements (SDWA monitoring frequencies, RTCR rules, LCR sampling). This link documents the regulatory basis for each monitoring schedule, essent',
    `crew_id` BIGINT COMMENT 'Reference to the field crew or team responsible for collecting samples under this schedule.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Qualitys sampling schedules implement laboratorys approved sampling plans. Compliance monitoring requires linking schedule execution to approved plans for UCMR, RTCR, LCR, and NPDES permit complianc',
    `vendor_id` BIGINT COMMENT 'Reference to the laboratory responsible for analyzing samples collected under this schedule (internal lab or contracted external lab).',
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
    `chain_of_custody_id` BIGINT COMMENT 'Foreign key linking to laboratory.chain_of_custody. Business justification: Every water sample transferred to laboratory requires chain of custody documentation per EPA and state regulations. Links field sample to laboratory custody record for sample integrity verification an',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Commissioning and construction acceptance require project-specific water sampling (disinfection validation, bacteriological clearance before placing new mains in service). Project managers must track',
    `point_id` BIGINT COMMENT 'Reference to the regulatory compliance monitoring point associated with this sample, if applicable. Links sample to specific permit or regulatory obligation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sample collection incurs labor, materials, and equipment costs that utilities allocate to departmental cost centers for budgeting, variance reporting, and rate case cost-of-service documentation—stand',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Field-collected water samples are submitted to laboratory for analysis, creating lab_sample records. Chain of custody workflow requires linking field sample to lab sample for regulatory compliance and',
    `parent_sample_water_sample_id` BIGINT COMMENT 'For duplicate or split samples, reference to the original parent sample from which this sample was derived. Null for primary samples.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or technician who collected the sample in the field or at the process point.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the physical location or monitoring point where the sample was collected (e.g., treatment plant inlet, distribution system tap, wastewater effluent discharge point).',
    `registry_id` BIGINT COMMENT 'Reference to the automatic sampler or field equipment used to collect the sample, if applicable. Supports equipment calibration tracking and quality assurance.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Water samples collected at customer premises for compliance monitoring (lead/copper rule, bacteriological sampling, customer complaint investigations). Required for customer notification and site-spec',
    `vendor_id` BIGINT COMMENT 'Reference to the laboratory facility that will perform or has performed the analysis. May be internal lab or external contract lab.',
    `water_employee_id` BIGINT COMMENT 'Reference to the employee or technician who collected the sample in the field or at the process point.',
    `water_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified this sample record. Supports audit trail and accountability.',
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
    `certified_analyst_id` BIGINT COMMENT 'Identifier of the laboratory analyst who performed the analysis. Used for quality assurance, training tracking, and accountability.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: analytical_result currently has analyte_name and cas_number as free-text attributes. These should reference the contaminant master table for standardization, regulatory alignment, and to enable proper',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: Lab analytical results are compared against applicable regulatory limits for compliance determination. Links result to specific limit used for MCL/AL exceedance evaluation, public notification trigger',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Laboratory analysis represents significant operating expense; utilities track lab costs by cost center for budget management, rate case justification, and regulatory cost recovery—critical for O&M exp',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory analyst who performed the analysis. Used for quality assurance, training tracking, and accountability.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the laboratory instrument used for the analysis (e.g., ICP-MS, GC-MS, spectrophotometer). Used for calibration tracking and quality control.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lab analytical results for customer tap samples (lead, copper, bacteriological) must link to meter installation for customer notification, compliance reporting, and corrosion control program effective',
    `qaqc_batch_id` BIGINT COMMENT 'Reference to the QA/QC batch in which this sample was analyzed. Links to batch-level quality control samples (blanks, duplicates, spikes, standards).',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Qualitys validated analytical results must trace back to laboratorys raw test_result records for audit trail, data validation workflows, and regulatory defensibility. Required for NELAC/TNI complian',
    `vendor_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the analysis. May be internal lab or external contract lab.',
    `water_sample_id` BIGINT COMMENT 'Reference to the water sample that was analyzed to produce this result. Links to the sample collection event.',
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
    `analyte_id` BIGINT COMMENT 'Foreign key linking to laboratory.analyte. Business justification: Qualitys contaminant master (regulatory perspective: MCLs, health effects) maps to laboratorys analyte master (analytical perspective: methods, detection limits). Same chemical species, different co',
    `contaminant_group_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_group. Business justification: Contaminants are organized into groups; replacing the free‑text column with a foreign key enforces referential integrity and enables group‑level analytics.',
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
    `monitoring_context_id` BIGINT COMMENT 'Reference to the monitoring context where this limit applies (e.g., drinking water distribution, source water intake, wastewater effluent discharge point).',
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
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Quality exceedances (MCL, action level violations) trigger formal compliance violations that require regulatory reporting, public notification, and enforcement response. This link connects water quali',
    `contaminant_id` BIGINT COMMENT 'add column contaminant_id (BIGINT) with FK to quality.contaminant.contaminant_id - exceedances are for specific contaminants and direct linkage avoids traversing through analytical_result',
    `quality_sampling_point_id` BIGINT COMMENT 'add column quality_sampling_point_id (BIGINT) with FK to quality.quality_sampling_point.quality_sampling_point_id - exceedances occur at specific sampling points and this is needed for spatial analysis',
    CONSTRAINT pk_exceedance PRIMARY KEY(`exceedance_id`)
) COMMENT 'Transactional record of each confirmed MCL, action level, or permit limit exceedance detected from analytical results. Captures exceedance date, contaminant, sampling point, measured value, applicable limit, exceedance magnitude, regulatory notification deadline, public notification requirement flag, corrective action required, and resolution status. This is the primary operational record driving regulatory response workflows and violation tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` (
    `dbp_monitoring_event_id` BIGINT COMMENT 'Unique identifier for the disinfection byproduct monitoring event record.',
    `point_id` BIGINT COMMENT 'Reference to the compliance monitoring point where the DBP sample was collected.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DBP monitoring is a recurring compliance cost with dedicated budget allocation; linking to cost_center enables tracking of Stage 2 DBPR compliance costs for regulatory reporting and rate case cost rec',
    `lab_sample_id` BIGINT COMMENT 'The unique sample identifier assigned by the laboratory for tracking and chain of custody.',
    `territory_id` BIGINT COMMENT 'Reference to the public water system subject to DBP monitoring requirements.',
    `vendor_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the DBP analysis.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: DBP monitoring events are based on water samples collected and analyzed. Currently has lab_sample_id (cross-domain to laboratory). Adding water_sample_id establishes the in-domain link to the quality',
    `water_system_id` BIGINT COMMENT 'Reference to the public water system subject to DBP monitoring requirements.',
    `analysis_completion_date` DATE COMMENT 'The date when the laboratory completed the DBP analysis and reported results.',
    `bromide_concentration_mg_l` DECIMAL(18,2) COMMENT 'The bromide ion concentration in milligrams per liter, which influences the formation of brominated DBP species.',
    `bromodichloromethane_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of bromodichloromethane (CHBrCl2), a trihalomethane species, in micrograms per liter.',
    `bromoform_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of bromoform (CHBr3), a trihalomethane species, in micrograms per liter.',
    `ccr_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this monitoring event result is included in the annual Consumer Confidence Report.',
    `chloroform_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of chloroform (CHCl3), a trihalomethane species, in micrograms per liter.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DBP monitoring event record was first created in the system.',
    `dibromoacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of dibromoacetic acid (DBAA), a haloacetic acid species, in micrograms per liter.',
    `dibromochloromethane_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of dibromochloromethane (CHBr2Cl), a trihalomethane species, in micrograms per liter.',
    `dichloroacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of dichloroacetic acid (DCAA), a haloacetic acid species, in micrograms per liter.',
    `free_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'The free chlorine residual measured at the time of sample collection, in milligrams per liter, which influences DBP formation.',
    `haa5_compliance_status` STRING COMMENT 'Indicates whether the HAA5 LRAA at this monitoring point is in compliance with the MCL.. Valid values are `compliant|non-compliant|pending|under_review`',
    `haa5_concentration_ug_l` DECIMAL(18,2) COMMENT 'Sum of the five regulated haloacetic acid species (MCAA, DCAA, TCAA, MBAA, DBAA) in micrograms per liter.',
    `haa5_lraa_ug_l` DECIMAL(18,2) COMMENT 'The locational running annual average of HAA5 concentrations at this monitoring point, calculated as the arithmetic average of the current quarter and the previous three quarters.',
    `haa5_mcl_ug_l` DECIMAL(18,2) COMMENT 'The applicable HAA5 maximum contaminant level for this monitoring event, typically 60 µg/L under Stage 2 DBPR.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this DBP monitoring event record was last updated in the system.',
    `monitoring_frequency` STRING COMMENT 'The required monitoring frequency for this location under Stage 2 DBPR, which may vary based on system size and historical compliance.. Valid values are `quarterly|annual|reduced|increased`',
    `monitoring_period_end_date` DATE COMMENT 'The last day of the monitoring period (typically quarterly) for which this DBP sample applies.',
    `monitoring_period_start_date` DATE COMMENT 'The first day of the monitoring period (typically quarterly) for which this DBP sample applies.',
    `monobromoacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of monobromoacetic acid (MBAA), a haloacetic acid species, in micrograms per liter.',
    `monochloroacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of monochloroacetic acid (MCAA), a haloacetic acid species, in micrograms per liter.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the monitoring event, sample collection, or analysis results.',
    `ph_value` DECIMAL(18,2) COMMENT 'The pH value of the water sample at the time of collection, which influences DBP speciation and formation.',
    `reported_to_state_date` DATE COMMENT 'The date when this monitoring event result was reported to the state primacy agency.',
    `reported_to_state_flag` BOOLEAN COMMENT 'Indicates whether this monitoring event result has been reported to the state primacy agency.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'The precise date and time when the DBP water sample was collected from the monitoring point.',
    `sample_type` STRING COMMENT 'Classification of the sample purpose: routine compliance monitoring, confirmation of exceedance, investigative, or special study.. Valid values are `routine|confirmation|investigative|special`',
    `system_wide_haa5_raa_ug_l` DECIMAL(18,2) COMMENT 'The system-wide running annual average of HAA5 concentrations across all monitoring points, used for overall system compliance assessment.',
    `system_wide_tthm_raa_ug_l` DECIMAL(18,2) COMMENT 'The system-wide running annual average of TTHM concentrations across all monitoring points, used for overall system compliance assessment.',
    `toc_concentration_mg_l` DECIMAL(18,2) COMMENT 'The total organic carbon concentration in milligrams per liter, a key precursor to DBP formation.',
    `total_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'The total chlorine residual measured at the time of sample collection, in milligrams per liter.',
    `trichloroacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of trichloroacetic acid (TCAA), a haloacetic acid species, in micrograms per liter.',
    `tthm_compliance_status` STRING COMMENT 'Indicates whether the TTHM LRAA at this monitoring point is in compliance with the MCL.. Valid values are `compliant|non-compliant|pending|under_review`',
    `tthm_concentration_ug_l` DECIMAL(18,2) COMMENT 'Sum of the four trihalomethane species (chloroform, bromodichloromethane, dibromochloromethane, bromoform) in micrograms per liter.',
    `tthm_lraa_ug_l` DECIMAL(18,2) COMMENT 'The locational running annual average of TTHM concentrations at this monitoring point, calculated as the arithmetic average of the current quarter and the previous three quarters.',
    `tthm_mcl_ug_l` DECIMAL(18,2) COMMENT 'The applicable TTHM maximum contaminant level for this monitoring event, typically 80 µg/L under Stage 2 DBPR.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'The water temperature at the time of sample collection in degrees Celsius, which affects DBP formation rates.',
    CONSTRAINT pk_dbp_monitoring_event PRIMARY KEY(`dbp_monitoring_event_id`)
) COMMENT 'Specialized transactional record for Disinfection Byproduct (DBP) monitoring events under Stage 2 DBPR rules. Captures monitoring period, LRAA (Locational Running Annual Average) calculation inputs, THM and HAA5 individual species results (chloroform, bromodichloromethane, dibromochloromethane, bromoform; monochloroacetic acid, dichloroacetic acid, trichloroacetic acid, monobromoacetic acid, dibromoacetic acid), TTHM and HAA5 totals, compliance status, and system-wide running annual average. Distinct from general analytical_result due to LRAA compliance calculation requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` (
    `pfas_monitoring_id` BIGINT COMMENT 'Primary key for pfas_monitoring',
    `contaminant_id` BIGINT COMMENT 'add column contaminant_id (BIGINT) with FK to quality.contaminant.contaminant_id - PFAS monitoring must link to specific PFAS contaminant records',
    `quality_sampling_point_id` BIGINT COMMENT 'add column quality_sampling_point_id (BIGINT) with FK to quality.quality_sampling_point.quality_sampling_point_id - PFAS monitoring events occur at specific sampling points',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: PFAS monitoring follows state-mandated sampling schedules (UCMR5, state-specific requirements). Links monitoring event to regulatory schedule for compliance tracking, public notification, and treatmen',
    `water_sample_id` BIGINT COMMENT 'add column water_sample_id (BIGINT) with FK to quality.water_sample.water_sample_id - PFAS monitoring produces samples that need tracking',
    CONSTRAINT pk_pfas_monitoring PRIMARY KEY(`pfas_monitoring_id`)
) COMMENT 'Specialized transactional record for PFAS (Per- and Polyfluoroalkyl Substances) monitoring under UCMR5 and the final PFAS NPDWR. Captures individual PFAS compound results (PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA/GenX), hazard index calculation for PFNA+PFHxS+PFBS+HFPO-DA, MCL compliance status, monitoring period, sampling point, and treatment response trigger status. Maintained separately from general analytical results due to distinct regulatory framework and emerging compliance requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` (
    `turbidity_reading_id` BIGINT COMMENT 'Unique identifier for the turbidity measurement record. Primary key.',
    `analytical_result_id` BIGINT COMMENT 'Unique identifier linking the turbidity reading to a laboratory analysis record in the Laboratory Information Management System (LIMS), if the reading was obtained through laboratory testing.',
    `analytical_test_id` BIGINT COMMENT 'Unique identifier linking the turbidity reading to a laboratory analysis record in the Laboratory Information Management System (LIMS), if the reading was obtained through laboratory testing.',
    `chain_of_custody_id` BIGINT COMMENT 'Unique identifier for the chain of custody documentation associated with the sample, ensuring traceability and integrity for regulatory compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Continuous turbidity monitoring involves instrument maintenance, calibration, and operator time—all costs allocated to treatment operations cost centers for budget tracking and rate case documentation',
    `online_instrument_id` BIGINT COMMENT 'Unique identifier of the turbidity monitoring instrument or analyzer that captured the reading.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier of the physical sampling location or monitoring point within the treatment plant or distribution system where the turbidity reading was captured.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the certified water treatment plant operator or laboratory technician who collected or validated the turbidity reading.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the Water Treatment Plant where the turbidity measurement was recorded.',
    `turbidity_operator_employee_id` BIGINT COMMENT 'Unique identifier of the certified water treatment plant operator or laboratory technician who collected or validated the turbidity reading.',
    `turbidity_wtp_facility_id` BIGINT COMMENT 'Unique identifier of the Water Treatment Plant where the turbidity measurement was recorded.',
    `alarm_threshold_ntu` DECIMAL(18,2) COMMENT 'The turbidity threshold value in NTU configured in the SCADA system that triggers an operational alarm when exceeded.',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the turbidity reading triggered an automated alarm in the SCADA system due to exceeding a predefined threshold.',
    `calibration_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent calibration performed on the turbidity instrument prior to this reading.',
    `compliance_status` STRING COMMENT 'The compliance status of the turbidity reading relative to regulatory requirements, indicating whether the reading meets Surface Water Treatment Rule standards.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action taken by plant operators in response to the turbidity reading, such as filter backwash, chemical dosage adjustment, or process shutdown.',
    `ct_compliance_context` STRING COMMENT 'Contextual information linking the turbidity reading to disinfection Contact Time (CT) compliance calculations, indicating whether the reading impacts CT credit eligibility under the Surface Water Treatment Rule.',
    `data_quality_code` STRING COMMENT 'Code indicating the quality and reliability of the turbidity reading, including flags for suspect data, instrument faults, calibration status, or manual overrides.. Valid values are `valid|suspect|invalid|calibration_due|instrument_fault|manual_override`',
    `data_source_system` STRING COMMENT 'The source system from which the turbidity reading was ingested into the lakehouse: OSIsoft PI Historian, LIMS, manual entry, or direct SCADA feed.. Valid values are `pi_historian|lims|manual_entry|scada_direct`',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the turbidity reading exceeded the regulatory Maximum Contaminant Level (MCL) or treatment technique requirement under the Surface Water Treatment Rule.',
    `filter_unit_number` STRING COMMENT 'Identifier of the specific filter unit at the Water Treatment Plant (WTP) from which the turbidity reading was captured. Applicable for Individual Filter Effluent (IFE) measurements.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'The flow rate through the filter or treatment process at the time of the turbidity measurement, expressed in Million Gallons per Day (MGD).',
    `measurement_location_type` STRING COMMENT 'Designation of where in the treatment process the turbidity measurement was taken: Individual Filter Effluent (IFE), Combined Filter Effluent (CFE), distribution system entry point, raw water intake, settled water, or filtered water.. Valid values are `ife|cfe|distribution_entry|raw_water|settled_water|filtered_water`',
    `measurement_method` STRING COMMENT 'The method used to capture the turbidity measurement, indicating whether it was a continuous online reading, grab sample, or laboratory analysis.. Valid values are `nephelometric|continuous_online|grab_sample|laboratory`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the turbidity measurement was captured by the instrument or collected as a grab sample.',
    `notes` STRING COMMENT 'Free-text field for operator or analyst notes regarding the turbidity reading, including contextual information, anomalies, or special conditions.',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag name associated with the turbidity measurement point, used for SCADA data integration and historical trending.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbidity reading record was first created in the lakehouse silver layer.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbidity reading record was last updated in the lakehouse silver layer.',
    `regulatory_limit_ntu` DECIMAL(18,2) COMMENT 'The applicable regulatory turbidity limit in NTU for the measurement location and context, as defined by the Surface Water Treatment Rule or state primacy agency requirements.',
    `reporting_period` STRING COMMENT 'The regulatory reporting period (e.g., monthly, quarterly) to which this turbidity reading applies for compliance reporting purposes.',
    `sample_collection_method` STRING COMMENT 'Method by which the water sample was collected for turbidity analysis: automated continuous monitoring, manual grab sample, or composite sample.. Valid values are `automated|manual_grab|composite`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the water sample at the time of turbidity measurement, expressed in degrees Celsius. Temperature can affect turbidity readings and is recorded for quality assurance.',
    `turbidity_value_ntu` DECIMAL(18,2) COMMENT 'The measured turbidity value expressed in Nephelometric Turbidity Units (NTU), representing the cloudiness or haziness of the water sample.',
    CONSTRAINT pk_turbidity_reading PRIMARY KEY(`turbidity_reading_id`)
) COMMENT 'High-frequency turbidity monitoring records from continuous online instruments and grab samples at WTP filter effluents, combined filter effluent, and distribution entry points. Captures NTU value, measurement timestamp, instrument ID, measurement method (nephelometric), filter unit number, CT compliance context, IFE (Individual Filter Effluent) vs CFE (Combined Filter Effluent) designation, and exceedance flag against Surface Water Treatment Rule turbidity limits. Sourced from OSIsoft PI Historian via SCADA integration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` (
    `ct_calculation_id` BIGINT COMMENT 'Unique identifier for the CT calculation record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: New disinfection systems require CT validation during commissioning before operational acceptance. Project substantial completion depends on demonstrated CT compliance. Role-prefixed because ongoing o',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CT calculations are part of disinfection operations; associated costs (SCADA systems, operator time, validation) are allocated to treatment cost centers for operational budgeting and rate case cost-of',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the certified water treatment plant operator who reviewed or validated the CT calculation.',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the water treatment plant where this CT calculation was performed.',
    `ct_operator_employee_id` BIGINT COMMENT 'Foreign key reference to the certified water treatment plant operator who reviewed or validated the CT calculation.',
    `process_unit_id` BIGINT COMMENT 'Foreign key reference to the specific disinfection process unit or stage within the WTP.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: CT calculations are performed at specific measurement points in the disinfection process. Currently has measurement_point_location as a STRING. Adding sampling_point_id normalizes this to reference th',
    `turbidity_reading_id` BIGINT COMMENT 'Foreign key linking to quality.turbidity_reading. Business justification: CT calculations use turbidity as a key input parameter (CT credit depends on turbidity levels). Currently has turbidity_ntu as a denormalized value. Adding turbidity_reading_id links to the authoritat',
    `calculated_ct_value_mg_min_l` DECIMAL(18,2) COMMENT 'Calculated CT value (C × T) in mg·min/L. This is the achieved disinfection contact time value.',
    `calculation_method` STRING COMMENT 'Method used to perform the CT calculation. Values: manual (operator calculated), automated_scada (real-time SCADA calculation), pi_calculation (OSIsoft PI calculation), laboratory (lab-based calculation).. Valid values are `manual|automated_scada|pi_calculation|laboratory`',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the CT calculation was performed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Sourced from OSIsoft PI Historian.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the CT calculation. Compliant if both Giardia and virus CT ratios ≥ 1.0. Values: compliant, non_compliant, marginal (close to threshold), under_review.. Valid values are `compliant|non_compliant|marginal|under_review`',
    `contact_chamber_volume_gallons` DECIMAL(18,2) COMMENT 'Volume of the disinfection contact chamber in gallons. Used in conjunction with flow rate to calculate contact time (T).',
    `contact_time_minutes` DECIMAL(18,2) COMMENT 'Measured or calculated contact time (T) in minutes that water is exposed to the disinfectant. This is the T component of the CT calculation. Typically calculated as T10 (time for 10% of water to pass through the contact chamber).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CT calculation record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ct_ratio_giardia` DECIMAL(18,2) COMMENT 'Ratio of achieved CT to required CT for Giardia inactivation (calculated_ct_value / required_ct_giardia_3log). Must be ≥ 1.0 for compliance.',
    `ct_ratio_virus` DECIMAL(18,2) COMMENT 'Ratio of achieved CT to required CT for virus inactivation (calculated_ct_value / required_ct_virus_4log). Must be ≥ 1.0 for compliance.',
    `data_quality_flag` BOOLEAN COMMENT 'Flag indicating the quality or reliability of the source data used in the CT calculation. Values: good, suspect (questionable readings), estimated (interpolated values), missing (incomplete data), calibration_due (instrument calibration overdue).',
    `disinfectant_residual_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured disinfectant residual concentration (C) in mg/L at the point of measurement. This is the C component of the CT calculation.',
    `disinfectant_type` STRING COMMENT 'Type of disinfectant used in the treatment process. Values: chlorine, chloramine, ozone, uv (ultraviolet), chlorine_dioxide, mixed_oxidant.. Valid values are `chlorine|chloramine|ozone|uv|chlorine_dioxide|mixed_oxidant`',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Water flow rate through the disinfection process in million gallons per day at the time of calculation. Used to calculate contact time.',
    `log_inactivation_giardia` DECIMAL(18,2) COMMENT 'Calculated log inactivation credit achieved for Giardia based on the CT ratio. Minimum 3-log required by SWTR.',
    `log_inactivation_virus` DECIMAL(18,2) COMMENT 'Calculated log inactivation credit achieved for viruses based on the CT ratio. Minimum 4-log required by SWTR.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CT calculation record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mor_reporting_period` STRING COMMENT 'Monthly Operating Report period to which this CT calculation applies, in YYYY-MM format. Used for regulatory reporting aggregation.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the CT calculation, including any anomalies, equipment issues, or special conditions observed during the calculation period.',
    `ph_level` DECIMAL(18,2) COMMENT 'pH level of the water at the time of CT calculation. pH affects disinfection efficacy and required CT values per EPA tables. Typical range: 6.5-8.5.',
    `required_ct_giardia_3log_mg_min_l` DECIMAL(18,2) COMMENT 'Required CT value for achieving 3-log (99.9%) inactivation of Giardia lamblia cysts, based on EPA CT tables considering water temperature, pH, and disinfectant type.',
    `required_ct_virus_4log_mg_min_l` DECIMAL(18,2) COMMENT 'Required CT value for achieving 4-log (99.99%) inactivation of viruses, based on EPA CT tables considering water temperature, pH, and disinfectant type.',
    `scada_tag_flow` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the flow rate measurement point.',
    `scada_tag_ph` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the pH measurement point.',
    `scada_tag_residual` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the disinfectant residual concentration measurement point.',
    `scada_tag_temperature` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the water temperature measurement point.',
    `t10_factor` DECIMAL(18,2) COMMENT 'T10 factor representing the ratio of T10 (time for 10% of water to pass through) to theoretical detention time. Typically determined through tracer studies. Used to calculate effective contact time.',
    `validation_status` STRING COMMENT 'Status of operator or supervisor validation of the CT calculation. Values: pending, validated, rejected, requires_review.. Valid values are `pending|validated|rejected|requires_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the CT calculation was validated by an operator or supervisor. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature in degrees Celsius at the time of CT calculation. Temperature affects disinfection efficacy and required CT values per EPA tables.',
    CONSTRAINT pk_ct_calculation PRIMARY KEY(`ct_calculation_id`)
) COMMENT 'Disinfection CT (Contact Time) calculation records for each WTP disinfection process. Captures calculation date/time, disinfectant type (chlorine, chloramine, ozone, UV), disinfectant residual concentration (C in mg/L), contact time (T in minutes), calculated CT value (mg·min/L), required CT for 3-log Giardia and 4-log virus inactivation, CT ratio (achieved/required), temperature, pH, and compliance status. Sourced from OSIsoft PI Historian. Critical for Surface Water Treatment Rule compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` (
    `residual_chlorine_reading_id` BIGINT COMMENT 'Unique identifier for the residual chlorine reading record.',
    `online_instrument_id` BIGINT COMMENT 'Identifier of the field instrument, handheld meter, or SCADA analyzer used to perform the measurement. Used for calibration tracking and data quality assurance.',
    `process_control_setpoint_id` BIGINT COMMENT 'Foreign key linking to treatment.process_control_setpoint. Business justification: Distribution system chlorine residual measurements are validated against treatment plant process control setpoints. Links field measurement to operational target for disinfection adequacy verification',
    `quality_sampling_point_id` BIGINT COMMENT 'Identifier of the location where the chlorine residual sample was collected. Links to distribution system nodes, WTP process points, or WWTP discharge points.',
    `employee_id` BIGINT COMMENT 'Identifier of the certified water treatment or distribution operator who collected the manual field reading. Required for regulatory compliance and data quality assurance.',
    `residual_operator_employee_id` BIGINT COMMENT 'Identifier of the certified water treatment or distribution operator who collected the manual field reading. Required for regulatory compliance and data quality assurance.',
    `sampling_schedule_id` BIGINT COMMENT 'Identifier linking this reading to a planned compliance monitoring schedule. Used to track adherence to regulatory sampling frequency requirements.',
    `calibration_date` DATE COMMENT 'Date when the measurement instrument was last calibrated. Regular calibration is required for data validity and regulatory compliance.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the measured residual meets regulatory minimum requirements. False indicates non-compliance requiring corrective action and potential reporting to primacy agency.',
    `contact_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time between disinfectant application and this measurement point. Used to calculate CT (concentration × time) for disinfection credit under SWTR.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken in response to non-compliant or suspect readings. Documents operational response for regulatory reporting and audit trail.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the reading triggered a need for corrective action such as booster chlorination, system flushing, or regulatory notification.',
    `data_source` STRING COMMENT 'Origin of the residual chlorine reading. SCADA continuous monitors provide real-time data via PI Historian; manual field readings are collected by operators; lab readings are from grab samples.. Valid values are `scada_continuous|manual_field|laboratory|ami_sensor`',
    `disinfectant_type` STRING COMMENT 'Type of disinfectant residual being measured. Free chlorine is the most common primary disinfectant; total chlorine includes both free and combined forms; chloramine is used for secondary disinfection to reduce DBP formation.. Valid values are `free_chlorine|total_chlorine|chloramine|chlorine_dioxide`',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Water flow rate at the sampling point in gallons per minute. Flow affects contact time and mixing; low flow can lead to stagnation and chlorine loss.',
    `holding_time_hours` DECIMAL(18,2) COMMENT 'Elapsed time between sample collection and analysis. Chlorine residual must be measured immediately or within 15 minutes to prevent decay and ensure accuracy.',
    `maximum_allowed_residual_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum Residual Disinfectant Level (MRDL) allowed by EPA. For chlorine and chloramine, MRDL is 4.0 mg/L as annual average; chlorine dioxide MRDL is 0.8 mg/L.',
    `measurement_method` STRING COMMENT 'Analytical method used to determine chlorine residual. DPD colorimetric is standard for field testing; amperometric is used for precise lab analysis; online analyzers provide continuous SCADA monitoring.. Valid values are `colorimetric_dpd|amperometric|online_analyzer|test_strip`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the chlorine residual measurement was taken in the field or recorded by SCADA system.',
    `minimum_required_residual_mg_per_l` DECIMAL(18,2) COMMENT 'Regulatory or operational minimum disinfectant residual threshold applicable at this sampling point. Typically 0.2 mg/L free chlorine at distribution entry point per EPA requirements.',
    `notes` STRING COMMENT 'Free-text field for operator observations, unusual conditions, or contextual information relevant to the reading (e.g., recent main break, flushing activity, taste/odor complaints).',
    `ph_value` DECIMAL(18,2) COMMENT 'pH level of water at sampling point. pH affects chlorine speciation and disinfection effectiveness; optimal range for free chlorine is 6.5-7.5.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Water pressure at sampling point in pounds per square inch. Pressure fluctuations can indicate system issues affecting water quality and disinfectant distribution.',
    `quality_control_flag` BOOLEAN COMMENT 'Data quality indicator based on QA/QC review. Suspect or invalid readings may result from instrument malfunction, calibration drift, or sampling error.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified. Tracks data quality corrections, QC flag updates, or supplemental information additions.',
    `regulatory_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this reading is part of required regulatory compliance monitoring for state primacy agency or EPA reporting (e.g., MOR, CCR).',
    `residual_value_mg_per_l` DECIMAL(18,2) COMMENT 'Measured concentration of disinfectant residual in milligrams per liter. EPA requires minimum 0.2 mg/L free chlorine or detectable residual entering distribution system.',
    `sample_collection_method` STRING COMMENT 'Method by which the water sample was obtained. Grab samples are instantaneous; composite samples are time-weighted; continuous monitors provide real-time streaming data.. Valid values are `grab_sample|composite_sample|continuous_monitor|inline_sensor`',
    `sample_location_type` STRING COMMENT 'Classification of the sampling point within the water system infrastructure. Critical for compliance monitoring as different locations have different regulatory requirements.. Valid values are `wtp_clearwell|distribution_entry|distribution_remote|storage_tank|booster_station|wwtp_effluent`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of water sample collected for analysis in milliliters. Standard sample volumes ensure analytical accuracy and method compliance.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measurement at sampling point. High turbidity can shield pathogens from disinfectant contact and increase chlorine demand.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the water sample at time of measurement. Temperature affects chlorine decay rate and disinfection efficacy; warmer water accelerates chlorine loss.',
    `weather_condition` STRING COMMENT 'Weather conditions at time of field sampling. Extreme weather can affect water quality, chlorine demand, and distribution system hydraulics.. Valid values are `clear|rain|snow|storm|extreme_heat`',
    CONSTRAINT pk_residual_chlorine_reading PRIMARY KEY(`residual_chlorine_reading_id`)
) COMMENT 'Transactional records of disinfectant residual measurements throughout the distribution system and at WTP/WWTP process points. Captures measurement date/time, sampling point, disinfectant type (free chlorine, total chlorine, chloramine), residual value (mg/L), measurement method (colorimetric, amperometric), field instrument ID, and compliance flag against minimum residual requirements (0.2 mg/L free or detectable). Sourced from both SCADA continuous monitors (PI Historian) and manual field readings.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` (
    `bacteriological_result_id` BIGINT COMMENT 'Unique identifier for the bacteriological test result record.',
    `analytical_test_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_test. Business justification: Bacteriological results must reference laboratorys analytical_test record for method traceability (SM 9223B, Colilert), analyst certification verification, and proficiency testing correlation. Requir',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory supervisor or quality assurance personnel who verified and approved the final result.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the laboratory analyst who performed the bacteriological test.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Bacteriological results are for specific contaminants (total coliform, E. coli, fecal coliform, enterococci, HPC). This FK identifies which contaminant the result applies to, enabling proper linkage t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bacteriological testing is a major compliance cost with dedicated budget lines; linking to cost_center enables tracking of RTCR compliance costs for budget variance analysis and regulatory cost recove',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Bacteriological samples (total coliform, E.coli) collected at customer taps must be traceable to meter installation for RTCR compliance, repeat sampling location identification, and Level 1/2 assessme',
    `primary_bacteriological_employee_id` BIGINT COMMENT 'Reference to the laboratory analyst who performed the bacteriological test.',
    `qaqc_batch_id` BIGINT COMMENT 'Identifier for the quality control batch in which this sample was analyzed, linking to QC blanks, duplicates, and standards.',
    `qc_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.qc_batch. Business justification: Bacteriological results must reference laboratory QC batch for method validation and regulatory defensibility. RTCR compliance requires demonstrating QC acceptance criteria were met for each analytica',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the location where the sample was collected (distribution system tap, treatment plant, reservoir, etc.).',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Bacteriological samples (total coliform, E. coli) are collected per RTCR-mandated sampling schedules. Links result to regulatory schedule for compliance tracking, repeat sample triggering, and assessm',
    `vendor_id` BIGINT COMMENT 'Reference to the laboratory that performed the bacteriological analysis.',
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
    `analytical_test_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_test. Business justification: Lead/copper results must reference laboratory analytical_test for method compliance verification (EPA 200.8/200.9), QA/QC acceptance, and 90th percentile calculation defensibility. Required for LCR/LC',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Lead and copper results are for specific contaminants (lead or copper). This FK identifies which contaminant the result applies to, enabling proper linkage to contaminant limits and regulatory require',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lead/copper monitoring involves significant costs (sampling, analysis, customer notification, reporting); utilities track LCR program costs by cost center for compliance budgeting and rate case justif',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with the sampling site premises.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lead and Copper Rule explicitly requires sampling at customer taps with documented service line materials. Meter installation is the sampling location for tier classification, 90th percentile calculat',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Lead and Copper Rule requires sampling at customer taps (service points) with specific site selection criteria based on service line material and building age. Service point linkage is mandatory for 9',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Premise characteristics (service line material, building age, plumbing configuration) are mandatory for lead/copper site selection, tier classification, and LCRR compliance. Business process: site inv',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the customer tap location selected for Lead and Copper Rule monitoring.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EPA Lead and Copper Rule requires certified personnel for sampling. Tracking collector employee enables license verification, training compliance audits, and chain-of-custody validation for regulatory',
    `sampling_round_id` BIGINT COMMENT 'Reference to the 6-month monitoring period during which this sample was collected per LCRR requirements.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Lead/copper monitoring follows LCR sampling rounds with specific site selection and frequency requirements. Links result to regulatory schedule for 90th percentile calculation, action level exceedance',
    `sampling_site_id` BIGINT COMMENT 'Reference to the customer tap location selected for Lead and Copper Rule monitoring.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Lead/copper sampling requires precise service address tracking for tier site selection, customer notification within 30 days of result, and LCRR compliance documentation. Already has customer_account_',
    `vendor_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the lead and copper analysis.',
    `water_sample_id` BIGINT COMMENT 'Laboratory-assigned unique identifier for the physical water sample collected at the tap.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` (
    `source_water_quality_id` BIGINT COMMENT 'Unique identifier for the source water quality measurement record.',
    `bulk_water_agreement_id` BIGINT COMMENT 'Foreign key linking to service.bulk_water_agreement. Business justification: Bulk water agreements specify contractual water quality standards at delivery points. Source water monitoring at these points verifies compliance with contracted quality parameters, triggers price adj',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: New source water intakes require baseline water quality characterization during commissioning to validate design assumptions. Project cannot be turned over to operations without documented source wate',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Source water monitoring costs are allocated to raw water/intake operations cost centers for budget tracking and rate case documentation of source water protection and monitoring program expenses.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Source water quality measurements are taken at specific sampling points (intake locations). Currently has source_water_intake_id (cross-domain to treatment) and sample_id. Adding sampling_point_id est',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Source water monitoring under SDWA requires operator certification. Linking sampler employee enables compliance verification for intake monitoring programs, training record validation, and regulatory',
    `source_location_source_water_intake_id` BIGINT COMMENT 'Reference to the specific water source intake point or well where the sample was collected.',
    `source_water_intake_id` BIGINT COMMENT 'Reference to the specific water source intake point or well where the sample was collected.',
    `water_sample_id` BIGINT COMMENT 'Unique laboratory identifier assigned to the water sample for tracking and chain of custody.',
    `algae_count_cells_per_ml` STRING COMMENT 'Concentration of algae cells per milliliter of source water, important for taste, odor, and treatment challenges.',
    `alkalinity_mg_per_l` DECIMAL(18,2) COMMENT 'Total alkalinity expressed as milligrams per liter of calcium carbonate equivalent, indicating buffering capacity.',
    `ammonia_mg_per_l` DECIMAL(18,2) COMMENT 'Ammonia nitrogen concentration in milligrams per liter, affecting disinfection effectiveness and DBP formation.',
    `analysis_method` STRING COMMENT 'EPA or Standard Methods reference number for the analytical method used for testing.',
    `chloride_mg_per_l` DECIMAL(18,2) COMMENT 'Chloride concentration in milligrams per liter, affecting taste and corrosivity.',
    `color_pcu` STRING COMMENT 'Apparent color of the source water measured in Platinum-Cobalt Units, indicating dissolved organic matter.',
    `conductivity_us_per_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity of the source water in microsiemens per centimeter, indicating ionic content.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this source water quality record was first created in the system.',
    `cyanotoxin_concentration_ug_per_l` DECIMAL(18,2) COMMENT 'Concentration of cyanotoxins in micrograms per liter if detected, null if not detected or not analyzed.',
    `cyanotoxin_detected` BOOLEAN COMMENT 'Boolean indicator of whether cyanotoxins (blue-green algae toxins) were detected in the screening analysis.',
    `dissolved_oxygen_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of dissolved oxygen in milligrams per liter, indicating water quality and biological activity.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Flow rate of the source water at the intake point at time of sampling, expressed in Million Gallons per Day.',
    `hardness_mg_per_l` DECIMAL(18,2) COMMENT 'Total hardness expressed as milligrams per liter of calcium carbonate equivalent, indicating calcium and magnesium content.',
    `iron_mg_per_l` DECIMAL(18,2) COMMENT 'Total iron concentration in milligrams per liter, important for treatment process design and aesthetic quality.',
    `lab_analyzed_by` STRING COMMENT 'Name or identifier of the laboratory analyst who performed the water quality analysis.',
    `manganese_mg_per_l` DECIMAL(18,2) COMMENT 'Total manganese concentration in milligrams per liter, important for treatment and aesthetic quality.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the source water quality sample was collected and measured.',
    `nitrate_mg_per_l` DECIMAL(18,2) COMMENT 'Nitrate nitrogen concentration in milligrams per liter, a regulated contaminant under SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional observations, anomalies, or contextual information about the source water quality measurement.',
    `ph_level` DECIMAL(18,2) COMMENT 'Measure of acidity or alkalinity of the source water on a scale of 0-14, critical for treatment process optimization.',
    `quality_control_passed` BOOLEAN COMMENT 'Boolean indicator of whether the laboratory analysis passed all quality control checks and validation criteria.',
    `regulatory_exceedance` BOOLEAN COMMENT 'Boolean indicator of whether any measured parameter exceeded regulatory action levels or Maximum Contaminant Levels (MCL).',
    `season` STRING COMMENT 'Season during which the source water sample was collected, used for seasonal trend analysis.. Valid values are `spring|summer|fall|winter`',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this measurement represents a period of significant seasonal variation in source water quality.',
    `source_type` STRING COMMENT 'Classification of the water source from which the sample was collected.. Valid values are `surface_water|groundwater|reservoir|lake|river|purchased_water`',
    `sulfate_mg_per_l` DECIMAL(18,2) COMMENT 'Sulfate concentration in milligrams per liter, a secondary contaminant affecting taste and odor.',
    `tds_mg_per_l` DECIMAL(18,2) COMMENT 'Total Dissolved Solids concentration in milligrams per liter, indicating mineral content and salinity.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the source water at time of sampling, measured in degrees Celsius.',
    `toc_mg_per_l` DECIMAL(18,2) COMMENT 'Total Organic Carbon concentration in milligrams per liter, a key indicator for disinfection byproduct formation potential.',
    `treatment_adjustment_required` BOOLEAN COMMENT 'Boolean indicator of whether the source water quality measurement triggered a need for Water Treatment Plant (WTP) process adjustment.',
    `tss_mg_per_l` DECIMAL(18,2) COMMENT 'Total Suspended Solids concentration in milligrams per liter, indicating particulate matter load.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Raw turbidity measurement of the source water expressed in Nephelometric Turbidity Units, indicating suspended particle concentration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this source water quality record was last modified in the system.',
    `weather_condition` STRING COMMENT 'General weather condition at the time of sampling, affecting source water quality characteristics.. Valid values are `dry|wet|storm|drought|normal`',
    CONSTRAINT pk_source_water_quality PRIMARY KEY(`source_water_quality_id`)
) COMMENT 'Transactional records of raw source water quality measurements at intake points (surface water intakes, groundwater wells, purchased water entry points). Captures measurement date/time, source type (river, reservoir, lake, groundwater, purchased), raw turbidity (NTU), TOC (mg/L), pH, temperature, alkalinity, hardness, color, algae counts, cyanotoxin screening results, and seasonal variation flags. Drives WTP treatment process adjustments and source water assessment reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` (
    `effluent_quality_id` BIGINT COMMENT 'Unique identifier for the effluent quality measurement record.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: New or upgraded WWTP facilities require effluent quality validation during commissioning to demonstrate NPDES permit compliance before final acceptance. Project closeout requires documented effluent q',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key reference to the NPDES permit governing this discharge point.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wastewater effluent monitoring costs are allocated to treatment operations cost centers for NPDES compliance budgeting, DMR reporting cost tracking, and rate case justification of wastewater treatment',
    `dmr_id` BIGINT COMMENT 'Foreign key linking to compliance.dmr. Business justification: Effluent quality measurements populate DMR (Discharge Monitoring Report) submissions for NPDES compliance. This link connects laboratory results to regulatory reporting documents, essential for wastew',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Wastewater effluent samples analyzed in laboratory for NPDES compliance. Direct lab_sample link required for DMR reporting, laboratory QA/QC traceability, and permit limit verification. Supports EPA N',
    `outfall_id` BIGINT COMMENT 'Foreign key reference to the specific discharge outfall point where the effluent sample was collected.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Effluent quality measurements are evaluated against specific permit conditions (BOD limits, TSS limits, pH ranges). This link enables automated compliance determination by comparing measured values to',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who collected the effluent sample.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Effluent quality measurements are taken at specific sampling points. Currently has outfall_id (not a product in this domain) and outfall_identifier (STRING). Adding sampling_point_id establishes the l',
    `special_contract_id` BIGINT COMMENT 'Foreign key linking to service.special_contract. Business justification: Large industrial users often have special contracts with negotiated discharge limits beyond standard IUP permits. Effluent monitoring results verify compliance with contract-specific limits, trigger p',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the laboratory that performed the effluent quality analysis.',
    `wwtp_id` BIGINT COMMENT 'Foreign key reference to the wastewater treatment plant where the effluent sample was collected.',
    `ammonia_nitrogen_mg_l` DECIMAL(18,2) COMMENT 'Ammonia nitrogen concentration in milligrams per liter, measuring un-ionized and ionized ammonia.',
    `ammonia_permit_limit_mg_l` DECIMAL(18,2) COMMENT 'NPDES permit limit for ammonia nitrogen concentration in milligrams per liter for this discharge point.',
    `analysis_completion_date` DATE COMMENT 'Date when the laboratory completed all analytical testing for this effluent sample.',
    `bod5_mg_l` DECIMAL(18,2) COMMENT 'Five-day biochemical oxygen demand concentration in milligrams per liter, measuring organic pollution load.',
    `bod5_permit_limit_mg_l` DECIMAL(18,2) COMMENT 'NPDES permit limit for BOD5 concentration in milligrams per liter for this discharge point.',
    `cbod5_mg_l` DECIMAL(18,2) COMMENT 'Five-day carbonaceous biochemical oxygen demand concentration in milligrams per liter, excluding nitrogenous demand.',
    `cod_mg_l` DECIMAL(18,2) COMMENT 'Chemical oxygen demand concentration in milligrams per liter, measuring total organic and inorganic oxidizable matter.',
    `compliance_status` STRING COMMENT 'Overall compliance status of this effluent sample against NPDES permit limits: compliant (all parameters within limits), non-compliant (one or more violations), exceedance (exceeds but within reporting tolerance), or pending review.. Valid values are `compliant|non_compliant|exceedance|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this effluent quality record was first created in the database.',
    `discharge_date` DATE COMMENT 'Calendar date of the effluent discharge event for reporting purposes.',
    `dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration in milligrams per liter, measuring oxygen available in the effluent.',
    `dmr_reporting_period` STRING COMMENT 'The DMR reporting period (e.g., 2024-01, 2024-Q1) to which this effluent measurement applies.',
    `e_coli_cfu_100ml` DECIMAL(18,2) COMMENT 'E. coli bacteria count in colony forming units per 100 milliliters, indicating fecal contamination and pathogen risk.',
    `fecal_coliform_cfu_100ml` DECIMAL(18,2) COMMENT 'Fecal coliform bacteria count in colony forming units per 100 milliliters, indicating fecal contamination.',
    `fecal_coliform_permit_limit_cfu_100ml` DECIMAL(18,2) COMMENT 'NPDES permit limit for fecal coliform bacteria count in colony forming units per 100 milliliters for this discharge point.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Effluent discharge flow rate measured in million gallons per day at the time of sampling.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this effluent quality record was last modified.',
    `npdes_permit_number` STRING COMMENT 'The EPA-issued NPDES permit number authorizing this discharge (e.g., CA0001234).',
    `ph_permit_range_max` DECIMAL(18,2) COMMENT 'NPDES permit maximum allowable pH value for this discharge point.',
    `ph_permit_range_min` DECIMAL(18,2) COMMENT 'NPDES permit minimum allowable pH value for this discharge point.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the effluent, indicating acidity or alkalinity on a scale of 0-14.',
    `remarks` STRING COMMENT 'Free-text field for operational notes, unusual conditions, or explanations related to this effluent sample (e.g., heavy rainfall event, equipment malfunction, process upset).',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent sample was collected at the discharge point.',
    `sample_type` STRING COMMENT 'Method of sample collection: grab (instantaneous), composite over 24 hours, flow-weighted composite, or continuous monitoring.. Valid values are `grab|composite_24hr|composite_flow_weighted|continuous`',
    `tds_mg_l` DECIMAL(18,2) COMMENT 'Total dissolved solids concentration in milligrams per liter, measuring dissolved inorganic and organic substances.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Effluent temperature measured in degrees Celsius at the time of discharge.',
    `toc_mg_l` DECIMAL(18,2) COMMENT 'Total organic carbon concentration in milligrams per liter, measuring all carbon in organic compounds.',
    `total_nitrogen_mg_l` DECIMAL(18,2) COMMENT 'Total nitrogen concentration in milligrams per liter, including organic nitrogen, ammonia, nitrite, and nitrate.',
    `total_phosphorus_mg_l` DECIMAL(18,2) COMMENT 'Total phosphorus concentration in milligrams per liter, measuring all forms of phosphorus including orthophosphate and organic phosphorus.',
    `total_residual_chlorine_mg_l` DECIMAL(18,2) COMMENT 'Total residual chlorine concentration in milligrams per liter, measuring disinfectant residual in the effluent.',
    `tss_mg_l` DECIMAL(18,2) COMMENT 'Total suspended solids concentration in milligrams per liter, measuring particulate matter in the effluent.',
    `tss_permit_limit_mg_l` DECIMAL(18,2) COMMENT 'NPDES permit limit for TSS concentration in milligrams per liter for this discharge point.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measurement in nephelometric turbidity units, indicating water clarity and suspended particle content.',
    CONSTRAINT pk_effluent_quality PRIMARY KEY(`effluent_quality_id`)
) COMMENT 'Transactional records of treated wastewater effluent quality at WWTP discharge points. Captures discharge date/time, outfall identifier, NPDES permit number, BOD5 (mg/L), CBOD5, COD, TSS (mg/L), TDS, ammonia-nitrogen, total nitrogen, total phosphorus, pH, dissolved oxygen, fecal coliform, E. coli, flow rate (MGD), and permit limit compliance status for each parameter. Drives DMR (Discharge Monitoring Report) preparation and NPDES compliance tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` (
    `ccr_period_id` BIGINT COMMENT 'Unique identifier for the Consumer Confidence Report period. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CCR preparation and distribution involves costs (printing, mailing, staff time, translation) allocated to customer service or compliance cost centers for budget tracking and rate case justification of',
    `additional_languages` STRING COMMENT 'Comma-separated list of additional languages in which the CCR was made available (e.g., Spanish, Chinese, Vietnamese).',
    `certification_method` STRING COMMENT 'Method used to submit the CCR certification to the primacy agency. Many states now require electronic submission through online portals.. Valid values are `electronic|mail|fax|online_portal`',
    `certification_submission_date` DATE COMMENT 'Date when the CCR certification was submitted to the primacy agency. Systems must certify delivery of the CCR to customers by October 1.',
    `certified_by_name` STRING COMMENT 'Name of the authorized water system official who certified the CCR. Typically the system manager, superintendent, or designated compliance officer.',
    `certified_by_title` STRING COMMENT 'Job title of the authorized official who certified the CCR.',
    `comments` STRING COMMENT 'Additional notes, observations, or context about this CCR period, preparation process, or special circumstances.',
    `contact_email` STRING COMMENT 'Email address for customer inquiries about the CCR. Increasingly included as an additional contact method.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the water system contact person for customer questions about the CCR. Required to be included in the published report.',
    `contact_phone` STRING COMMENT 'Phone number for customer inquiries about the CCR. Required to be included in the published report.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was first created in the system.',
    `customers_served_count` STRING COMMENT 'Total number of customer accounts or service connections served by the water system during the report year. Used to determine CCR distribution requirements.',
    `detected_contaminant_count` STRING COMMENT 'Total number of regulated contaminants detected in the water system during the report year. Includes contaminants above and below Maximum Contaminant Levels (MCL).',
    `distribution_method` STRING COMMENT 'Primary method used to deliver the Consumer Confidence Report to customers. EPA allows mail, electronic delivery, or posting with notification.. Valid values are `mailed|posted_online|electronic_delivery|newspaper|combination`',
    `document_file_path` STRING COMMENT 'File system path or cloud storage location of the final published CCR document (typically PDF format).',
    `health_effects_language_included_flag` BOOLEAN COMMENT 'Indicates whether mandatory EPA health effects language was included for all detected contaminants. Required for CCR compliance.',
    `language_accessibility_provided_flag` BOOLEAN COMMENT 'Indicates whether the CCR was made available in languages other than English to serve non-English speaking populations. Required for systems serving significant non-English speaking populations.',
    `lead_copper_educational_information_flag` BOOLEAN COMMENT 'Indicates whether mandatory lead and copper educational information was included in the CCR. Required under Lead and Copper Rule Revisions (LCRR).',
    `mcl_violation_count` STRING COMMENT 'Number of Maximum Contaminant Level violations that occurred during the report year. Must be prominently disclosed in the CCR.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this CCR period record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was last modified.',
    `monitoring_violation_count` STRING COMMENT 'Number of monitoring and reporting violations that occurred during the report year. Includes failures to test or report as required.',
    `online_ccr_url` STRING COMMENT 'Web address where the CCR is posted online. Required if using electronic delivery method.',
    `population_served_count` STRING COMMENT 'Estimated total population receiving water from the system during the report year. Used for regulatory classification and reporting.',
    `preparation_start_date` DATE COMMENT 'Date when preparation of the Consumer Confidence Report began. Typically starts in January following the report year.',
    `primacy_agency` STRING COMMENT 'State or tribal agency with primary enforcement responsibility for public water systems under the Safe Drinking Water Act. Typically the state Department of Environmental Quality or Health.',
    `publication_date` DATE COMMENT 'Date when the Consumer Confidence Report was published and made available to customers. Must be by July 1 following the report year per EPA regulations.',
    `pwsid` STRING COMMENT 'EPA-assigned unique identifier for the public water system. Format: two-letter state code followed by seven digits (e.g., CA1234567).. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the Consumer Confidence Report. Tracks progression from draft through publication and certification to primacy agency.. Valid values are `draft|in_review|approved|published|certified|archived`',
    `report_year` STRING COMMENT 'Calendar year for which this Consumer Confidence Report is prepared. CCRs are annual reports covering the previous calendar years water quality data.',
    `source_water_assessment_summary` STRING COMMENT 'Summary of the source water assessment including susceptibility to contamination and availability information. Required CCR content element.',
    `special_notices_included` STRING COMMENT 'Description of any special notices included in the CCR such as boil water advisories, vulnerable population warnings, or emerging contaminant information.',
    `treatment_technique_violation_count` STRING COMMENT 'Number of treatment technique violations that occurred during the report year. Treatment techniques are required processes for contaminants without MCLs.',
    `violation_summary` STRING COMMENT 'Narrative summary of all violations that occurred during the report year, including health effects language and corrective actions taken. Required CCR content element.',
    `water_source_summary` STRING COMMENT 'Narrative description of the water systems sources including surface water, groundwater, purchased water, and source water protection information. Required CCR content element.',
    `water_system_name` STRING COMMENT 'Official name of the public water system as registered with the primacy agency.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this CCR period record.',
    CONSTRAINT pk_ccr_period PRIMARY KEY(`ccr_period_id`)
) COMMENT 'Master record for each annual Consumer Confidence Report (CCR) reporting period. Captures report year, water system name, PWSID (Public Water System ID), primacy agency, report preparation status, publication date, distribution method (mailed, posted, electronic), number of customers served, water source summary, detected contaminant summary count, violation summary, and certification submission date to primacy agency. Serves as the organizing entity for all CCR-related quality data aggregation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` (
    `ccr_detected_contaminant_id` BIGINT COMMENT 'Unique identifier for each contaminant detection record required to be reported in the annual Consumer Confidence Report (CCR) for a given reporting period. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who originally created this contaminant detection record. Supports accountability and audit trail for regulatory compliance.',
    `ccr_employee_id` BIGINT COMMENT 'Identifier of the water quality manager or compliance officer who reviewed and approved this contaminant detection record for inclusion in the Consumer Confidence Report. Supports audit trail and regulatory accountability.',
    `ccr_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this contaminant detection record. Supports change tracking and accountability for data quality.',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking to quality.ccr_period. Business justification: CCR detected contaminants belong to a CCR period within the quality domain. The existing ccr_id points to compliance.ccr (cross-domain), but ccr_period is the in-domain master record for CCR reporting',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: ccr_detected_contaminant currently has contaminant_code and contaminant_name as denormalized attributes. This product reports contaminants detected in the annual Consumer Confidence Report and must re',
    `primary_ccr_employee_id` BIGINT COMMENT 'Identifier of the water quality manager or compliance officer who reviewed and approved this contaminant detection record for inclusion in the Consumer Confidence Report. Supports audit trail and regulatory accountability.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: CCR detected contaminants are detected at specific sampling points. This FK identifies the primary sampling point where the contaminant was detected, enabling location-specific reporting in the CCR.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Consumer Confidence Reports are prepared and distributed by service territory (water system). Detected contaminants must be associated with the specific service territory for accurate CCR generation',
    `tertiary_ccr_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this contaminant detection record. Supports change tracking and accountability for data quality.',
    `action_level` DECIMAL(18,2) COMMENT 'The concentration of a contaminant which, if exceeded, triggers treatment or other requirements that a water system must follow. Primarily used for lead and copper under the Lead and Copper Rule (LCR) and Lead and Copper Rule Revisions (LCRR). Null if not applicable.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this contaminant detection record was reviewed and approved for CCR publication. Part of the quality assurance and regulatory compliance workflow.',
    `ccr_table_display_order` STRING COMMENT 'Sequence number controlling the display order of this contaminant in the published CCR detected contaminants table. Allows utilities to organize contaminants by category, regulatory importance, or alphabetically for public presentation.',
    `comments` STRING COMMENT 'Internal notes, comments, or observations regarding this contaminant detection. May include quality control notes, data validation comments, or context for unusual results. Not published in the CCR but retained for internal documentation.',
    `compliance_status` STRING COMMENT 'Overall compliance status for this contaminant during the reporting period. Indicates whether the water system met all regulatory requirements including MCL/AL compliance, monitoring frequency, and reporting obligations.. Valid values are `compliant|violation|pending_review|corrective_action_required`',
    `contaminant_category` STRING COMMENT 'Classification of the contaminant type for regulatory grouping and CCR presentation. Categories align with EPA National Primary Drinking Water Regulations structure.. Valid values are `inorganic|organic|disinfection_byproduct|microbiological|radiological|emerging_contaminant`',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned by the water system in response to violations or elevated contaminant levels. Required disclosure in CCR when violations occur. Includes treatment modifications, infrastructure improvements, or operational changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contaminant detection record was first created in the system. Part of the audit trail for regulatory compliance and data governance.',
    `data_source` STRING COMMENT 'Identifies the system or process from which this contaminant detection data was obtained (e.g., Laboratory Information Management System, SCADA historian, manual data entry, state drinking water database). Supports data lineage and quality assurance.. Valid values are `lims|scada|manual_entry|state_reporting_system|laboratory_report`',
    `detection_frequency_percent` DECIMAL(18,2) COMMENT 'Percentage of samples in which this contaminant was detected, calculated as (number_of_detections / number_of_samples) * 100. Provides statistical context for contaminant presence in the water system.',
    `footnote_text` STRING COMMENT 'Additional explanatory text or footnotes specific to this contaminant detection that will appear in the CCR. Used to provide context, explain unusual results, clarify monitoring schedules, or reference specific regulatory requirements.',
    `health_effects_language` STRING COMMENT 'EPA-mandated health effects language describing the potential health impacts of this contaminant when present above the MCL or MCLG. Must use EPA-approved standard language as specified in 40 CFR 141.153 Appendix B. Required for all contaminants with violations or detections above health-based levels.',
    `highest_level_detected` DECIMAL(18,2) COMMENT 'The highest single measurement or calculated running annual average (RAA) of the contaminant detected during the reporting period. For some contaminants (e.g., THM, HAA5), this represents the highest locational running annual average (LRAA). Reporting format depends on contaminant-specific regulations.',
    `mcl` DECIMAL(18,2) COMMENT 'The Maximum Contaminant Level (MCL) - the highest level of a contaminant that is allowed in drinking water. MCLs are enforceable standards set as close to MCLGs as feasible using the best available treatment technology. Null if a Treatment Technique (TT) applies instead of an MCL.',
    `mclg` DECIMAL(18,2) COMMENT 'The Maximum Contaminant Level Goal (MCLG) - the level of a contaminant in drinking water below which there is no known or expected risk to health. MCLGs are non-enforceable public health goals. Value of zero indicates no safe level. Null indicates no MCLG established.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contaminant detection record was last modified. Supports change tracking and audit requirements for regulatory reporting.',
    `monitoring_period_end_date` DATE COMMENT 'The ending date of the monitoring period for which this contaminant detection data was collected. Defines the temporal scope of the reported results.',
    `monitoring_period_start_date` DATE COMMENT 'The beginning date of the monitoring period for which this contaminant detection data was collected. Defines the temporal scope of the reported results.',
    `number_of_detections` STRING COMMENT 'Count of samples in which this contaminant was detected above the method detection limit (MDL) or practical quantitation level (PQL) during the reporting period. Provides transparency on detection frequency.',
    `number_of_samples` STRING COMMENT 'Total count of samples collected and analyzed for this contaminant during the reporting period. Used to demonstrate compliance with monitoring frequency requirements and provide context for detection statistics.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this contaminant detection triggered Public Notification (PN) requirements under 40 CFR 141 Subpart Q. True if Tier 1, 2, or 3 public notice was required, False otherwise. Public notification is separate from but related to CCR reporting.',
    `range_high` DECIMAL(18,2) COMMENT 'The highest level detected for this contaminant across all samples collected during the reporting period. Forms the upper bound of the detection range required for CCR reporting. Typically matches highest_level_detected unless different averaging methods apply.',
    `range_low` DECIMAL(18,2) COMMENT 'The lowest level detected for this contaminant across all samples collected during the reporting period. Forms the lower bound of the detection range required for CCR reporting. May be zero or below detection limit.',
    `regulatory_program` STRING COMMENT 'The specific EPA regulatory program or rule under which this contaminant is monitored and reported (e.g., National Primary Drinking Water Regulations, Lead and Copper Rule, Disinfectants and Disinfection Byproducts Rule, Unregulated Contaminant Monitoring Rule). [ENUM-REF-CANDIDATE: npdwr|surface_water_treatment_rule|groundwater_rule|lead_copper_rule|dbp_rule|radionuclides_rule|unregulated_contaminant_monitoring — 7 candidates stripped; promote to reference product]',
    `reporting_year` STRING COMMENT 'Calendar year for which this contaminant detection is being reported in the CCR. Typically the year in which samples were collected and analyzed.',
    `sample_year` STRING COMMENT 'The actual year in which the water samples were collected for this contaminant. May differ from reporting year for contaminants with multi-year monitoring cycles (e.g., lead and copper, certain synthetic organic chemicals).',
    `treatment_technique_flag` BOOLEAN COMMENT 'Indicates whether this contaminant is regulated by a Treatment Technique (TT) requirement rather than an MCL. True if TT applies (e.g., turbidity, lead and copper action levels), False if MCL applies.',
    `typical_source_description` STRING COMMENT 'EPA-mandated language describing the likely sources of this contaminant in drinking water. Must use EPA-approved standard language for each contaminant as specified in 40 CFR 141.153 Appendix A. This text appears directly in the published CCR.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for contaminant concentration values (e.g., mg/L for milligrams per liter, ug/L for micrograms per liter, pCi/L for picocuries per liter, NTU for Nephelometric Turbidity Units, MFL for million fibers per liter). Must align with EPA reporting standards. [ENUM-REF-CANDIDATE: mg/L|ug/L|pCi/L|MFL|NTU|%|CFU/100mL|MPN/100mL — 8 candidates stripped; promote to reference product]',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether the detected contaminant level resulted in a violation of the MCL, MCLG, Treatment Technique, or Action Level during the reporting period. True if violation occurred, False if compliant. Violations must be prominently disclosed in the CCR.',
    `violation_type` STRING COMMENT 'Classification of the type of violation if violation_flag is True. Specifies whether the violation was due to MCL exceedance, action level exceedance, treatment technique failure, monitoring failure, or reporting failure. Value is none if no violation occurred.. Valid values are `mcl_exceedance|action_level_exceedance|treatment_technique_violation|monitoring_violation|reporting_violation|none`',
    CONSTRAINT pk_ccr_detected_contaminant PRIMARY KEY(`ccr_detected_contaminant_id`)
) COMMENT 'Transactional record of each contaminant detected and required to be reported in the annual CCR for a given reporting period. Captures contaminant name, MCLG, MCL or treatment technique, highest level detected, range of detections (low-high), sample year, violation flag, typical source description, and health effects language. Directly populates the CCR table of detected contaminants as required by 40 CFR 141.153.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` (
    `monitoring_waiver_id` BIGINT COMMENT 'Unique identifier for the monitoring waiver record. Primary key.',
    `contaminant_id` BIGINT COMMENT 'Reference to the specific contaminant or contaminant group for which the monitoring waiver is granted. Links to the contaminant product.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the specific sampling point or compliance monitoring point where the waiver applies. Links to the sampling_point product.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Monitoring waivers are granted under specific regulatory requirements (vulnerability assessments per 40 CFR 141). This link documents the regulatory authority and conditions for reduced monitoring, es',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Monitoring waivers require primacy agency approval and internal accountability tracking. Linking responsible employee enables compliance tracking, renewal deadline management, regulatory correspondenc',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Monitoring waivers affect specific sampling schedules by reducing monitoring frequency. This FK links the waiver to the schedule(s) it modifies, enabling proper tracking of which schedules operate und',
    `approval_date` DATE COMMENT 'Date on which the monitoring waiver was officially approved and granted by the primacy agency.',
    `baseline_monitoring_frequency` STRING COMMENT 'Original required monitoring frequency before the waiver was granted (e.g., quarterly, monthly, annual). Expressed as a frequency code or description.',
    `ccr_reporting_impact` STRING COMMENT 'Description of how the monitoring waiver affects Consumer Confidence Report (CCR) reporting requirements and public notification language.',
    `comments` STRING COMMENT 'Additional free-text comments, notes, or observations related to the monitoring waiver, including internal coordination notes or historical context.',
    `contaminant_group` STRING COMMENT 'Descriptive name of the contaminant group covered by this waiver (e.g., Disinfection Byproducts (DBP), Volatile Organic Compounds (VOC), Synthetic Organic Chemicals (SOC), Inorganic Chemicals (IOC), Radionuclides).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring waiver record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the monitoring waiver becomes effective and the reduced monitoring frequency applies.',
    `expiration_date` DATE COMMENT 'Date on which the monitoring waiver expires and full monitoring frequency must resume unless the waiver is renewed.',
    `historical_monitoring_period_end` DATE COMMENT 'End date of the historical monitoring period used to demonstrate non-detect results for waiver eligibility.',
    `historical_monitoring_period_start` DATE COMMENT 'Start date of the historical monitoring period used to demonstrate non-detect results for waiver eligibility.',
    `historical_non_detect_count` STRING COMMENT 'Number of consecutive historical samples with non-detect results for the contaminant, supporting the waiver justification.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this monitoring waiver record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring waiver record was last modified or updated in the system.',
    `next_renewal_date` DATE COMMENT 'Date by which the waiver renewal application must be submitted or the waiver reassessment must be completed.',
    `primacy_agency_approval_reference` STRING COMMENT 'Official reference number, permit number, or document identifier issued by the primacy agency for this waiver approval.',
    `primacy_agency_name` STRING COMMENT 'Name of the state or federal primacy agency that approved and granted the monitoring waiver (e.g., State Department of Environmental Quality, EPA Region).',
    `reduced_monitoring_frequency` STRING COMMENT 'Reduced monitoring frequency allowed under the waiver (e.g., annual, triennial, once per compliance period). Expressed as a frequency code or description.',
    `renewal_frequency_years` STRING COMMENT 'Frequency in years at which the waiver must be renewed or reassessed if renewal is required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the waiver requires periodic renewal or reapplication (True) or is granted indefinitely subject to conditions (False).',
    `responsible_department` STRING COMMENT 'Department or organizational unit responsible for waiver compliance and monitoring (e.g., Water Quality, Regulatory Compliance, Laboratory).',
    `revocation_date` DATE COMMENT 'Date on which the waiver was revoked by the primacy agency or voluntarily withdrawn by the utility, if applicable.',
    `revocation_reason` STRING COMMENT 'Detailed explanation of the reason for waiver revocation, including regulatory violations, detection events, or operational changes.',
    `revocation_trigger_conditions` STRING COMMENT 'Specific conditions or events that would trigger automatic revocation of the waiver (e.g., detection above action level, source water contamination, operational changes).',
    `sampling_schedule_adjustment_notes` STRING COMMENT 'Operational notes describing how the sampling schedule must be adjusted to reflect the waiver-reduced monitoring frequency.',
    `vulnerability_assessment_date` DATE COMMENT 'Date on which the vulnerability assessment or source water assessment supporting the waiver was completed.',
    `vulnerability_assessment_result` STRING COMMENT 'Outcome of the vulnerability assessment indicating the level of vulnerability to the contaminant at the sampling point (e.g., not vulnerable, low vulnerability).. Valid values are `not_vulnerable|low_vulnerability|moderate_vulnerability|high_vulnerability`',
    `waiver_conditions` STRING COMMENT 'Specific conditions, requirements, or restrictions imposed by the primacy agency for maintaining the waiver (e.g., annual source water monitoring, notification requirements, operational changes).',
    `waiver_duration_years` DECIMAL(18,2) COMMENT 'Duration of the monitoring waiver in years, representing the period between effective date and expiration date.',
    `waiver_justification` STRING COMMENT 'Detailed business and regulatory justification for granting the monitoring waiver, including vulnerability assessment results, historical non-detect data, or source water protection measures.',
    `waiver_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned by the primacy agency or utility for this monitoring waiver.',
    `waiver_status` STRING COMMENT 'Current lifecycle status of the monitoring waiver indicating whether it is active, expired, revoked, pending approval, suspended, or renewed.. Valid values are `active|expired|revoked|pending|suspended|renewed`',
    `waiver_type` STRING COMMENT 'Classification of the monitoring waiver based on the regulatory basis for reduced monitoring (e.g., vulnerability assessment waiver, source water waiver, contaminant-specific waiver).. Valid values are `vulnerability_assessment|source_water|contaminant_specific|composite|reduced_frequency|other`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this monitoring waiver record.',
    CONSTRAINT pk_monitoring_waiver PRIMARY KEY(`monitoring_waiver_id`)
) COMMENT 'Master record of approved monitoring waivers granted by the primacy agency allowing reduced monitoring frequency for specific contaminants at specific sampling points. Captures waiver type (vulnerability assessment, source water, contaminant-specific), contaminant group, waiver approval date, expiration date, reduced monitoring frequency, primacy agency approval reference, and conditions for waiver continuation. Ensures the sampling_schedule correctly reflects waiver-adjusted requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` (
    `quality_public_notification_id` BIGINT COMMENT 'Unique identifier for the quality_public_notification data product (auto-inserted pre-linking).',
    `compliance_violation_id` BIGINT COMMENT 'add column compliance_violation_id (BIGINT) with FK to compliance.compliance_violation.compliance_violation_id - public notifications are triggered by compliance violations per SDWA',
    `contaminant_id` BIGINT COMMENT 'add column contaminant_id (BIGINT) with FK to quality.contaminant.contaminant_id - public notifications are issued for specific contaminant exceedances',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Public notifications for water quality violations (Tier 1/2/3 PN) must be delivered to affected customer accounts with proof of delivery tracking. EPA regulatory requirement: PN delivery documentation',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Geographic targeting of public notifications based on affected service areas (boil water notices, lead exceedances, pressure zone contamination). Operational necessity: incident response, door-to-door',
    `compliance_public_notification_id` BIGINT COMMENT '',
    CONSTRAINT pk_quality_public_notification PRIMARY KEY(`quality_public_notification_id`)
) COMMENT 'Transactional record of each public notification issued to customers and the primacy agency in response to MCL violations, monitoring failures, or other reportable water quality events. Captures notification type (Tier 1 immediate, Tier 2 30-day, Tier 3 annual), triggering violation or event, notification date, delivery method (newspaper, mail, electronic, posting), affected population count, health effects language used, and certification of delivery to primacy agency. Tracks compliance with public notification rule timelines.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` (
    `online_instrument_id` BIGINT COMMENT 'Unique identifier for the online water quality monitoring instrument. Primary key for the online instrument registry.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Online instruments measure specific contaminants/parameters. Currently has measurement_parameter as a STRING. Adding contaminant_id normalizes this to reference the contaminant registry and allows rem',
    `facility_id` BIGINT COMMENT 'Identifier of the water treatment plant (WTP), wastewater treatment plant (WWTP), pump station, or other facility where the instrument is installed.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Online instruments are capital assets requiring depreciation tracking, asset management, and inclusion in rate base for rate case proceedings—standard utility practice for capitalizing monitoring equi',
    `registry_id` BIGINT COMMENT 'Reference to the general asset registry if this instrument is also tracked as a capital asset in the CMMS or ERP system. Links quality-specific instrument metadata to enterprise asset management.',
    `online_registry_id` BIGINT COMMENT 'Reference to the general asset registry if this instrument is also tracked as a capital asset in the CMMS or ERP system. Links quality-specific instrument metadata to enterprise asset management.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the specific sampling point or monitoring location where the instrument is deployed. Links to the sampling point registry for regulatory compliance tracking.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Online instruments purchased from and serviced by vendors. Required for warranty tracking, calibration service scheduling, spare parts procurement, and vendor performance evaluation. No existing unlin',
    `accuracy_specification` STRING COMMENT 'Manufacturers stated accuracy or precision specification for the instrument (e.g., ±0.02 NTU, ±2% of reading, ±0.1 pH units). Critical for data quality assessment.',
    `alarm_high_threshold` DECIMAL(18,2) COMMENT 'Upper alarm threshold value configured in SCADA. When instrument reading exceeds this value, an alarm is triggered for operator response.',
    `alarm_low_threshold` DECIMAL(18,2) COMMENT 'Lower alarm threshold value configured in SCADA. When instrument reading falls below this value, an alarm is triggered for operator response.',
    `calibration_frequency_days` STRING COMMENT 'Required interval between calibrations, expressed in days. Determined by manufacturer recommendations, regulatory requirements, and operational experience.',
    `calibration_standard_used` STRING COMMENT 'Description of the calibration standard or reference material used during the most recent calibration (e.g., NIST-traceable 10 NTU formazin standard, pH 7.0 buffer solution).',
    `calibration_technician` STRING COMMENT 'Name or identifier of the technician who performed the most recent calibration. Used for quality assurance and accountability.',
    `communication_protocol` STRING COMMENT 'Communication protocol used by the instrument to transmit data to SCADA or control systems (e.g., Modbus RTU, Modbus TCP/IP, HART, Profibus, analog 4-20mA signal). [ENUM-REF-CANDIDATE: modbus_rtu|modbus_tcp|hart|profibus|foundation_fieldbus|ethernet_ip|analog_4_20ma|digital_pulse|bacnet — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system. Used for data lineage and audit trail.',
    `data_logging_interval_seconds` STRING COMMENT 'Frequency at which the instrument records or transmits data to the SCADA/historian system, expressed in seconds (e.g., 60 for one-minute intervals, 300 for five-minute intervals).',
    `expected_service_life_years` STRING COMMENT 'Anticipated operational lifespan of the instrument in years, based on manufacturer specifications and utility experience. Used for capital planning and replacement scheduling.',
    `gis_feature_code` STRING COMMENT 'Unique identifier in the GIS system linking this instrument to its geographic location and network context. Enables spatial analysis and network modeling.',
    `installation_date` DATE COMMENT 'Date when the instrument was installed and commissioned at its current location. Used for asset lifecycle tracking and warranty management.',
    `installation_location` STRING COMMENT 'Detailed description of where the instrument is physically installed (e.g., WTP Filter Effluent Gallery, Distribution Pump Station 5 Discharge, WWTP Final Clarifier Effluent Channel).',
    `instrument_name` STRING COMMENT 'Descriptive name of the online monitoring instrument indicating its function and location (e.g., WTP Effluent Turbidimeter, Distribution Zone 3 Chlorine Analyzer).',
    `instrument_tag` STRING COMMENT 'Unique alphanumeric tag or asset identifier assigned to the instrument for field identification and maintenance tracking. Typically follows plant or utility tagging conventions.',
    `instrument_type` STRING COMMENT 'Classification of the online instrument by measurement function. Defines the primary water quality parameter or operational metric the instrument monitors. [ENUM-REF-CANDIDATE: turbidimeter|chlorine_analyzer|ph_meter|toc_analyzer|uv254_sensor|flow_meter|conductivity_meter|dissolved_oxygen_analyzer|particle_counter|fluorometer|ammonia_analyzer|nitrate_analyzer|phosphate_analyzer|bod_analyzer|cod_analyzer|tss_analyzer|ozone_analyzer|pressure_transmitter|temperature_sensor — promote to reference product]',
    `last_calibration_date` DATE COMMENT 'Date when the instrument was most recently calibrated. Used to track calibration compliance and schedule next calibration.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the instrument installation location in decimal degrees. Used for mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the instrument installation location in decimal degrees. Used for mapping and spatial analysis.',
    `maintenance_notes` STRING COMMENT 'Free-text field for recording maintenance history, operational issues, calibration adjustments, or other relevant notes about the instruments performance and service history.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Maximum value of the instruments calibrated measurement range. Defines the upper detection limit for accurate readings.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Minimum value of the instruments calibrated measurement range. Defines the lower detection limit for accurate readings.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the parameter reported by the instrument (e.g., mg/L, NTU, pH units, µS/cm, ppm, ppb, GPM, MGD, PSI).',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the instrument. Used for procurement, spare parts identification, and technical support.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who most recently modified this instrument record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was most recently updated. Used for change tracking and data quality monitoring.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration. Calculated from last calibration date plus calibration frequency. Used for preventive maintenance scheduling.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. Indicates whether the instrument is actively monitoring, undergoing maintenance, or out of service.. Valid values are `operational|out_of_service|maintenance|calibration|failed|decommissioned`',
    `pi_historian_tag` STRING COMMENT 'Tag name in the OSIsoft PI Historian or equivalent time-series database where continuous instrument readings are stored for trending and analysis.',
    `power_supply_type` STRING COMMENT 'Type of electrical power supply used by the instrument (e.g., AC 120V, DC 24V, battery-powered, solar-powered, loop-powered from 4-20mA signal).. Valid values are `ac_120v|ac_240v|dc_24v|battery|solar|loop_powered`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this instrument is used for regulatory compliance monitoring and reporting (e.g., SDWA, NPDES permit requirements). True if data from this instrument is reported to regulatory agencies.',
    `responsible_department` STRING COMMENT 'Name of the department or work group responsible for maintaining and calibrating this instrument (e.g., Water Quality Lab, Instrumentation & Controls, Plant Operations).',
    `scada_tag_name` STRING COMMENT 'Unique tag identifier in the SCADA system that receives real-time data from this instrument. Used for process control, alarming, and data historian integration.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit. Critical for warranty tracking and service history.',
    `treatment_stage` STRING COMMENT 'Stage in the water or wastewater treatment process where the instrument is monitoring. Critical for understanding data context and compliance requirements. [ENUM-REF-CANDIDATE: raw_water|pre_treatment|coagulation|flocculation|sedimentation|filtration|disinfection|post_treatment|distribution|wastewater_influent|primary_treatment|secondary_treatment|tertiary_treatment|effluent_discharge|sludge_processing — promote to reference product]',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage expires. Critical for maintenance planning and budgeting.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this instrument record. Used for accountability and audit trail.',
    CONSTRAINT pk_online_instrument PRIMARY KEY(`online_instrument_id`)
) COMMENT 'Master registry of continuous online water quality monitoring instruments deployed across WTPs, WWTPs, and the distribution network. Captures instrument type (turbidimeter, chlorine analyzer, pH meter, TOC analyzer, UV254 sensor, flow meter), manufacturer, model, serial number, installation location/sampling point, calibration frequency, last calibration date, calibration standard used, communication protocol (SCADA/Modbus/HART), PI Historian tag name, and operational status. Distinct from the asset domains general asset registry by focusing on quality-specific instrument metadata and calibration management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` (
    `quality_instrument_calibration_id` BIGINT COMMENT 'Unique identifier for the quality_instrument_calibration data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - calibration events require recording who performed them for QA/QC audit trails',
    `online_instrument_id` BIGINT COMMENT 'add column online_instrument_id (BIGINT) with FK to quality.online_instrument.online_instrument_id - calibration records must link to the instrument being calibrated',
    `instrument_id` BIGINT COMMENT '',
    `calibration_date` DATE COMMENT '',
    `calibration_due_date` DATE COMMENT '',
    `calibration_type` STRING COMMENT '',
    `calibration_standard_used` STRING COMMENT '',
    `calibration_result` STRING COMMENT '',
    `performed_by` STRING COMMENT '',
    `certificate_number` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_quality_instrument_calibration PRIMARY KEY(`quality_instrument_calibration_id`)
) COMMENT 'Transactional record of each calibration event performed on an online or field water quality instrument. Captures calibration date/time, instrument ID, calibration type (single-point, multi-point, verification), standard solution used (concentration, lot number, expiry), pre-calibration reading, post-calibration reading, calibration factor applied, technician ID, pass/fail status, and next calibration due date. Ensures data quality and defensibility of continuous monitoring data used for regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` (
    `iup_monitoring_result_id` BIGINT COMMENT 'Unique identifier for the industrial user pretreatment monitoring result record.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: IUP monitoring results are based on underlying analytical results. Currently duplicates many analytical_result attributes (result_value, detection_limit, analytical_method, etc.). Adding analytical_re',
    `compliance_permit_id` BIGINT COMMENT 'Identifier for the NPDES permit under which this industrial user monitoring result is reported.',
    `contaminant_id` BIGINT COMMENT 'Identifier for the contaminant or parameter being monitored in this result.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Industrial user monitoring costs are often recovered through IUP permit fees; cost center tracking enables cost recovery analysis, fee justification, and budget management for pretreatment program ope',
    `industrial_user_id` BIGINT COMMENT 'Identifier for the significant industrial user (SIU) subject to pretreatment monitoring.',
    `industrial_user_permit_id` BIGINT COMMENT 'Identifier for the Industrial User Permit under which this monitoring result was collected.',
    `laboratory_id` BIGINT COMMENT 'Identifier for the laboratory that performed the analysis.',
    `employee_id` BIGINT COMMENT 'Identifier for the utility employee who collected the sample, if utility-collected.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier for the utility employee who reviewed and validated the monitoring result.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Industrial user permit monitoring follows pretreatment program sampling schedules for local limits and categorical standards. Links result to regulatory schedule for compliance determination, enforcem',
    `special_contract_id` BIGINT COMMENT 'Foreign key linking to service.special_contract. Business justification: Industrial users with special contracts often have negotiated discharge limits, monitoring frequencies, and penalty structures beyond standard IUP permits. IUP monitoring results verify compliance wit',
    `water_sample_id` BIGINT COMMENT 'Identifier linking this monitoring result to the water sample record in the laboratory information management system.',
    `categorical_standard_value` DECIMAL(18,2) COMMENT 'The federal categorical pretreatment standard applicable to this industrial user category and parameter, if applicable.',
    `compliance_status` STRING COMMENT 'The compliance status of this monitoring result relative to the applicable local or categorical pretreatment limit.. Valid values are `compliant|non_compliant|exceedance|pending_review|not_applicable`',
    `composite_duration_hours` DECIMAL(18,2) COMMENT 'The duration in hours over which a composite sample was collected, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this monitoring result record was first created in the system.',
    `daily_flow_mgd` DECIMAL(18,2) COMMENT 'The total daily flow in million gallons per day from the industrial user on the sampling date.',
    `dmr_reporting_period` STRING COMMENT 'The reporting period (e.g., 2024-Q1, 2024-03) for which this result will be included in the DMR.',
    `dmr_reporting_required` BOOLEAN COMMENT 'Indicates whether this monitoring result must be included in the utilitys Discharge Monitoring Report to the regulatory agency.',
    `enforcement_action_triggered` BOOLEAN COMMENT 'Indicates whether this non-compliant result triggered an enforcement action against the industrial user.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage by which the result value exceeds the applicable limit, if non-compliant.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The flow rate in gallons per minute at the sampling point during sample collection.',
    `holding_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the required holding time for the parameter.',
    `local_limit_unit` STRING COMMENT 'The unit of measure for the local pretreatment limit.',
    `local_limit_value` DECIMAL(18,2) COMMENT 'The local pretreatment limit established by the utility for this parameter under the Industrial User Permit.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this monitoring result record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this monitoring result record was last modified.',
    `monitoring_type` STRING COMMENT 'Indicates whether the sample was collected through industrial user self-monitoring, utility inspection, or third-party sampling.. Valid values are `self_monitoring|utility_collected|third_party|composite|grab`',
    `parameter_code` STRING COMMENT 'The standardized code for the parameter being monitored, typically aligned with EPA or state regulatory codes.',
    `parameter_name` STRING COMMENT 'The name of the parameter or contaminant being measured (e.g., Biochemical Oxygen Demand (BOD), Chemical Oxygen Demand (COD), Total Suspended Solids (TSS), heavy metals, Fats Oils and Grease (FOG), pH, specific toxics).',
    `permit_number` STRING COMMENT 'The externally-known permit number issued to the industrial user for pretreatment compliance.',
    `quality_control_status` STRING COMMENT 'The quality control status of the analytical result, indicating whether QC checks passed.. Valid values are `passed|failed|pending|not_applicable`',
    `remarks` STRING COMMENT 'Additional notes or comments regarding the monitoring result, sample collection, or compliance status.',
    `sample_type` STRING COMMENT 'The type of sample collected (grab sample, composite sample, or continuous monitoring).. Valid values are `grab|composite|continuous`',
    `sampler_name` STRING COMMENT 'The name of the individual who collected the sample.',
    `sampling_date` DATE COMMENT 'The date on which the industrial user sample was collected for pretreatment monitoring.',
    `sampling_point_description` STRING COMMENT 'Detailed description of the specific sampling location at the industrial user facility.',
    `sampling_point_type` STRING COMMENT 'The type of sampling location where the industrial user sample was collected (influent to facility, effluent from pretreatment unit, process stream, final discharge point, etc.).. Valid values are `influent|effluent|process|discharge|pretreatment_unit|combined`',
    `sampling_time` TIMESTAMP COMMENT 'The precise timestamp when the industrial user sample was collected, including time of day.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this monitoring result record.',
    CONSTRAINT pk_iup_monitoring_result PRIMARY KEY(`iup_monitoring_result_id`)
) COMMENT 'Transactional record of industrial user pretreatment monitoring results collected from significant industrial users (SIUs) under Industrial User Permits (IUPs). Captures industrial user ID, permit number, sampling date, sampling point (influent, effluent, process), parameter (BOD, COD, TSS, heavy metals, FOG, pH, specific toxics), result value, local pretreatment limit, compliance status, and self-monitoring vs. utility-collected designation. Supports pretreatment program compliance and NPDES permit reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` (
    `fog_monitoring_event_id` BIGINT COMMENT 'Unique identifier for the FOG monitoring event record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FOG inspection program costs (inspector time, equipment, enforcement) are tracked by cost center for program budgeting, cost recovery through fees, and rate case justification of collection system mai',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who conducted the FOG inspection.',
    `grease_interceptor_id` BIGINT COMMENT 'Identifier of the specific grease trap or interceptor being monitored.',
    `inspector_employee_id` BIGINT COMMENT 'Identifier of the employee who conducted the FOG inspection.',
    `pretreatment_iup_id` BIGINT COMMENT 'Foreign key linking to compliance.pretreatment_iup. Business justification: FOG monitoring events enforce pretreatment permit conditions for food service establishments (grease trap/interceptor compliance). This link connects FOG inspections to industrial user permits, essent',
    `fog_source_id` BIGINT COMMENT 'Identifier of the food service establishment or industrial contributor being inspected.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: FOG monitoring events occur at specific sampling locations. While fog_source_id links to the establishment (cross-domain), sampling_point_id identifies the physical monitoring location within the qual',
    `best_management_practices_compliant` BOOLEAN COMMENT 'Indicates whether the establishment is following FOG best management practices.',
    `bmp_deficiencies` STRING COMMENT 'Description of any deficiencies in FOG best management practices observed.',
    `compliance_status` STRING COMMENT 'Compliance status of the establishment with local FOG ordinance requirements.. Valid values are `compliant|non_compliant|conditional|warning`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions required to achieve compliance.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the establishment must complete required corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to address inspection findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG monitoring event record was created in the system.',
    `days_since_last_pump_out` STRING COMMENT 'Number of days elapsed since the last pump-out service.',
    `effluent_fog_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of FOG in the effluent discharge in milligrams per liter.',
    `enforcement_action_triggered` BOOLEAN COMMENT 'Indicates whether this inspection triggered an enforcement action due to non-compliance.',
    `enforcement_action_type` STRING COMMENT 'Type of enforcement action taken as a result of the inspection findings.. Valid values are `notice_of_violation|citation|fine|permit_suspension|legal_action|warning`',
    `establishment_type` STRING COMMENT 'Type of food service establishment or industrial contributor. [ENUM-REF-CANDIDATE: restaurant|cafeteria|food_processor|bakery|hotel|hospital|school|industrial — 8 candidates stripped; promote to reference product]',
    `grease_accumulation_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth of accumulated fats, oils, and grease in the interceptor in inches.',
    `grease_accumulation_percentage` DECIMAL(18,2) COMMENT 'Percentage of interceptor capacity filled with FOG accumulation.',
    `inspection_date` DATE COMMENT 'Date when the FOG monitoring inspection was conducted.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the FOG monitoring inspection was performed.',
    `inspection_type` STRING COMMENT 'Type of FOG monitoring inspection conducted.. Valid values are `routine|complaint|follow_up|initial|reinspection|emergency`',
    `inspector_notes` STRING COMMENT 'Additional notes and observations recorded by the inspector during the FOG monitoring event.',
    `interceptor_condition` STRING COMMENT 'Physical condition assessment of the grease interceptor or trap.. Valid values are `good|fair|poor|critical`',
    `interceptor_size_gallons` DECIMAL(18,2) COMMENT 'Capacity of the grease interceptor or trap in gallons.',
    `iup_permit_number` STRING COMMENT 'Industrial user permit number for the establishment if applicable.',
    `last_pump_out_date` DATE COMMENT 'Date when the grease interceptor was last pumped out or cleaned.',
    `maintenance_issues_noted` STRING COMMENT 'Description of any maintenance issues or deficiencies observed during the inspection.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG monitoring event record was last modified.',
    `notification_sent_date` DATE COMMENT 'Date when the inspection notification or report was sent to the establishment.',
    `notification_sent_to_establishment` BOOLEAN COMMENT 'Indicates whether an inspection report or notification was sent to the establishment.',
    `ordinance_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the FOG accumulation or concentration exceeded the local ordinance threshold.',
    `photo_documentation_available` BOOLEAN COMMENT 'Indicates whether photographic documentation of the inspection is available.',
    `pump_out_frequency_compliant` BOOLEAN COMMENT 'Indicates whether the establishment is compliant with the required pump-out frequency.',
    `pump_out_service_provider` STRING COMMENT 'Name of the licensed service provider who performed the last pump-out.',
    `reinspection_required` BOOLEAN COMMENT 'Indicates whether a follow-up reinspection is required to verify corrective actions.',
    `reinspection_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up reinspection.',
    `required_pump_out_frequency_days` STRING COMMENT 'Required frequency for pump-out service as mandated by local FOG ordinance, in days.',
    `sso_risk_level` STRING COMMENT 'Assessed risk level of potential sanitary sewer overflow based on FOG accumulation and discharge quality.. Valid values are `low|medium|high|critical`',
    `violation_code` STRING COMMENT 'Code identifying the specific FOG ordinance violation observed during inspection.',
    `violation_description` STRING COMMENT 'Detailed description of the FOG ordinance violation identified during the inspection.',
    `created_by` STRING COMMENT 'User identifier of the person who created this record.',
    CONSTRAINT pk_fog_monitoring_event PRIMARY KEY(`fog_monitoring_event_id`)
) COMMENT 'Transactional record of Fats, Oils, and Grease (FOG) program inspections and monitoring events at food service establishments and industrial grease interceptor sites. Captures inspection date, establishment identifier, interceptor specifications (size, type), grease accumulation measurement, effluent FOG concentration (mg/L), compliance status against local FOG ordinance limits, pump-out frequency verification, maintenance condition assessment, and enforcement action triggered (warning, NOV, permit revocation). Supports FOG program management, sanitary sewer overflow (SSO) prevention, and pretreatment program reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` (
    `quality_corrective_action_id` BIGINT COMMENT 'Primary key for corrective_action',
    `exceedance_id` BIGINT COMMENT 'Foreign key linking to quality.exceedance. Business justification: Quality corrective actions are often triggered by MCL exceedances. Currently has triggering_event_reference_id as a STRING. Adding exceedance_id as a typed FK establishes the proper relationship and a',
    `quality_instrument_calibration_id` BIGINT COMMENT 'Foreign key linking to quality.quality_instrument_calibration. Business justification: Quality corrective actions can be triggered by instrument calibration failures or out-of-tolerance conditions. This FK links corrective actions to the specific calibration event that triggered them.',
    `compliance_corrective_action_id` BIGINT COMMENT '',
    CONSTRAINT pk_quality_corrective_action PRIMARY KEY(`quality_corrective_action_id`)
) COMMENT 'Operational record tracking corrective and preventive actions arising from water quality events including MCL exceedances, monitoring failures, instrument malfunctions, and process upsets. Captures triggering event reference, action type (corrective, preventive, investigative), action description, responsible party, due date, completion date, verification method, and closure status. Provides the quality management workflow layer connecting quality findings to operational response and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` (
    `compliance_determination_id` BIGINT COMMENT 'Unique identifier for the compliance_determination data product (auto-inserted pre-linking).',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Compliance determinations are contaminant-specific (e.g., compliance determination for lead, for TTHM, etc.). This FK identifies which contaminant the determination applies to.',
    `regulatory_requirement_id` BIGINT COMMENT 'add column regulatory_requirement_id (BIGINT) with FK to compliance.regulatory_requirement.regulatory_requirement_id - compliance determinations are made against specific regulatory requirements (MCLs, TTs)',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Compliance determinations aggregate analytical results for a specific sampling schedule over a monitoring period. This FK links the compliance determination to the schedule being evaluated, eliminatin',
    `superseded_compliance_determination_id` BIGINT COMMENT 'Self-referencing FK on compliance_determination (superseded_compliance_determination_id)',
    CONSTRAINT pk_compliance_determination PRIMARY KEY(`compliance_determination_id`)
) COMMENT 'Period-level compliance determination record that aggregates analytical results into a formal compliance status for each contaminant group, monitoring period, and regulatory rule. Captures determination period (monthly, quarterly, annual), contaminant or contaminant group, applicable rule (SDWA, CWA, NPDES), calculation method (single sample max, running annual average, 90th percentile), calculated compliance value, applicable limit, pass/fail status, and determination date. Bridges the gap between individual analytical results and regulatory reporting by providing the formal compliance roll-up that drives CCR preparation, DMR submission, and violation determination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` (
    `qaqc_batch_id` BIGINT COMMENT 'Unique identifier for the qaqc_batch data product (auto-inserted pre-linking).',
    `qc_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.qc_batch. Business justification: Quality domains QA/QC batch tracking must reference laboratorys QC batch for method validation and data defensibility. Regulatory audits (EPA, primacy agencies) require tracing quality results to la',
    `reanalysis_qaqc_batch_id` BIGINT COMMENT 'Self-referencing FK on qaqc_batch (reanalysis_qaqc_batch_id)',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: QA/QC batches group analytical results with their associated samples for quality control purposes. Linking to the primary water_sample in the batch establishes the in-domain relationship and eliminate',
    CONSTRAINT pk_qaqc_batch PRIMARY KEY(`qaqc_batch_id`)
) COMMENT 'Quality assurance and quality control batch record grouping analytical results with their associated QC samples (method blanks, laboratory control samples, matrix spikes, duplicates, surrogate recoveries). Captures batch ID, analytical method, analysis date, QC acceptance criteria, batch-level pass/fail status, corrective action if failed, and data usability assessment. Essential for defending analytical data quality during regulatory audits and ensuring results meet method-specific precision and accuracy requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` (
    `territory_contaminant_monitoring_requirement_id` BIGINT COMMENT 'Primary key for the territory_contaminant_monitoring_requirement association',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to the contaminant being monitored in this territory',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Territory-specific contaminant monitoring requirements drive the creation and configuration of sampling schedules. This FK links the requirement to the schedule(s) that implement it, enabling tracking',
    `territory_id` BIGINT COMMENT 'Foreign key linking to the service territory where monitoring requirements apply',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting the rationale for territory-specific requirements, variance conditions, or special monitoring instructions from the primacy agency.',
    `effective_date` DATE COMMENT 'Date when this territory-specific monitoring requirement, variance, or action level became effective. Critical for compliance tracking and historical regulatory reporting.',
    `expiration_date` DATE COMMENT 'Date when this territory-specific monitoring requirement, variance, or exemption expires and reverts to standard requirements. Null if permanent. Essential for proactive compliance management.',
    `local_action_level` DECIMAL(18,2) COMMENT 'Action level specific to this territory that may differ from the federal standard due to state primacy agency requirements or local conditions. Exists because state agencies with primacy can set more stringent requirements than federal MCLs.',
    `monitoring_frequency_override` STRING COMMENT 'Territory-specific monitoring frequency that overrides the default contaminant monitoring_frequency_code based on primacy agency approval, vulnerability assessment results, or granted waivers. This attribute exists because different territories may have different monitoring requirements for the same contaminant.',
    `primacy_agency_override` STRING COMMENT 'Identification of the specific primacy agency (state or EPA regional office) that issued the territory-specific requirement or variance. Necessary because different territories may fall under different primacy jurisdictions.',
    `territory_specific_mcl` DECIMAL(18,2) COMMENT 'Maximum contaminant level specific to this territory, typically more stringent than federal MCL when set by state primacy agencies. This attribute captures jurisdiction-specific regulatory limits that vary by territory.',
    `variance_approval_number` STRING COMMENT 'Official reference number of the variance, waiver, or exemption approval issued by the primacy agency. Used for regulatory correspondence and audit trail.',
    `variance_status` STRING COMMENT 'Current status of any monitoring variance, waiver, or exemption granted by the primacy agency for this contaminant in this territory. Tracks whether the utility has been granted relief from standard monitoring requirements.',
    `vulnerability_assessment_result` STRING COMMENT 'Result of source water vulnerability assessment for this contaminant in this territory. Determines eligibility for monitoring waivers and reduced frequency. This is territory-specific because vulnerability depends on local source water characteristics.',
    CONSTRAINT pk_territory_contaminant_monitoring_requirement PRIMARY KEY(`territory_contaminant_monitoring_requirement_id`)
) COMMENT 'This association product represents the territory-specific monitoring requirements and regulatory variances between contaminants and service territories. It captures jurisdiction-specific monitoring frequencies, action levels, and variance statuses that exist only in the context of a specific contaminant being monitored within a specific service territory. Each record links one contaminant to one service territory with regulatory override attributes that reflect primacy agency decisions, vulnerability assessments, and approved variances.. Existence Justification: In water utility operations, contaminants have different monitoring requirements across service territories based on primacy agency jurisdiction, source water vulnerability assessments, and approved regulatory variances. A single contaminant (e.g., lead) may require quarterly monitoring in one territory but have a waiver for reduced frequency in another territory based on vulnerability assessment results. Conversely, a single service territory must track territory-specific monitoring requirements, action levels, and variance statuses for dozens of regulated contaminants. This is an operational compliance management relationship that utilities actively maintain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` (
    `monitoring_context_id` BIGINT COMMENT 'Primary key for monitoring_context',
    `compliance_permit_id` BIGINT COMMENT 'add column compliance_permit_id (BIGINT) with FK to compliance.compliance_permit.compliance_permit_id - monitoring contexts are defined by permit requirements',
    `parent_monitoring_context_id` BIGINT COMMENT 'Self-referencing FK on monitoring_context (parent_monitoring_context_id)',
    `monitoring_context_code` STRING COMMENT 'Unique business code used to reference the monitoring context in operational systems.',
    `context_type` STRING COMMENT 'Category of the monitoring context indicating the water system segment it applies to.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring context record was first created in the system.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the quality and reliability of the data collected under this context.',
    `effective_end_date` DATE COMMENT 'Date when the monitoring context expires or is retired (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the monitoring context becomes effective.',
    `geographic_region` STRING COMMENT 'Three‑letter ISO country code representing the region of the monitoring location.',
    `location_code` STRING COMMENT 'Code identifying the physical location (e.g., treatment plant, reservoir, distribution node) where monitoring occurs.',
    `measurement_parameter` STRING COMMENT 'Water quality parameter measured in this context (e.g., pH, turbidity, chlorine, BOD, COD, TSS, TDS, TOC, DBP, PFAS). [ENUM-REF-CANDIDATE: pH|turbidity|temperature|chlorine|conductivity|BOD|COD|TSS|TDS|TOC|DBP|PFAS — promote to reference product]',
    `monitoring_context_name` STRING COMMENT 'Human‑readable name describing the monitoring context.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the monitoring context.',
    `regulatory_limit_unit` STRING COMMENT 'Unit associated with the regulatory limit value.',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable value for the measurement parameter as defined by regulatory standards.',
    `sampling_frequency` STRING COMMENT 'How often samples are collected for this monitoring context.',
    `sampling_method` STRING COMMENT 'Technique used to obtain water samples.',
    `monitoring_context_status` STRING COMMENT 'Current lifecycle status of the monitoring context.',
    `unit_of_measure` STRING COMMENT 'Unit used for the measurement parameter (e.g., mg/L, NTU, pH units, µg/L).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the monitoring context record.',
    CONSTRAINT pk_monitoring_context PRIMARY KEY(`monitoring_context_id`)
) COMMENT 'Master reference table for monitoring_context. Referenced by monitoring_context_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` (
    `sampling_round_id` BIGINT COMMENT 'Primary key for sampling_round',
    `certified_analyst_id` BIGINT COMMENT 'Identifier of the laboratory analyst responsible for processing the samples.',
    `facility_id` BIGINT COMMENT 'Identifier of the water facility or site where the sampling round is performed.',
    `parent_sampling_round_id` BIGINT COMMENT 'Self-referencing FK on sampling_round (parent_sampling_round_id)',
    `regulatory_submission_id` BIGINT COMMENT 'Link to the regulatory compliance report generated from this round.',
    `sampling_plan_id` BIGINT COMMENT 'Reference to the predefined sampling plan governing this round.',
    `compliance_status` STRING COMMENT 'Regulatory compliance outcome for the round.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sampling round record was first created in the system.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact end time of the sampling activities.',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the sampling round was executed or is scheduled to occur.',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the round was initiated as an emergency response.',
    `mcl_exceedance_flag` BOOLEAN COMMENT 'True if any measured parameter exceeds its MCL for the round.',
    `notes` STRING COMMENT 'Free‑form comments entered by field staff.',
    `parameters_measured` STRING COMMENT 'Comma‑separated list of water quality parameters (e.g., pH, turbidity, lead) measured in this round.',
    `round_code` STRING COMMENT 'External code used by field crews and regulators to reference the sampling round.',
    `round_name` STRING COMMENT 'Human‑readable name or description of the sampling round.',
    `sample_type` STRING COMMENT 'Category of water being sampled.',
    `sampling_method` STRING COMMENT 'Technique used to collect the water sample.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the sampling round.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact start time of the sampling activities.',
    `sampling_round_status` STRING COMMENT 'Current lifecycle state of the sampling round.',
    `total_samples_collected` STRING COMMENT 'Number of samples actually collected during the round.',
    `total_samples_expected` STRING COMMENT 'Number of individual samples planned for the round.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sampling round record.',
    `weather_conditions` STRING COMMENT 'Brief description of weather during sampling (e.g., sunny, rain).',
    CONSTRAINT pk_sampling_round PRIMARY KEY(`sampling_round_id`)
) COMMENT 'Master reference table for sampling_round. Referenced by sampling_round_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` (
    `contaminant_group_id` BIGINT COMMENT 'Primary key for contaminant_group',
    `parent_contaminant_group_id` BIGINT COMMENT 'Self-referencing FK on contaminant_group (parent_contaminant_group_id)',
    `applicable_standards` STRING COMMENT 'List of standards, guidelines, or regulations that apply to this contaminant group (e.g., EPA MCL, WHO guidelines).',
    `contaminant_category` STRING COMMENT 'Broad classification of the contaminant group.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first inserted into the lakehouse.',
    `contaminant_group_description` STRING COMMENT 'Detailed description of the contaminant group, its relevance and typical usage.',
    `effective_from` DATE COMMENT 'Date when the contaminant group definition became effective.',
    `effective_until` DATE COMMENT 'Date when the contaminant group definition expires or is superseded (null if indefinite).',
    `group_code` STRING COMMENT 'Short alphanumeric code used to reference the contaminant group in systems and reports.',
    `group_name` STRING COMMENT 'Human‑readable name of the contaminant group (e.g., Disinfection By‑Products).',
    `health_effects_summary` STRING COMMENT 'Brief summary of known health impacts associated with exposure to the contaminant group.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the contaminant group is currently in active use within the system.',
    `max_contaminant_level` DECIMAL(18,2) COMMENT 'Regulatory maximum allowable concentration for the contaminant group.',
    `max_contaminant_level_goal` DECIMAL(18,2) COMMENT 'Health‑based goal concentration for the contaminant group (non‑enforceable).',
    `monitoring_frequency_days` STRING COMMENT 'Recommended number of days between routine monitoring events for this contaminant group.',
    `regulatory_status` STRING COMMENT 'Current regulatory status of the contaminant group under federal or state law.',
    `risk_level` STRING COMMENT 'Overall risk classification based on toxicity, prevalence, and regulatory concern.',
    `typical_concentration_range_high` DECIMAL(18,2) COMMENT 'Upper bound of typical observed concentration range for the contaminant group.',
    `typical_concentration_range_low` DECIMAL(18,2) COMMENT 'Lower bound of typical observed concentration range for the contaminant group.',
    `typical_sources` STRING COMMENT 'Common natural or anthropogenic sources of the contaminants in this group.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for reporting concentrations of this contaminant group.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_contaminant_group PRIMARY KEY(`contaminant_group_id`)
) COMMENT 'Master reference table for contaminant_group. Referenced by contaminant_group_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_system` (
    `water_system_id` BIGINT COMMENT 'Primary key for water_system',
    `compliance_permit_id` BIGINT COMMENT 'add column compliance_permit_id (BIGINT) with FK to compliance.compliance_permit.compliance_permit_id - water systems operate under specific primacy agency permits (PWS ID)',
    `parent_water_system_id` BIGINT COMMENT 'Self-referencing FK on water_system (parent_water_system_id)',
    `average_daily_consumption_mgd` DECIMAL(18,2) COMMENT 'Average daily water consumption served by the system.',
    `average_daily_production_mgd` DECIMAL(18,2) COMMENT 'Average daily water production volume.',
    `capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum designed water flow capacity.',
    `chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Typical residual chlorine concentration.',
    `classification` STRING COMMENT 'Ownership and governance classification of the water system.',
    `commissioning_date` DATE COMMENT 'Date when the water system entered service.',
    `compliance_status` STRING COMMENT 'Current compliance status with water quality regulations.',
    `construction_date` DATE COMMENT 'Date when construction of the water system was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the water system record was created.',
    `decommission_date` DATE COMMENT 'Date when the water system was retired, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the water system is currently active in the system.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate.',
    `location_city` STRING COMMENT 'City where the water system is located.',
    `location_state` STRING COMMENT 'State or province of the water system location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate.',
    `maintenance_schedule` STRING COMMENT 'Textual description of routine maintenance schedule (e.g., quarterly, annual).',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operational hours between failures.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time to repair a failure.',
    `water_system_name` STRING COMMENT 'Human readable name of the water system.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next inspection.',
    `number_of_units` STRING COMMENT 'Count of major equipment units within the system (e.g., pumps, filters).',
    `owner_organization` STRING COMMENT 'Name of the organization that owns the water system.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the regulatory permit.',
    `permit_number` STRING COMMENT 'Identifier of the regulatory permit governing the water system.',
    `ph_range` STRING COMMENT 'Typical pH range of output water (e.g., 6.5-8.5).',
    `source_type` STRING COMMENT 'Primary source of raw water for the system.',
    `water_system_status` STRING COMMENT 'Current operational status of the water system.',
    `system_code` STRING COMMENT 'Unique alphanumeric code assigned to the water system.',
    `system_type` STRING COMMENT 'Category of the water system based on function.',
    `total_coliforms_cfu_100ml` DECIMAL(18,2) COMMENT 'Typical total coliform count.',
    `treatment_processes` STRING COMMENT 'Comma-separated list of treatment processes applied (e.g., coagulation, filtration, disinfection).',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Typical turbidity measurement in Nephelometric Turbidity Units.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `water_quality_category` STRING COMMENT 'Classification of water quality produced.',
    CONSTRAINT pk_water_system PRIMARY KEY(`water_system_id`)
) COMMENT 'Master reference table for water_system. Referenced by water_system_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_contaminant_group_id` FOREIGN KEY (`contaminant_group_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_group`(`contaminant_group_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_parent_sample_water_sample_id` FOREIGN KEY (`parent_sample_water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_qaqc_batch_id` FOREIGN KEY (`qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_contaminant_group_id` FOREIGN KEY (`contaminant_group_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_group`(`contaminant_group_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_monitoring_context_id` FOREIGN KEY (`monitoring_context_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`monitoring_context`(`monitoring_context_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_turbidity_reading_id` FOREIGN KEY (`turbidity_reading_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`turbidity_reading`(`turbidity_reading_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_qaqc_batch_id` FOREIGN KEY (`qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_round_id` FOREIGN KEY (`sampling_round_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_round`(`sampling_round_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` ADD CONSTRAINT `fk_quality_quality_corrective_action_exceedance_id` FOREIGN KEY (`exceedance_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`exceedance`(`exceedance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` ADD CONSTRAINT `fk_quality_quality_corrective_action_quality_instrument_calibration_id` FOREIGN KEY (`quality_instrument_calibration_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration`(`quality_instrument_calibration_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_superseded_compliance_determination_id` FOREIGN KEY (`superseded_compliance_determination_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`compliance_determination`(`compliance_determination_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_reanalysis_qaqc_batch_id` FOREIGN KEY (`reanalysis_qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ADD CONSTRAINT `fk_quality_monitoring_context_parent_monitoring_context_id` FOREIGN KEY (`parent_monitoring_context_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`monitoring_context`(`monitoring_context_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_parent_sampling_round_id` FOREIGN KEY (`parent_sampling_round_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_round`(`sampling_round_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ADD CONSTRAINT `fk_quality_contaminant_group_parent_contaminant_group_id` FOREIGN KEY (`parent_contaminant_group_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_group`(`contaminant_group_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_parent_water_system_id` FOREIGN KEY (`parent_water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `asset_sampling_point_id` SET TAGS ('dbx_ssot_owner' = 'asset.asset_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'public|restricted|private_property|confined_space|remote');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `ccr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `dmr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Gallons Per Minute - GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `last_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `primary_contaminant_group` SET TAGS ('dbx_business_glossary_term' = 'Primary Contaminant Group');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Monitoring Zone');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `residence_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Residence Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `safety_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous_monitor|passive_sampler');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Sampler Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Sampling Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_point_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_point_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_point_name` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_point_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_point_status` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `sampling_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_suspended|decommissioned');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Stage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|groundwater_under_influence|blended|purchased|recycled');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `contaminant_group_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Group ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Laboratory (Lab) ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `chain_of_custody_id` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `parent_sample_water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sample Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collector Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Sampler Equipment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collector Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_group_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Group Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `monitoring_context_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Context Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `exceedance_id` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_subdomain' = 'specialized_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `dbp_monitoring_event_id` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Byproduct (DBP) Monitoring Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Water System ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `analysis_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `bromide_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Bromide Concentration (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `bromodichloromethane_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Bromodichloromethane Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `bromoform_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Bromoform Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `ccr_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Inclusion Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `chloroform_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Chloroform Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `dibromoacetic_acid_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Dibromoacetic Acid Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `dibromochloromethane_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Dibromochloromethane Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `dichloroacetic_acid_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Dichloroacetic Acid Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `free_chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Free Chlorine Residual (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `haa5_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Haloacetic Acids Five (HAA5) Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `haa5_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `haa5_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Haloacetic Acids Five (HAA5) Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `haa5_lraa_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Haloacetic Acids Five (HAA5) Locational Running Annual Average (LRAA) (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `haa5_mcl_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Haloacetic Acids Five (HAA5) Maximum Contaminant Level (MCL) (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|annual|reduced|increased');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `monobromoacetic_acid_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Monobromoacetic Acid Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `monochloroacetic_acid_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Monochloroacetic Acid Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen) Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `reported_to_state_date` SET TAGS ('dbx_business_glossary_term' = 'Reported to State Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `reported_to_state_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `reported_to_state_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to State Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `reported_to_state_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `sample_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'routine|confirmation|investigative|special');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `system_wide_haa5_raa_ug_l` SET TAGS ('dbx_business_glossary_term' = 'System-Wide Haloacetic Acids Five (HAA5) Running Annual Average (RAA) (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `system_wide_tthm_raa_ug_l` SET TAGS ('dbx_business_glossary_term' = 'System-Wide Total Trihalomethanes (TTHM) Running Annual Average (RAA) (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `toc_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Organic Carbon (TOC) Concentration (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `total_chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Chlorine Residual (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `trichloroacetic_acid_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Trichloroacetic Acid Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `tthm_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Total Trihalomethanes (TTHM) Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `tthm_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `tthm_concentration_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Total Trihalomethanes (TTHM) Concentration (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `tthm_lraa_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Total Trihalomethanes (TTHM) Locational Running Annual Average (LRAA) (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `tthm_mcl_ug_l` SET TAGS ('dbx_business_glossary_term' = 'Total Trihalomethanes (TTHM) Maximum Contaminant Level (MCL) (µg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `water_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Water Temperature (°C)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_subdomain' = 'specialized_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Pfas Monitoring Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_subdomain' = 'specialized_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `chain_of_custody_id` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_wtp_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `alarm_threshold_ntu` SET TAGS ('dbx_business_glossary_term' = 'Alarm Threshold in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `ct_compliance_context` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Compliance Context');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|calibration_due|instrument_fault|manual_override');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'pi_historian|lims|manual_entry|scada_direct');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Exceedance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `filter_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_location_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_location_type` SET TAGS ('dbx_value_regex' = 'ife|cfe|distribution_entry|raw_water|settled_water|filtered_water');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'nephelometric|continuous_online|grab_sample|laboratory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI Historian Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `regulatory_limit_ntu` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Turbidity Limit in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'automated|manual_grab|composite');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature in Celsius');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_value_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Value in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_subdomain' = 'specialized_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Calculation ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Process ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `turbidity_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Reading Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `calculated_ct_value_mg_min_l` SET TAGS ('dbx_business_glossary_term' = 'Calculated Contact Time (CT) Value in Milligrams-Minutes per Liter (mg·min/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'manual|automated_scada|pi_calculation|laboratory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|marginal|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `contact_chamber_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Contact Chamber Volume in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `contact_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (T) in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_ratio_giardia` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Ratio for Giardia');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_ratio_virus` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Ratio for Virus');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `disinfectant_residual_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Residual Concentration (C) in Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_value_regex' = 'chlorine|chloramine|ozone|uv|chlorine_dioxide|mixed_oxidant');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `log_inactivation_giardia` SET TAGS ('dbx_business_glossary_term' = 'Log Inactivation for Giardia');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `log_inactivation_virus` SET TAGS ('dbx_business_glossary_term' = 'Log Inactivation for Virus');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `mor_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Monthly Operating Report (MOR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `required_ct_giardia_3log_mg_min_l` SET TAGS ('dbx_business_glossary_term' = 'Required Contact Time (CT) for 3-Log Giardia Inactivation in Milligrams-Minutes per Liter (mg·min/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `required_ct_virus_4log_mg_min_l` SET TAGS ('dbx_business_glossary_term' = 'Required Contact Time (CT) for 4-Log Virus Inactivation in Milligrams-Minutes per Liter (mg·min/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `scada_tag_flow` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag for Flow');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `scada_tag_ph` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag for Potential of Hydrogen (pH)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `scada_tag_residual` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag for Residual');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `scada_tag_temperature` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag for Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `t10_factor` SET TAGS ('dbx_business_glossary_term' = 'T10 Factor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|requires_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `water_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Water Temperature in Degrees Celsius (°C)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_subdomain' = 'specialized_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `residual_chlorine_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Chlorine Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `process_control_setpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Process Control Setpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `residual_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `residual_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `residual_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `contact_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT - Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada_continuous|manual_field|laboratory|ami_sensor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_value_regex' = 'free_chlorine|total_chlorine|chloramine|chlorine_dioxide');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `maximum_allowed_residual_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowed Residual (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'colorimetric_dpd|amperometric|online_analyzer|test_strip');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `minimum_required_residual_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Residual (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen) Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `regulatory_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `residual_value_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Residual Value (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'grab_sample|composite_sample|continuous_monitor|inline_sensor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `sample_location_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `sample_location_type` SET TAGS ('dbx_value_regex' = 'wtp_clearwell|distribution_entry|distribution_remote|storage_tank|booster_station|wwtp_effluent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (mL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity (NTU - Nephelometric Turbidity Units)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `water_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Water Temperature (°C)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|storm|extreme_heat');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `bacteriological_result_id` SET TAGS ('dbx_business_glossary_term' = 'Bacteriological Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `primary_bacteriological_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `primary_bacteriological_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `primary_bacteriological_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Batch Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_copper_result_id` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collector Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_round_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Round ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_site_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identification Number');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_water_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Source Water Quality ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `bulk_water_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Water Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampled By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_location_source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `algae_count_cells_per_ml` SET TAGS ('dbx_business_glossary_term' = 'Algae Count in Cells per Milliliter');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `alkalinity_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Alkalinity in mg/L as CaCO3');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `ammonia_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Ammonia Concentration in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analysis Method Reference');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `chloride_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Chloride Concentration in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `color_pcu` SET TAGS ('dbx_business_glossary_term' = 'Color in Platinum-Cobalt Units (PCU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `conductivity_us_per_cm` SET TAGS ('dbx_business_glossary_term' = 'Conductivity in µS/cm');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `cyanotoxin_concentration_ug_per_l` SET TAGS ('dbx_business_glossary_term' = 'Cyanotoxin Concentration in µg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `cyanotoxin_detected` SET TAGS ('dbx_business_glossary_term' = 'Cyanotoxin Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `dissolved_oxygen_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Oxygen (DO) in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `hardness_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Hardness in mg/L as CaCO3');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `iron_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Iron Concentration in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `lab_analyzed_by` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analyst Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `manganese_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Manganese Concentration in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `nitrate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Nitrate Concentration in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen) Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `quality_control_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Passed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `regulatory_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exceedance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season of Measurement');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'spring|summer|fall|winter');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `seasonal_variation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Variation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Water Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|reservoir|lake|river|purchased_water');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `sulfate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Sulfate Concentration in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `tds_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Dissolved Solids (TDS) in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Water Temperature in Celsius');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `toc_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Organic Carbon (TOC) in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `treatment_adjustment_required` SET TAGS ('dbx_business_glossary_term' = 'Treatment Adjustment Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `treatment_adjustment_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `treatment_adjustment_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `tss_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) in mg/L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity (NTU - Nephelometric Turbidity Units)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition at Sampling');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'dry|wet|storm|drought|normal');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `effluent_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Quality ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Dmr Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampled By Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `special_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `ammonia_nitrogen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Ammonia Nitrogen (NH3-N) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `ammonia_permit_limit_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Ammonia Nitrogen (NH3-N) Permit Limit Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `analysis_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `bod5_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand 5-Day (BOD5) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `bod5_permit_limit_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand 5-Day (BOD5) Permit Limit Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `cbod5_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Carbonaceous Biochemical Oxygen Demand 5-Day (CBOD5) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `cod_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Chemical Oxygen Demand (COD) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exceedance|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `dissolved_oxygen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Oxygen (DO) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `e_coli_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Escherichia coli (E. coli) Colony Forming Units per 100 Milliliters (CFU/100mL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `fecal_coliform_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform Colony Forming Units per 100 Milliliters (CFU/100mL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `fecal_coliform_permit_limit_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform Permit Limit Colony Forming Units per 100 Milliliters (CFU/100mL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `ph_permit_range_max` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Permit Range Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `ph_permit_range_min` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Permit Range Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `sample_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite_24hr|composite_flow_weighted|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `tds_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Dissolved Solids (TDS) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `toc_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Organic Carbon (TOC) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `total_nitrogen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen (TN) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `total_phosphorus_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Phosphorus (TP) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `total_residual_chlorine_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Residual Chlorine (TRC) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `tss_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `tss_permit_limit_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Permit Limit Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_subdomain' = 'consumer_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Period ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `additional_languages` SET TAGS ('dbx_business_glossary_term' = 'Additional Languages');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_business_glossary_term' = 'Certification Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|fax|online_portal');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Certified By Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_title` SET TAGS ('dbx_business_glossary_term' = 'Certified By Title');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `customers_served_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Served Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `detected_contaminant_count` SET TAGS ('dbx_business_glossary_term' = 'Detected Contaminant Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'mailed|posted_online|electronic_delivery|newspaper|combination');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Language Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `language_accessibility_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Accessibility Provided Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `lead_copper_educational_information_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Educational Information Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `mcl_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `monitoring_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Monitoring and Reporting Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `online_ccr_url` SET TAGS ('dbx_business_glossary_term' = 'Online Consumer Confidence Report (CCR) URL');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `population_served_count` SET TAGS ('dbx_business_glossary_term' = 'Population Served Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `preparation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `primacy_agency` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'Public Water System Identification (PWSID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `pwsid` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|certified|archived');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `report_year` SET TAGS ('dbx_business_glossary_term' = 'Report Year');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `source_water_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Source Water Assessment Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `special_notices_included` SET TAGS ('dbx_business_glossary_term' = 'Special Notices Included');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `water_source_summary` SET TAGS ('dbx_business_glossary_term' = 'Water Source Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `water_system_name` SET TAGS ('dbx_business_glossary_term' = 'Water System Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `water_system_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_subdomain' = 'consumer_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_detected_contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Detected Contaminant Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Period Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `primary_ccr_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `primary_ccr_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `primary_ccr_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `tertiary_ccr_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `tertiary_ccr_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `tertiary_ccr_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `action_level` SET TAGS ('dbx_business_glossary_term' = 'Action Level (AL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `ccr_table_display_order` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Table Display Order');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|violation|pending_review|corrective_action_required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `contaminant_category` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `contaminant_category` SET TAGS ('dbx_value_regex' = 'inorganic|organic|disinfection_byproduct|microbiological|radiological|emerging_contaminant');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'lims|scada|manual_entry|state_reporting_system|laboratory_report');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `detection_frequency_percent` SET TAGS ('dbx_business_glossary_term' = 'Detection Frequency Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `footnote_text` SET TAGS ('dbx_business_glossary_term' = 'Footnote Text');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Language');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `highest_level_detected` SET TAGS ('dbx_business_glossary_term' = 'Highest Level Detected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `mcl` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `mclg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `number_of_detections` SET TAGS ('dbx_business_glossary_term' = 'Number of Detections');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `number_of_samples` SET TAGS ('dbx_business_glossary_term' = 'Number of Samples');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `range_high` SET TAGS ('dbx_business_glossary_term' = 'Range of Detections - High');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `range_low` SET TAGS ('dbx_business_glossary_term' = 'Range of Detections - Low');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `sample_year` SET TAGS ('dbx_business_glossary_term' = 'Sample Year');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `treatment_technique_flag` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `treatment_technique_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `treatment_technique_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `typical_source_description` SET TAGS ('dbx_business_glossary_term' = 'Typical Source Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'mcl_exceedance|action_level_exceedance|treatment_technique_violation|monitoring_violation|reporting_violation|none');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `monitoring_waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Waiver ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `baseline_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Baseline Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `ccr_reporting_impact` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Impact');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `contaminant_group` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Group');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `historical_monitoring_period_end` SET TAGS ('dbx_business_glossary_term' = 'Historical Monitoring Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `historical_monitoring_period_start` SET TAGS ('dbx_business_glossary_term' = 'Historical Monitoring Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `historical_non_detect_count` SET TAGS ('dbx_business_glossary_term' = 'Historical Non-Detect Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `primacy_agency_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Approval Reference');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `primacy_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `primacy_agency_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `reduced_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reduced Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `renewal_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `revocation_trigger_conditions` SET TAGS ('dbx_business_glossary_term' = 'Revocation Trigger Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `sampling_schedule_adjustment_notes` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Adjustment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `vulnerability_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `vulnerability_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Assessment Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `vulnerability_assessment_result` SET TAGS ('dbx_value_regex' = 'not_vulnerable|low_vulnerability|moderate_vulnerability|high_vulnerability');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_conditions` SET TAGS ('dbx_business_glossary_term' = 'Waiver Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Waiver Duration (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|suspended|renewed');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_type` SET TAGS ('dbx_business_glossary_term' = 'Waiver Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `waiver_type` SET TAGS ('dbx_value_regex' = 'vulnerability_assessment|source_water|contaminant_specific|composite|reduced_frequency|other');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for quality_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_ssot_owner' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Online Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `online_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `alarm_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm High Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `alarm_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm Low Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency in Days');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `calibration_standard_used` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Used');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `calibration_technician` SET TAGS ('dbx_business_glossary_term' = 'Calibration Technician Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `data_logging_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Data Logging Interval in Seconds');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `installation_location` SET TAGS ('dbx_business_glossary_term' = 'Installation Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_business_glossary_term' = 'Instrument Tag Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `maintenance_notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `measurement_range_max` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `measurement_range_min` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|out_of_service|maintenance|calibration|failed|decommissioned');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `pi_historian_tag` SET TAGS ('dbx_business_glossary_term' = 'Process Information (PI) Historian Tag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_value_regex' = 'ac_120v|ac_240v|dc_24v|battery|solar|loop_powered');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Stage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_instrument_calibration_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `iup_monitoring_result_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Monitoring Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampler Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `special_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `categorical_standard_value` SET TAGS ('dbx_business_glossary_term' = 'Categorical Pretreatment Standard Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exceedance|pending_review|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `composite_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Composite Sample Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Daily Flow (Million Gallons per Day - MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `dmr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `enforcement_action_triggered` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Triggered Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Gallons per Minute - GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `holding_time_compliant` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `local_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Local Pretreatment Limit Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `local_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Local Pretreatment Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_value_regex' = 'self_monitoring|utility_collected|third_party|composite|grab');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Sampler Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampler_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_point_description` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_point_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_point_type` SET TAGS ('dbx_value_regex' = 'influent|effluent|process|discharge|pretreatment_unit|combined');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_time` SET TAGS ('dbx_business_glossary_term' = 'Sampling Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_subdomain' = 'specialized_testing');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `fog_monitoring_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Monitoring Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `grease_interceptor_id` SET TAGS ('dbx_business_glossary_term' = 'Grease Interceptor ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `pretreatment_iup_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Iup Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `fog_source_id` SET TAGS ('dbx_business_glossary_term' = 'Food Service Establishment ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `best_management_practices_compliant` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `bmp_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Deficiencies');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|warning');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `days_since_last_pump_out` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Pump-Out');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `effluent_fog_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Effluent Fats, Oils, and Grease (FOG) Concentration (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `enforcement_action_triggered` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Triggered Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_value_regex' = 'notice_of_violation|citation|fine|permit_suspension|legal_action|warning');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `establishment_type` SET TAGS ('dbx_business_glossary_term' = 'Establishment Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `grease_accumulation_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Grease Accumulation Depth (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `grease_accumulation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grease Accumulation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|complaint|follow_up|initial|reinspection|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `interceptor_condition` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Condition');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `interceptor_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `interceptor_size_gallons` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Size (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `iup_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `last_pump_out_date` SET TAGS ('dbx_business_glossary_term' = 'Last Pump-Out Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `maintenance_issues_noted` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Issues Noted');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `notification_sent_to_establishment` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent to Establishment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `ordinance_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Ordinance Threshold Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `photo_documentation_available` SET TAGS ('dbx_business_glossary_term' = 'Photo Documentation Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `photo_documentation_available` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `pump_out_frequency_compliant` SET TAGS ('dbx_business_glossary_term' = 'Pump-Out Frequency Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `pump_out_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Pump-Out Service Provider Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `reinspection_required` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `reinspection_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Scheduled Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `required_pump_out_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Required Pump-Out Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `sso_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `sso_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` ALTER COLUMN `quality_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` ALTER COLUMN `exceedance_id` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` ALTER COLUMN `quality_instrument_calibration_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Instrument Calibration Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_corrective_action` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_ssot_owner' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_determination');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `superseded_compliance_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Compliance Determination Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `superseded_compliance_determination_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_subdomain' = 'analytical_results');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for qaqc_batch');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Batch Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `reanalysis_qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reanalysis Qaqc Batch Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `reanalysis_qaqc_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_association_edges' = 'quality.contaminant,service.service_territory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `territory_contaminant_monitoring_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Contaminant Monitoring Requirement - Territory Contaminant Monitoring Requirement Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Contaminant Monitoring Requirement - Contaminant Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Contaminant Monitoring Requirement - Service Territory Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Contaminant Compliance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `local_action_level` SET TAGS ('dbx_business_glossary_term' = 'Territory-Specific Action Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `monitoring_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Territory Monitoring Frequency Override');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `primacy_agency_override` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Override Authority');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `territory_specific_mcl` SET TAGS ('dbx_business_glossary_term' = 'Territory-Specific Maximum Contaminant Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `variance_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Variance Approval Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `variance_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Variance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ALTER COLUMN `vulnerability_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Source Water Vulnerability Assessment Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Context Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `parent_monitoring_context_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Monitoring Context Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `parent_monitoring_context_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `context_type` SET TAGS ('dbx_business_glossary_term' = 'Context Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `regulatory_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_subdomain' = 'monitoring_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `sampling_round_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Round Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `parent_sampling_round_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sampling Round Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `parent_sampling_round_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `mcl_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Mcl Exceedance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `parameters_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameters Measured');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `round_code` SET TAGS ('dbx_business_glossary_term' = 'Round Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `round_name` SET TAGS ('dbx_business_glossary_term' = 'Round Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `round_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `sampling_round_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `total_samples_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Samples Collected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `total_samples_expected` SET TAGS ('dbx_business_glossary_term' = 'Total Samples Expected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `contaminant_group_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Group Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `parent_contaminant_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contaminant Group Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `parent_contaminant_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `contaminant_category` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `contaminant_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `max_contaminant_level` SET TAGS ('dbx_business_glossary_term' = 'Max Contaminant Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `max_contaminant_level_goal` SET TAGS ('dbx_business_glossary_term' = 'Max Contaminant Level Goal');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `monitoring_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Days');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `typical_concentration_range_high` SET TAGS ('dbx_business_glossary_term' = 'Typical Concentration Range High');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `typical_concentration_range_low` SET TAGS ('dbx_business_glossary_term' = 'Typical Concentration Range Low');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `typical_sources` SET TAGS ('dbx_business_glossary_term' = 'Typical Sources');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `parent_water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Water System Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `parent_water_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `average_daily_consumption_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Consumption Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `average_daily_production_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Production Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Capacity Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Chlorine Residual Mg L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `construction_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number Of Units');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `ph_range` SET TAGS ('dbx_business_glossary_term' = 'Ph Range');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'System Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `system_type` SET TAGS ('dbx_business_glossary_term' = 'System Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `total_coliforms_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Total Coliforms Cfu 100ml');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Processes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Ntu');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_quality_category` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Category');
