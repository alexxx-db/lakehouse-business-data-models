-- Schema for Domain: quality | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`quality` COMMENT 'Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` (
    `sampling_point_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: NPDES and drinking water operating permits designate specific monitoring locations. Linking quality_sampling_point to compliance_permit enables permit-level monitoring location management and supports',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Regulatory monitoring programs (SWTR, LCR, DBPR) require sampling points to be associated with the treatment facility whose finished water they monitor. Facility-level sampling point inventory is esse',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Hydrants serve as designated sampling points in dead-end flushing programs and DBP monitoring at distribution extremities. Linking sampling points to specific hydrants supports flushing program compli',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Regulatory monitoring programs require sampling coverage per pressure zone (e.g., one sample per zone per monitoring period under SWTR). The existing plain-text pressure_zone attribute is a denormal',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Pump stations are designated sampling locations in distribution monitoring programs (chlorine residual, microbiological). Establishing a direct FK from sampling point to pump station supports station-',
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address referenced by each quality sampling point record in the quality domain.',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Storage tanks have designated outlet sampling points established for ongoing regulatory monitoring programs. A 1:N relationship (one tank, multiple sampling points over time or at multiple outlets) su',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Source water monitoring programs (SWTR, UCMR) designate specific sampling points at water source intakes. Linking quality_sampling_point to water_source enables source water quality trend analysis, in',
    `access_type` STRING COMMENT 'The access type value recorded for each quality sampling point in the quality domain.',
    `ccr_reporting_flag` BOOLEAN COMMENT 'The ccr reporting flag value recorded for each quality sampling point in the quality domain.',
    `sampling_point_code` STRING COMMENT 'The sampling point code value recorded for each quality sampling point in the quality domain.',
    `comments` STRING COMMENT 'The comments value recorded for each quality sampling point in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each quality sampling point record in the quality domain.',
    `decommission_date` DATE COMMENT 'The decommission date associated with each quality sampling point record in the quality domain.',
    `dma_code` STRING COMMENT 'The dma code value recorded for each quality sampling point in the quality domain.',
    `dmr_reporting_flag` BOOLEAN COMMENT 'The dmr reporting flag value recorded for each quality sampling point in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each quality sampling point record in the quality domain.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'The elevation ft value recorded for each quality sampling point in the quality domain.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The flow rate gpm value recorded for each quality sampling point in the quality domain.',
    `gis_feature_code` BOOLEAN COMMENT 'The gis feature code value recorded for each quality sampling point in the quality domain.',
    `installation_date` DATE COMMENT 'The installation date associated with each quality sampling point record in the quality domain.',
    `last_sample_date` DATE COMMENT 'The last sample date associated with each quality sampling point record in the quality domain.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the quality sampling point location.',
    `location_type` STRING COMMENT 'The location type value recorded for each quality sampling point in the quality domain.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the quality sampling point location.',
    `modified_by` STRING COMMENT 'The modified by value recorded for each quality sampling point in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each quality sampling point record in the quality domain.',
    `sampling_point_name` STRING COMMENT 'The sampling point name used to identify each quality sampling point record in the quality domain.',
    `next_scheduled_sample_date` DATE COMMENT 'The next scheduled sample date associated with each quality sampling point record in the quality domain.',
    `primary_contaminant_group` STRING COMMENT 'The primary contaminant group value recorded for each quality sampling point in the quality domain.',
    `quality_sampling_point_code` STRING COMMENT 'The quality sampling point code value recorded for each quality sampling point in the quality domain.',
    `quality_sampling_point_description` STRING COMMENT 'The quality sampling point description value recorded for each quality sampling point in the quality domain.',
    `quality_sampling_point_name` STRING COMMENT 'The quality sampling point name used to identify each quality sampling point record in the quality domain.',
    `quality_sampling_point_status` STRING COMMENT 'The quality sampling point status value recorded for each quality sampling point in the quality domain.',
    `regulatory_zone` STRING COMMENT 'The regulatory zone value recorded for each quality sampling point in the quality domain.',
    `residence_time_hours` DECIMAL(18,2) COMMENT 'The residence time hours value recorded for each quality sampling point in the quality domain.',
    `responsible_department` STRING COMMENT 'The responsible department value recorded for each quality sampling point in the quality domain.',
    `safety_notes` STRING COMMENT 'The safety notes value recorded for each quality sampling point in the quality domain.',
    `sample_collection_method` STRING COMMENT 'The sample collection method value recorded for each quality sampling point in the quality domain.',
    `sampler_name` STRING COMMENT 'The sampler name used to identify each quality sampling point record in the quality domain.',
    `sampling_frequency` STRING COMMENT 'The sampling frequency value recorded for each quality sampling point in the quality domain.',
    `sampling_instructions` STRING COMMENT 'The sampling instructions value recorded for each quality sampling point in the quality domain.',
    `sampling_point_status` STRING COMMENT 'The sampling point status value recorded for each quality sampling point in the quality domain.',
    `scada_tag` STRING COMMENT 'The scada tag value recorded for each quality sampling point in the quality domain.',
    `treatment_stage` STRING COMMENT 'The treatment stage value recorded for each quality sampling point in the quality domain.',
    `created_by` STRING COMMENT 'The created by value recorded for each quality sampling point in the quality domain.',
    CONSTRAINT pk_sampling_point PRIMARY KEY(`sampling_point_id`)
) COMMENT 'Master registry of all approved water quality sampling locations across the utilitys infrastructure including distribution system sites, source water intakes, WTP/WWTP process points, and wastewater effluent discharge outfalls. Captures location type (entry point, distribution, source, effluent, customer tap), GIS coordinates, regulatory monitoring zone classification, DMA assignment, pressure zone, LCRR tier classification for tap sites, associated permit or CCR reporting requirements, and activation/deactivation status. Serves as the authoritative SSOT for where samples are collected and links to sampling_schedule for monitoring requirements. [SSOT: reference view of canonical asset.asset_sampling_point] SSOT master for sampling points.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` (
    `sampling_schedule_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Sampling schedules are established to satisfy permit monitoring requirements. The compliance_permit is the operative document mandating the schedule. This link enables permit managers to view all moni',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: A sampling schedule is defined for a specific contaminant or contaminant group (e.g., a PFAS monitoring schedule, a THM/HAA5 DBP schedule, a Lead and Copper Rule schedule). Linking sampling_schedule.c',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMA-level water quality monitoring schedules are a core operational requirement — utilities plan sampling frequency and locations by DMA for NRW programs and regulatory compliance. Linking sampling sc',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Regulatory monitoring schedules are facility-specific — each treatment plant has its own monitoring program obligations under SDWA. Linking sampling_schedule to facility enables facility-level complia',
    `location_id` BIGINT COMMENT 'Unique identifier for the monitoring location referenced by each sampling schedule record in the quality domain.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each sampling schedule record in the quality domain.',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each sampling schedule record in the quality domain.',
    `annual_budget_allocation` DECIMAL(18,2) COMMENT 'The annual budget allocation value recorded for each sampling schedule in the quality domain.',
    `approved_by` STRING COMMENT 'The approved by value recorded for each sampling schedule in the quality domain.',
    `approved_date` DATE COMMENT 'The approved date associated with each sampling schedule record in the quality domain.',
    `sampling_schedule_code` STRING COMMENT 'The sampling schedule code value recorded for each sampling schedule in the quality domain.',
    `compliance_deadline_date` DATE COMMENT 'The compliance deadline date associated with each sampling schedule record in the quality domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each sampling schedule in the quality domain.',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'The cost per sample value recorded for each sampling schedule in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each sampling schedule record in the quality domain.',
    `sampling_schedule_description` STRING COMMENT 'The sampling schedule description value recorded for each sampling schedule in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each sampling schedule record in the quality domain.',
    `holding_time_hours` STRING COMMENT 'The holding time hours value recorded for each sampling schedule in the quality domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each sampling schedule record in the quality domain.',
    `last_sample_collected_date` DATE COMMENT 'The last sample collected date associated with each sampling schedule record in the quality domain.',
    `modified_by` STRING COMMENT 'The modified by value recorded for each sampling schedule in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each sampling schedule record in the quality domain.',
    `monitoring_period_end_date` DATE COMMENT 'The monitoring period end date associated with each sampling schedule record in the quality domain.',
    `monitoring_period_start_date` DATE COMMENT 'The monitoring period start date associated with each sampling schedule record in the quality domain.',
    `sampling_schedule_name` STRING COMMENT 'The sampling schedule name used to identify each sampling schedule record in the quality domain.',
    `next_scheduled_sample_date` DATE COMMENT 'The next scheduled sample date associated with each sampling schedule record in the quality domain.',
    `notes` STRING COMMENT 'The notes value recorded for each sampling schedule in the quality domain.',
    `notification_lead_time_days` STRING COMMENT 'The notification lead time days value recorded for each sampling schedule in the quality domain.',
    `preservation_method` STRING COMMENT 'The preservation method value recorded for each sampling schedule in the quality domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each sampling schedule in the quality domain.',
    `regulatory_rule` STRING COMMENT 'The regulatory rule value recorded for each sampling schedule in the quality domain.',
    `reporting_requirement` STRING COMMENT 'The reporting requirement value recorded for each sampling schedule in the quality domain.',
    `sample_type` STRING COMMENT 'The sample type value recorded for each sampling schedule in the quality domain.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'The sample volume ml value recorded for each sampling schedule in the quality domain.',
    `samples_collected_ytd` STRING COMMENT 'The samples collected ytd value recorded for each sampling schedule in the quality domain.',
    `samples_per_period` STRING COMMENT 'The samples per period value recorded for each sampling schedule in the quality domain.',
    `samples_required_ytd` STRING COMMENT 'The samples required ytd value recorded for each sampling schedule in the quality domain.',
    `sampling_frequency` STRING COMMENT 'The sampling frequency value recorded for each sampling schedule in the quality domain.',
    `sampling_method` STRING COMMENT 'The sampling method value recorded for each sampling schedule in the quality domain.',
    `sampling_schedule_status` STRING COMMENT 'The sampling schedule status value recorded for each sampling schedule in the quality domain.',
    `schedule_name` STRING COMMENT 'The schedule name used to identify each sampling schedule record in the quality domain.',
    `schedule_status` STRING COMMENT 'The schedule status value recorded for each sampling schedule in the quality domain.',
    `schedule_type` STRING COMMENT 'The schedule type value recorded for each sampling schedule in the quality domain.',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'The seasonal adjustment flag value recorded for each sampling schedule in the quality domain.',
    `violation_flag` BOOLEAN COMMENT 'The violation flag value recorded for each sampling schedule in the quality domain.',
    CONSTRAINT pk_sampling_schedule PRIMARY KEY(`sampling_schedule_id`)
) COMMENT 'Defines the regulatory and operational sampling schedules for each monitoring location and contaminant group. Captures required sampling frequency (daily, weekly, monthly, quarterly, annual), applicable rule (LCRR, DBP Stage 2, PFAS, NPDES), monitoring period start/end dates, responsible lab or field crew, and schedule status. Drives compliance calendar and ensures no monitoring gaps that could trigger violations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` (
    `water_sample_id` BIGINT COMMENT 'Primary key. Ref: LabWare LIMS.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Water samples collected for NPDES or drinking water permit compliance must be traceable to the specific compliance_permit mandating the monitoring. This traceability is required for DMR compilation an',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Water samples must be traceable to the treatment facility that produced the water being sampled. This supports facility-level compliance reporting, CCR preparation, and SWTR process monitoring. A wate',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Hydrant flushing programs generate water quality samples (turbidity, chlorine residual) tied to the specific hydrant flushed. Post-flush sampling is a standard distribution operations process; linking',
    `parent_sample_water_sample_id` BIGINT COMMENT 'Unique identifier for the parent sample water sample referenced by each water sample record in the quality domain.',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Pump station discharge points are designated regulatory sampling locations for chlorine residual and microbiological monitoring under SWTR and distribution system monitoring rules. Linking water sampl',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each water sample record in the quality domain.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Every water sample is collected pursuant to a regulatory or operational sampling schedule. The sampling_schedule defines the frequency, method, preservation, and regulatory program for collection. Add',
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address referenced by each water sample record in the quality domain.',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Storage tanks are critical regulatory sampling locations for DBP monitoring, chlorine residual, and microbiological compliance under SWTR and Stage 2 DBPR. Linking water samples directly to the storag',
    `analysis_due_timestamp` TIMESTAMP COMMENT 'The analysis due timestamp associated with each water sample record in the quality domain.',
    `water_sample_code` STRING COMMENT 'The water sample code value recorded for each water sample in the quality domain.',
    `collection_notes` STRING COMMENT 'The collection notes value recorded for each water sample in the quality domain.',
    `collection_timestamp` TIMESTAMP COMMENT 'The collection timestamp associated with each water sample record in the quality domain.',
    `composite_duration_hours` STRING COMMENT 'The composite duration hours value recorded for each water sample in the quality domain.',
    `composite_interval_minutes` STRING COMMENT 'The composite interval minutes value recorded for each water sample in the quality domain.',
    `container_type` STRING COMMENT 'The container type value recorded for each water sample in the quality domain.',
    `container_volume_ml` STRING COMMENT 'The container volume ml value recorded for each water sample in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each water sample record in the quality domain.',
    `water_sample_description` STRING COMMENT 'The water sample description value recorded for each water sample in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each water sample record in the quality domain.',
    `field_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'The field chlorine residual mg l value recorded for each water sample in the quality domain.',
    `field_conductivity_us_cm` DECIMAL(18,2) COMMENT 'The field conductivity us cm value recorded for each water sample in the quality domain.',
    `field_dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'The field dissolved oxygen mg l value recorded for each water sample in the quality domain.',
    `field_ph` DECIMAL(18,2) COMMENT 'The field ph value recorded for each water sample in the quality domain.',
    `field_temperature_c` DECIMAL(18,2) COMMENT 'The field temperature c value recorded for each water sample in the quality domain.',
    `field_turbidity_ntu` DECIMAL(18,2) COMMENT 'The field turbidity ntu value recorded for each water sample in the quality domain.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The flow rate gpm value recorded for each water sample in the quality domain.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the water sample location.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the water sample location.',
    `hold_time_hours` STRING COMMENT 'The hold time hours value recorded for each water sample in the quality domain.',
    `lims_submission_code` STRING COMMENT 'The lims submission code value recorded for each water sample in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each water sample record in the quality domain.',
    `water_sample_name` STRING COMMENT 'The water sample name used to identify each water sample record in the quality domain.',
    `preservation_method` STRING COMMENT 'The preservation method value recorded for each water sample in the quality domain.',
    `quality_control_flag` BOOLEAN COMMENT 'The quality control flag value recorded for each water sample in the quality domain.',
    `regulatory_program` STRING COMMENT 'The regulatory program value recorded for each water sample in the quality domain.',
    `requested_analysis_group` BOOLEAN COMMENT 'The requested analysis group value recorded for each water sample in the quality domain.',
    `sample_location_description` STRING COMMENT 'The sample location description value recorded for each water sample in the quality domain.',
    `sample_matrix` STRING COMMENT 'The sample matrix value recorded for each water sample in the quality domain.',
    `sample_number` STRING COMMENT 'The sample number value recorded for each water sample in the quality domain.',
    `sample_purpose` STRING COMMENT 'The sample purpose value recorded for each water sample in the quality domain.',
    `sample_status` STRING COMMENT 'The sample status value recorded for each water sample in the quality domain.',
    `sample_type` STRING COMMENT 'The sample type value recorded for each water sample in the quality domain.',
    `sampler_equipment_code` BIGINT COMMENT 'The sampler equipment code value recorded for each water sample in the quality domain.',
    `water_sample_status` STRING COMMENT 'The water sample status value recorded for each water sample in the quality domain.',
    `weather_conditions` STRING COMMENT 'The weather conditions value recorded for each water sample in the quality domain.',
    CONSTRAINT pk_water_sample PRIMARY KEY(`water_sample_id`)
) COMMENT 'Transactional record of each individual water or wastewater sample collected in the field or at a process point. Captures sample collection date/time, collector identity, sampling point, sample type (grab, composite, field blank, duplicate), preservation method, container type, chain-of-custody number, field measurements (temperature, pH, residual chlorine, turbidity in NTU), and LIMS submission reference. This is the primary event record for all quality monitoring activity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` (
    `analytical_result_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Analytical results reported in Discharge Monitoring Reports must be traceable to the compliance_permit under which monitoring was required. Permit-specific effluent limits govern result evaluation; th',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each analytical result record in the quality domain.',
    `contaminant_limit_id` BIGINT COMMENT 'Unique identifier for the contaminant limit referenced by each analytical result record in the quality domain.',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each analytical result record in the quality domain.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each analytical result record in the quality domain.',
    `analysis_date` DATE COMMENT 'The analysis date associated with each analytical result record in the quality domain.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The analysis timestamp associated with each analytical result record in the quality domain.',
    `analytical_method` STRING COMMENT 'The analytical method value recorded for each analytical result in the quality domain.',
    `analytical_result_status` STRING COMMENT 'The analytical result status value recorded for each analytical result in the quality domain.',
    `calibration_date` DATE COMMENT 'The calibration date associated with each analytical result record in the quality domain.',
    `analytical_result_code` STRING COMMENT 'The analytical result code value recorded for each analytical result in the quality domain.',
    `compliance_exceeded` BOOLEAN COMMENT 'The compliance exceeded value recorded for each analytical result in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each analytical result record in the quality domain.',
    `data_validation_level` STRING COMMENT 'The data validation level value recorded for each analytical result in the quality domain.',
    `analytical_result_description` STRING COMMENT 'The analytical result description value recorded for each analytical result in the quality domain.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The detection limit value recorded for each analytical result in the quality domain.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'The dilution factor value recorded for each analytical result in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each analytical result record in the quality domain.',
    `hold_time_compliant` BOOLEAN COMMENT 'The hold time compliant value recorded for each analytical result in the quality domain.',
    `hold_time_hours` STRING COMMENT 'The hold time hours value recorded for each analytical result in the quality domain.',
    `laboratory_accreditation_number` STRING COMMENT 'The laboratory accreditation number value recorded for each analytical result in the quality domain.',
    `lims_result_code` STRING COMMENT 'The lims result code value recorded for each analytical result in the quality domain.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The mcl value value recorded for each analytical result in the quality domain.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The mclg value value recorded for each analytical result in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each analytical result record in the quality domain.',
    `analytical_result_name` STRING COMMENT 'The analytical result name used to identify each analytical result record in the quality domain.',
    `percent_recovery` DECIMAL(18,2) COMMENT 'The percent recovery value recorded for each analytical result in the quality domain.',
    `qualifier_code` STRING COMMENT 'The qualifier code value recorded for each analytical result in the quality domain.',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'The quantitation limit value recorded for each analytical result in the quality domain.',
    `relative_percent_difference` DECIMAL(18,2) COMMENT 'The relative percent difference value recorded for each analytical result in the quality domain.',
    `reporting_required` BOOLEAN COMMENT 'The reporting required value recorded for each analytical result in the quality domain.',
    `result_comment` STRING COMMENT 'The result comment value recorded for each analytical result in the quality domain.',
    `result_status` STRING COMMENT 'The result status value recorded for each analytical result in the quality domain.',
    `result_value` DECIMAL(18,2) COMMENT 'The result value value recorded for each analytical result in the quality domain.',
    `sample_matrix` STRING COMMENT 'The sample matrix value recorded for each analytical result in the quality domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each analytical result in the quality domain.',
    `validated_by` STRING COMMENT 'The validated by associated with each analytical result record in the quality domain.',
    `validation_timestamp` TIMESTAMP COMMENT 'The validation timestamp associated with each analytical result record in the quality domain.',
    CONSTRAINT pk_analytical_result PRIMARY KEY(`analytical_result_id`)
) COMMENT 'Laboratory and field analytical result for each parameter tested on a collected water sample or measured by a continuous online instrument. Captures analyte/contaminant reference, CAS number, analytical method (EPA method number), result value, unit of measure, detection limit (MDL/MRL), qualifier flags (non-detect, estimated, hold-time exceeded, presence/absence), result type (grab, composite, continuous, calculated), measurement source (laboratory, field, SCADA/online), laboratory accreditation number, analyst ID, analysis date/time, QA/QC batch reference, instrument ID for online readings, and monitoring period context. Supports all parameter types including conventional chemistry, DBP species, PFAS compounds, bacteriological presence/absence, turbidity NTU, chlorine residuals, and CT calculations. Links to water_sample for discrete samples and online_instrument for continuous readings. Sourced from LIMS (LabWare) and OSIsoft PI Historian. Note: Individual PFAS compound results are stored here for lab-level detail; pfas_monitoring provides the regulatory compliance context, hazard index calculations, and treatment trigger evaluations that aggregate across compounds.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` (
    `contaminant_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each contaminant record in the quality domain.',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each contaminant record in the quality domain.',
    `action_level_unit` STRING COMMENT 'The action level unit value recorded for each contaminant in the quality domain.',
    `action_level_value` DECIMAL(18,2) COMMENT 'The action level value value recorded for each contaminant in the quality domain.',
    `analytical_method_code` STRING COMMENT 'The analytical method code value recorded for each contaminant in the quality domain.',
    `analytical_method_reference` STRING COMMENT 'EPA 524.2, EPA 533, ISO method',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service (CAS) registry number. PFAS compounds enumerated: PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA (GenX), PFHxA, PFHpA, PFDA, PFUnDA with CAS numbers per ECHA REACH database. Ref: Sensus AMI.',
    `contaminant_category` STRING COMMENT 'IOC, VOC, SOC, radionuclide, microbiological, DBP, PFAS. Ref: Sensus AMI.',
    `ccr_language_template` STRING COMMENT 'The ccr language template value recorded for each contaminant in the quality domain.',
    `ccr_reporting_required` BOOLEAN COMMENT 'The ccr reporting required value recorded for each contaminant in the quality domain.',
    `contaminant_code` STRING COMMENT 'EPA contaminant code. Ref: Sensus AMI.',
    `contaminant_status` STRING COMMENT 'Regulated, proposed, unregulated. Ref: Sensus AMI.',
    `contaminant_type` STRING COMMENT 'The contaminant type value recorded for each contaminant in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `contaminant_description` STRING COMMENT 'The contaminant description value recorded for each contaminant in the quality domain.',
    `detection_limit_unit` STRING COMMENT 'The detection limit unit value recorded for each contaminant in the quality domain.',
    `detection_limit_value` DECIMAL(18,2) COMMENT 'The detection limit value value recorded for each contaminant in the quality domain.',
    `effective_date` DATE COMMENT 'Regulation effective date. Ref: Sensus AMI.',
    `eu_dwd_parametric_value` DECIMAL(18,2) COMMENT 'EU DWD 2020/2184 parametric value. Ref: Sensus AMI.',
    `eu_dwd_regulated_flag` BOOLEAN COMMENT 'Indicates whether this contaminant is regulated under EU Drinking Water Directive 2020/2184. Ref: Sensus AMI.',
    `eu_dwd_sum20_included` BOOLEAN COMMENT 'Included in EU Drinking Water Directive 2020/2184 sum-of-20 PFAS (100 ng/L limit). Ref: Sensus AMI.',
    `eu_dwd_total_pfas_included` BOOLEAN COMMENT 'Included in EU DWD total PFAS measurement (500 ng/L limit). Ref: Sensus AMI.',
    `eu_dwd_unit` STRING COMMENT 'EU parametric value unit. Ref: Sensus AMI.',
    `eu_parametric_limit_ng_l` DECIMAL(18,2) COMMENT 'EU parametric value for this PFAS compound under DWD 2020/2184 Annex I Part B, in ng/L. Ref: Sensus AMI.',
    `eu_parametric_value_ng_l` DECIMAL(18,2) COMMENT 'EU DWD parametric value: 100 ng/L sum-of-20, 500 ng/L total PFAS. Ref: Sensus AMI.',
    `eu_pfas_total_class_member` BOOLEAN COMMENT 'Whether this compound is included in the EU total PFAS class restriction (500 ng/L limit per DWD 2020/2184). Ref: Sensus AMI.',
    `eu_pfas_total_member` BOOLEAN COMMENT 'Indicates if compound counts toward EU total PFAS parametric value (500 ng/L). Ref: Sensus AMI.',
    `eu_priority_compound_flag` BOOLEAN COMMENT 'EU sum-of-20 priority compound. Ref: Sensus AMI.',
    `eu_sum20_member` BOOLEAN COMMENT 'Part of EU sum-of-20 PFAS. Ref: Sensus AMI.',
    `eu_sum_of_20_flag` BOOLEAN COMMENT 'Flag indicating if compound is part of EU sum-of-20 PFAS. Ref: Sensus AMI.',
    `eu_sum_of_20_member` BOOLEAN COMMENT 'Boolean flag indicating whether this PFAS compound is included in the EU Drinking Water Directive 2020/2184 sum-of-20 PFAS parametric value (100 ng/L total). Includes PFOA, PFOS, PFNA, PFHxS, PFBS, PFHxA, PFHpA, PFDA, PFUnDA, and 11 others. Ref: Sensus AMI.',
    `eu_sum_of_20_member_flag` BOOLEAN COMMENT 'The eu sum of 20 member flag value recorded for each contaminant in the quality domain.',
    `gac_removal_efficiency_pct` DECIMAL(18,2) COMMENT 'Typical granular activated carbon removal efficiency percentage. Ref: Sensus AMI.',
    `hazard_index_compound_flag` BOOLEAN COMMENT 'Included in US hazard index calculation. Ref: Sensus AMI.',
    `hazard_index_mcl_ng_l` DECIMAL(18,2) COMMENT 'Individual compound MCL used as denominator in hazard index calculation (ng/L). HI = sum(concentration_i / MCL_i). Ref: Sensus AMI.',
    `hazard_index_member` BOOLEAN COMMENT 'Part of US hazard index (PFNA+PFHxS+PFBS+HFPO-DA). Ref: Sensus AMI.',
    `hazard_index_member_flag` BOOLEAN COMMENT 'The hazard index member flag value recorded for each contaminant in the quality domain.',
    `health_effect_category` STRING COMMENT 'The health effect category value recorded for each contaminant in the quality domain.',
    `health_effect_description` STRING COMMENT 'The health effect description value recorded for each contaminant in the quality domain.',
    `health_effects` STRING COMMENT 'Health effects summary. Ref: Sensus AMI.',
    `ion_exchange_removal_efficiency_pct` DECIMAL(18,2) COMMENT 'Typical anion exchange removal efficiency percentage. Ref: Sensus AMI.',
    `is_pfas_compound` BOOLEAN COMMENT 'PFAS compound flag. Ref: Sensus AMI.',
    `mcl_unit` STRING COMMENT 'The mcl unit value recorded for each contaminant in the quality domain.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The mcl value value recorded for each contaminant in the quality domain.',
    `mclg_unit` STRING COMMENT 'The mclg unit value recorded for each contaminant in the quality domain.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The mclg value value recorded for each contaminant in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each contaminant record in the quality domain.',
    `molecular_formula` STRING COMMENT 'Molecular formula of the PFAS compound. Ref: Sensus AMI.',
    `monitoring_frequency` STRING COMMENT 'Required monitoring frequency. Ref: Sensus AMI.',
    `monitoring_frequency_code` STRING COMMENT 'The monitoring frequency code value recorded for each contaminant in the quality domain.',
    `monitoring_location_type` STRING COMMENT 'The monitoring location type value recorded for each contaminant in the quality domain.',
    `contaminant_name` STRING COMMENT 'Contaminant name. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'The notes value recorded for each contaminant in the quality domain.',
    `npdes_effluent_limit_unit` STRING COMMENT 'The npdes effluent limit unit value recorded for each contaminant in the quality domain.',
    `npdes_effluent_limit_value` DECIMAL(18,2) COMMENT 'The npdes effluent limit value value recorded for each contaminant in the quality domain.',
    `perfluorinated_carbon_count` STRING COMMENT 'Number of perfluorinated carbon atoms in the compound chain, used for long/short chain classification. Ref: Sensus AMI.',
    `pfas_bioaccumulation_potential` STRING COMMENT 'Bioaccumulation potential: HIGH, MODERATE, LOW based on BCF/BAF. Ref: Sensus AMI.',
    `pfas_carbon_chain_length` STRING COMMENT 'Carbon chain length for PFAS. Ref: Sensus AMI.',
    `pfas_carbon_count` STRING COMMENT 'Number of carbon atoms in the PFAS molecule backbone. Ref: Sensus AMI.',
    `pfas_cas_number` STRING COMMENT 'The pfas cas number value recorded for each contaminant in the quality domain.',
    `pfas_chain_classification` STRING COMMENT 'long-chain vs short-chain PFAS. Ref: Sensus AMI.',
    `pfas_chain_length` STRING COMMENT 'PFAS chain length classification: long-chain (C8+ perfluorocarboxylic acids, C6+ perfluorosulfonic acids) or short-chain (C7 or fewer perfluorocarboxylic acids, C5 or fewer perfluorosulfonic acids). Long-chain: PFOA, PFOS, PFNA, PFHxS, PFHpA, PFDA, PFUnDA. Short-chain: PFBS, HFPO-DA (GenX), PFHxA. Ref: Sensus AMI.',
    `pfas_chain_length_class` STRING COMMENT 'Long-chain or short-chain PFAS classification. Ref: Sensus AMI.',
    `pfas_chain_type` STRING COMMENT 'Long-chain, short-chain, precursor. Ref: Sensus AMI.',
    `pfas_compound_abbreviation` STRING COMMENT 'Standard abbreviation for the PFAS compound (e.g. PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA/GenX). Ref: Sensus AMI.',
    `pfas_compound_class` STRING COMMENT 'PFAS compound class: PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA, etc. Ref: Sensus AMI.',
    `pfas_compound_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this contaminant is a PFAS compound. Enumerated PFAS compounds include: PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA (GenX), PFHxA, PFHpA, PFDA, PFUnDA. Ref: Sensus AMI.',
    `pfas_compound_name` STRING COMMENT 'The pfas compound name used to identify each contaminant record in the quality domain.',
    `pfas_full_name` STRING COMMENT 'The pfas full name used to identify each contaminant record in the quality domain.',
    `pfas_functional_class` STRING COMMENT 'Functional chemical class of the PFAS compound (e.g. perfluorocarboxylic_acid, perfluorosulfonic_acid, fluorotelomer, ether_pfas). Ref: Sensus AMI.',
    `pfas_functional_group` STRING COMMENT 'Carboxylic acid, sulfonic acid, etc. Ref: Sensus AMI.',
    `pfas_hfpo_da_genx_chain` STRING COMMENT 'PFAS compound HFPO-DA/GenX classified as short-chain. Ref: Sensus AMI.',
    `pfas_persistence_class` STRING COMMENT 'Environmental persistence: VERY_PERSISTENT, PERSISTENT per REACH PBT criteria. Ref: Sensus AMI.',
    `pfas_pfbs_chain` STRING COMMENT 'PFAS compound PFBS classified as short-chain. Ref: Sensus AMI.',
    `pfas_pfhxs_chain` STRING COMMENT 'PFAS compound PFHxS classified as long-chain. Ref: Sensus AMI.',
    `pfas_pfna_chain` STRING COMMENT 'PFAS compound PFNA classified as long-chain. Ref: Sensus AMI.',
    `pfas_pfoa_chain` STRING COMMENT 'PFAS compound PFOA classified as long-chain. Ref: Sensus AMI.',
    `pfas_pfos_chain` STRING COMMENT 'PFAS compound PFOS classified as long-chain. Ref: Sensus AMI.',
    `pfas_sum_of_20_member_flag` BOOLEAN COMMENT 'Indicates whether this PFAS compound is one of the 20 substances included in the EU DWD 2020/2184 sum-of-20 parametric value (0.10 ug/L). Ref: Sensus AMI.',
    `primary_treatment_technology` STRING COMMENT 'Most effective treatment: GAC, ION_EXCHANGE, NANOFILTRATION, REVERSE_OSMOSIS, HIGH_PRESSURE_MEMBRANE. Ref: Sensus AMI.',
    `public_notification_tier` STRING COMMENT 'The public notification tier value recorded for each contaminant in the quality domain.',
    `reach_restricted_flag` BOOLEAN COMMENT 'REACH PFAS restriction applicable. Ref: Sensus AMI.',
    `reach_restriction_applicable` BOOLEAN COMMENT 'Subject to EU REACH PFAS restriction proposal. Ref: Sensus AMI.',
    `reach_restriction_flag` BOOLEAN COMMENT 'Subject to EU REACH PFAS restriction. Ref: Sensus AMI.',
    `reach_restriction_status` STRING COMMENT 'EU REACH PFAS restriction status: RESTRICTED, PROPOSED, NOT_RESTRICTED. Ref: Sensus AMI.',
    `regulatory_program` STRING COMMENT 'The regulatory program value recorded for each contaminant in the quality domain.',
    `reporting_threshold_unit` STRING COMMENT 'The reporting threshold unit value recorded for each contaminant in the quality domain.',
    `reporting_threshold_value` DECIMAL(18,2) COMMENT 'The reporting threshold value value recorded for each contaminant in the quality domain.',
    `revision_date` TIMESTAMP COMMENT 'The revision date associated with each contaminant record in the quality domain.',
    `source_category` STRING COMMENT 'The source category value recorded for each contaminant in the quality domain.',
    `source_description` STRING COMMENT 'Common sources. Ref: Sensus AMI.',
    `subgroup` STRING COMMENT 'The subgroup value recorded for each contaminant in the quality domain.',
    `treatment_technique_description` STRING COMMENT 'The treatment technique description value recorded for each contaminant in the quality domain.',
    `treatment_technique_required` BOOLEAN COMMENT 'The treatment technique required value recorded for each contaminant in the quality domain.',
    `treatment_technology` STRING COMMENT 'BAT: GAC, ion exchange, RO, etc. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: Sensus AMI.',
    `us_epa_hazard_index_member` BOOLEAN COMMENT 'Indicates if compound is part of US EPA Hazard Index group (PFNA, PFHxS, PFBS, HFPO-DA). Ref: Sensus AMI.',
    `us_epa_hbwc_ng_l` DECIMAL(18,2) COMMENT 'US EPA Health-Based Water Concentration for Hazard Index calculation. Ref: Sensus AMI.',
    `us_epa_mcl` DECIMAL(18,2) COMMENT 'US EPA Maximum Contaminant Level. Ref: Sensus AMI.',
    `us_epa_mcl_ng_l` DECIMAL(18,2) COMMENT 'US EPA Maximum Contaminant Level (MCL) for individual PFAS compounds in ng/L. Per EPA PFAS Rule 2024: PFOA = 4 ng/L, PFOS = 4 ng/L. Hazard index compounds (PFNA, PFHxS, PFBS, HFPO-DA) are regulated via hazard index MCL = 1.0. Ref: Sensus AMI.',
    `us_epa_mcl_unit` STRING COMMENT 'MCL unit (mg/L, ug/L, pCi/L, ppt). Ref: Sensus AMI.',
    `us_epa_mclg` DECIMAL(18,2) COMMENT 'US EPA MCL Goal. Ref: Sensus AMI.',
    `us_hazard_index_hbwc_ng_l` DECIMAL(18,2) COMMENT 'Health-Based Water Concentration for hazard index calculation per EPA 2024 NPDWR',
    `us_hazard_index_member` BOOLEAN COMMENT 'Boolean flag indicating whether this PFAS compound is included in the US EPA PFAS hazard index calculation (PFNA, PFHxS, PFBS, HFPO-DA/GenX). Hazard index MCL = 1.0 (unitless) per EPA PFAS Rule 2024. Ref: Sensus AMI.',
    `us_health_advisory_level` DECIMAL(18,2) COMMENT 'EPA health advisory level',
    `us_individual_mcl_ng_l` DECIMAL(18,2) COMMENT 'US EPA individual maximum contaminant level for this PFAS compound in nanograms per liter under the 2024 PFAS NPDWR.',
    `us_mcl_ng_l` DECIMAL(18,2) COMMENT 'US EPA MCL in ng/L for individual PFAS compound. Ref: Sensus AMI.',
    `us_per_compound_mcl_ng_l` DECIMAL(18,2) COMMENT 'US per-compound MCL in ng/L (PFOA 4.0, PFOS 4.0, PFNA/PFHxS/HFPO-DA 10.0; PFBS via hazard index). Ref: Sensus AMI.',
    `us_regulated_flag` BOOLEAN COMMENT 'US EPA regulated compound. Ref: Sensus AMI.',
    `violation_trigger_logic` STRING COMMENT 'The violation trigger logic value recorded for each contaminant in the quality domain.',
    `wastewater_parameter` BOOLEAN COMMENT 'The wastewater parameter value recorded for each contaminant in the quality domain.',
    `who_guideline_value` DECIMAL(18,2) COMMENT 'WHO drinking water guideline. Ref: Sensus AMI.',
    CONSTRAINT pk_contaminant PRIMARY KEY(`contaminant_id`)
) COMMENT 'Contaminant master including PFAS compounds per EPA NPDWR, UCMR5, and EU DWD 2020/2184. Enumerates regulated contaminants with MCLs, MCLGs, and international equivalents. Includes PFAS compound master with per-compound MCLs (US EPA PFAS Rule 2024: PFOA 4 ng/L, PFOS 4 ng/L), hazard index members (PFNA, PFHxS, PFBS, HFPO-DA/GenX), EU Drinking Water Directive 2020/2184 sum-of-20 PFAS (100 ng/L total), and long-chain vs short-chain classification per REACH restriction framework.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` (
    `contaminant_limit_id` BIGINT COMMENT 'Unique identifier for the contaminant limit record. Primary key for the contaminant_limit product. Ref: Sensus AMI.',
    `contaminant_id` BIGINT COMMENT 'Reference to the specific contaminant (e.g., lead, arsenic, THM, HAA5, PFAS) for which this limit applies. Ref: Sensus AMI.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contaminant limits (MCLs, action levels, effluent limits) are established by specific regulatory requirements. This FK replaces the denormalized applicable_regulation text column with a proper referen',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each contaminant limit record in the quality domain.',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Regulatory contaminant limits (MCLs, discharge limits) are specified in treatment/discharge permits. Links specific numeric limit to authorizing permit for compliance tracking, permit renewal, and var. Ref: Sensus AMI.',
    `analytical_method_required` STRING COMMENT 'EPA-approved analytical method(s) required for measuring this contaminant. Examples: EPA Method 200.8 (metals by ICP-MS), EPA Method 524.2 (VOCs), EPA Method 537.1 (PFAS), Standard Method 2320 (alkalinity), EPA Method 1664A (oil and grease). Ref: Sensus AMI.',
    `averaging_period` STRING COMMENT 'Time period over which the limit is calculated or averaged. Instantaneous = single sample, daily_max = maximum value in a day, monthly_avg = average over calendar month, quarterly_avg = average over quarter, annual_avg = average over calendar year, running_annual_avg = rolling 12-month average, locational_running_annual_avg = running annual average at specific sampling location (e.g., for DBPs under Stage 2 DBPR). [ENUM-REF-CANDIDATE: instantaneous|daily_max|monthly_avg|quarterly_avg|annual_avg|running_annual_avg|locational_running_annual_avg — 7 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether this contaminant must be included in the annual Consumer Confidence Report (CCR) distributed to drinking water customers. True = must report in CCR, False = not required in CCR. Ref: Sensus AMI.',
    `contaminant_limit_code` STRING COMMENT 'The contaminant limit code value recorded for each contaminant limit in the quality domain.',
    `compliance_status` STRING COMMENT 'Current status of this limit record. Active = currently enforceable, superseded = replaced by newer limit, pending = future effective date not yet reached, suspended = temporarily not enforced due to variance or waiver. Ref: Sensus AMI.. Valid values are `active|superseded|pending|suspended`',
    `contaminant_limit_status` STRING COMMENT 'The contaminant limit status value recorded for each contaminant limit in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant limit record was first created in the system. Used for audit trail and data lineage tracking. Ref: Sensus AMI.',
    `contaminant_limit_description` STRING COMMENT 'The contaminant limit description value recorded for each contaminant limit in the quality domain.',
    `detection_limit_required` DECIMAL(18,2) COMMENT 'Minimum detection limit (MDL) or practical quantitation limit (PQL) required for the analytical method. Laboratory results must meet or exceed this sensitivity. Expressed in same unit_of_measure as limit_value. Ref: Sensus AMI.',
    `effective_date` DATE COMMENT 'Date when this contaminant limit became or will become enforceable. Critical for compliance tracking and historical analysis. Ref: Sensus AMI.',
    `exceedance_action_required` STRING COMMENT 'Description of required actions when this limit is exceeded. Examples: Public notification within 24 hours, Implement corrosion control treatment, Increase monitoring frequency, Submit corrective action plan within 30 days, Immediate discharge cessation. Ref: Sensus AMI.',
    `health_effect_category` STRING COMMENT 'Primary health effect category associated with this contaminant. Acute = immediate health impact, chronic = long-term exposure health impact, carcinogen = cancer-causing, developmental = impacts fetal/child development, reproductive = impacts reproductive health, aesthetic = non-health impact (taste, odor, color). Ref: Sensus AMI.. Valid values are `acute|chronic|carcinogen|developmental|reproductive|aesthetic`',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction imposing this limit. Federal = EPA national standard, state = state primacy agency standard (may be more stringent than federal), local = municipal or county requirement, permit_specific = facility-specific limit in NPDES or discharge permit. Ref: Sensus AMI.. Valid values are `federal|state|local|permit_specific`',
    `jurisdiction_authority` STRING COMMENT 'Name of the regulatory authority or agency that issued this limit. Examples: U.S. EPA, California State Water Resources Control Board, Ohio EPA, Local Municipal Authority, or specific permit-issuing agency. Ref: Sensus AMI.',
    `limit_type` STRING COMMENT 'Type of regulatory or operational limit. MCL = Maximum Contaminant Level (enforceable), MCLG = Maximum Contaminant Level Goal (non-enforceable health goal), action_level = threshold triggering corrective action (e.g., Lead and Copper Rule), treatment_technique = required treatment process standard, permit_limit = facility-specific NPDES or discharge permit limit. Ref: Sensus AMI.. Valid values are `mcl|mclg|action_level|treatment_technique|permit_limit`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric threshold value for the contaminant limit. For example, MCL for lead is 0.015 mg/L. Null if limit is qualitative (e.g., treatment technique with no numeric threshold). Ref: Sensus AMI.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each contaminant limit record in the quality domain.',
    `monitoring_frequency_required` STRING COMMENT 'Required sampling and analysis frequency for this contaminant at this context. Examples: Quarterly, Monthly, Weekly, Daily, Continuous, Every 3 years, Per compliance schedule. May reference a compliance_schedule record for complex schedules. Ref: Sensus AMI.',
    `contaminant_limit_name` STRING COMMENT 'The contaminant limit name used to identify each contaminant limit record in the quality domain.',
    `notes` STRING COMMENT 'Additional context, clarifications, or special conditions related to this contaminant limit. May include information about seasonal variations, conditional applicability, calculation methods, or references to related compliance obligations. Ref: Sensus AMI.',
    `public_notification_tier` STRING COMMENT 'Public notification tier required when this limit is violated (drinking water only). Tier_1 = immediate notice (within 24 hours) for acute health risk, tier_2 = notice within 30 days for chronic health risk, tier_3 = notice within 1 year for monitoring/reporting violations, not_applicable = no public notification required (e.g., for wastewater limits). Ref: Sensus AMI.. Valid values are `tier_1|tier_2|tier_3|not_applicable`',
    `sample_location_type` STRING COMMENT 'Type of location where samples are collected for comparison against this limit. Entry_point = water entering distribution system, distribution_system = within distribution network, consumer_tap = at customer premise, source_water = raw water intake, effluent_discharge = treated wastewater discharge point, process_intermediate = within treatment process.. Valid values are `entry_point|distribution_system|consumer_tap|source_water|effluent_discharge|process_intermediate`',
    `superseded_date` DATE COMMENT 'Date when this limit was replaced by a newer regulation or permit condition. Null if the limit is currently active. Used for historical compliance analysis and regulatory change tracking. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the limit value. Common units: mg/L (milligrams per liter), ug/L (micrograms per liter), ppm (parts per million), ppb (parts per billion), ppt (parts per trillion), CFU/100mL (colony forming units per 100 milliliters for bacteriological), NTU (Nephelometric Turbidity Units), SU (standard units for pH), mrem/year (millirem per year for radionuclides). [ENUM-REF-CANDIDATE: mg/l|ug/l|ppm|ppb|ppt|cfu/100ml|ntu|su|mrem/year — 9 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant limit record was last modified. Used for audit trail and change tracking. Ref: Sensus AMI.',
    `variance_expiration_date` DATE COMMENT 'Date when the variance or waiver expires and standard limit enforcement resumes. Null if no variance is in effect or if variance is indefinite (subject to periodic review). Ref: Sensus AMI.',
    `variance_waiver_flag` BOOLEAN COMMENT 'Indicates whether a variance or waiver has been granted for this limit at this monitoring context. True = variance/waiver in effect (limit may be temporarily relaxed or monitoring reduced), False = standard limit applies without exception. Ref: Sensus AMI.',
    CONSTRAINT pk_contaminant_limit PRIMARY KEY(`contaminant_limit_id`)
) COMMENT 'Regulatory and operational limits for each contaminant at each applicable monitoring context (drinking water, effluent discharge, source water). Captures MCL, MCLG, action level, treatment technique standard, permit-specific effluent limit (daily max, monthly average), applicable regulation citation, effective date, superseded date, and jurisdiction (federal, state primacy agency). Enables automated compliance comparison against analytical_result values.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` (
    `exceedance_id` BIGINT COMMENT 'Primary key for exceedance. Ref: EPA SDWA.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: MCL exceedances are detected from specific analytical results. Currently has sample_id linking to water_sample, but should also link to the specific analytical_result that triggered the exceedance. Th. Ref: EPA SDWA.',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking to quality.ccr_period. Business justification: An exceedance detected during a reporting year must be disclosed in that years Consumer Confidence Report (CCR). The ccr_period is the parent reporting period; exceedance is the child event that fall',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Exceedances must be reported under specific permits and flagged in DMR submissions. A direct compliance_permit_id on exceedance enables permit-level exceedance dashboards and DMR noncompliance flaggin',
    `contaminant_limit_id` BIGINT COMMENT 'FK to quality.contaminant_limit. Ref: EPA SDWA.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Water quality exceedances are reported and remediated at the DMA level — utilities use DMA-level exceedance tracking to target flushing, pipe replacement, and pressure management interventions. This l',
    `facility_id` BIGINT COMMENT 'Facility associated with the exceedance. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to compliance.regulatory_agency. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each exceedance record in the quality domain.',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each exceedance record in the quality domain.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each exceedance record in the quality domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each exceedance in the quality domain.',
    `exceedance_category` STRING COMMENT 'The exceedance category value recorded for each exceedance in the quality domain.',
    `classification` STRING COMMENT 'The classification value recorded for each exceedance in the quality domain.',
    `exceedance_code` STRING COMMENT 'The exceedance code value recorded for each exceedance in the quality domain.',
    `comments` STRING COMMENT 'The comments value recorded for each exceedance in the quality domain.',
    `compliance_period` STRING COMMENT 'The compliance period value recorded for each exceedance in the quality domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each exceedance in the quality domain.',
    `confirmation_sample_required` BOOLEAN COMMENT 'Whether a confirmation sample must be collected. Ref: EPA SDWA.',
    `confirmed_date` TIMESTAMP COMMENT 'Date exceedance was confirmed by resampling. Ref: EPA SDWA.',
    `corrective_action_deadline` DATE COMMENT 'Deadline for completing corrective action. Ref: EPA SDWA.',
    `corrective_action_description` STRING COMMENT 'Description of corrective action taken. Ref: EPA SDWA.',
    `corrective_action_initiated` BOOLEAN COMMENT 'Whether a corrective action has been initiated in response. Ref: EPA SDWA.',
    `corrective_action_required` STRING COMMENT 'Whether corrective action is required. Ref: EPA SDWA.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'The corrective action required flag value recorded for each exceedance in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each exceedance in the quality domain.',
    `exceedance_description` STRING COMMENT 'The exceedance description value recorded for each exceedance in the quality domain.',
    `detected_date` TIMESTAMP COMMENT 'The detected date associated with each exceedance record in the quality domain.',
    `detected_value` DECIMAL(18,2) COMMENT 'Detected concentration value. Ref: EPA SDWA.',
    `detection_date` DATE COMMENT 'Date exceedance was detected. Ref: EPA SDWA.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each exceedance record in the quality domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each exceedance record in the quality domain.',
    `engineering_unit` STRING COMMENT 'Unit of measurement for the measured value and limit (e.g., mg/L, ug/L, pCi/L). Ref: EPA SDWA.',
    `exceedance_date` TIMESTAMP COMMENT 'The exceedance date associated with each exceedance record in the quality domain.',
    `exceedance_number` STRING COMMENT 'Unique exceedance reference number. Ref: EPA SDWA.',
    `exceedance_status` STRING COMMENT 'Status (detected, confirmed, reported, resolved, under_review). Ref: EPA SDWA.',
    `exceedance_type` STRING COMMENT 'Type (MCL, MCLG, action_level, treatment_technique, secondary). Ref: EPA SDWA.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each exceedance record in the quality domain.',
    `factor` DECIMAL(18,2) COMMENT 'Ratio of measured value to limit value. Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: EPA SDWA.',
    `is_confirmed` BOOLEAN COMMENT 'Boolean flag indicating whether the is confirmed condition applies to the exceedance record.',
    `jurisdiction` STRING COMMENT 'US, EU, or other regulatory jurisdiction. Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction (US_EPA, EU_DWD, UK_DWI). Ref: EPA SDWA.',
    `kpi_added_flag` BOOLEAN COMMENT 'Flag indicating KPI metadata added. Ref: EPA SDWA.',
    `kpi_note` STRING COMMENT 'Placeholder attribute to ensure quality.exceedance is touched by KPI addition. Ref: EPA SDWA.',
    `limit_type` STRING COMMENT 'MCL, MCLG, action level, treatment technique. Ref: EPA SDWA.',
    `limit_value` DECIMAL(18,2) COMMENT 'The limit value value recorded for each exceedance in the quality domain.',
    `magnitude` STRING COMMENT 'Amount by which limit was exceeded. Ref: EPA SDWA.',
    `mcl_value` DECIMAL(18,2) COMMENT 'Applicable MCL or action level value. Ref: EPA SDWA.',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value that exceeded limit. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each exceedance record in the quality domain.',
    `monitoring_period` STRING COMMENT 'Monitoring period (monthly, quarterly, annual). Ref: EPA SDWA.',
    `exceedance_name` STRING COMMENT 'The exceedance name used to identify each exceedance record in the quality domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: EPA SDWA.',
    `notification_date` TIMESTAMP COMMENT 'The notification date associated with each exceedance record in the quality domain.',
    `notification_required_flag` BOOLEAN COMMENT 'The notification required flag value recorded for each exceedance in the quality domain.',
    `parameter` STRING COMMENT 'Parameter that exceeded limit. Ref: EPA SDWA.',
    `parameter_name` STRING COMMENT 'The parameter name used to identify each exceedance record in the quality domain.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage value recorded for each exceedance in the quality domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each exceedance in the quality domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each exceedance in the quality domain.',
    `public_notification_deadline` DATE COMMENT 'Deadline for issuing public notification. Ref: EPA SDWA.',
    `public_notification_due_date` TIMESTAMP COMMENT 'Date by which public must be notified. Ref: EPA SDWA.',
    `public_notification_issued` STRING COMMENT 'Whether public notification was issued. Ref: EPA SDWA.',
    `public_notification_issued_date` TIMESTAMP COMMENT 'Date public notification was issued. Ref: EPA SDWA.',
    `public_notification_required` STRING COMMENT 'Whether public notification is required. Ref: EPA SDWA.',
    `public_notification_required_flag` BOOLEAN COMMENT 'The public notification required flag value recorded for each exceedance in the quality domain.',
    `public_notified_date` TIMESTAMP COMMENT 'Date public was actually notified. Ref: EPA SDWA.',
    `pwsid` STRING COMMENT 'Public Water System ID. Ref: EPA SDWA.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each exceedance in the quality domain.',
    `ratio` DECIMAL(18,2) COMMENT 'Ratio of detected value to MCL. Ref: EPA SDWA.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each exceedance in the quality domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each exceedance in the quality domain.',
    `regulatory_citation` STRING COMMENT 'Regulatory citation (40 CFR part, EU DWD Annex). Ref: EPA SDWA.',
    `regulatory_framework` STRING COMMENT 'Regulatory framework (EPA NPDWR, EU DWD 2020/2184, state primacy).',
    `regulatory_limit` STRING COMMENT 'Applicable regulatory limit value. Ref: EPA SDWA.',
    `regulatory_notification_due_date` TIMESTAMP COMMENT 'Date by which regulator must be notified. Ref: EPA SDWA.',
    `regulatory_notified_date` TIMESTAMP COMMENT 'Date regulator was actually notified. Ref: EPA SDWA.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each exceedance in the quality domain.',
    `reportable_flag` BOOLEAN COMMENT 'The reportable flag value recorded for each exceedance in the quality domain.',
    `reported_date` TIMESTAMP COMMENT 'Date exceedance was reported to regulator. Ref: EPA SDWA.',
    `reported_to_agency_date` TIMESTAMP COMMENT 'Date the exceedance was reported to the regulatory agency. Ref: EPA SDWA.',
    `reporting_date` DATE COMMENT 'Date reported to regulatory agency. Ref: EPA SDWA.',
    `reporting_deadline_date` TIMESTAMP COMMENT 'Regulatory reporting deadline. Ref: EPA SDWA.',
    `resolution_date` DATE COMMENT 'Date exceedance was resolved. Ref: EPA SDWA.',
    `resolution_description` STRING COMMENT 'Description of resolution. Ref: EPA SDWA.',
    `resolution_status` STRING COMMENT 'Current resolution status (open, under investigation, resolved, closed). Ref: EPA SDWA.',
    `resolved_date` TIMESTAMP COMMENT 'Date exceedance was resolved. Ref: EPA SDWA.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each exceedance in the quality domain.',
    `severity` STRING COMMENT 'The severity value recorded for each exceedance in the quality domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each exceedance record in the quality domain.',
    `treatment_response_description` STRING COMMENT 'Description of treatment response actions. Ref: EPA SDWA.',
    `treatment_response_required` BOOLEAN COMMENT 'Whether treatment response is required. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement (mg/L, ug/L, pCi/L, NTU). Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `value` DECIMAL(18,2) COMMENT 'The value value recorded for each exceedance in the quality domain.',
    CONSTRAINT pk_exceedance PRIMARY KEY(`exceedance_id`)
) COMMENT 'Transactional record of each confirmed MCL, action level, or permit limit exceedance detected from analytical results. Captures exceedance date, contaminant, sampling point, measured value, applicable limit, exceedance magnitude, regulatory notification deadline, public notification requirement flag, corrective action required, and resolution status. This is the primary operational record driving regulatory response workflows and violation tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` (
    `lead_copper_result_id` BIGINT COMMENT 'Unique identifier for the lead and copper sampling result record. Ref: EPA SDWA.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: lead_copper_result is a specialized transactional record for LCR/LCRR tap sampling. Each LCR record corresponds to an underlying analytical_result record in the laboratory system (LIMS). Adding analyt',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking to quality.ccr_period. Business justification: Lead and Copper Rule results are a mandatory component of the annual Consumer Confidence Report. Each LCR tap sample result belongs to a specific CCR reporting period (calendar year). Adding ccr_perio',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Lead and copper monitoring is conducted under the public water systems operating permit. Linking lead_copper_result to compliance_permit enables permit-level LCR compliance tracking and supports regu',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Lead and copper results are for specific contaminants (lead or copper). This FK identifies which contaminant the result applies to, enabling proper linkage to contaminant limits and regulatory require. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with the sampling site premises. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Lead and Copper Rule (LCR) compliance requires 90th percentile calculations and corrosion control treatment decisions at the facility level. Linking lead_copper_result to facility enables facility-lev',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Lead and copper results are collected under the Lead and Copper Rule — a specific regulatory requirement. This link enables LCR compliance tracking, 90th percentile calculation per rule cycle, and act',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Lead/copper monitoring follows LCR sampling rounds with specific site selection and frequency requirements. Links result to regulatory schedule for 90th percentile calculation, action level exceedance. Ref: EPA SDWA.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Lead/copper sampling requires precise service address tracking for tier site selection, customer notification within 30 days of result, and LCRR compliance documentation. Already has customer_account_',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR compliance requires linking lead/copper sampling results to the specific service line sampled — material type, ownership, and replacement priority are determined from the service line record. The',
    `water_sample_id` BIGINT COMMENT 'Laboratory-assigned unique identifier for the physical water sample collected at the tap. Ref: EPA SDWA.',
    `action_level_exceeded_flag` BOOLEAN COMMENT 'The action level exceeded flag value recorded for each lead copper result in the quality domain.',
    `analysis_date` DATE COMMENT 'Date when the laboratory completed the lead and copper analysis. Ref: EPA SDWA.',
    `analysis_method` BOOLEAN COMMENT 'EPA-approved analytical method used for lead and copper determination (e.g., EPA 200.8 ICP-MS, EPA 200.9 ICP-AES). Ref: EPA SDWA.',
    `lead_copper_result_code` STRING COMMENT 'The lead copper result code value recorded for each lead copper result in the quality domain.',
    `copper_action_level_exceeded` BOOLEAN COMMENT 'Indicates whether the copper result exceeds the EPA action level of 1300 ppb (1.3 mg/L), triggering potential corrosion control treatment requirements. Ref: EPA SDWA.',
    `copper_action_level_mg_l` DECIMAL(18,2) COMMENT 'The copper action level mg l value recorded for each lead copper result in the quality domain.',
    `copper_concentration_mg_l` DECIMAL(18,2) COMMENT 'The copper concentration mg l value recorded for each lead copper result in the quality domain.',
    `copper_result_ppb` DECIMAL(18,2) COMMENT 'Measured concentration of copper in the water sample expressed in parts per billion (ppb or µg/L). Used for 90th percentile calculation and action level comparison.',
    `corrosion_control_treatment_status` STRING COMMENT 'Status of corrosion control treatment optimization at the time of sampling, indicating whether the water system has optimized corrosion control per LCRR requirements.. Valid values are `optimal|suboptimal|not_optimized|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead and copper result record was first created in the system. Ref: EPA SDWA.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified of their individual lead and copper sample result. Ref: EPA SDWA.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether the customer was notified of their individual sample result as required by LCRR within 30 days of receiving results.',
    `lead_copper_result_description` STRING COMMENT 'The lead copper result description value recorded for each lead copper result in the quality domain.',
    `detection_limit_copper_ppb` DECIMAL(18,2) COMMENT 'Minimum concentration of copper that the analytical method can reliably detect and quantify for this sample. Ref: EPA SDWA.',
    `detection_limit_lead_ppb` DECIMAL(18,2) COMMENT 'Minimum concentration of lead that the analytical method can reliably detect and quantify for this sample. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The effective date associated with each lead copper result record in the quality domain.',
    `holding_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the EPA-required holding time (6 months for metals) from collection to analysis. Ref: EPA SDWA.',
    `included_in_90th_percentile` DECIMAL(18,2) COMMENT 'Indicates whether this result was included in the 90th percentile calculation for LCRR compliance determination. Invalid or QC-failed samples are excluded.',
    `lead_action_level_exceeded` BOOLEAN COMMENT 'Indicates whether the lead result exceeds the EPA action level of 15 ppb, triggering potential corrosion control treatment requirements. Ref: EPA SDWA.',
    `lead_action_level_mg_l` DECIMAL(18,2) COMMENT 'The lead action level mg l value recorded for each lead copper result in the quality domain.',
    `lead_concentration_mg_l` DECIMAL(18,2) COMMENT 'The lead concentration mg l value recorded for each lead copper result in the quality domain.',
    `lead_copper_result_status` STRING COMMENT 'The lead copper result status value recorded for each lead copper result in the quality domain.',
    `lead_result_ppb` DECIMAL(18,2) COMMENT 'Measured concentration of lead in the water sample expressed in parts per billion (ppb or µg/L). Used for 90th percentile calculation and action level comparison.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead and copper result record was last updated in the system. Ref: EPA SDWA.',
    `lead_copper_result_name` STRING COMMENT 'The lead copper result name used to identify each lead copper result record in the quality domain.',
    `ninetieth_percentile_flag` BOOLEAN COMMENT 'The ninetieth percentile flag value recorded for each lead copper result in the quality domain.',
    `quality_control_status` STRING COMMENT 'Laboratory quality control status indicating whether the sample result passed all QC checks including blanks, duplicates, and spike recoveries. Ref: EPA SDWA.. Valid values are `passed|failed|pending`',
    `regulatory_reporting_status` STRING COMMENT 'Status of this result in the regulatory reporting workflow to state primacy agency and EPA. Ref: EPA SDWA.. Valid values are `pending|submitted|accepted|rejected`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the sample collection or analysis. Ref: EPA SDWA.',
    `sample_collection_date` DATE COMMENT 'Date when the first-draw water sample was collected at the customer tap. Ref: EPA SDWA.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the first-draw water sample was collected, including time of day to verify minimum stagnation period compliance. Ref: EPA SDWA.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'The sample collection timestamp associated with each lead copper result record in the quality domain.',
    `sample_ph` DECIMAL(18,2) COMMENT 'pH measurement of the water sample at collection, relevant for corrosion control assessment. Ref: EPA SDWA.',
    `sample_preservation_method` STRING COMMENT 'Method used to preserve the sample for metals analysis, typically acidification with nitric acid to pH < 2. Ref: EPA SDWA.. Valid values are `nitric_acid|unpreserved`',
    `sample_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature at the time of sample collection, recorded to document field conditions. Ref: EPA SDWA.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the first-draw water sample collected, typically 1 liter (1000 mL) per LCRR protocol.',
    `site_tier` STRING COMMENT 'LCRR-mandated tier classification of the sampling site based on service line material and building construction date (Tier 1: lead service lines, Tier 2: lead status unknown, Tier 3: non-lead).. Valid values are `tier_1|tier_2|tier_3`',
    `stagnation_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours that water remained stagnant in the service line prior to sample collection. LCRR requires minimum 6-hour stagnation for first-draw samples.',
    CONSTRAINT pk_lead_copper_result PRIMARY KEY(`lead_copper_result_id`)
) COMMENT 'Specialized transactional record for Lead and Copper Rule (LCR/LCRR) monitoring at customer tap sampling sites. Captures sampling round (6-month period), customer service line material classification (lead, galvanized, copper, unknown), first-draw sample result (lead ppb, copper ppb), 90th percentile calculation inputs, action level exceedance flag (lead >15 ppb, copper >1300 ppb), tier classification of sampling site, and corrosion control treatment optimization status. Distinct from general analytical_result due to LCRR-specific site selection, tiering, and 90th percentile compliance methodology.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` (
    `ccr_period_id` BIGINT COMMENT 'Unique identifier for the Consumer Confidence Report period. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Consumer Confidence Reports are produced under the public water systems operating permit obligations. Linking ccr_period to compliance_permit enables direct traceability from the annual CCR to the pe',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Consumer Confidence Reports are issued per water system and must reference the treatment facility whose water quality data they summarize. This link is required for automated CCR generation, regulator',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency overseeing CCR/consumer information compliance (US EPA/state, ANSES, DWI, UBA). Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: CCR reporting obligations stem from specific regulatory requirements (e.g., 40 CFR Part 141 Subpart O). Linking ccr_period to regulatory_requirement enables compliance tracking against the specific ru',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each ccr period record in the quality domain.',
    `ccr_period_status` STRING COMMENT 'The ccr period status value recorded for each ccr period in the quality domain.',
    `certification_method` STRING COMMENT 'Method used to submit the CCR certification to the primacy agency. Many states now require electronic submission through online portals. Ref: EPA SDWA.. Valid values are `electronic|mail|fax|online_portal`',
    `certification_submission_date` DATE COMMENT 'Date when the CCR certification was submitted to the primacy agency. Systems must certify delivery of the CCR to customers by October 1. Ref: EPA SDWA.',
    `certified_by_name` STRING COMMENT 'Name of the authorized water system official who certified the CCR. Typically the system manager, superintendent, or designated compliance officer. Ref: EPA SDWA.',
    `certified_by_title` STRING COMMENT 'Job title of the authorized official who certified the CCR. Ref: EPA SDWA.',
    `ccr_period_code` STRING COMMENT 'The ccr period code value recorded for each ccr period in the quality domain.',
    `comments` STRING COMMENT 'Additional notes, observations, or context about this CCR period, preparation process, or special circumstances. Ref: EPA SDWA.',
    `contact_email` STRING COMMENT 'Email address for customer inquiries about the CCR. Increasingly included as an additional contact method. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the water system contact person for customer questions about the CCR. Required to be included in the published report. Ref: EPA SDWA.',
    `contact_phone` STRING COMMENT 'Phone number for customer inquiries about the CCR. Required to be included in the published report. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was first created in the system. Ref: EPA SDWA.',
    `customers_served_count` STRING COMMENT 'Total number of customer accounts or service connections served by the water system during the report year. Used to determine CCR distribution requirements. Ref: EPA SDWA.',
    `ccr_period_description` STRING COMMENT 'The ccr period description value recorded for each ccr period in the quality domain.',
    `distribution_method` STRING COMMENT 'Primary method used to deliver the Consumer Confidence Report to customers. EPA allows mail, electronic delivery, or posting with notification. Ref: EPA SDWA.. Valid values are `mailed|posted_online|electronic_delivery|newspaper|combination`',
    `distribution_status` STRING COMMENT 'The distribution status value recorded for each ccr period in the quality domain.',
    `document_file_path` STRING COMMENT 'File system path or cloud storage location of the final published CCR document (typically PDF format). Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The effective date associated with each ccr period record in the quality domain.',
    `eu_consumer_information_reference` STRING COMMENT 'Reference to EU DWD 2020/2184 Article 17 consumer information requirements or national transposition equivalent. NULL for US CCRs. Ref: EPA SDWA.',
    `eu_directive_reference` STRING COMMENT 'EU directive reference (Drinking Water Directive 2020/2184, WFD 2000/60/EC, UWWTD 91/271/EEC, REACH PFAS restriction). Ref: EPA SDWA.',
    `eu_dwd_article_17_compliance` BOOLEAN COMMENT 'Compliance with EU Drinking Water Directive 2020/2184 Article 17 consumer information requirements. Ref: EPA SDWA.',
    `eu_dwd_article_17_compliance_flag` BOOLEAN COMMENT 'Flag indicating compliance with EU Drinking Water Directive 2020/2184 Article 17 public information requirements. Null for non-EU jurisdictions. Ref: EPA SDWA.',
    `eu_dwd_article_17_compliant` BOOLEAN COMMENT 'Indicates compliance with EU Drinking Water Directive 2020/2184 Article 17 consumer information requirements. Ref: EPA SDWA.',
    `eu_dwd_compliance_flag` BOOLEAN COMMENT 'Indicates whether the reporting period meets EU Drinking Water Directive 2020/2184 requirements for public information disclosure, equivalent to US CCR but under Article 17 transparency obligations. Ref: EPA SDWA.',
    `eu_dwd_reference` STRING COMMENT 'EU Drinking Water Directive 2020/2184 consumer information reference. Ref: EPA SDWA.',
    `eu_reporting_directive_reference` STRING COMMENT 'EU reporting basis under Drinking Water Directive 2020/2184 for EU-flavor CCR-equivalent reporting. Ref: EPA SDWA.',
    `health_effects_language_included_flag` BOOLEAN COMMENT 'Indicates whether mandatory EPA health effects language was included for all detected contaminants. Required for CCR compliance. Ref: EPA SDWA.',
    `international_report_format` STRING COMMENT 'Report format standard: US_CCR (EPA), EU_DWD_ANNEX_IV, UK_DWI_ANNUAL, DE_TRINKWV, FR_ARS. Ref: EPA SDWA.',
    `issuing_authority_name` STRING COMMENT 'Name of the regulatory authority overseeing this CCR/public information report (US EPA, DWI, ANSES, UBA). Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'Reporting jurisdiction (US SDWA CCR vs EU DWD 2020/2184 consumer information obligations). Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction for consumer confidence reporting. US requires annual CCR under SDWA; EU DWD 2020/2184 Article 17 requires real-time online access to water quality information for consumers. Ref: EPA SDWA.',
    `jurisdiction_region` STRING COMMENT 'Sub-national or supra-national region qualifier, e.g. US state abbreviation, EU member state, UK nation (England/Wales/Scotland), German Bundesland. Supports multi-level regulatory hierarchy. Ref: EPA SDWA.',
    `jurisdiction_region_code` STRING COMMENT 'ISO region code for CCR jurisdiction (US, EU, FR, UK, DE). US CCRs follow EPA requirements; EU equivalents follow DWD 2020/2184 Article 17 consumer information provisions.',
    `jurisdictional_report_type` STRING COMMENT 'Report flavor: US CCR vs EU DWD Article 17 consumer information. Ref: EPA SDWA.',
    `language_accessibility_provided_flag` BOOLEAN COMMENT 'Indicates whether the CCR was made available in languages other than English to serve non-English speaking populations. Required for systems serving significant non-English speaking populations. Ref: EPA SDWA.',
    `lead_copper_educational_information_flag` BOOLEAN COMMENT 'Indicates whether mandatory lead and copper educational information was included in the CCR. Required under Lead and Copper Rule Revisions (LCRR).',
    `mcl_violation_count` STRING COMMENT 'Number of Maximum Contaminant Level violations that occurred during the report year. Must be prominently disclosed in the CCR. Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this CCR period record. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was last modified. Ref: EPA SDWA.',
    `monitoring_violation_count` STRING COMMENT 'Number of monitoring and reporting violations that occurred during the report year. Includes failures to test or report as required. Ref: EPA SDWA.',
    `ccr_period_name` STRING COMMENT 'The ccr period name used to identify each ccr period record in the quality domain.',
    `online_ccr_url` STRING COMMENT 'Web address where the CCR is posted online. Required if using electronic delivery method. Ref: EPA SDWA.',
    `period_end_date` DATE COMMENT 'The period end date associated with each ccr period record in the quality domain.',
    `period_start_date` DATE COMMENT 'The period start date associated with each ccr period record in the quality domain.',
    `population_served_count` STRING COMMENT 'Estimated total population receiving water from the system during the report year. Used for regulatory classification and reporting. Ref: EPA SDWA.',
    `preparation_start_date` DATE COMMENT 'Date when preparation of the Consumer Confidence Report began. Typically starts in January following the report year. Ref: EPA SDWA.',
    `primacy_agency` STRING COMMENT 'State or tribal agency with primary enforcement responsibility for public water systems under the Safe Drinking Water Act. Typically the state Department of Environmental Quality or Health. Ref: EPA SDWA.',
    `publication_date` DATE COMMENT 'Date when the Consumer Confidence Report was published and made available to customers. Must be by July 1 following the report year per EPA regulations. Ref: EPA SDWA.',
    `published_flag` BOOLEAN COMMENT 'The published flag value recorded for each ccr period in the quality domain.',
    `pwsid` STRING COMMENT 'EPA-assigned unique identifier for the public water system. Format: two-letter state code followed by seven digits (e.g., CA1234567). Ref: EPA SDWA.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `regulatory_body_name` STRING COMMENT 'Name of the regulatory agency or body with oversight, e.g. US EPA, state primacy agency, European Commission DG Environment, French ANSES, UK DWI (Drinking Water Inspectorate), German UBA (Umweltbundesamt), Australian NHMRC. Ref: EPA SDWA.',
    `regulatory_directive_reference` STRING COMMENT 'Specific directive, rule, or regulation citation, e.g. 40 CFR 141 (US NPDWR), Directive 2020/2184/EU Article 13, Directive 91/271/EEC Annex I, REACH Annex XVII PFAS restriction, French Code de la sante publique R.1321.',
    `regulatory_framework` STRING COMMENT 'Consumer reporting framework: US_SDWA_CCR, EU_DWD_2020_2184_ART17, or national transposition. EU approach emphasizes continuous digital access vs US annual paper/electronic report. Ref: EPA SDWA.',
    `regulatory_framework_reference` STRING COMMENT 'Framework governing the consumer report, e.g. US SDWA CCR or EU DWD 2020/2184. Ref: EU Drinking Water Directive 2020/2184; REACH PFAS restriction; Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC. Ref: EPA SDWA.',
    `regulatory_region` STRING COMMENT 'Region of the consumer confidence / drinking-water reporting period (DE|EU|FR|UK|US). Ref: EPA SDWA.',
    `regulatory_region_code` STRING COMMENT 'ISO region code for CCR jurisdiction (US, EU, FR, UK, DE)',
    `report_status` STRING COMMENT 'Current lifecycle status of the Consumer Confidence Report. Tracks progression from draft through publication and certification to primacy agency. Ref: EPA SDWA.. Valid values are `draft|in_review|approved|published|certified|archived`',
    `report_year` STRING COMMENT 'Calendar year for which this Consumer Confidence Report is prepared. CCRs are annual reports covering the previous calendar years water quality data. Ref: EPA SDWA.',
    `reporting_year` STRING COMMENT 'The reporting year value recorded for each ccr period in the quality domain.',
    `source_water_assessment_summary` STRING COMMENT 'Summary of the source water assessment including susceptibility to contamination and availability information. Required CCR content element. Ref: EPA SDWA.',
    `special_notices_included` STRING COMMENT 'Description of any special notices included in the CCR such as boil water advisories, vulnerable population warnings, or emerging contaminant information.',
    `treatment_technique_violation_count` STRING COMMENT 'Number of treatment technique violations that occurred during the report year. Treatment techniques are required processes for contaminants without MCLs. Ref: EPA SDWA.',
    `violation_summary` STRING COMMENT 'Narrative summary of all violations that occurred during the report year, including health effects language and corrective actions taken. Required CCR content element. Ref: EPA SDWA.',
    `water_source_summary` STRING COMMENT 'Narrative description of the water systems sources including surface water, groundwater, purchased water, and source water protection information. Required CCR content element. Ref: EPA SDWA.',
    `wfd_river_basin_district` STRING COMMENT 'EU Water Framework Directive 2000/60/EC river basin district identifier for source water context in EU jurisdictions. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this CCR period record. Ref: EPA SDWA.',
    CONSTRAINT pk_ccr_period PRIMARY KEY(`ccr_period_id`)
) COMMENT 'Master record for each annual Consumer Confidence Report (CCR) reporting period. Captures report year, water system name, PWSID (Public Water System ID), primacy agency, report preparation status, publication date, distribution method (mailed, posted, electronic), number of customers served, water source summary, detected contaminant summary count, violation summary, and certification submission date to primacy agency. Serves as the organizing entity for all CCR-related quality data aggregation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` (
    `ccr_contaminant_disclosure_id` BIGINT COMMENT 'Primary key for the ccr_contaminant_disclosure association',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking this disclosure record to the annual CCR reporting period in which the contaminant was disclosed.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking this disclosure record to the regulated contaminant master entry being disclosed.',
    `compliance_status` STRING COMMENT 'Compliance determination for this contaminant in this CCR period. Indicates whether the detected value met, exceeded, or was not subject to the applicable MCL.',
    `detected_contaminant_count` STRING COMMENT 'Total number of regulated contaminants detected in the water system during the report year. Includes contaminants above and below Maximum Contaminant Levels (MCL). Ref: EPA SDWA. [Moved from ccr_period: This is a derived summary count of how many contaminants were detected in the period. It is derivable by COUNT(*) over ccr_contaminant_disclosure records for the period and should not be stored redundantly on ccr_period. If retained on ccr_period it must be treated as a denormalized cache, not a source of truth.]',
    `detected_value` DECIMAL(18,2) COMMENT 'The measured concentration of the contaminant reported in the CCR for this period. This value is specific to the period-contaminant combination and cannot reside on either master entity.',
    `health_effects_language` STRING COMMENT 'The mandatory EPA health effects language included in the CCR for this contaminant in this period. Text may vary by reporting year as EPA updates required language; captured here rather than on the contaminant master to preserve the exact language used in each published report.',
    `mcl_value_at_reporting` DECIMAL(18,2) COMMENT 'The Maximum Contaminant Level (MCL) in effect at the time this CCR period was published. Captured here because MCLs can change between reporting years, and the contaminant master reflects only the current MCL.',
    `reporting_unit_of_measure` STRING COMMENT 'The unit of measure used to express the detected value in the published CCR (e.g., mg/L, ng/L, pCi/L). May vary by contaminant and reporting year.',
    `violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an MCL exceedance or monitoring violation occurred for this contaminant during this reporting period. Drives mandatory public notification requirements.',
    CONSTRAINT pk_ccr_contaminant_disclosure PRIMARY KEY(`ccr_contaminant_disclosure_id`)
) COMMENT 'This association product represents the regulatory disclosure event between a CCR reporting period and a regulated contaminant. It captures the year-specific detected concentration, compliance determination, applicable MCL at time of reporting, and mandatory health effects language that the EPA CCR Rule (40 CFR Part 141, Subpart O) requires water systems to publish annually. Each record links one ccr_period to one contaminant with attributes that exist only in the context of that period-contaminant disclosure and cannot reside on either master entity alone.. Existence Justification: The EPA CCR Rule (40 CFR Part 141, Subpart O) mandates that every annual Consumer Confidence Report disclose the detected levels of ALL regulated contaminants found during that reporting year. This creates a genuine operational M:N: a single CCR period covers many contaminants (every regulated substance detected), and a single contaminant (e.g., PFOA, nitrate, lead) appears across many CCR periods year after year. The association — a CCR contaminant disclosure — is an active regulatory record that water system staff create, review, and certify each year, carrying year-specific detected values, compliance determinations, and MCL references that belong to neither the period nor the contaminant master alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_parent_sample_water_sample_id` FOREIGN KEY (`parent_sample_water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ADD CONSTRAINT `fk_quality_ccr_contaminant_disclosure_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ADD CONSTRAINT `fk_quality_ccr_contaminant_disclosure_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_dwd_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Regulated');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_dwd_sum20_included` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Sum-20');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_dwd_total_pfas_included` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Total PFAS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_parametric_limit_ng_l` SET TAGS ('dbx_business_glossary_term' = 'EU Parametric Limit (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_parametric_value_ng_l` SET TAGS ('dbx_business_glossary_term' = 'EU Parametric Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_pfas_total_class_member` SET TAGS ('dbx_business_glossary_term' = 'EU PFAS Total Class Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_pfas_total_member` SET TAGS ('dbx_business_glossary_term' = 'EU PFAS Total Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `eu_sum_of_20_member` SET TAGS ('dbx_business_glossary_term' = 'EU Sum-of-20 Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `gac_removal_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'GAC Removal Efficiency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `hazard_index_mcl_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index MCL');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effects` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effects` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `ion_exchange_removal_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Ion Exchange Removal Efficiency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `perfluorinated_carbon_count` SET TAGS ('dbx_business_glossary_term' = 'Perfluorinated Carbon Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_bioaccumulation_potential` SET TAGS ('dbx_business_glossary_term' = 'Bioaccumulation Potential');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_carbon_count` SET TAGS ('dbx_business_glossary_term' = 'Carbon Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_chain_length` SET TAGS ('dbx_business_glossary_term' = 'PFAS Chain Length');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_compound_abbreviation` SET TAGS ('dbx_business_glossary_term' = 'PFAS Compound Abbreviation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_full_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_functional_class` SET TAGS ('dbx_business_glossary_term' = 'PFAS Functional Class');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_persistence_class` SET TAGS ('dbx_business_glossary_term' = 'Persistence Class');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `pfas_sum_of_20_member_flag` SET TAGS ('dbx_business_glossary_term' = 'PFAS Sum-of-20 Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `primary_treatment_technology` SET TAGS ('dbx_business_glossary_term' = 'Primary Treatment');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `primary_treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `primary_treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `reach_restriction_applicable` SET TAGS ('dbx_business_glossary_term' = 'REACH Restriction');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `reach_restriction_status` SET TAGS ('dbx_business_glossary_term' = 'REACH Restriction Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_epa_hazard_index_member` SET TAGS ('dbx_business_glossary_term' = 'US EPA HI Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_epa_hbwc_ng_l` SET TAGS ('dbx_business_glossary_term' = 'US EPA HBWC (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_epa_mcl_ng_l` SET TAGS ('dbx_business_glossary_term' = 'US EPA MCL (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_hazard_index_hbwc_ng_l` SET TAGS ('dbx_business_glossary_term' = 'US HBWC (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_hazard_index_member` SET TAGS ('dbx_business_glossary_term' = 'US Hazard Index Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_health_advisory_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_health_advisory_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `us_individual_mcl_ng_l` SET TAGS ('dbx_business_glossary_term' = 'US Individual MCL (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `analytical_method_required` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Required');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Period Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `confirmation_sample_required` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sample Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `corrective_action_initiated` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Initiated');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `factor` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Factor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `parameter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `public_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `public_notification_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Issued Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'Pwsid');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `reported_to_agency_date` SET TAGS ('dbx_business_glossary_term' = 'Reported To Agency Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `reporting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `treatment_response_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `treatment_response_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `treatment_response_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `treatment_response_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_copper_result_id` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Period Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identification Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Code');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `stagnation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Water Stagnation Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Period ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_business_glossary_term' = 'Certification Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|fax|online_portal');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Certified By Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_title` SET TAGS ('dbx_business_glossary_term' = 'Certified By Title');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `customers_served_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Served Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'mailed|posted_online|electronic_delivery|newspaper|combination');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_consumer_information_reference` SET TAGS ('dbx_business_glossary_term' = 'EU consumer information reference');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_article_17_compliance` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Article 17 Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_article_17_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Article 17 Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_article_17_compliant` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Article 17 Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_dwd_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_reporting_directive_reference` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Language Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `international_report_format` SET TAGS ('dbx_business_glossary_term' = 'International Report Format');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction region code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_i18n' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `wfd_river_basin_district` SET TAGS ('dbx_business_glossary_term' = 'WFD River Basin District');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` SET TAGS ('dbx_association_edges' = 'quality.ccr_period,quality.contaminant');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `ccr_contaminant_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Ccr Contaminant Disclosure Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Ccr Period Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Contaminant Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `detected_contaminant_count` SET TAGS ('dbx_business_glossary_term' = 'Detected Contaminant Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `detected_value` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Detected Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Health Effects Language');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `mcl_value_at_reporting` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Mcl Value At Reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `reporting_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Reporting Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_contaminant_disclosure` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Ccr Contaminant Disclosure - Violation Flag');
