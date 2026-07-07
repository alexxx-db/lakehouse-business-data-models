-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`quality` COMMENT 'Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` (
    `quality_sampling_point_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each quality sampling point record in the quality domain.',
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address referenced by each quality sampling point record in the quality domain.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory referenced by each quality sampling point record in the quality domain.',
    `asset_sampling_point_id` BIGINT COMMENT 'Unique identifier for the canonical asset sampling point referenced by each quality sampling point record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each quality sampling point record in the quality domain.',
    `access_type` STRING COMMENT 'The access type value recorded for each quality sampling point in the quality domain.',
    `ccr_reporting_flag` BOOLEAN COMMENT 'The ccr reporting flag value recorded for each quality sampling point in the quality domain.',
    `quality_sampling_point_code` STRING COMMENT 'The quality sampling point code value recorded for each quality sampling point in the quality domain.',
    `comments` STRING COMMENT 'The comments value recorded for each quality sampling point in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each quality sampling point record in the quality domain.',
    `decommission_date` DATE COMMENT 'The decommission date associated with each quality sampling point record in the quality domain.',
    `quality_sampling_point_description` STRING COMMENT 'The quality sampling point description value recorded for each quality sampling point in the quality domain.',
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
    `quality_sampling_point_name` STRING COMMENT 'The quality sampling point name used to identify each quality sampling point record in the quality domain.',
    `next_scheduled_sample_date` DATE COMMENT 'The next scheduled sample date associated with each quality sampling point record in the quality domain.',
    `pressure_zone` STRING COMMENT 'The pressure zone value recorded for each quality sampling point in the quality domain.',
    `primary_contaminant_group` STRING COMMENT 'The primary contaminant group value recorded for each quality sampling point in the quality domain.',
    `regulatory_zone` STRING COMMENT 'The regulatory zone value recorded for each quality sampling point in the quality domain.',
    `residence_time_hours` DECIMAL(18,2) COMMENT 'The residence time hours value recorded for each quality sampling point in the quality domain.',
    `responsible_department` STRING COMMENT 'The responsible department value recorded for each quality sampling point in the quality domain.',
    `safety_notes` STRING COMMENT 'The safety notes value recorded for each quality sampling point in the quality domain.',
    `sample_collection_method` STRING COMMENT 'The sample collection method value recorded for each quality sampling point in the quality domain.',
    `sampler_name` STRING COMMENT 'The sampler name used to identify each quality sampling point record in the quality domain.',
    `sampling_frequency` STRING COMMENT 'The sampling frequency value recorded for each quality sampling point in the quality domain.',
    `sampling_instructions` STRING COMMENT 'The sampling instructions value recorded for each quality sampling point in the quality domain.',
    `sampling_point_code` STRING COMMENT 'The sampling point code value recorded for each quality sampling point in the quality domain.',
    `sampling_point_name` STRING COMMENT 'The sampling point name used to identify each quality sampling point record in the quality domain.',
    `sampling_point_status` STRING COMMENT 'The sampling point status value recorded for each quality sampling point in the quality domain.',
    `scada_tag` STRING COMMENT 'The scada tag value recorded for each quality sampling point in the quality domain.',
    `quality_sampling_point_status` STRING COMMENT 'The quality sampling point status value recorded for each quality sampling point in the quality domain.',
    `treatment_stage` STRING COMMENT 'The treatment stage value recorded for each quality sampling point in the quality domain.',
    `water_source_type` STRING COMMENT 'The water source type value recorded for each quality sampling point in the quality domain.',
    `created_by` STRING COMMENT 'The created by value recorded for each quality sampling point in the quality domain.',
    CONSTRAINT pk_quality_sampling_point PRIMARY KEY(`quality_sampling_point_id`)
) COMMENT 'Master registry of all approved water quality sampling locations across the utilitys infrastructure including distribution system sites, source water intakes, WTP/WWTP process points, and wastewater effluent discharge outfalls. Captures location type (entry point, distribution, source, effluent, customer tap), GIS coordinates, regulatory monitoring zone classification, DMA assignment, pressure zone, LCRR tier classification for tap sites, associated permit or CCR reporting requirements, and activation/deactivation status. Serves as the authoritative SSOT for where samples are collected and links to sampling_schedule for monitoring requirements. [SSOT: reference view of canonical asset.asset_sampling_point] SSOT master for sampling points.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` (
    `sampling_schedule_id` BIGINT COMMENT 'Primary key. Ref: EPA SDWA.',
    `contaminant_group_id` BIGINT COMMENT 'Unique identifier for the contaminant group referenced by each sampling schedule record in the quality domain.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each sampling schedule record in the quality domain.',
    `location_id` BIGINT COMMENT 'Unique identifier for the monitoring location referenced by each sampling schedule record in the quality domain.',
    `obligation_id` BIGINT COMMENT 'Unique identifier for the obligation referenced by each sampling schedule record in the quality domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each sampling schedule record in the quality domain.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each sampling schedule record in the quality domain.',
    `crew_id` BIGINT COMMENT 'Unique identifier for the responsible crew referenced by each sampling schedule record in the quality domain.',
    `sampling_plan_id` BIGINT COMMENT 'Unique identifier for the sampling plan referenced by each sampling schedule record in the quality domain.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor referenced by each sampling schedule record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each sampling schedule record in the quality domain.',
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
    `schedule_name` STRING COMMENT 'The schedule name used to identify each sampling schedule record in the quality domain.',
    `schedule_status` STRING COMMENT 'The schedule status value recorded for each sampling schedule in the quality domain.',
    `schedule_type` STRING COMMENT 'The schedule type value recorded for each sampling schedule in the quality domain.',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'The seasonal adjustment flag value recorded for each sampling schedule in the quality domain.',
    `sampling_schedule_status` STRING COMMENT 'The sampling schedule status value recorded for each sampling schedule in the quality domain.',
    `violation_flag` BOOLEAN COMMENT 'The violation flag value recorded for each sampling schedule in the quality domain.',
    CONSTRAINT pk_sampling_schedule PRIMARY KEY(`sampling_schedule_id`)
) COMMENT 'Defines the regulatory and operational sampling schedules for each monitoring location and contaminant group. Captures required sampling frequency (daily, weekly, monthly, quarterly, annual), applicable rule (LCRR, DBP Stage 2, PFAS, NPDES), monitoring period start/end dates, responsible lab or field crew, and schedule status. Drives compliance calendar and ensures no monitoring gaps that could trigger violations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` (
    `water_sample_id` BIGINT COMMENT 'Primary key. Ref: LabWare LIMS.',
    `chain_of_custody_id` BIGINT COMMENT 'Unique identifier for the chain of custody referenced by each water sample record in the quality domain.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each water sample record in the quality domain.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each water sample record in the quality domain.',
    `lab_sample_id` BIGINT COMMENT 'Unique identifier for the lab sample referenced by each water sample record in the quality domain.',
    `parent_sample_water_sample_id` BIGINT COMMENT 'Unique identifier for the parent sample water sample referenced by each water sample record in the quality domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary water employee referenced by each water sample record in the quality domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each water sample record in the quality domain.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each water sample record in the quality domain.',
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address referenced by each water sample record in the quality domain.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor referenced by each water sample record in the quality domain.',
    `water_employee_id` BIGINT COMMENT 'Unique identifier for the water employee referenced by each water sample record in the quality domain.',
    `water_modified_by_user_employee_id` BIGINT COMMENT 'Unique identifier for the water modified by user employee referenced by each water sample record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each water sample record in the quality domain.',
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
    `certified_analyst_id` BIGINT COMMENT 'Unique identifier for the certified analyst referenced by each analytical result record in the quality domain.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each analytical result record in the quality domain.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each analytical result record in the quality domain.',
    `contaminant_limit_id` BIGINT COMMENT 'Unique identifier for the contaminant limit referenced by each analytical result record in the quality domain.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each analytical result record in the quality domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee referenced by each analytical result record in the quality domain.',
    `lab_instrument_id` BIGINT COMMENT 'Unique identifier for the lab instrument referenced by each analytical result record in the quality domain.',
    `qaqc_batch_id` BIGINT COMMENT 'Unique identifier for the qaqc batch referenced by each analytical result record in the quality domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each analytical result record in the quality domain.',
    `test_result_id` BIGINT COMMENT 'Unique identifier for the test result referenced by each analytical result record in the quality domain.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor referenced by each analytical result record in the quality domain.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each analytical result record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each analytical result record in the quality domain.',
    `analysis_date` DATE COMMENT 'The analysis date associated with each analytical result record in the quality domain.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The analysis timestamp associated with each analytical result record in the quality domain.',
    `analytical_method` STRING COMMENT 'The analytical method value recorded for each analytical result in the quality domain.',
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
    `analytical_result_status` STRING COMMENT 'The analytical result status value recorded for each analytical result in the quality domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each analytical result in the quality domain.',
    `validated_by` STRING COMMENT 'The validated by associated with each analytical result record in the quality domain.',
    `validation_timestamp` TIMESTAMP COMMENT 'The validation timestamp associated with each analytical result record in the quality domain.',
    CONSTRAINT pk_analytical_result PRIMARY KEY(`analytical_result_id`)
) COMMENT 'Laboratory and field analytical result for each parameter tested on a collected water sample or measured by a continuous online instrument. Captures analyte/contaminant reference, CAS number, analytical method (EPA method number), result value, unit of measure, detection limit (MDL/MRL), qualifier flags (non-detect, estimated, hold-time exceeded, presence/absence), result type (grab, composite, continuous, calculated), measurement source (laboratory, field, SCADA/online), laboratory accreditation number, analyst ID, analysis date/time, QA/QC batch reference, instrument ID for online readings, and monitoring period context. Supports all parameter types including conventional chemistry, DBP species, PFAS compounds, bacteriological presence/absence, turbidity NTU, chlorine residuals, and CT calculations. Links to water_sample for discrete samples and online_instrument for continuous readings. Sourced from LIMS (LabWare) and OSIsoft PI Historian. Note: Individual PFAS compound results are stored here for lab-level detail; pfas_monitoring provides the regulatory compliance context, hazard index calculations, and treatment trigger evaluations that aggregate across compounds.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` (
    `contaminant_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `analyte_id` BIGINT COMMENT 'Unique identifier for the analyte referenced by each contaminant record in the quality domain.',
    `contaminant_group_id` BIGINT COMMENT 'FK to contaminant group. Ref: Sensus AMI.',
    `pfas_compound_id` BIGINT COMMENT 'Unique identifier for the pfas compound referenced by each contaminant record in the quality domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each contaminant record in the quality domain.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each contaminant record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each contaminant record in the quality domain.',
    `action_level_unit` STRING COMMENT 'The action level unit value recorded for each contaminant in the quality domain.',
    `action_level_value` DECIMAL(18,2) COMMENT 'The action level value value recorded for each contaminant in the quality domain.',
    `analytical_method_code` STRING COMMENT 'The analytical method code value recorded for each contaminant in the quality domain.',
    `analytical_method_reference` STRING COMMENT 'EPA 524.2, EPA 533, ISO method',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service (CAS) registry number. PFAS compounds enumerated: PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA (GenX), PFHxA, PFHpA, PFDA, PFUnDA with CAS numbers per ECHA REACH database. Ref: Sensus AMI.',
    `contaminant_category` STRING COMMENT 'IOC, VOC, SOC, radionuclide, microbiological, DBP, PFAS. Ref: Sensus AMI.',
    `ccr_language_template` STRING COMMENT 'The ccr language template value recorded for each contaminant in the quality domain.',
    `ccr_reporting_required` BOOLEAN COMMENT 'The ccr reporting required value recorded for each contaminant in the quality domain.',
    `contaminant_code` STRING COMMENT 'EPA contaminant code. Ref: Sensus AMI.',
    `contaminant_name` STRING COMMENT 'Contaminant name. Ref: Sensus AMI.',
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
    `monitoring_context_id` BIGINT COMMENT 'Reference to the monitoring context where this limit applies (e.g., drinking water distribution, source water intake, wastewater effluent discharge point). Ref: Sensus AMI.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each contaminant limit record in the quality domain.',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Regulatory contaminant limits (MCLs, discharge limits) are specified in treatment/discharge permits. Links specific numeric limit to authorizing permit for compliance tracking, permit renewal, and var. Ref: Sensus AMI.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each contaminant limit record in the quality domain.',
    `analytical_method_required` STRING COMMENT 'EPA-approved analytical method(s) required for measuring this contaminant. Examples: EPA Method 200.8 (metals by ICP-MS), EPA Method 524.2 (VOCs), EPA Method 537.1 (PFAS), Standard Method 2320 (alkalinity), EPA Method 1664A (oil and grease). Ref: Sensus AMI.',
    `applicable_regulation` STRING COMMENT 'Citation of the regulation or rule establishing this limit. Examples: 40 CFR 141.80 (Stage 2 DBPR), 40 CFR 141.51 (MCLs for inorganic contaminants), LCRR 40 CFR 141.80-141.91, state-specific regulation citation, or facility NPDES permit number.',
    `averaging_period` STRING COMMENT 'Time period over which the limit is calculated or averaged. Instantaneous = single sample, daily_max = maximum value in a day, monthly_avg = average over calendar month, quarterly_avg = average over quarter, annual_avg = average over calendar year, running_annual_avg = rolling 12-month average, locational_running_annual_avg = running annual average at specific sampling location (e.g., for DBPs under Stage 2 DBPR). [ENUM-REF-CANDIDATE: instantaneous|daily_max|monthly_avg|quarterly_avg|annual_avg|running_annual_avg|locational_running_annual_avg — 7 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether this contaminant must be included in the annual Consumer Confidence Report (CCR) distributed to drinking water customers. True = must report in CCR, False = not required in CCR. Ref: Sensus AMI.',
    `contaminant_limit_code` STRING COMMENT 'The contaminant limit code value recorded for each contaminant limit in the quality domain.',
    `compliance_status` STRING COMMENT 'Current status of this limit record. Active = currently enforceable, superseded = replaced by newer limit, pending = future effective date not yet reached, suspended = temporarily not enforced due to variance or waiver. Ref: Sensus AMI.. Valid values are `active|superseded|pending|suspended`',
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
    `contaminant_limit_status` STRING COMMENT 'The contaminant limit status value recorded for each contaminant limit in the quality domain.',
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
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Quality exceedances (MCL, action level violations) trigger formal compliance violations that require regulatory reporting, public notification, and enforcement response. This link connects water quali. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each exceedance record in the quality domain.',
    `contaminant_limit_id` BIGINT COMMENT 'FK to quality.contaminant_limit. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the exceedance created by employee referenced by each exceedance record in the quality domain.',
    `exceedance_quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the exceedance quality sampling point referenced by each exceedance record in the quality domain.',
    `exceedance_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the exceedance responsible employee referenced by each exceedance record in the quality domain.',
    `facility_id` BIGINT COMMENT 'Facility associated with the exceedance. Ref: EPA SDWA.',
    `laboratory_corrective_action_id` BIGINT COMMENT 'Unique identifier for the quality corrective action referenced by each exceedance record in the quality domain.',
    `quality_public_notification_id` BIGINT COMMENT 'FK to quality.quality_public_notification. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each exceedance record in the quality domain.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to compliance.regulatory_agency. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each exceedance record in the quality domain.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each exceedance record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'FK to the water system. Ref: EPA SDWA.',
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
    `exceedance_name` STRING COMMENT 'The exceedance name used to identify each exceedance record in the quality domain.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` (
    `dbp_monitoring_event_id` BIGINT COMMENT 'Unique identifier for the disinfection byproduct monitoring event record. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DBP monitoring is a recurring compliance cost with dedicated budget allocation; linking to cost_center enables tracking of Stage 2 DBPR compliance costs for regulatory reporting and rate case cost rec. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'The unique sample identifier assigned by the laboratory for tracking and chain of custody. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each dbp monitoring event record in the quality domain.',
    `territory_id` BIGINT COMMENT 'Reference to the public water system subject to DBP monitoring requirements. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the DBP analysis. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: DBP monitoring events are based on water samples collected and analyzed. Currently has lab_sample_id (cross-domain to laboratory). Adding water_sample_id establishes the in-domain link to the quality. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Reference to the public water system subject to DBP monitoring requirements. Ref: EPA SDWA.',
    `analysis_completion_date` DATE COMMENT 'The date when the laboratory completed the DBP analysis and reported results. Ref: EPA SDWA.',
    `bromide_concentration_mg_l` DECIMAL(18,2) COMMENT 'The bromide ion concentration in milligrams per liter, which influences the formation of brominated DBP species. Ref: EPA SDWA.',
    `bromodichloromethane_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of bromodichloromethane (CHBrCl2), a trihalomethane species, in micrograms per liter. Ref: EPA SDWA.',
    `bromoform_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of bromoform (CHBr3), a trihalomethane species, in micrograms per liter. Ref: EPA SDWA.',
    `ccr_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this monitoring event result is included in the annual Consumer Confidence Report. Ref: EPA SDWA.',
    `chloroform_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of chloroform (CHCl3), a trihalomethane species, in micrograms per liter. Ref: EPA SDWA.',
    `dbp_monitoring_event_code` STRING COMMENT 'The dbp monitoring event code value recorded for each dbp monitoring event in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DBP monitoring event record was first created in the system. Ref: EPA SDWA.',
    `dbp_monitoring_event_description` STRING COMMENT 'The dbp monitoring event description value recorded for each dbp monitoring event in the quality domain.',
    `dibromoacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of dibromoacetic acid (DBAA), a haloacetic acid species, in micrograms per liter. Ref: EPA SDWA.',
    `dibromochloromethane_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of dibromochloromethane (CHBr2Cl), a trihalomethane species, in micrograms per liter. Ref: EPA SDWA.',
    `dichloroacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of dichloroacetic acid (DCAA), a haloacetic acid species, in micrograms per liter. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The effective date associated with each dbp monitoring event record in the quality domain.',
    `free_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'The free chlorine residual measured at the time of sample collection, in milligrams per liter, which influences DBP formation. Ref: EPA SDWA.',
    `haa5_compliance_status` STRING COMMENT 'Indicates whether the HAA5 LRAA at this monitoring point is in compliance with the MCL. Ref: EPA SDWA.. Valid values are `compliant|non-compliant|pending|under_review`',
    `haa5_concentration_ug_l` DECIMAL(18,2) COMMENT 'Sum of the five regulated haloacetic acid species (MCAA, DCAA, TCAA, MBAA, DBAA) in micrograms per liter. Ref: EPA SDWA.',
    `haa5_lraa_ug_l` DECIMAL(18,2) COMMENT 'The locational running annual average of HAA5 concentrations at this monitoring point, calculated as the arithmetic average of the current quarter and the previous three quarters. Ref: EPA SDWA.',
    `haa5_mcl_ug_l` DECIMAL(18,2) COMMENT 'The applicable HAA5 maximum contaminant level for this monitoring event, typically 60 µg/L under Stage 2 DBPR. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this DBP monitoring event record was last updated in the system. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each dbp monitoring event record in the quality domain.',
    `monitoring_frequency` STRING COMMENT 'The required monitoring frequency for this location under Stage 2 DBPR, which may vary based on system size and historical compliance. Ref: EPA SDWA.. Valid values are `quarterly|annual|reduced|increased`',
    `monitoring_period_end_date` DATE COMMENT 'The last day of the monitoring period (typically quarterly) for which this DBP sample applies. Ref: EPA SDWA.',
    `monitoring_period_start_date` DATE COMMENT 'The first day of the monitoring period (typically quarterly) for which this DBP sample applies. Ref: EPA SDWA.',
    `monobromoacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of monobromoacetic acid (MBAA), a haloacetic acid species, in micrograms per liter. Ref: EPA SDWA.',
    `monochloroacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of monochloroacetic acid (MCAA), a haloacetic acid species, in micrograms per liter. Ref: EPA SDWA.',
    `dbp_monitoring_event_name` STRING COMMENT 'The dbp monitoring event name used to identify each dbp monitoring event record in the quality domain.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the monitoring event, sample collection, or analysis results. Ref: EPA SDWA.',
    `ph_value` DECIMAL(18,2) COMMENT 'The pH value of the water sample at the time of collection, which influences DBP speciation and formation. Ref: EPA SDWA.',
    `reported_to_state_date` DATE COMMENT 'The date when this monitoring event result was reported to the state primacy agency. Ref: EPA SDWA.',
    `reported_to_state_flag` BOOLEAN COMMENT 'Indicates whether this monitoring event result has been reported to the state primacy agency. Ref: EPA SDWA.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'The precise date and time when the DBP water sample was collected from the monitoring point. Ref: EPA SDWA.',
    `sample_type` STRING COMMENT 'Classification of the sample purpose: routine compliance monitoring, confirmation of exceedance, investigative, or special study. Ref: EPA SDWA.. Valid values are `routine|confirmation|investigative|special`',
    `dbp_monitoring_event_status` STRING COMMENT 'The dbp monitoring event status value recorded for each dbp monitoring event in the quality domain.',
    `system_wide_haa5_raa_ug_l` DECIMAL(18,2) COMMENT 'The system-wide running annual average of HAA5 concentrations across all monitoring points, used for overall system compliance assessment. Ref: EPA SDWA.',
    `system_wide_tthm_raa_ug_l` DECIMAL(18,2) COMMENT 'The system-wide running annual average of TTHM concentrations across all monitoring points, used for overall system compliance assessment. Ref: EPA SDWA.',
    `toc_concentration_mg_l` DECIMAL(18,2) COMMENT 'The total organic carbon concentration in milligrams per liter, a key precursor to DBP formation. Ref: EPA SDWA.',
    `total_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'The total chlorine residual measured at the time of sample collection, in milligrams per liter. Ref: EPA SDWA.',
    `trichloroacetic_acid_concentration_ug_l` DECIMAL(18,2) COMMENT 'Measured concentration of trichloroacetic acid (TCAA), a haloacetic acid species, in micrograms per liter. Ref: EPA SDWA.',
    `tthm_compliance_status` STRING COMMENT 'Indicates whether the TTHM LRAA at this monitoring point is in compliance with the MCL. Ref: EPA SDWA.. Valid values are `compliant|non-compliant|pending|under_review`',
    `tthm_concentration_ug_l` DECIMAL(18,2) COMMENT 'Sum of the four trihalomethane species (chloroform, bromodichloromethane, dibromochloromethane, bromoform) in micrograms per liter. Ref: EPA SDWA.',
    `tthm_lraa_ug_l` DECIMAL(18,2) COMMENT 'The locational running annual average of TTHM concentrations at this monitoring point, calculated as the arithmetic average of the current quarter and the previous three quarters. Ref: EPA SDWA.',
    `tthm_mcl_ug_l` DECIMAL(18,2) COMMENT 'The applicable TTHM maximum contaminant level for this monitoring event, typically 80 µg/L under Stage 2 DBPR. Ref: EPA SDWA.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'The water temperature at the time of sample collection in degrees Celsius, which affects DBP formation rates. Ref: EPA SDWA.',
    CONSTRAINT pk_dbp_monitoring_event PRIMARY KEY(`dbp_monitoring_event_id`)
) COMMENT 'Specialized transactional record for Disinfection Byproduct (DBP) monitoring events under Stage 2 DBPR rules. Captures monitoring period, LRAA (Locational Running Annual Average) calculation inputs, THM and HAA5 individual species results (chloroform, bromodichloromethane, dibromochloromethane, bromoform; monochloroacetic acid, dichloroacetic acid, trichloroacetic acid, monobromoacetic acid, dibromoacetic acid), TTHM and HAA5 totals, compliance status, and system-wide running annual average. Distinct from general analytical_result due to LRAA compliance calculation requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` (
    `pfas_monitoring_id` BIGINT COMMENT 'Unique identifier for the pfas monitoring referenced by each pfas monitoring record in the quality domain.',
    `analytical_result_id` BIGINT COMMENT 'FK to the laboratory analytical result record. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each pfas monitoring record in the quality domain.',
    `facility_id` BIGINT COMMENT 'FK to the treatment facility where sample was collected. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'Laboratory-assigned sample identifier for traceability. Ref: EPA SDWA.',
    `laboratory_id` BIGINT COMMENT 'Identifier of the certified laboratory performing the PFAS analysis. Ref: EPA SDWA.',
    `pfas_compound_id` BIGINT COMMENT 'Unique identifier for the pfas compound referenced by each pfas monitoring record in the quality domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the pfas created by employee referenced by each pfas monitoring record in the quality domain.',
    `pfas_employee_id` BIGINT COMMENT 'Foreign key to workforce.employee; identifies the employee who performed the PFAS monitoring calibration or sampling event. Ref: EPA SDWA.',
    `pfas_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the pfas responsible employee referenced by each pfas monitoring record in the quality domain.',
    `qaqc_batch_id` BIGINT COMMENT 'FK to the QA/QC batch for this analysis. Ref: EPA SDWA.',
    `laboratory_corrective_action_id` BIGINT COMMENT 'FK to corrective action record if treatment response initiated. Ref: EPA SDWA.',
    `quality_public_notification_id` BIGINT COMMENT 'FK to public notification record if notification was issued. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each pfas monitoring record in the quality domain.',
    `sampling_schedule_id` BIGINT COMMENT 'Unique identifier for the sampling schedule referenced by each pfas monitoring record in the quality domain.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each pfas monitoring record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'FK to the public water system (PWSID) under monitoring. Ref: EPA SDWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each pfas monitoring in the quality domain.',
    `analysis_date` TIMESTAMP COMMENT 'Date the laboratory completed PFAS analysis (EPA Method 533 or 537.1). Ref: EPA SDWA.',
    `analytical_method` STRING COMMENT 'Laboratory analytical method used (e.g., EPA 533, EPA 537.1, ISO 21675).',
    `breakthrough_predicted_flag` BOOLEAN COMMENT 'Indicates whether AI/ML model predicts PFAS breakthrough before next scheduled sampling event. Ref: EPA SDWA.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number for the PFAS compound. Ref: EPA SDWA.',
    `pfas_monitoring_category` STRING COMMENT 'The pfas monitoring category value recorded for each pfas monitoring in the quality domain.',
    `chain_length_class` STRING COMMENT 'Classification: LONG_CHAIN (>=6 carbons) or SHORT_CHAIN (<6 carbons). Ref: EPA SDWA.',
    `classification` STRING COMMENT 'The classification value recorded for each pfas monitoring in the quality domain.',
    `pfas_monitoring_code` STRING COMMENT 'The pfas monitoring code value recorded for each pfas monitoring in the quality domain.',
    `comments` STRING COMMENT 'Free-text comments on the monitoring result. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each pfas monitoring in the quality domain.',
    `compound_code` STRING COMMENT 'Standard code for the PFAS compound (e.g., PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA). Ref: EPA SDWA.',
    `compound_name` STRING COMMENT 'Full chemical name of the PFAS compound. Ref: EPA SDWA.',
    `confirmation_sample_required_flag` BOOLEAN COMMENT 'Indicates whether a confirmation sample is required per initial monitoring protocol. Ref: EPA SDWA.',
    `created_at` TIMESTAMP COMMENT 'The created at associated with each pfas monitoring record in the quality domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `cumulative_hazard_index` DECIMAL(18,2) COMMENT 'Sum of hazard quotients for PFNA+PFHxS+PFBS+HFPO-DA; MCL is 1.0. Ref: EPA SDWA.',
    `data_quality_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the result passed QA/QC validation checks. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each pfas monitoring in the quality domain.',
    `data_validation_level` STRING COMMENT 'Level of data validation applied: raw, preliminary, validated, definitive. Ref: EPA SDWA.',
    `pfas_monitoring_description` STRING COMMENT 'The pfas monitoring description value recorded for each pfas monitoring in the quality domain.',
    `detection_limit_ng_l` DECIMAL(18,2) COMMENT 'Method detection limit for the specific PFAS compound in nanograms per liter. Ref: EPA SDWA.',
    `detection_limit_ppt` DECIMAL(18,2) COMMENT 'Method detection limit for the PFAS compound in ppt. Ref: EPA SDWA.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Sample dilution factor applied during analysis. Ref: EPA SDWA.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each pfas monitoring record in the quality domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each pfas monitoring record in the quality domain.',
    `eu_directive_reference` STRING COMMENT 'EU directive reference (Drinking Water Directive 2020/2184, WFD 2000/60/EC, UWWTD 91/271/EEC, REACH PFAS restriction). Ref: EPA SDWA.',
    `eu_dwd_compliance_status` STRING COMMENT 'Compliance status against EU Drinking Water Directive 2020/2184 PFAS parametric values. Ref: EPA SDWA.',
    `eu_limit_ng_l` DECIMAL(18,2) COMMENT 'EU parametric value: 100 ng/L for sum-of-20, 500 ng/L for total PFAS. Ref: EPA SDWA.',
    `eu_pfas_total_member_flag` BOOLEAN COMMENT 'Indicates if compound counts toward EU total PFAS limit (500 ng/L). Ref: EPA SDWA.',
    `eu_reach_restriction_reference` STRING COMMENT 'REACH PFAS restriction reference; EU DWD 2020/2184 sum-of-20 basis. Ref: EPA SDWA.',
    `eu_sum_of_20_contribution_flag` BOOLEAN COMMENT 'Whether this compound is included in the EU Drinking Water Directive 2020/2184 sum-of-20 PFAS parameter (100 ng/L limit). Ref: EPA SDWA.',
    `eu_sum_of_20_member` BOOLEAN COMMENT 'The eu sum of 20 member value recorded for each pfas monitoring in the quality domain.',
    `eu_sum_of_20_member_flag` BOOLEAN COMMENT 'Indicates if compound is part of EU Drinking Water Directive 2020/2184 sum-of-20 PFAS. Ref: EPA SDWA.',
    `eu_sum_of_20_ng_l` DECIMAL(18,2) COMMENT 'EU DWD sum of 20 PFAS ng/L. Ref: EPA SDWA.',
    `eu_total_pfas_contribution_flag` BOOLEAN COMMENT 'Whether this compound contributes to the EU total PFAS parameter (500 ng/L limit per DWD 2020/2184). Ref: EPA SDWA.',
    `exceedance_flag` BOOLEAN COMMENT 'Whether any PFAS compound exceeded regulatory limit. Ref: EPA SDWA.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each pfas monitoring record in the quality domain.',
    `exposure_pathway_code` BIGINT COMMENT 'FK to exposure pathway entity capturing human/ecological exposure routes (ingestion, dermal, inhalation) for PFAS risk assessment. Ref: EPA SDWA.',
    `exposure_pathway_type` STRING COMMENT 'The exposure pathway type value recorded for each pfas monitoring in the quality domain.',
    `gac_bed_volumes_treated` DECIMAL(18,2) COMMENT 'Number of bed volumes treated since last GAC media replacement, relevant for breakthrough prediction. Ref: EPA SDWA.',
    `hazard_index` DECIMAL(18,2) COMMENT 'Calculated hazard index for the mixture of PFNA, PFHxS, PFBS, and HFPO-DA/GenX per EPA NPDWR. HI >= 1.0 indicates MCL exceedance.',
    `hazard_index_compliance_status` STRING COMMENT 'Compliance status for the hazard index mixture MCL: COMPLIANT (HI<=1.0) or EXCEEDS (HI>1.0). Ref: EPA SDWA.',
    `hazard_index_contribution` DECIMAL(18,2) COMMENT 'This compounds contribution to the hazard index (result_value / HBWC). Applies to PFNA, PFHxS, PFBS, HFPO-DA per EPA mixture rule. Ref: EPA SDWA.',
    `hazard_index_exceedance_flag` BOOLEAN COMMENT 'Indicates whether cumulative hazard index exceeds 1.0. Ref: EPA SDWA.',
    `hazard_index_member_flag` BOOLEAN COMMENT 'Indicates if compound is part of EPA hazard index calculation (PFNA, PFHxS, PFBS, HFPO-DA). Ref: EPA SDWA.',
    `hazard_index_total` DECIMAL(18,2) COMMENT 'Cumulative hazard index for the mixture of PFNA+PFHxS+PFBS+HFPO-DA. MCL is 1.0 (unitless). Ref: EPA SDWA.',
    `hazard_index_value` DECIMAL(18,2) COMMENT 'Sum of PFNA+PFHxS+PFBS+HFPO-DA hazard quotients. Ref: EPA SDWA.',
    `hazard_quotient` DECIMAL(18,2) COMMENT 'Individual hazard quotient = result / HBWC for hazard index calculation. Ref: EPA SDWA.',
    `hbwc_ng_l` DECIMAL(18,2) COMMENT 'Health-Based Water Concentration used as denominator in hazard quotient. Ref: EPA SDWA.',
    `health_based_water_concentration_ppt` DECIMAL(18,2) COMMENT 'Health-Based Water Concentration used as denominator in hazard index calculation for this compound. Ref: EPA SDWA.',
    `hfpo_da_genx_concentration_ng_l` STRING COMMENT 'The hfpo da genx concentration ng l value recorded for each pfas monitoring in the quality domain.',
    `hfpo_da_genx_ng_l` DECIMAL(18,2) COMMENT 'Hexafluoropropylene oxide dimer acid (HFPO-DA/GenX) concentration in nanograms per liter. US EPA MCL = 10.0 ng/L. Included in hazard index. Ref: EPA SDWA.',
    `hfpo_da_genx_ng_per_l` DECIMAL(18,2) COMMENT 'PFAS compound-level measurement attribute. Ref: EPA SDWA.',
    `hfpo_da_genx_result_ng_l` DECIMAL(18,2) COMMENT 'Hexafluoropropylene oxide dimer acid (HFPO-DA/GenX) result in ng/L. Ref: EPA SDWA.',
    `hfpo_da_ng_l` DECIMAL(18,2) COMMENT 'The hfpo da ng l value recorded for each pfas monitoring in the quality domain.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the pfas monitoring record.',
    `is_detected` BOOLEAN COMMENT 'Indicates whether the PFAS compound was detected above the detection limit. Ref: EPA SDWA.',
    `is_initial_monitoring` BOOLEAN COMMENT 'Whether this is part of initial monitoring (first 3 years) vs ongoing compliance monitoring. Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'The jurisdiction value recorded for each pfas monitoring in the quality domain.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction code (e.g., US_EPA, EU_DWD, UK_DWI, DE_UBA, FR_ANSES) for multi-region compliance. Ref: EPA SDWA.',
    `laboratory_accreditation_number` STRING COMMENT 'Accreditation number of the laboratory for PFAS methods. Ref: EPA SDWA.',
    `laboratory_analysis_date` DATE COMMENT 'Date laboratory analysis was completed. Ref: EPA SDWA.',
    `mcl_compliance_status` STRING COMMENT 'The mcl compliance status value recorded for each pfas monitoring in the quality domain.',
    `mcl_exceedance_flag` BOOLEAN COMMENT 'Indicates whether the result exceeds the applicable MCL. Ref: EPA SDWA.',
    `mcl_value_ppt` DECIMAL(18,2) COMMENT 'Maximum Contaminant Level for this PFAS compound in ppt (e.g., 4.0 for PFOA, 4.0 for PFOS per 2024 EPA NPDWR).',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last-modified timestamp. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'Required monitoring frequency: quarterly, annual, triennial per EPA PFAS NPDWR.',
    `monitoring_number` STRING COMMENT 'The monitoring number value recorded for each pfas monitoring in the quality domain.',
    `monitoring_period` STRING COMMENT 'The monitoring period value recorded for each pfas monitoring in the quality domain.',
    `monitoring_period_end` DATE COMMENT 'End date of the PFAS monitoring period per regulatory schedule. Ref: EPA SDWA.',
    `monitoring_period_end_date` TIMESTAMP COMMENT 'The monitoring period end date associated with each pfas monitoring record in the quality domain.',
    `monitoring_period_start` DATE COMMENT 'Start date of the PFAS monitoring period per regulatory schedule. Ref: EPA SDWA.',
    `monitoring_period_start_date` TIMESTAMP COMMENT 'The monitoring period start date associated with each pfas monitoring record in the quality domain.',
    `pfas_monitoring_name` STRING COMMENT 'The pfas monitoring name used to identify each pfas monitoring record in the quality domain.',
    `non_detect_flag` BOOLEAN COMMENT 'Whether the result is a non-detect (below method detection limit). Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes regarding the PFAS monitoring result. Ref: EPA SDWA.',
    `notification_date` DATE COMMENT 'Date regulatory agency was notified. Ref: EPA SDWA.',
    `ontology_class_uri` STRING COMMENT 'URI reference to OWL ontology class (e.g., OntoBricks water utility ontology) for semantic validation and conceptual completeness checking. Ref: EPA SDWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each pfas monitoring in the quality domain.',
    `pfas_chain_classification` STRING COMMENT 'Classification as long-chain or short-chain PFAS per OECD definitions. Ref: EPA SDWA.',
    `pfas_compound_cas_number` STRING COMMENT 'Chemical Abstracts Service registry number for the PFAS compound. Ref: EPA SDWA.',
    `pfas_compound_name` STRING COMMENT 'Name of the specific PFAS compound measured (e.g., PFOA, PFOS, PFNA, PFHxS, PFBS, HFPO-DA/GenX). Ref: EPA SDWA.',
    `pfas_monitoring_number` STRING COMMENT 'The pfas monitoring number value recorded for each pfas monitoring in the quality domain.',
    `pfas_monitoring_status` STRING COMMENT 'The pfas monitoring status value recorded for each pfas monitoring in the quality domain.',
    `pfas_monitoring_type` STRING COMMENT 'The pfas monitoring type value recorded for each pfas monitoring in the quality domain.',
    `pfas_sum_of_20_ug_l` DECIMAL(18,2) COMMENT 'Sum of 20 specified PFAS substances in micrograms per liter per EU DWD 2020/2184 parametric value of 0.10 ug/L. Ref: EPA SDWA.',
    `pfas_total_ug_l` DECIMAL(18,2) COMMENT 'Total PFAS concentration in micrograms per liter per EU Drinking Water Directive 2020/2184 parametric value of 0.50 ug/L for PFAS total. Ref: EPA SDWA.',
    `pfbs_concentration_ng_l` STRING COMMENT 'The pfbs concentration ng l value recorded for each pfas monitoring in the quality domain.',
    `pfbs_ng_l` DECIMAL(18,2) COMMENT 'Perfluorobutane sulfonic acid (PFBS) concentration in nanograms per liter. Short-chain PFAS included in EPA hazard index. Ref: EPA SDWA.',
    `pfbs_ng_per_l` DECIMAL(18,2) COMMENT 'PFAS compound-level measurement attribute. Ref: EPA SDWA.',
    `pfbs_result_ng_l` DECIMAL(18,2) COMMENT 'Perfluorobutane sulfonic acid (PFBS) result in ng/L. Ref: EPA SDWA.',
    `pfhxs_concentration_ng_l` STRING COMMENT 'The pfhxs concentration ng l value recorded for each pfas monitoring in the quality domain.',
    `pfhxs_ng_l` DECIMAL(18,2) COMMENT 'Perfluorohexane sulfonic acid (PFHxS) concentration in nanograms per liter. Included in EPA hazard index mixture. Ref: EPA SDWA.',
    `pfhxs_ng_per_l` DECIMAL(18,2) COMMENT 'PFAS compound-level measurement attribute. Ref: EPA SDWA.',
    `pfhxs_result_ng_l` DECIMAL(18,2) COMMENT 'Perfluorohexane sulfonic acid (PFHxS) result in ng/L. Ref: EPA SDWA.',
    `pfna_concentration_ng_l` STRING COMMENT 'The pfna concentration ng l value recorded for each pfas monitoring in the quality domain.',
    `pfna_ng_l` DECIMAL(18,2) COMMENT 'Perfluorononanoic acid (PFNA) concentration in nanograms per liter. Included in EPA hazard index mixture. Ref: EPA SDWA.',
    `pfna_ng_per_l` DECIMAL(18,2) COMMENT 'PFAS compound-level measurement attribute. Ref: EPA SDWA.',
    `pfna_result_ng_l` DECIMAL(18,2) COMMENT 'Perfluorononanoic acid (PFNA) result in ng/L. Ref: EPA SDWA.',
    `pfoa_concentration_ng_l` STRING COMMENT 'The pfoa concentration ng l value recorded for each pfas monitoring in the quality domain.',
    `pfoa_ng_l` DECIMAL(18,2) COMMENT 'Perfluorooctanoic acid (PFOA) concentration in nanograms per liter. US EPA MCL = 4.0 ng/L. Ref: EPA SDWA.',
    `pfoa_ng_per_l` DECIMAL(18,2) COMMENT 'PFAS compound-level measurement attribute. Ref: EPA SDWA.',
    `pfoa_result_ng_l` DECIMAL(18,2) COMMENT 'Perfluorooctanoic acid (PFOA) result in ng/L. Ref: EPA SDWA.',
    `pfos_concentration_ng_l` STRING COMMENT 'The pfos concentration ng l value recorded for each pfas monitoring in the quality domain.',
    `pfos_ng_l` DECIMAL(18,2) COMMENT 'Perfluorooctane sulfonic acid (PFOS) concentration in nanograms per liter. US EPA MCL = 4.0 ng/L. Ref: EPA SDWA.',
    `pfos_ng_per_l` DECIMAL(18,2) COMMENT 'PFAS compound-level measurement attribute. Ref: EPA SDWA.',
    `pfos_result_ng_l` DECIMAL(18,2) COMMENT 'Perfluorooctane sulfonic acid (PFOS) result in ng/L. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each pfas monitoring in the quality domain.',
    `public_notification_required` BOOLEAN COMMENT 'Indicates if MCL exceedance requires public notification. Ref: EPA SDWA.',
    `pwsid` STRING COMMENT 'Public Water System Identifier for regulatory reporting. Ref: EPA SDWA.',
    `qualifier_code` STRING COMMENT 'Data qualifier (e.g., U=non-detect, J=estimated, B=blank contamination). Ref: EPA SDWA.',
    `quality_control_flag` BOOLEAN COMMENT 'QC flag indicating data quality issues. Ref: EPA SDWA.',
    `quantitation_limit_ppt` DECIMAL(18,2) COMMENT 'Practical quantitation limit (PQL) for the PFAS compound in ppt. Ref: EPA SDWA.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each pfas monitoring in the quality domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each pfas monitoring in the quality domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each pfas monitoring in the quality domain.',
    `regulatory_agency_notified` BOOLEAN COMMENT 'Whether regulatory agency was notified of results. Ref: EPA SDWA.',
    `regulatory_directive_reference` STRING COMMENT 'The regulatory directive reference value recorded for each pfas monitoring in the quality domain.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework value recorded for each pfas monitoring in the quality domain.',
    `regulatory_framework_reference` STRING COMMENT 'Citation of the governing regulatory framework or directive. Ref: EPA SDWA.',
    `regulatory_limit_ng_l` STRING COMMENT 'Applicable regulatory limit in ng/L. Ref: EPA SDWA.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each pfas monitoring in the quality domain.',
    `regulatory_region` STRING COMMENT 'Regulatory region or member state. Ref: EPA SDWA.',
    `regulatory_region_code` STRING COMMENT 'ISO/region code for the regulatory region (US, EU, UK, FR, DE).',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates if result has been submitted to regulatory agency. Ref: EPA SDWA.',
    `reported_to_state_date` TIMESTAMP COMMENT 'Date the result was reported to the state primacy agency. Ref: EPA SDWA.',
    `reporting_limit_ng_l` DECIMAL(18,2) COMMENT 'Practical quantitation limit / reporting limit in nanograms per liter. Ref: EPA SDWA.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each pfas monitoring record in the quality domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each pfas monitoring in the quality domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each pfas monitoring in the quality domain.',
    `result_qualifier` STRING COMMENT 'Data qualifier flag (e.g., U=non-detect, J=estimated, B=blank contamination). Ref: EPA SDWA.',
    `result_status` STRING COMMENT 'Status of the monitoring result: pending, validated, reported, rejected. Ref: EPA SDWA.',
    `result_value_ng_l` DECIMAL(18,2) COMMENT 'Measured concentration of the PFAS compound in nanograms per liter. Ref: EPA SDWA.',
    `result_value_ppt` DECIMAL(18,2) COMMENT 'Measured concentration of the PFAS compound in parts per trillion (ng/L). Ref: EPA SDWA.',
    `risk_receptor_code` BIGINT COMMENT 'FK to risk receptor entity (human populations, aquatic life, terrestrial ecosystems) for PFAS exposure modeling. Ref: EPA SDWA.',
    `sample_collection_date` TIMESTAMP COMMENT 'Date the PFAS sample was physically collected at the sampling point. Ref: EPA SDWA.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'Precise timestamp of PFAS sample collection. Ref: EPA SDWA.',
    `sample_date` TIMESTAMP COMMENT 'Date when the PFAS sample was collected. Ref: EPA SDWA.',
    `sample_location_description` STRING COMMENT 'Description of sampling location (entry point, distribution, source). Ref: EPA SDWA.',
    `sample_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the PFAS sample was collected. Ref: EPA SDWA.',
    `sample_type` STRING COMMENT 'Type of sample: ROUTINE, CONFIRMATION, TRIGGERED, COMPLIANCE. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each pfas monitoring record in the quality domain.',
    `state_submission_flag` BOOLEAN COMMENT 'Indicates if result was submitted to state drinking water program. Ref: EPA SDWA.',
    `total_pfas_concentration_ng_l` STRING COMMENT 'Total PFAS concentration in ng/L. Ref: EPA SDWA.',
    `treatment_response_threshold_ng_l` DECIMAL(18,2) COMMENT 'Utility-defined threshold that triggers treatment response. Ref: EPA SDWA.',
    `treatment_response_trigger_flag` BOOLEAN COMMENT 'Indicates whether the result triggers a treatment response action (e.g., GAC replacement, IX resin change-out). Ref: EPA SDWA.',
    `treatment_response_trigger_status` STRING COMMENT 'Whether treatment response is triggered. Ref: EPA SDWA.',
    `treatment_response_triggered` BOOLEAN COMMENT 'The treatment response triggered value recorded for each pfas monitoring in the quality domain.',
    `treatment_response_triggered_flag` BOOLEAN COMMENT 'The treatment response triggered flag value recorded for each pfas monitoring in the quality domain.',
    `treatment_technology` STRING COMMENT 'Treatment technology in place at sampling point (e.g., GAC, IX, RO, nanofiltration). Ref: EPA SDWA.',
    `treatment_technology_code` BIGINT COMMENT 'FK to treatment technology master (GAC, ion exchange, multimedia sand filter, reverse osmosis) for PFAS removal response. Ref: EPA SDWA.',
    `treatment_technology_recommended` STRING COMMENT 'Recommended treatment: GAC, ION_EXCHANGE, NANOFILTRATION, REVERSE_OSMOSIS. Ref: EPA SDWA.',
    `treatment_technology_type` STRING COMMENT 'PFAS treatment technology in place: GAC, ion_exchange, nanofiltration, reverse_osmosis, HFPO_DA_specific. Ref: EPA SDWA.',
    `trigger_level_ppt` DECIMAL(18,2) COMMENT 'Utility-defined trigger level for treatment action (typically set below MCL as early warning). Ref: EPA SDWA.',
    `ucmr5_submission_flag` BOOLEAN COMMENT 'Indicates if result was submitted under EPA UCMR5 monitoring. Ref: EPA SDWA.',
    `ucmr_reporting_flag` BOOLEAN COMMENT 'Whether this result is reportable under UCMR5 unregulated contaminant monitoring. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each pfas monitoring in the quality domain.',
    `updated_at` TIMESTAMP COMMENT 'The updated at associated with each pfas monitoring record in the quality domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each pfas monitoring record in the quality domain.',
    `us_hazard_index_member` BOOLEAN COMMENT 'The us hazard index member value recorded for each pfas monitoring in the quality domain.',
    `us_mcl_ng_l` DECIMAL(18,2) COMMENT 'US EPA Maximum Contaminant Level for this compound in ng/L (4.0 for PFOA/PFOS per 2024 NPDWR)',
    `us_per_compound_mcl_ng_l` DECIMAL(18,2) COMMENT 'The us per compound mcl ng l value recorded for each pfas monitoring in the quality domain.',
    `validation_status` STRING COMMENT 'Data validation status: PRELIMINARY, VALIDATED, REJECTED. Ref: EPA SDWA.',
    CONSTRAINT pk_pfas_monitoring PRIMARY KEY(`pfas_monitoring_id`)
) COMMENT 'Tracks individual PFAS compound monitoring results including PFOA, PFOS, PFNA, PFHxS, PFBS, and HFPO-DA (GenX). Calculates hazard index for PFNA+PFHxS+PFBS+HFPO-DA per EPA PFAS NPDWR. Records MCL compliance status, monitoring period, sampling point, treatment response triggers, and supports both US EPA SDWA PFAS regulations and EU Drinking Water Directive 2020/2184 sum-of-20 and total PFAS limits. Links to water samples, analytical results, and treatment technology responses (GAC, ion exchange, RO). Supports UCMR5 reporting and state-specific PFAS monitoring requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` (
    `turbidity_reading_id` BIGINT COMMENT 'Unique identifier for the turbidity measurement record. Primary key. Ref: OSIsoft PI Historian.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: Distribution system turbidity monitoring points may co-locate with AMI endpoints to correlate water quality events with flow/pressure anomalies. Business process: main break detection, water quality e. Ref: OSIsoft PI Historian.',
    `analytical_result_id` BIGINT COMMENT 'Unique identifier linking the turbidity reading to a laboratory analysis record in the Laboratory Information Management System (LIMS), if the reading was obtained through laboratory testing. Ref: OSIsoft PI Historian.',
    `analytical_test_id` BIGINT COMMENT 'Unique identifier linking the turbidity reading to a laboratory analysis record in the Laboratory Information Management System (LIMS), if the reading was obtained through laboratory testing. Ref: OSIsoft PI Historian.',
    `chain_of_custody_id` BIGINT COMMENT 'Unique identifier for the chain of custody documentation associated with the sample, ensuring traceability and integrity for regulatory compliance. Ref: OSIsoft PI Historian.',
    `online_instrument_id` BIGINT COMMENT 'Unique identifier of the turbidity monitoring instrument or analyzer that captured the reading. Ref: OSIsoft PI Historian.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier of the physical sampling location or monitoring point within the treatment plant or distribution system where the turbidity reading was captured. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the certified water treatment plant operator or laboratory technician who collected or validated the turbidity reading. Ref: OSIsoft PI Historian.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the Water Treatment Plant where the turbidity measurement was recorded. Ref: OSIsoft PI Historian.',
    `turbidity_operator_employee_id` BIGINT COMMENT 'Unique identifier of the certified water treatment plant operator or laboratory technician who collected or validated the turbidity reading. Ref: OSIsoft PI Historian.',
    `turbidity_wtp_facility_id` BIGINT COMMENT 'Unique identifier of the Water Treatment Plant where the turbidity measurement was recorded. Ref: OSIsoft PI Historian.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each turbidity reading record in the quality domain.',
    `alarm_threshold_ntu` DECIMAL(18,2) COMMENT 'The turbidity threshold value in NTU configured in the SCADA system that triggers an operational alarm when exceeded. Ref: OSIsoft PI Historian.',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the turbidity reading triggered an automated alarm in the SCADA system due to exceeding a predefined threshold. Ref: OSIsoft PI Historian.',
    `calibration_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent calibration performed on the turbidity instrument prior to this reading. Ref: OSIsoft PI Historian.',
    `turbidity_reading_code` STRING COMMENT 'The turbidity reading code value recorded for each turbidity reading in the quality domain.',
    `compliance_status` STRING COMMENT 'The compliance status of the turbidity reading relative to regulatory requirements, indicating whether the reading meets Surface Water Treatment Rule standards. Ref: OSIsoft PI Historian.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action taken by plant operators in response to the turbidity reading, such as filter backwash, chemical dosage adjustment, or process shutdown. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each turbidity reading record in the quality domain.',
    `ct_compliance_context` STRING COMMENT 'Contextual information linking the turbidity reading to disinfection Contact Time (CT) compliance calculations, indicating whether the reading impacts CT credit eligibility under the Surface Water Treatment Rule. Ref: OSIsoft PI Historian.',
    `data_quality_code` STRING COMMENT 'Code indicating the quality and reliability of the turbidity reading, including flags for suspect data, instrument faults, calibration status, or manual overrides. Ref: OSIsoft PI Historian.. Valid values are `valid|suspect|invalid|calibration_due|instrument_fault|manual_override`',
    `data_source_system` STRING COMMENT 'The source system from which the turbidity reading was ingested into the lakehouse: OSIsoft PI Historian, LIMS, manual entry, or direct SCADA feed.. Valid values are `pi_historian|lims|manual_entry|scada_direct`',
    `turbidity_reading_description` STRING COMMENT 'The turbidity reading description value recorded for each turbidity reading in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each turbidity reading record in the quality domain.',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the turbidity reading exceeded the regulatory Maximum Contaminant Level (MCL) or treatment technique requirement under the Surface Water Treatment Rule. Ref: OSIsoft PI Historian.',
    `filter_unit_number` STRING COMMENT 'Identifier of the specific filter unit at the Water Treatment Plant (WTP) from which the turbidity reading was captured. Applicable for Individual Filter Effluent (IFE) measurements. Ref: OSIsoft PI Historian.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'The flow rate through the filter or treatment process at the time of the turbidity measurement, expressed in Million Gallons per Day (MGD). Ref: OSIsoft PI Historian.',
    `measurement_location_type` STRING COMMENT 'Designation of where in the treatment process the turbidity measurement was taken: Individual Filter Effluent (IFE), Combined Filter Effluent (CFE), distribution system entry point, raw water intake, settled water, or filtered water. Ref: OSIsoft PI Historian.. Valid values are `ife|cfe|distribution_entry|raw_water|settled_water|filtered_water`',
    `measurement_method` STRING COMMENT 'The method used to capture the turbidity measurement, indicating whether it was a continuous online reading, grab sample, or laboratory analysis. Ref: OSIsoft PI Historian.. Valid values are `nephelometric|continuous_online|grab_sample|laboratory`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the turbidity measurement was captured by the instrument or collected as a grab sample. Ref: OSIsoft PI Historian.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each turbidity reading record in the quality domain.',
    `turbidity_reading_name` STRING COMMENT 'The turbidity reading name used to identify each turbidity reading record in the quality domain.',
    `notes` STRING COMMENT 'Free-text field for operator or analyst notes regarding the turbidity reading, including contextual information, anomalies, or special conditions. Ref: OSIsoft PI Historian.',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag name associated with the turbidity measurement point, used for SCADA data integration and historical trending.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbidity reading record was first created in the lakehouse silver layer. Ref: OSIsoft PI Historian.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbidity reading record was last updated in the lakehouse silver layer. Ref: OSIsoft PI Historian.',
    `regulatory_limit_ntu` DECIMAL(18,2) COMMENT 'The applicable regulatory turbidity limit in NTU for the measurement location and context, as defined by the Surface Water Treatment Rule or state primacy agency requirements. Ref: OSIsoft PI Historian.',
    `reporting_period` STRING COMMENT 'The regulatory reporting period (e.g., monthly, quarterly) to which this turbidity reading applies for compliance reporting purposes. Ref: OSIsoft PI Historian.',
    `sample_collection_method` STRING COMMENT 'Method by which the water sample was collected for turbidity analysis: automated continuous monitoring, manual grab sample, or composite sample. Ref: OSIsoft PI Historian.. Valid values are `automated|manual_grab|composite`',
    `turbidity_reading_status` STRING COMMENT 'The turbidity reading status value recorded for each turbidity reading in the quality domain.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the water sample at the time of turbidity measurement, expressed in degrees Celsius. Temperature can affect turbidity readings and is recorded for quality assurance. Ref: OSIsoft PI Historian.',
    `turbidity_value_ntu` DECIMAL(18,2) COMMENT 'The measured turbidity value expressed in Nephelometric Turbidity Units (NTU), representing the cloudiness or haziness of the water sample. Ref: OSIsoft PI Historian.',
    CONSTRAINT pk_turbidity_reading PRIMARY KEY(`turbidity_reading_id`)
) COMMENT 'High-frequency turbidity monitoring records from continuous online instruments and grab samples at WTP filter effluents, combined filter effluent, and distribution entry points. Captures NTU value, measurement timestamp, instrument ID, measurement method (nephelometric), filter unit number, CT compliance context, IFE (Individual Filter Effluent) vs CFE (Combined Filter Effluent) designation, and exceedance flag against Surface Water Treatment Rule turbidity limits. Sourced from OSIsoft PI Historian via SCADA integration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` (
    `ct_calculation_id` BIGINT COMMENT 'Unique identifier for the CT calculation record. Primary key. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CT calculations are part of disinfection operations; associated costs (SCADA systems, operator time, validation) are allocated to treatment cost centers for operational budgeting and rate case cost-of. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the certified water treatment plant operator who reviewed or validated the CT calculation. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the water treatment plant where this CT calculation was performed. Ref: EPA SDWA.',
    `ct_operator_employee_id` BIGINT COMMENT 'Foreign key reference to the certified water treatment plant operator who reviewed or validated the CT calculation. Ref: EPA SDWA.',
    `ct_wtp_facility_id` BIGINT COMMENT 'Foreign key reference to the water treatment plant where this CT calculation was performed. Ref: EPA SDWA.',
    `process_unit_id` BIGINT COMMENT 'Foreign key reference to the specific disinfection process unit or stage within the WTP. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: CT calculations are performed at specific measurement points in the disinfection process. Currently has measurement_point_location as a STRING. Adding sampling_point_id normalizes this to reference th. Ref: EPA SDWA.',
    `turbidity_reading_id` BIGINT COMMENT 'Foreign key linking to quality.turbidity_reading. Business justification: CT calculations use turbidity as a key input parameter (CT credit depends on turbidity levels). Currently has turbidity_ntu as a denormalized value. Adding turbidity_reading_id links to the authoritat. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each ct calculation record in the quality domain.',
    `calculated_ct_value_mg_min_l` DECIMAL(18,2) COMMENT 'Calculated CT value (C × T) in mg·min/L. This is the achieved disinfection contact time value. Ref: EPA SDWA.',
    `calculation_method` STRING COMMENT 'Method used to perform the CT calculation. Values: manual (operator calculated), automated_scada (real-time SCADA calculation), pi_calculation (OSIsoft PI calculation), laboratory (lab-based calculation).. Valid values are `manual|automated_scada|pi_calculation|laboratory`',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the CT calculation was performed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Sourced from OSIsoft PI Historian.',
    `ct_calculation_code` STRING COMMENT 'The ct calculation code value recorded for each ct calculation in the quality domain.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the CT calculation. Compliant if both Giardia and virus CT ratios ≥ 1.0. Values: compliant, non_compliant, marginal (close to threshold), under_review. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|marginal|under_review`',
    `contact_chamber_volume_gallons` DECIMAL(18,2) COMMENT 'Volume of the disinfection contact chamber in gallons. Used in conjunction with flow rate to calculate contact time (T). Ref: EPA SDWA.',
    `contact_time_minutes` DECIMAL(18,2) COMMENT 'Measured or calculated contact time (T) in minutes that water is exposed to the disinfectant. This is the T component of the CT calculation. Typically calculated as T10 (time for 10% of water to pass through the contact chamber). Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CT calculation record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Ref: EPA SDWA.',
    `ct_ratio_giardia` DECIMAL(18,2) COMMENT 'Ratio of achieved CT to required CT for Giardia inactivation (calculated_ct_value / required_ct_giardia_3log). Must be ≥ 1.0 for compliance. Ref: EPA SDWA.',
    `ct_ratio_virus` DECIMAL(18,2) COMMENT 'Ratio of achieved CT to required CT for virus inactivation (calculated_ct_value / required_ct_virus_4log). Must be ≥ 1.0 for compliance. Ref: EPA SDWA.',
    `data_quality_flag` BOOLEAN COMMENT 'Flag indicating the quality or reliability of the source data used in the CT calculation. Values: good, suspect (questionable readings), estimated (interpolated values), missing (incomplete data), calibration_due (instrument calibration overdue). Ref: EPA SDWA.',
    `ct_calculation_description` STRING COMMENT 'The ct calculation description value recorded for each ct calculation in the quality domain.',
    `disinfectant_residual_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured disinfectant residual concentration (C) in mg/L at the point of measurement. This is the C component of the CT calculation. Ref: EPA SDWA.',
    `disinfectant_type` STRING COMMENT 'Type of disinfectant used in the treatment process. Values: chlorine, chloramine, ozone, uv (ultraviolet), chlorine_dioxide, mixed_oxidant. Ref: EPA SDWA.. Valid values are `chlorine|chloramine|ozone|uv|chlorine_dioxide|mixed_oxidant`',
    `effective_date` DATE COMMENT 'The effective date associated with each ct calculation record in the quality domain.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Water flow rate through the disinfection process in million gallons per day at the time of calculation. Used to calculate contact time. Ref: EPA SDWA.',
    `log_inactivation_giardia` DECIMAL(18,2) COMMENT 'Calculated log inactivation credit achieved for Giardia based on the CT ratio. Minimum 3-log required by SWTR. Ref: EPA SDWA.',
    `log_inactivation_virus` DECIMAL(18,2) COMMENT 'Calculated log inactivation credit achieved for viruses based on the CT ratio. Minimum 4-log required by SWTR. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CT calculation record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Ref: EPA SDWA.',
    `mor_reporting_period` STRING COMMENT 'Monthly Operating Report period to which this CT calculation applies, in YYYY-MM format. Used for regulatory reporting aggregation. Ref: EPA SDWA.',
    `ct_calculation_name` STRING COMMENT 'The ct calculation name used to identify each ct calculation record in the quality domain.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the CT calculation, including any anomalies, equipment issues, or special conditions observed during the calculation period. Ref: EPA SDWA.',
    `ph_level` DECIMAL(18,2) COMMENT 'pH level of the water at the time of CT calculation. pH affects disinfection efficacy and required CT values per EPA tables. Typical range: 6.5-8.5. Ref: EPA SDWA.',
    `required_ct_giardia_3log_mg_min_l` DECIMAL(18,2) COMMENT 'Required CT value for achieving 3-log (99.9%) inactivation of Giardia lamblia cysts, based on EPA CT tables considering water temperature, pH, and disinfectant type. Ref: EPA SDWA.',
    `required_ct_virus_4log_mg_min_l` DECIMAL(18,2) COMMENT 'Required CT value for achieving 4-log (99.99%) inactivation of viruses, based on EPA CT tables considering water temperature, pH, and disinfectant type. Ref: EPA SDWA.',
    `scada_tag_flow` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the flow rate measurement point.',
    `scada_tag_ph` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the pH measurement point.',
    `scada_tag_residual` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the disinfectant residual concentration measurement point.',
    `scada_tag_temperature` STRING COMMENT 'SCADA tag identifier in OSIsoft PI Historian for the water temperature measurement point.',
    `ct_calculation_status` STRING COMMENT 'The ct calculation status value recorded for each ct calculation in the quality domain.',
    `t10_factor` DECIMAL(18,2) COMMENT 'T10 factor representing the ratio of T10 (time for 10% of water to pass through) to theoretical detention time. Typically determined through tracer studies. Used to calculate effective contact time. Ref: EPA SDWA.',
    `validation_status` STRING COMMENT 'Status of operator or supervisor validation of the CT calculation. Values: pending, validated, rejected, requires_review.. Valid values are `pending|validated|rejected|requires_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the CT calculation was validated by an operator or supervisor. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature in degrees Celsius at the time of CT calculation. Temperature affects disinfection efficacy and required CT values per EPA tables. Ref: EPA SDWA.',
    CONSTRAINT pk_ct_calculation PRIMARY KEY(`ct_calculation_id`)
) COMMENT 'Disinfection CT (Contact Time) calculation records for each WTP disinfection process. Captures calculation date/time, disinfectant type (chlorine, chloramine, ozone, UV), disinfectant residual concentration (C in mg/L), contact time (T in minutes), calculated CT value (mg·min/L), required CT for 3-log Giardia and 4-log virus inactivation, CT ratio (achieved/required), temperature, pH, and compliance status. Sourced from OSIsoft PI Historian. Critical for Surface Water Treatment Rule compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` (
    `residual_chlorine_reading_id` BIGINT COMMENT 'Unique identifier for the residual chlorine reading record. Ref: OSIsoft PI Historian.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: Real-time chlorine residual monitoring at distribution points often co-locates with AMI endpoints for integrated water quality/hydraulic monitoring. Business process: disinfection residual compliance. Ref: OSIsoft PI Historian.',
    `online_instrument_id` BIGINT COMMENT 'Identifier of the field instrument, handheld meter, or SCADA analyzer used to perform the measurement. Used for calibration tracking and data quality assurance. Ref: OSIsoft PI Historian.',
    `process_control_setpoint_id` BIGINT COMMENT 'Foreign key linking to treatment.process_control_setpoint. Business justification: Distribution system chlorine residual measurements are validated against treatment plant process control setpoints. Links field measurement to operational target for disinfection adequacy verification. Ref: OSIsoft PI Historian.',
    `quality_sampling_point_id` BIGINT COMMENT 'Identifier of the location where the chlorine residual sample was collected. Links to distribution system nodes, WTP process points, or WWTP discharge points. Ref: OSIsoft PI Historian.',
    `employee_id` BIGINT COMMENT 'Identifier of the certified water treatment or distribution operator who collected the manual field reading. Required for regulatory compliance and data quality assurance. Ref: OSIsoft PI Historian.',
    `residual_operator_employee_id` BIGINT COMMENT 'Identifier of the certified water treatment or distribution operator who collected the manual field reading. Required for regulatory compliance and data quality assurance. Ref: OSIsoft PI Historian.',
    `sampling_schedule_id` BIGINT COMMENT 'Identifier linking this reading to a planned compliance monitoring schedule. Used to track adherence to regulatory sampling frequency requirements. Ref: OSIsoft PI Historian.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each residual chlorine reading record in the quality domain.',
    `calibration_date` DATE COMMENT 'Date when the measurement instrument was last calibrated. Regular calibration is required for data validity and regulatory compliance. Ref: OSIsoft PI Historian.',
    `residual_chlorine_reading_code` STRING COMMENT 'The residual chlorine reading code value recorded for each residual chlorine reading in the quality domain.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the measured residual meets regulatory minimum requirements. False indicates non-compliance requiring corrective action and potential reporting to primacy agency. Ref: OSIsoft PI Historian.',
    `contact_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time between disinfectant application and this measurement point. Used to calculate CT (concentration × time) for disinfection credit under SWTR. Ref: OSIsoft PI Historian.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken in response to non-compliant or suspect readings. Documents operational response for regulatory reporting and audit trail. Ref: OSIsoft PI Historian.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the reading triggered a need for corrective action such as booster chlorination, system flushing, or regulatory notification. Ref: OSIsoft PI Historian.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each residual chlorine reading record in the quality domain.',
    `data_source` STRING COMMENT 'Origin of the residual chlorine reading. SCADA continuous monitors provide real-time data via PI Historian; manual field readings are collected by operators; lab readings are from grab samples. Ref: OSIsoft PI Historian.. Valid values are `scada_continuous|manual_field|laboratory|ami_sensor`',
    `residual_chlorine_reading_description` STRING COMMENT 'The residual chlorine reading description value recorded for each residual chlorine reading in the quality domain.',
    `disinfectant_type` STRING COMMENT 'Type of disinfectant residual being measured. Free chlorine is the most common primary disinfectant; total chlorine includes both free and combined forms; chloramine is used for secondary disinfection to reduce DBP formation. Ref: OSIsoft PI Historian.. Valid values are `free_chlorine|total_chlorine|chloramine|chlorine_dioxide`',
    `effective_date` DATE COMMENT 'The effective date associated with each residual chlorine reading record in the quality domain.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Water flow rate at the sampling point in gallons per minute. Flow affects contact time and mixing; low flow can lead to stagnation and chlorine loss. Ref: OSIsoft PI Historian.',
    `holding_time_hours` DECIMAL(18,2) COMMENT 'Elapsed time between sample collection and analysis. Chlorine residual must be measured immediately or within 15 minutes to prevent decay and ensure accuracy. Ref: OSIsoft PI Historian.',
    `maximum_allowed_residual_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum Residual Disinfectant Level (MRDL) allowed by EPA. For chlorine and chloramine, MRDL is 4.0 mg/L as annual average; chlorine dioxide MRDL is 0.8 mg/L. Ref: OSIsoft PI Historian.',
    `measurement_method` STRING COMMENT 'Analytical method used to determine chlorine residual. DPD colorimetric is standard for field testing; amperometric is used for precise lab analysis; online analyzers provide continuous SCADA monitoring. Ref: OSIsoft PI Historian.. Valid values are `colorimetric_dpd|amperometric|online_analyzer|test_strip`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the chlorine residual measurement was taken in the field or recorded by SCADA system. Ref: OSIsoft PI Historian.',
    `minimum_required_residual_mg_per_l` DECIMAL(18,2) COMMENT 'Regulatory or operational minimum disinfectant residual threshold applicable at this sampling point. Typically 0.2 mg/L free chlorine at distribution entry point per EPA requirements. Ref: OSIsoft PI Historian.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each residual chlorine reading record in the quality domain.',
    `residual_chlorine_reading_name` STRING COMMENT 'The residual chlorine reading name used to identify each residual chlorine reading record in the quality domain.',
    `notes` STRING COMMENT 'Free-text field for operator observations, unusual conditions, or contextual information relevant to the reading (e.g., recent main break, flushing activity, taste/odor complaints). Ref: OSIsoft PI Historian.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH level of water at sampling point. pH affects chlorine speciation and disinfection effectiveness; optimal range for free chlorine is 6.5-7.5. Ref: OSIsoft PI Historian.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Water pressure at sampling point in pounds per square inch. Pressure fluctuations can indicate system issues affecting water quality and disinfectant distribution. Ref: OSIsoft PI Historian.',
    `quality_control_flag` BOOLEAN COMMENT 'Data quality indicator based on QA/QC review. Suspect or invalid readings may result from instrument malfunction, calibration drift, or sampling error. Ref: OSIsoft PI Historian.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data system. Used for audit trail and data lineage tracking. Ref: OSIsoft PI Historian.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified. Tracks data quality corrections, QC flag updates, or supplemental information additions. Ref: OSIsoft PI Historian.',
    `regulatory_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this reading is part of required regulatory compliance monitoring for state primacy agency or EPA reporting (e.g., MOR, CCR). Ref: OSIsoft PI Historian.',
    `residual_value_mg_per_l` DECIMAL(18,2) COMMENT 'Measured concentration of disinfectant residual in milligrams per liter. EPA requires minimum 0.2 mg/L free chlorine or detectable residual entering distribution system. Ref: OSIsoft PI Historian.',
    `sample_collection_method` STRING COMMENT 'Method by which the water sample was obtained. Grab samples are instantaneous; composite samples are time-weighted; continuous monitors provide real-time streaming data. Ref: OSIsoft PI Historian.. Valid values are `grab_sample|composite_sample|continuous_monitor|inline_sensor`',
    `sample_location_type` STRING COMMENT 'Classification of the sampling point within the water system infrastructure. Critical for compliance monitoring as different locations have different regulatory requirements. Ref: OSIsoft PI Historian.. Valid values are `wtp_clearwell|distribution_entry|distribution_remote|storage_tank|booster_station|wwtp_effluent`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of water sample collected for analysis in milliliters. Standard sample volumes ensure analytical accuracy and method compliance. Ref: OSIsoft PI Historian.',
    `residual_chlorine_reading_status` STRING COMMENT 'The residual chlorine reading status value recorded for each residual chlorine reading in the quality domain.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measurement at sampling point. High turbidity can shield pathogens from disinfectant contact and increase chlorine demand. Ref: OSIsoft PI Historian.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the water sample at time of measurement. Temperature affects chlorine decay rate and disinfection efficacy; warmer water accelerates chlorine loss. Ref: OSIsoft PI Historian.',
    `weather_condition` STRING COMMENT 'Weather conditions at time of field sampling. Extreme weather can affect water quality, chlorine demand, and distribution system hydraulics. Ref: OSIsoft PI Historian.. Valid values are `clear|rain|snow|storm|extreme_heat`',
    CONSTRAINT pk_residual_chlorine_reading PRIMARY KEY(`residual_chlorine_reading_id`)
) COMMENT 'Transactional records of disinfectant residual measurements throughout the distribution system and at WTP/WWTP process points. Captures measurement date/time, sampling point, disinfectant type (free chlorine, total chlorine, chloramine), residual value (mg/L), measurement method (colorimetric, amperometric), field instrument ID, and compliance flag against minimum residual requirements (0.2 mg/L free or detectable). Sourced from both SCADA continuous monitors (PI Historian) and manual field readings.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` (
    `bacteriological_result_id` BIGINT COMMENT 'Unique identifier for the bacteriological test result record. Ref: EPA SDWA.',
    `analytical_test_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_test. Business justification: Bacteriological results must reference laboratorys analytical_test record for method traceability (SM 9223B, Colilert), analyst certification verification, and proficiency testing correlation. Requir. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory supervisor or quality assurance personnel who verified and approved the final result.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the laboratory analyst who performed the bacteriological test. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Bacteriological results are for specific contaminants (total coliform, E. coli, fecal coliform, enterococci, HPC). This FK identifies which contaminant the result applies to, enabling proper linkage t. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bacteriological testing is a major compliance cost with dedicated budget lines; linking to cost_center enables tracking of RTCR compliance costs for budget variance analysis and regulatory cost recove. Ref: EPA SDWA.',
    `primary_bacteriological_employee_id` BIGINT COMMENT 'Reference to the laboratory analyst who performed the bacteriological test. Ref: EPA SDWA.',
    `qaqc_batch_id` BIGINT COMMENT 'Identifier for the quality control batch in which this sample was analyzed, linking to QC blanks, duplicates, and standards. Ref: EPA SDWA.',
    `qc_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.qc_batch. Business justification: Bacteriological results must reference laboratory QC batch for method validation and regulatory defensibility. RTCR compliance requires demonstrating QC acceptance criteria were met for each analytica. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the location where the sample was collected (distribution system tap, treatment plant, reservoir, etc.). Ref: EPA SDWA.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Bacteriological samples (total coliform, E. coli) are collected per RTCR-mandated sampling schedules. Links result to regulatory schedule for compliance tracking, repeat sample triggering, and assessm. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the laboratory that performed the bacteriological analysis. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Reference to the water quality sample that was tested. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each bacteriological result record in the quality domain.',
    `analysis_completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the bacteriological analysis was completed and results were finalized. Ref: EPA SDWA.',
    `analysis_date` DATE COMMENT 'Date when the bacteriological analysis was performed in the laboratory. Ref: EPA SDWA.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The analysis timestamp associated with each bacteriological result record in the quality domain.',
    `analytical_method` STRING COMMENT 'Laboratory analytical method used for bacteriological testing (Membrane Filtration, Colilert, Colisure, MUG, EC-MUG, Multiple Tube Fermentation, Presence-Absence). [ENUM-REF-CANDIDATE: membrane_filtration|colilert|colisure|mug|ec_mug|multiple_tube_fermentation|presence_absence — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `chain_of_custody_number` STRING COMMENT 'Chain of custody tracking number for the sample from collection through analysis, ensuring sample integrity and traceability. Ref: EPA SDWA.',
    `bacteriological_result_code` STRING COMMENT 'The bacteriological result code value recorded for each bacteriological result in the quality domain.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the result (compliant, non-compliant, exceeds MCL, requires repeat sampling, RTCR assessment triggered). Ref: EPA SDWA.. Valid values are `compliant|non_compliant|exceeds_mcl|requires_repeat|assessment_triggered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bacteriological result record was first created in the system. Ref: EPA SDWA.',
    `bacteriological_result_description` STRING COMMENT 'The bacteriological result description value recorded for each bacteriological result in the quality domain.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Dilution factor applied to the sample during analysis, used to calculate final concentration from raw counts. Ref: EPA SDWA.',
    `e_coli_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for E. coli bacteria expressed as Colony Forming Units per 100 mL when membrane filtration method is used. Ref: EPA SDWA.',
    `e_coli_mpn` DECIMAL(18,2) COMMENT 'Quantitative result for E. coli bacteria expressed as Most Probable Number per 100 mL when enumeration method is used. Ref: EPA SDWA.',
    `e_coli_result` STRING COMMENT 'Presence or absence result for E. coli bacteria in the sample. Ref: EPA SDWA.. Valid values are `present|absent`',
    `ecoli_result` STRING COMMENT 'The ecoli result value recorded for each bacteriological result in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each bacteriological result record in the quality domain.',
    `enterococci_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for enterococci bacteria expressed as Colony Forming Units per 100 mL. Ref: EPA SDWA.',
    `enterococci_result` STRING COMMENT 'Presence or absence result for enterococci bacteria, typically used for wastewater and recreational water monitoring. Ref: EPA SDWA.. Valid values are `present|absent`',
    `fecal_coliform_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for fecal coliform bacteria expressed as Colony Forming Units per 100 mL. Ref: EPA SDWA.',
    `fecal_coliform_result` STRING COMMENT 'Presence or absence result for fecal coliform bacteria in the sample (legacy parameter, replaced by E. coli under RTCR). Ref: EPA SDWA.. Valid values are `present|absent`',
    `hpc_result` DECIMAL(18,2) COMMENT 'Quantitative result for Heterotrophic Plate Count expressed as Colony Forming Units per milliliter (CFU/mL), used to assess general bacterial population and treatment effectiveness. Ref: EPA SDWA.',
    `incubation_duration_hours` DECIMAL(18,2) COMMENT 'Duration in hours for which the sample was incubated during analysis (typically 24 or 48 hours depending on method). Ref: EPA SDWA.',
    `incubation_temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius at which the sample was incubated during analysis (typically 35°C or 44.5°C depending on test type). Ref: EPA SDWA.',
    `invalidation_reason` STRING COMMENT 'Reason for invalidating the test result if result_status is invalidated (e.g., contamination, procedural error, equipment failure). Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bacteriological result record was last modified or updated. Ref: EPA SDWA.',
    `mcl_exceeded_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the result exceeded the Maximum Contaminant Level for the tested parameter. Ref: EPA SDWA.',
    `mcl_violation_flag` BOOLEAN COMMENT 'The mcl violation flag value recorded for each bacteriological result in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each bacteriological result record in the quality domain.',
    `bacteriological_result_name` STRING COMMENT 'The bacteriological result name used to identify each bacteriological result record in the quality domain.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result triggers a public notification requirement under SDWA. Ref: EPA SDWA.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result must be included in regulatory compliance reporting to EPA or state primacy agency. Ref: EPA SDWA.',
    `repeat_sample_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether RTCR requires repeat sampling due to a positive total coliform result. Ref: EPA SDWA.',
    `result_comments` STRING COMMENT 'Free-text comments from the analyst regarding the test result, including observations, anomalies, or special conditions. Ref: EPA SDWA.',
    `result_status` STRING COMMENT 'Current status of the bacteriological test result in the laboratory workflow (preliminary, final, verified, invalidated, pending review). Ref: EPA SDWA.. Valid values are `preliminary|final|verified|invalidated|pending_review`',
    `rtcr_assessment_level` STRING COMMENT 'RTCR assessment level triggered by the result (none, Level 1 Assessment, Level 2 Assessment) based on coliform detection patterns. Ref: EPA SDWA.. Valid values are `none|level_1|level_2`',
    `sample_collection_date` DATE COMMENT 'Date when the water sample was collected from the sampling point. Ref: EPA SDWA.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the water sample was collected, including time of day. Ref: EPA SDWA.',
    `sample_type` STRING COMMENT 'Classification of the sample within the monitoring program (routine, repeat, triggered, investigative, special). Ref: EPA SDWA.. Valid values are `routine|repeat|triggered|investigative|special`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the water sample in milliliters that was analyzed. Ref: EPA SDWA.',
    `bacteriological_result_status` STRING COMMENT 'The bacteriological result status value recorded for each bacteriological result in the quality domain.',
    `test_type` STRING COMMENT 'Type of bacteriological test performed (Total Coliform, E. coli, Fecal Coliform, Heterotrophic Plate Count, Enterococci, or Combined TCR/RTCR). Ref: EPA SDWA.. Valid values are `total_coliform|e_coli|fecal_coliform|hpc|enterococci|combined_tcr`',
    `total_coliform_cfu` DECIMAL(18,2) COMMENT 'Quantitative result for total coliform bacteria expressed as Colony Forming Units per 100 mL when membrane filtration method is used. Ref: EPA SDWA.',
    `total_coliform_mpn` DECIMAL(18,2) COMMENT 'Quantitative result for total coliform bacteria expressed as Most Probable Number per 100 mL when enumeration method is used. Ref: EPA SDWA.',
    `total_coliform_result` STRING COMMENT 'Presence or absence result for total coliform bacteria in the sample. Ref: EPA SDWA.. Valid values are `present|absent`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the result was verified and approved by quality assurance personnel. Ref: EPA SDWA.',
    CONSTRAINT pk_bacteriological_result PRIMARY KEY(`bacteriological_result_id`)
) COMMENT 'Specialized transactional record for bacteriological testing results including Total Coliform Rule (TCR), Revised Total Coliform Rule (RTCR), and E. coli monitoring. Captures sample date, sampling point, total coliform presence/absence or MPN count, E. coli presence/absence, fecal coliform result, HPC (Heterotrophic Plate Count), analytical method (membrane filtration, Colilert), incubation temperature/time, and triggered repeat sampling requirement. Distinct from general analytical_result due to presence/absence reporting and RTCR Level 1/Level 2 assessment triggers.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` (
    `lead_copper_result_id` BIGINT COMMENT 'Unique identifier for the lead and copper sampling result record. Ref: EPA SDWA.',
    `analytical_test_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_test. Business justification: Lead/copper results must reference laboratory analytical_test for method compliance verification (EPA 200.8/200.9), QA/QC acceptance, and 90th percentile calculation defensibility. Required for LCR/LC. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Lead and copper results are for specific contaminants (lead or copper). This FK identifies which contaminant the result applies to, enabling proper linkage to contaminant limits and regulatory require. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lead/copper monitoring involves significant costs (sampling, analysis, customer notification, reporting); utilities track LCR program costs by cost center for compliance budgeting and rate case justif. Ref: EPA SDWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with the sampling site premises. Ref: EPA SDWA.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lead and Copper Rule explicitly requires sampling at customer taps with documented service line materials. Meter installation is the sampling location for tier classification, 90th percentile calculat. Ref: EPA SDWA.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Lead and Copper Rule requires sampling at customer taps (service points) with specific site selection criteria based on service line material and building age. Service point linkage is mandatory for 9. Ref: EPA SDWA.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Premise characteristics (service line material, building age, plumbing configuration) are mandatory for lead/copper site selection, tier classification, and LCRR compliance. Business process: site inv',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the customer tap location selected for Lead and Copper Rule monitoring. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EPA Lead and Copper Rule requires certified personnel for sampling. Tracking collector employee enables license verification, training compliance audits, and chain-of-custody validation for regulatory. Ref: EPA SDWA.',
    `sampling_round_id` BIGINT COMMENT 'Reference to the 6-month monitoring period during which this sample was collected per LCRR requirements.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Lead/copper monitoring follows LCR sampling rounds with specific site selection and frequency requirements. Links result to regulatory schedule for 90th percentile calculation, action level exceedance. Ref: EPA SDWA.',
    `sampling_site_id` BIGINT COMMENT 'Reference to the customer tap location selected for Lead and Copper Rule monitoring. Ref: EPA SDWA.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Lead/copper sampling requires precise service address tracking for tier site selection, customer notification within 30 days of result, and LCRR compliance documentation. Already has customer_account_',
    `vendor_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the lead and copper analysis. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Laboratory-assigned unique identifier for the physical water sample collected at the tap. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each lead copper result record in the quality domain.',
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
    `service_line_material` STRING COMMENT 'Material composition of the customer service line as classified under LCRR for site selection and tiering. [ENUM-REF-CANDIDATE: lead|galvanized_requiring_replacement|lead_status_unknown|non_lead|copper|plastic|steel|iron|unknown — promote to reference product]',
    `site_tier` STRING COMMENT 'LCRR-mandated tier classification of the sampling site based on service line material and building construction date (Tier 1: lead service lines, Tier 2: lead status unknown, Tier 3: non-lead).. Valid values are `tier_1|tier_2|tier_3`',
    `stagnation_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours that water remained stagnant in the service line prior to sample collection. LCRR requires minimum 6-hour stagnation for first-draw samples.',
    `lead_copper_result_status` STRING COMMENT 'The lead copper result status value recorded for each lead copper result in the quality domain.',
    CONSTRAINT pk_lead_copper_result PRIMARY KEY(`lead_copper_result_id`)
) COMMENT 'Specialized transactional record for Lead and Copper Rule (LCR/LCRR) monitoring at customer tap sampling sites. Captures sampling round (6-month period), customer service line material classification (lead, galvanized, copper, unknown), first-draw sample result (lead ppb, copper ppb), 90th percentile calculation inputs, action level exceedance flag (lead >15 ppb, copper >1300 ppb), tier classification of sampling site, and corrosion control treatment optimization status. Distinct from general analytical_result due to LCRR-specific site selection, tiering, and 90th percentile compliance methodology.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` (
    `source_water_quality_id` BIGINT COMMENT 'Unique identifier for the source water quality measurement record. Ref: EPA SDWA.',
    `bulk_water_agreement_id` BIGINT COMMENT 'Foreign key linking to service.bulk_water_agreement. Business justification: Bulk water agreements specify contractual water quality standards at delivery points. Source water monitoring at these points verifies compliance with contracted quality parameters, triggers price adj. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Source water monitoring costs are allocated to raw water/intake operations cost centers for budget tracking and rate case documentation of source water protection and monitoring program expenses. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Source water quality measurements are taken at specific sampling points (intake locations). Currently has source_water_intake_id (cross-domain to treatment) and sample_id. Adding sampling_point_id est. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Source water monitoring under SDWA requires operator certification. Linking sampler employee enables compliance verification for intake monitoring programs, training record validation, and regulatory. Ref: EPA SDWA.',
    `source_location_source_water_intake_id` BIGINT COMMENT 'Reference to the specific water source intake point or well where the sample was collected. Ref: EPA SDWA.',
    `source_water_intake_id` BIGINT COMMENT 'Reference to the specific water source intake point or well where the sample was collected. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Unique laboratory identifier assigned to the water sample for tracking and chain of custody. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each source water quality record in the quality domain.',
    `algae_count_cells_per_ml` STRING COMMENT 'Concentration of algae cells per milliliter of source water, important for taste, odor, and treatment challenges. Ref: EPA SDWA.',
    `alkalinity_mg_per_l` DECIMAL(18,2) COMMENT 'Total alkalinity expressed as milligrams per liter of calcium carbonate equivalent, indicating buffering capacity. Ref: EPA SDWA.',
    `ammonia_mg_per_l` DECIMAL(18,2) COMMENT 'Ammonia nitrogen concentration in milligrams per liter, affecting disinfection effectiveness and DBP formation. Ref: EPA SDWA.',
    `analysis_method` BOOLEAN COMMENT 'EPA or Standard Methods reference number for the analytical method used for testing. Ref: EPA SDWA.',
    `chloride_mg_per_l` DECIMAL(18,2) COMMENT 'Chloride concentration in milligrams per liter, affecting taste and corrosivity. Ref: EPA SDWA.',
    `source_water_quality_code` STRING COMMENT 'The source water quality code value recorded for each source water quality in the quality domain.',
    `color_pcu` STRING COMMENT 'Apparent color of the source water measured in Platinum-Cobalt Units, indicating dissolved organic matter. Ref: EPA SDWA.',
    `conductivity_us_cm` DECIMAL(18,2) COMMENT 'The conductivity us cm value recorded for each source water quality in the quality domain.',
    `conductivity_us_per_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity of the source water in microsiemens per centimeter, indicating ionic content. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this source water quality record was first created in the system. Ref: EPA SDWA.',
    `cyanotoxin_concentration_ug_per_l` DECIMAL(18,2) COMMENT 'Concentration of cyanotoxins in micrograms per liter if detected, null if not detected or not analyzed. Ref: EPA SDWA.',
    `cyanotoxin_detected` BOOLEAN COMMENT 'Boolean indicator of whether cyanotoxins (blue-green algae toxins) were detected in the screening analysis. Ref: EPA SDWA.',
    `source_water_quality_description` STRING COMMENT 'The source water quality description value recorded for each source water quality in the quality domain.',
    `dissolved_oxygen_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of dissolved oxygen in milligrams per liter, indicating water quality and biological activity. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The effective date associated with each source water quality record in the quality domain.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Flow rate of the source water at the intake point at time of sampling, expressed in Million Gallons per Day. Ref: EPA SDWA.',
    `hardness_mg_per_l` DECIMAL(18,2) COMMENT 'Total hardness expressed as milligrams per liter of calcium carbonate equivalent, indicating calcium and magnesium content. Ref: EPA SDWA.',
    `iron_mg_per_l` DECIMAL(18,2) COMMENT 'Total iron concentration in milligrams per liter, important for treatment process design and aesthetic quality. Ref: EPA SDWA.',
    `lab_analyzed_by` STRING COMMENT 'Name or identifier of the laboratory analyst who performed the water quality analysis. Ref: EPA SDWA.',
    `manganese_mg_per_l` DECIMAL(18,2) COMMENT 'Total manganese concentration in milligrams per liter, important for treatment and aesthetic quality. Ref: EPA SDWA.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the source water quality sample was collected and measured. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each source water quality record in the quality domain.',
    `source_water_quality_name` STRING COMMENT 'The source water quality name used to identify each source water quality record in the quality domain.',
    `nitrate_mg_per_l` DECIMAL(18,2) COMMENT 'Nitrate nitrogen concentration in milligrams per liter, a regulated contaminant under SDWA. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional observations, anomalies, or contextual information about the source water quality measurement. Ref: EPA SDWA.',
    `ph_level` DECIMAL(18,2) COMMENT 'Measure of acidity or alkalinity of the source water on a scale of 0-14, critical for treatment process optimization. Ref: EPA SDWA.',
    `ph_value` DECIMAL(18,2) COMMENT 'The ph value value recorded for each source water quality in the quality domain.',
    `quality_control_passed` BOOLEAN COMMENT 'Boolean indicator of whether the laboratory analysis passed all quality control checks and validation criteria. Ref: EPA SDWA.',
    `regulatory_exceedance` BOOLEAN COMMENT 'Boolean indicator of whether any measured parameter exceeded regulatory action levels or Maximum Contaminant Levels (MCL). Ref: EPA SDWA.',
    `sample_type` STRING COMMENT 'The sample type value recorded for each source water quality in the quality domain.',
    `season` STRING COMMENT 'Season during which the source water sample was collected, used for seasonal trend analysis. Ref: EPA SDWA.. Valid values are `spring|summer|fall|winter`',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this measurement represents a period of significant seasonal variation in source water quality. Ref: EPA SDWA.',
    `source_type` STRING COMMENT 'Classification of the water source from which the sample was collected. Ref: EPA SDWA.. Valid values are `surface_water|groundwater|reservoir|lake|river|purchased_water`',
    `source_water_quality_status` STRING COMMENT 'The source water quality status value recorded for each source water quality in the quality domain.',
    `sulfate_mg_per_l` DECIMAL(18,2) COMMENT 'Sulfate concentration in milligrams per liter, a secondary contaminant affecting taste and odor. Ref: EPA SDWA.',
    `tds_mg_per_l` DECIMAL(18,2) COMMENT 'Total Dissolved Solids concentration in milligrams per liter, indicating mineral content and salinity. Ref: EPA SDWA.',
    `temperature_c` DECIMAL(18,2) COMMENT 'The temperature c value recorded for each source water quality in the quality domain.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the source water at time of sampling, measured in degrees Celsius. Ref: EPA SDWA.',
    `toc_mg_l` DECIMAL(18,2) COMMENT 'The toc mg l value recorded for each source water quality in the quality domain.',
    `toc_mg_per_l` DECIMAL(18,2) COMMENT 'Total Organic Carbon concentration in milligrams per liter, a key indicator for disinfection byproduct formation potential. Ref: EPA SDWA.',
    `treatment_adjustment_required` BOOLEAN COMMENT 'Boolean indicator of whether the source water quality measurement triggered a need for Water Treatment Plant (WTP) process adjustment. Ref: EPA SDWA.',
    `tss_mg_per_l` DECIMAL(18,2) COMMENT 'Total Suspended Solids concentration in milligrams per liter, indicating particulate matter load. Ref: EPA SDWA.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Raw turbidity measurement of the source water expressed in Nephelometric Turbidity Units, indicating suspended particle concentration. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this source water quality record was last modified in the system. Ref: EPA SDWA.',
    `weather_condition` STRING COMMENT 'General weather condition at the time of sampling, affecting source water quality characteristics. Ref: EPA SDWA.. Valid values are `dry|wet|storm|drought|normal`',
    `wfd_chemical_status` STRING COMMENT 'EU WFD chemical status: Good or Failing to achieve good. Based on compliance with Environmental Quality Standards for 45 priority substances (Directive 2013/39/EU). Binary classification differs from US approach of parameter-specific impairment. Ref: EPA SDWA.',
    `wfd_ecological_status` STRING COMMENT 'EU Water Framework Directive ecological status classification for the source water body: High, Good, Moderate, Poor, Bad. Determined by biological quality elements (one-out-all-out principle), supporting hydromorphological and physico-chemical elements. Fundamentally different from US CWA 303(d) impairment listing. Ref: EPA SDWA.',
    `wfd_river_basin_district` STRING COMMENT 'EU WFD River Basin District name as defined under Article 3. The RBD is the fundamental management unit under WFD, unlike US which uses HUC watershed codes and state boundaries as primary regulatory units. Ref: EPA SDWA.',
    `wfd_water_body_code` STRING COMMENT 'EU Water Framework Directive water body identifier as assigned in River Basin Management Plans. Format varies by member state. Used for WFD Article 5 characterization and Article 8 monitoring programme linkage. Ref: EPA SDWA.',
    CONSTRAINT pk_source_water_quality PRIMARY KEY(`source_water_quality_id`)
) COMMENT 'Transactional records of raw source water quality measurements at intake points (surface water intakes, groundwater wells, purchased water entry points). Captures measurement date/time, source type (river, reservoir, lake, groundwater, purchased), raw turbidity (NTU), TOC (mg/L), pH, temperature, alkalinity, hardness, color, algae counts, cyanotoxin screening results, and seasonal variation flags. Drives WTP treatment process adjustments and source water assessment reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` (
    `effluent_quality_id` BIGINT COMMENT 'Unique identifier for the effluent quality measurement record. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: New or upgraded WWTP facilities require effluent quality validation during commissioning to demonstrate NPDES permit compliance before final acceptance. Project closeout requires documented effluent q. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key reference to the NPDES permit governing this discharge point. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each effluent quality record in the quality domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wastewater effluent monitoring costs are allocated to treatment operations cost centers for NPDES compliance budgeting, DMR reporting cost tracking, and rate case justification of wastewater treatment. Ref: EPA SDWA.',
    `dmr_id` BIGINT COMMENT 'Foreign key linking to compliance.dmr. Business justification: Effluent quality measurements populate DMR (Discharge Monitoring Report) submissions for NPDES compliance. This link connects laboratory results to regulatory reporting documents, essential for wastew. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Wastewater effluent samples analyzed in laboratory for NPDES compliance. Direct lab_sample link required for DMR reporting, laboratory QA/QC traceability, and permit limit verification. Supports EPA N. Ref: EPA SDWA.',
    `outfall_id` BIGINT COMMENT 'Foreign key reference to the specific discharge outfall point where the effluent sample was collected. Ref: EPA SDWA.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Effluent quality measurements are evaluated against specific permit conditions (BOD limits, TSS limits, pH ranges). This link enables automated compliance determination by comparing measured values to. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who collected the effluent sample. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Effluent quality measurements are taken at specific sampling points. Currently has outfall_id (not a product in this domain) and outfall_identifier (STRING). Adding sampling_point_id establishes the l. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the laboratory that performed the effluent quality analysis. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each effluent quality record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each effluent quality record in the quality domain.',
    `wwtp_id` BIGINT COMMENT 'Foreign key reference to the wastewater treatment plant where the effluent sample was collected. Ref: EPA SDWA.',
    `ammonia_mg_l` DECIMAL(18,2) COMMENT 'The ammonia mg l value recorded for each effluent quality in the quality domain.',
    `ammonia_nitrogen_mg_l` DECIMAL(18,2) COMMENT 'Ammonia nitrogen concentration in milligrams per liter, measuring un-ionized and ionized ammonia. Ref: EPA SDWA.',
    `ammonia_permit_limit_mg_l` DECIMAL(18,2) COMMENT 'NPDES permit limit for ammonia nitrogen concentration in milligrams per liter for this discharge point. Ref: EPA SDWA.',
    `analysis_completion_date` DATE COMMENT 'Date when the laboratory completed all analytical testing for this effluent sample. Ref: EPA SDWA.',
    `bod5_mg_l` DECIMAL(18,2) COMMENT 'Five-day biochemical oxygen demand concentration in milligrams per liter, measuring organic pollution load. Ref: EPA SDWA.',
    `bod5_permit_limit_mg_l` DECIMAL(18,2) COMMENT 'NPDES permit limit for BOD5 concentration in milligrams per liter for this discharge point. Ref: EPA SDWA.',
    `bod_mg_l` DECIMAL(18,2) COMMENT 'The bod mg l value recorded for each effluent quality in the quality domain.',
    `cbod5_mg_l` DECIMAL(18,2) COMMENT 'Five-day carbonaceous biochemical oxygen demand concentration in milligrams per liter, excluding nitrogenous demand. Ref: EPA SDWA.',
    `cod_mg_l` DECIMAL(18,2) COMMENT 'Chemical oxygen demand concentration in milligrams per liter, measuring total organic and inorganic oxidizable matter. Ref: EPA SDWA.',
    `effluent_quality_code` STRING COMMENT 'The effluent quality code value recorded for each effluent quality in the quality domain.',
    `compliance_status` STRING COMMENT 'Overall compliance status of this effluent sample against NPDES permit limits: compliant (all parameters within limits), non-compliant (one or more violations), exceedance (exceeds but within reporting tolerance), or pending review. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|exceedance|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this effluent quality record was first created in the database. Ref: EPA SDWA.',
    `effluent_quality_description` STRING COMMENT 'The effluent quality description value recorded for each effluent quality in the quality domain.',
    `discharge_date` DATE COMMENT 'Calendar date of the effluent discharge event for reporting purposes. Ref: EPA SDWA.',
    `dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration in milligrams per liter, measuring oxygen available in the effluent. Ref: EPA SDWA.',
    `dmr_reporting_period` STRING COMMENT 'The DMR reporting period (e.g., 2024-01, 2024-Q1) to which this effluent measurement applies. Ref: EPA SDWA.',
    `e_coli_cfu_100ml` DECIMAL(18,2) COMMENT 'E. coli bacteria count in colony forming units per 100 milliliters, indicating fecal contamination and pathogen risk. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The effective date associated with each effluent quality record in the quality domain.',
    `exceedance_flag` BOOLEAN COMMENT 'The exceedance flag value recorded for each effluent quality in the quality domain.',
    `fecal_coliform_cfu_100ml` DECIMAL(18,2) COMMENT 'Fecal coliform bacteria count in colony forming units per 100 milliliters, indicating fecal contamination. Ref: EPA SDWA.',
    `fecal_coliform_permit_limit_cfu_100ml` DECIMAL(18,2) COMMENT 'NPDES permit limit for fecal coliform bacteria count in colony forming units per 100 milliliters for this discharge point. Ref: EPA SDWA.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Effluent discharge flow rate measured in million gallons per day at the time of sampling. Ref: EPA SDWA.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The measurement timestamp associated with each effluent quality record in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this effluent quality record was last modified. Ref: EPA SDWA.',
    `effluent_quality_name` STRING COMMENT 'The effluent quality name used to identify each effluent quality record in the quality domain.',
    `npdes_limit_value` DECIMAL(18,2) COMMENT 'The npdes limit value value recorded for each effluent quality in the quality domain.',
    `npdes_permit_number` STRING COMMENT 'The EPA-issued NPDES permit number authorizing this discharge (e.g., CA0001234). Ref: EPA SDWA.',
    `ph_permit_range_max` DECIMAL(18,2) COMMENT 'NPDES permit maximum allowable pH value for this discharge point. Ref: EPA SDWA.',
    `ph_permit_range_min` DECIMAL(18,2) COMMENT 'NPDES permit minimum allowable pH value for this discharge point. Ref: EPA SDWA.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the effluent, indicating acidity or alkalinity on a scale of 0-14. Ref: EPA SDWA.',
    `remarks` STRING COMMENT 'Free-text field for operational notes, unusual conditions, or explanations related to this effluent sample (e.g., heavy rainfall event, equipment malfunction, process upset). Ref: EPA SDWA.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent sample was collected at the discharge point. Ref: EPA SDWA.',
    `sample_type` STRING COMMENT 'Method of sample collection: grab (instantaneous), composite over 24 hours, flow-weighted composite, or continuous monitoring. Ref: EPA SDWA.. Valid values are `grab|composite_24hr|composite_flow_weighted|continuous`',
    `effluent_quality_status` STRING COMMENT 'The effluent quality status value recorded for each effluent quality in the quality domain.',
    `tds_mg_l` DECIMAL(18,2) COMMENT 'Total dissolved solids concentration in milligrams per liter, measuring dissolved inorganic and organic substances. Ref: EPA SDWA.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Effluent temperature measured in degrees Celsius at the time of discharge. Ref: EPA SDWA.',
    `toc_mg_l` DECIMAL(18,2) COMMENT 'Total organic carbon concentration in milligrams per liter, measuring all carbon in organic compounds. Ref: EPA SDWA.',
    `total_nitrogen_mg_l` DECIMAL(18,2) COMMENT 'Total nitrogen concentration in milligrams per liter, including organic nitrogen, ammonia, nitrite, and nitrate. Ref: EPA SDWA.',
    `total_phosphorus_mg_l` DECIMAL(18,2) COMMENT 'Total phosphorus concentration in milligrams per liter, measuring all forms of phosphorus including orthophosphate and organic phosphorus. Ref: EPA SDWA.',
    `total_residual_chlorine_mg_l` DECIMAL(18,2) COMMENT 'Total residual chlorine concentration in milligrams per liter, measuring disinfectant residual in the effluent. Ref: EPA SDWA.',
    `tss_mg_l` DECIMAL(18,2) COMMENT 'Total suspended solids concentration in milligrams per liter, measuring particulate matter in the effluent. Ref: EPA SDWA.',
    `tss_permit_limit_mg_l` DECIMAL(18,2) COMMENT 'NPDES permit limit for TSS concentration in milligrams per liter for this discharge point. Ref: EPA SDWA.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measurement in nephelometric turbidity units, indicating water clarity and suspended particle content. Ref: EPA SDWA.',
    CONSTRAINT pk_effluent_quality PRIMARY KEY(`effluent_quality_id`)
) COMMENT 'Transactional records of treated wastewater effluent quality at WWTP discharge points. Captures discharge date/time, outfall identifier, NPDES permit number, BOD5 (mg/L), CBOD5, COD, TSS (mg/L), TDS, ammonia-nitrogen, total nitrogen, total phosphorus, pH, dissolved oxygen, fecal coliform, E. coli, flow rate (MGD), and permit limit compliance status for each parameter. Drives DMR (Discharge Monitoring Report) preparation and NPDES compliance tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` (
    `ccr_period_id` BIGINT COMMENT 'Unique identifier for the Consumer Confidence Report period. Primary key. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each ccr period record in the quality domain.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency overseeing CCR/consumer information compliance (US EPA/state, ANSES, DWI, UBA). Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each ccr period record in the quality domain.',
    `additional_languages` STRING COMMENT 'Comma-separated list of additional languages in which the CCR was made available (e.g., Spanish, Chinese, Vietnamese). Ref: EPA SDWA.',
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
    `detected_contaminant_count` STRING COMMENT 'Total number of regulated contaminants detected in the water system during the report year. Includes contaminants above and below Maximum Contaminant Levels (MCL). Ref: EPA SDWA.',
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
    `ccr_period_status` STRING COMMENT 'The ccr period status value recorded for each ccr period in the quality domain.',
    `treatment_technique_violation_count` STRING COMMENT 'Number of treatment technique violations that occurred during the report year. Treatment techniques are required processes for contaminants without MCLs. Ref: EPA SDWA.',
    `violation_summary` STRING COMMENT 'Narrative summary of all violations that occurred during the report year, including health effects language and corrective actions taken. Required CCR content element. Ref: EPA SDWA.',
    `water_source_summary` STRING COMMENT 'Narrative description of the water systems sources including surface water, groundwater, purchased water, and source water protection information. Required CCR content element. Ref: EPA SDWA.',
    `wfd_river_basin_district` STRING COMMENT 'EU Water Framework Directive 2000/60/EC river basin district identifier for source water context in EU jurisdictions. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this CCR period record. Ref: EPA SDWA.',
    CONSTRAINT pk_ccr_period PRIMARY KEY(`ccr_period_id`)
) COMMENT 'Master record for each annual Consumer Confidence Report (CCR) reporting period. Captures report year, water system name, PWSID (Public Water System ID), primacy agency, report preparation status, publication date, distribution method (mailed, posted, electronic), number of customers served, water source summary, detected contaminant summary count, violation summary, and certification submission date to primacy agency. Serves as the organizing entity for all CCR-related quality data aggregation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` (
    `ccr_detected_contaminant_id` BIGINT COMMENT 'Unique identifier for each contaminant detection record required to be reported in the annual Consumer Confidence Report (CCR) for a given reporting period. Primary key. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who originally created this contaminant detection record. Supports accountability and audit trail for regulatory compliance. Ref: Sensus AMI.',
    `ccr_employee_id` BIGINT COMMENT 'Identifier of the water quality manager or compliance officer who reviewed and approved this contaminant detection record for inclusion in the Consumer Confidence Report. Supports audit trail and regulatory accountability. Ref: Sensus AMI.',
    `ccr_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this contaminant detection record. Supports change tracking and accountability for data quality. Ref: Sensus AMI.',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking to quality.ccr_period. Business justification: CCR detected contaminants belong to a CCR period within the quality domain. The existing ccr_id points to quality.ccr (cross-domain), but ccr_period is the in-domain master record for CCR reporting. Ref: Sensus AMI.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: ccr_detected_contaminant currently has contaminant_code and contaminant_name as denormalized attributes. This product reports contaminants detected in the annual Consumer Confidence Report and must re. Ref: Sensus AMI.',
    `primary_ccr_employee_id` BIGINT COMMENT 'Identifier of the water quality manager or compliance officer who reviewed and approved this contaminant detection record for inclusion in the Consumer Confidence Report. Supports audit trail and regulatory accountability. Ref: Sensus AMI.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: CCR detected contaminants are detected at specific sampling points. This FK identifies the primary sampling point where the contaminant was detected, enabling location-specific reporting in the CCR. Ref: Sensus AMI.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: CCR distribution and contaminant messaging varies by customer segment (residential vs commercial, language requirements, delivery method preferences). Regulatory requirement: targeted CCR delivery and. Ref: Sensus AMI.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Consumer Confidence Reports are prepared and distributed by service territory (water system). Detected contaminants must be associated with the specific service territory for accurate CCR generation,. Ref: Sensus AMI.',
    `tertiary_ccr_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this contaminant detection record. Supports change tracking and accountability for data quality. Ref: Sensus AMI.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each ccr detected contaminant record in the quality domain.',
    `action_level` DECIMAL(18,2) COMMENT 'The concentration of a contaminant which, if exceeded, triggers treatment or other requirements that a water system must follow. Primarily used for lead and copper under the Lead and Copper Rule (LCR) and Lead and Copper Rule Revisions (LCRR). Null if not applicable.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this contaminant detection record was reviewed and approved for CCR publication. Part of the quality assurance and regulatory compliance workflow. Ref: Sensus AMI.',
    `ccr_table_display_order` STRING COMMENT 'Sequence number controlling the display order of this contaminant in the published CCR detected contaminants table. Allows utilities to organize contaminants by category, regulatory importance, or alphabetically for public presentation. Ref: Sensus AMI.',
    `ccr_detected_contaminant_code` STRING COMMENT 'The ccr detected contaminant code value recorded for each ccr detected contaminant in the quality domain.',
    `comments` STRING COMMENT 'Internal notes, comments, or observations regarding this contaminant detection. May include quality control notes, data validation comments, or context for unusual results. Not published in the CCR but retained for internal documentation. Ref: Sensus AMI.',
    `compliance_status` STRING COMMENT 'Overall compliance status for this contaminant during the reporting period. Indicates whether the water system met all regulatory requirements including MCL/AL compliance, monitoring frequency, and reporting obligations. Ref: Sensus AMI.. Valid values are `compliant|violation|pending_review|corrective_action_required`',
    `contaminant_category` STRING COMMENT 'Classification of the contaminant type for regulatory grouping and CCR presentation. Categories align with EPA National Primary Drinking Water Regulations structure. Ref: Sensus AMI.. Valid values are `inorganic|organic|disinfection_byproduct|microbiological|radiological|emerging_contaminant`',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned by the water system in response to violations or elevated contaminant levels. Required disclosure in CCR when violations occur. Includes treatment modifications, infrastructure improvements, or operational changes. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contaminant detection record was first created in the system. Part of the audit trail for regulatory compliance and data governance. Ref: Sensus AMI.',
    `data_source` STRING COMMENT 'Identifies the system or process from which this contaminant detection data was obtained (e.g., Laboratory Information Management System, SCADA historian, manual data entry, state drinking water database). Supports data lineage and quality assurance. Ref: Sensus AMI.. Valid values are `lims|scada|manual_entry|state_reporting_system|laboratory_report`',
    `ccr_detected_contaminant_description` STRING COMMENT 'The ccr detected contaminant description value recorded for each ccr detected contaminant in the quality domain.',
    `detected_level` DECIMAL(18,2) COMMENT 'The detected level value recorded for each ccr detected contaminant in the quality domain.',
    `detection_frequency_percent` DECIMAL(18,2) COMMENT 'Percentage of samples in which this contaminant was detected, calculated as (number_of_detections / number_of_samples) * 100. Provides statistical context for contaminant presence in the water system. Ref: Sensus AMI.',
    `effective_date` DATE COMMENT 'The effective date associated with each ccr detected contaminant record in the quality domain.',
    `footnote_text` STRING COMMENT 'Additional explanatory text or footnotes specific to this contaminant detection that will appear in the CCR. Used to provide context, explain unusual results, clarify monitoring schedules, or reference specific regulatory requirements. Ref: Sensus AMI.',
    `health_effects_language` STRING COMMENT 'EPA-mandated health effects language describing the potential health impacts of this contaminant when present above the MCL or MCLG. Must use EPA-approved standard language as specified in 40 CFR 141.153 Appendix B. Required for all contaminants with violations or detections above health-based levels. Ref: Sensus AMI.',
    `highest_level_detected` DECIMAL(18,2) COMMENT 'The highest single measurement or calculated running annual average (RAA) of the contaminant detected during the reporting period. For some contaminants (e.g., THM, HAA5), this represents the highest locational running annual average (LRAA). Reporting format depends on contaminant-specific regulations. Ref: Sensus AMI.',
    `mcl` DECIMAL(18,2) COMMENT 'The Maximum Contaminant Level (MCL) - the highest level of a contaminant that is allowed in drinking water. MCLs are enforceable standards set as close to MCLGs as feasible using the best available treatment technology. Null if a Treatment Technique (TT) applies instead of an MCL. Ref: Sensus AMI.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The mcl value value recorded for each ccr detected contaminant in the quality domain.',
    `mclg` DECIMAL(18,2) COMMENT 'The Maximum Contaminant Level Goal (MCLG) - the level of a contaminant in drinking water below which there is no known or expected risk to health. MCLGs are non-enforceable public health goals. Value of zero indicates no safe level. Null indicates no MCLG established. Ref: Sensus AMI.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The mclg value value recorded for each ccr detected contaminant in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contaminant detection record was last modified. Supports change tracking and audit requirements for regulatory reporting. Ref: Sensus AMI.',
    `monitoring_period_end_date` DATE COMMENT 'The ending date of the monitoring period for which this contaminant detection data was collected. Defines the temporal scope of the reported results. Ref: Sensus AMI.',
    `monitoring_period_start_date` DATE COMMENT 'The beginning date of the monitoring period for which this contaminant detection data was collected. Defines the temporal scope of the reported results. Ref: Sensus AMI.',
    `ccr_detected_contaminant_name` STRING COMMENT 'The ccr detected contaminant name used to identify each ccr detected contaminant record in the quality domain.',
    `number_of_detections` STRING COMMENT 'Count of samples in which this contaminant was detected above the method detection limit (MDL) or practical quantitation level (PQL) during the reporting period. Provides transparency on detection frequency. Ref: Sensus AMI.',
    `number_of_samples` STRING COMMENT 'Total count of samples collected and analyzed for this contaminant during the reporting period. Used to demonstrate compliance with monitoring frequency requirements and provide context for detection statistics. Ref: Sensus AMI.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this contaminant detection triggered Public Notification (PN) requirements under 40 CFR 141 Subpart Q. True if Tier 1, 2, or 3 public notice was required, False otherwise. Public notification is separate from but related to CCR reporting. Ref: Sensus AMI.',
    `range_high` DECIMAL(18,2) COMMENT 'The highest level detected for this contaminant across all samples collected during the reporting period. Forms the upper bound of the detection range required for CCR reporting. Typically matches highest_level_detected unless different averaging methods apply. Ref: Sensus AMI.',
    `range_low` DECIMAL(18,2) COMMENT 'The lowest level detected for this contaminant across all samples collected during the reporting period. Forms the lower bound of the detection range required for CCR reporting. May be zero or below detection limit. Ref: Sensus AMI.',
    `regulatory_program` STRING COMMENT 'The specific EPA regulatory program or rule under which this contaminant is monitored and reported (e.g., National Primary Drinking Water Regulations, Lead and Copper Rule, Disinfectants and Disinfection Byproducts Rule, Unregulated Contaminant Monitoring Rule). [ENUM-REF-CANDIDATE: npdwr|surface_water_treatment_rule|groundwater_rule|lead_copper_rule|dbp_rule|radionuclides_rule|unregulated_contaminant_monitoring — 7 candidates stripped; promote to reference product]',
    `reporting_year` STRING COMMENT 'Calendar year for which this contaminant detection is being reported in the CCR. Typically the year in which samples were collected and analyzed. Ref: Sensus AMI.',
    `sample_year` STRING COMMENT 'The actual year in which the water samples were collected for this contaminant. May differ from reporting year for contaminants with multi-year monitoring cycles (e.g., lead and copper, certain synthetic organic chemicals). Ref: Sensus AMI.',
    `ccr_detected_contaminant_status` STRING COMMENT 'The ccr detected contaminant status value recorded for each ccr detected contaminant in the quality domain.',
    `treatment_technique_flag` BOOLEAN COMMENT 'Indicates whether this contaminant is regulated by a Treatment Technique (TT) requirement rather than an MCL. True if TT applies (e.g., turbidity, lead and copper action levels), False if MCL applies. Ref: Sensus AMI.',
    `typical_source_description` STRING COMMENT 'EPA-mandated language describing the likely sources of this contaminant in drinking water. Must use EPA-approved standard language for each contaminant as specified in 40 CFR 141.153 Appendix A. This text appears directly in the published CCR. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for contaminant concentration values (e.g., mg/L for milligrams per liter, ug/L for micrograms per liter, pCi/L for picocuries per liter, NTU for Nephelometric Turbidity Units, MFL for million fibers per liter). Must align with EPA reporting standards. [ENUM-REF-CANDIDATE: mg/L|ug/L|pCi/L|MFL|NTU|%|CFU/100mL|MPN/100mL — 8 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether the detected contaminant level resulted in a violation of the MCL, MCLG, Treatment Technique, or Action Level during the reporting period. True if violation occurred, False if compliant. Violations must be prominently disclosed in the CCR. Ref: Sensus AMI.',
    `violation_type` STRING COMMENT 'Classification of the type of violation if violation_flag is True. Specifies whether the violation was due to MCL exceedance, action level exceedance, treatment technique failure, monitoring failure, or reporting failure. Value is none if no violation occurred. Ref: Sensus AMI.. Valid values are `mcl_exceedance|action_level_exceedance|treatment_technique_violation|monitoring_violation|reporting_violation|none`',
    CONSTRAINT pk_ccr_detected_contaminant PRIMARY KEY(`ccr_detected_contaminant_id`)
) COMMENT 'Transactional record of each contaminant detected and required to be reported in the annual CCR for a given reporting period. Captures contaminant name, MCLG, MCL or treatment technique, highest level detected, range of detections (low-high), sample year, violation flag, typical source description, and health effects language. Directly populates the CCR table of detected contaminants as required by 40 CFR 141.153.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` (
    `monitoring_waiver_id` BIGINT COMMENT 'Unique identifier for the monitoring waiver record. Primary key. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Reference to the specific contaminant or contaminant group for which the monitoring waiver is granted. Links to the contaminant product. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the specific sampling point or compliance monitoring point where the waiver applies. Links to the sampling_point product. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Monitoring waivers are granted under specific regulatory requirements (vulnerability assessments per 40 CFR 141). This link documents the regulatory authority and conditions for reduced monitoring, es. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Monitoring waivers require primacy agency approval and internal accountability tracking. Linking responsible employee enables compliance tracking, renewal deadline management, regulatory correspondenc. Ref: EPA SDWA.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Monitoring waivers affect specific sampling schedules by reducing monitoring frequency. This FK links the waiver to the schedule(s) it modifies, enabling proper tracking of which schedules operate und. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each monitoring waiver record in the quality domain.',
    `approval_date` DATE COMMENT 'Date on which the monitoring waiver was officially approved and granted by the primacy agency. Ref: EPA SDWA.',
    `approved_by` STRING COMMENT 'The approved by value recorded for each monitoring waiver in the quality domain.',
    `baseline_monitoring_frequency` STRING COMMENT 'Original required monitoring frequency before the waiver was granted (e.g., quarterly, monthly, annual). Expressed as a frequency code or description. Ref: EPA SDWA.',
    `ccr_reporting_impact` STRING COMMENT 'Description of how the monitoring waiver affects Consumer Confidence Report (CCR) reporting requirements and public notification language. Ref: EPA SDWA.',
    `monitoring_waiver_code` STRING COMMENT 'The monitoring waiver code value recorded for each monitoring waiver in the quality domain.',
    `comments` STRING COMMENT 'Additional free-text comments, notes, or observations related to the monitoring waiver, including internal coordination notes or historical context. Ref: EPA SDWA.',
    `contaminant_group` STRING COMMENT 'Descriptive name of the contaminant group covered by this waiver (e.g., Disinfection Byproducts (DBP), Volatile Organic Compounds (VOC), Synthetic Organic Chemicals (SOC), Inorganic Chemicals (IOC), Radionuclides). Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring waiver record was first created in the system. Ref: EPA SDWA.',
    `monitoring_waiver_description` STRING COMMENT 'The monitoring waiver description value recorded for each monitoring waiver in the quality domain.',
    `effective_date` DATE COMMENT 'Date from which the monitoring waiver becomes effective and the reduced monitoring frequency applies. Ref: EPA SDWA.',
    `expiration_date` DATE COMMENT 'Date on which the monitoring waiver expires and full monitoring frequency must resume unless the waiver is renewed. Ref: EPA SDWA.',
    `historical_monitoring_period_end` DATE COMMENT 'End date of the historical monitoring period used to demonstrate non-detect results for waiver eligibility. Ref: EPA SDWA.',
    `historical_monitoring_period_start` DATE COMMENT 'Start date of the historical monitoring period used to demonstrate non-detect results for waiver eligibility. Ref: EPA SDWA.',
    `historical_non_detect_count` STRING COMMENT 'Number of consecutive historical samples with non-detect results for the contaminant, supporting the waiver justification. Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this monitoring waiver record. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring waiver record was last modified or updated in the system. Ref: EPA SDWA.',
    `monitoring_waiver_name` STRING COMMENT 'The monitoring waiver name used to identify each monitoring waiver record in the quality domain.',
    `next_renewal_date` DATE COMMENT 'Date by which the waiver renewal application must be submitted or the waiver reassessment must be completed. Ref: EPA SDWA.',
    `primacy_agency_approval_reference` STRING COMMENT 'Official reference number, permit number, or document identifier issued by the primacy agency for this waiver approval. Ref: EPA SDWA.',
    `primacy_agency_name` STRING COMMENT 'Name of the state or federal primacy agency that approved and granted the monitoring waiver (e.g., State Department of Environmental Quality, EPA Region). Ref: EPA SDWA.',
    `reduced_monitoring_frequency` STRING COMMENT 'Reduced monitoring frequency allowed under the waiver (e.g., annual, triennial, once per compliance period). Expressed as a frequency code or description. Ref: EPA SDWA.',
    `renewal_frequency_years` STRING COMMENT 'Frequency in years at which the waiver must be renewed or reassessed if renewal is required. Ref: EPA SDWA.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the waiver requires periodic renewal or reapplication (True) or is granted indefinitely subject to conditions (False). Ref: EPA SDWA.',
    `responsible_department` STRING COMMENT 'Department or organizational unit responsible for waiver compliance and monitoring (e.g., Water Quality, Regulatory Compliance, Laboratory). Ref: EPA SDWA.',
    `revocation_date` DATE COMMENT 'Date on which the waiver was revoked by the primacy agency or voluntarily withdrawn by the utility, if applicable. Ref: EPA SDWA.',
    `revocation_reason` STRING COMMENT 'Detailed explanation of the reason for waiver revocation, including regulatory violations, detection events, or operational changes. Ref: EPA SDWA.',
    `revocation_trigger_conditions` STRING COMMENT 'Specific conditions or events that would trigger automatic revocation of the waiver (e.g., detection above action level, source water contamination, operational changes). Ref: EPA SDWA.',
    `sampling_schedule_adjustment_notes` STRING COMMENT 'Operational notes describing how the sampling schedule must be adjusted to reflect the waiver-reduced monitoring frequency. Ref: EPA SDWA.',
    `monitoring_waiver_status` STRING COMMENT 'The monitoring waiver status value recorded for each monitoring waiver in the quality domain.',
    `vulnerability_assessment_date` DATE COMMENT 'Date on which the vulnerability assessment or source water assessment supporting the waiver was completed. Ref: EPA SDWA.',
    `vulnerability_assessment_result` STRING COMMENT 'Outcome of the vulnerability assessment indicating the level of vulnerability to the contaminant at the sampling point (e.g., not vulnerable, low vulnerability). Ref: EPA SDWA.. Valid values are `not_vulnerable|low_vulnerability|moderate_vulnerability|high_vulnerability`',
    `waiver_conditions` STRING COMMENT 'Specific conditions, requirements, or restrictions imposed by the primacy agency for maintaining the waiver (e.g., annual source water monitoring, notification requirements, operational changes). Ref: EPA SDWA.',
    `waiver_duration_years` DECIMAL(18,2) COMMENT 'Duration of the monitoring waiver in years, representing the period between effective date and expiration date. Ref: EPA SDWA.',
    `waiver_justification` STRING COMMENT 'Detailed business and regulatory justification for granting the monitoring waiver, including vulnerability assessment results, historical non-detect data, or source water protection measures. Ref: EPA SDWA.',
    `waiver_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned by the primacy agency or utility for this monitoring waiver. Ref: EPA SDWA.',
    `waiver_status` STRING COMMENT 'Current lifecycle status of the monitoring waiver indicating whether it is active, expired, revoked, pending approval, suspended, or renewed. Ref: EPA SDWA.. Valid values are `active|expired|revoked|pending|suspended|renewed`',
    `waiver_type` STRING COMMENT 'Classification of the monitoring waiver based on the regulatory basis for reduced monitoring (e.g., vulnerability assessment waiver, source water waiver, contaminant-specific waiver). Ref: EPA SDWA.. Valid values are `vulnerability_assessment|source_water|contaminant_specific|composite|reduced_frequency|other`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this monitoring waiver record. Ref: EPA SDWA.',
    CONSTRAINT pk_monitoring_waiver PRIMARY KEY(`monitoring_waiver_id`)
) COMMENT 'Master record of approved monitoring waivers granted by the primacy agency allowing reduced monitoring frequency for specific contaminants at specific sampling points. Captures waiver type (vulnerability assessment, source water, contaminant-specific), contaminant group, waiver approval date, expiration date, reduced monitoring frequency, primacy agency approval reference, and conditions for waiver continuation. Ensures the sampling_schedule correctly reflects waiver-adjusted requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` (
    `quality_public_notification_id` BIGINT COMMENT 'Unique identifier for the quality_public_notification data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Unique identifier for the violation compliance violation referenced by each quality public notification record in the quality domain.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each quality public notification record in the quality domain.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Public notifications for water quality violations (Tier 1/2/3 PN) must be delivered to affected customer accounts with proof of delivery tracking. EPA regulatory requirement: PN delivery documentation. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Facility associated with the public notification. Ref: EPA SDWA.',
    `quality_compliance_violation_id` BIGINT COMMENT 'Compliance violation associated with this notification. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the quality created by employee referenced by each quality public notification record in the quality domain.',
    `quality_issued_by_employee_id` BIGINT COMMENT 'FK to workforce.employee. Ref: EPA SDWA.',
    `quality_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the quality responsible employee referenced by each quality public notification record in the quality domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each quality public notification record in the quality domain.',
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency referenced by each quality public notification record in the quality domain.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Geographic targeting of public notifications based on affected service areas (boil water notices, lead exceedances, pressure zone contamination). Operational necessity: incident response, door-to-door. Ref: EPA SDWA.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory referenced by each quality public notification record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'FK to the affected water system. Ref: EPA SDWA.',
    `compliance_public_notification_id` BIGINT COMMENT 'Reference to primary compliance.compliance_public_notification for SSOT alignment. Ref: EPA SDWA.',
    `actions_taken_description` STRING COMMENT 'Description of actions taken to address violation. Ref: EPA SDWA.',
    `advisory_lifted_date` TIMESTAMP COMMENT 'Date advisory was lifted',
    `affected_area_description` STRING COMMENT 'Description of affected service area. Ref: EPA SDWA.',
    `affected_population` STRING COMMENT 'Estimated population affected. Ref: EPA SDWA.',
    `alternative_water_source_provided` BOOLEAN COMMENT 'Whether alternative water source was provided to affected customers. Ref: EPA SDWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each quality public notification in the quality domain.',
    `boil_water_advisory` BOOLEAN COMMENT 'Whether boil water advisory was issued',
    `quality_public_notification_category` STRING COMMENT 'The quality public notification category value recorded for each quality public notification in the quality domain.',
    `certification_of_delivery_date` TIMESTAMP COMMENT 'Date delivery was certified to the primacy agency. Ref: EPA SDWA.',
    `certification_submitted` STRING COMMENT 'Whether PN certification was submitted to primacy agency. Ref: EPA SDWA.',
    `classification` STRING COMMENT 'The classification value recorded for each quality public notification in the quality domain.',
    `quality_public_notification_code` STRING COMMENT 'The quality public notification code value recorded for each quality public notification in the quality domain.',
    `comments` STRING COMMENT 'The comments value recorded for each quality public notification in the quality domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each quality public notification in the quality domain.',
    `connections_affected` STRING COMMENT 'Number of service connections affected. Ref: EPA SDWA.',
    `corrective_actions_description` STRING COMMENT 'Description of corrective actions being taken. Ref: EPA SDWA.',
    `corrective_actions_taken` STRING COMMENT 'Description of corrective actions taken or planned. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each quality public notification in the quality domain.',
    `delivered_on_time` TIMESTAMP COMMENT 'Whether notification met regulatory deadline. Ref: EPA SDWA.',
    `delivery_confirmation_date` TIMESTAMP COMMENT 'The delivery confirmation date associated with each quality public notification record in the quality domain.',
    `delivery_date` TIMESTAMP COMMENT 'Actual delivery date. Ref: EPA SDWA.',
    `delivery_deadline` DATE COMMENT 'The delivery deadline value recorded for each quality public notification in the quality domain.',
    `delivery_deadline_date` TIMESTAMP COMMENT 'Regulatory deadline for delivery. Ref: EPA SDWA.',
    `delivery_method` STRING COMMENT 'The delivery method value recorded for each quality public notification in the quality domain.',
    `delivery_methods` STRING COMMENT 'Comma-separated list of delivery methods used: Mail, Email, Newspaper, Website, Bill Insert. Ref: EPA SDWA.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each quality public notification in the quality domain.',
    `quality_public_notification_description` STRING COMMENT 'The quality public notification description value recorded for each quality public notification in the quality domain.',
    `detected_level` DECIMAL(18,2) COMMENT 'Detected level of contaminant. Ref: EPA SDWA.',
    `distribution_method` STRING COMMENT 'How notification was distributed (mail, media, door_to_door, web). Ref: EPA SDWA.',
    `do_not_boil_advisory` BOOLEAN COMMENT 'Whether do-not-boil advisory was issued',
    `do_not_drink_advisory` BOOLEAN COMMENT 'Whether do-not-drink advisory was issued',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each quality public notification record in the quality domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each quality public notification record in the quality domain.',
    `exceedance_id` BIGINT COMMENT 'Unique identifier for the exceedance referenced by each quality public notification record in the quality domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each quality public notification record in the quality domain.',
    `health_effects_description` STRING COMMENT 'Description of potential health effects. Ref: EPA SDWA.',
    `health_effects_language` STRING COMMENT 'Required health effects language. Ref: EPA SDWA.',
    `health_effects_statement` STRING COMMENT 'Required health effects statement. Ref: EPA SDWA.',
    `is_acknowledged` BOOLEAN COMMENT 'Boolean flag indicating whether the is acknowledged condition applies to the quality public notification record.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: EPA SDWA.',
    `is_issued_on_time` BOOLEAN COMMENT 'Flag indicating the notification was issued by the regulatory deadline. Ref: EPA SDWA.',
    `issue_date` DATE COMMENT 'Date notification was issued. Ref: EPA SDWA.',
    `issue_deadline` DATE COMMENT 'Regulatory deadline for issuing the notification. Ref: EPA SDWA.',
    `issued_date` TIMESTAMP COMMENT 'The issued date associated with each quality public notification record in the quality domain.',
    `jurisdiction` STRING COMMENT 'US, EU, UK, or other regulatory jurisdiction. Ref: EPA SDWA.',
    `mcl_or_al` DECIMAL(18,2) COMMENT 'Applicable MCL or action level. Ref: EPA SDWA.',
    `measured_level` STRING COMMENT 'Measured contaminant level. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each quality public notification record in the quality domain.',
    `multilingual_required` BOOLEAN COMMENT 'Whether multilingual notification is required. Ref: EPA SDWA.',
    `quality_public_notification_name` STRING COMMENT 'The quality public notification name used to identify each quality public notification record in the quality domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: EPA SDWA.',
    `notification_date` TIMESTAMP COMMENT 'The notification date associated with each quality public notification record in the quality domain.',
    `notification_deadline` DATE COMMENT 'Regulatory deadline for notification. Ref: EPA SDWA.',
    `notification_language` STRING COMMENT 'Language of notification. Ref: EPA SDWA.',
    `notification_method` STRING COMMENT 'Mail, newspaper, radio, TV, website. Ref: EPA SDWA.',
    `notification_number` STRING COMMENT 'Unique notification reference number. Ref: EPA SDWA.',
    `notification_reason` STRING COMMENT 'Reason for notification (MCL violation, treatment technique violation, monitoring violation, boil water advisory).',
    `notification_status` STRING COMMENT 'Status (draft, issued, active, rescinded, expired). Ref: EPA SDWA.',
    `notification_text` STRING COMMENT 'The notification text value recorded for each quality public notification in the quality domain.',
    `notification_tier` STRING COMMENT 'PN tier. Ref: EPA SDWA.',
    `notification_type` STRING COMMENT 'Type (Tier_1, Tier_2, Tier_3, boil_water, do_not_use, do_not_drink). Ref: EPA SDWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each quality public notification in the quality domain.',
    `population_affected` BIGINT COMMENT 'The population affected value recorded for each quality public notification in the quality domain.',
    `population_notified` STRING COMMENT 'The population notified value recorded for each quality public notification in the quality domain.',
    `population_notified_count` STRING COMMENT 'The population notified count value recorded for each quality public notification in the quality domain.',
    `population_served` STRING COMMENT 'Number of people served by the affected water system. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each quality public notification in the quality domain.',
    `public_health_flag` BOOLEAN COMMENT 'The public health flag value recorded for each quality public notification in the quality domain.',
    `public_notification_language` STRING COMMENT 'The public notification language value recorded for each quality public notification in the quality domain.',
    `pwsid` STRING COMMENT 'Public Water System ID for the notification. Ref: EPA SDWA.',
    `quality_canonical_compliance_public_notification_id` BIGINT COMMENT 'Reference FK to canonical SSOT compliance.compliance_public_notification. Ref: EPA SDWA.',
    `quality_compliance_public_notification_id` BIGINT COMMENT 'Foreign key to SSOT entity compliance.compliance_public_notification. Ref: EPA SDWA.',
    `quality_public_notification_number` STRING COMMENT 'The quality public notification number value recorded for each quality public notification in the quality domain.',
    `quality_public_notification_type` STRING COMMENT 'The quality public notification type value recorded for each quality public notification in the quality domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each quality public notification in the quality domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each quality public notification in the quality domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each quality public notification in the quality domain.',
    `regulatory_deadline` STRING COMMENT 'Regulatory deadline for notification delivery. Ref: EPA SDWA.',
    `regulatory_deadline_date` TIMESTAMP COMMENT 'The regulatory deadline date associated with each quality public notification record in the quality domain.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework (EPA PN Rule, EU DWD Art. 14, state-specific). Ref: EPA SDWA.',
    `regulatory_limit` STRING COMMENT 'Applicable regulatory limit. Ref: EPA SDWA.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each quality public notification in the quality domain.',
    `required_by_date` TIMESTAMP COMMENT 'Regulatory deadline for issuing the notification. Ref: EPA SDWA.',
    `rescind_date` DATE COMMENT 'Date notification was rescinded. Ref: EPA SDWA.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each quality public notification record in the quality domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each quality public notification in the quality domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each quality public notification in the quality domain.',
    `service_connections_affected` STRING COMMENT 'Number of service connections affected. Ref: EPA SDWA.',
    `ssot_entity_type` STRING COMMENT 'The ssot entity type value recorded for each quality public notification in the quality domain.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each quality public notification in the quality domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each quality public notification record in the quality domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each quality public notification record in the quality domain.',
    `state_approval_date` TIMESTAMP COMMENT 'Date the state primacy agency approved the notification content. Ref: EPA SDWA.',
    `state_notification_date` TIMESTAMP COMMENT 'Date the primacy agency was notified. Ref: EPA SDWA.',
    `quality_public_notification_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `submitted_to_agency_date` TIMESTAMP COMMENT 'Date the notification was submitted to the regulatory agency. Ref: EPA SDWA.',
    `submitted_to_regulator_date` TIMESTAMP COMMENT 'Date notification was submitted to regulator. Ref: EPA SDWA.',
    `tier` STRING COMMENT 'The tier value recorded for each quality public notification in the quality domain.',
    `tier_level` STRING COMMENT 'The tier level value recorded for each quality public notification in the quality domain.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for detected level. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each quality public notification record in the quality domain.',
    `violation_category` STRING COMMENT 'Category of violation triggering notification: MCL, TT, Monitoring, Other. Ref: EPA SDWA.',
    `violation_description` STRING COMMENT 'The violation description value recorded for each quality public notification in the quality domain.',
    `violation_type` STRING COMMENT 'Violation type. Ref: EPA SDWA.',
    `what_to_do_description` STRING COMMENT 'Instructions for affected customers. Ref: EPA SDWA.',
    CONSTRAINT pk_quality_public_notification PRIMARY KEY(`quality_public_notification_id`)
) COMMENT 'Transactional record of each public notification issued to customers and the primacy agency in response to MCL violations, monitoring failures, or other reportable water quality events. Captures notification type (Tier 1 immediate, Tier 2 30-day, Tier 3 annual), triggering violation or event, notification date, delivery method (newspaper, mail, electronic, posting), affected population count, health effects language used, and certification of delivery to primacy agency. Tracks compliance with public notification rule timelines. [SSOT: reference view of canonical compliance.compliance_public_notification] Consolidated: compliance.compliance_public_notification is SSOT; this table references it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` (
    `online_instrument_id` BIGINT COMMENT 'Unique identifier for the online water quality monitoring instrument. Primary key for the online instrument registry. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Online instruments measure specific contaminants/parameters. Currently has measurement_parameter as a STRING. Adding contaminant_id normalizes this to reference the contaminant registry and allows rem. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Identifier of the water treatment plant (WTP), wastewater treatment plant (WWTP), pump station, or other facility where the instrument is installed. Ref: EPA SDWA.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Online instruments are capital assets requiring depreciation tracking, asset management, and inclusion in rate base for rate case proceedings—standard utility practice for capitalizing monitoring equi. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Reference to the general asset registry if this instrument is also tracked as a capital asset in the CMMS or ERP system. Links quality-specific instrument metadata to enterprise asset management. Ref: EPA SDWA.',
    `online_registry_id` BIGINT COMMENT 'Reference to the general asset registry if this instrument is also tracked as a capital asset in the CMMS or ERP system. Links quality-specific instrument metadata to enterprise asset management. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Reference to the specific sampling point or monitoring location where the instrument is deployed. Links to the sampling point registry for regulatory compliance tracking. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Online instruments purchased from and serviced by vendors. Required for warranty tracking, calibration service scheduling, spare parts procurement, and vendor performance evaluation. No existing unlin. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each online instrument record in the quality domain.',
    `accuracy_specification` STRING COMMENT 'Manufacturers stated accuracy or precision specification for the instrument (e.g., ±0.02 NTU, ±2% of reading, ±0.1 pH units). Critical for data quality assessment. Ref: EPA SDWA.',
    `alarm_high_threshold` DECIMAL(18,2) COMMENT 'Upper alarm threshold value configured in SCADA. When instrument reading exceeds this value, an alarm is triggered for operator response. Ref: EPA SDWA.',
    `alarm_low_threshold` DECIMAL(18,2) COMMENT 'Lower alarm threshold value configured in SCADA. When instrument reading falls below this value, an alarm is triggered for operator response. Ref: EPA SDWA.',
    `calibration_frequency_days` STRING COMMENT 'Required interval between calibrations, expressed in days. Determined by manufacturer recommendations, regulatory requirements, and operational experience. Ref: EPA SDWA.',
    `calibration_standard_used` STRING COMMENT 'Description of the calibration standard or reference material used during the most recent calibration (e.g., NIST-traceable 10 NTU formazin standard, pH 7.0 buffer solution). Ref: EPA SDWA.',
    `calibration_technician` STRING COMMENT 'Name or identifier of the technician who performed the most recent calibration. Used for quality assurance and accountability. Ref: EPA SDWA.',
    `online_instrument_code` STRING COMMENT 'The online instrument code value recorded for each online instrument in the quality domain.',
    `communication_protocol` STRING COMMENT 'Communication protocol used by the instrument to transmit data to SCADA or control systems (e.g., Modbus RTU, Modbus TCP/IP, HART, Profibus, analog 4-20mA signal). [ENUM-REF-CANDIDATE: modbus_rtu|modbus_tcp|hart|profibus|foundation_fieldbus|ethernet_ip|analog_4_20ma|digital_pulse|bacnet — 9 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system. Used for data lineage and audit trail. Ref: EPA SDWA.',
    `data_logging_interval_seconds` STRING COMMENT 'Frequency at which the instrument records or transmits data to the SCADA/historian system, expressed in seconds (e.g., 60 for one-minute intervals, 300 for five-minute intervals). Ref: EPA SDWA.',
    `online_instrument_description` STRING COMMENT 'The online instrument description value recorded for each online instrument in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each online instrument record in the quality domain.',
    `expected_service_life_years` STRING COMMENT 'Anticipated operational lifespan of the instrument in years, based on manufacturer specifications and utility experience. Used for capital planning and replacement scheduling. Ref: EPA SDWA.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique identifier in the GIS system linking this instrument to its geographic location and network context. Enables spatial analysis and network modeling. Ref: EPA SDWA.',
    `installation_date` DATE COMMENT 'Date when the instrument was installed and commissioned at its current location. Used for asset lifecycle tracking and warranty management. Ref: EPA SDWA.',
    `installation_location` STRING COMMENT 'Detailed description of where the instrument is physically installed (e.g., WTP Filter Effluent Gallery, Distribution Pump Station 5 Discharge, WWTP Final Clarifier Effluent Channel). Ref: EPA SDWA.',
    `instrument_name` STRING COMMENT 'Descriptive name of the online monitoring instrument indicating its function and location (e.g., WTP Effluent Turbidimeter, Distribution Zone 3 Chlorine Analyzer). Ref: EPA SDWA.',
    `instrument_tag` STRING COMMENT 'Unique alphanumeric tag or asset identifier assigned to the instrument for field identification and maintenance tracking. Typically follows plant or utility tagging conventions. Ref: EPA SDWA.',
    `instrument_type` STRING COMMENT 'Classification of the online instrument by measurement function. Defines the primary water quality parameter or operational metric the instrument monitors. [ENUM-REF-CANDIDATE: turbidimeter|chlorine_analyzer|ph_meter|toc_analyzer|uv254_sensor|flow_meter|conductivity_meter|dissolved_oxygen_analyzer|particle_counter|fluorometer|ammonia_analyzer|nitrate_analyzer|phosphate_analyzer|bod_analyzer|cod_analyzer|tss_analyzer|ozone_analyzer|pressure_transmitter|temperature_sensor — promote to reference product]. Ref: EPA SDWA.',
    `last_calibration_date` DATE COMMENT 'Date when the instrument was most recently calibrated. Used to track calibration compliance and schedule next calibration. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the instrument installation location in decimal degrees. Used for mapping and spatial analysis. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the instrument installation location in decimal degrees. Used for mapping and spatial analysis. Ref: EPA SDWA.',
    `maintenance_notes` STRING COMMENT 'Free-text field for recording maintenance history, operational issues, calibration adjustments, or other relevant notes about the instruments performance and service history. Ref: EPA SDWA.',
    `manufacturer` STRING COMMENT 'The manufacturer value recorded for each online instrument in the quality domain.',
    `measurement_parameter` STRING COMMENT 'The measurement parameter value recorded for each online instrument in the quality domain.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Maximum value of the instruments calibrated measurement range. Defines the upper detection limit for accurate readings. Ref: EPA SDWA.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Minimum value of the instruments calibrated measurement range. Defines the lower detection limit for accurate readings. Ref: EPA SDWA.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the parameter reported by the instrument (e.g., mg/L, NTU, pH units, µS/cm, ppm, ppb, GPM, MGD, PSI). Ref: EPA SDWA.',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the instrument. Used for procurement, spare parts identification, and technical support. Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who most recently modified this instrument record. Used for accountability and audit trail. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was most recently updated. Used for change tracking and data quality monitoring. Ref: EPA SDWA.',
    `online_instrument_name` STRING COMMENT 'The online instrument name used to identify each online instrument record in the quality domain.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration. Calculated from last calibration date plus calibration frequency. Used for preventive maintenance scheduling. Ref: EPA SDWA.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. Indicates whether the instrument is actively monitoring, undergoing maintenance, or out of service. Ref: EPA SDWA.. Valid values are `operational|out_of_service|maintenance|calibration|failed|decommissioned`',
    `pi_historian_tag` STRING COMMENT 'Tag name in the OSIsoft PI Historian or equivalent time-series database where continuous instrument readings are stored for trending and analysis.',
    `power_supply_type` STRING COMMENT 'Type of electrical power supply used by the instrument (e.g., AC 120V, DC 24V, battery-powered, solar-powered, loop-powered from 4-20mA signal). Ref: EPA SDWA.. Valid values are `ac_120v|ac_240v|dc_24v|battery|solar|loop_powered`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this instrument is used for regulatory compliance monitoring and reporting (e.g., SDWA, NPDES permit requirements). True if data from this instrument is reported to regulatory agencies. Ref: EPA SDWA.',
    `responsible_department` STRING COMMENT 'Name of the department or work group responsible for maintaining and calibrating this instrument (e.g., Water Quality Lab, Instrumentation & Controls, Plant Operations). Ref: EPA SDWA.',
    `scada_tag_name` STRING COMMENT 'Unique tag identifier in the SCADA system that receives real-time data from this instrument. Used for process control, alarming, and data historian integration. Ref: EPA SDWA.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit. Critical for warranty tracking and service history. Ref: EPA SDWA.',
    `online_instrument_status` STRING COMMENT 'The online instrument status value recorded for each online instrument in the quality domain.',
    `treatment_stage` STRING COMMENT 'Stage in the water or wastewater treatment process where the instrument is monitoring. Critical for understanding data context and compliance requirements. [ENUM-REF-CANDIDATE: raw_water|pre_treatment|coagulation|flocculation|sedimentation|filtration|disinfection|post_treatment|distribution|wastewater_influent|primary_treatment|secondary_treatment|tertiary_treatment|effluent_discharge|sludge_processing — promote to reference product]. Ref: EPA SDWA.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage expires. Critical for maintenance planning and budgeting. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this instrument record. Used for accountability and audit trail. Ref: EPA SDWA.',
    CONSTRAINT pk_online_instrument PRIMARY KEY(`online_instrument_id`)
) COMMENT 'Master registry of continuous online water quality monitoring instruments deployed across WTPs, WWTPs, and the distribution network. Captures instrument type (turbidimeter, chlorine analyzer, pH meter, TOC analyzer, UV254 sensor, flow meter), manufacturer, model, serial number, installation location/sampling point, calibration frequency, last calibration date, calibration standard used, communication protocol (SCADA/Modbus/HART), PI Historian tag name, and operational status. Distinct from the asset domains general asset registry by focusing on quality-specific instrument metadata and calibration management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` (
    `quality_instrument_calibration_id` BIGINT COMMENT 'Unique identifier for the quality_instrument_calibration data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Facility where the calibration was performed. Ref: EPA SDWA.',
    `laboratory_instrument_calibration_id` BIGINT COMMENT 'Reference to primary laboratory.laboratory_instrument_calibration for SSOT alignment. Ref: EPA SDWA.',
    `online_instrument_id` BIGINT COMMENT 'FK to online instrument per VREQ-045. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the quality created by employee referenced by each quality instrument calibration record in the quality domain.',
    `quality_employee_id` BIGINT COMMENT 'FK to performing employee per VREQ-046. Ref: EPA SDWA.',
    `quality_laboratory_instrument_calibration_id` BIGINT COMMENT 'Foreign key to SSOT entity laboratory.laboratory_instrument_calibration. Ref: EPA SDWA.',
    `quality_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the quality responsible employee referenced by each quality instrument calibration record in the quality domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each quality instrument calibration record in the quality domain.',
    `reagent_standard_id` BIGINT COMMENT 'Unique identifier for the reagent standard referenced by each quality instrument calibration record in the quality domain.',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory requirement driving calibration. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each quality instrument calibration record in the quality domain.',
    `acceptable_error_tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable error tolerance percentage for this instrument type. Ref: EPA SDWA.',
    `acceptance_criteria` STRING COMMENT 'Acceptance criteria applied (e.g. +/- 5%). Ref: EPA SDWA.',
    `acceptance_criteria_met` BOOLEAN COMMENT 'Whether acceptance criteria were met. Ref: EPA SDWA.',
    `acceptance_criteria_pct` DECIMAL(18,2) COMMENT 'Acceptable deviation percentage from standard for passing calibration. Ref: EPA SDWA.',
    `acceptance_tolerance_pct` DECIMAL(18,2) COMMENT 'Maximum allowable deviation percentage for passing calibration. Ref: EPA SDWA.',
    `accuracy_pct` DECIMAL(18,2) COMMENT 'Calibration accuracy percentage. Ref: EPA SDWA.',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'The accuracy percentage value recorded for each quality instrument calibration in the quality domain.',
    `adjustment_performed` BOOLEAN COMMENT 'Whether an adjustment was made to the instrument. Ref: EPA SDWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each quality instrument calibration in the quality domain.',
    `as_found_value` DECIMAL(18,2) COMMENT 'The as found value value recorded for each quality instrument calibration in the quality domain.',
    `as_left_value` DECIMAL(18,2) COMMENT 'The as left value value recorded for each quality instrument calibration in the quality domain.',
    `calibration_date` DATE COMMENT 'Date calibration was performed. Ref: EPA SDWA.',
    `calibration_error_pct` DECIMAL(18,2) COMMENT 'Calibration error as percentage. Ref: EPA SDWA.',
    `calibration_frequency_days` DECIMAL(18,2) COMMENT 'Required calibration frequency in days. Ref: EPA SDWA.',
    `calibration_interval_days` DECIMAL(18,2) COMMENT 'Calibration interval in days. Ref: EPA SDWA.',
    `calibration_method` STRING COMMENT 'Calibration method/procedure used. Ref: EPA SDWA.',
    `calibration_notes` DECIMAL(18,2) COMMENT 'The calibration notes value recorded for each quality instrument calibration in the quality domain.',
    `calibration_number` STRING COMMENT 'Unique calibration reference number. Ref: EPA SDWA.',
    `calibration_offset_applied` DECIMAL(18,2) COMMENT 'Offset applied during calibration. Ref: EPA SDWA.',
    `calibration_result` STRING COMMENT 'Calibration result. Ref: EPA SDWA.',
    `calibration_slope` DECIMAL(18,2) COMMENT 'Calibration slope/gain factor. Ref: EPA SDWA.',
    `calibration_standard_used` DECIMAL(18,2) COMMENT 'Reference standard used for calibration. Ref: EPA SDWA.',
    `calibration_status` DECIMAL(18,2) COMMENT 'The calibration status value recorded for each quality instrument calibration in the quality domain.',
    `calibration_timestamp` DECIMAL(18,2) COMMENT 'Precise timestamp of calibration. Ref: EPA SDWA.',
    `calibration_type` STRING COMMENT 'Type (initial, routine, post_maintenance, verification). Ref: EPA SDWA.',
    `quality_instrument_calibration_category` STRING COMMENT 'The quality instrument calibration category value recorded for each quality instrument calibration in the quality domain.',
    `certificate_number` STRING COMMENT 'Calibration certificate or reference number. Ref: EPA SDWA.',
    `classification` STRING COMMENT 'The classification value recorded for each quality instrument calibration in the quality domain.',
    `quality_instrument_calibration_code` STRING COMMENT 'The quality instrument calibration code value recorded for each quality instrument calibration in the quality domain.',
    `comments` STRING COMMENT 'Operator comments or notes on calibration. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each quality instrument calibration in the quality domain.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each quality instrument calibration in the quality domain.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each quality instrument calibration in the quality domain.',
    `quality_instrument_calibration_description` STRING COMMENT 'The quality instrument calibration description value recorded for each quality instrument calibration in the quality domain.',
    `deviation_pct` DECIMAL(18,2) COMMENT 'Actual deviation from standard. Ref: EPA SDWA.',
    `drift_pct` DECIMAL(18,2) COMMENT 'The drift pct value recorded for each quality instrument calibration in the quality domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each quality instrument calibration record in the quality domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each quality instrument calibration record in the quality domain.',
    `engineering_unit` STRING COMMENT 'Unit of measurement for the calibrated parameter. Ref: EPA SDWA.',
    `expected_reading` DECIMAL(18,2) COMMENT 'Expected reading based on standard. Ref: EPA SDWA.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each quality instrument calibration record in the quality domain.',
    `instrument_parameter` STRING COMMENT 'Parameter being calibrated (e.g., turbidity, chlorine_residual, pH, conductivity). Ref: EPA SDWA.',
    `instrument_serial_number` STRING COMMENT 'Instrument serial number. Ref: EPA SDWA.',
    `instrument_taken_offline` BOOLEAN COMMENT 'Whether instrument was taken offline due to calibration failure. Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: EPA SDWA.',
    `is_passed` BOOLEAN COMMENT 'Whether the calibration met acceptance criteria. Ref: EPA SDWA.',
    `manufacturer_procedure_reference` STRING COMMENT 'Manufacturer calibration procedure reference. Ref: EPA SDWA.',
    `measured_value` DECIMAL(18,2) COMMENT 'The measured value value recorded for each quality instrument calibration in the quality domain.',
    `measured_value_after` DECIMAL(18,2) COMMENT 'Instrument reading after calibration adjustment. Ref: EPA SDWA.',
    `measured_value_before` DECIMAL(18,2) COMMENT 'Instrument reading before calibration adjustment. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each quality instrument calibration record in the quality domain.',
    `quality_instrument_calibration_name` STRING COMMENT 'The quality instrument calibration name used to identify each quality instrument calibration record in the quality domain.',
    `next_calibration_date` TIMESTAMP COMMENT 'The next calibration date associated with each quality instrument calibration record in the quality domain.',
    `next_calibration_due_date` DATE COMMENT 'Next calibration due date. Ref: EPA SDWA.',
    `next_due_date` TIMESTAMP COMMENT 'The next due date associated with each quality instrument calibration record in the quality domain.',
    `notes` STRING COMMENT 'Calibration notes. Ref: EPA SDWA.',
    `number_of_points` STRING COMMENT 'Number of calibration standard points used. Ref: EPA SDWA.',
    `offset` DECIMAL(18,2) COMMENT 'Offset/intercept of calibration curve. Ref: EPA SDWA.',
    `parameter_measured` STRING COMMENT 'Parameter: Turbidity, Chlorine, pH, DO, Conductivity. Ref: EPA SDWA.',
    `parameter_name` STRING COMMENT 'Name of the parameter being measured (e.g., turbidity, chlorine, pH). Ref: EPA SDWA.',
    `pass_fail_flag` BOOLEAN COMMENT 'The pass fail flag value recorded for each quality instrument calibration in the quality domain.',
    `pass_fail_status` STRING COMMENT 'Calibration result (pass, fail, adjusted). Ref: EPA SDWA.',
    `pass_flag` BOOLEAN COMMENT 'The pass flag value recorded for each quality instrument calibration in the quality domain.',
    `passed_flag` BOOLEAN COMMENT 'The passed flag value recorded for each quality instrument calibration in the quality domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each quality instrument calibration in the quality domain.',
    `post_calibration_reading` STRING COMMENT 'Instrument reading after calibration. Ref: EPA SDWA.',
    `pre_calibration_reading` STRING COMMENT 'Instrument reading before calibration. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each quality instrument calibration in the quality domain.',
    `quality_instrument_calibration_number` STRING COMMENT 'The quality instrument calibration number value recorded for each quality instrument calibration in the quality domain.',
    `quality_instrument_calibration_type` STRING COMMENT 'The quality instrument calibration type value recorded for each quality instrument calibration in the quality domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each quality instrument calibration in the quality domain.',
    `r_squared` DECIMAL(18,2) COMMENT 'Coefficient of determination for multi-point calibration. Ref: EPA SDWA.',
    `reagent_expiry_date` TIMESTAMP COMMENT 'Expiry date of calibration reagent. Ref: EPA SDWA.',
    `reagent_lot_number` STRING COMMENT 'Lot number of the reagent or standard used. Ref: EPA SDWA.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each quality instrument calibration in the quality domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each quality instrument calibration in the quality domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each quality instrument calibration in the quality domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each quality instrument calibration record in the quality domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each quality instrument calibration in the quality domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each quality instrument calibration in the quality domain.',
    `result` STRING COMMENT 'Result of the calibration (e.g., pass, fail, adjusted_pass). Ref: EPA SDWA.',
    `slope` DECIMAL(18,2) COMMENT 'Slope of calibration curve (for linear instruments). Ref: EPA SDWA.',
    `ssot_resolution_type` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: EPA SDWA.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'SSOT cross-domain reconciliation link. Ref: EPA SDWA.',
    `standard_concentration` DECIMAL(18,2) COMMENT 'Concentration of standard solution. Ref: EPA SDWA.',
    `standard_expiration_date` DATE COMMENT 'Expiration date of calibration standard. Ref: EPA SDWA.',
    `standard_lot_number` STRING COMMENT 'Lot number of calibration standard. Ref: EPA SDWA.',
    `standard_solution_unit` STRING COMMENT 'Unit of calibration standard. Ref: EPA SDWA.',
    `standard_solution_used` STRING COMMENT 'Reference standard solution used for calibration. Ref: EPA SDWA.',
    `standard_solution_value` DECIMAL(18,2) COMMENT 'Known value of calibration standard. Ref: EPA SDWA.',
    `standard_unit` STRING COMMENT 'Unit of standard concentration. Ref: EPA SDWA.',
    `standard_used` STRING COMMENT 'The standard used value recorded for each quality instrument calibration in the quality domain.',
    `standard_value` DECIMAL(18,2) COMMENT 'Known standard value used. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each quality instrument calibration record in the quality domain.',
    `quality_instrument_calibration_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `tolerance_high` DECIMAL(18,2) COMMENT 'The tolerance high value recorded for each quality instrument calibration in the quality domain.',
    `tolerance_low` DECIMAL(18,2) COMMENT 'The tolerance low value recorded for each quality instrument calibration in the quality domain.',
    `tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable tolerance percentage. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each quality instrument calibration in the quality domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each quality instrument calibration record in the quality domain.',
    CONSTRAINT pk_quality_instrument_calibration PRIMARY KEY(`quality_instrument_calibration_id`)
) COMMENT 'Transactional record of each calibration event performed on an online or field water quality instrument. Captures calibration date/time, instrument ID, calibration type (single-point, multi-point, verification), standard solution used (concentration, lot number, expiry), pre-calibration reading, post-calibration reading, calibration factor applied, technician ID, pass/fail status, and next calibration due date. Ensures data quality and defensibility of continuous monitoring data used for regulatory compliance. [SSOT canonical for laboratory.laboratory_instrument_calibration] [SSOT: reference view of canonical laboratory.laboratory_instrument_calibration] Consolidated: laboratory.laboratory_instrument_calibration is SSOT; this table references it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` (
    `iup_monitoring_result_id` BIGINT COMMENT 'Unique identifier for the industrial user pretreatment monitoring result record. Ref: EPA SDWA.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: IUP monitoring results are based on underlying analytical results. Currently duplicates many analytical_result attributes (result_value, detection_limit, analytical_method, etc.). Adding analytical_re. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier for the NPDES permit under which this industrial user monitoring result is reported. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Identifier for the contaminant or parameter being monitored in this result. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Industrial user monitoring costs are often recovered through IUP permit fees; cost center tracking enables cost recovery analysis, fee justification, and budget management for pretreatment program ope. Ref: EPA SDWA.',
    `industrial_user_id` BIGINT COMMENT 'Identifier for the significant industrial user (SIU) subject to pretreatment monitoring. Ref: EPA SDWA.',
    `industrial_user_permit_id` BIGINT COMMENT 'Identifier for the Industrial User Permit under which this monitoring result was collected. Ref: EPA SDWA.',
    `laboratory_id` BIGINT COMMENT 'Identifier for the laboratory that performed the analysis. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Identifier for the utility employee who collected the sample, if utility-collected. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each iup monitoring result record in the quality domain.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier for the utility employee who reviewed and validated the monitoring result. Ref: EPA SDWA.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Industrial user permit monitoring follows pretreatment program sampling schedules for local limits and categorical standards. Links result to regulatory schedule for compliance determination, enforcem. Ref: EPA SDWA.',
    `special_contract_id` BIGINT COMMENT 'Foreign key linking to service.special_contract. Business justification: Industrial users with special contracts often have negotiated discharge limits, monitoring frequencies, and penalty structures beyond standard IUP permits. IUP monitoring results verify compliance wit. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Identifier linking this monitoring result to the water sample record in the laboratory information management system. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each iup monitoring result record in the quality domain.',
    `categorical_standard_value` DECIMAL(18,2) COMMENT 'The federal categorical pretreatment standard applicable to this industrial user category and parameter, if applicable. Ref: EPA SDWA.',
    `iup_monitoring_result_code` STRING COMMENT 'The iup monitoring result code value recorded for each iup monitoring result in the quality domain.',
    `compliance_status` STRING COMMENT 'The compliance status of this monitoring result relative to the applicable local or categorical pretreatment limit. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|exceedance|pending_review|not_applicable`',
    `composite_duration_hours` DECIMAL(18,2) COMMENT 'The duration in hours over which a composite sample was collected, if applicable. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this monitoring result record was first created in the system. Ref: EPA SDWA.',
    `daily_flow_mgd` DECIMAL(18,2) COMMENT 'The total daily flow in million gallons per day from the industrial user on the sampling date. Ref: EPA SDWA.',
    `iup_monitoring_result_description` STRING COMMENT 'The iup monitoring result description value recorded for each iup monitoring result in the quality domain.',
    `dmr_reporting_period` STRING COMMENT 'The reporting period (e.g., 2024-Q1, 2024-03) for which this result will be included in the DMR. Ref: EPA SDWA.',
    `dmr_reporting_required` BOOLEAN COMMENT 'Indicates whether this monitoring result must be included in the utilitys Discharge Monitoring Report to the regulatory agency. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The effective date associated with each iup monitoring result record in the quality domain.',
    `enforcement_action_triggered` BOOLEAN COMMENT 'Indicates whether this non-compliant result triggered an enforcement action against the industrial user. Ref: EPA SDWA.',
    `exceedance_flag` BOOLEAN COMMENT 'The exceedance flag value recorded for each iup monitoring result in the quality domain.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage by which the result value exceeds the applicable limit, if non-compliant. Ref: EPA SDWA.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The flow rate in gallons per minute at the sampling point during sample collection. Ref: EPA SDWA.',
    `holding_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the required holding time for the parameter. Ref: EPA SDWA.',
    `local_limit_unit` STRING COMMENT 'The unit of measure for the local pretreatment limit. Ref: EPA SDWA.',
    `local_limit_value` DECIMAL(18,2) COMMENT 'The local pretreatment limit established by the utility for this parameter under the Industrial User Permit. Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this monitoring result record. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this monitoring result record was last modified. Ref: EPA SDWA.',
    `monitoring_type` STRING COMMENT 'Indicates whether the sample was collected through industrial user self-monitoring, utility inspection, or third-party sampling. Ref: EPA SDWA.. Valid values are `self_monitoring|utility_collected|third_party|composite|grab`',
    `iup_monitoring_result_name` STRING COMMENT 'The iup monitoring result name used to identify each iup monitoring result record in the quality domain.',
    `parameter_code` STRING COMMENT 'The standardized code for the parameter being monitored, typically aligned with EPA or state regulatory codes. Ref: EPA SDWA.',
    `parameter_name` STRING COMMENT 'The name of the parameter or contaminant being measured (e.g., Biochemical Oxygen Demand (BOD), Chemical Oxygen Demand (COD), Total Suspended Solids (TSS), heavy metals, Fats Oils and Grease (FOG), pH, specific toxics). Ref: EPA SDWA.',
    `permit_limit_value` DECIMAL(18,2) COMMENT 'The permit limit value value recorded for each iup monitoring result in the quality domain.',
    `permit_number` STRING COMMENT 'The externally-known permit number issued to the industrial user for pretreatment compliance. Ref: EPA SDWA.',
    `quality_control_status` STRING COMMENT 'The quality control status of the analytical result, indicating whether QC checks passed. Ref: EPA SDWA.. Valid values are `passed|failed|pending|not_applicable`',
    `remarks` STRING COMMENT 'Additional notes or comments regarding the monitoring result, sample collection, or compliance status. Ref: EPA SDWA.',
    `result_value` DECIMAL(18,2) COMMENT 'The result value value recorded for each iup monitoring result in the quality domain.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'The sample collection timestamp associated with each iup monitoring result record in the quality domain.',
    `sample_type` STRING COMMENT 'The type of sample collected (grab sample, composite sample, or continuous monitoring). Ref: EPA SDWA.. Valid values are `grab|composite|continuous`',
    `sampler_name` STRING COMMENT 'The name of the individual who collected the sample. Ref: EPA SDWA.',
    `sampling_date` DATE COMMENT 'The date on which the industrial user sample was collected for pretreatment monitoring. Ref: EPA SDWA.',
    `sampling_point_description` STRING COMMENT 'Detailed description of the specific sampling location at the industrial user facility. Ref: EPA SDWA.',
    `sampling_point_type` STRING COMMENT 'The type of sampling location where the industrial user sample was collected (influent to facility, effluent from pretreatment unit, process stream, final discharge point, etc.). Ref: EPA SDWA.. Valid values are `influent|effluent|process|discharge|pretreatment_unit|combined`',
    `sampling_time` TIMESTAMP COMMENT 'The precise timestamp when the industrial user sample was collected, including time of day. Ref: EPA SDWA.',
    `iup_monitoring_result_status` STRING COMMENT 'The iup monitoring result status value recorded for each iup monitoring result in the quality domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each iup monitoring result in the quality domain.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this monitoring result record. Ref: EPA SDWA.',
    CONSTRAINT pk_iup_monitoring_result PRIMARY KEY(`iup_monitoring_result_id`)
) COMMENT 'Transactional record of industrial user pretreatment monitoring results collected from significant industrial users (SIUs) under Industrial User Permits (IUPs). Captures industrial user ID, permit number, sampling date, sampling point (influent, effluent, process), parameter (BOD, COD, TSS, heavy metals, FOG, pH, specific toxics), result value, local pretreatment limit, compliance status, and self-monitoring vs. utility-collected designation. Supports pretreatment program compliance and NPDES permit reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` (
    `fog_monitoring_event_id` BIGINT COMMENT 'Unique identifier for the FOG monitoring event record. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FOG inspection program costs (inspector time, equipment, enforcement) are tracked by cost center for program budgeting, cost recovery through fees, and rate case justification of collection system mai. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who conducted the FOG inspection. Ref: EPA SDWA.',
    `grease_interceptor_id` BIGINT COMMENT 'Identifier of the specific grease trap or interceptor being monitored. Ref: EPA SDWA.',
    `inspector_employee_id` BIGINT COMMENT 'Identifier of the employee who conducted the FOG inspection. Ref: EPA SDWA.',
    `pretreatment_iup_id` BIGINT COMMENT 'Foreign key linking to compliance.pretreatment_iup. Business justification: FOG monitoring events enforce pretreatment permit conditions for food service establishments (grease trap/interceptor compliance). This link connects FOG inspections to industrial user permits, essent. Ref: EPA SDWA.',
    `fog_source_id` BIGINT COMMENT 'Identifier of the food service establishment or industrial contributor being inspected. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: FOG monitoring events occur at specific sampling locations. While fog_source_id links to the establishment (cross-domain), sampling_point_id identifies the physical monitoring location within the qual. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each fog monitoring event record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each fog monitoring event record in the quality domain.',
    `best_management_practices_compliant` BOOLEAN COMMENT 'Indicates whether the establishment is following FOG best management practices. Ref: EPA SDWA.',
    `bmp_deficiencies` STRING COMMENT 'Description of any deficiencies in FOG best management practices observed. Ref: EPA SDWA.',
    `fog_monitoring_event_code` STRING COMMENT 'The fog monitoring event code value recorded for each fog monitoring event in the quality domain.',
    `compliance_status` STRING COMMENT 'Compliance status of the establishment with local FOG ordinance requirements. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|conditional|warning`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions required to achieve compliance. Ref: EPA SDWA.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the establishment must complete required corrective actions. Ref: EPA SDWA.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to address inspection findings. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG monitoring event record was created in the system. Ref: EPA SDWA.',
    `days_since_last_pump_out` STRING COMMENT 'Number of days elapsed since the last pump-out service. Ref: EPA SDWA.',
    `fog_monitoring_event_description` STRING COMMENT 'The fog monitoring event description value recorded for each fog monitoring event in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each fog monitoring event record in the quality domain.',
    `effluent_fog_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured concentration of FOG in the effluent discharge in milligrams per liter. Ref: EPA SDWA.',
    `enforcement_action_triggered` BOOLEAN COMMENT 'Indicates whether this inspection triggered an enforcement action due to non-compliance. Ref: EPA SDWA.',
    `enforcement_action_type` STRING COMMENT 'Type of enforcement action taken as a result of the inspection findings. Ref: EPA SDWA.. Valid values are `notice_of_violation|citation|fine|permit_suspension|legal_action|warning`',
    `establishment_type` STRING COMMENT 'Type of food service establishment or industrial contributor. [ENUM-REF-CANDIDATE: restaurant|cafeteria|food_processor|bakery|hotel|hospital|school|industrial — 8 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp associated with each fog monitoring event record in the quality domain.',
    `exceedance_flag` BOOLEAN COMMENT 'The exceedance flag value recorded for each fog monitoring event in the quality domain.',
    `fog_concentration_mg_l` DECIMAL(18,2) COMMENT 'The fog concentration mg l value recorded for each fog monitoring event in the quality domain.',
    `grease_accumulation_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth of accumulated fats, oils, and grease in the interceptor in inches. Ref: EPA SDWA.',
    `grease_accumulation_percentage` DECIMAL(18,2) COMMENT 'Percentage of interceptor capacity filled with FOG accumulation. Ref: EPA SDWA.',
    `inspection_date` DATE COMMENT 'Date when the FOG monitoring inspection was conducted. Ref: EPA SDWA.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the FOG monitoring inspection was performed. Ref: EPA SDWA.',
    `inspection_type` STRING COMMENT 'Type of FOG monitoring inspection conducted. Ref: EPA SDWA.. Valid values are `routine|complaint|follow_up|initial|reinspection|emergency`',
    `inspector_notes` STRING COMMENT 'Additional notes and observations recorded by the inspector during the FOG monitoring event. Ref: EPA SDWA.',
    `interceptor_condition` STRING COMMENT 'Physical condition assessment of the grease interceptor or trap. Ref: EPA SDWA.. Valid values are `good|fair|poor|critical`',
    `interceptor_size_gallons` DECIMAL(18,2) COMMENT 'Capacity of the grease interceptor or trap in gallons. Ref: EPA SDWA.',
    `iup_permit_number` STRING COMMENT 'Industrial user permit number for the establishment if applicable. Ref: EPA SDWA.',
    `last_pump_out_date` DATE COMMENT 'Date when the grease interceptor was last pumped out or cleaned. Ref: EPA SDWA.',
    `limit_value_mg_l` DECIMAL(18,2) COMMENT 'The limit value mg l value recorded for each fog monitoring event in the quality domain.',
    `maintenance_issues_noted` STRING COMMENT 'Description of any maintenance issues or deficiencies observed during the inspection. Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this record. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG monitoring event record was last modified. Ref: EPA SDWA.',
    `fog_monitoring_event_name` STRING COMMENT 'The fog monitoring event name used to identify each fog monitoring event record in the quality domain.',
    `notification_sent_date` DATE COMMENT 'Date when the inspection notification or report was sent to the establishment. Ref: EPA SDWA.',
    `notification_sent_to_establishment` BOOLEAN COMMENT 'Indicates whether an inspection report or notification was sent to the establishment. Ref: EPA SDWA.',
    `ordinance_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the FOG accumulation or concentration exceeded the local ordinance threshold. Ref: EPA SDWA.',
    `photo_documentation_available` BOOLEAN COMMENT 'Indicates whether photographic documentation of the inspection is available. Ref: EPA SDWA.',
    `pump_out_frequency_compliant` BOOLEAN COMMENT 'Indicates whether the establishment is compliant with the required pump-out frequency. Ref: EPA SDWA.',
    `pump_out_service_provider` STRING COMMENT 'Name of the licensed service provider who performed the last pump-out. Ref: EPA SDWA.',
    `reinspection_required` BOOLEAN COMMENT 'Indicates whether a follow-up reinspection is required to verify corrective actions. Ref: EPA SDWA.',
    `reinspection_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up reinspection. Ref: EPA SDWA.',
    `required_pump_out_frequency_days` STRING COMMENT 'Required frequency for pump-out service as mandated by local FOG ordinance, in days. Ref: EPA SDWA.',
    `sso_risk_level` STRING COMMENT 'Assessed risk level of potential sanitary sewer overflow based on FOG accumulation and discharge quality. Ref: EPA SDWA.. Valid values are `low|medium|high|critical`',
    `fog_monitoring_event_status` STRING COMMENT 'The fog monitoring event status value recorded for each fog monitoring event in the quality domain.',
    `violation_code` STRING COMMENT 'Code identifying the specific FOG ordinance violation observed during inspection. Ref: EPA SDWA.',
    `violation_description` STRING COMMENT 'Detailed description of the FOG ordinance violation identified during the inspection. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'User identifier of the person who created this record. Ref: EPA SDWA.',
    CONSTRAINT pk_fog_monitoring_event PRIMARY KEY(`fog_monitoring_event_id`)
) COMMENT 'Transactional record of Fats, Oils, and Grease (FOG) program inspections and monitoring events at food service establishments and industrial grease interceptor sites. Captures inspection date, establishment identifier, interceptor specifications (size, type), grease accumulation measurement, effluent FOG concentration (mg/L), compliance status against local FOG ordinance limits, pump-out frequency verification, maintenance condition assessment, and enforcement action triggered (warning, NOV, permit revocation). Supports FOG program management, sanitary sewer overflow (SSO) prevention, and pretreatment program reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` (
    `compliance_determination_id` BIGINT COMMENT 'Unique identifier for the compliance_determination data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the compliance created by employee referenced by each compliance determination record in the quality domain.',
    `compliance_determined_by_employee_id` BIGINT COMMENT 'Unique identifier for the compliance determined by employee referenced by each compliance determination record in the quality domain.',
    `compliance_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the compliance responsible employee referenced by each compliance determination record in the quality domain.',
    `compliance_reviewed_by_employee_id` BIGINT COMMENT 'Employee who reviewed and approved the determination. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Compliance determinations are contaminant-specific (e.g., compliance determination for lead, for TTHM, etc.). This FK identifies which contaminant the determination applies to. Ref: EPA SDWA.',
    `contaminant_limit_id` BIGINT COMMENT 'FK to quality.contaminant_limit. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Facility for which the determination was made. Ref: EPA SDWA.',
    `monitoring_context_id` BIGINT COMMENT 'FK to quality.monitoring_context. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each compliance determination record in the quality domain.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to compliance.regulatory_agency. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each compliance determination record in the quality domain.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Compliance determinations aggregate analytical results for a specific sampling schedule over a monitoring period. This FK links the compliance determination to the schedule being evaluated, eliminatin. Ref: EPA SDWA.',
    `superseded_compliance_determination_id` BIGINT COMMENT 'Self-referencing FK on compliance_determination (superseded_compliance_determination_id). Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each compliance determination record in the quality domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each compliance determination in the quality domain.',
    `applicable_limit` DECIMAL(18,2) COMMENT 'Applicable MCL or action level. Ref: EPA SDWA.',
    `calculated_value` DECIMAL(18,2) COMMENT 'Calculated compliance value (running annual average, LRAA, 90th percentile). Ref: EPA SDWA.',
    `calculation_method` STRING COMMENT 'Method used for compliance calculation (RAA, LRAA, SMA, 90th percentile). Ref: EPA SDWA.',
    `compliance_determination_category` STRING COMMENT 'The compliance determination category value recorded for each compliance determination in the quality domain.',
    `classification` STRING COMMENT 'The classification value recorded for each compliance determination in the quality domain.',
    `compliance_determination_code` STRING COMMENT 'The compliance determination code value recorded for each compliance determination in the quality domain.',
    `comments` STRING COMMENT 'Analyst comments on the determination. Ref: EPA SDWA.',
    `compliance_basis` STRING COMMENT 'Basis for determination (RAA, single_sample, LRAA, SYS). Ref: EPA SDWA.',
    `compliance_determination_name` STRING COMMENT 'The compliance determination name used to identify each compliance determination record in the quality domain.',
    `compliance_determination_number` STRING COMMENT 'The compliance determination number value recorded for each compliance determination in the quality domain.',
    `compliance_determination_type` STRING COMMENT 'The compliance determination type value recorded for each compliance determination in the quality domain.',
    `compliance_limit` DECIMAL(18,2) COMMENT 'Applicable compliance limit. Ref: EPA SDWA.',
    `compliance_period` STRING COMMENT 'The compliance period value recorded for each compliance determination in the quality domain.',
    `compliance_period_end` DATE COMMENT 'The compliance period end value recorded for each compliance determination in the quality domain.',
    `compliance_period_start` DATE COMMENT 'The compliance period start value recorded for each compliance determination in the quality domain.',
    `compliance_result` STRING COMMENT 'Final compliance result (in-compliance, violation, significant-non-compliance). Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Compliant, violation, pending. Ref: EPA SDWA.',
    `compliance_value` DECIMAL(18,2) COMMENT 'Value used for compliance determination. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each compliance determination in the quality domain.',
    `compliance_determination_description` STRING COMMENT 'The compliance determination description value recorded for each compliance determination in the quality domain.',
    `determination_date` DATE COMMENT 'Date determination was made. Ref: EPA SDWA.',
    `determination_method` STRING COMMENT 'The determination method value recorded for each compliance determination in the quality domain.',
    `determination_notes` STRING COMMENT 'The determination notes value recorded for each compliance determination in the quality domain.',
    `determination_number` STRING COMMENT 'Unique determination reference number. Ref: EPA SDWA.',
    `determination_period_end` DATE COMMENT 'The determination period end value recorded for each compliance determination in the quality domain.',
    `determination_period_start` DATE COMMENT 'The determination period start value recorded for each compliance determination in the quality domain.',
    `determination_result` STRING COMMENT 'Determination result. Ref: EPA SDWA.',
    `determination_status` STRING COMMENT 'Status (compliant, non_compliant, pending, under_review). Ref: EPA SDWA.',
    `determination_type` STRING COMMENT 'Type (MCL, treatment_technique, monitoring, reporting). Ref: EPA SDWA.',
    `determined_value` DECIMAL(18,2) COMMENT 'The determined value value recorded for each compliance determination in the quality domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each compliance determination record in the quality domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each compliance determination record in the quality domain.',
    `engineering_unit` STRING COMMENT 'Unit of measurement (mg/L, ug/L, pCi/L, NTU). Ref: EPA SDWA.',
    `evaluation_period_end` STRING COMMENT 'End of evaluation period. Ref: EPA SDWA.',
    `evaluation_period_start` STRING COMMENT 'Start of evaluation period. Ref: EPA SDWA.',
    `exceedance_count` STRING COMMENT 'Number of exceedances in period. Ref: EPA SDWA.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each compliance determination record in the quality domain.',
    `in_compliance_flag` BOOLEAN COMMENT 'The in compliance flag value recorded for each compliance determination in the quality domain.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: EPA SDWA.',
    `is_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the is compliant condition applies to the compliance determination record.',
    `is_monitoring_complete` BOOLEAN COMMENT 'Flag indicating all required monitoring was completed. Ref: EPA SDWA.',
    `is_violation` BOOLEAN COMMENT 'Whether this determination constitutes a regulatory violation. Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'US, EU, UK, or other regulatory jurisdiction. Ref: EPA SDWA.',
    `limit_value` DECIMAL(18,2) COMMENT 'The limit value value recorded for each compliance determination in the quality domain.',
    `locational_running_annual_average` DECIMAL(18,2) COMMENT 'The locational running annual average value recorded for each compliance determination in the quality domain.',
    `lraa_value` DECIMAL(18,2) COMMENT 'Locational Running Annual Average. Ref: EPA SDWA.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The mcl value value recorded for each compliance determination in the quality domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each compliance determination record in the quality domain.',
    `monitoring_period` STRING COMMENT 'The monitoring period value recorded for each compliance determination in the quality domain.',
    `monitoring_period_end` DATE COMMENT 'The monitoring period end value recorded for each compliance determination in the quality domain.',
    `monitoring_period_end_date` TIMESTAMP COMMENT 'End date of the monitoring period evaluated. Ref: EPA SDWA.',
    `monitoring_period_start` DATE COMMENT 'The monitoring period start value recorded for each compliance determination in the quality domain.',
    `monitoring_period_start_date` TIMESTAMP COMMENT 'Start date of the monitoring period evaluated. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Determination notes. Ref: EPA SDWA.',
    `notification_tier` STRING COMMENT 'Public notification tier (Tier 1, Tier 2, Tier 3). Ref: EPA SDWA.',
    `number_of_exceedances` STRING COMMENT 'Number of MCL/AL exceedances in the period. Ref: EPA SDWA.',
    `number_of_samples` STRING COMMENT 'Total number of samples included in the determination. Ref: EPA SDWA.',
    `number_of_samples_collected` STRING COMMENT 'Number of samples actually collected. Ref: EPA SDWA.',
    `number_of_samples_required` STRING COMMENT 'Number of samples required for the period. Ref: EPA SDWA.',
    `parameter_name` STRING COMMENT 'The parameter name used to identify each compliance determination record in the quality domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each compliance determination in the quality domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each compliance determination in the quality domain.',
    `public_notification_required` BOOLEAN COMMENT 'Whether public notification is required per Tier 1/2/3 rules. Ref: EPA SDWA.',
    `pwsid` STRING COMMENT 'The pwsid value recorded for each compliance determination in the quality domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each compliance determination in the quality domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each compliance determination in the quality domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each compliance determination in the quality domain.',
    `regulatory_citation` STRING COMMENT 'Applicable regulatory citation. Ref: EPA SDWA.',
    `regulatory_limit` STRING COMMENT 'Applicable regulatory limit. Ref: EPA SDWA.',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'Applicable regulatory limit (MCL, MRDL, action level). Ref: EPA SDWA.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each compliance determination in the quality domain.',
    `required_sample_count` STRING COMMENT 'Required number of samples per monitoring schedule. Ref: EPA SDWA.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each compliance determination record in the quality domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each compliance determination in the quality domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each compliance determination in the quality domain.',
    `review_date` TIMESTAMP COMMENT 'Date the determination was reviewed. Ref: EPA SDWA.',
    `rule_citation` STRING COMMENT 'Regulatory rule citation (e.g., 40 CFR 141.64). Ref: EPA SDWA.',
    `running_annual_average` STRING COMMENT 'Running annual average value. Ref: EPA SDWA.',
    `running_average_value` DECIMAL(18,2) COMMENT 'The running average value value recorded for each compliance determination in the quality domain.',
    `sample_count` STRING COMMENT 'Number of samples in evaluation. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each compliance determination record in the quality domain.',
    `compliance_determination_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for compliance value. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each compliance determination record in the quality domain.',
    `violation_flag` BOOLEAN COMMENT 'The violation flag value recorded for each compliance determination in the quality domain.',
    `violation_generated` STRING COMMENT 'Whether a violation was generated. Ref: EPA SDWA.',
    `violation_triggered` BOOLEAN COMMENT 'Whether a violation was triggered by this determination. Ref: EPA SDWA.',
    `violation_type` STRING COMMENT 'Type of violation if applicable (MCL, TT, monitoring, reporting). Ref: EPA SDWA.',
    CONSTRAINT pk_compliance_determination PRIMARY KEY(`compliance_determination_id`)
) COMMENT 'Period-level compliance determination record that aggregates analytical results into a formal compliance status for each contaminant group, monitoring period, and regulatory rule. Captures determination period (monthly, quarterly, annual), contaminant or contaminant group, applicable rule (SDWA, CWA, NPDES), calculation method (single sample max, running annual average, 90th percentile), calculated compliance value, applicable limit, pass/fail status, and determination date. Bridges the gap between individual analytical results and regulatory reporting by providing the formal compliance roll-up that drives CCR preparation, DMR submission, and violation determination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` (
    `qaqc_batch_id` BIGINT COMMENT 'Unique identifier for the qaqc_batch data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `analyte_id` BIGINT COMMENT 'Analyte being measured. Ref: EPA SDWA.',
    `certified_analyst_id` BIGINT COMMENT 'Unique identifier for the certifying analyst referenced by each qaqc batch record in the quality domain.',
    `facility_id` BIGINT COMMENT 'Facility associated with this QA/QC batch. Ref: EPA SDWA.',
    `lab_instrument_id` BIGINT COMMENT 'Unique identifier for the lab instrument referenced by each qaqc batch record in the quality domain.',
    `laboratory_id` BIGINT COMMENT 'FK to laboratory.laboratory. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Employee who performed the analysis. Ref: EPA SDWA.',
    `qaqc_approved_by_employee_id` BIGINT COMMENT 'Employee who approved the QA/QC batch. Ref: EPA SDWA.',
    `qaqc_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the qaqc created by employee referenced by each qaqc batch record in the quality domain.',
    `qaqc_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the qaqc responsible employee referenced by each qaqc batch record in the quality domain.',
    `qaqc_reviewed_by_analyst_id` BIGINT COMMENT 'Analyst who reviewed results. Ref: EPA SDWA.',
    `qaqc_reviewed_by_employee_id` BIGINT COMMENT 'Unique identifier for the qaqc reviewed by employee referenced by each qaqc batch record in the quality domain.',
    `qc_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.qc_batch. Business justification: Quality domains QA/QC batch tracking must reference laboratorys QC batch for method validation and data defensibility. Regulatory audits (EPA, primacy agencies) require tracing quality results to la. Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each qaqc batch record in the quality domain.',
    `reanalysis_qaqc_batch_id` BIGINT COMMENT 'Self-referencing FK on qaqc_batch (reanalysis_qaqc_batch_id). Ref: EPA SDWA.',
    `reviewer_employee_id` BIGINT COMMENT 'Employee who reviewed the batch. Ref: EPA SDWA.',
    `sampling_round_id` BIGINT COMMENT 'Sampling round associated with this QA/QC batch. Ref: EPA SDWA.',
    `test_method_id` BIGINT COMMENT 'FK to laboratory.test_method. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: QA/QC batches group analytical results with their associated samples for quality control purposes. Linking to the primary water_sample in the batch establishes the in-domain relationship and eliminate. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each qaqc batch record in the quality domain.',
    `acceptance_criteria` STRING COMMENT 'QC acceptance criteria applied. Ref: EPA SDWA.',
    `acceptance_criteria_description` STRING COMMENT 'The acceptance criteria description value recorded for each qaqc batch in the quality domain.',
    `acceptance_criteria_met` BOOLEAN COMMENT 'The acceptance criteria met value recorded for each qaqc batch in the quality domain.',
    `acceptance_criteria_met_flag` BOOLEAN COMMENT 'The acceptance criteria met flag value recorded for each qaqc batch in the quality domain.',
    `all_criteria_met` STRING COMMENT 'Whether all QC criteria were met. Ref: EPA SDWA.',
    `all_qc_criteria_met` BOOLEAN COMMENT 'Whether all QC acceptance criteria were met. Ref: EPA SDWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each qaqc batch in the quality domain.',
    `analysis_date` DATE COMMENT 'Date QC samples were analyzed. Ref: EPA SDWA.',
    `analytical_result_count` STRING COMMENT 'Number of analytical results in this batch. Ref: EPA SDWA.',
    `approval_date` TIMESTAMP COMMENT 'Date the batch was approved. Ref: EPA SDWA.',
    `batch_date` TIMESTAMP COMMENT 'The batch date associated with each qaqc batch record in the quality domain.',
    `batch_notes` STRING COMMENT 'The batch notes value recorded for each qaqc batch in the quality domain.',
    `batch_number` STRING COMMENT 'Unique QA/QC batch number. Ref: EPA SDWA.',
    `batch_result` STRING COMMENT 'Batch result. Ref: EPA SDWA.',
    `batch_status` STRING COMMENT 'Status (open, analyzed, reviewed, accepted, rejected). Ref: EPA SDWA.',
    `batch_type` STRING COMMENT 'Type (field_blank, trip_blank, duplicate, spike, split). Ref: EPA SDWA.',
    `blank_acceptance_criteria` STRING COMMENT 'Acceptance criteria for blank. Ref: EPA SDWA.',
    `blank_acceptance_limit` DECIMAL(18,2) COMMENT 'Method blank acceptance limit. Ref: EPA SDWA.',
    `blank_count` STRING COMMENT 'The blank count value recorded for each qaqc batch in the quality domain.',
    `blank_pass_fail` STRING COMMENT 'Pass or Fail for blank. Ref: EPA SDWA.',
    `blank_result` DOUBLE COMMENT 'The blank result value recorded for each qaqc batch in the quality domain.',
    `blank_unit` STRING COMMENT 'Unit of blank result. Ref: EPA SDWA.',
    `qaqc_batch_category` STRING COMMENT 'The qaqc batch category value recorded for each qaqc batch in the quality domain.',
    `classification` STRING COMMENT 'The classification value recorded for each qaqc batch in the quality domain.',
    `qaqc_batch_code` STRING COMMENT 'The qaqc batch code value recorded for each qaqc batch in the quality domain.',
    `collection_date` DATE COMMENT 'Date QC samples were collected. Ref: EPA SDWA.',
    `comments` STRING COMMENT 'Analyst or reviewer comments. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each qaqc batch in the quality domain.',
    `corrective_action_required` STRING COMMENT 'Whether corrective action is needed. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_qualifier` STRING COMMENT 'Data qualifier code: J, B, R, U, etc. Ref: EPA SDWA.',
    `data_qualifier_codes` STRING COMMENT 'Comma-separated data qualifier codes applied. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each qaqc batch in the quality domain.',
    `qaqc_batch_description` STRING COMMENT 'The qaqc batch description value recorded for each qaqc batch in the quality domain.',
    `duplicate_count` STRING COMMENT 'The duplicate count value recorded for each qaqc batch in the quality domain.',
    `duplicate_rpd` DECIMAL(18,2) COMMENT 'The duplicate rpd value recorded for each qaqc batch in the quality domain.',
    `duplicate_rpd_limit_pct` DECIMAL(18,2) COMMENT 'Acceptance limit for duplicate RPD. Ref: EPA SDWA.',
    `duplicate_rpd_pct` DECIMAL(18,2) COMMENT 'The duplicate rpd pct value recorded for each qaqc batch in the quality domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each qaqc batch record in the quality domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each qaqc batch record in the quality domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each qaqc batch record in the quality domain.',
    `fail_count` STRING COMMENT 'Number of QC checks that failed. Ref: EPA SDWA.',
    `field_duplicate_rpd_pct` DECIMAL(18,2) COMMENT 'Field duplicate relative percent difference. Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: EPA SDWA.',
    `is_blank_acceptable` BOOLEAN COMMENT 'Whether the method blank met acceptance criteria. Ref: EPA SDWA.',
    `is_duplicate_acceptable` BOOLEAN COMMENT 'Whether the duplicate met acceptance criteria. Ref: EPA SDWA.',
    `is_spike_acceptable` BOOLEAN COMMENT 'Whether the spike recovery met acceptance criteria. Ref: EPA SDWA.',
    `matrix_spike_duplicate_rpd_pct` DECIMAL(18,2) COMMENT 'Matrix spike duplicate RPD percentage. Ref: EPA SDWA.',
    `matrix_spike_recovery_pct` DECIMAL(18,2) COMMENT 'Matrix spike recovery percentage. Ref: EPA SDWA.',
    `method_name` STRING COMMENT 'Analytical method used (e.g., EPA 524.2, SM 4500-Cl). Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each qaqc batch record in the quality domain.',
    `qaqc_batch_name` STRING COMMENT 'The qaqc batch name used to identify each qaqc batch record in the quality domain.',
    `notes` STRING COMMENT 'Review notes. Ref: EPA SDWA.',
    `number_of_qc_samples` STRING COMMENT 'Number of QC samples in the batch. Ref: EPA SDWA.',
    `number_of_samples` STRING COMMENT 'Number of samples in the batch. Ref: EPA SDWA.',
    `overall_qaqc_status` STRING COMMENT 'Overall QAQC status: Acceptable, Unacceptable, Qualified. Ref: EPA SDWA.',
    `overall_qc_pass` BOOLEAN COMMENT 'Whether all QC criteria were met for the batch. Ref: EPA SDWA.',
    `overall_qc_status` STRING COMMENT 'Overall QC status: Pass, Fail, Conditional Pass. Ref: EPA SDWA.',
    `parameter_name` STRING COMMENT 'Primary parameter or analyte group for the batch. Ref: EPA SDWA.',
    `pass_count` STRING COMMENT 'Number of QC checks that passed. Ref: EPA SDWA.',
    `passed_flag` BOOLEAN COMMENT 'Whether batch passed. Ref: EPA SDWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each qaqc batch in the quality domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each qaqc batch in the quality domain.',
    `qaqc_batch_number` STRING COMMENT 'The qaqc batch number value recorded for each qaqc batch in the quality domain.',
    `qaqc_batch_type` STRING COMMENT 'The qaqc batch type value recorded for each qaqc batch in the quality domain.',
    `qaqc_pass_flag` BOOLEAN COMMENT 'The qaqc pass flag value recorded for each qaqc batch in the quality domain.',
    `qc_pass_flag` BOOLEAN COMMENT 'The qc pass flag value recorded for each qaqc batch in the quality domain.',
    `qc_sample_count` STRING COMMENT 'The qc sample count value recorded for each qaqc batch in the quality domain.',
    `qc_status` STRING COMMENT 'The qc status value recorded for each qaqc batch in the quality domain.',
    `qc_type` STRING COMMENT 'The qc type value recorded for each qaqc batch in the quality domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each qaqc batch in the quality domain.',
    `reanalysis_required_flag` BOOLEAN COMMENT 'The reanalysis required flag value recorded for each qaqc batch in the quality domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each qaqc batch in the quality domain.',
    `recovery_high_pct` DECIMAL(18,2) COMMENT 'High recovery acceptance limit. Ref: EPA SDWA.',
    `recovery_low_pct` DECIMAL(18,2) COMMENT 'Low recovery acceptance limit. Ref: EPA SDWA.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each qaqc batch in the quality domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each qaqc batch in the quality domain.',
    `rejection_reason` STRING COMMENT 'Reason for batch rejection if applicable. Ref: EPA SDWA.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each qaqc batch record in the quality domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each qaqc batch in the quality domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each qaqc batch in the quality domain.',
    `result_summary` STRING COMMENT 'Summary of QA/QC results for the batch. Ref: EPA SDWA.',
    `review_date` DATE COMMENT 'Date results were reviewed. Ref: EPA SDWA.',
    `rpd_limit_pct` DECIMAL(18,2) COMMENT 'Relative percent difference acceptance limit. Ref: EPA SDWA.',
    `rpd_pct` DECIMAL(18,2) COMMENT 'The rpd pct value recorded for each qaqc batch in the quality domain.',
    `sample_count` STRING COMMENT 'Number of samples in batch. Ref: EPA SDWA.',
    `spike_count` STRING COMMENT 'The spike count value recorded for each qaqc batch in the quality domain.',
    `spike_recovery_lower_limit_pct` DECIMAL(18,2) COMMENT 'Lower acceptance limit for spike recovery. Ref: EPA SDWA.',
    `spike_recovery_pct` DECIMAL(18,2) COMMENT 'The spike recovery pct value recorded for each qaqc batch in the quality domain.',
    `spike_recovery_upper_limit_pct` DECIMAL(18,2) COMMENT 'Upper acceptance limit for spike recovery. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each qaqc batch record in the quality domain.',
    `qaqc_batch_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each qaqc batch in the quality domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each qaqc batch record in the quality domain.',
    CONSTRAINT pk_qaqc_batch PRIMARY KEY(`qaqc_batch_id`)
) COMMENT 'Quality assurance and quality control batch record grouping analytical results with their associated QC samples (method blanks, laboratory control samples, matrix spikes, duplicates, surrogate recoveries). Captures batch ID, analytical method, analysis date, QC acceptance criteria, batch-level pass/fail status, corrective action if failed, and data usability assessment. Essential for defending analytical data quality during regulatory audits and ensuring results meet method-specific precision and accuracy requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` (
    `territory_contaminant_monitoring_requirement_id` BIGINT COMMENT 'Primary key for the territory_contaminant_monitoring_requirement association. Ref: Sensus AMI.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to the contaminant being monitored in this territory. Ref: Sensus AMI.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each territory contaminant monitoring requirement record in the quality domain.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each territory contaminant monitoring requirement record in the quality domain.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Territory-specific contaminant monitoring requirements drive the creation and configuration of sampling schedules. This FK links the requirement to the schedule(s) that implement it, enabling tracking. Ref: Sensus AMI.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to the service territory where monitoring requirements apply. Ref: Sensus AMI.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each territory contaminant monitoring requirement record in the quality domain.',
    `territory_contaminant_monitoring_requirement_code` STRING COMMENT 'The territory contaminant monitoring requirement code value recorded for each territory contaminant monitoring requirement in the quality domain.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting the rationale for territory-specific requirements, variance conditions, or special monitoring instructions from the primacy agency. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each territory contaminant monitoring requirement record in the quality domain.',
    `territory_contaminant_monitoring_requirement_description` STRING COMMENT 'The territory contaminant monitoring requirement description value recorded for each territory contaminant monitoring requirement in the quality domain.',
    `effective_date` DATE COMMENT 'Date when this territory-specific monitoring requirement, variance, or action level became effective. Critical for compliance tracking and historical regulatory reporting. Ref: Sensus AMI.',
    `expiration_date` DATE COMMENT 'Date when this territory-specific monitoring requirement, variance, or exemption expires and reverts to standard requirements. Null if permanent. Essential for proactive compliance management. Ref: Sensus AMI.',
    `jurisdiction` STRING COMMENT 'The jurisdiction value recorded for each territory contaminant monitoring requirement in the quality domain.',
    `local_action_level` DECIMAL(18,2) COMMENT 'Action level specific to this territory that may differ from the federal standard due to state primacy agency requirements or local conditions. Exists because state agencies with primacy can set more stringent requirements than federal MCLs. Ref: Sensus AMI.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each territory contaminant monitoring requirement record in the quality domain.',
    `monitoring_frequency` STRING COMMENT 'The monitoring frequency value recorded for each territory contaminant monitoring requirement in the quality domain.',
    `monitoring_frequency_override` STRING COMMENT 'Territory-specific monitoring frequency that overrides the default contaminant monitoring_frequency_code based on primacy agency approval, vulnerability assessment results, or granted waivers. This attribute exists because different territories may have different monitoring requirements for the same contaminant. Ref: Sensus AMI.',
    `territory_contaminant_monitoring_requirement_name` STRING COMMENT 'The territory contaminant monitoring requirement name used to identify each territory contaminant monitoring requirement record in the quality domain.',
    `primacy_agency_override` STRING COMMENT 'Identification of the specific primacy agency (state or EPA regional office) that issued the territory-specific requirement or variance. Necessary because different territories may fall under different primacy jurisdictions. Ref: Sensus AMI.',
    `samples_required_per_period` STRING COMMENT 'The samples required per period value recorded for each territory contaminant monitoring requirement in the quality domain.',
    `territory_contaminant_monitoring_requirement_status` STRING COMMENT 'The territory contaminant monitoring requirement status value recorded for each territory contaminant monitoring requirement in the quality domain.',
    `territory_specific_mcl` DECIMAL(18,2) COMMENT 'Maximum contaminant level specific to this territory, typically more stringent than federal MCL when set by state primacy agencies. This attribute captures jurisdiction-specific regulatory limits that vary by territory. Ref: Sensus AMI.',
    `variance_approval_number` STRING COMMENT 'Official reference number of the variance, waiver, or exemption approval issued by the primacy agency. Used for regulatory correspondence and audit trail. Ref: Sensus AMI.',
    `variance_status` STRING COMMENT 'Current status of any monitoring variance, waiver, or exemption granted by the primacy agency for this contaminant in this territory. Tracks whether the utility has been granted relief from standard monitoring requirements. Ref: Sensus AMI.',
    `vulnerability_assessment_result` STRING COMMENT 'Result of source water vulnerability assessment for this contaminant in this territory. Determines eligibility for monitoring waivers and reduced frequency. This is territory-specific because vulnerability depends on local source water characteristics. Ref: Sensus AMI.',
    CONSTRAINT pk_territory_contaminant_monitoring_requirement PRIMARY KEY(`territory_contaminant_monitoring_requirement_id`)
) COMMENT 'This association product represents the territory-specific monitoring requirements and regulatory variances between contaminants and service territories. It captures jurisdiction-specific monitoring frequencies, action levels, and variance statuses that exist only in the context of a specific contaminant being monitored within a specific service territory. Each record links one contaminant to one service territory with regulatory override attributes that reflect primacy agency decisions, vulnerability assessments, and approved variances.. Existence Justification: In water utility operations, contaminants have different monitoring requirements across service territories based on primacy agency jurisdiction, source water vulnerability assessments, and approved regulatory variances. A single contaminant (e.g., lead) may require quarterly monitoring in one territory but have a waiver for reduced frequency in another territory based on vulnerability assessment results. Conversely, a single service territory must track territory-specific monitoring requirements, action levels, and variance statuses for dozens of regulated contaminants. This is an operational compliance management relationship that utilities actively maintain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` (
    `monitoring_context_id` BIGINT COMMENT 'Primary key for monitoring_context. Ref: EPA SDWA.',
    `parent_monitoring_context_id` BIGINT COMMENT 'Self-referencing FK on monitoring_context (parent_monitoring_context_id). Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each monitoring context record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each monitoring context record in the quality domain.',
    `monitoring_context_code` STRING COMMENT 'Unique business code used to reference the monitoring context in operational systems. Ref: EPA SDWA.',
    `context_type` STRING COMMENT 'Category of the monitoring context indicating the water system segment it applies to. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring context record was first created in the system. Ref: EPA SDWA.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the quality and reliability of the data collected under this context. Ref: EPA SDWA.',
    `monitoring_context_description` STRING COMMENT 'The monitoring context description value recorded for each monitoring context in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each monitoring context record in the quality domain.',
    `effective_end_date` DATE COMMENT 'Date when the monitoring context expires or is retired (null if open‑ended). Ref: EPA SDWA.',
    `effective_start_date` DATE COMMENT 'Date when the monitoring context becomes effective. Ref: EPA SDWA.',
    `geographic_region` STRING COMMENT 'Three‑letter ISO country code representing the region of the monitoring location.',
    `jurisdiction` STRING COMMENT 'The jurisdiction value recorded for each monitoring context in the quality domain.',
    `location_code` STRING COMMENT 'Code identifying the physical location (e.g., treatment plant, reservoir, distribution node) where monitoring occurs. Ref: EPA SDWA.',
    `measurement_parameter` STRING COMMENT 'Water quality parameter measured in this context (e.g., pH, turbidity, chlorine, BOD, COD, TSS, TDS, TOC, DBP, PFAS). [ENUM-REF-CANDIDATE: pH|turbidity|temperature|chlorine|conductivity|BOD|COD|TSS|TDS|TOC|DBP|PFAS — promote to reference product]. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each monitoring context record in the quality domain.',
    `monitoring_context_name` STRING COMMENT 'Human‑readable name describing the monitoring context. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the monitoring context. Ref: EPA SDWA.',
    `regulatory_limit_unit` STRING COMMENT 'Unit associated with the regulatory limit value. Ref: EPA SDWA.',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable value for the measurement parameter as defined by regulatory standards. Ref: EPA SDWA.',
    `regulatory_program` STRING COMMENT 'The regulatory program value recorded for each monitoring context in the quality domain.',
    `sampling_frequency` STRING COMMENT 'How often samples are collected for this monitoring context. Ref: EPA SDWA.',
    `sampling_method` STRING COMMENT 'Technique used to obtain water samples. Ref: EPA SDWA.',
    `monitoring_context_status` STRING COMMENT 'Current lifecycle status of the monitoring context. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'Unit used for the measurement parameter (e.g., mg/L, NTU, pH units, µg/L). Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the monitoring context record. Ref: EPA SDWA.',
    CONSTRAINT pk_monitoring_context PRIMARY KEY(`monitoring_context_id`)
) COMMENT 'Master reference table for monitoring_context. Referenced by monitoring_context_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` (
    `sampling_round_id` BIGINT COMMENT 'Primary key for sampling_round. Ref: EPA SDWA.',
    `certified_analyst_id` BIGINT COMMENT 'Identifier of the laboratory analyst responsible for processing the samples. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Identifier of the water facility or site where the sampling round is performed. Ref: EPA SDWA.',
    `parent_sampling_round_id` BIGINT COMMENT 'Self-referencing FK on sampling_round (parent_sampling_round_id). Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each sampling round record in the quality domain.',
    `regulatory_submission_id` BIGINT COMMENT 'Link to the regulatory compliance report generated from this round. Ref: EPA SDWA.',
    `sampling_plan_id` BIGINT COMMENT 'Reference to the predefined sampling plan governing this round. Ref: EPA SDWA.',
    `sampling_schedule_id` BIGINT COMMENT 'Unique identifier for the sampling schedule referenced by each sampling round record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each sampling round record in the quality domain.',
    `sampling_round_code` STRING COMMENT 'The sampling round code value recorded for each sampling round in the quality domain.',
    `compliance_status` STRING COMMENT 'Regulatory compliance outcome for the round. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sampling round record was first created in the system. Ref: EPA SDWA.',
    `sampling_round_description` STRING COMMENT 'The sampling round description value recorded for each sampling round in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each sampling round record in the quality domain.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact end time of the sampling activities. Ref: EPA SDWA.',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the sampling round was executed or is scheduled to occur. Ref: EPA SDWA.',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the round was initiated as an emergency response. Ref: EPA SDWA.',
    `mcl_exceedance_flag` BOOLEAN COMMENT 'True if any measured parameter exceeds its MCL for the round. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each sampling round record in the quality domain.',
    `sampling_round_name` STRING COMMENT 'The sampling round name used to identify each sampling round record in the quality domain.',
    `notes` STRING COMMENT 'Free‑form comments entered by field staff. Ref: EPA SDWA.',
    `parameters_measured` STRING COMMENT 'Comma‑separated list of water quality parameters (e.g., pH, turbidity, lead) measured in this round. Ref: EPA SDWA.',
    `round_code` STRING COMMENT 'External code used by field crews and regulators to reference the sampling round. Ref: EPA SDWA.',
    `round_end_date` DATE COMMENT 'The round end date associated with each sampling round record in the quality domain.',
    `round_name` STRING COMMENT 'Human‑readable name or description of the sampling round. Ref: EPA SDWA.',
    `round_number` STRING COMMENT 'The round number value recorded for each sampling round in the quality domain.',
    `round_start_date` DATE COMMENT 'The round start date associated with each sampling round record in the quality domain.',
    `round_status` STRING COMMENT 'The round status value recorded for each sampling round in the quality domain.',
    `sample_type` STRING COMMENT 'Category of water being sampled. Ref: EPA SDWA.',
    `samples_collected` STRING COMMENT 'The samples collected value recorded for each sampling round in the quality domain.',
    `samples_planned` STRING COMMENT 'The samples planned value recorded for each sampling round in the quality domain.',
    `sampling_method` STRING COMMENT 'Technique used to collect the water sample. Ref: EPA SDWA.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the sampling round. Ref: EPA SDWA.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact start time of the sampling activities. Ref: EPA SDWA.',
    `sampling_round_status` STRING COMMENT 'Current lifecycle state of the sampling round. Ref: EPA SDWA.',
    `total_samples_collected` STRING COMMENT 'Number of samples actually collected during the round. Ref: EPA SDWA.',
    `total_samples_expected` STRING COMMENT 'Number of individual samples planned for the round. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sampling round record. Ref: EPA SDWA.',
    `weather_conditions` STRING COMMENT 'Brief description of weather during sampling (e.g., sunny, rain). Ref: EPA SDWA.',
    CONSTRAINT pk_sampling_round PRIMARY KEY(`sampling_round_id`)
) COMMENT 'Master reference table for sampling_round. Referenced by sampling_round_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` (
    `contaminant_group_id` BIGINT COMMENT 'Primary key for contaminant_group. Ref: Sensus AMI.',
    `parent_contaminant_group_id` BIGINT COMMENT 'Self-referencing FK on contaminant_group (parent_contaminant_group_id). Ref: Sensus AMI.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each contaminant group record in the quality domain.',
    `water_system_id` BIGINT COMMENT 'Unique identifier for the water system referenced by each contaminant group record in the quality domain.',
    `applicable_standards` STRING COMMENT 'List of standards, guidelines, or regulations that apply to this contaminant group (e.g., EPA MCL, WHO guidelines). Ref: Sensus AMI.',
    `chain_classification` STRING COMMENT 'long-chain vs short-chain PFAS distinction. Ref: Sensus AMI.',
    `chain_length_class` STRING COMMENT 'The chain length class value recorded for each contaminant group in the quality domain.',
    `contaminant_group_code` STRING COMMENT 'The contaminant group code value recorded for each contaminant group in the quality domain.',
    `contaminant_category` STRING COMMENT 'Broad classification of the contaminant group. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first inserted into the lakehouse. Ref: Sensus AMI.',
    `contaminant_group_description` STRING COMMENT 'Detailed description of the contaminant group, its relevance and typical usage. Ref: Sensus AMI.',
    `effective_date` DATE COMMENT 'The effective date associated with each contaminant group record in the quality domain.',
    `effective_from` DATE COMMENT 'Date when the contaminant group definition became effective. Ref: Sensus AMI.',
    `effective_until` DATE COMMENT 'Date when the contaminant group definition expires or is superseded (null if indefinite). Ref: Sensus AMI.',
    `eu_regulatory_framework` STRING COMMENT 'EU regulatory framework (DWD_SUM20, DWD_TOTAL, REACH_RESTRICTION, WFD). Ref: Sensus AMI.',
    `eu_sum_limit_ng_l` DECIMAL(18,2) COMMENT 'EU sum limit for this PFAS group in ng/L (100 for sum-20, 500 for total). Ref: Sensus AMI.',
    `group_category` STRING COMMENT 'The group category value recorded for each contaminant group in the quality domain.',
    `group_code` STRING COMMENT 'Short alphanumeric code used to reference the contaminant group in systems and reports. Ref: Sensus AMI.',
    `group_name` STRING COMMENT 'Human‑readable name of the contaminant group (e.g., Disinfection By‑Products). Ref: Sensus AMI.',
    `hazard_index_components` STRING COMMENT 'PFNA+PFHxS+PFBS+HFPO-DA hazard index members. Ref: Sensus AMI.',
    `hazard_index_group_flag` BOOLEAN COMMENT 'Indicates if this group is the US EPA Hazard Index mixture group. Ref: Sensus AMI.',
    `hazard_index_limit` DECIMAL(18,2) COMMENT 'Hazard Index limit for this group (1.0 for US EPA HI group). Ref: Sensus AMI.',
    `health_effects_summary` STRING COMMENT 'Brief summary of known health impacts associated with exposure to the contaminant group. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the contaminant group is currently in active use within the system. Ref: Sensus AMI.',
    `is_pfas_group` BOOLEAN COMMENT 'Indicates if this group represents a PFAS classification. Ref: Sensus AMI.',
    `max_contaminant_level` DECIMAL(18,2) COMMENT 'Regulatory maximum allowable concentration for the contaminant group. Ref: Sensus AMI.',
    `max_contaminant_level_goal` DECIMAL(18,2) COMMENT 'Health‑based goal concentration for the contaminant group (non‑enforceable). Ref: Sensus AMI.',
    `member_compound_count` STRING COMMENT 'Number of individual PFAS compounds in this group. Ref: Sensus AMI.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each contaminant group record in the quality domain.',
    `monitoring_frequency_days` STRING COMMENT 'Recommended number of days between routine monitoring events for this contaminant group. Ref: Sensus AMI.',
    `contaminant_group_name` STRING COMMENT 'The contaminant group name used to identify each contaminant group record in the quality domain.',
    `pfas_chain_category` STRING COMMENT 'PFAS chain length category for this group (LONG_CHAIN, SHORT_CHAIN, MIXED). Ref: Sensus AMI.',
    `regulatory_citation` STRING COMMENT 'Primary regulatory citation (e.g., 40 CFR 141, EU DWD 2020/2184, REACH Annex XVII). Ref: Sensus AMI.',
    `regulatory_program` STRING COMMENT 'The regulatory program value recorded for each contaminant group in the quality domain.',
    `regulatory_status` STRING COMMENT 'Current regulatory status of the contaminant group under federal or state law. Ref: Sensus AMI.',
    `risk_level` STRING COMMENT 'Overall risk classification based on toxicity, prevalence, and regulatory concern. Ref: Sensus AMI.',
    `contaminant_group_status` STRING COMMENT 'The contaminant group status value recorded for each contaminant group in the quality domain.',
    `typical_concentration_range_high` DECIMAL(18,2) COMMENT 'Upper bound of typical observed concentration range for the contaminant group. Ref: Sensus AMI.',
    `typical_concentration_range_low` DECIMAL(18,2) COMMENT 'Lower bound of typical observed concentration range for the contaminant group. Ref: Sensus AMI.',
    `typical_sources` STRING COMMENT 'Common natural or anthropogenic sources of the contaminants in this group. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for reporting concentrations of this contaminant group. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record. Ref: Sensus AMI.',
    `us_regulatory_framework` STRING COMMENT 'US regulatory framework (NPDWR_MCL, HAZARD_INDEX, UCMR, STATE_SPECIFIC)',
    CONSTRAINT pk_contaminant_group PRIMARY KEY(`contaminant_group_id`)
) COMMENT 'Master reference table for contaminant_group. Referenced by contaminant_group_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_system` (
    `water_system_id` BIGINT COMMENT 'Primary key for water_system. Ref: EPA SDWA.',
    `parent_water_system_id` BIGINT COMMENT 'Self-referencing FK on water_system (parent_water_system_id). Ref: EPA SDWA.',
    `quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the quality sampling point referenced by each water system record in the quality domain.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory referenced by each water system record in the quality domain.',
    `average_daily_consumption_mgd` DECIMAL(18,2) COMMENT 'Average daily water consumption served by the system. Ref: EPA SDWA.',
    `average_daily_production_mgd` DECIMAL(18,2) COMMENT 'Average daily water production volume. Ref: EPA SDWA.',
    `capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum designed water flow capacity. Ref: EPA SDWA.',
    `chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Typical residual chlorine concentration. Ref: EPA SDWA.',
    `classification` STRING COMMENT 'Ownership and governance classification of the water system. Ref: EPA SDWA.',
    `water_system_code` STRING COMMENT 'The water system code value recorded for each water system in the quality domain.',
    `commissioning_date` DATE COMMENT 'Date when the water system entered service. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Current compliance status with water quality regulations. Ref: EPA SDWA.',
    `construction_date` DATE COMMENT 'Date when construction of the water system was completed. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the water system record was created. Ref: EPA SDWA.',
    `decommission_date` DATE COMMENT 'Date when the water system was retired, if applicable. Ref: EPA SDWA.',
    `water_system_description` STRING COMMENT 'The water system description value recorded for each water system in the quality domain.',
    `effective_date` DATE COMMENT 'The effective date associated with each water system record in the quality domain.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the water system is currently active in the system. Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'The jurisdiction value recorded for each water system in the quality domain.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection. Ref: EPA SDWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate. Ref: EPA SDWA.',
    `location_city` STRING COMMENT 'City where the water system is located. Ref: EPA SDWA.',
    `location_state` STRING COMMENT 'State or province of the water system location. Ref: EPA SDWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate. Ref: EPA SDWA.',
    `maintenance_schedule` STRING COMMENT 'Textual description of routine maintenance schedule (e.g., quarterly, annual). Ref: EPA SDWA.',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operational hours between failures. Ref: EPA SDWA.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time to repair a failure. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each water system record in the quality domain.',
    `water_system_name` STRING COMMENT 'Human readable name of the water system. Ref: EPA SDWA.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next inspection. Ref: EPA SDWA.',
    `number_of_units` STRING COMMENT 'Count of major equipment units within the system (e.g., pumps, filters). Ref: EPA SDWA.',
    `owner_organization` STRING COMMENT 'Name of the organization that owns the water system. Ref: EPA SDWA.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the regulatory permit. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'Identifier of the regulatory permit governing the water system. Ref: EPA SDWA.',
    `ph_range` STRING COMMENT 'Typical pH range of output water (e.g., 6.5-8.5). Ref: EPA SDWA.',
    `population_served` STRING COMMENT 'The population served value recorded for each water system in the quality domain.',
    `pwsid` STRING COMMENT 'The pwsid value recorded for each water system in the quality domain.',
    `regulatory_region` STRING COMMENT 'The regulatory region value recorded for each water system in the quality domain.',
    `service_connections_count` STRING COMMENT 'The service connections count value recorded for each water system in the quality domain.',
    `source_type` STRING COMMENT 'Primary source of raw water for the system. Ref: EPA SDWA.',
    `source_water_type` STRING COMMENT 'The source water type value recorded for each water system in the quality domain.',
    `water_system_status` STRING COMMENT 'Current operational status of the water system. Ref: EPA SDWA.',
    `system_code` STRING COMMENT 'Unique alphanumeric code assigned to the water system. Ref: EPA SDWA.',
    `system_status` STRING COMMENT 'The system status value recorded for each water system in the quality domain.',
    `system_type` STRING COMMENT 'Category of the water system based on function. Ref: EPA SDWA.',
    `total_coliforms_cfu_100ml` DECIMAL(18,2) COMMENT 'Typical total coliform count. Ref: EPA SDWA.',
    `treatment_processes` STRING COMMENT 'Comma-separated list of treatment processes applied (e.g., coagulation, filtration, disinfection). Ref: EPA SDWA.',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Typical turbidity measurement in Nephelometric Turbidity Units. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record. Ref: EPA SDWA.',
    `water_quality_category` STRING COMMENT 'Classification of water quality produced. Ref: EPA SDWA.',
    CONSTRAINT pk_water_system PRIMARY KEY(`water_system_id`)
) COMMENT 'Master reference table for water_system. Referenced by water_system_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` (
    `pfas_compound_id` BIGINT COMMENT 'Unique identifier for the pfas compound referenced by each pfas compound record in the quality domain.',
    `cas_number` STRING COMMENT 'The cas number value recorded for each pfas compound in the quality domain.',
    `chain_length` STRING COMMENT 'The chain length value recorded for each pfas compound in the quality domain.',
    `chain_type` STRING COMMENT 'The chain type value recorded for each pfas compound in the quality domain.',
    `compound_code` STRING COMMENT 'The compound code value recorded for each pfas compound in the quality domain.',
    `compound_name` STRING COMMENT 'The compound name used to identify each pfas compound record in the quality domain.',
    `eu_sum_of_20` BOOLEAN COMMENT 'The eu sum of 20 value recorded for each pfas compound in the quality domain.',
    `us_hazard_index` BOOLEAN COMMENT 'The us hazard index value recorded for each pfas compound in the quality domain.',
    `us_mcl_ng_l` DECIMAL(18,2) COMMENT 'The us mcl ng l value recorded for each pfas compound in the quality domain.',
    `us_per_compound_mcl` DOUBLE COMMENT 'The us per compound mcl value recorded for each pfas compound in the quality domain.',
    `us_hazard_index_component` STRING COMMENT 'The us hazard index component value recorded for each pfas compound in the quality domain.',
    `eu_sum_of_20_member` BOOLEAN COMMENT 'The eu sum of 20 member value recorded for each pfas compound in the quality domain.',
    `eu_class_restriction` STRING COMMENT 'The eu class restriction value recorded for each pfas compound in the quality domain.',
    `chain_length_class` STRING COMMENT 'The chain length class value recorded for each pfas compound in the quality domain.',
    CONSTRAINT pk_pfas_compound PRIMARY KEY(`pfas_compound_id`)
) COMMENT 'Data product representing pfas compound within the quality domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_contaminant_group_id` FOREIGN KEY (`contaminant_group_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_group`(`contaminant_group_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_parent_sample_water_sample_id` FOREIGN KEY (`parent_sample_water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_qaqc_batch_id` FOREIGN KEY (`qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_contaminant_group_id` FOREIGN KEY (`contaminant_group_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_group`(`contaminant_group_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_pfas_compound_id` FOREIGN KEY (`pfas_compound_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`pfas_compound`(`pfas_compound_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_monitoring_context_id` FOREIGN KEY (`monitoring_context_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`monitoring_context`(`monitoring_context_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_exceedance_quality_sampling_point_id` FOREIGN KEY (`exceedance_quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_pfas_compound_id` FOREIGN KEY (`pfas_compound_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`pfas_compound`(`pfas_compound_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_qaqc_batch_id` FOREIGN KEY (`qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_turbidity_reading_id` FOREIGN KEY (`turbidity_reading_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`turbidity_reading`(`turbidity_reading_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_qaqc_batch_id` FOREIGN KEY (`qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_round_id` FOREIGN KEY (`sampling_round_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_round`(`sampling_round_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_monitoring_context_id` FOREIGN KEY (`monitoring_context_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`monitoring_context`(`monitoring_context_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_superseded_compliance_determination_id` FOREIGN KEY (`superseded_compliance_determination_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`compliance_determination`(`compliance_determination_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_reanalysis_qaqc_batch_id` FOREIGN KEY (`reanalysis_qaqc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`qaqc_batch`(`qaqc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_sampling_round_id` FOREIGN KEY (`sampling_round_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_round`(`sampling_round_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ADD CONSTRAINT `fk_quality_monitoring_context_parent_monitoring_context_id` FOREIGN KEY (`parent_monitoring_context_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`monitoring_context`(`monitoring_context_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ADD CONSTRAINT `fk_quality_monitoring_context_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ADD CONSTRAINT `fk_quality_monitoring_context_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_parent_sampling_round_id` FOREIGN KEY (`parent_sampling_round_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_round`(`sampling_round_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ADD CONSTRAINT `fk_quality_contaminant_group_parent_contaminant_group_id` FOREIGN KEY (`parent_contaminant_group_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_group`(`contaminant_group_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ADD CONSTRAINT `fk_quality_contaminant_group_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ADD CONSTRAINT `fk_quality_contaminant_group_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_parent_water_system_id` FOREIGN KEY (`parent_water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_pair' = 'asset.asset_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_master_for' = 'asset.asset_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot' = 'asset.asset_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_role' = 'non_canonical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` SET TAGS ('dbx_ssot_secondary' = 'asset.asset_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_pfas_results_also_in_pfas_monitoring' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_pfas' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_per_and_polyfluoroalkyl_substances' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_emerging_contaminants' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_forever_chemicals' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `exceedance_id` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `exceedance_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `exceedance_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `dbp_monitoring_event_id` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Byproduct (DBP) Monitoring Event ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ALTER COLUMN `reported_to_state_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to State Flag');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_contaminant_monitoring' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_epa_npdwr' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_eu_dwd' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_hazard_index' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_mcl_compliance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_ontology' = 'OntoBricks');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_ontology_validated' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_owl_class' = 'PFASMonitoringEvent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_pfas' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_treatment_trigger' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_ucmr5' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'QC Batch');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `laboratory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `quality_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `breakthrough_predicted_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakthrough Predicted');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `chain_length_class` SET TAGS ('dbx_business_glossary_term' = 'Chain Length Class');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `compound_code` SET TAGS ('dbx_business_glossary_term' = 'PFAS Compound Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `compound_name` SET TAGS ('dbx_business_glossary_term' = 'PFAS Compound Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `confirmation_sample_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sample Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `cumulative_hazard_index` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Hazard Index');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `data_validation_level` SET TAGS ('dbx_business_glossary_term' = 'Data Validation Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `detection_limit_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `detection_limit_ppt` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `eu_dwd_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `eu_limit_ng_l` SET TAGS ('dbx_business_glossary_term' = 'EU Limit (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `eu_pfas_total_member_flag` SET TAGS ('dbx_business_glossary_term' = 'EU PFAS Total Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `eu_sum_of_20_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Sum-of-20 Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `eu_sum_of_20_member_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Sum-of-20 Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `eu_total_pfas_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Total PFAS Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `exposure_pathway_code` SET TAGS ('dbx_business_glossary_term' = 'Exposure Pathway');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `exposure_pathway_code` SET TAGS ('dbx_risk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `exposure_pathway_code` SET TAGS ('dbx_exposure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `gac_bed_volumes_treated` SET TAGS ('dbx_business_glossary_term' = 'GAC Bed Volumes Treated');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_index` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_index_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_index_contribution` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Contribution');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_index_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_index_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Member');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_index_total` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Total');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hazard_quotient` SET TAGS ('dbx_business_glossary_term' = 'Hazard Quotient');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hbwc_ng_l` SET TAGS ('dbx_business_glossary_term' = 'HBWC (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `health_based_water_concentration_ppt` SET TAGS ('dbx_business_glossary_term' = 'HBWC');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `health_based_water_concentration_ppt` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `health_based_water_concentration_ppt` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hfpo_da_genx_ng_l` SET TAGS ('dbx_business_glossary_term' = 'HFPO-DA (GenX) Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `hfpo_da_genx_result_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Hfpo Da Genx Result Ng L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `is_detected` SET TAGS ('dbx_business_glossary_term' = 'Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `is_initial_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Initial Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Lab Accreditation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `mcl_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'MCL Exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `mcl_value_ppt` SET TAGS ('dbx_business_glossary_term' = 'MCL Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `monitoring_period_end` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `monitoring_period_start` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `non_detect_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Detect Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `ontology_class_uri` SET TAGS ('dbx_business_glossary_term' = 'Ontology Class URI');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `ontology_class_uri` SET TAGS ('dbx_ontology' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `ontology_class_uri` SET TAGS ('dbx_semantic_web' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_chain_classification` SET TAGS ('dbx_business_glossary_term' = 'PFAS Chain Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_compound_cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_compound_name` SET TAGS ('dbx_business_glossary_term' = 'PFAS Compound Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_sum_of_20_ug_l` SET TAGS ('dbx_business_glossary_term' = 'PFAS Sum-of-20 (EU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfas_total_ug_l` SET TAGS ('dbx_business_glossary_term' = 'PFAS Total (EU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfbs_ng_l` SET TAGS ('dbx_business_glossary_term' = 'PFBS Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfbs_result_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Pfbs Result Ng L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfhxs_ng_l` SET TAGS ('dbx_business_glossary_term' = 'PFHxS Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfhxs_result_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Pfhxs Result Ng L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfna_ng_l` SET TAGS ('dbx_business_glossary_term' = 'PFNA Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfna_result_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Pfna Result Ng L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfoa_ng_l` SET TAGS ('dbx_business_glossary_term' = 'PFOA Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfoa_result_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Pfoa Result Ng L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfos_ng_l` SET TAGS ('dbx_business_glossary_term' = 'PFOS Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pfos_result_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Pfos Result Ng L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'PWSID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `qualifier_code` SET TAGS ('dbx_business_glossary_term' = 'Qualifier Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `quantitation_limit_ppt` SET TAGS ('dbx_business_glossary_term' = 'Quantitation Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `regulatory_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Notified');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `reported_to_state_date` SET TAGS ('dbx_business_glossary_term' = 'State Reporting Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `reporting_limit_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Reporting Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `result_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `result_value_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Result Value (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `result_value_ppt` SET TAGS ('dbx_business_glossary_term' = 'Result Value (ppt)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `risk_receptor_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Receptor');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `risk_receptor_code` SET TAGS ('dbx_risk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `risk_receptor_code` SET TAGS ('dbx_receptor' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sample_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sample_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Location');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sample_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `state_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'State Submission');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_threshold_ng_l` SET TAGS ('dbx_business_glossary_term' = 'Treatment Response Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_threshold_ng_l` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_threshold_ng_l` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Treatment Response Trigger');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_trigger_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_trigger_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_trigger_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_trigger_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_triggered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_triggered` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_triggered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_response_triggered_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_treatment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_technology' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_recommended` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_recommended` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_recommended` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `treatment_technology_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `trigger_level_ppt` SET TAGS ('dbx_business_glossary_term' = 'Trigger Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `ucmr5_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'UCMR5 Submission');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `ucmr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'UCMR Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `us_mcl_ng_l` SET TAGS ('dbx_business_glossary_term' = 'US MCL (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `chain_of_custody_id` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Identifier');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `regulatory_limit_ntu` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Turbidity Limit in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'automated|manual_grab|composite');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature in Celsius');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_value_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Value in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Calculation ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ALTER COLUMN `ct_wtp_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `residual_chlorine_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Chlorine Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `bacteriological_result_id` SET TAGS ('dbx_business_glossary_term' = 'Bacteriological Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_cites' = 'LCRR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_line_material` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `stagnation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Water Stagnation Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_water_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Source Water Quality ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `bulk_water_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Water Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampled By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_location_source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_renamed_from' = 'source_water_intake_id');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `wfd_chemical_status` SET TAGS ('dbx_business_glossary_term' = 'WFD Chemical Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `wfd_ecological_status` SET TAGS ('dbx_business_glossary_term' = 'WFD Ecological Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `wfd_river_basin_district` SET TAGS ('dbx_business_glossary_term' = 'WFD River Basin District');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ALTER COLUMN `wfd_water_body_code` SET TAGS ('dbx_business_glossary_term' = 'WFD Water Body Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Period ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `additional_languages` SET TAGS ('dbx_business_glossary_term' = 'Additional Languages');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `detected_contaminant_count` SET TAGS ('dbx_business_glossary_term' = 'Detected Contaminant Count');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ALTER COLUMN `primacy_agency_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_pair' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_canonical_ref' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_dependent' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_role' = 'non_canonical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_canonical' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for quality_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_issued_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_issued_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `advisory_lifted_date` SET TAGS ('dbx_business_glossary_term' = 'Advisory Lifted Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `alternative_water_source_provided` SET TAGS ('dbx_business_glossary_term' = 'Alt Water Provided');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `boil_water_advisory` SET TAGS ('dbx_business_glossary_term' = 'Boil Water Advisory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `certification_of_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `connections_affected` SET TAGS ('dbx_business_glossary_term' = 'Connections Affected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `corrective_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Taken');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `delivery_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `delivery_methods` SET TAGS ('dbx_business_glossary_term' = 'Delivery Methods');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `do_not_boil_advisory` SET TAGS ('dbx_business_glossary_term' = 'Do Not Boil Advisory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `do_not_drink_advisory` SET TAGS ('dbx_business_glossary_term' = 'Do Not Drink Advisory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_statement` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Statement');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_statement` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `health_effects_statement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `is_issued_on_time` SET TAGS ('dbx_business_glossary_term' = 'Is Issued On Time');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `issue_deadline` SET TAGS ('dbx_business_glossary_term' = 'Issue Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `multilingual_required` SET TAGS ('dbx_business_glossary_term' = 'Multilingual Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `notification_language` SET TAGS ('dbx_business_glossary_term' = 'Notification Language');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `notification_reason` SET TAGS ('dbx_business_glossary_term' = 'Notification Reason');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `public_health_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `public_health_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'PWSID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_canonical_compliance_public_notification_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `quality_compliance_public_notification_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `service_connections_affected` SET TAGS ('dbx_business_glossary_term' = 'Service Connections Affected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_ssot_discriminator' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_canonical' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'compliance.compliance_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `state_approval_date` SET TAGS ('dbx_business_glossary_term' = 'State Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `state_notification_date` SET TAGS ('dbx_business_glossary_term' = 'State Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `submitted_to_agency_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted To Agency Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `submitted_to_regulator_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted To Regulator Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_subdomain' = 'instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Stage');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_subdomain' = 'instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_reference' = 'laboratory.laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_pair' = 'laboratory.laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_canonical_ref' = 'laboratory.laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_dependent' = 'laboratory.laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot' = 'laboratory.laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_role' = 'non_canonical');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_canonical' = 'laboratory.laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_instrument_calibration_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Online Instrument');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_laboratory_instrument_calibration_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `quality_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `acceptable_error_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Error Tolerance Percent');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `acceptance_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Met');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `acceptance_criteria_pct` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria %');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `acceptance_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Tolerance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Pct');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `adjustment_performed` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Performed');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval Days');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `calibration_offset_applied` SET TAGS ('dbx_business_glossary_term' = 'Calibration Offset Applied');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `calibration_slope` SET TAGS ('dbx_business_glossary_term' = 'Calibration Slope');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `calibration_standard_used` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Used');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `instrument_parameter` SET TAGS ('dbx_business_glossary_term' = 'Instrument Parameter');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `is_passed` SET TAGS ('dbx_business_glossary_term' = 'Passed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `manufacturer_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Procedure Reference');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `measured_value_after` SET TAGS ('dbx_business_glossary_term' = 'Post-Calibration Reading');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `measured_value_before` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Reading');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `number_of_points` SET TAGS ('dbx_business_glossary_term' = 'Number of Points');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `offset` SET TAGS ('dbx_business_glossary_term' = 'Calibration Offset');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `parameter_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameter Measured');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `r_squared` SET TAGS ('dbx_business_glossary_term' = 'R-Squared');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `reagent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Reagent Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `reagent_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `slope` SET TAGS ('dbx_business_glossary_term' = 'Calibration Slope');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `standard_solution_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Solution Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ALTER COLUMN `standard_solution_value` SET TAGS ('dbx_business_glossary_term' = 'Standard Solution Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Sampler Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampler_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_point_description` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_point_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_point_type` SET TAGS ('dbx_value_regex' = 'influent|effluent|process|discharge|pretreatment_unit|combined');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `sampling_time` SET TAGS ('dbx_business_glossary_term' = 'Sampling Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` SET TAGS ('dbx_ssot' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_determination');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_determined_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_determined_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `superseded_compliance_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Compliance Determination Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `calculated_value` SET TAGS ('dbx_business_glossary_term' = 'Calculated Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_limit` SET TAGS ('dbx_business_glossary_term' = 'Compliance Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Result');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `is_monitoring_complete` SET TAGS ('dbx_business_glossary_term' = 'Is Monitoring Complete');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `is_violation` SET TAGS ('dbx_business_glossary_term' = 'Is Violation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `lraa_value` SET TAGS ('dbx_business_glossary_term' = 'Lraa Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `notification_tier` SET TAGS ('dbx_business_glossary_term' = 'Notification Tier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `number_of_samples` SET TAGS ('dbx_business_glossary_term' = 'Number of Samples');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `required_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Required Sample Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `rule_citation` SET TAGS ('dbx_business_glossary_term' = 'Rule Citation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_subdomain' = 'instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for qaqc_batch');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_renamed_from' = 'certified_analyst_id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_reviewed_by_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qaqc_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Batch Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `reanalysis_qaqc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reanalysis Qaqc Batch Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `sampling_round_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Round');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `all_qc_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'All Qc Criteria Met');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `analytical_result_count` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `blank_acceptance_limit` SET TAGS ('dbx_business_glossary_term' = 'Blank Acceptance Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `data_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Data Qualifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `duplicate_rpd_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Duplicate RPD Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `is_blank_acceptable` SET TAGS ('dbx_business_glossary_term' = 'Blank Acceptable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `is_duplicate_acceptable` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Acceptable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `is_spike_acceptable` SET TAGS ('dbx_business_glossary_term' = 'Spike Acceptable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `method_name` SET TAGS ('dbx_business_glossary_term' = 'Method Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `overall_qc_pass` SET TAGS ('dbx_business_glossary_term' = 'Overall QC Pass');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `overall_qc_status` SET TAGS ('dbx_business_glossary_term' = 'Overall QC Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `pass_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `spike_recovery_lower_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Spike Recovery Lower Limit Pct');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ALTER COLUMN `spike_recovery_upper_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Spike Recovery Upper Limit Pct');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_association_edges' = 'quality.contaminant,service.service_territory');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Context Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `parent_monitoring_context_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Monitoring Context Id');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `regulatory_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Unit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `monitoring_context_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_context` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_subdomain' = 'sampling_operations');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `sampling_round_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Round Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `parent_sampling_round_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sampling Round Id');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ALTER COLUMN `round_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `contaminant_group_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Group Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `parent_contaminant_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contaminant Group Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `contaminant_category` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `contaminant_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `eu_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'EU Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `eu_sum_limit_ng_l` SET TAGS ('dbx_business_glossary_term' = 'EU Sum Limit (ng/L)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `group_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `hazard_index_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Group');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `hazard_index_limit` SET TAGS ('dbx_business_glossary_term' = 'Hazard Index Limit');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `health_effects_summary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `is_pfas_group` SET TAGS ('dbx_business_glossary_term' = 'PFAS Group Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `max_contaminant_level` SET TAGS ('dbx_business_glossary_term' = 'Max Contaminant Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `max_contaminant_level_goal` SET TAGS ('dbx_business_glossary_term' = 'Max Contaminant Level Goal');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `member_compound_count` SET TAGS ('dbx_business_glossary_term' = 'Member Compound Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `monitoring_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Days');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `pfas_chain_category` SET TAGS ('dbx_business_glossary_term' = 'PFAS Chain Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `typical_concentration_range_high` SET TAGS ('dbx_business_glossary_term' = 'Typical Concentration Range High');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `typical_concentration_range_low` SET TAGS ('dbx_business_glossary_term' = 'Typical Concentration Range Low');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `typical_sources` SET TAGS ('dbx_business_glossary_term' = 'Typical Sources');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_group` ALTER COLUMN `us_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'US Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `parent_water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Water System Id');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` SET TAGS ('dbx_subdomain' = 'contaminant_standards');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `us_per_compound_mcl` SET TAGS ('dbx_framework' = 'US');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `us_per_compound_mcl` SET TAGS ('dbx_measure' = 'mcl');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `us_hazard_index_component` SET TAGS ('dbx_framework' = 'US');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `us_hazard_index_component` SET TAGS ('dbx_measure' = 'hazard_index');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `eu_sum_of_20_member` SET TAGS ('dbx_framework' = 'EU');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `eu_sum_of_20_member` SET TAGS ('dbx_measure' = 'sum_of_20');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `eu_class_restriction` SET TAGS ('dbx_framework' = 'EU');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `eu_class_restriction` SET TAGS ('dbx_measure' = 'class_restriction');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_compound` ALTER COLUMN `chain_length_class` SET TAGS ('dbx_classification' = 'long_chain_vs_short_chain');
