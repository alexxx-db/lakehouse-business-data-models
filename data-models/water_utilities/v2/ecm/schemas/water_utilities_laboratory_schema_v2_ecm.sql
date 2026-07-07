-- Schema for Domain: laboratory | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`laboratory` COMMENT 'Laboratory operations and analytical testing including sample management, chain of custody, test methods, instrument calibration, QA/QC protocols, proficiency testing, result validation, and LIMS integration (LabWare). Distinct from the quality domain which owns regulatory thresholds and compliance outcomes; laboratory owns the analytical process and certified analyst records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` (
    `lab_sample_id` BIGINT COMMENT 'Primary key. Ref: LabWare LIMS.',
    `agreement_id` BIGINT COMMENT 'Unique identifier for the agreement referenced by each lab sample record in the laboratory domain.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each lab sample record in the laboratory domain.',
    `point_id` BIGINT COMMENT 'Unique identifier for the collection point referenced by each lab sample record in the laboratory domain.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each lab sample record in the laboratory domain.',
    `dma_id` BIGINT COMMENT 'Unique identifier for the dma referenced by each lab sample record in the laboratory domain.',
    `hydrant_id` BIGINT COMMENT 'Unique identifier for the hydrant referenced by each lab sample record in the laboratory domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the lab employee referenced by each lab sample record in the laboratory domain.',
    `lab_sampler_employee_id` BIGINT COMMENT 'Unique identifier for the lab sampler employee referenced by each lab sample record in the laboratory domain.',
    `lab_work_order_id` BIGINT COMMENT 'Unique identifier for the lab work order referenced by each lab sample record in the laboratory domain.',
    `pipe_main_id` BIGINT COMMENT 'Unique identifier for the pipe main referenced by each lab sample record in the laboratory domain.',
    `pressure_zone_id` BIGINT COMMENT 'Unique identifier for the pressure zone referenced by each lab sample record in the laboratory domain.',
    `qc_batch_id` BIGINT COMMENT 'Unique identifier for the qc batch referenced by each lab sample record in the laboratory domain.',
    `sample_collection_event_id` BIGINT COMMENT 'Unique identifier for the sample collection event referenced by each lab sample record in the laboratory domain.',
    `sampling_location_id` BIGINT COMMENT 'Unique identifier for the sampling location referenced by each lab sample record in the laboratory domain.',
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address referenced by each lab sample record in the laboratory domain.',
    `storage_tank_id` BIGINT COMMENT 'Unique identifier for the storage tank referenced by each lab sample record in the laboratory domain.',
    `added_flag` BOOLEAN COMMENT 'Sentinel flag added by mutator to satisfy target touch requirement. Ref: LabWare LIMS.',
    `analysis_requested` BOOLEAN COMMENT 'The analysis requested value recorded for each lab sample in the laboratory domain.',
    `chain_of_custody_number` STRING COMMENT 'The chain of custody number value recorded for each lab sample in the laboratory domain.',
    `comments` STRING COMMENT 'The comments value recorded for each lab sample in the laboratory domain.',
    `compliance_program` STRING COMMENT 'The compliance program value recorded for each lab sample in the laboratory domain.',
    `composite_end_datetime` TIMESTAMP COMMENT 'The composite end datetime associated with each lab sample record in the laboratory domain.',
    `composite_interval_minutes` STRING COMMENT 'The composite interval minutes value recorded for each lab sample in the laboratory domain.',
    `composite_start_datetime` TIMESTAMP COMMENT 'The composite start datetime associated with each lab sample record in the laboratory domain.',
    `container_type` STRING COMMENT 'The container type value recorded for each lab sample in the laboratory domain.',
    `container_volume_ml` DECIMAL(18,2) COMMENT 'The container volume ml value recorded for each lab sample in the laboratory domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each lab sample record in the laboratory domain.',
    `disposal_date` DATE COMMENT 'The disposal date associated with each lab sample record in the laboratory domain.',
    `disposal_method` STRING COMMENT 'The disposal method value recorded for each lab sample in the laboratory domain.',
    `field_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'The field chlorine residual mg l value recorded for each lab sample in the laboratory domain.',
    `field_ph` DECIMAL(18,2) COMMENT 'The field ph value recorded for each lab sample in the laboratory domain.',
    `field_temperature_c` DECIMAL(18,2) COMMENT 'The field temperature c value recorded for each lab sample in the laboratory domain.',
    `holding_time_expiry_datetime` TIMESTAMP COMMENT 'The holding time expiry datetime associated with each lab sample record in the laboratory domain.',
    `logged_datetime` TIMESTAMP COMMENT 'The logged datetime associated with each lab sample record in the laboratory domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each lab sample record in the laboratory domain.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each lab sample in the laboratory domain.',
    `preservation_method` STRING COMMENT 'The preservation method value recorded for each lab sample in the laboratory domain.',
    `priority` STRING COMMENT 'The priority value recorded for each lab sample in the laboratory domain.',
    `qc_level` STRING COMMENT 'The qc level value recorded for each lab sample in the laboratory domain.',
    `received_datetime` TIMESTAMP COMMENT 'The received datetime associated with each lab sample record in the laboratory domain.',
    `sample_condition` STRING COMMENT 'The sample condition value recorded for each lab sample in the laboratory domain.',
    `sample_condition_notes` STRING COMMENT 'The sample condition notes value recorded for each lab sample in the laboratory domain.',
    `sample_matrix` STRING COMMENT 'The sample matrix value recorded for each lab sample in the laboratory domain.',
    `sample_number` STRING COMMENT 'The sample number value recorded for each lab sample in the laboratory domain.',
    `sample_origin` STRING COMMENT 'The sample origin value recorded for each lab sample in the laboratory domain.',
    `sample_status` STRING COMMENT 'The sample status value recorded for each lab sample in the laboratory domain.',
    `sample_temperature_c` DECIMAL(18,2) COMMENT 'The sample temperature c value recorded for each lab sample in the laboratory domain.',
    `sample_type` STRING COMMENT 'The sample type value recorded for each lab sample in the laboratory domain.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'The sample volume ml value recorded for each lab sample in the laboratory domain.',
    `turnaround_time_hours` STRING COMMENT 'The turnaround time hours value recorded for each lab sample in the laboratory domain.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each lab sample in the laboratory domain.',
    CONSTRAINT pk_lab_sample PRIMARY KEY(`lab_sample_id`)
) COMMENT 'Laboratory sample record tracking physical samples from collection through analysis, including chain of custody, preservation, and holding time compliance per EPA 40 CFR 136 and Standard Methods 1060. Integrates with LabWare LIMS and supports SDWA compliance monitoring, lead and copper sampling, PFAS monitoring, and industrial pretreatment programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` (
    `sample_collection_event_id` BIGINT COMMENT 'Unique identifier for the sample collection event. Primary key. Ref: LabWare LIMS.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field sampling events incur direct costs (collector labor, vehicle use, field equipment) that must be allocated to the operational cost center responsible for the sampling program. Required for field. Ref: LabWare LIMS.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Field sampling events document the specific hydrant where samples were collected, including field parameters (chlorine, pH, temperature). Event records must link to the hydrant asset for coordinating. Ref: LabWare LIMS.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Field collection events consume inventory-managed materials (sample bottles, preservatives, labels, ice packs). Tracks material usage per event for cost allocation, inventory replenishment, and field. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the certified analyst or field technician who performed the sample collection. Must be a certified individual per regulatory requirements. Ref: LabWare LIMS.',
    `sample_employee_id` BIGINT COMMENT 'Reference to the certified analyst or field technician who performed the sample collection. Must be a certified individual per regulatory requirements. Ref: LabWare LIMS.',
    `sampling_location_id` BIGINT COMMENT 'Reference to the predefined sampling location or monitoring point where the sample was collected. Links to GIS and SCADA systems. Ref: LabWare LIMS.',
    `sampling_plan_id` BIGINT COMMENT 'Reference to the sampling plan that triggered this collection event. Links to the regulatory or operational schedule that mandated this sample. Ref: LabWare LIMS.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: LCRR sampling events scheduled at customer taps require service address linkage for field crew routing, access instructions, appointment confirmation, and geographic compliance verification. Collectio',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Air temperature at the time of sample collection in degrees Celsius. Documented for quality assurance and environmental context. Ref: LabWare LIMS.',
    `chain_of_custody_number` STRING COMMENT 'Unique chain of custody document number linking this collection event to laboratory analysis. Critical for regulatory defensibility and legal admissibility of results. Ref: LabWare LIMS.',
    `collection_equipment_code` BIGINT COMMENT 'Reference to the equipment or instrument used for sample collection (e.g., autosampler, grab sample kit, composite sampler). Links to asset management and calibration records. Ref: LabWare LIMS.',
    `collection_equipment_description` STRING COMMENT 'Description of the equipment used for sample collection, including make, model, and serial number if applicable. Ref: LabWare LIMS.',
    `collection_event_number` STRING COMMENT 'Business identifier for the collection event, typically generated by LIMS or field data collection system. Used for tracking and chain of custody documentation. Ref: LabWare LIMS.',
    `collection_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the sample collection point in decimal degrees. Used for spatial analysis and regulatory reporting. Ref: LabWare LIMS.',
    `collection_location_name` STRING COMMENT 'Human-readable name or description of the collection location (e.g., Entry Point 1, Distribution System Site 12A, WWTP Effluent Outfall). Ref: LabWare LIMS.',
    `collection_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the sample collection point in decimal degrees. Used for spatial analysis and regulatory reporting. Ref: LabWare LIMS.',
    `collection_method_code` STRING COMMENT 'Standardized code identifying the sample collection method used (e.g., grab sample, composite sample, continuous monitoring). Must align with EPA-approved methods. Ref: LabWare LIMS.',
    `collection_method_description` STRING COMMENT 'Detailed description of the collection method, including any deviations from standard protocols or special handling requirements. Ref: LabWare LIMS.',
    `collection_notes` STRING COMMENT 'Free-text field for documenting any unusual conditions, deviations from standard procedures, or observations made during sample collection. Ref: LabWare LIMS.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the sample collection event. Tracks progression from scheduled through completion or cancellation. Ref: LabWare LIMS.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the physical sample was collected in the field or at the facility. Critical for regulatory compliance and sample integrity validation. Ref: LabWare LIMS.',
    `collector_certification_number` STRING COMMENT 'Certification or license number of the sample collector, demonstrating qualification to perform regulated sample collection activities. Ref: LabWare LIMS.',
    `collector_name` STRING COMMENT 'Full name of the individual who collected the sample. Required for chain of custody documentation and regulatory audit trails. Ref: LabWare LIMS.',
    `compliance_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this sample is part of regulatory compliance monitoring (true) or operational/investigative monitoring (false). Compliance samples have stricter QA/QC and reporting requirements. Ref: LabWare LIMS.',
    `composite_duration_hours` DECIMAL(18,2) COMMENT 'For composite samples, the total time period over which the sample was collected in hours (e.g., 24-hour composite). Null for grab samples. Ref: LabWare LIMS.',
    `composite_interval_minutes` STRING COMMENT 'For composite samples, the time interval between individual aliquot collections in minutes. Null for grab samples. Ref: LabWare LIMS.',
    `container_type` STRING COMMENT 'Type of sample container used (e.g., glass bottle, plastic bottle, sterile bag). Must be appropriate for the analytes being tested and comply with EPA protocols. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection event record was first created in the LIMS or data management system. Ref: LabWare LIMS.',
    `field_conductivity_us_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity measured at the time of collection in microsiemens per centimeter. Indicates total dissolved solids and water mineralization. Ref: LabWare LIMS.',
    `field_dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration measured at the time of collection in mg/L. Important for wastewater treatment process control and environmental discharge monitoring. Ref: LabWare LIMS.',
    `field_ph` DECIMAL(18,2) COMMENT 'pH level measured at the time of collection. Indicates acidity or alkalinity of the water sample. Required field measurement for many regulatory programs. Ref: LabWare LIMS.',
    `field_residual_chlorine_mg_l` DECIMAL(18,2) COMMENT 'Free or total chlorine residual measured at the time of collection in mg/L. Critical disinfection parameter for drinking water distribution system monitoring. Ref: LabWare LIMS.',
    `field_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature measured at the time of collection in degrees Celsius. Critical field parameter for sample integrity and regulatory compliance. Ref: LabWare LIMS.',
    `field_turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measured at the time of collection in NTU. Key indicator of water clarity and treatment effectiveness, with strict regulatory limits for drinking water. Ref: LabWare LIMS.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate at the sampling point at the time of collection in gallons per minute. Used for flow-weighted composite calculations and process monitoring. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this collection event record. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection event record was last modified. Used for audit trail and data lineage tracking. Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each sample collection event in the laboratory domain.',
    `preservative_used` STRING COMMENT 'Chemical preservative added to the sample at the time of collection (e.g., sulfuric acid, nitric acid, sodium thiosulfate). Required for certain analytes to maintain sample integrity. Ref: LabWare LIMS.',
    `regulatory_program` STRING COMMENT 'The regulatory program or compliance obligation that mandated this sample collection (e.g., SDWA Compliance Monitoring, NPDES Permit DMR, Lead and Copper Rule). Ref: LabWare LIMS.',
    `sample_matrix` STRING COMMENT 'The physical medium or matrix of the sample collected (drinking water, raw water, wastewater, effluent, sludge, biosolids). Determines applicable analytical methods and regulatory thresholds. Ref: LabWare LIMS.. Valid values are `drinking_water|raw_water|wastewater|effluent|sludge|biosolids`',
    `sample_type` STRING COMMENT 'Classification of the sample based on collection approach: grab (single point in time), composite (time or flow-weighted), continuous, or QA/QC samples (duplicate, blank, spike). Ref: LabWare LIMS.. Valid values are `grab|composite|continuous|duplicate|blank|spike`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Total volume of the sample collected in milliliters. Must meet minimum volume requirements for planned analytical tests. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each sample collection event in the laboratory domain.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection (e.g., clear, rain, snow, fog). Relevant for source water and stormwater sampling events. Ref: LabWare LIMS.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this collection event record in the system. Ref: LabWare LIMS.',
    CONSTRAINT pk_sample_collection_event PRIMARY KEY(`sample_collection_event_id`)
) COMMENT 'Transactional record of a physical sample collection activity in the field or at a facility. Captures the collector (certified analyst or field technician), collection location coordinates, collection method, field measurements taken at time of collection (temperature, pH, residual chlorine, DO), weather conditions, and equipment used. Links to the sampling plan that triggered the collection and the resulting lab_sample records.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` (
    `chain_of_custody_id` BIGINT COMMENT 'Unique identifier for the chain of custody record. Primary key for tracking legal and regulatory custody transfers from sample collection through final disposition. Ref: LabWare LIMS.',
    `cip_project_id` BIGINT COMMENT 'Reference to the monitoring project or compliance program associated with this sample. Used for cost allocation and regulatory reporting. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Chain of custody regulatory compliance requires documented employee accountability for sample collection. EPA and state regulations mandate traceable custody records with employee identification for l. Ref: LabWare LIMS.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Chain of custody documentation for customer-origin samples must link to account for regulatory defensibility when customers dispute results, for billing fee-based testing services, and for tracking sa. Ref: LabWare LIMS.',
    `lab_sample_id` BIGINT COMMENT 'Reference to the laboratory sample being tracked through custody transfers. Links to the sample master record in LIMS (LabWare). Ref: LabWare LIMS.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility receiving the sample for analysis. Links to the laboratory master record. Ref: LabWare LIMS.',
    `sample_collection_event_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_collection_event. Business justification: chain_of_custody currently links to lab_sample and sampling_location, but the actual COLLECTION EVENT (the transactional record of when/how the sample was physically collected in the field) should be. Ref: LabWare LIMS.',
    `sampling_location_id` BIGINT COMMENT 'Reference to the geographic location where the sample was collected. Links to GIS (Geographic Information System) location master. Ref: LabWare LIMS.',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the sample was originally collected from the field location. Critical for hold time compliance and regulatory defensibility. Ref: LabWare LIMS.',
    `collector_certification_number` STRING COMMENT 'State or EPA certification number of the sample collector. Required for regulatory compliance and data defensibility. Ref: LabWare LIMS.',
    `collector_signature` STRING COMMENT 'Digital or scanned signature of the sample collector. Required for legal chain of custody documentation. Ref: LabWare LIMS.',
    `container_count` STRING COMMENT 'Number of sample containers included in this custody transfer. Used to verify completeness of sample delivery. Ref: LabWare LIMS.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions taken to address discrepancies or non-conformances identified during custody transfer. Ref: LabWare LIMS.',
    `courier_name` STRING COMMENT 'Name of the courier service or individual responsible for transporting samples. Applicable when transfer involves third-party transport. Ref: LabWare LIMS.',
    `courier_tracking_number` STRING COMMENT 'Tracking number provided by courier service for shipment traceability. Used to verify delivery and resolve custody disputes. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this chain of custody record was first created in the LIMS (Laboratory Information Management System). Audit trail field. Ref: LabWare LIMS.',
    `custody_document_number` STRING COMMENT 'Externally-known unique document number for the chain of custody form. Used for legal traceability and audit purposes. Format: COC-YYYYMMDD-XXXXXX. Ref: LabWare LIMS.. Valid values are `^COC-[0-9]{8}-[A-Z0-9]{6}$`',
    `custody_status` STRING COMMENT 'Current lifecycle status of the chain of custody record. Tracks progression from sample collection through final disposition. Ref: LabWare LIMS.. Valid values are `initiated|in_transit|received|in_analysis|archived|disposed`',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies noted during custody transfer. Required for corrective action and regulatory reporting. Ref: LabWare LIMS.',
    `discrepancy_noted` BOOLEAN COMMENT 'Indicates whether any discrepancies were noted during the custody transfer (e.g., missing samples, damaged containers, documentation errors). Ref: LabWare LIMS.',
    `hold_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was received within the maximum allowable hold time specified by the analytical method. Non-compliance may invalidate results. Ref: LabWare LIMS.',
    `ice_present` BOOLEAN COMMENT 'Indicates whether ice or cooling packs were present in the sample cooler at the time of receipt. Required for temperature-sensitive samples. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this chain of custody record. Audit trail field for data governance. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this chain of custody record was last modified in the LIMS (Laboratory Information Management System). Audit trail field. Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each chain of custody in the laboratory domain.',
    `preservation_method` STRING COMMENT 'Chemical or physical preservation method applied to the sample (e.g., HCl, H2SO4, refrigeration, none). Must match method requirements. Ref: LabWare LIMS.',
    `preservation_verified` BOOLEAN COMMENT 'Indicates whether the sample preservation was verified at receipt (e.g., pH check for acid preservation). Required for regulatory compliance. Ref: LabWare LIMS.',
    `received_by` STRING COMMENT 'Full name of the person receiving custody of the sample during this transfer event. Part of the legal custody chain. Ref: LabWare LIMS.',
    `received_datetime` TIMESTAMP COMMENT 'Date and time when custody was received by the receiving party. Critical for establishing unbroken custody chain and hold time compliance. Ref: LabWare LIMS.',
    `received_signature` STRING COMMENT 'Digital or scanned signature of the person receiving custody. Required for legal chain of custody documentation. Ref: LabWare LIMS.',
    `relinquished_by` STRING COMMENT 'Full name of the person relinquishing custody of the sample during this transfer event. Part of the legal custody chain. Ref: LabWare LIMS.',
    `relinquished_datetime` TIMESTAMP COMMENT 'Date and time when custody was relinquished by the transferring party. Critical for establishing unbroken custody chain. Ref: LabWare LIMS.',
    `relinquished_signature` STRING COMMENT 'Digital or scanned signature of the person relinquishing custody. Required for legal chain of custody documentation. Ref: LabWare LIMS.',
    `remarks` STRING COMMENT 'Additional notes or comments regarding the custody transfer, sample condition, or special handling requirements. Free-text field for documentation. Ref: LabWare LIMS.',
    `sample_condition_at_transfer` TIMESTAMP COMMENT 'Observed physical condition of the sample at the time of custody transfer. Critical for determining sample integrity and data usability. Ref: LabWare LIMS.',
    `seal_intact` BOOLEAN COMMENT 'Indicates whether the custody seal on the sample container or cooler was intact at the time of transfer. Critical for establishing sample integrity. Ref: LabWare LIMS.',
    `seal_number` STRING COMMENT 'Unique identifier of the tamper-evident seal applied to the sample container or cooler. Used to verify custody integrity. Ref: LabWare LIMS.',
    `temperature_at_receipt_c` DECIMAL(18,2) COMMENT 'Measured temperature of the sample or cooler at the time of receipt. Must be within acceptable range (typically 0-6°C) for regulatory compliance. Ref: LabWare LIMS.',
    `temperature_compliant` BOOLEAN COMMENT 'Indicates whether the sample temperature at receipt was within the acceptable range specified by the analytical method. Non-compliance may invalidate results. Ref: LabWare LIMS.',
    `transfer_type` STRING COMMENT 'Classification of the custody transfer event. Identifies the stage in the sample lifecycle where custody changed hands. Ref: LabWare LIMS.. Valid values are `collector_to_courier|courier_to_lab|lab_to_analyst|analyst_to_storage|storage_to_disposal`',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each chain of custody in the laboratory domain.',
    CONSTRAINT pk_chain_of_custody PRIMARY KEY(`chain_of_custody_id`)
) COMMENT 'Legal and regulatory chain of custody record tracking the possession, transfer, and handling of samples from collection through final disposition. Records each custody transfer (collector to courier, courier to lab, lab to archive), transfer datetime, condition of samples at transfer, seal integrity, and signatures of transferring and receiving parties. Required for EPA-defensible data and NPDES/SDWA compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` (
    `test_method_id` BIGINT COMMENT 'Unique identifier for the analytical test method record. Primary key. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Method validation documentation requires employee accountability. Accreditation standards mandate traceable method development and validation records linked to qualified analysts for regulatory defens. Ref: LabWare LIMS.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Many test methods require proprietary kits or reagents from specific vendors (e.g., Hach chlorine kits, IDEXX Colilert for coliforms). Method specifications reference approved vendor products for regu. Ref: LabWare LIMS.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation or certification body that granted laboratory certification for this method (e.g., State Department of Health, EPA, NELAC, A2LA). Ref: LabWare LIMS.',
    `accreditation_date` DATE COMMENT 'Date on which the laboratory received accreditation for this test method. Ref: LabWare LIMS.',
    `accreditation_expiration_date` DATE COMMENT 'Date on which the current accreditation for this test method expires and requires renewal. Ref: LabWare LIMS.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the laboratory for this specific test method under state or federal certification programs. Ref: LabWare LIMS.. Valid values are `accredited|pending_accreditation|not_accredited|suspended|withdrawn`',
    `analysis_cost` DECIMAL(18,2) COMMENT 'Standard cost per sample analysis for this method, used for budgeting and billing purposes. Ref: LabWare LIMS.',
    `analyst_certification_required` BOOLEAN COMMENT 'Indicates whether analysts must hold specific certification or training credentials to perform this method. Ref: LabWare LIMS.',
    `analyte_group` STRING COMMENT 'The specific analyte or group of analytes measured by this method (e.g., Trace Metals, Volatile Organic Compounds, Total Coliform, Turbidity, PFAS). Ref: LabWare LIMS.',
    `applicable_matrix_types` STRING COMMENT 'Comma-separated list of sample matrix types for which this method is validated and approved (e.g., drinking water, wastewater, source water, groundwater, soil, sludge, biosolids). Ref: LabWare LIMS.',
    `container_type` STRING COMMENT 'Required sample container material and specifications (e.g., glass amber bottle, polyethylene bottle, sterile container). Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test method record was first created in the system. Ref: LabWare LIMS.',
    `detection_technique` STRING COMMENT 'The analytical detection or measurement technique employed by the method (e.g., ICP-MS, GC-MS, LC-MS/MS, colorimetric, titration, UV spectrophotometry, membrane filtration, enzyme substrate). Ref: LabWare LIMS.',
    `effective_date` DATE COMMENT 'Date on which this method became effective and approved for use in the laboratory. Ref: LabWare LIMS.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis to ensure result validity, as specified by the method. Ref: LabWare LIMS.',
    `instrument_required` STRING COMMENT 'Type of analytical instrument required to perform this method (e.g., ICP-MS, GC-MS, UV-Vis Spectrophotometer, Incubator). Ref: LabWare LIMS.',
    `interferences` STRING COMMENT 'Known interferences or matrix effects that may impact method accuracy or precision, as documented in the method reference. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test method record was last updated or modified. Ref: LabWare LIMS.',
    `last_reviewed_date` DATE COMMENT 'Date of the most recent technical review or validation of this method by laboratory quality assurance personnel. Ref: LabWare LIMS.',
    `lims_method_code` STRING COMMENT 'Unique identifier for this test method in the laboratory LIMS system (LabWare or equivalent), used for system integration and data traceability. Ref: LabWare LIMS.',
    `mdl_unit` STRING COMMENT 'Unit of measure for the MDL value (e.g., mg/L, µg/L, CFU/100mL, NTU, MPN/100mL). Ref: LabWare LIMS.',
    `mdl_value` DECIMAL(18,2) COMMENT 'The Method Detection Limit - the minimum concentration of an analyte that can be measured and reported with 99% confidence that the value is greater than zero. Ref: LabWare LIMS.',
    `method_category` STRING COMMENT 'High-level classification of the test method by analyte category (inorganic, organic, microbiological, physical, radiological, emerging contaminants). Ref: LabWare LIMS.. Valid values are `inorganic|organic|microbiological|physical|radiological|emerging_contaminants`',
    `method_code` STRING COMMENT 'Standardized code identifying the analytical test method (e.g., EPA 200.8, SM 2130B, EPA 524.2, ASTM D1067). This is the externally-recognized identifier used in regulatory reporting and laboratory documentation. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9-.]+$`',
    `method_description` STRING COMMENT 'Detailed technical description of the analytical procedure, including sample preparation, analysis steps, and calculation methods. Ref: LabWare LIMS.',
    `method_name` STRING COMMENT 'Full descriptive name of the analytical test method (e.g., Determination of Trace Elements in Waters and Wastes by Inductively Coupled Plasma-Mass Spectrometry). Ref: LabWare LIMS.',
    `method_source` STRING COMMENT 'The authoritative source or publishing organization of the method (e.g., EPA, Standard Methods, ASTM, ISO, USGS).',
    `method_status` STRING COMMENT 'Current operational status of the test method in the laboratory (active, inactive, under validation, obsolete, suspended). Ref: LabWare LIMS.. Valid values are `active|inactive|under_validation|obsolete|suspended`',
    `method_version` STRING COMMENT 'Version or revision number of the method (e.g., Rev 5.4, 23rd Edition, 2017 version). Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each test method in the laboratory domain.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or revalidation of this method. Ref: LabWare LIMS.',
    `obsolete_date` DATE COMMENT 'Date on which this method was retired or superseded by a newer method. Null if the method is still active. Ref: LabWare LIMS.',
    `pql_unit` STRING COMMENT 'Unit of measure for the PQL value (e.g., mg/L, µg/L, CFU/100mL, NTU, MPN/100mL). Ref: LabWare LIMS.',
    `pql_value` DECIMAL(18,2) COMMENT 'The Practical Quantitation Limit - the lowest concentration that can be reliably measured within specified limits of precision and accuracy during routine laboratory operations. Ref: LabWare LIMS.',
    `preservation_requirements` STRING COMMENT 'Required sample preservation techniques and conditions (e.g., cool to 4°C, acidify to pH<2 with HNO3, add sodium thiosulfate, protect from light). Ref: LabWare LIMS.',
    `proficiency_testing_required` BOOLEAN COMMENT 'Indicates whether successful proficiency testing is required for laboratory certification for this method. Ref: LabWare LIMS.',
    `qc_requirements` STRING COMMENT 'Summary of quality control requirements for the method including frequency of blanks, duplicates, spikes, and control standards. Ref: LabWare LIMS.',
    `regulatory_acceptance` STRING COMMENT 'Comma-separated list of regulatory programs that accept this method for compliance monitoring (e.g., SDWA, CWA, NPDES, state-specific programs). Ref: LabWare LIMS.',
    `reporting_limit` DECIMAL(18,2) COMMENT 'The minimum concentration at which results are reported to clients or regulatory agencies, typically equal to or greater than the PQL. Ref: LabWare LIMS.',
    `reporting_limit_unit` STRING COMMENT 'Unit of measure for the reporting limit (e.g., mg/L, µg/L, CFU/100mL, NTU). Ref: LabWare LIMS.',
    `superseded_by_method_code` STRING COMMENT 'Method code of the replacement method if this method has been superseded. Null if still current. Ref: LabWare LIMS.',
    `turnaround_time_days` STRING COMMENT 'Standard turnaround time in business days from sample receipt to result reporting for routine analysis. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each test method in the laboratory domain.',
    CONSTRAINT pk_test_method PRIMARY KEY(`test_method_id`)
) COMMENT 'Reference catalog of approved analytical test methods used by the laboratory. Defines the method code (e.g., EPA 200.8, SM 2130B, EPA 524.2), method name, analyte or analyte group, detection technique (ICP-MS, GC-MS, colorimetric, titration, UV), accreditation status, applicable matrix types (drinking water, wastewater, source water, soil), holding time requirements, preservation requirements, MDL (Method Detection Limit), PQL (Practical Quantitation Limit), and regulatory acceptance (SDWA, CWA, NPDES).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` (
    `analytical_test_id` BIGINT COMMENT 'Unique identifier for the analytical test record. Primary key for the analytical test entity. Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Reference to the specific chemical, physical, or biological parameter being measured (e.g., lead, total coliform, pH, turbidity, PFAS). Ref: LabWare LIMS.',
    `calibration_curve_id` BIGINT COMMENT 'Reference to the instrument calibration curve used to convert raw instrument response to analyte concentration. Links to calibration standards, curve coefficients, and correlation coefficient (R²). Ref: LabWare LIMS.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Analytical tests are frequently performed for specific capital projects (new treatment plant startup, pipeline disinfection verification, construction phase monitoring). Required for project cost allo. Ref: LabWare LIMS.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual test costs must be allocated to the requesting departments cost center for interdepartmental billing and budget tracking. Water utilities operate labs as internal service centers that char. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the laboratory instrument or equipment used to perform the test (e.g., ICP-MS, spectrophotometer, incubator). Links to calibration and maintenance records. Ref: LabWare LIMS.',
    `lab_sample_id` BIGINT COMMENT 'Reference to the parent laboratory sample on which this analytical test was performed. Links to the sample collection and chain of custody record. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified laboratory analyst who performed the test. Used for quality assurance, proficiency tracking, and regulatory audit trails. Ref: LabWare LIMS.',
    `qc_batch_id` BIGINT COMMENT 'Reference to the quality control batch that includes this test. QC batches contain blanks, duplicates, spikes, and control standards to validate analytical accuracy and precision. Ref: LabWare LIMS.',
    `tertiary_analytical_approved_by_analyst_certified_analyst_id` BIGINT COMMENT 'Reference to the laboratory director or authorized signatory who provided final approval for the test result. Approved results are certified for regulatory reporting and external release. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Reference to the standardized analytical test method applied (e.g., EPA 200.7, SM 2540C, ASTM D1067). Defines the procedure, detection limits, and quality control requirements. Ref: LabWare LIMS.',
    `accreditation_body` STRING COMMENT 'Name of the organization that accredited the laboratory to perform this test method (e.g., NELAC, A2LA, ANAB, state primacy agency). Required for regulatory acceptance of results. Ref: LabWare LIMS.',
    `accreditation_number` STRING COMMENT 'Unique certificate or license number issued by the accreditation body authorizing the laboratory to perform this test method. Must be current and valid for regulatory reporting. Ref: LabWare LIMS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the test result received final approval and was certified for regulatory reporting. Marks transition to approved status and enables result release. Ref: LabWare LIMS.',
    `chain_of_custody_number` STRING COMMENT 'Unique identifier for the chain of custody document that accompanied the sample from collection through laboratory receipt. Ensures sample integrity and traceability for legal defensibility. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this analytical test record was first created in the laboratory system. Represents the initial entry into the laboratory workflow. Ref: LabWare LIMS.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Minimum concentration of analyte that can be measured and reported with 99% confidence that the value is greater than zero. Used to determine non-detect results and reporting limits. Ref: LabWare LIMS.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to raw instrument response to account for sample dilution performed to bring analyte concentration within instrument calibration range. A value of 1.0 indicates no dilution. Ref: LabWare LIMS.',
    `hold_time_compliant_flag` BOOLEAN COMMENT 'Indicates whether the test was performed within the maximum allowable time between sample collection and analysis. Hold times vary by analyte and method (e.g., 48 hours for bacteria, 28 days for metals). Non-compliance may invalidate results for regulatory reporting. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this analytical test record was most recently updated. Tracks changes to results, status transitions, or corrections throughout the test lifecycle. Ref: LabWare LIMS.',
    `lims_import_timestamp` TIMESTAMP COMMENT 'Date and time when this test record was imported from the source Laboratory Information Management System (LabWare) into the enterprise data lakehouse. Used for data lineage and reconciliation. Ref: LabWare LIMS.',
    `matrix_type` STRING COMMENT 'Classification of the sample medium being analyzed. Matrix type affects method selection, quality control requirements, and regulatory applicability. Different matrices may require different preparation techniques and have different interference profiles. [ENUM-REF-CANDIDATE: drinking_water|raw_water|wastewater|groundwater|surface_water|biosolids|soil|sediment — 8 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each analytical test in the laboratory domain.',
    `percent_recovery` DECIMAL(18,2) COMMENT 'Quality control metric indicating the percentage of known analyte concentration recovered in matrix spike or laboratory control sample. Used to assess method accuracy and matrix interference. Acceptable ranges are method-specific. Ref: LabWare LIMS.',
    `preservation_method` STRING COMMENT 'Chemical or physical treatment applied to the sample to maintain analyte stability during storage and transport (e.g., acidification with HNO3, refrigeration at 4°C, addition of sodium thiosulfate for dechlorination). Ref: LabWare LIMS.',
    `qualifier_code` STRING COMMENT 'Data quality flag indicating special conditions affecting the result. U=non-detect (below detection limit), J=estimated value (between MDL and RL), B=blank contamination detected, E=exceeds calibration range, H=hold time exceeded, N=tentative identification, Q=QC failure, R=rejected, S=spike recovery out of range, T=temperature exceedance, V=value verified, X=other (see comments). [ENUM-REF-CANDIDATE: U|J|B|E|H|N|Q|R|S|T|V|X — 12 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `raw_instrument_response` DECIMAL(18,2) COMMENT 'Uncorrected measurement value directly from the analytical instrument before applying dilution factors, calibration curves, or other corrections. Retained for audit trails and method validation. Ref: LabWare LIMS.',
    `reanalysis_required_flag` BOOLEAN COMMENT 'Indicates whether the test must be repeated due to quality control failure, questionable results, or regulatory requirements. Triggers workflow to schedule reanalysis from the same sample or request new sample collection. Ref: LabWare LIMS.',
    `regulatory_program` STRING COMMENT 'Federal or state regulatory program under which this test is being performed. Determines applicable compliance thresholds, reporting requirements, and data quality objectives. SDWA=Safe Drinking Water Act, CWA=Clean Water Act, NPDES=National Pollutant Discharge Elimination System. [ENUM-REF-CANDIDATE: sdwa|cwa|npdes|rcra|cercla|tsca|state_program — 7 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `rejection_reason` STRING COMMENT 'Detailed explanation for why the test result was rejected and cannot be used for regulatory reporting. Common reasons include QC failure, hold time exceedance, contamination, instrument malfunction, or analyst error. Triggers resampling or reanalysis. Ref: LabWare LIMS.',
    `relative_percent_difference` DECIMAL(18,2) COMMENT 'Quality control metric measuring precision between duplicate samples. Calculated as the absolute difference divided by the mean, expressed as a percentage. Used to assess analytical reproducibility. Ref: LabWare LIMS.',
    `reporting_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that can be reliably quantified and reported. Typically set at 2-10 times the Method Detection Limit (MDL) to ensure data quality and regulatory compliance. Ref: LabWare LIMS.',
    `result_unit` STRING COMMENT 'Unit of measure for the result value (e.g., mg/L, ug/L, NTU, MPN/100mL, pH units, CFU/100mL). Must align with regulatory reporting requirements and Maximum Contaminant Level (MCL) units. Ref: LabWare LIMS.',
    `result_value` DECIMAL(18,2) COMMENT 'Calculated analytical result value after applying dilution factors, calibration curves, and method-specific calculations. This is the reportable concentration or measurement for the analyte. Ref: LabWare LIMS.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the test result was reviewed and validated by a senior analyst or supervisor. Marks transition from preliminary to reviewed status.',
    `test_comments` STRING COMMENT 'Free-text field for analyst notes, observations, or explanations regarding unusual conditions, deviations from standard procedures, or result interpretation. May include details on matrix interference, instrument issues, or quality control anomalies. Ref: LabWare LIMS.',
    `test_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the analytical test procedure was completed and raw results were recorded. Used to calculate turnaround time and verify hold time compliance. Ref: LabWare LIMS.',
    `test_number` STRING COMMENT 'Human-readable business identifier for the analytical test, often used in laboratory worksheets, chain of custody forms, and external reporting. May follow lab-specific numbering conventions. Ref: LabWare LIMS.',
    `test_priority` STRING COMMENT 'Business priority classification for the analytical test. STAT tests require immediate processing for operational decisions; regulatory tests support compliance reporting deadlines; routine tests follow standard turnaround times. Ref: LabWare LIMS.. Valid values are `routine|urgent|stat|regulatory|compliance`',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date and time when the analytical test procedure was initiated. Critical for hold time compliance and contact time (CT) calculations for disinfection validation. Ref: LabWare LIMS.',
    `test_status` STRING COMMENT 'Current lifecycle status of the analytical test. Tracks progression from initiation through final approval or rejection. Preliminary results are unvalidated; reviewed results have passed QC checks; approved results are certified for regulatory reporting. [ENUM-REF-CANDIDATE: pending|in_progress|preliminary|reviewed|approved|rejected|cancelled — 7 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `uncertainty_value` DECIMAL(18,2) COMMENT 'Quantified estimate of the doubt associated with the measurement result, expressed in the same units as the result. Includes contributions from sampling, sample preparation, calibration, and instrument variability. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each analytical test in the laboratory domain.',
    CONSTRAINT pk_analytical_test PRIMARY KEY(`analytical_test_id`)
) COMMENT 'Core transactional record representing a single analytical test performed on a lab sample. Captures the test method applied, assigned analyst, instrument used, test start and completion datetimes, raw instrument response, calculated result value, result unit, dilution factor, qualifier codes (U=non-detect, J=estimated, B=blank contamination), QC batch reference, and result status (preliminary, reviewed, approved, rejected). This is the primary result-generating entity in the laboratory workflow.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the validated and finalized analytical test result record. Primary key. Ref: LabWare LIMS.',
    `analytical_test_id` BIGINT COMMENT 'Reference to the parent analytical test record from which this result was produced. Links to the in-process measurement and test execution context. Ref: LabWare LIMS.',
    `calibration_curve_id` BIGINT COMMENT 'Reference to the instrument calibration curve used to quantify this result. Links result to the specific calibration standards and curve parameters in effect at the time of analysis. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified analyst or laboratory supervisor who reviewed and approved this result for release. Must be a qualified individual with appropriate certification and training.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Test results must be attributed to projects for regulatory compliance reporting, cost recovery, and commissioning documentation. Water utilities track which analytical results support specific capital. Ref: LabWare LIMS.',
    `contaminant_id` BIGINT COMMENT 'Reference to the regulatory parameter this result maps to (e.g., Total Coliform, Lead, Nitrate). Links result to compliance thresholds such as Maximum Contaminant Level (MCL), Maximum Contaminant Level Goal (MCLG), or National Pollutant Discharge Elimination System (NPDES) effluent limits. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the laboratory instrument used to perform the analysis (e.g., Inductively Coupled Plasma Mass Spectrometry (ICP-MS), Gas Chromatography-Mass Spectrometry (GC-MS), spectrophotometer). Links result to instrument calibration and maintenance records. Ref: LabWare LIMS.',
    `lab_sample_id` BIGINT COMMENT 'Reference to the water or wastewater sample that was analyzed to produce this result. Ref: LabWare LIMS.',
    `original_result_test_result_id` BIGINT COMMENT 'Reference to the original test result record if this result is a reanalysis. Links reanalysis results back to the initial result for audit trail and comparison purposes. Null if this is the first analysis.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: When test results exceed regulatory limits (lead action level, MCL violations), utilities must notify affected customers at specific service points. Customer notification letters, remediation tracking. Ref: LabWare LIMS.',
    `qc_batch_id` BIGINT COMMENT 'Reference to the quality control batch in which this sample was analyzed. Links result to associated QC samples (blanks, duplicates, spikes, standards) run concurrently to validate analytical performance. Ref: LabWare LIMS.',
    `regulatory_requirement_id` BIGINT COMMENT 'Reference to the regulatory parameter this result maps to (e.g., Total Coliform, Lead, Nitrate). Links result to compliance thresholds such as Maximum Contaminant Level (MCL), Maximum Contaminant Level Goal (MCLG), or National Pollutant Discharge Elimination System (NPDES) effluent limits. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Reference to the standardized analytical test method used (e.g., EPA Method 200.7, Standard Methods 2540 C). Defines the procedure, detection limits, and quality control requirements. Ref: LabWare LIMS.',
    `accreditation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result was produced under laboratory accreditation (e.g., ISO/IEC 17025, state certification program). True indicates the result was produced by an accredited laboratory using an accredited method; False indicates non-accredited analysis.',
    `analysis_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the analytical test was completed and the raw result was generated by the instrument or analyst. Distinct from approval_timestamp which represents the validation and release event. Ref: LabWare LIMS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the result was reviewed and approved by the approving analyst. Marks the point at which the result became the authoritative reported value available for compliance and operational use. Ref: LabWare LIMS.',
    `approved_result_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result has been reviewed and approved by a qualified analyst or laboratory supervisor. True indicates the result has passed all quality control checks and is released for reporting; False indicates the result is pending review or has been rejected.',
    `blank_contamination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the method blank analyzed in the same batch showed detectable contamination of the target analyte. True indicates blank contamination was detected, which may affect result interpretation. Ref: LabWare LIMS.',
    `compliance_status` STRING COMMENT 'Indicates whether the result meets applicable regulatory thresholds. Values: compliant (result within acceptable limits), non-compliant (result exceeds Maximum Contaminant Level (MCL) or violates National Pollutant Discharge Elimination System (NPDES) limit), exceedance (result exceeds action level but not MCL), not_applicable (no regulatory threshold for this parameter), pending_review (compliance determination not yet made). Ref: LabWare LIMS.. Valid values are `compliant|non-compliant|exceedance|not_applicable|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the system. Represents the initial capture of the result data. Ref: LabWare LIMS.',
    `detection_status` STRING COMMENT 'Indicates whether the analyte was detected in the sample. Values: detected (analyte present above Method Detection Limit), non-detect (analyte not detected or below MDL), trace (analyte detected but below quantitation limit), below_mdl (result below Method Detection Limit), above_mdl (result above Method Detection Limit and quantifiable). Ref: LabWare LIMS.. Valid values are `detected|non-detect|trace|below_mdl|above_mdl`',
    `dilution_factor` DECIMAL(18,2) COMMENT 'The factor by which the sample was diluted prior to analysis. A value of 1.0 indicates no dilution. Values greater than 1.0 indicate the sample was diluted to bring analyte concentration within the calibration range or to reduce matrix interference. Ref: LabWare LIMS.',
    `duplicate_relative_percent_difference` DECIMAL(18,2) COMMENT 'Relative percent difference between the sample result and its duplicate, calculated as (|Sample - Duplicate| / Average) × 100. Indicates the precision of the analytical method. Acceptable ranges are method-specific (typically <20%). Ref: LabWare LIMS.',
    `holding_time_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sample was analyzed within the method-specified holding time (time between sample collection and analysis). True indicates compliance; False indicates holding time was exceeded, which may affect result validity. Ref: LabWare LIMS.',
    `lims_result_code` STRING COMMENT 'The unique result identifier from the source Laboratory Information Management System (LIMS), such as LabWare. Enables traceability back to the originating system and supports data reconciliation. Ref: LabWare LIMS.',
    `matrix_spike_recovery_percent` DECIMAL(18,2) COMMENT 'Percent recovery of the analyte from the matrix spike sample analyzed in the same batch. Indicates the accuracy of the method in the presence of the sample matrix. Acceptable ranges are method-specific (typically 75-125%). Ref: LabWare LIMS.',
    `method_detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of an analyte that can be measured and reported with 99% confidence that the value is greater than zero. Specific to the test method and laboratory instrumentation used. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was last modified. Tracks any updates to the result data after initial creation. Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each test result in the laboratory domain.',
    `proficiency_test_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result is from a proficiency testing (PT) sample used to evaluate laboratory performance. True indicates this is a PT result; False indicates a routine sample result. Ref: LabWare LIMS.',
    `reanalysis_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result is from a reanalysis of the sample. True indicates the sample was reanalyzed due to quality control failure, holding time exceedance, or other issue with the initial analysis; False indicates this is the first analysis. Ref: LabWare LIMS.',
    `regulatory_threshold_unit` STRING COMMENT 'Unit of measure for the regulatory threshold value. Must be compatible with the reporting_unit to enable valid comparison. [ENUM-REF-CANDIDATE: mg/L|ug/L|NTU|CFU/100mL|MPN/100mL|pH units|percent|ppm|ppb|SU — 10 candidates stripped; promote to reference product]',
    `regulatory_threshold_value` DECIMAL(18,2) COMMENT 'The applicable regulatory limit against which this result is compared (e.g., Maximum Contaminant Level (MCL), Maximum Contaminant Level Goal (MCLG), National Pollutant Discharge Elimination System (NPDES) effluent limit). Captured at the time of result approval to preserve the threshold in effect. Ref: LabWare LIMS.',
    `reporting_limit` DECIMAL(18,2) COMMENT 'The minimum concentration at which the laboratory can quantitatively report a result with confidence. Typically set at 2-10 times the Method Detection Limit (MDL). Also known as Practical Quantitation Limit (PQL) or Limit of Quantitation (LOQ). Ref: LabWare LIMS.',
    `reporting_timestamp` TIMESTAMP COMMENT 'Date and time when the result was officially reported to the client or regulatory agency. Distinct from approval_timestamp which is internal laboratory validation; this marks external release. Ref: LabWare LIMS.',
    `reporting_unit` STRING COMMENT 'Unit of measure in which the result value is reported. Common units include milligrams per liter (mg/L), micrograms per liter (ug/L), Nephelometric Turbidity Units (NTU), Colony Forming Units per 100 milliliters (CFU/100mL), Most Probable Number per 100 milliliters (MPN/100mL), pH units, percent, parts per million (ppm), parts per billion (ppb), Standard Units (SU). [ENUM-REF-CANDIDATE: mg/L|ug/L|NTU|CFU/100mL|MPN/100mL|pH units|percent|ppm|ppb|SU — 10 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `result_comment` STRING COMMENT 'Free-text comment field for analyst notes, observations, or explanations regarding the result. May include information about matrix interference, unusual sample characteristics, deviations from standard procedure, or other contextual information. Ref: LabWare LIMS.',
    `result_qualifier` STRING COMMENT 'Data qualifier code providing additional context about the result (e.g., J=estimated value, U=undetected, E=exceeds calibration range, B=blank contamination, H=holding time exceeded, Q=quality control failure). Follows EPA and laboratory-specific qualifier conventions. Ref: LabWare LIMS.',
    `result_status` STRING COMMENT 'Current lifecycle status of the result record. Values: final (result approved and released), preliminary (result generated but not yet approved), rejected (result failed quality control and is not valid), under_review (result pending analyst review), cancelled (result voided due to sample or procedural issue). Ref: LabWare LIMS.. Valid values are `final|preliminary|rejected|under_review|cancelled`',
    `result_value` DECIMAL(18,2) COMMENT 'The validated and finalized numeric result value reported from the analytical test. This is the authoritative measurement released for compliance and operational use. Ref: LabWare LIMS.',
    `uncertainty_estimate` DECIMAL(18,2) COMMENT 'Quantitative estimate of the uncertainty associated with the reported result, expressed in the same units as the result. Represents the range within which the true value is expected to lie with a specified confidence level (typically 95%). Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each test result in the laboratory domain.',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Validated and finalized analytical result record produced from an analytical test. Stores the reported result value, reporting unit, detection status (detected, non-detect, trace), result qualifier, uncertainty estimate, approved result flag, approving analyst, approval datetime, and the regulatory parameter it maps to (e.g., MCL, MCLG, NPDES effluent limit). Distinct from analytical_test which captures the raw in-process measurement; test_result is the authoritative reported value released for compliance and operational use.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` (
    `sampling_plan_id` BIGINT COMMENT 'Unique identifier for the sampling plan. Primary key. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sampling plans are regulatory compliance documents requiring documented authorship. EPA and state regulations mandate traceable plan development by qualified employees for permit compliance and audit. Ref: LabWare LIMS.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Sampling plans are designed for specific service territories to meet regulatory monitoring requirements (distribution system monitoring, source water monitoring). Each territory has unique permit cond. Ref: LabWare LIMS.',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Sampling plans implement permit monitoring requirements (NPDES discharge limits, drinking water MCLs, withdrawal permits). Every compliance sampling plan is driven by a specific permits monitoring sc. Ref: LabWare LIMS.',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved this sampling plan. Used for audit trail and regulatory compliance documentation. Nullable for draft plans. Ref: LabWare LIMS.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling plan was formally approved for use by authorized personnel (e.g., laboratory manager, quality assurance officer, regulatory compliance manager). Nullable for draft plans. Ref: LabWare LIMS.',
    `certified_analyst_required` BOOLEAN COMMENT 'Indicates whether samples under this plan must be analyzed by a state-certified or EPA-certified analyst. True for regulatory compliance samples; false for operational monitoring. Ref: LabWare LIMS.',
    `chain_of_custody_required` BOOLEAN COMMENT 'Indicates whether formal chain of custody documentation is required for samples collected under this plan. True for regulatory, legal, or enforcement-related samples; false for routine operational monitoring. Ref: LabWare LIMS.',
    `compliance_threshold_reference` STRING COMMENT 'Reference to the regulatory standard or internal guideline defining acceptable limits for analytes in this sampling plan (e.g., MCL, MCLG, NPDES permit limits, internal action levels). Detailed thresholds are managed in the quality domain. Ref: LabWare LIMS.',
    `container_type` STRING COMMENT 'Type of sample container required for collection (e.g., sterile plastic bottle, amber glass bottle, pre-preserved vial). Ensures compatibility with analyte and test method requirements. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling plan record was first created in the system. Used for audit trail and data lineage tracking. Ref: LabWare LIMS.',
    `effective_end_date` DATE COMMENT 'Date on which this sampling plan is scheduled to end or be replaced. Nullable for ongoing plans without a defined end date. Ref: LabWare LIMS.',
    `effective_start_date` DATE COMMENT 'Date on which this sampling plan becomes active and sample collection events should begin. Aligns with regulatory compliance periods or operational schedules. Ref: LabWare LIMS.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time (in hours) between sample collection and analysis to ensure sample integrity and regulatory compliance. Varies by analyte and test method. Ref: LabWare LIMS.',
    `last_sample_collected_date` DATE COMMENT 'Date of the most recent sample collection event completed under this plan. Used for compliance verification and schedule adherence tracking. Ref: LabWare LIMS.',
    `lims_integration_flag` BOOLEAN COMMENT 'Indicates whether this sampling plan is integrated with the LabWare LIMS system for automated sample tracking, result entry, and reporting. True for plans with LIMS integration; false for manual tracking.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this sampling plan record. Used for audit trail and accountability. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling plan record was last modified. Used for audit trail and change tracking. Ref: LabWare LIMS.',
    `next_scheduled_sample_date` DATE COMMENT 'Date of the next scheduled sample collection event under this plan. Updated dynamically as sample collection events are completed. Used for operational scheduling and compliance tracking. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or operational notes related to this sampling plan (e.g., seasonal adjustments, site access requirements, coordination with other departments). Ref: LabWare LIMS.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the sampling plan, used in LIMS and regulatory reporting systems. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_name` STRING COMMENT 'Human-readable name of the sampling plan describing its purpose and scope. Ref: LabWare LIMS.',
    `plan_type` STRING COMMENT 'Classification of the sampling plan based on its purpose: regulatory (compliance-driven), operational (routine monitoring), investigational (troubleshooting), proficiency (QA/QC), emergency (incident response), or special (one-time study). Ref: LabWare LIMS.. Valid values are `regulatory|operational|investigational|proficiency|emergency|special`',
    `preservation_method` STRING COMMENT 'Required sample preservation technique to maintain analyte stability during transport and storage (e.g., refrigeration at 4°C, acidification with HNO3, addition of sodium thiosulfate for dechlorination). Nullable if no preservation is required. Ref: LabWare LIMS.',
    `proficiency_testing_required` BOOLEAN COMMENT 'Indicates whether the laboratory performing analyses under this plan must participate in proficiency testing programs (e.g., EPA Water Pollution Performance Evaluation Studies, state PT programs). True for regulatory compliance samples. Ref: LabWare LIMS.',
    `qaqc_protocol` STRING COMMENT 'Reference to the QA/QC protocol or standard operating procedure governing quality control measures for this sampling plan (e.g., blank samples, duplicate samples, spike recovery, proficiency testing frequency). Ref: LabWare LIMS.',
    `regulatory_driver` STRING COMMENT 'Primary regulatory framework or permit requirement driving this sampling plan: SDWA (Safe Drinking Water Act), NPDES (National Pollutant Discharge Elimination System), LCRR (Lead and Copper Rule Revisions), state primacy agency requirements, local ordinance, or none for operational plans.. Valid values are `SDWA|NPDES|LCRR|state_primacy|local_ordinance|none`',
    `reporting_frequency` STRING COMMENT 'Frequency at which results from this sampling plan must be reported to regulatory agencies or internal stakeholders: monthly, quarterly, semiannual, annual, or as-needed (event-driven). Ref: LabWare LIMS.. Valid values are `monthly|quarterly|semiannual|annual|as_needed`',
    `reporting_requirement` STRING COMMENT 'Primary regulatory or internal reporting obligation that this sampling plan supports: CCR (Consumer Confidence Report), DMR (Discharge Monitoring Report), MOR (Monthly Operating Report), state-specific report, internal management report, or none. Ref: LabWare LIMS.. Valid values are `CCR|DMR|MOR|state_report|internal|none`',
    `responsible_party` STRING COMMENT 'Name or identifier of the person, team, or organizational unit responsible for executing this sampling plan (e.g., Water Quality Team, Field Operations, Contract Laboratory). May reference employee or organizational unit records. Ref: LabWare LIMS.',
    `revision_reason` STRING COMMENT 'Brief description of the reason for the most recent revision to this sampling plan (e.g., regulatory change, permit update, operational improvement, corrective action). Supports change control and audit trail. Ref: LabWare LIMS.',
    `sample_type` STRING COMMENT 'Type of sample collection method required: grab (single point-in-time), composite (time- or flow-weighted), continuous (automated real-time), field (on-site analysis), or split (duplicate for QA/QC or third-party verification). Ref: LabWare LIMS.. Valid values are `grab|composite|continuous|field|split`',
    `sample_volume_ml` STRING COMMENT 'Minimum required sample volume in milliliters to perform all specified analyses. Ensures sufficient sample quantity for laboratory testing and QA/QC replicates. Ref: LabWare LIMS.',
    `sampling_frequency` STRING COMMENT 'Scheduled frequency at which samples must be collected under this plan: continuous (real-time monitoring), hourly, daily, weekly, biweekly, monthly, quarterly, semiannual, annual, or event-driven (triggered by specific conditions). [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|biweekly|monthly|quarterly|semiannual|annual|event_driven — 10 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `sampling_plan_status` STRING COMMENT 'Current lifecycle status of the sampling plan: draft (under development), active (in use), suspended (temporarily paused), retired (no longer used), archived (historical record). Ref: LabWare LIMS.. Valid values are `draft|active|suspended|retired|archived`',
    `total_samples_collected` STRING COMMENT 'Cumulative count of sample collection events completed under this sampling plan since its effective start date. Used for compliance reporting and plan performance tracking. Ref: LabWare LIMS.',
    `version_number` STRING COMMENT 'Version number of this sampling plan, incremented with each revision. Supports change control and regulatory audit requirements. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each sampling plan in the laboratory domain.',
    CONSTRAINT pk_sampling_plan PRIMARY KEY(`sampling_plan_id`)
) COMMENT 'Master record defining a scheduled or regulatory-driven sampling program. Specifies the sampling frequency (daily, weekly, monthly, quarterly), required analytes, sampling locations, applicable regulation or permit (SDWA, NPDES, LCRR, state primacy), sample type requirements, required test methods, and responsible party. Drives the generation of sample_collection_event records and ensures regulatory sampling schedules are met. Covers CCR monitoring, DBP (THM/HAA5) monitoring, PFAS sampling, LCRR tap sampling, and NPDES effluent monitoring.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` (
    `sampling_location_id` BIGINT COMMENT 'Unique identifier for the sampling location. Primary key for the sampling location master record. Ref: LabWare LIMS.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Construction projects require water quality monitoring at project sites during and after construction. Sampling locations are established for pre-commissioning testing, post-construction verification,. Ref: LabWare LIMS.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sampling locations are associated with operational facilities (WTPs, pump stations, pressure zones) that have assigned cost centers. Compliance monitoring costs must be allocated to the responsible op. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sampling location registry management requires employee accountability for data quality. Location setup affects compliance monitoring site selection and must be traceable to qualified employees for re. Ref: LabWare LIMS.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: LCRR Tier 1/2/3 sampling sites are customer taps requiring account linkage for access coordination, volunteer recruitment, sampling appointment scheduling, and result notification. Utilities maintain ',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Water quality monitoring programs align with DMA boundaries for correlating quality issues with leak detection, NRW analysis, and system performance. Location records must reference the DMA for integr. Ref: LabWare LIMS.',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility (WTP, WWTP, pump station, reservoir) to which this sampling location belongs. Ref: LabWare LIMS.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Designated sampling locations in distribution systems are typically hydrants used for routine compliance monitoring. Location records must reference the physical hydrant asset for field crew navigatio. Ref: LabWare LIMS.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Many sampling locations ARE service points (customer taps for lead/copper monitoring, distribution system sample stations). LCRR requires tier classification of service points, linking monitoring loca',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Regulatory sampling plans require representative coverage across pressure zones to ensure water quality throughout the distribution system. Location records must identify which pressure zone they repr. Ref: LabWare LIMS.',
    `registry_id` BIGINT COMMENT 'Reference to the specific asset (pipe segment, valve, tank, outfall structure) at which sampling occurs. Links to IBM Maximo asset registry.',
    `sampling_registry_id` BIGINT COMMENT 'Reference to the specific asset (pipe segment, valve, tank, outfall structure) at which sampling occurs. Links to IBM Maximo asset registry.',
    `scada_tag_id` BIGINT COMMENT 'Reference to the SCADA tag or point in OSIsoft PI Historian associated with this sampling location, if applicable (e.g., for online monitoring).',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Storage tanks are designated sampling locations for water quality monitoring programs. Location records must link to the specific tank asset for regulatory compliance tracking, operational monitoring. Ref: LabWare LIMS.',
    `accessibility_notes` STRING COMMENT 'Free-text notes describing access requirements, restrictions, or special instructions for field sampling crews (e.g., key required, gate code, contact property owner). Ref: LabWare LIMS.',
    `address_line_1` STRING COMMENT 'Primary street address or location descriptor for the sampling point. Used for field crew navigation and regulatory reporting. Ref: LabWare LIMS.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, building, unit) for the sampling location. Ref: LabWare LIMS.',
    `city` STRING COMMENT 'City or municipality where the sampling location is situated. Ref: LabWare LIMS.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, MEX) for the sampling location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling location record was first created in the system. Ref: LabWare LIMS.',
    `decommission_date` DATE COMMENT 'Date when the sampling location was decommissioned or removed from active sampling schedules. Ref: LabWare LIMS.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet at the sampling location. Relevant for hydraulic modeling and pressure zone analysis. Ref: LabWare LIMS.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier in the Esri ArcGIS system linking this sampling location to the spatial layer. Ref: LabWare LIMS.',
    `installation_date` DATE COMMENT 'Date when the sampling location was established or the sampling infrastructure was installed. Ref: LabWare LIMS.',
    `is_compliance_location` BOOLEAN COMMENT 'Boolean flag indicating whether this location is designated for regulatory compliance monitoring (true) or operational monitoring only (false). Ref: LabWare LIMS.',
    `is_public_access` BOOLEAN COMMENT 'Boolean flag indicating whether the sampling location is in a publicly accessible area (true) or requires special access arrangements (false). Ref: LabWare LIMS.',
    `last_sample_date` DATE COMMENT 'Date of the most recent sample collected at this location. Used for scheduling and compliance tracking. Ref: LabWare LIMS.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the sampling location. Used for GIS mapping and spatial analysis in Esri ArcGIS. Ref: LabWare LIMS.',
    `lcrr_tier_classification` STRING COMMENT 'Tier classification under EPA Lead and Copper Rule Revisions (LCRR). Determines sampling frequency and priority for lead service line locations.. Valid values are `tier_1|tier_2|tier_3|not_applicable`',
    `lims_location_code` STRING COMMENT 'Location code used in the LabWare LIMS system for sample tracking and chain of custody. May differ from the utilitys internal location code.',
    `location_code` STRING COMMENT 'Business identifier for the sampling location, used in field operations, laboratory requisitions, and regulatory reporting. Typically follows utility-specific naming conventions. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9]{4,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the sampling location (e.g., Main Street Tap, WTP Effluent Point A, Outfall 001). Ref: LabWare LIMS.',
    `location_status` STRING COMMENT 'Current operational status of the sampling location. Determines whether the location is included in active sampling schedules. Ref: LabWare LIMS.. Valid values are `active|inactive|seasonal|decommissioned|pending_activation`',
    `location_type` STRING COMMENT 'Classification of the sampling location based on its position in the water or wastewater system. Determines applicable regulatory requirements and sampling protocols. [ENUM-REF-CANDIDATE: entry_point_distribution|distribution_system_tap|source_water_intake|wtp_effluent|wwtp_influent|wwtp_effluent|industrial_user_discharge|ambient_receiving_water|reservoir|storage_tank|pump_station — 11 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the sampling location. Used for GIS mapping and spatial analysis in Esri ArcGIS. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this sampling location record. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling location record was last modified. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'General notes or comments about the sampling location, including historical context, special considerations, or operational observations. Ref: LabWare LIMS.',
    `npdes_outfall_number` STRING COMMENT 'EPA-assigned NPDES permit outfall identifier for wastewater discharge points. Required for DMR reporting and compliance monitoring. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9]{3,10}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the sampling location address. Ref: LabWare LIMS.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `regulatory_designation` STRING COMMENT 'Additional regulatory classification or designation for the sampling location (e.g., compliance monitoring point, operational monitoring point, special study site). Ref: LabWare LIMS.',
    `sample_point_description` STRING COMMENT 'Detailed description of the physical sampling point (e.g., tap type, valve location, manhole ID, outfall structure details). Ref: LabWare LIMS.',
    `sampling_frequency` STRING COMMENT 'Standard sampling frequency for this location as defined by regulatory requirements or operational protocols. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annual|event_based|as_needed — 8 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `service_area` STRING COMMENT 'Service area or district designation for the sampling location. Used for operational reporting and customer communication. Ref: LabWare LIMS.',
    `site_contact_name` STRING COMMENT 'Name of the on-site contact person or property owner who can provide access to the sampling location. Ref: LabWare LIMS.',
    `site_contact_phone` STRING COMMENT 'Phone number for the on-site contact person or property owner. Ref: LabWare LIMS.. Valid values are `^+?[0-9]{10,15}$`',
    `state_province` STRING COMMENT 'Two-letter state or province code (e.g., CA, TX, NY) for the sampling location. Ref: LabWare LIMS.. Valid values are `^[A-Z]{2}$`',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each sampling location in the laboratory domain.',
    `water_source_type` STRING COMMENT 'Type of water source serving this sampling location. Relevant for source water monitoring and treatment correlation. Ref: LabWare LIMS.. Valid values are `surface_water|groundwater|purchased_water|blended|recycled_water`',
    CONSTRAINT pk_sampling_location PRIMARY KEY(`sampling_location_id`)
) COMMENT 'Master record for each designated sampling point in the water and wastewater system. Captures location identifier, location type (entry point to distribution, distribution system tap, source water intake, WTP effluent, WWTP influent, WWTP effluent, industrial user discharge, ambient receiving water), GIS coordinates, associated facility or asset, accessibility notes, and regulatory designation (e.g., NPDES outfall number, LCRR tier classification). Provides the spatial anchor for all sampling activities.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` (
    `lab_instrument_id` BIGINT COMMENT 'Unique identifier for the laboratory instrument. Primary key for the lab_instrument product. Ref: LabWare LIMS.',
    `registry_id` BIGINT COMMENT 'Reference to the enterprise asset registry for this instrument, linking laboratory equipment to the broader asset management system for depreciation, warranty, and disposal tracking. Ref: LabWare LIMS.',
    `lab_registry_id` BIGINT COMMENT 'Reference to the enterprise asset registry for this instrument, linking laboratory equipment to the broader asset management system for depreciation, warranty, and disposal tracking. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified laboratory analyst who is the primary operator or custodian of this instrument, responsible for routine operation, calibration verification, and performance monitoring. Ref: LabWare LIMS.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: High-value instruments often have multi-year service contracts covering calibration, preventive maintenance, and parts. Links instrument to its service agreement for contract compliance tracking and c. Ref: LabWare LIMS.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Every lab instrument has a manufacturer/vendor for procurement, service contracts, calibration, and spare parts. Critical for asset lifecycle management, warranty tracking, and maintenance planning. R. Ref: LabWare LIMS.',
    `accuracy_specification` STRING COMMENT 'Manufacturer-stated accuracy or precision specification for the instrument, typically expressed as a percentage or absolute value (e.g., ±2%, ±0.01 pH units, ±0.5 NTU). Used for method validation and quality control (QC) acceptance criteria. Ref: LabWare LIMS.',
    `annual_service_cost` DECIMAL(18,2) COMMENT 'Annual cost in USD for vendor service contract, preventive maintenance, and consumables for this instrument. Used for OPEX (Operating Expenditure) budgeting and total cost of ownership analysis. Ref: LabWare LIMS.',
    `calibration_frequency_days` STRING COMMENT 'Required interval in days between calibration events for this instrument, as defined by manufacturer specifications, regulatory requirements, or laboratory quality manual. Typical values range from 30 to 365 days depending on instrument type and criticality. Ref: LabWare LIMS.',
    `certification_expiration_date` DATE COMMENT 'Date the instruments regulatory certification expires, after which it cannot be used for compliance testing until recertified. Applicable for instruments used in SDWA, NPDES, or state-mandated testing programs. Ref: LabWare LIMS.',
    `certification_status` STRING COMMENT 'Current certification or accreditation status of the instrument for regulatory compliance testing. Certified indicates the instrument meets all requirements for use in compliance monitoring under SDWA (Safe Drinking Water Act), NPDES (National Pollutant Discharge Elimination System), or other programs. Pending indicates certification is in progress. Expired indicates recertification is required. Not Required indicates the instrument is used for non-compliance testing only. Ref: LabWare LIMS.. Valid values are `Certified|Pending|Expired|Not Required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system, used for audit trail and data lineage tracking. Ref: LabWare LIMS.',
    `in_service_date` DATE COMMENT 'Date the instrument was first placed into operational service in the laboratory, marking the start of its useful life for depreciation and lifecycle tracking. Ref: LabWare LIMS.',
    `instrument_name` STRING COMMENT 'Human-readable name or designation for the instrument, often combining type and location for operational clarity (e.g., Main Lab ICP-MS Unit 1). Ref: LabWare LIMS.',
    `instrument_tag` STRING COMMENT 'Unique physical asset tag or barcode identifier affixed to the instrument for inventory tracking and field identification. Typically follows organizational asset tagging conventions. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9]{3,20}$`',
    `instrument_type` STRING COMMENT 'Classification of the analytical instrument by its primary measurement technology. ICP-MS (Inductively Coupled Plasma Mass Spectrometry) for metals, GC-MS (Gas Chromatography Mass Spectrometry) for organics, IC (Ion Chromatography) for anions, TOC (Total Organic Carbon) Analyzer, Turbidimeter for NTU (Nephelometric Turbidity Units), Spectrophotometer for colorimetric analysis, pH Meter, DO (Dissolved Oxygen) Meter, Conductivity Meter, and various parameter-specific analyzers for water quality testing. [ENUM-REF-CANDIDATE: ICP-MS|GC-MS|IC|TOC Analyzer|Turbidimeter|Spectrophotometer|pH Meter|DO Meter|Conductivity Meter|Chlorine Analyzer|Fluoride Analyzer|Ammonia Analyzer|Nitrate Analyzer|Phosphate Analyzer|BOD Analyzer|COD Analyzer — 16 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `lab_location` STRING COMMENT 'Physical location of the instrument within the laboratory facility (e.g., Main Lab - Room 201, WTP Lab - Bench 3, WWTP Lab - Instrument Room). Used for operational logistics and sample routing. Ref: LabWare LIMS.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent successful calibration event for this instrument. Critical for determining current calibration status and next due date per laboratory quality assurance (QA) protocols. Ref: LabWare LIMS.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance (PM) activity performed on this instrument, used to track maintenance schedules and predict next service needs. Ref: LabWare LIMS.',
    `lims_instrument_code` STRING COMMENT 'Unique instrument identifier in the laboratorys LIMS (Laboratory Information Management System), such as LabWare. Used for electronic data integration, sample tracking, and result validation workflows. Ref: LabWare LIMS.',
    `maintenance_frequency_days` STRING COMMENT 'Required interval in days between preventive maintenance activities for this instrument, as defined by manufacturer recommendations or laboratory maintenance program. Typical values range from 90 to 365 days. Ref: LabWare LIMS.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the instrument (e.g., Agilent, Thermo Fisher Scientific, Hach, YSI, Shimadzu). Ref: LabWare LIMS.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Upper bound of the instruments measurement range, expressed in the instruments native units. For example, 1000 mg/L for an ICP-MS, or 1000 NTU for a turbidimeter. Values beyond this range require dilution or alternative methods. Ref: LabWare LIMS.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Lower bound of the instruments measurement range or detection limit, expressed in the instruments native units. For example, 0.001 mg/L for an ICP-MS measuring trace metals, or 0.1 NTU for a turbidimeter. Ref: LabWare LIMS.',
    `measurement_unit` STRING COMMENT 'Standard unit of measure for results produced by this instrument (e.g., mg/L, ug/L, NTU, pH units, uS/cm, mg/L as CaCO3). Must align with regulatory reporting requirements and laboratory LIMS (Laboratory Information Management System) configuration. Ref: LabWare LIMS.',
    `model_number` STRING COMMENT 'Manufacturers model number or designation for the instrument, used for parts ordering, service manuals, and technical specifications. Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each lab instrument in the laboratory domain.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration event, calculated based on calibration frequency requirements and last calibration date. Instruments past due for calibration must be taken out of service per ISO/IEC 17025.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity, calculated based on maintenance frequency and last maintenance date. Used for work order scheduling in CMMS (Computerized Maintenance Management System). Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional information about the instrument, including special handling requirements, known quirks, configuration details, or historical context not captured in structured fields. Ref: LabWare LIMS.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. In Service indicates the instrument is available and qualified for testing. Out of Service indicates temporary unavailability. Calibration and Maintenance indicate scheduled activities. Repair indicates unplanned downtime. Retired indicates permanent removal from service. Quarantined indicates the instrument is under investigation for performance issues. [ENUM-REF-CANDIDATE: In Service|Out of Service|Calibration|Maintenance|Repair|Retired|Quarantined — 7 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `primary_test_method` STRING COMMENT 'Primary analytical test method or Standard Method number that this instrument is configured to perform (e.g., EPA 200.8, SM 2540 C, EPA 300.0, SM 2130 B). Links the instrument to specific regulatory-approved analytical procedures. Ref: LabWare LIMS.',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost of the instrument in USD, used for asset valuation, depreciation calculations, and capital budgeting. Excludes installation and training costs unless capitalized. Ref: LabWare LIMS.',
    `purchase_date` DATE COMMENT 'Date the instrument was purchased or acquired by the organization, used for warranty tracking and capital expenditure (CAPEX) reporting. Ref: LabWare LIMS.',
    `retirement_date` DATE COMMENT 'Date the instrument was permanently retired from service and removed from the active laboratory inventory. Used for asset disposal tracking and historical record keeping. Ref: LabWare LIMS.',
    `retirement_reason` STRING COMMENT 'Explanation for why the instrument was retired (e.g., End of useful life, Replaced by newer model, Excessive repair costs, Obsolete technology, Regulatory method discontinued). Used for asset lifecycle analysis and replacement planning. Ref: LabWare LIMS.',
    `secondary_test_methods` STRING COMMENT 'Comma-separated list of additional test methods or Standard Method numbers that this instrument can perform, beyond the primary method. Used for multi-parameter instruments or instruments with multiple configurations. Ref: LabWare LIMS.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for this specific instrument unit, used for warranty claims, service history, and regulatory traceability. Ref: LabWare LIMS.',
    `service_contract_expiration_date` DATE COMMENT 'Date the current vendor service contract expires, after which service calls will be billed separately or a new contract must be negotiated. Used for budgeting and contract renewal planning. Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was last modified, used for audit trail, change tracking, and data synchronization with source systems. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each lab instrument in the laboratory domain.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturers warranty coverage expires, after which repairs and parts are at the organizations expense. Used for maintenance planning and service contract decisions. Ref: LabWare LIMS.',
    CONSTRAINT pk_lab_instrument PRIMARY KEY(`lab_instrument_id`)
) COMMENT 'Master inventory record for each analytical instrument in the laboratory. Captures instrument type (ICP-MS, GC-MS, IC, TOC analyzer, turbidimeter, spectrophotometer, pH meter, DO meter), manufacturer, model, serial number, asset tag, location within lab, current operational status, date placed in service, and associated test methods. Serves as the equipment master for calibration scheduling and maintenance tracking within the laboratory domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` (
    `laboratory_instrument_calibration_id` BIGINT COMMENT 'Unique identifier for the laboratory_instrument_calibration data product (auto-inserted pre-linking). Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Unique identifier for the analyte referenced by each laboratory instrument calibration record in the laboratory domain.',
    `calibration_curve_id` BIGINT COMMENT 'Unique identifier for the calibration curve referenced by each laboratory instrument calibration record in the laboratory domain.',
    `certified_analyst_id` BIGINT COMMENT 'Foreign key linking to laboratory.certified_analyst. Business justification: Calibration events are performed BY certified analysts. This N:1 relationship (many calibrations per analyst) tracks who performed the calibration, which is required for regulatory traceability and qu. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_instrument. Business justification: Calibration events are performed ON specific laboratory instruments. This is a core N:1 relationship (many calibration events per instrument). The FK enables tracking of calibration history per instru. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Analyst who performed calibration. Ref: LabWare LIMS.',
    `laboratory_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the laboratory created by employee referenced by each laboratory instrument calibration record in the laboratory domain.',
    `laboratory_employee_id` BIGINT COMMENT 'FK to the employee who performed the calibration. Ref: LabWare LIMS.',
    `laboratory_id` BIGINT COMMENT 'Laboratory where the calibration was performed. Ref: LabWare LIMS.',
    `laboratory_reagent_standard_id` BIGINT COMMENT 'Unique identifier for the laboratory reagent standard referenced by each laboratory instrument calibration record in the laboratory domain.',
    `laboratory_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the laboratory responsible employee referenced by each laboratory instrument calibration record in the laboratory domain.',
    `reagent_standard_id` BIGINT COMMENT 'Reagent standard used for calibration. Ref: LabWare LIMS.',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory requirement driving calibration. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Unique identifier for the test method referenced by each laboratory instrument calibration record in the laboratory domain.',
    `canonical_quality_instrument_calibration_id` BIGINT COMMENT 'Unique identifier for the canonical quality instrument calibration referenced by each laboratory instrument calibration record in the laboratory domain.',
    `acceptance_criteria` STRING COMMENT 'Acceptance criteria per method. Ref: LabWare LIMS.',
    `acceptance_criteria_high` DECIMAL(18,2) COMMENT 'The acceptance criteria high value recorded for each laboratory instrument calibration in the laboratory domain.',
    `acceptance_criteria_low` DECIMAL(18,2) COMMENT 'The acceptance criteria low value recorded for each laboratory instrument calibration in the laboratory domain.',
    `acceptance_criteria_met` BOOLEAN COMMENT 'Flag indicating all acceptance criteria were met. Ref: LabWare LIMS.',
    `acceptance_tolerance_pct` DECIMAL(18,2) COMMENT 'Maximum allowable deviation for passing. Ref: LabWare LIMS.',
    `adjustment_description` STRING COMMENT 'Description of adjustment made. Ref: LabWare LIMS.',
    `adjustment_made` BOOLEAN COMMENT 'Whether an adjustment was made during calibration. Ref: LabWare LIMS.',
    `adjustment_performed` BOOLEAN COMMENT 'Whether instrument was adjusted. Ref: LabWare LIMS.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each laboratory instrument calibration in the laboratory domain.',
    `as_found_value` DECIMAL(18,2) COMMENT 'The as found value value recorded for each laboratory instrument calibration in the laboratory domain.',
    `as_left_value` DECIMAL(18,2) COMMENT 'The as left value value recorded for each laboratory instrument calibration in the laboratory domain.',
    `calibration_curve_r_squared` DECIMAL(18,2) COMMENT 'R-squared value of the calibration curve. Ref: LabWare LIMS.',
    `calibration_date` DATE COMMENT 'Date and time calibration was performed. Ref: LabWare LIMS.',
    `calibration_frequency_days` DECIMAL(18,2) COMMENT 'Required calibration frequency in days. Ref: LabWare LIMS.',
    `calibration_interval_days` DECIMAL(18,2) COMMENT 'Calibration interval in days. Ref: LabWare LIMS.',
    `calibration_level` STRING COMMENT 'Calibration level (single_point, multi_point, full_curve). Ref: LabWare LIMS.',
    `calibration_method` DECIMAL(18,2) COMMENT 'The calibration method value recorded for each laboratory instrument calibration in the laboratory domain.',
    `calibration_notes` DECIMAL(18,2) COMMENT 'The calibration notes value recorded for each laboratory instrument calibration in the laboratory domain.',
    `calibration_number` STRING COMMENT 'Unique calibration reference number. Ref: LabWare LIMS.',
    `calibration_range_high` DECIMAL(18,2) COMMENT 'High end of calibration range. Ref: LabWare LIMS.',
    `calibration_range_low` DECIMAL(18,2) COMMENT 'Low end of calibration range. Ref: LabWare LIMS.',
    `calibration_result` STRING COMMENT 'Calibration result. Ref: LabWare LIMS.',
    `calibration_status` DECIMAL(18,2) COMMENT 'The calibration status value recorded for each laboratory instrument calibration in the laboratory domain.',
    `calibration_timestamp` DECIMAL(18,2) COMMENT 'Precise timestamp of calibration. Ref: LabWare LIMS.',
    `calibration_type` STRING COMMENT 'Type (initial, continuing, verification, post_maintenance). Ref: LabWare LIMS.',
    `calibration_unit` DECIMAL(18,2) COMMENT 'Unit of calibration range. Ref: LabWare LIMS.',
    `laboratory_instrument_calibration_category` STRING COMMENT 'The laboratory instrument calibration category value recorded for each laboratory instrument calibration in the laboratory domain.',
    `certificate_number` STRING COMMENT 'Calibration certificate reference number. Ref: LabWare LIMS.',
    `classification` STRING COMMENT 'The classification value recorded for each laboratory instrument calibration in the laboratory domain.',
    `laboratory_instrument_calibration_code` STRING COMMENT 'code for laboratory_instrument_calibration. Ref: LabWare LIMS.',
    `comments` STRING COMMENT 'Analyst notes on calibration. Ref: LabWare LIMS.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each laboratory instrument calibration in the laboratory domain.',
    `continuing_calibration_verification_pct` DECIMAL(18,2) COMMENT 'CCV recovery percentage. Ref: LabWare LIMS.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required. Ref: LabWare LIMS.',
    `correlation_coefficient` STRING COMMENT 'R-squared value for calibration curve. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: LabWare LIMS.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each laboratory instrument calibration in the laboratory domain.',
    `laboratory_instrument_calibration_description` STRING COMMENT 'The laboratory instrument calibration description value recorded for each laboratory instrument calibration in the laboratory domain.',
    `deviation_from_standard` DECIMAL(18,2) COMMENT 'Percent deviation from expected standard value. Ref: LabWare LIMS.',
    `deviation_pct` DECIMAL(18,2) COMMENT 'Percentage deviation from standard. Ref: LabWare LIMS.',
    `drift_pct` DECIMAL(18,2) COMMENT 'The drift pct value recorded for each laboratory instrument calibration in the laboratory domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each laboratory instrument calibration record in the laboratory domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: LabWare LIMS.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: LabWare LIMS.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each laboratory instrument calibration record in the laboratory domain.',
    `engineering_unit` STRING COMMENT 'Unit of measurement for calibration. Ref: LabWare LIMS.',
    `expected_response` STRING COMMENT 'Expected instrument response. Ref: LabWare LIMS.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each laboratory instrument calibration record in the laboratory domain.',
    `initial_calibration_verification_pct` DECIMAL(18,2) COMMENT 'ICV recovery percentage. Ref: LabWare LIMS.',
    `instrument_serial_number` STRING COMMENT 'Instrument serial number. Ref: LabWare LIMS.',
    `instrument_taken_offline` BOOLEAN COMMENT 'Whether instrument was taken offline. Ref: LabWare LIMS.',
    `intercept` DECIMAL(18,2) COMMENT 'Calibration curve intercept. Ref: LabWare LIMS.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: LabWare LIMS.',
    `is_passed` BOOLEAN COMMENT 'Whether calibration met acceptance criteria. Ref: LabWare LIMS.',
    `laboratory_instrument_calibration_number` STRING COMMENT 'The laboratory instrument calibration number value recorded for each laboratory instrument calibration in the laboratory domain.',
    `laboratory_instrument_calibration_type` STRING COMMENT 'The laboratory instrument calibration type value recorded for each laboratory instrument calibration in the laboratory domain.',
    `measured_response` STRING COMMENT 'Instrument response to standard. Ref: LabWare LIMS.',
    `measured_value_after` DECIMAL(18,2) COMMENT 'Instrument reading after calibration. Ref: LabWare LIMS.',
    `measured_value_before` DECIMAL(18,2) COMMENT 'Instrument reading before calibration. Ref: LabWare LIMS.',
    `method_reference` STRING COMMENT 'Analytical method requiring this calibration (e.g., EPA 524.2, SM 4500-Cl G). Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last modification timestamp. Ref: LabWare LIMS.',
    `laboratory_instrument_calibration_name` STRING COMMENT 'name for laboratory_instrument_calibration. Ref: LabWare LIMS.',
    `next_calibration_date` TIMESTAMP COMMENT 'The next calibration date associated with each laboratory instrument calibration record in the laboratory domain.',
    `next_calibration_due_date` DECIMAL(18,2) COMMENT 'The next calibration due date associated with each laboratory instrument calibration record in the laboratory domain.',
    `next_due_date` DATE COMMENT 'Next calibration due date. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Calibration notes. Ref: LabWare LIMS.',
    `number_of_calibration_points` DECIMAL(18,2) COMMENT 'Number of calibration curve points. Ref: LabWare LIMS.',
    `number_of_standards` STRING COMMENT 'Number of calibration standards used. Ref: LabWare LIMS.',
    `parameter_measured` STRING COMMENT 'Parameter or analyte measured by instrument. Ref: LabWare LIMS.',
    `pass_fail_flag` BOOLEAN COMMENT 'The pass fail flag value recorded for each laboratory instrument calibration in the laboratory domain.',
    `pass_fail_status` STRING COMMENT 'Result (pass, fail, adjusted). Ref: LabWare LIMS.',
    `pass_flag` BOOLEAN COMMENT 'The pass flag value recorded for each laboratory instrument calibration in the laboratory domain.',
    `passed_flag` BOOLEAN COMMENT 'The passed flag value recorded for each laboratory instrument calibration in the laboratory domain.',
    `percent_recovery` STRING COMMENT 'Percent recovery of standard. Ref: LabWare LIMS.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each laboratory instrument calibration in the laboratory domain.',
    `post_calibration_response` DECIMAL(18,2) COMMENT 'Instrument response after calibration adjustment. Ref: LabWare LIMS.',
    `pre_calibration_response` DECIMAL(18,2) COMMENT 'Instrument response before calibration adjustment. Ref: LabWare LIMS.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each laboratory instrument calibration in the laboratory domain.',
    `quality_instrument_calibration_id` BIGINT COMMENT 'Foreign key to the canonical single-source-of-truth entity quality.quality_instrument_calibration to resolve cross-domain duplication. Ref: LabWare LIMS.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each laboratory instrument calibration in the laboratory domain.',
    `r_squared` DECIMAL(18,2) COMMENT 'R-squared value of calibration curve. Ref: LabWare LIMS.',
    `r_squared_acceptance_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable R-squared value. Ref: LabWare LIMS.',
    `r_squared_value` DECIMAL(18,2) COMMENT 'R-squared value of calibration curve. Ref: LabWare LIMS.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: LabWare LIMS.',
    `record_status` STRING COMMENT 'The record status value recorded for each laboratory instrument calibration in the laboratory domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each laboratory instrument calibration in the laboratory domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each laboratory instrument calibration in the laboratory domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each laboratory instrument calibration record in the laboratory domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each laboratory instrument calibration in the laboratory domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each laboratory instrument calibration in the laboratory domain.',
    `result` STRING COMMENT 'Result of the calibration (e.g., pass, fail, conditional_pass). Ref: LabWare LIMS.',
    `slope` DECIMAL(18,2) COMMENT 'Calibration curve slope. Ref: LabWare LIMS.',
    `software_version` STRING COMMENT 'Instrument software version. Ref: LabWare LIMS.',
    `ssot_entity_type` STRING COMMENT 'The ssot entity type value recorded for each laboratory instrument calibration in the laboratory domain.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each laboratory instrument calibration in the laboratory domain.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: LabWare LIMS.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each laboratory instrument calibration record in the laboratory domain.',
    `standard_concentration` STRING COMMENT 'Concentration of calibration standard. Ref: LabWare LIMS.',
    `standard_expiration_date` DATE COMMENT 'Standard expiration date. Ref: LabWare LIMS.',
    `standard_expiry_date` TIMESTAMP COMMENT 'Expiry date of calibration standard. Ref: LabWare LIMS.',
    `standard_lot_number` STRING COMMENT 'Calibration standard lot number. Ref: LabWare LIMS.',
    `standard_reference_material` STRING COMMENT 'Reference material used for calibration. Ref: LabWare LIMS.',
    `standard_unit` STRING COMMENT 'Unit of calibration standard. Ref: LabWare LIMS.',
    `standard_used` STRING COMMENT 'The standard used value recorded for each laboratory instrument calibration in the laboratory domain.',
    `standard_value` DECIMAL(18,2) COMMENT 'Known reference standard concentration/value. Ref: LabWare LIMS.',
    `standard_vendor` STRING COMMENT 'Vendor/manufacturer of calibration standard. Ref: LabWare LIMS.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each laboratory instrument calibration record in the laboratory domain.',
    `laboratory_instrument_calibration_status` STRING COMMENT 'Lifecycle status of the record. Ref: LabWare LIMS.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each laboratory instrument calibration in the laboratory domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each laboratory instrument calibration record in the laboratory domain.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each laboratory instrument calibration in the laboratory domain.',
    CONSTRAINT pk_laboratory_instrument_calibration PRIMARY KEY(`laboratory_instrument_calibration_id`)
) COMMENT 'Transactional record of each instrument calibration event performed in the laboratory. Captures calibration type (initial, continuing, multi-point, single-point), calibration standard used, standard lot number and expiry, calibration curve coefficients, acceptance criteria (R² threshold, percent recovery), pass/fail result, calibration datetime, analyst performing calibration, and next calibration due date. Required for data defensibility under NELAC/TNI accreditation and EPA method requirements. [SSOT delegates to quality.quality_instrument_calibration] [SSOT: Canonical source of truth for this concept across domains.] SSOT master for instrument calibration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` (
    `qc_batch_id` BIGINT COMMENT 'Unique identifier for the quality control batch record. Primary key. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified laboratory analyst who performed the analytical work for this batch. Ensures traceability and accountability for test results. Ref: LabWare LIMS.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: QC batch costs (reference standards, control samples, analyst time) represent laboratory overhead that must be allocated to a cost center for overhead rate calculation and indirect cost distribution.. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the analytical instrument used for this batch. Links to instrument calibration records and maintenance history. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory supervisor or QA officer who reviewed and approved the batch QC results. Ensures accountability for data validation decisions.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the laboratory supervisor or QA officer who reviewed and approved the batch QC results. Ensures accountability for data validation decisions.',
    `test_method_id` BIGINT COMMENT 'Reference to the analytical test method applied to all samples in this QC batch. Ensures all samples are processed under the same standardized procedure. Ref: LabWare LIMS.',
    `batch_completion_datetime` TIMESTAMP COMMENT 'Date and time when all analytical work for the batch was completed and results were recorded. Used to calculate batch processing time and ensure timely reporting. Ref: LabWare LIMS.',
    `batch_number` STRING COMMENT 'Human-readable unique batch identifier assigned by the laboratory information management system (LIMS). Used for tracking and referencing in laboratory documentation and chain of custody records. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_preparation_datetime` TIMESTAMP COMMENT 'Date and time when the batch preparation or analytical run was initiated. Critical for hold time compliance and method-specific timing requirements. Ref: LabWare LIMS.',
    `batch_review_datetime` TIMESTAMP COMMENT 'Date and time when the QC batch was reviewed and acceptance status was assigned by the laboratory supervisor or quality assurance officer.',
    `batch_size` STRING COMMENT 'Total number of samples (including field samples and QC samples) processed together in this batch. Used to verify batch integrity and compliance with method-specific batch size limits. Ref: LabWare LIMS.',
    `batch_type` STRING COMMENT 'Classification of the QC batch based on the laboratory process stage. Preparation batch groups samples undergoing initial preparation; analytical batch groups samples analyzed together under identical conditions; extraction/digestion batches are specific to sample matrix processing. Ref: LabWare LIMS.. Valid values are `preparation_batch|analytical_batch|extraction_batch|digestion_batch|calibration_batch|validation_batch`',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether QC failures or deviations in this batch require formal corrective action per laboratory quality management system. Triggers corrective action workflow. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC batch record was first created in the data system. Part of audit trail for data lineage and compliance. Ref: LabWare LIMS.',
    `duplicate_acceptance_status` STRING COMMENT 'QC acceptance status for the duplicate sample based on RPD limits. Fail status may indicate sample heterogeneity or analytical imprecision. Ref: LabWare LIMS.. Valid values are `pass|fail|not_applicable`',
    `duplicate_relative_percent_difference` DECIMAL(18,2) COMMENT 'Calculated RPD between original and duplicate field samples. Measures precision of the entire analytical process including sample heterogeneity. Ref: LabWare LIMS.',
    `duplicate_sample_included` BOOLEAN COMMENT 'Indicates whether a duplicate field sample was analyzed in this batch. Duplicates assess overall analytical precision for unspiked samples. Ref: LabWare LIMS.',
    `field_sample_count` STRING COMMENT 'Number of actual field samples (non-QC samples) included in this batch. Excludes method blanks, laboratory control samples, and other QC samples. Ref: LabWare LIMS.',
    `lcs_acceptance_status` STRING COMMENT 'QC acceptance status for the LCS based on percent recovery limits. Fail status indicates systematic bias and may require corrective action or batch reanalysis. Ref: LabWare LIMS.. Valid values are `pass|fail|not_applicable`',
    `lcs_expected_value` DECIMAL(18,2) COMMENT 'Known or true concentration of the analyte in the laboratory control sample. Used to calculate percent recovery. Ref: LabWare LIMS.',
    `lcs_included` BOOLEAN COMMENT 'Indicates whether a laboratory control sample was included in this batch. LCS is a known-concentration standard used to verify method accuracy and instrument performance. Ref: LabWare LIMS.',
    `lcs_measured_value` DECIMAL(18,2) COMMENT 'Analytical result obtained for the laboratory control sample. Compared against expected value to calculate percent recovery. Ref: LabWare LIMS.',
    `lcs_percent_recovery` DECIMAL(18,2) COMMENT 'Calculated percent recovery for the LCS: (measured_value / expected_value) * 100. Must fall within method-specific acceptance limits (typically 80-120%) to validate batch accuracy. Ref: LabWare LIMS.',
    `lims_batch_code` STRING COMMENT 'External batch identifier from the laboratory information management system (LabWare or similar). Used for integration and cross-system traceability. Ref: LabWare LIMS.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `matrix_spike_acceptance_status` STRING COMMENT 'QC acceptance status for the matrix spike based on percent recovery limits. Fail status may indicate matrix interference requiring method modification or result qualification. Ref: LabWare LIMS.. Valid values are `pass|fail|not_applicable`',
    `matrix_spike_duplicate_included` BOOLEAN COMMENT 'Indicates whether a matrix spike duplicate was included in this batch. MSD is a second spiked aliquot of the same sample used to assess analytical precision through relative percent difference (RPD) calculation. Ref: LabWare LIMS.',
    `matrix_spike_included` BOOLEAN COMMENT 'Indicates whether a matrix spike sample was included in this batch. Matrix spike is a field sample spiked with known analyte concentration to assess matrix interference and method accuracy in real sample matrices. Ref: LabWare LIMS.',
    `matrix_spike_percent_recovery` DECIMAL(18,2) COMMENT 'Calculated percent recovery for the matrix spike. Evaluates the effect of sample matrix on analytical accuracy. Acceptance limits are method-specific. Ref: LabWare LIMS.',
    `method_blank_acceptance_status` STRING COMMENT 'QC acceptance status for the method blank based on method-specific criteria. Fail status indicates contamination and may require batch reanalysis. Ref: LabWare LIMS.. Valid values are `pass|fail|not_applicable`',
    `method_blank_included` BOOLEAN COMMENT 'Indicates whether a method blank (reagent blank) was included in this batch. Method blanks are required to detect contamination from reagents, glassware, or the analytical process. Ref: LabWare LIMS.',
    `method_blank_result` DECIMAL(18,2) COMMENT 'Analytical result for the method blank. Should be below the method detection limit (MDL) to confirm no contamination. Elevated blank results may invalidate the entire batch. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC batch record was last modified. Tracks data changes for audit and quality assurance purposes. Ref: LabWare LIMS.',
    `msd_acceptance_status` STRING COMMENT 'QC acceptance status for the MSD based on RPD limits. Fail status indicates poor precision and may require investigation or reanalysis. Ref: LabWare LIMS.. Valid values are `pass|fail|not_applicable`',
    `msd_percent_recovery` DECIMAL(18,2) COMMENT 'Calculated percent recovery for the matrix spike duplicate. Used in conjunction with MS recovery to calculate relative percent difference. Ref: LabWare LIMS.',
    `msd_relative_percent_difference` DECIMAL(18,2) COMMENT 'Calculated RPD between matrix spike and matrix spike duplicate: |MS - MSD| / ((MS + MSD) / 2) * 100. Measures analytical precision; must meet method-specific limits (typically <20%). Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each qc batch in the laboratory domain.',
    `overall_batch_acceptance_status` STRING COMMENT 'Final QC acceptance status for the entire batch based on all QC sample results. Accepted batches have all QC criteria met; rejected batches require reanalysis; conditional batches may have qualified results. Ref: LabWare LIMS.. Valid values are `accepted|rejected|conditional|under_review`',
    `qc_comments` STRING COMMENT 'Free-text field for documenting QC issues, corrective actions taken, deviations from standard procedures, or explanations for conditional acceptance. Critical for audit trail and regulatory compliance. Ref: LabWare LIMS.',
    `surrogate_acceptance_status` STRING COMMENT 'QC acceptance status for surrogate standards based on recovery limits. Fail status may indicate sample preparation problems or matrix interference. Ref: LabWare LIMS.. Valid values are `pass|fail|not_applicable`',
    `surrogate_included` BOOLEAN COMMENT 'Indicates whether surrogate standards were added to all samples in this batch. Surrogates are analyte-like compounds added before sample processing to monitor extraction and analytical efficiency. Ref: LabWare LIMS.',
    `surrogate_percent_recovery` DECIMAL(18,2) COMMENT 'Average percent recovery for surrogate standards across the batch. Used to assess sample preparation and extraction efficiency. Method-specific acceptance limits apply. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each qc batch in the laboratory domain.',
    CONSTRAINT pk_qc_batch PRIMARY KEY(`qc_batch_id`)
) COMMENT 'Quality control batch record grouping a set of analytical tests processed together under the same QC conditions. Defines the batch type (preparation batch, analytical batch), associated test method, batch size, batch preparation datetime, analyst, and the QC samples included (method blank, laboratory control sample, matrix spike, matrix spike duplicate, surrogate). Tracks overall batch acceptance status based on QC acceptance criteria and is the primary unit for QC review and data validation in the laboratory. Batch failure triggers corrective action and may require re-analysis of all associated samples.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` (
    `qc_sample_id` BIGINT COMMENT 'Unique identifier for the quality control sample record. Primary key. Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Reference to the specific analyte or parameter being measured in this QC sample (e.g., lead, chlorine, pH, Total Organic Carbon (TOC), Biochemical Oxygen Demand (BOD)). Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the laboratory instrument used for this QC sample analysis. Links to instrument calibration and maintenance records. Ref: LabWare LIMS.',
    `lab_sample_id` BIGINT COMMENT 'Reference to the associated environmental or production sample when applicable (e.g., for matrix spike or field duplicate QC types). Null for method blanks and laboratory control samples. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified laboratory analyst who performed the QC sample analysis. Required for chain of custody and accreditation compliance. Ref: LabWare LIMS.',
    `qc_batch_id` BIGINT COMMENT 'Reference to the QC batch that contains this QC sample. Links to the parent batch for traceability. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Reference to the analytical test method applied to this QC sample. Links to the standard operating procedure and method specifications. Ref: LabWare LIMS.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation body or state certification program under which this QC sample was analyzed (e.g., state drinking water laboratory certification program, NELAP, A2LA). Required for regulatory reporting and audit trail. Ref: LabWare LIMS.',
    `analysis_date` DATE COMMENT 'Date the QC sample was analyzed in the laboratory. Used to verify compliance with method-specific holding time requirements and to track batch chronology. Ref: LabWare LIMS.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Precise date and time the QC sample analysis was completed. Provides detailed audit trail for Laboratory Information Management System (LIMS) integration and regulatory reporting. Ref: LabWare LIMS.',
    `concentration_unit` STRING COMMENT 'Unit of measure for the expected and measured concentration values. Common units include milligrams per liter (mg/L), micrograms per liter (ug/L), nanograms per liter (ng/L), parts per million (ppm), parts per billion (ppb), parts per trillion (ppt), Nephelometric Turbidity Units (NTU), Colony Forming Units per 100 milliliters (CFU/100mL), Most Probable Number per 100 milliliters (MPN/100mL), pH units, percent, and Standard Units (SU). [ENUM-REF-CANDIDATE: mg/L|ug/L|ng/L|ppm|ppb|ppt|NTU|CFU/100mL|MPN/100mL|pH_units|percent|SU — 12 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required based on QC sample failure. True if the QC failure necessitates re-analysis, method adjustment, or other corrective measures; false otherwise. Ref: LabWare LIMS.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective action taken in response to QC sample failure. May include re-analysis, instrument recalibration, method modification, or sample re-collection. Required for laboratory accreditation and audit trail. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC sample record was first created in the data warehouse. Part of the audit trail for data lineage and compliance. Ref: LabWare LIMS.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Method Detection Limit (MDL) for the analyte and test method at the time of analysis. Represents the minimum concentration that can be measured and reported with 99% confidence that the analyte is greater than zero. Ref: LabWare LIMS.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Dilution factor applied to the QC sample during preparation or analysis. A value of 1.0 indicates no dilution; values greater than 1.0 indicate the sample was diluted. Used to back-calculate original concentrations. Ref: LabWare LIMS.',
    `expected_concentration` DECIMAL(18,2) COMMENT 'The known or target concentration value for the QC sample. For LCS and CRM, this is the certified value; for matrix spikes, this is the spiked amount plus the native sample concentration; for blanks, this is typically zero. Ref: LabWare LIMS.',
    `lims_sample_number` STRING COMMENT 'Unique sample identifier assigned by the Laboratory Information Management System (LIMS), such as LabWare. Used for integration and cross-referencing between the data warehouse and the operational LIMS system. Ref: LabWare LIMS.',
    `lower_acceptance_limit` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable range for percent recovery or Relative Percent Difference (RPD). Defined by the analytical method, laboratory Standard Operating Procedure (SOP), or regulatory requirement. QC samples below this limit fail acceptance criteria. Ref: LabWare LIMS.',
    `measured_concentration` DECIMAL(18,2) COMMENT 'The actual concentration value obtained from laboratory analysis of the QC sample. Used to calculate recovery and evaluate method performance. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC sample record was last modified in the data warehouse. Tracks data lineage and supports audit trail requirements. Ref: LabWare LIMS.',
    `mvm_tier` STRING COMMENT 'The mvm tier value recorded for each qc sample in the laboratory domain.',
    `native_concentration` DECIMAL(18,2) COMMENT 'Original concentration of the analyte in the sample before spiking, applicable to matrix spike and matrix spike duplicate QC types. Used in recovery calculations: recovery = (measured - native) / spike * 100. Ref: LabWare LIMS.',
    `percent_recovery` DECIMAL(18,2) COMMENT 'Calculated percent recovery of the QC sample, computed as (measured_concentration / expected_concentration) * 100. Indicates the accuracy of the analytical method. Typically evaluated against acceptance limits defined in the method or laboratory QA plan. Ref: LabWare LIMS.',
    `proficiency_test_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this QC sample is part of an external proficiency testing program (e.g., EPA Water Pollution Performance Evaluation Studies, AWWA proficiency testing). True if part of proficiency testing; false for routine internal QC.',
    `proficiency_test_provider` STRING COMMENT 'Name of the external proficiency testing provider if this QC sample is part of a proficiency test (e.g., EPA, AWWA, Environmental Resource Associates). Null for routine internal QC samples.',
    `qc_comments` STRING COMMENT 'Free-text comments from the analyst or quality assurance officer regarding the QC sample. May include notes on anomalies, corrective actions taken, reasons for failure, or special handling procedures. Ref: LabWare LIMS.',
    `qc_sample_type` STRING COMMENT 'Type of quality control sample. Method blank verifies absence of contamination; Laboratory Control Sample (LCS) verifies method accuracy; Matrix Spike (MS) and Matrix Spike Duplicate (MSD) verify matrix interference and precision; field duplicate and field blank verify field collection procedures; surrogate spike verifies extraction efficiency; Certified Reference Material (CRM) verifies instrument calibration. [ENUM-REF-CANDIDATE: method_blank|laboratory_control_sample|matrix_spike|matrix_spike_duplicate|field_duplicate|field_blank|surrogate_spike|certified_reference_material — 8 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `qc_status` STRING COMMENT 'Pass/fail status of the QC sample based on comparison of percent recovery or Relative Percent Difference (RPD) against acceptance limits. Pass indicates the QC sample met all acceptance criteria; fail indicates one or more criteria were not met; warning indicates results are marginal; pending_review indicates awaiting quality assurance officer review; not_applicable for QC types without numeric acceptance criteria.. Valid values are `pass|fail|warning|pending_review|not_applicable`',
    `relative_percent_difference` DECIMAL(18,2) COMMENT 'Relative Percent Difference between duplicate QC samples (e.g., matrix spike and matrix spike duplicate, or field duplicates). Calculated as absolute difference divided by the mean, multiplied by 100. Measures precision and reproducibility of the analytical method. Ref: LabWare LIMS.',
    `reporting_limit` DECIMAL(18,2) COMMENT 'Reporting Limit (RL) or Practical Quantitation Limit (PQL) for the analyte and test method. The minimum concentration that can be reliably quantified and reported to regulatory agencies. Typically 3-5 times the Method Detection Limit (MDL). Ref: LabWare LIMS.',
    `review_date` DATE COMMENT 'Date the QC sample results were reviewed and validated by the quality assurance officer. Part of the data validation and approval workflow. Ref: LabWare LIMS.',
    `spike_concentration` DECIMAL(18,2) COMMENT 'Concentration of analyte added to the sample for matrix spike, matrix spike duplicate, or surrogate spike QC types. Null for other QC types. Used to calculate percent recovery in the presence of sample matrix. Ref: LabWare LIMS.',
    `upper_acceptance_limit` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable range for percent recovery or Relative Percent Difference (RPD). Defined by the analytical method, laboratory Standard Operating Procedure (SOP), or regulatory requirement. QC samples above this limit fail acceptance criteria. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each qc sample in the laboratory domain.',
    CONSTRAINT pk_qc_sample PRIMARY KEY(`qc_sample_id`)
) COMMENT 'Record for each quality control sample included in a QC batch. Captures QC sample type (method blank, laboratory control sample LCS, matrix spike MS, matrix spike duplicate MSD, field duplicate, field blank, surrogate spike, certified reference material CRM), expected concentration, measured concentration, percent recovery, relative percent difference RPD, acceptance limits, and pass/fail status. Provides the QA/QC evidence trail required for data validation and laboratory accreditation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` (
    `certified_analyst_id` BIGINT COMMENT 'Unique identifier for the certified laboratory analyst record. Primary key for the certified analyst entity. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the employee ID of the analysts direct supervisor or laboratory manager. Used for organizational hierarchy and approval workflows.',
    `primary_certified_employee_id` BIGINT COMMENT 'Reference to the employee record in the workforce domain. Links the laboratory certification record to the underlying employee master data. Ref: LabWare LIMS.',
    `analyst_first_name` STRING COMMENT 'First name of the certified laboratory analyst. Used for identification on laboratory reports and chain of custody documentation. Ref: LabWare LIMS.',
    `analyst_last_name` STRING COMMENT 'Last name of the certified laboratory analyst. Used for identification on laboratory reports and chain of custody documentation. Ref: LabWare LIMS.',
    `analyst_middle_initial` STRING COMMENT 'Middle initial of the certified laboratory analyst. Optional field for complete name identification. Ref: LabWare LIMS.',
    `background_check_date` DATE COMMENT 'Date of the most recent background check or security clearance verification. Required for analysts working with sensitive data or in facilities subject to security regulations. Ref: LabWare LIMS.',
    `certification_level` STRING COMMENT 'Hierarchical level or grade of the certification indicating the complexity of analytical work the analyst is authorized to perform. Higher levels typically authorize more complex testing methods and supervisory responsibilities.. Valid values are `level_1|level_2|level_3|level_4|advanced|master`',
    `certification_number` STRING COMMENT 'Unique certification number or license number issued by the certifying body. This is the official credential identifier that must be referenced on laboratory reports and regulatory submissions. Ref: LabWare LIMS.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Active certifications authorize the analyst to perform regulated work; expired, suspended, or revoked certifications prohibit such work until reinstated. Ref: LabWare LIMS.. Valid values are `active|expired|suspended|revoked|pending_renewal|inactive`',
    `certification_type` STRING COMMENT 'Type of laboratory certification held by the analyst. Categories include state drinking water analyst certification, wastewater operator certification, NELAC (National Environmental Laboratory Accreditation Conference) signatory authority, laboratory director certification, quality assurance officer certification, or specialty method certification. Ref: LabWare LIMS.. Valid values are `state_drinking_water|wastewater_operator|nelac_signatory|laboratory_director|quality_assurance|specialty_method`',
    `certifying_body` STRING COMMENT 'Name of the organization or agency that issued the certification. Examples include state environmental agencies, EPA regional offices, NELAC accreditation bodies, or professional associations such as AWWA or WEF.',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Total number of continuing education hours or professional development units earned by the analyst in the current certification period. Required for certification renewal. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certified analyst record was first created in the system. Part of the audit trail for data lineage and compliance tracking. Ref: LabWare LIMS.',
    `email_address` STRING COMMENT 'Primary email address for the analyst. Used for official communications, training notifications, and certification renewal reminders. Ref: LabWare LIMS.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_phone` STRING COMMENT 'Emergency contact phone number for the analyst. Used for urgent notifications related to laboratory incidents, sample integrity issues, or regulatory inquiries. Ref: LabWare LIMS.',
    `expiration_date` DATE COMMENT 'Date on which the certification expires and must be renewed. Critical for compliance tracking to ensure only currently certified analysts perform regulated analytical work. Ref: LabWare LIMS.',
    `instrument_qualifications` STRING COMMENT 'Comma-separated list of laboratory instruments the analyst is trained and qualified to operate. Examples include ICP-MS (Inductively Coupled Plasma Mass Spectrometry), GC-MS (Gas Chromatography Mass Spectrometry), IC (Ion Chromatography), UV-Vis spectrophotometer, TOC (Total Organic Carbon) analyzer, etc. Ref: LabWare LIMS.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this certified analyst record is currently active. Inactive records represent analysts who have left the organization or whose certifications are no longer maintained. Ref: LabWare LIMS.',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued to the analyst. Used to calculate tenure and experience with the certification. Ref: LabWare LIMS.',
    `laboratory_assignment` STRING COMMENT 'Name or code of the laboratory facility or work center where the analyst is primarily assigned. Examples include Central Laboratory, WTP (Water Treatment Plant) Lab, WWTP (Wastewater Treatment Plant) Lab, or Field Testing Unit. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certified analyst record was most recently updated. Part of the audit trail for data lineage and compliance tracking. Ref: LabWare LIMS.',
    `last_proficiency_test_date` DATE COMMENT 'Date of the most recent proficiency testing event completed by the analyst. Used to track compliance with annual or semi-annual PT requirements. Ref: LabWare LIMS.',
    `lims_user_code` STRING COMMENT 'User identifier for the analyst in the Laboratory Information Management System (LabWare or similar). Links the certification record to the analysts login and activity in the LIMS for audit trail and data integrity purposes. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the analysts certification or qualifications. May include restrictions, accommodations, or historical context. Ref: LabWare LIMS.',
    `proficiency_testing_status` STRING COMMENT 'Status of the analysts participation in proficiency testing programs. Proficiency testing is required for NELAC accreditation and demonstrates the analysts ability to produce accurate results. Current status indicates successful completion of required PT samples. Ref: LabWare LIMS.. Valid values are `current|overdue|failed|not_required`',
    `quality_control_role` STRING COMMENT 'Role of the analyst in the laboratorys quality assurance and quality control program. Roles include bench analyst, data reviewer, QA officer, or technical director with oversight responsibilities. Ref: LabWare LIMS.. Valid values are `analyst|reviewer|qa_officer|technical_director|none`',
    `record_source` STRING COMMENT 'Identifier of the source system from which this certified analyst record originated. Examples include LIMS (LabWare), SAP HR, or manual certification tracking system. Ref: LabWare LIMS.',
    `renewal_date` DATE COMMENT 'Date on which the certification was most recently renewed. Tracks the analysts compliance with continuing education and renewal requirements. Ref: LabWare LIMS.',
    `safety_training_date` DATE COMMENT 'Date of the most recent laboratory safety training completion. Required annually for OSHA compliance and includes topics such as chemical hygiene, hazardous waste handling, and emergency response.',
    `shift_assignment` STRING COMMENT 'Work shift to which the analyst is assigned. Relevant for 24/7 laboratory operations and emergency response coverage. Ref: LabWare LIMS.. Valid values are `day|evening|night|rotating|on_call`',
    `signatory_authority` BOOLEAN COMMENT 'Boolean flag indicating whether the analyst has signatory authority to approve and sign laboratory reports for regulatory submission. Signatory authority is typically restricted to senior analysts or laboratory directors who meet specific qualification criteria. Ref: LabWare LIMS.',
    `specialty_areas` STRING COMMENT 'Comma-separated list of analytical specialty areas or matrices the analyst is qualified to work with. Examples include drinking water microbiology, wastewater metals, organic compounds, radiochemistry, or specific contaminant groups such as PFAS (Per- and Polyfluoroalkyl Substances) or DBPs (Disinfection Byproducts). Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each certified analyst in the laboratory domain.',
    CONSTRAINT pk_certified_analyst PRIMARY KEY(`certified_analyst_id`)
) COMMENT 'Master record for each laboratory analyst holding certifications relevant to water and wastewater analytical work. Captures analyst name, employee reference, certification type (state drinking water analyst certification, wastewater operator certification, NELAC signatory authority), certifying body, certification number, issue date, expiration date, renewal status, and approved test methods the analyst is qualified to perform. Distinct from the workforce domain employee record; this entity owns the laboratory-specific certification and method authorization data.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` (
    `lab_accreditation_id` BIGINT COMMENT 'Unique identifier for the laboratory accreditation record. Primary key. Ref: LabWare LIMS.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Each accreditation record belongs to a specific laboratory; adding laboratory_id FK enables direct navigation and eliminates need to infer via other tables. No existing FK from laboratory to lab_accre. Ref: LabWare LIMS.',
    `accreditation_certificate_number` STRING COMMENT 'The unique certificate number issued by the accrediting body for this accreditation. Ref: LabWare LIMS.',
    `accreditation_cost_usd` DECIMAL(18,2) COMMENT 'The total cost in US dollars for obtaining and maintaining this accreditation, including application fees, assessment fees, and proficiency testing costs. Ref: LabWare LIMS.',
    `accreditation_document_url` STRING COMMENT 'URL or file path to the digital copy of the accreditation certificate and scope document. Ref: LabWare LIMS.',
    `accreditation_scope_description` STRING COMMENT 'Detailed description of the accreditation scope, including the list of accredited analytes, matrices, and test methods covered under this accreditation. Ref: LabWare LIMS.',
    `accreditation_status` STRING COMMENT 'Current status of the accreditation (active, suspended, revoked, expired, pending, provisional). Ref: LabWare LIMS.. Valid values are `active|suspended|revoked|expired|pending|provisional`',
    `accreditation_type` STRING COMMENT 'The type or program of accreditation granted (e.g., state primacy, NELAC/TNI, A2LA, DoD ELAP, ISO 17025).. Valid values are `state_primacy|nelac_tni|a2la|dod_elap|iso_17025|other`',
    `conditions_or_deficiencies_noted` STRING COMMENT 'Any conditions, limitations, or deficiencies noted by the accrediting body during the last assessment. May include corrective action requirements. Ref: LabWare LIMS.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which corrective actions must be completed and submitted to the accrediting body. Ref: LabWare LIMS.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required to maintain or restore accreditation status. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation record was first created in the system. Ref: LabWare LIMS.',
    `initial_accreditation_date` DATE COMMENT 'The date when the laboratory first received this accreditation from the accrediting body. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation record was last updated in the system. Ref: LabWare LIMS.',
    `next_assessment_due_date` DATE COMMENT 'The scheduled date for the next on-site or surveillance assessment by the accrediting body. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each lab accreditation in the laboratory domain.',
    CONSTRAINT pk_lab_accreditation PRIMARY KEY(`lab_accreditation_id`)
) COMMENT 'Master record for the laboratorys accreditation and certification status with regulatory and accrediting bodies. Captures accrediting organization (state primacy agency, NELAC/TNI, A2LA, DoD ELAP), accreditation scope (list of accredited analytes and matrices), certificate number, accreditation status, initial accreditation date, current certificate expiry, last on-site assessment date, next assessment due date, and any conditions or deficiencies noted. Critical for demonstrating regulatory defensibility of analytical data.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` (
    `proficiency_test_id` BIGINT COMMENT 'Unique identifier for the proficiency testing study participation event. Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Reference to the analyte or parameter tested (e.g., lead, pH, total coliform). Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified analyst who performed the proficiency test analysis. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the laboratory instrument used for the proficiency test analysis. Ref: LabWare LIMS.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory that participated in this proficiency test. Ref: LabWare LIMS.',
    `lab_sample_id` BIGINT COMMENT 'Unique sample identifier assigned by the proficiency test provider. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance officer or supervisor who reviewed the proficiency test results.',
    `proficiency_reviewed_by_employee_id` BIGINT COMMENT 'Reference to the quality assurance officer or supervisor who reviewed the proficiency test results.',
    `pt_provider_id` BIGINT COMMENT 'Reference to the proficiency testing provider organization (ERA, NERL, LGC, etc.). Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Reference to the analytical test method used for this proficiency test. Ref: LabWare LIMS.',
    `vendor_id` BIGINT COMMENT 'Reference to the proficiency testing provider organization (ERA, NERL, LGC, etc.). Ref: LabWare LIMS.',
    `acceptance_criteria` STRING COMMENT 'Acceptance limits or criteria defined by the proficiency test provider (e.g., z-score ±2.0, recovery 80-120%). Ref: LabWare LIMS.',
    `accreditation_field` STRING COMMENT 'Field of accreditation or testing category this proficiency test supports (e.g., Drinking Water Chemistry, Microbiology). Ref: LabWare LIMS.',
    `accreditation_impact` STRING COMMENT 'Assessment of the impact of this proficiency test result on laboratory accreditation status. Ref: LabWare LIMS.. Valid values are `none|warning|suspension_risk|revocation_risk`',
    `analysis_date` DATE COMMENT 'Date the proficiency test sample was analyzed by the laboratory. Ref: LabWare LIMS.',
    `assigned_value` DECIMAL(18,2) COMMENT 'True or reference concentration value assigned by the proficiency test provider. Ref: LabWare LIMS.',
    `comments` STRING COMMENT 'Additional comments or notes regarding the proficiency test participation, analysis, or results. Ref: LabWare LIMS.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required due to proficiency test failure or unacceptable performance. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this proficiency test record was first created in the system. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this proficiency test record was last modified. Ref: LabWare LIMS.',
    `participant_count` STRING COMMENT 'Number of laboratories that participated in this proficiency test round. Ref: LabWare LIMS.',
    `peer_group_mean` DECIMAL(18,2) COMMENT 'Mean value reported by all participating laboratories in the peer group. Ref: LabWare LIMS.',
    `peer_group_standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of values reported by all participating laboratories in the peer group. Ref: LabWare LIMS.',
    `percentile_rank` DECIMAL(18,2) COMMENT 'Percentile ranking of the laboratorys performance relative to all participants (0-100). Ref: LabWare LIMS.',
    `performance_score` DECIMAL(18,2) COMMENT 'Alternative performance metric used by some proficiency test providers (e.g., percent recovery, bias). Ref: LabWare LIMS.',
    `pt_round` STRING COMMENT 'Round or cycle identifier for the proficiency test (e.g., 2024-Q1, Round 45). Ref: LabWare LIMS.',
    `pt_study_name` STRING COMMENT 'Name of the proficiency testing study or program (e.g., WP-123, DMR-QA). Ref: LabWare LIMS.',
    `report_receipt_date` DATE COMMENT 'Date the laboratory received the final proficiency test report from the provider. Ref: LabWare LIMS.',
    `reported_value` DECIMAL(18,2) COMMENT 'Concentration value reported by the laboratory for the proficiency test sample. Ref: LabWare LIMS.',
    `result_status` STRING COMMENT 'Pass/fail determination or acceptability status of the proficiency test result. Ref: LabWare LIMS.. Valid values are `pass|fail|acceptable|unacceptable|warning|pending_review`',
    `review_date` DATE COMMENT 'Date the proficiency test results were reviewed and approved by quality assurance. Ref: LabWare LIMS.',
    `sample_matrix` STRING COMMENT 'Type of sample matrix tested in the proficiency test. [ENUM-REF-CANDIDATE: drinking_water|wastewater|surface_water|groundwater|soil|sediment|sludge|biosolids|other — 9 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `sample_receipt_date` DATE COMMENT 'Date the proficiency test sample was received by the laboratory. Ref: LabWare LIMS.',
    `submission_date` DATE COMMENT 'Actual date the laboratory submitted results to the proficiency test provider. Ref: LabWare LIMS.',
    `submission_deadline` DATE COMMENT 'Deadline date by which the laboratory must submit results to the proficiency test provider. Ref: LabWare LIMS.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the assigned and reported values (e.g., mg/L, ug/L, NTU, pH units). Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each proficiency test in the laboratory domain.',
    `z_score` DECIMAL(18,2) COMMENT 'Statistical z-score calculated from the reported value, assigned value, and standard deviation, indicating performance relative to peer laboratories. Ref: LabWare LIMS.',
    CONSTRAINT pk_proficiency_test PRIMARY KEY(`proficiency_test_id`)
) COMMENT 'Record of each proficiency testing (PT) study participation event required to maintain laboratory accreditation. Captures the PT provider (ERA, NERL, LGC), study name and round, analyte(s) tested, sample matrix, assigned value (true concentration), reported value, z-score or performance score, pass/fail determination, and submission deadline. Tracks the laboratorys ongoing demonstration of analytical competency as required by NELAC/TNI and state primacy agencies.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` (
    `result_validation_id` BIGINT COMMENT 'Unique identifier for the result validation record. Primary key. Ref: LabWare LIMS.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Laboratorys result_validation process validates quality domains analytical_result records. Data validation workflow (Level II/III review) requires linking validation findings to final reported resul. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the certified analyst or data validator who performed the validation review. Must be a qualified individual per laboratory QA/QC protocols. Ref: LabWare LIMS.',
    `result_employee_id` BIGINT COMMENT 'Reference to the certified analyst or data validator who performed the validation review. Must be a qualified individual per laboratory QA/QC protocols. Ref: LabWare LIMS.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to a secondary reviewer or quality assurance officer who performed independent review of the validation. Used in laboratories with multi-tier validation protocols. Ref: LabWare LIMS.',
    `reviewer_id` BIGINT COMMENT 'Reference to a secondary reviewer or quality assurance officer who performed independent review of the validation. Used in laboratories with multi-tier validation protocols. Ref: LabWare LIMS.',
    `test_result_id` BIGINT COMMENT 'Reference to the test result record being validated. Links to the laboratory test result that underwent this validation review. Ref: LabWare LIMS.',
    `validation_batch_id` BIGINT COMMENT 'Reference to the validation batch if multiple results were validated together. Enables grouping of validation activities performed in a single review session. Ref: LabWare LIMS.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this validation requires formal approval by a laboratory director or quality assurance manager before data release. True if approval is required, False if validator authority is sufficient. Ref: LabWare LIMS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the validation was formally approved for data release. Applicable when approval_required_flag is True. Ref: LabWare LIMS.',
    `calibration_verification_flag` BOOLEAN COMMENT 'Indicates whether instrument calibration was current and verified at the time of analysis. True if calibration was valid, False if calibration issues were identified. Ref: LabWare LIMS.',
    `chain_of_custody_verified_flag` BOOLEAN COMMENT 'Indicates whether the chain of custody documentation was complete and verified during validation. True if COC is intact and verified, False if discrepancies were found. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this validation record was first created in the system. Audit trail field for data lineage and compliance tracking. Ref: LabWare LIMS.',
    `data_release_timestamp` TIMESTAMP COMMENT 'Date and time when the validated result was released for regulatory reporting, customer delivery, or internal use. Marks the completion of the validation and approval workflow. Ref: LabWare LIMS.',
    `flags_raised_count` STRING COMMENT 'Number of quality flags or warnings raised during validation. Flags may indicate potential issues that do not necessarily result in rejection but require documentation. Ref: LabWare LIMS.',
    `holding_time_compliance_flag` BOOLEAN COMMENT 'Indicates whether the sample holding time requirements were met per EPA method specifications. True if compliant, False if holding time was exceeded. Ref: LabWare LIMS.',
    `method_compliance_flag` BOOLEAN COMMENT 'Indicates whether the analytical method was performed in full compliance with the approved EPA or Standard Method protocol. True if compliant, False if deviations occurred. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this validation record. Audit trail field for tracking changes and maintaining data integrity. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this validation record was last modified. Audit trail field for tracking changes to validation decisions or documentation. Ref: LabWare LIMS.',
    `qc_acceptance_criteria_met_flag` BOOLEAN COMMENT 'Indicates whether all quality control acceptance criteria (blanks, duplicates, spikes, surrogates, calibration verification) were met for this result. True if all QC passed, False if any QC failure occurred. Ref: LabWare LIMS.',
    `qualifiers_applied` STRING COMMENT 'Data qualifiers or flags assigned to the result during validation. Common qualifiers include J (estimated value), U (non-detect), R (rejected), Q (quality control issue). Multiple qualifiers may be comma-separated. Ref: LabWare LIMS.',
    `regulatory_defensibility_flag` BOOLEAN COMMENT 'Indicates whether the validated result meets the full defensibility standard required for regulatory reporting and potential legal proceedings. True if defensible, False if data quality issues compromise defensibility. Ref: LabWare LIMS.',
    `regulatory_program` STRING COMMENT 'The regulatory program or compliance framework under which this validation was performed. Examples: SDWA compliance monitoring, NPDES permit monitoring, CWA industrial pretreatment, state-specific programs. Ref: LabWare LIMS.',
    `results_rejected_count` STRING COMMENT 'Number of individual test results rejected during this validation review. Used for quality metrics and laboratory performance tracking. Ref: LabWare LIMS.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the secondary review was completed. Applicable when laboratory protocols require independent QA review of validation decisions. Ref: LabWare LIMS.',
    `validation_criteria_applied` STRING COMMENT 'Description of the specific validation criteria, checklists, or protocols applied during the review. May reference EPA method requirements, laboratory SOP numbers, or regulatory program-specific validation rules. Ref: LabWare LIMS.',
    `validation_disposition` STRING COMMENT 'Final outcome of the validation review. Accepted: result meets all quality criteria and is released without qualification. Qualified: result is usable but carries data qualifiers or flags. Rejected: result fails validation and cannot be used for regulatory reporting. Ref: LabWare LIMS.. Valid values are `accepted|qualified|rejected`',
    `validation_duration_minutes` STRING COMMENT 'Total time in minutes spent performing the validation review. Used for laboratory productivity metrics and resource planning. Ref: LabWare LIMS.',
    `validation_findings` STRING COMMENT 'Detailed narrative of validation findings, issues identified, corrective actions taken, and rationale for the final disposition. Critical for regulatory audit trail and data defensibility. Ref: LabWare LIMS.',
    `validation_level` STRING COMMENT 'The EPA validation protocol level applied to this result. Level I: basic data verification; Level II: analytical QC review; Level III: method and holding time compliance; Level IV: full data package audit for regulatory defensibility. Ref: LabWare LIMS.. Valid values are `Level I|Level II|Level III|Level IV`',
    `validation_notes` STRING COMMENT 'Additional notes, comments, or observations recorded by the validator during the review process. May include references to supporting documentation, communications with analysts, or special circumstances. Ref: LabWare LIMS.',
    `validation_status` STRING COMMENT 'Current workflow status of the validation process. Tracks whether the validation review is pending, in progress, completed, or on hold pending additional information. Ref: LabWare LIMS.. Valid values are `pending|in_progress|completed|on_hold`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the validation review was completed. Critical for establishing data release timeline and regulatory reporting deadlines. Ref: LabWare LIMS.',
    `validator_certification_number` STRING COMMENT 'Professional certification or license number of the validator. Required for regulatory defensibility under SDWA and CWA compliance programs. Ref: LabWare LIMS.',
    `validator_name` STRING COMMENT 'Full name of the validator who performed the review. Provides human-readable identification for audit trail and regulatory reporting. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each result validation in the laboratory domain.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this validation record. Audit trail field for accountability and data governance. Ref: LabWare LIMS.',
    CONSTRAINT pk_result_validation PRIMARY KEY(`result_validation_id`)
) COMMENT 'Record of the formal data validation review applied to a set of test results before release. Captures the validation level (level I through IV per EPA validation protocols), validator identity, validation datetime, validation criteria applied, findings (qualifiers applied, results rejected, flags raised), and final validation disposition (accepted, qualified, rejected). Ensures that all data released for regulatory reporting meets defensibility standards under SDWA, CWA, and NPDES requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` (
    `reagent_standard_id` BIGINT COMMENT 'Unique identifier for the laboratory reagent or chemical standard record. Primary key for the reagent standard master inventory. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: QC/QA protocols require documented employee accountability for reagent preparation. Accreditation standards (TNI, NELAC) mandate traceable preparation records linking to qualified employees for method. Ref: LabWare LIMS.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Reagents and certified reference materials are procured from chemical suppliers. Tracking vendor is essential for COA verification, lot traceability, reordering, and quality control. Replaces denormal. Ref: LabWare LIMS.',
    `associated_test_methods` STRING COMMENT 'Comma-separated list of analytical test method codes or names for which this reagent or standard is used. Supports traceability of reagents to specific analytical procedures and regulatory compliance demonstrations. Ref: LabWare LIMS.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature. Used for unambiguous identification of reagents and standards. Ref: LabWare LIMS.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `catalog_number` STRING COMMENT 'Manufacturer or supplier catalog number for the reagent or standard. Used for reordering and traceability to supplier specifications. Ref: LabWare LIMS.',
    `certificate_number` STRING COMMENT 'Certificate of analysis or certificate of conformance number provided by the manufacturer or certifying body. Documents the certified properties and traceability of the standard. Ref: LabWare LIMS.',
    `certified_reference_material_flag` BOOLEAN COMMENT 'Indicates whether this standard is a certified reference material with traceability to national or international measurement standards. True if CRM, false otherwise. CRMs are required for certain regulatory compliance testing. Ref: LabWare LIMS.',
    `concentration_unit` STRING COMMENT 'Unit of measure for the concentration or purity value: milligrams per liter (mg/L), micrograms per liter (ug/L), percent (%), parts per million (ppm), parts per billion (ppb), molarity (M), or normality (N). [ENUM-REF-CANDIDATE: mg_l|ug_l|percent|ppm|ppb|molarity|normality — 7 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `concentration_value` DECIMAL(18,2) COMMENT 'Numeric concentration or purity of the reagent or standard as certified by the manufacturer or as prepared in the laboratory. Used in calibration calculations and quality control verification. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reagent standard record was first created in the Laboratory Information Management System (LIMS). Part of the audit trail. Ref: LabWare LIMS.',
    `current_stock_quantity` DECIMAL(18,2) COMMENT 'Current quantity of the reagent or standard available in laboratory inventory. Updated as material is consumed or replenished. Ref: LabWare LIMS.',
    `disposal_method` STRING COMMENT 'Approved method for disposing of expired or unused reagent or standard, such as chemical waste collection, neutralization, incineration, or return to supplier. Ensures compliance with environmental and safety regulations. Ref: LabWare LIMS.',
    `expiry_date` DATE COMMENT 'Date after which the reagent or standard should no longer be used for analytical testing due to potential degradation or loss of certified properties. Determined by manufacturer specifications or laboratory stability studies. Ref: LabWare LIMS.',
    `hazard_classification` STRING COMMENT 'Safety hazard classification of the reagent according to Globally Harmonized System (GHS) or OSHA Hazard Communication Standard. Examples include flammable, corrosive, toxic, oxidizer, or non-hazardous.',
    `last_calibration_date` DATE COMMENT 'Date on which this standard was last used for instrument calibration or quality control verification. Supports traceability and audit trail for analytical data defensibility. Ref: LabWare LIMS.',
    `lot_number` STRING COMMENT 'Manufacturer-assigned lot or batch number for the reagent or standard. Essential for traceability in the event of quality issues or recalls and for demonstrating chain of custody in regulatory audits. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this reagent standard record in the Laboratory Information Management System (LIMS). Supports accountability and audit compliance. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this reagent standard record was last modified in the Laboratory Information Management System (LIMS). Supports change tracking and audit compliance. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional information, observations, or special handling instructions related to the reagent or standard. May include stability observations, usage restrictions, or audit findings. Ref: LabWare LIMS.',
    `preparation_date` DATE COMMENT 'Date on which the reagent or standard was prepared or diluted in the laboratory. For commercially prepared standards, this is the manufacture date. Critical for determining shelf life and expiry. Ref: LabWare LIMS.',
    `reagent_name` STRING COMMENT 'Full chemical or commercial name of the reagent, standard, or reference material as provided by the manufacturer or as catalogued in the Laboratory Information Management System (LIMS). Ref: LabWare LIMS.',
    `reagent_standard_status` STRING COMMENT 'Current lifecycle status of the reagent or standard: active (in use), expired (past expiry date), depleted (stock exhausted), quarantined (under investigation or hold), or disposed (removed from inventory). Ref: LabWare LIMS.. Valid values are `active|expired|depleted|quarantined|disposed`',
    `reagent_type` STRING COMMENT 'Classification of the chemical material by its intended laboratory use: reagent for general analytical work, standard for calibration, reference material for quality control, buffer for pH adjustment, indicator for endpoint detection, or solvent for dilution and extraction. Ref: LabWare LIMS.. Valid values are `reagent|standard|reference_material|buffer|indicator|solvent`',
    `reorder_threshold` DECIMAL(18,2) COMMENT 'Minimum stock quantity that triggers a reorder alert or procurement action. Ensures continuous availability of critical reagents and standards for analytical operations. Ref: LabWare LIMS.',
    `safety_data_sheet_reference` STRING COMMENT 'Reference identifier or file location for the Safety Data Sheet (SDS) associated with this reagent. SDS provides hazard information, handling instructions, and emergency procedures. Ref: LabWare LIMS.',
    `stock_unit` STRING COMMENT 'Unit of measure for the stock quantity: milliliters (mL), liters (L), grams (g), kilograms (kg), units, or vials. Ref: LabWare LIMS.. Valid values are `ml|l|g|kg|units|vials`',
    `storage_conditions` STRING COMMENT 'Required environmental conditions for storing the reagent or standard to maintain stability and integrity: ambient temperature, refrigerated (2-8°C), frozen (<0°C), protected from light (dark), or under inert atmosphere. Ref: LabWare LIMS.. Valid values are `ambient|refrigerated|frozen|dark|inert_atmosphere`',
    `storage_location` STRING COMMENT 'Physical location within the laboratory where the reagent or standard is stored, such as refrigerator ID, cabinet number, or shelf designation. Supports inventory management and retrieval. Ref: LabWare LIMS.',
    `verified_by` STRING COMMENT 'Name or identifier of the laboratory supervisor or quality assurance officer who verified the preparation or receipt of the reagent or standard. Ensures independent quality control.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each reagent standard in the laboratory domain.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this reagent standard record in the Laboratory Information Management System (LIMS). Part of the audit trail. Ref: LabWare LIMS.',
    CONSTRAINT pk_reagent_standard PRIMARY KEY(`reagent_standard_id`)
) COMMENT 'Master inventory record for laboratory reagents, chemical standards, and reference materials used in analytical testing. Captures reagent name, CAS number, supplier, lot number, concentration or purity, preparation date, expiry date, storage conditions, current stock quantity, reorder threshold, and associated test methods. Tracks the traceability of standards used in calibration and QC to ensure analytical data defensibility. Distinct from the supply domain which manages procurement; this entity owns the in-lab inventory and traceability record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` (
    `analyte_id` BIGINT COMMENT 'Unique identifier for the analyte parameter. Primary key for the analyte reference catalog. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory parameter registry management requires employee accountability. Analyte setup affects compliance reporting and must be traceable to qualified employees for data quality assurance and regula. Ref: LabWare LIMS.',
    `action_level_value` DECIMAL(18,2) COMMENT 'The concentration of a contaminant which, if exceeded, triggers treatment or other requirements. Primarily used for lead and copper under the Lead and Copper Rule Revisions (LCRR).',
    `analyte_group` STRING COMMENT 'High-level classification of the analyte by its chemical or biological nature (inorganic, organic, microbiological, radiological, physical, emerging contaminant). Ref: LabWare LIMS.. Valid values are `inorganic|organic|microbiological|radiological|physical|emerging_contaminant`',
    `analyte_status` STRING COMMENT 'Current status of the analyte in the laboratory catalog (active, inactive, retired, pending approval, under review). Ref: LabWare LIMS.. Valid values are `active|inactive|retired|pending_approval|under_review`',
    `astm_method_code` STRING COMMENT 'The ASTM International standard method code(s) for measuring this analyte, if applicable. Multiple methods may be comma-separated. Ref: LabWare LIMS.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to chemical substances. Used for unambiguous identification of chemical analytes. Ref: LabWare LIMS.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `analyte_category` STRING COMMENT 'Detailed sub-classification within the analyte group (e.g., heavy metals, volatile organic compounds, disinfection byproducts, indicator organisms). Ref: LabWare LIMS.',
    `certified_analyst_required_flag` BOOLEAN COMMENT 'Indicates whether analysis of this analyte must be performed by a state-certified or specially trained analyst. Ref: LabWare LIMS.',
    `analyte_code` STRING COMMENT 'Short alphanumeric code used to identify the analyte in laboratory systems and reports. Often corresponds to LIMS internal codes or regulatory parameter codes. Ref: LabWare LIMS.',
    `container_type` STRING COMMENT 'Required container material and type for sample collection (e.g., plastic bottle, glass bottle amber, sterile bag, VOA vial). Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this analyte record was first created in the system. Ref: LabWare LIMS.',
    `default_reporting_unit` STRING COMMENT 'Standard unit of measure for reporting results for this analyte (e.g., mg/L, µg/L, CFU/100mL, NTU, pH units, pCi/L). Ref: LabWare LIMS.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of the analyte that can be measured and reported with 99% confidence that the analyte concentration is greater than zero, expressed in the default reporting unit. Ref: LabWare LIMS.',
    `effective_date` DATE COMMENT 'Date when this analyte definition became effective in the laboratory catalog or when regulatory requirements took effect. Ref: LabWare LIMS.',
    `epa_method_code` STRING COMMENT 'The EPA-approved analytical method code(s) for measuring this analyte (e.g., EPA 200.8, EPA 300.0, EPA 1103.1). Multiple methods may be comma-separated. Ref: LabWare LIMS.',
    `health_effect` STRING COMMENT 'Summary of known or potential health effects associated with exposure to this analyte at elevated concentrations (e.g., gastrointestinal illness, neurological effects, increased cancer risk). Ref: LabWare LIMS.',
    `holding_time_hours` STRING COMMENT 'Maximum time allowed between sample collection and analysis, expressed in hours, to ensure result validity and regulatory compliance. Ref: LabWare LIMS.',
    `lims_integration_code` STRING COMMENT 'The analyte identifier or code used in the LIMS (LabWare or similar) for system integration and data exchange. Ref: LabWare LIMS.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The enforceable regulatory limit for this analyte in drinking water, expressed in the default reporting unit. Null if no MCL is established. Ref: LabWare LIMS.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The non-enforceable health goal for this analyte in drinking water, expressed in the default reporting unit. Null if no MCLG is established. Ref: LabWare LIMS.',
    `minimum_sample_volume_ml` STRING COMMENT 'Minimum volume of sample required for analysis of this analyte, expressed in milliliters. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this analyte record. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this analyte record was last modified. Ref: LabWare LIMS.',
    `monitoring_location_type` STRING COMMENT 'Types of monitoring locations where this analyte is typically measured (e.g., entry point to distribution system, distribution system, source water, treatment plant effluent, NPDES outfall). Ref: LabWare LIMS.',
    `analyte_name` STRING COMMENT 'Full descriptive name of the chemical, biological, or physical parameter being measured (e.g., Total Coliform, Lead, pH, Turbidity). Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or comments regarding this analyte, including method-specific considerations, interferences, or regulatory updates. Ref: LabWare LIMS.',
    `preservation_method` STRING COMMENT 'Required preservation technique for samples collected for this analyte (e.g., acidify to pH<2 with HNO3, cool to 4°C, add sodium thiosulfate, no preservation required). Ref: LabWare LIMS.',
    `proficiency_testing_required_flag` BOOLEAN COMMENT 'Indicates whether the laboratory must participate in proficiency testing programs for this analyte to maintain accreditation and regulatory compliance. Ref: LabWare LIMS.',
    `qaqc_requirement` STRING COMMENT 'Specific QA/QC protocols required for this analyte (e.g., matrix spike/matrix spike duplicate, laboratory control sample, method blank, field duplicate, proficiency testing frequency). Ref: LabWare LIMS.',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'The minimum concentration at which the analyte can be reliably quantified with acceptable precision and accuracy, expressed in the default reporting unit. Typically higher than the detection limit. Ref: LabWare LIMS.',
    `regulatory_classification` STRING COMMENT 'Classification of the analyte based on regulatory requirements: primary MCL (Maximum Contaminant Level), secondary MCL, NPDES (National Pollutant Discharge Elimination System) parameter, PFAS (Per- and Polyfluoroalkyl Substances), DBP (Disinfection Byproduct), DBP precursor, unregulated, or action level. [ENUM-REF-CANDIDATE: primary_mcl|secondary_mcl|npdes_parameter|pfas|dbp|dbp_precursor|unregulated|action_level — 8 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `reporting_frequency` STRING COMMENT 'Required frequency for reporting results for this analyte to regulatory agencies (daily, weekly, monthly, quarterly, annually, as required, continuous). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|as_required|continuous — 7 candidates stripped; promote to reference product]. Ref: LabWare LIMS.',
    `retirement_date` DATE COMMENT 'Date when this analyte was retired from the laboratory catalog or when regulatory requirements were superseded. Null if still active. Ref: LabWare LIMS.',
    `sample_matrix_applicability` STRING COMMENT 'The types of sample matrices for which this analyte is applicable (e.g., drinking water, wastewater, surface water, groundwater, biosolids, sludge). Multiple matrices may be comma-separated. Ref: LabWare LIMS.',
    `seasonal_monitoring_flag` BOOLEAN COMMENT 'Indicates whether monitoring for this analyte is required only during specific seasons or months (e.g., DBP monitoring during warmer months). Ref: LabWare LIMS.',
    `source_of_contamination` STRING COMMENT 'Common sources or pathways by which this analyte enters water systems (e.g., naturally occurring, industrial discharge, agricultural runoff, corrosion of household plumbing, disinfection byproduct). Ref: LabWare LIMS.',
    `standard_method_code` STRING COMMENT 'The Standard Methods for the Examination of Water and Wastewater method code(s) for measuring this analyte (e.g., SM 2320 B, SM 4500-Cl G). Multiple methods may be comma-separated. Ref: LabWare LIMS.',
    `treatment_technology` STRING COMMENT 'Recommended or required treatment technologies for removing or reducing this analyte (e.g., coagulation/filtration, activated carbon, reverse osmosis, ion exchange, UV disinfection, chlorination). Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each analyte in the laboratory domain.',
    CONSTRAINT pk_analyte PRIMARY KEY(`analyte_id`)
) COMMENT 'Reference catalog of all chemical, biological, and physical parameters that the laboratory is capable of or required to measure. Captures analyte name, CAS number, analyte group (inorganic, organic, microbiological, radiological, physical), regulatory classification (primary MCL, secondary MCL, NPDES parameter, PFAS, DBP precursor), default reporting unit, and associated EPA or Standard Methods method codes. Serves as the authoritative analyte dictionary linking laboratory results to regulatory parameters across the quality and compliance domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` (
    `laboratory_corrective_action_id` BIGINT COMMENT 'Unique identifier for the laboratory_corrective_action data product (auto-inserted pre-linking). Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Analyte affected. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Analyst responsible for action. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Responsible analyst. Ref: LabWare LIMS.',
    `lab_accreditation_id` BIGINT COMMENT 'FK to laboratory.lab_accreditation. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Unique identifier for the lab instrument referenced by each laboratory corrective action record in the laboratory domain.',
    `lab_sample_id` BIGINT COMMENT 'lab sample id for laboratory_corrective_action. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Test method affected. Ref: LabWare LIMS.',
    `laboratory_assigned_employee_id` BIGINT COMMENT 'Employee responsible for implementing the action. Ref: LabWare LIMS.',
    `laboratory_assigned_to_employee_id` BIGINT COMMENT 'FK to workforce.employee (assigned to). Ref: LabWare LIMS.',
    `laboratory_certified_analyst_id` BIGINT COMMENT 'Foreign key linking to laboratory.certified_analyst. Business justification: Corrective actions are assigned to specific analysts for investigation and resolution. This N:1 relationship (many corrective actions per analyst) tracks responsibility and workload. The FK column use. Ref: LabWare LIMS.',
    `laboratory_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the laboratory created by employee referenced by each laboratory corrective action record in the laboratory domain.',
    `laboratory_id` BIGINT COMMENT 'Laboratory where the corrective action was implemented. Ref: LabWare LIMS.',
    `laboratory_initiated_by_employee_id` BIGINT COMMENT 'FK to workforce.employee (initiated by). Ref: LabWare LIMS.',
    `laboratory_instrument_calibration_id` BIGINT COMMENT 'laboratory instrument calibration id for laboratory_corrective_action. Ref: LabWare LIMS.',
    `laboratory_responsible_employee_id` BIGINT COMMENT 'Employee responsible for implementing the corrective action. Ref: LabWare LIMS.',
    `laboratory_test_method_id` BIGINT COMMENT 'Unique identifier for the laboratory test method referenced by each laboratory corrective action record in the laboratory domain.',
    `laboratory_verified_by_analyst_id` BIGINT COMMENT 'Analyst who verified completion. Ref: LabWare LIMS.',
    `laboratory_verified_by_employee_id` BIGINT COMMENT 'FK to workforce.employee (verified by). Ref: LabWare LIMS.',
    `proficiency_test_id` BIGINT COMMENT 'Foreign key linking to laboratory.proficiency_test. Business justification: Corrective actions are triggered by proficiency test failures (z-score out of range, unacceptable performance). This N:1 relationship (many corrective actions per PT failure) links the corrective acti. Ref: LabWare LIMS.',
    `qc_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.qc_batch. Business justification: Corrective actions are often triggered by QC batch failures (method blank contamination, LCS recovery out of range, etc.). This N:1 relationship (many corrective actions per failed batch) links the co. Ref: LabWare LIMS.',
    `test_result_id` BIGINT COMMENT 'test result id for laboratory_corrective_action. Ref: LabWare LIMS.',
    `canonical_quality_corrective_action_id` BIGINT COMMENT 'Canonical reference to laboratory.quality_corrective_action. Ref: LabWare LIMS.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Reference to primary compliance.compliance_corrective_action for SSOT alignment. Ref: LabWare LIMS.',
    `accreditation_body_notified` BOOLEAN COMMENT 'Whether accreditation body was notified. Ref: LabWare LIMS.',
    `accreditation_impact` BOOLEAN COMMENT 'Whether this action has accreditation implications. Ref: LabWare LIMS.',
    `action_date` TIMESTAMP COMMENT 'The action date associated with each laboratory corrective action record in the laboratory domain.',
    `action_description` STRING COMMENT 'The action description value recorded for each laboratory corrective action in the laboratory domain.',
    `action_number` STRING COMMENT 'Unique corrective action number. Ref: LabWare LIMS.',
    `action_status` STRING COMMENT 'Status (open, in_progress, completed, verified, closed). Ref: LabWare LIMS.',
    `action_type` STRING COMMENT 'Type (immediate, corrective, preventive, CAPA). Ref: LabWare LIMS.',
    `actual_completion_date` TIMESTAMP COMMENT 'The actual completion date associated with each laboratory corrective action record in the laboratory domain.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost incurred. Ref: LabWare LIMS.',
    `affected_results_count` STRING COMMENT 'Number of analytical results potentially affected. Ref: LabWare LIMS.',
    `affected_sample_count` STRING COMMENT 'Number of samples affected by the issue requiring corrective action. Ref: LabWare LIMS.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each laboratory corrective action in the laboratory domain.',
    `assigned_date` TIMESTAMP COMMENT 'Date action was assigned. Ref: LabWare LIMS.',
    `laboratory_corrective_action_category` STRING COMMENT 'The laboratory corrective action category value recorded for each laboratory corrective action in the laboratory domain.',
    `classification` STRING COMMENT 'The classification value recorded for each laboratory corrective action in the laboratory domain.',
    `client_notification_required` STRING COMMENT 'Whether client notification is required. Ref: LabWare LIMS.',
    `laboratory_corrective_action_code` STRING COMMENT 'code for laboratory_corrective_action. Ref: LabWare LIMS.',
    `comments` STRING COMMENT 'Additional comments or notes. Ref: LabWare LIMS.',
    `completed_date` TIMESTAMP COMMENT 'The completed date associated with each laboratory corrective action record in the laboratory domain.',
    `completed_flag` BOOLEAN COMMENT 'The completed flag value recorded for each laboratory corrective action in the laboratory domain.',
    `completion_date` DATE COMMENT 'Actual completion date. Ref: LabWare LIMS.',
    `completion_status` STRING COMMENT 'Completion status. Ref: LabWare LIMS.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each laboratory corrective action in the laboratory domain.',
    `corrective_action_number` STRING COMMENT 'External corrective action reference number. Ref: LabWare LIMS.',
    `corrective_action_status` STRING COMMENT 'Status: Open, In Progress, Completed, Verified, Closed. Ref: LabWare LIMS.',
    `corrective_action_type` STRING COMMENT 'Type: Instrument Failure, Reagent Issue, Analyst Error, QC Failure, Contamination. Ref: LabWare LIMS.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'cost estimate for laboratory_corrective_action. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: LabWare LIMS.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each laboratory corrective action in the laboratory domain.',
    `deprecated_flag` BOOLEAN COMMENT 'deprecated flag for laboratory_corrective_action. Ref: LabWare LIMS.',
    `laboratory_corrective_action_description` STRING COMMENT 'Description of the corrective action. Ref: LabWare LIMS.',
    `due_date` TIMESTAMP COMMENT 'The due date associated with each laboratory corrective action record in the laboratory domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each laboratory corrective action record in the laboratory domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: LabWare LIMS.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: LabWare LIMS.',
    `effectiveness_check_date` TIMESTAMP COMMENT 'Date effectiveness check is due. Ref: LabWare LIMS.',
    `effectiveness_confirmed` BOOLEAN COMMENT 'The effectiveness confirmed value recorded for each laboratory corrective action in the laboratory domain.',
    `effectiveness_evaluation` STRING COMMENT 'Summary of effectiveness evaluation. Ref: LabWare LIMS.',
    `effectiveness_status` STRING COMMENT 'effectiveness status for laboratory_corrective_action. Ref: LabWare LIMS.',
    `effectiveness_verified` STRING COMMENT 'Whether effectiveness was verified. Ref: LabWare LIMS.',
    `effectiveness_verified_flag` BOOLEAN COMMENT 'The effectiveness verified flag value recorded for each laboratory corrective action in the laboratory domain.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each laboratory corrective action record in the laboratory domain.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost of corrective action. Ref: LabWare LIMS.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each laboratory corrective action record in the laboratory domain.',
    `identified_date` DATE COMMENT 'Date nonconformance was identified. Ref: LabWare LIMS.',
    `impact_assessment` STRING COMMENT 'Assessment of impact on reported results. Ref: LabWare LIMS.',
    `impact_on_results` STRING COMMENT 'Assessment of impact on previously reported results. Ref: LabWare LIMS.',
    `initiated_date` TIMESTAMP COMMENT 'The initiated date associated with each laboratory corrective action record in the laboratory domain.',
    `is_accreditation_impact` BOOLEAN COMMENT 'Whether this issue impacts lab accreditation. Ref: LabWare LIMS.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: LabWare LIMS.',
    `is_effective` BOOLEAN COMMENT 'Boolean flag indicating whether the is effective condition applies to the laboratory corrective action record.',
    `is_recurring` BOOLEAN COMMENT 'Whether this is a recurring issue. Ref: LabWare LIMS.',
    `laboratory_canonical_compliance_corrective_action_id` BIGINT COMMENT 'Reference FK to canonical SSOT compliance.compliance_corrective_action. Ref: LabWare LIMS.',
    `laboratory_compliance_corrective_action_id` BIGINT COMMENT 'Foreign key to SSOT entity compliance.compliance_corrective_action. Ref: LabWare LIMS.',
    `laboratory_corrective_action_number` STRING COMMENT 'The laboratory corrective action number value recorded for each laboratory corrective action in the laboratory domain.',
    `laboratory_corrective_action_type` STRING COMMENT 'The laboratory corrective action type value recorded for each laboratory corrective action in the laboratory domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last modification timestamp. Ref: LabWare LIMS.',
    `laboratory_corrective_action_name` STRING COMMENT 'name for laboratory_corrective_action. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text notes. Ref: LabWare LIMS.',
    `notification_date` TIMESTAMP COMMENT 'Date client was notified. Ref: LabWare LIMS.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each laboratory corrective action in the laboratory domain.',
    `preventive_action_description` STRING COMMENT 'Description of preventive actions to avoid recurrence. Ref: LabWare LIMS.',
    `preventive_measure` STRING COMMENT 'Preventive measures to avoid recurrence. Ref: LabWare LIMS.',
    `priority` STRING COMMENT 'Critical, High, Medium, Low. Ref: LabWare LIMS.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each laboratory corrective action in the laboratory domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each laboratory corrective action in the laboratory domain.',
    `reanalysis_required` STRING COMMENT 'Whether reanalysis is required. Ref: LabWare LIMS.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: LabWare LIMS.',
    `record_status` STRING COMMENT 'The record status value recorded for each laboratory corrective action in the laboratory domain.',
    `recurrence_prevention_description` STRING COMMENT 'Description of measures to prevent recurrence. Ref: LabWare LIMS.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each laboratory corrective action in the laboratory domain.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Whether regulatory notification is required. Ref: LabWare LIMS.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each laboratory corrective action in the laboratory domain.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'regulatory reporting required for laboratory_corrective_action. Ref: LabWare LIMS.',
    `required_completion_date` TIMESTAMP COMMENT 'Required completion date. Ref: LabWare LIMS.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each laboratory corrective action record in the laboratory domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each laboratory corrective action in the laboratory domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each laboratory corrective action in the laboratory domain.',
    `root_cause` STRING COMMENT 'The root cause value recorded for each laboratory corrective action in the laboratory domain.',
    `root_cause_analysis` STRING COMMENT 'Root cause analysis findings. Ref: LabWare LIMS.',
    `root_cause_category` STRING COMMENT 'Category (instrument, reagent, analyst, method, environmental). Ref: LabWare LIMS.',
    `root_cause_description` STRING COMMENT 'Description of root cause identified. Ref: LabWare LIMS.',
    `samples_affected_count` STRING COMMENT 'Number of samples potentially affected. Ref: LabWare LIMS.',
    `ssot_entity_type` STRING COMMENT 'The ssot entity type value recorded for each laboratory corrective action in the laboratory domain.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each laboratory corrective action in the laboratory domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each laboratory corrective action record in the laboratory domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each laboratory corrective action record in the laboratory domain.',
    `laboratory_corrective_action_status` STRING COMMENT 'Lifecycle status of the record. Ref: LabWare LIMS.',
    `target_completion_date` TIMESTAMP COMMENT 'The target completion date associated with each laboratory corrective action record in the laboratory domain.',
    `target_date` DATE COMMENT 'Target completion date. Ref: LabWare LIMS.',
    `trigger_event` STRING COMMENT 'trigger event for laboratory_corrective_action. Ref: LabWare LIMS.',
    `trigger_source` STRING COMMENT 'Source (QC_failure, PT_failure, audit_finding, complaint, nonconformance). Ref: LabWare LIMS.',
    `trigger_type` STRING COMMENT 'Calibration failure, QC failure, PT failure, audit finding, customer complaint. Ref: LabWare LIMS.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each laboratory corrective action in the laboratory domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each laboratory corrective action record in the laboratory domain.',
    `verification_date` DATE COMMENT 'Date effectiveness was verified. Ref: LabWare LIMS.',
    `verification_method` STRING COMMENT 'The verification method value recorded for each laboratory corrective action in the laboratory domain.',
    `verified_date` TIMESTAMP COMMENT 'Date corrective action effectiveness was verified. Ref: LabWare LIMS.',
    `verified_flag` BOOLEAN COMMENT 'verified flag for laboratory_corrective_action. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each laboratory corrective action in the laboratory domain.',
    CONSTRAINT pk_laboratory_corrective_action PRIMARY KEY(`laboratory_corrective_action_id`)
) COMMENT 'Record of corrective actions initiated in response to laboratory QC failures, accreditation deficiencies, proficiency test failures, or data quality issues. Captures the triggering event (QC batch failure, PT failure, customer complaint, internal audit finding), root cause analysis, corrective action description, responsible analyst or supervisor, target completion date, actual completion date, and effectiveness verification. Required for NELAC/TNI accreditation maintenance and continuous quality improvement. [SSOT: reference view of canonical compliance.compliance_corrective_action] Consolidated: compliance.compliance_corrective_action is SSOT; this table references it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` (
    `method_detection_limit_id` BIGINT COMMENT 'Unique identifier for the method detection limit study record. Primary key. Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Reference to the specific analyte (contaminant or parameter) for which the MDL study was performed. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Reference to the certified analyst who performed the MDL study. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Reference to the laboratory instrument used to perform the MDL study. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance reviewer who validated the MDL study calculations and acceptance criteria. Ref: LabWare LIMS.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the quality assurance reviewer who validated the MDL study calculations and acceptance criteria. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Reference to the analytical test method used in the MDL study. Ref: LabWare LIMS.',
    `acceptance_criteria_met_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the MDL study met all acceptance criteria (recovery range, RSD limits, replicate count). Ref: LabWare LIMS.',
    `accreditation_field` STRING COMMENT 'Accreditation field of testing code or identifier that this MDL study supports. Ref: LabWare LIMS.',
    `analyst_certification_number` STRING COMMENT 'Certification number of the analyst who performed the MDL study, issued by the accrediting body. Ref: LabWare LIMS.',
    `analyst_name` STRING COMMENT 'Full name of the certified analyst who performed the MDL study. Ref: LabWare LIMS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the MDL study was formally approved for use in laboratory reporting. Ref: LabWare LIMS.',
    `approved_by` STRING COMMENT 'Name or identifier of the laboratory manager or quality officer who approved the MDL study. Ref: LabWare LIMS.',
    `calculated_mdl` DECIMAL(18,2) COMMENT 'Calculated Method Detection Limit value, determined as the standard deviation of replicate measurements multiplied by the Students t-value at 99% confidence level. Ref: LabWare LIMS.',
    `calculated_mrl` DECIMAL(18,2) COMMENT 'Calculated Minimum Reporting Level (also known as Practical Quantitation Limit or PQL), typically set at 3-10 times the MDL to ensure reliable quantitation. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the MDL study record was first created in the system. Ref: LabWare LIMS.',
    `effective_end_date` DATE COMMENT 'Date on which the calculated MDL and MRL values expire and a new study is required. Typically one year from the study date or when method or instrument conditions change. Ref: LabWare LIMS.',
    `effective_start_date` DATE COMMENT 'Date from which the calculated MDL and MRL values become effective for use in laboratory reporting. Ref: LabWare LIMS.',
    `lims_integration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the MDL values have been integrated into the LIMS for automated reporting limit enforcement. Ref: LabWare LIMS.',
    `lims_mdl_code` STRING COMMENT 'Unique identifier for the corresponding MDL record in the Laboratory Information Management System (LabWare). Ref: LabWare LIMS.',
    `mdl_unit` STRING COMMENT 'Unit of measure for the calculated MDL and MRL values. Ref: LabWare LIMS.. Valid values are `mg/L|ug/L|ng/L|ppm|ppb|ppt`',
    `mean_recovery` DECIMAL(18,2) COMMENT 'Mean recovery percentage of the spiked analyte across all replicates, used to assess method accuracy. Ref: LabWare LIMS.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the MDL study record. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the MDL study record was last modified. Ref: LabWare LIMS.',
    `next_study_due_date` DATE COMMENT 'Date by which the next MDL study must be conducted to maintain regulatory compliance. Ref: LabWare LIMS.',
    `previous_mdl_value` DECIMAL(18,2) COMMENT 'Previously established MDL value for comparison and trend analysis.',
    `previous_mrl_value` DECIMAL(18,2) COMMENT 'Previously established MRL value for comparison and trend analysis.',
    `regulatory_acceptance_status` STRING COMMENT 'Regulatory acceptance status of the MDL study, indicating whether it meets EPA or state primacy agency requirements. Ref: LabWare LIMS.. Valid values are `accepted|rejected|pending_review`',
    `regulatory_program` STRING COMMENT 'Regulatory program under which the MDL study is required (e.g., Safe Drinking Water Act, Clean Water Act, NPDES). Ref: LabWare LIMS.. Valid values are `SDWA|CWA|NPDES|state_primacy`',
    `relative_standard_deviation_percent` DECIMAL(18,2) COMMENT 'Relative standard deviation (coefficient of variation) expressed as a percentage, used to assess method precision. Ref: LabWare LIMS.',
    `replicate_count` STRING COMMENT 'Number of replicate samples analyzed in the MDL study. EPA requires a minimum of 7 replicates. Ref: LabWare LIMS.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the MDL study was reviewed and validated by the quality assurance reviewer. Ref: LabWare LIMS.',
    `reviewer_name` STRING COMMENT 'Full name of the quality assurance reviewer who validated the MDL study. Ref: LabWare LIMS.',
    `sample_matrix` STRING COMMENT 'Type of sample matrix used in the MDL study (e.g., drinking water, wastewater, surface water). Ref: LabWare LIMS.. Valid values are `drinking_water|wastewater|surface_water|groundwater|biosolids|sludge`',
    `spike_concentration` DECIMAL(18,2) COMMENT 'Concentration at which the sample matrix was spiked for the MDL study, typically 1-5 times the estimated detection limit. Ref: LabWare LIMS.',
    `spike_concentration_unit` STRING COMMENT 'Unit of measure for the spike concentration (e.g., mg/L, ug/L, ng/L). Ref: LabWare LIMS.. Valid values are `mg/L|ug/L|ng/L|ppm|ppb|ppt`',
    `standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of the replicate measurements used in the MDL calculation. Ref: LabWare LIMS.',
    `study_date` DATE COMMENT 'Date on which the method detection limit study was conducted. Ref: LabWare LIMS.',
    `study_notes` STRING COMMENT 'Free-text notes documenting any special conditions, deviations, or observations during the MDL study. Ref: LabWare LIMS.',
    `study_reason` STRING COMMENT 'Reason for conducting the MDL study (e.g., annual renewal, method change, instrument change, matrix change). Ref: LabWare LIMS.. Valid values are `annual_renewal|method_change|instrument_change|matrix_change|regulatory_requirement|quality_issue`',
    `study_status` STRING COMMENT 'Current status of the MDL study in the approval workflow. Ref: LabWare LIMS.. Valid values are `draft|in_review|approved|rejected|expired`',
    `t_value` DECIMAL(18,2) COMMENT 'Students t-value at 99% confidence level for the number of replicates used in the MDL calculation. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each method detection limit in the laboratory domain.',
    `created_by` STRING COMMENT 'User identifier of the person who created the MDL study record. Ref: LabWare LIMS.',
    CONSTRAINT pk_method_detection_limit PRIMARY KEY(`method_detection_limit_id`)
) COMMENT 'Record of Method Detection Limit (MDL) and Minimum Reporting Level (MRL) determinations performed for each analyte-method-instrument combination in the laboratory. Captures the study date, number of replicates, spike concentration, calculated MDL, calculated MRL/PQL, analyst, instrument used, and regulatory acceptance status. MDL studies must be conducted annually or when method or instrument conditions change, per EPA MDL procedure (40 CFR Part 136 Appendix B).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` (
    `lab_work_order_id` BIGINT COMMENT 'Unique identifier for the laboratory work order. Primary key for the work order entity. Ref: IBM Maximo.',
    `certified_analyst_id` BIGINT COMMENT 'Identifier of the primary certified analyst assigned to perform or oversee the analytical work for this work order. Ref: IBM Maximo.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Lab work orders are issued for project-specific testing campaigns (construction water quality monitoring, commissioning testing, post-construction verification). Required for project cost allocation a. Ref: IBM Maximo.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders represent service requests from specific departments; all associated costs must be charged to the requesting departments cost center for internal cost recovery and budget variance analysi. Ref: IBM Maximo.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer-requested testing services (private well analysis, voluntary lead testing, complaint investigations) require work order linkage to customer account for billing, result delivery, appointment s. Ref: IBM Maximo.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: When external lab services are procured, the work order references the PO for cost tracking, budget management, and three-way match (PO-GR-Invoice). Essential for financial reconciliation and vendor p. Ref: IBM Maximo.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Lab work orders are often generated from scheduled sampling plans. The work order has regulatory_program and permit_number attributes that align with sampling plan drivers. This FK allows tracing work. Ref: IBM Maximo.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Lab work orders are organized by facility for routine compliance monitoring, operational troubleshooting, and process optimization. Linking work orders to facilities enables cost allocation, workload. Ref: IBM Maximo.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all analyses were completed, validated, and results released. Used to measure TAT performance and identify bottlenecks. Ref: IBM Maximo.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost in US dollars incurred for completing the work order, including labor, reagents, instrument time, and overhead allocation. Ref: IBM Maximo.',
    `analysis_count` STRING COMMENT 'Total number of individual analytical tests requested across all samples in the work order. A single sample may require multiple analyses. Ref: IBM Maximo.',
    `assigned_analyst_name` STRING COMMENT 'Name of the primary analyst assigned to the work order. Used for accountability and quality assurance tracking. Ref: IBM Maximo.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this work order is billable to an external client or internal cost recovery. True for external client work and some internal service agreements. Ref: IBM Maximo.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether the work order requires analysis by a state-certified analyst. True for regulatory compliance samples that must be legally defensible. Ref: IBM Maximo.',
    `compliance_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this work order is part of regulatory compliance monitoring. True for samples required by permits, regulations, or consent decrees. Ref: IBM Maximo.',
    `cost_center` STRING COMMENT 'Financial cost center to which laboratory charges for this work order will be allocated. Supports internal chargeback and budget tracking. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the LIMS. Used for audit trail and workflow tracking. Ref: IBM Maximo.',
    `data_release_timestamp` TIMESTAMP COMMENT 'Date and time when validated analytical results were officially released to the requestor. Marks the end of the laboratory workflow. Ref: IBM Maximo.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in US dollars for completing all analyses in the work order, based on standard labor and material rates. Ref: IBM Maximo.',
    `holding_time_compliant_flag` BOOLEAN COMMENT 'Indicates whether all analyses in the work order were completed within the required holding time. False triggers data qualification and potential regulatory reporting. Ref: IBM Maximo.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis completion, as specified by analytical method or regulation. Critical for regulatory defensibility. Ref: IBM Maximo.',
    `invoice_date` DATE COMMENT 'Date when the invoice was generated for the completed work order. Used for revenue recognition and accounts receivable aging. Ref: IBM Maximo.',
    `invoice_number` STRING COMMENT 'Invoice number generated for billable work orders. Links laboratory work to accounts receivable and revenue recognition. Ref: IBM Maximo.',
    `lims_batch_code` STRING COMMENT 'Batch identifier in LabWare LIMS grouping samples analyzed together under the same QC protocol and instrument calibration.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the work order record. Supports change tracking and audit trail requirements. Ref: IBM Maximo.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last modified. Tracks changes to status, assignments, or other work order attributes. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, deviations, or observations related to the work order. Ref: IBM Maximo.',
    `permit_number` STRING COMMENT 'Regulatory permit or authorization number associated with the work order, such as NPDES permit for wastewater discharge monitoring or public water system ID. Ref: IBM Maximo.',
    `priority_level` STRING COMMENT 'Priority classification determining the urgency and sequence of analytical work. Emergency priority typically reserved for regulatory exceedances or operational incidents. Ref: IBM Maximo.. Valid values are `routine|standard|high|urgent|emergency`',
    `qaqc_protocol` STRING COMMENT 'Name or identifier of the QA/QC protocol to be applied, including requirements for blanks, duplicates, spikes, and control standards. Ref: IBM Maximo.',
    `regulatory_program` STRING COMMENT 'Name of the regulatory program driving the analytical requirements, such as SDWA compliance monitoring, NPDES permit, LCRR, or state-specific programs.',
    `requested_analyte_list` STRING COMMENT 'Comma-separated list of analytes or parameters to be tested, such as pH, turbidity, total coliform, lead, copper, BOD, TSS, PFAS, or specific contaminants. Ref: IBM Maximo.',
    `requested_test_method_list` STRING COMMENT 'Comma-separated list of analytical test methods to be used, such as EPA 200.8, SM 2540C, EPA 1664A. Methods must be approved for regulatory defensibility. Ref: IBM Maximo.',
    `requesting_entity` STRING COMMENT 'Name of the department, facility, or external client that submitted the work order. May include treatment operations, compliance team, WTP, WWTP, or external industrial clients. Ref: IBM Maximo.',
    `requesting_entity_type` STRING COMMENT 'Classification of the requesting entity to support workflow routing, billing, and reporting requirements. Ref: IBM Maximo.. Valid values are `internal_operations|compliance_team|external_client|regulatory_agency|research_partner`',
    `requestor_contact_email` STRING COMMENT 'Email address of the requestor for result delivery, status updates, and work order correspondence. Ref: IBM Maximo.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_contact_phone` STRING COMMENT 'Phone number of the requestor for urgent communication regarding sample issues, result clarification, or turnaround time adjustments. Ref: IBM Maximo.',
    `requestor_name` STRING COMMENT 'Name of the individual who submitted the work order. Used for clarification and communication during analysis. Ref: IBM Maximo.',
    `required_turnaround_time_hours` STRING COMMENT 'Number of hours within which analytical results must be delivered. Driven by regulatory requirements, operational needs, or client service level agreements. Ref: IBM Maximo.',
    `sample_count` STRING COMMENT 'Total number of samples included in this work order. Used for workload planning and resource allocation. Ref: IBM Maximo.',
    `scheduled_completion_date` DATE COMMENT 'Target date by which all analyses in the work order should be completed and results validated. Calculated from submission timestamp and required TAT. Ref: IBM Maximo.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was submitted to the laboratory. Used to calculate turnaround time and holding time compliance. Ref: IBM Maximo.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each lab work order in the laboratory domain.',
    `work_order_number` STRING COMMENT 'Business identifier for the work order, typically generated by LabWare LIMS. Used for external communication and tracking.',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the laboratory workflow. Tracks progression from receipt through completion and invoicing. Ref: IBM Maximo.. Valid values are `received|in_progress|pending_review|completed|invoiced|cancelled`',
    `work_order_type` STRING COMMENT 'Classification of the work order based on its purpose and origin. Determines workflow routing and priority handling. Ref: IBM Maximo.. Valid values are `compliance|operational|research|external_client|emergency|routine`',
    `created_by` STRING COMMENT 'User ID or name of the person who created the work order record in the LIMS. Supports accountability and audit requirements. Ref: IBM Maximo.',
    CONSTRAINT pk_lab_work_order PRIMARY KEY(`lab_work_order_id`)
) COMMENT 'Operational work order record that organizes and tracks the analytical workload assigned to the laboratory for a given submission or sampling event. Captures work order number, requesting entity (treatment operations, compliance team, distribution crew, external client), priority level, required turnaround time (TAT), list of requested analyses, assigned analyst(s), scheduled completion date, receipt condition of samples (temperature, seal integrity, discrepancies), and current status (received, in-progress, pending review, completed, reported). Serves as the primary workflow management entity in LabWare LIMS and the official laboratory receipt record for incoming sample submissions.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` (
    `certificate_of_analysis_id` BIGINT COMMENT 'Unique identifier for the certificate_of_analysis data product (auto-inserted pre-linking). Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Employee who approved the certificate. Ref: LabWare LIMS.',
    `certificate_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the certificate created by employee referenced by each certificate of analysis record in the laboratory domain.',
    `certificate_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the certificate responsible employee referenced by each certificate of analysis record in the laboratory domain.',
    `certificate_reviewed_by_employee_id` BIGINT COMMENT 'Unique identifier for the certificate reviewed by employee referenced by each certificate of analysis record in the laboratory domain.',
    `certified_analyst_id` BIGINT COMMENT 'Foreign key linking to laboratory.certified_analyst. Business justification: COAs require formal approval and signature by a certified analyst with signatory authority before release to customers or regulatory agencies. This FK captures the approving analyst. Labeled FK (appro. Ref: LabWare LIMS.',
    `chain_of_custody_id` BIGINT COMMENT 'FK to laboratory.chain_of_custody. Ref: LabWare LIMS.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Certificates of analysis for customer-origin samples (lead testing, complaint investigations, fee-based services) must link to account for secure result delivery, regulatory notification compliance, r. Ref: LabWare LIMS.',
    `lab_accreditation_id` BIGINT COMMENT 'FK to laboratory.lab_accreditation. Ref: LabWare LIMS.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: A Certificate of Analysis (COA) is the formal report issued for a lab sample, documenting all test results and certifications. Every COA must reference the sample it reports on. This is a standard rep. Ref: LabWare LIMS.',
    `lab_work_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_work_order. Business justification: COAs are generated to fulfill lab work orders submitted by internal or external customers. This FK links the deliverable (COA) to the originating work request. This enables tracking of work order comp. Ref: LabWare LIMS.',
    `laboratory_id` BIGINT COMMENT 'FK to laboratory.laboratory. Ref: LabWare LIMS.',
    `qc_batch_id` BIGINT COMMENT 'Unique identifier for the qc batch referenced by each certificate of analysis record in the laboratory domain.',
    `revised_certificate_of_analysis_id` BIGINT COMMENT 'Self-referencing FK on certificate_of_analysis (revised_certificate_of_analysis_id). Ref: LabWare LIMS.',
    `sample_collection_event_id` BIGINT COMMENT 'FK to laboratory.sample_collection_event. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Unique identifier for the test method referenced by each certificate of analysis record in the laboratory domain.',
    `water_sample_id` BIGINT COMMENT 'water sample id for certificate_of_analysis. Ref: LabWare LIMS.',
    `document_id` BIGINT COMMENT 'Unique identifier for the document referenced by each certificate of analysis record in the laboratory domain.',
    `accreditation_number` STRING COMMENT 'accreditation number for certificate_of_analysis. Ref: LabWare LIMS.',
    `accreditation_reference` STRING COMMENT 'The accreditation reference value recorded for each certificate of analysis in the laboratory domain.',
    `all_qc_passed` STRING COMMENT 'Whether all QC criteria were met. Ref: LabWare LIMS.',
    `all_results_compliant` BOOLEAN COMMENT 'Whether all results are within limits. Ref: LabWare LIMS.',
    `all_results_within_limits` BOOLEAN COMMENT 'all results within limits for certificate_of_analysis. Ref: LabWare LIMS.',
    `amendment_reason` STRING COMMENT 'Reason for amendment if revised. Ref: LabWare LIMS.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each certificate of analysis in the laboratory domain.',
    `analysis_complete_date` TIMESTAMP COMMENT 'Date analysis was completed. Ref: LabWare LIMS.',
    `analysis_completed_date` TIMESTAMP COMMENT 'The analysis completed date associated with each certificate of analysis record in the laboratory domain.',
    `analysis_completion_date` TIMESTAMP COMMENT 'The analysis completion date associated with each certificate of analysis record in the laboratory domain.',
    `analysis_end_date` DATE COMMENT 'Date analysis was completed. Ref: LabWare LIMS.',
    `analysis_start_date` DATE COMMENT 'Date analysis began. Ref: LabWare LIMS.',
    `analysis_summary` STRING COMMENT 'The analysis summary value recorded for each certificate of analysis in the laboratory domain.',
    `analyst_signature` STRING COMMENT 'analyst signature for certificate_of_analysis. Ref: LabWare LIMS.',
    `analyte_count` STRING COMMENT 'The analyte count value recorded for each certificate of analysis in the laboratory domain.',
    `approval_date` DATE COMMENT 'Date of approval. Ref: LabWare LIMS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate was approved for release. Ref: LabWare LIMS.',
    `approved_by` STRING COMMENT 'The approved by value recorded for each certificate of analysis in the laboratory domain.',
    `approved_by_name` STRING COMMENT 'Name of the laboratory director or authorized signatory. Ref: LabWare LIMS.',
    `approved_flag` BOOLEAN COMMENT 'The approved flag value recorded for each certificate of analysis in the laboratory domain.',
    `approver_signature` STRING COMMENT 'approver signature for certificate_of_analysis. Ref: LabWare LIMS.',
    `certificate_of_analysis_category` STRING COMMENT 'The certificate of analysis category value recorded for each certificate of analysis in the laboratory domain.',
    `certificate_number` STRING COMMENT 'Unique certificate of analysis number. Ref: LabWare LIMS.',
    `certificate_of_analysis_number` STRING COMMENT 'The certificate of analysis number value recorded for each certificate of analysis in the laboratory domain.',
    `certificate_of_analysis_type` STRING COMMENT 'The certificate of analysis type value recorded for each certificate of analysis in the laboratory domain.',
    `certificate_status` STRING COMMENT 'Status (draft, reviewed, approved, issued, amended). Ref: LabWare LIMS.',
    `certificate_type` STRING COMMENT 'certificate type for certificate_of_analysis. Ref: LabWare LIMS.',
    `classification` STRING COMMENT 'The classification value recorded for each certificate of analysis in the laboratory domain.',
    `client_name` STRING COMMENT 'Client name on COA. Ref: LabWare LIMS.',
    `client_project_number` STRING COMMENT 'Client project number. Ref: LabWare LIMS.',
    `coa_number` STRING COMMENT 'External COA reference number. Ref: LabWare LIMS.',
    `coa_status` STRING COMMENT 'Draft, Issued, Revised, Superseded, Cancelled. Ref: LabWare LIMS.',
    `coa_version` STRING COMMENT 'Version number of COA. Ref: LabWare LIMS.',
    `certificate_of_analysis_code` STRING COMMENT 'code for certificate_of_analysis. Ref: LabWare LIMS.',
    `collection_date` TIMESTAMP COMMENT 'Date samples were collected. Ref: LabWare LIMS.',
    `collection_location` STRING COMMENT 'collection location for certificate_of_analysis. Ref: LabWare LIMS.',
    `comments` STRING COMMENT 'The comments value recorded for each certificate of analysis in the laboratory domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each certificate of analysis in the laboratory domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: LabWare LIMS.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each certificate of analysis in the laboratory domain.',
    `delivered_timestamp` TIMESTAMP COMMENT 'Timestamp when the COA was delivered to the client. Ref: LabWare LIMS.',
    `delivery_method` STRING COMMENT 'Method of COA delivery: Email, Portal, Mail, EDI. Ref: LabWare LIMS.',
    `certificate_of_analysis_description` STRING COMMENT 'The certificate of analysis description value recorded for each certificate of analysis in the laboratory domain.',
    `distribution_list` STRING COMMENT 'distribution list for certificate_of_analysis. Ref: LabWare LIMS.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each certificate of analysis record in the laboratory domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: LabWare LIMS.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: LabWare LIMS.',
    `electronic_signature` STRING COMMENT 'Electronic signature of certifying analyst. Ref: LabWare LIMS.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each certificate of analysis record in the laboratory domain.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date after which the certificate is no longer valid. Ref: LabWare LIMS.',
    `has_exceedances` BOOLEAN COMMENT 'Whether COA contains any exceedances. Ref: LabWare LIMS.',
    `has_qualifiers` BOOLEAN COMMENT 'Flag indicating one or more results carry data qualifiers. Ref: LabWare LIMS.',
    `is_accredited` BOOLEAN COMMENT 'is accredited for certificate_of_analysis. Ref: LabWare LIMS.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: LabWare LIMS.',
    `is_amended` BOOLEAN COMMENT 'is amended for certificate_of_analysis. Ref: LabWare LIMS.',
    `is_final` BOOLEAN COMMENT 'Boolean flag indicating whether the is final condition applies to the certificate of analysis record.',
    `is_revised` BOOLEAN COMMENT 'Flag indicating whether this certificate supersedes a prior version. Ref: LabWare LIMS.',
    `issue_date` DATE COMMENT 'Date certificate was issued. Ref: LabWare LIMS.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp COA was issued. Ref: LabWare LIMS.',
    `issued_date` TIMESTAMP COMMENT 'The issued date associated with each certificate of analysis record in the laboratory domain.',
    `laboratory_address` STRING COMMENT 'laboratory address for certificate_of_analysis. Ref: LabWare LIMS.',
    `modified_timestamp` TIMESTAMP COMMENT 'modified timestamp for certificate_of_analysis. Ref: LabWare LIMS.',
    `certificate_of_analysis_name` STRING COMMENT 'name for certificate_of_analysis. Ref: LabWare LIMS.',
    `narrative_comments` STRING COMMENT 'Narrative comments and qualifications. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text notes. Ref: LabWare LIMS.',
    `number_of_analytes` STRING COMMENT 'Number of analytes reported on the COA. Ref: LabWare LIMS.',
    `number_of_exceedances` STRING COMMENT 'Number of analytes exceeding limits on the COA. Ref: LabWare LIMS.',
    `overall_result_status` STRING COMMENT 'Aggregate pass/fail/conditional status of all tests on the certificate. Ref: LabWare LIMS.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each certificate of analysis in the laboratory domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each certificate of analysis in the laboratory domain.',
    `project_name` STRING COMMENT 'Project or study name. Ref: LabWare LIMS.',
    `qc_passed_flag` BOOLEAN COMMENT 'qc passed flag for certificate_of_analysis. Ref: LabWare LIMS.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each certificate of analysis in the laboratory domain.',
    `receipt_date` TIMESTAMP COMMENT 'Date samples were received at laboratory. Ref: LabWare LIMS.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: LabWare LIMS.',
    `record_status` STRING COMMENT 'The record status value recorded for each certificate of analysis in the laboratory domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each certificate of analysis in the laboratory domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each certificate of analysis in the laboratory domain.',
    `regulatory_submission_required` BOOLEAN COMMENT 'Whether COA must be submitted to regulator. Ref: LabWare LIMS.',
    `regulatory_submitted_date` TIMESTAMP COMMENT 'Date COA was submitted to regulator. Ref: LabWare LIMS.',
    `report_date` TIMESTAMP COMMENT 'The report date associated with each certificate of analysis record in the laboratory domain.',
    `report_format` STRING COMMENT 'Format of the certificate document (PDF, electronic, paper). Ref: LabWare LIMS.',
    `report_narrative` STRING COMMENT 'Narrative section of COA. Ref: LabWare LIMS.',
    `report_pdf_url` STRING COMMENT 'report pdf url for certificate_of_analysis. Ref: LabWare LIMS.',
    `report_status` STRING COMMENT 'Report status. Ref: LabWare LIMS.',
    `report_to_name` STRING COMMENT 'Client name on certificate. Ref: LabWare LIMS.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each certificate of analysis record in the laboratory domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each certificate of analysis in the laboratory domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each certificate of analysis in the laboratory domain.',
    `review_date` TIMESTAMP COMMENT 'The review date associated with each certificate of analysis record in the laboratory domain.',
    `revision_number` STRING COMMENT 'Revision number (0 for original). Ref: LabWare LIMS.',
    `revision_reason` STRING COMMENT 'The revision reason value recorded for each certificate of analysis in the laboratory domain.',
    `rush_flag` BOOLEAN COMMENT 'Whether rush turnaround was requested. Ref: LabWare LIMS.',
    `sample_collected_date` TIMESTAMP COMMENT 'The sample collected date associated with each certificate of analysis record in the laboratory domain.',
    `sample_collection_date` TIMESTAMP COMMENT 'The sample collection date associated with each certificate of analysis record in the laboratory domain.',
    `sample_count` STRING COMMENT 'Number of samples on certificate. Ref: LabWare LIMS.',
    `sample_description` STRING COMMENT 'sample description for certificate_of_analysis. Ref: LabWare LIMS.',
    `sample_matrix` STRING COMMENT 'Drinking water, wastewater, soil, sediment, air. Ref: LabWare LIMS.',
    `sample_receipt_date` DATE COMMENT 'Date samples were received. Ref: LabWare LIMS.',
    `sample_received_date` TIMESTAMP COMMENT 'sample received date for certificate_of_analysis. Ref: LabWare LIMS.',
    `signature_timestamp` TIMESTAMP COMMENT 'Timestamp of electronic signature. Ref: LabWare LIMS.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each certificate of analysis record in the laboratory domain.',
    `certificate_of_analysis_status` STRING COMMENT 'Lifecycle status of the record. Ref: LabWare LIMS.',
    `test_count` STRING COMMENT 'Number of tests reported. Ref: LabWare LIMS.',
    `total_analytes_tested` STRING COMMENT 'Number of distinct analytes reported on the certificate. Ref: LabWare LIMS.',
    `total_exceedances` STRING COMMENT 'Count of analytes exceeding regulatory limits on this certificate. Ref: LabWare LIMS.',
    `turnaround_days` STRING COMMENT 'Actual turnaround time in days. Ref: LabWare LIMS.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each certificate of analysis in the laboratory domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each certificate of analysis record in the laboratory domain.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each certificate of analysis in the laboratory domain.',
    CONSTRAINT pk_certificate_of_analysis PRIMARY KEY(`certificate_of_analysis_id`)
) COMMENT 'Record of each formal laboratory report or certificate of analysis (COA) issued to internal or external requestors. Captures report number, report type (compliance, operational, customer), associated work order, list of included test results, report generation datetime, reviewing analyst, signatory (NELAC-authorized), delivery method, recipient, and report status (draft, final, revised, superseded). The COA is the official deliverable that packages validated results for regulatory submission, operational decision-making, or external client delivery.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` (
    `analyst_method_qualification_id` BIGINT COMMENT 'Unique identifier for this analyst-method qualification record. Primary key. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Foreign key linking to the certified analyst who holds the method qualification. Ref: LabWare LIMS.',
    `employee_id` BIGINT COMMENT 'Reference to the employee ID of the supervisor who approved this method qualification. Part of the quality assurance audit trail.',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to the test method for which the analyst is qualified. Ref: LabWare LIMS.',
    `approved_test_methods` STRING COMMENT 'Comma-separated list or structured text of EPA method numbers and analytical procedures the analyst is qualified and authorized to perform. Examples include EPA 200.7 (metals by ICP), EPA 300.0 (anions by IC), EPA 524.2 (VOCs by GC/MS), Standard Methods 2540 (solids), etc. [Moved from certified_analyst: This comma-separated list attribute in certified_analyst is a denormalized representation of the many-to-many relationship. The proper model is to track each analyst-method qualification as a separate record in the association table with full qualification details. This attribute should be removed and replaced by queries against the analyst_method_qualification association.]. Ref: LabWare LIMS.',
    `certification_date` DATE COMMENT 'Date on which the analyst was certified or qualified to perform this specific test method. Used to track when the qualification became effective. Ref: LabWare LIMS.',
    `certification_level` STRING COMMENT 'Hierarchical level of qualification for this specific method indicating the complexity of analyses the analyst can perform independently (Trainee, Qualified, Senior, Signatory). Ref: LabWare LIMS.',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Total number of continuing education hours or professional development units earned by the analyst specific to this test method or method category. Required for certification renewal. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Part of audit trail. Ref: LabWare LIMS.',
    `demonstration_of_capability_date` DATE COMMENT 'Date on which the analyst successfully completed the Demonstration of Capability (DOC) for this method, proving they can meet method performance criteria. Required by TNI and NELAC standards. Ref: LabWare LIMS.',
    `expiration_date` DATE COMMENT 'Date on which this method-specific qualification expires and must be renewed. Critical for compliance with accreditation requirements. Ref: LabWare LIMS.',
    `initial_training_date` DATE COMMENT 'Date on which the analyst completed initial training for this specific test method. Part of the qualification documentation trail. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was most recently updated. Part of audit trail. Ref: LabWare LIMS.',
    `last_proficiency_test_date` DATE COMMENT 'Date of the most recent proficiency testing event completed by the analyst for this specific method. Used to track compliance with annual or biennial PT requirements. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this analyst-method qualification (e.g., matrix-specific limitations, instrument-specific qualifications). Ref: LabWare LIMS.',
    `proficiency_test_status` STRING COMMENT 'Status of the analysts most recent proficiency testing for this specific method. Proficiency testing is required by accreditation bodies to verify analyst competency. Ref: LabWare LIMS.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of this analyst-method qualification. Active qualifications authorize the analyst to perform the method; expired or suspended qualifications require remediation. Ref: LabWare LIMS.',
    `record_source` STRING COMMENT 'Identifier of the source system from which this qualification record originated (e.g., LIMS, QMS, training management system). Ref: LabWare LIMS.',
    `signatory_authority` BOOLEAN COMMENT 'Boolean flag indicating whether the analyst has signatory authority to approve and certify analytical results for this specific test method. Signatory authority requires demonstrated proficiency and supervisor approval.',
    `supervisor_approval_date` DATE COMMENT 'Date on which the laboratory supervisor or quality manager approved the analysts qualification for this method. Required for accreditation compliance.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each analyst method qualification in the laboratory domain.',
    CONSTRAINT pk_analyst_method_qualification PRIMARY KEY(`analyst_method_qualification_id`)
) COMMENT 'This association product represents the certification relationship between certified analysts and test methods in the laboratory quality assurance program. It captures the formal qualification of each analyst to perform specific analytical test methods, including certification dates, proficiency testing results, and signatory authority. Each record links one certified analyst to one test method with attributes that exist only in the context of this qualification relationship. This is a critical quality control entity audited by accreditation bodies (NELAC, TNI) and required for data defensibility in regulatory reporting.. Existence Justification: In water utility laboratories, analyst method qualification is a formal, audited business process required by accreditation bodies (NELAC, TNI). Each analyst must be individually certified to perform specific test methods, with documented training, proficiency testing, and supervisor approval. One analyst is qualified for multiple methods (e.g., an analyst qualified for EPA 200.8, SM 2130B, and EPA 524.2), and each method has multiple qualified analysts (e.g., EPA 200.8 can be performed by 5 different certified analysts). The laboratory quality manager actively manages this matrix of qualifications, tracking expiration dates, proficiency test results, and signatory authority for each analyst-method combination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` (
    `plan_analyte_requirement_id` BIGINT COMMENT 'Unique identifier for this plan-analyte requirement record. Primary key. Ref: LabWare LIMS.',
    `analyte_id` BIGINT COMMENT 'Foreign key linking to the analyte parameter that must be tested under this sampling plan. Ref: LabWare LIMS.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to the sampling plan that requires this analyte to be tested. Ref: LabWare LIMS.',
    `analyte_list` STRING COMMENT 'Comma-separated list of required analytes or parameters to be tested under this sampling plan (e.g., pH, turbidity, chlorine residual, THM, HAA5, lead, copper, PFAS, BOD, TSS, E. coli). Detailed test methods are specified separately. [Moved from sampling_plan: This comma-separated list in sampling_plan is a denormalized representation of the M:N relationship. The proper model is to have individual plan_analyte_requirement records rather than a text list. This attribute should be deprecated in favor of querying the association table.]. Ref: LabWare LIMS.',
    `compliance_threshold_unit` STRING COMMENT 'Unit of measure for the compliance threshold (e.g., mg/L, µg/L, CFU/100mL). Stored at the requirement level because different plans may report the same analyte in different units. Ref: LabWare LIMS.',
    `compliance_threshold_value` DECIMAL(18,2) COMMENT 'The specific regulatory or permit limit for this analyte under this sampling plan. May differ from the default MCL in the analyte table if the plan is driven by a specific permit or state regulation with stricter limits. Ref: LabWare LIMS.',
    `container_type` STRING COMMENT 'Required sample container type for this analyte under this plan (e.g., sterile plastic bottle, amber glass, PFAS-free container). Stored at requirement level because container requirements may vary by test method. Ref: LabWare LIMS.',
    `effective_end_date` DATE COMMENT 'Date on which this analyte requirement expires or is replaced for this sampling plan. Nullable for ongoing requirements. Used when regulatory requirements change or permits are updated. Ref: LabWare LIMS.',
    `effective_start_date` DATE COMMENT 'Date on which this analyte requirement becomes effective for this sampling plan. Allows for phased implementation of new regulatory requirements (e.g., PFAS monitoring phase-in). Ref: LabWare LIMS.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time between sample collection and analysis for this analyte under this plan. Stored at requirement level because different regulatory programs may impose different holding time requirements for the same analyte. Ref: LabWare LIMS.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether testing for this analyte is mandatory (true) or optional (false) under this sampling plan. Some plans may include optional analytes for operational monitoring beyond regulatory requirements. Ref: LabWare LIMS.',
    `minimum_sample_volume_ml` STRING COMMENT 'Minimum sample volume required for this analyte under this plan, in milliliters. May differ from the analytes default if the plan requires multiple replicates or QA/QC samples. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional context about this specific analyte requirement, such as special handling instructions, regulatory citations, or operational notes. Ref: LabWare LIMS.',
    `plan_analyte_requirement_status` STRING COMMENT 'Current status of this analyte requirement: active (currently in effect), inactive (temporarily suspended), pending (scheduled for future activation), superseded (replaced by updated requirement). Ref: LabWare LIMS.',
    `preservation_method` STRING COMMENT 'Required sample preservation technique for this analyte under this plan (e.g., acidify to pH<2, refrigerate to 4°C, add sodium thiosulfate). Stored at requirement level because preservation may vary by test method or regulatory program. Ref: LabWare LIMS.',
    `qaqc_protocol` STRING COMMENT 'Specific quality assurance and quality control protocol required for this analyte under this plan (e.g., matrix spike frequency, duplicate sample requirements, blank requirements). May be more stringent than default analyte QA/QC. Ref: LabWare LIMS.',
    `reporting_requirement` STRING COMMENT 'Specific reporting obligation for this analyte under this plan (e.g., CCR annual report, NPDES DMR monthly, LCRR 90th percentile calculation). Different plans may have different reporting requirements for the same analyte.',
    `required_detection_limit` DECIMAL(18,2) COMMENT 'The minimum detection limit required for this analyte under this plan. May be more stringent than the analytes default detection limit if the plan is driven by a regulatory program requiring lower detection limits (e.g., PFAS monitoring). Ref: LabWare LIMS.',
    `sampling_frequency` STRING COMMENT 'Required sampling frequency for this specific analyte under this plan (e.g., daily, weekly, monthly, quarterly). May differ from the plans overall frequency if certain analytes require more or less frequent testing. Ref: LabWare LIMS.',
    `test_method_code` STRING COMMENT 'The specific EPA, Standard Methods, or ASTM method code required for testing this analyte under this sampling plan. Different plans may require different methods for the same analyte based on regulatory driver or detection limit requirements. Ref: LabWare LIMS.',
    `test_method_list` STRING COMMENT 'Comma-separated list of required analytical test methods or standard method references (e.g., EPA 200.8, SM 2320B, ASTM D1067) corresponding to the analyte list. Ensures regulatory compliance and analytical consistency. [Moved from sampling_plan: This comma-separated list in sampling_plan is a denormalized representation of test methods that should be stored at the plan-analyte requirement level. Different analytes under the same plan require different test methods, so this belongs in the association, not as a plan-level list.]. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each plan analyte requirement in the laboratory domain.',
    CONSTRAINT pk_plan_analyte_requirement PRIMARY KEY(`plan_analyte_requirement_id`)
) COMMENT 'This association product represents the regulatory monitoring requirement between sampling_plan and analyte. It captures the specific testing parameters, methods, and compliance thresholds that define which analytes must be tested under each sampling plan. Each record links one sampling plan to one analyte with attributes that exist only in the context of this regulatory requirement, such as the specific test method to use, compliance threshold values, and preservation requirements for that analyte within that plans context.. Existence Justification: Water utilities manage sampling plans that specify multiple analytes to be tested (e.g., a SDWA compliance plan tests for lead, copper, chlorine, THMs, HAA5, PFAS), and each analyte appears in multiple sampling plans (e.g., lead is tested under LCRR tap sampling, distribution system monitoring, and entry point monitoring plans). The relationship itself carries critical regulatory data: the specific test method required for that analyte under that plan, the compliance threshold value (which may differ from default MCL based on permit conditions), preservation requirements, holding times, and reporting obligations. This is actively managed in LIMS as the core configuration that drives sample analysis and compliance reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` (
    `lab_accreditation_grant_id` BIGINT COMMENT 'Primary key for the lab_accreditation_grant association. Ref: LabWare LIMS.',
    `lab_accreditation_id` BIGINT COMMENT 'Foreign key linking to the laboratory accreditation record. Ref: LabWare LIMS.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to the regulatory agency that issued this accreditation. Ref: LabWare LIMS.',
    `accreditation_certificate_number` STRING COMMENT 'The unique certificate number issued by the accrediting body for this specific accreditation grant. This is relationship-specific data that exists only in the context of this agency-laboratory accreditation. Ref: LabWare LIMS.',
    `accreditation_contact_email` STRING COMMENT 'Email address of the laboratory staff member responsible for managing this accreditation. [Moved from lab_accreditation: Contact email for managing this specific agency relationship. Relationship-specific.]. Ref: LabWare LIMS.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `accreditation_contact_name` STRING COMMENT 'Name of the laboratory staff member responsible for managing this accreditation and serving as the primary contact with the accrediting body. [Moved from lab_accreditation: The lab contact responsible for managing this specific accreditation relationship with this agency. Relationship-specific.]. Ref: LabWare LIMS.',
    `accreditation_contact_phone` STRING COMMENT 'Phone number of the laboratory staff member responsible for managing this accreditation. [Moved from lab_accreditation: Contact phone for managing this specific agency relationship. Relationship-specific.]. Ref: LabWare LIMS.',
    `accreditation_cost_usd` DECIMAL(18,2) COMMENT 'The total cost in US dollars for obtaining and maintaining this specific accreditation from this agency. Ref: LabWare LIMS.',
    `accreditation_document_url` STRING COMMENT 'URL or file path to the digital copy of this accreditation certificate and scope document. Ref: LabWare LIMS.',
    `accreditation_scope_description` STRING COMMENT 'Detailed description of the accreditation scope for this specific grant, including the list of accredited analytes, matrices, and methods approved by this agency. Ref: LabWare LIMS.',
    `accreditation_status` STRING COMMENT 'Current status of this specific accreditation grant (active, suspended, revoked, expired, pending). This is relationship-specific state. Ref: LabWare LIMS.',
    `accreditation_type` STRING COMMENT 'The type or program of accreditation granted by this agency (e.g., state primacy, NELAC/TNI, A2LA, DoD ELAP). Ref: LabWare LIMS.',
    `accredited_analyte_count` STRING COMMENT 'The total number of analytes for which the laboratory is accredited under this accreditation. [Moved from lab_accreditation: The count of accredited analytes varies by agency and their scope. This is relationship-specific or derivable.]. Ref: LabWare LIMS.',
    `accredited_matrix_list` STRING COMMENT 'Comma-separated or structured list of matrices (e.g., drinking water, wastewater, soil, sludge) covered under this accreditation. [Moved from lab_accreditation: The list of accredited matrices varies by agency. EPA may accredit for drinking water while state accredits for wastewater.]. Ref: LabWare LIMS.',
    `accredited_method_list` STRING COMMENT 'Comma-separated or structured list of test methods (e.g., EPA 200.7, SM 2540C) for which the laboratory is accredited. [Moved from lab_accreditation: The list of accredited methods varies by agency and their program scope. This is relationship-specific.]. Ref: LabWare LIMS.',
    `accrediting_organization_name` STRING COMMENT 'Name of the accrediting body that issued this accreditation (e.g., state primacy agency, NELAC/TNI, A2LA, DoD ELAP). [Moved from lab_accreditation: This is redundant with the regulatory_agency reference and should be derived from the agency master record, not stored in the association or lab_accreditation.]. Ref: LabWare LIMS.',
    `assessment_frequency_months` STRING COMMENT 'The frequency in months at which the accrediting body conducts assessments (e.g., 12, 24, 36 months). [Moved from lab_accreditation: Assessment frequency is determined by the agencys program requirements, not the lab. This should be an attribute of the agency or the relationship.]. Ref: LabWare LIMS.',
    `certificate_effective_date` DATE COMMENT 'The effective start date of this accreditation certificate issued by this agency to this laboratory. Ref: LabWare LIMS.',
    `certificate_expiry_date` DATE COMMENT 'The expiration date of this accreditation certificate. Critical for renewal tracking and ensuring regulatory defensibility. Ref: LabWare LIMS.',
    `conditions_or_deficiencies_noted` STRING COMMENT 'Any conditions, limitations, or deficiencies noted by this agency during assessments for this accreditation. Ref: LabWare LIMS.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which corrective actions must be completed for this accreditation. Ref: LabWare LIMS.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required for this specific accreditation grant. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation grant record was first created in the system. Ref: LabWare LIMS.',
    `current_certificate_effective_date` DATE COMMENT 'The effective start date of the current accreditation certificate. [Moved from lab_accreditation: Each agency issues its own certificate with its own effective date. This is relationship-specific.]. Ref: LabWare LIMS.',
    `current_certificate_expiry_date` DATE COMMENT 'The expiration date of the current accreditation certificate. Critical for ensuring continuous regulatory defensibility. [Moved from lab_accreditation: Each agencys certificate has its own expiry date. This is relationship-specific and critical for renewal tracking per agency.]. Ref: LabWare LIMS.',
    `initial_accreditation_date` DATE COMMENT 'The date when the laboratory first received this accreditation from this agency. Ref: LabWare LIMS.',
    `last_assessment_date` DATE COMMENT 'The date of the most recent on-site assessment conducted by this agency for this accreditation. Ref: LabWare LIMS.',
    `last_onsite_assessment_date` DATE COMMENT 'The date of the most recent on-site assessment conducted by the accrediting body. [Moved from lab_accreditation: Each agency conducts its own assessments on its own schedule. This is relationship-specific.]. Ref: LabWare LIMS.',
    `last_proficiency_test_date` DATE COMMENT 'The date of the most recent proficiency testing event completed for this accreditation. [Moved from lab_accreditation: PT dates are tracked per accreditation program/agency. This is relationship-specific.]. Ref: LabWare LIMS.',
    `next_assessment_due_date` DATE COMMENT 'The scheduled date for the next assessment by this agency for this accreditation. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this accreditation, including special conditions, historical context, or operational considerations. [Moved from lab_accreditation: Notes are specific to each agency-lab accreditation relationship. Different agencies may have different notes.]. Ref: LabWare LIMS.',
    `proficiency_test_pass_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of proficiency test samples that passed acceptance criteria in the most recent testing cycle. [Moved from lab_accreditation: PT pass rates are evaluated per agency program. This is relationship-specific.]. Ref: LabWare LIMS.',
    `proficiency_testing_provider` STRING COMMENT 'Name of the proficiency testing provider used to satisfy accreditation requirements (e.g., ERA, APHA, NELAP PT providers). [Moved from lab_accreditation: PT provider requirements may vary by agency program. This is relationship-specific or should be on the agency.]. Ref: LabWare LIMS.',
    `regulatory_defensibility_flag` BOOLEAN COMMENT 'Indicates whether the accreditation is currently in good standing and provides regulatory defensibility for analytical data. [Moved from lab_accreditation: Regulatory defensibility is specific to each agency relationship. Data may be defensible for EPA but not for a state agency if that accreditation is suspended.]. Ref: LabWare LIMS.',
    `renewal_notification_days_prior` STRING COMMENT 'Number of days before expiry that renewal notifications should be triggered to ensure timely renewal. [Moved from lab_accreditation: Renewal notification timing may vary by agency program requirements. This is relationship-specific or agency-specific.]. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each lab accreditation grant in the laboratory domain.',
    CONSTRAINT pk_lab_accreditation_grant PRIMARY KEY(`lab_accreditation_grant_id`)
) COMMENT 'This association product represents the formal accreditation grant issued by a regulatory agency to a laboratory for specific testing capabilities. Each record captures the certificate, scope, validity period, assessment schedule, and compliance status for one accreditation relationship. A laboratory holds multiple accreditations from different agencies (EPA, state primacy, NELAC, A2LA), and each agency accredits multiple laboratories. This is a core compliance artifact that laboratories actively manage for regulatory defensibility.. Existence Justification: In water utility laboratory operations, a single laboratory holds multiple simultaneous accreditations from different regulatory agencies (EPA, state primacy agency, NELAC/TNI, A2LA, DoD ELAP), and each regulatory agency accredits multiple laboratories across their jurisdiction. Each accreditation grant is a distinct compliance artifact with its own certificate number, scope, validity period, assessment schedule, and status. Laboratory managers actively manage their accreditation portfolio, tracking renewal dates, responding to agency-specific deficiencies, and ensuring regulatory defensibility of analytical data for each agency relationship.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` (
    `method_material_usage_id` BIGINT COMMENT 'Unique identifier for this method-material usage record. Primary key. Ref: LabWare LIMS.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material, chemical, reagent, or consumable used in this test method. Ref: LabWare LIMS.',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to the analytical test method that requires this material. Ref: LabWare LIMS.',
    `alternative_material_flag` BOOLEAN COMMENT 'Indicates whether this material is an approved alternative or substitute for the primary material specified in the method. True if alternative, false if primary/required material. Ref: LabWare LIMS.',
    `consumption_rate` DECIMAL(18,2) COMMENT 'Average consumption rate of this material for this method, expressed as quantity per time period (e.g., liters per month). Used for procurement planning and reorder point calculations. Ref: LabWare LIMS.',
    `consumption_rate_unit` DECIMAL(18,2) COMMENT 'Time unit for the consumption rate (per_test, per_day, per_week, per_month). Ref: LabWare LIMS.',
    `cost_per_test` DECIMAL(18,2) COMMENT 'Calculated material cost for this specific material per single test execution. Derived from quantity_per_test and material standard_price. Used for test method cost accounting and pricing. Ref: LabWare LIMS.',
    `criticality` STRING COMMENT 'Criticality classification for this material in the context of this method. Critical materials have no substitutes and stockouts halt testing; important materials have limited alternatives; standard materials are readily substitutable. Ref: LabWare LIMS.',
    `effective_date` DATE COMMENT 'Date on which this material became approved and effective for use with this test method. Supports method version changes and material substitutions over time. Ref: LabWare LIMS.',
    `expiration_date` DATE COMMENT 'Date on which this material is no longer approved for use with this test method. Null if currently active. Used when materials are phased out or methods are updated. Ref: LabWare LIMS.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this method-material usage record. Tracks when consumption rates, quantities, or material preferences were last reviewed. Ref: LabWare LIMS.',
    `material_role` STRING COMMENT 'The functional role this material plays in the execution of this test method (reagent, standard, calibration_solution, preservative, consumable, quality_control_sample). Ref: LabWare LIMS.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor associated with this material is the preferred vendor for this specific method-material combination, based on quality, reliability, or regulatory acceptance. Ref: LabWare LIMS.',
    `quantity_per_test` DECIMAL(18,2) COMMENT 'Standard quantity of this material consumed per single test execution. Used for inventory forecasting and cost allocation. Units align with material base_unit_of_measure. Ref: LabWare LIMS.',
    `updated_by` STRING COMMENT 'User ID or name of the laboratory staff member who last updated this method-material usage record. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each method material usage in the laboratory domain.',
    CONSTRAINT pk_method_material_usage PRIMARY KEY(`method_material_usage_id`)
) COMMENT 'This association product represents the bill-of-materials relationship between laboratory test methods and the materials, reagents, chemicals, and consumables required to perform each test. It captures the specific materials needed for each analytical method, including quantities, consumption rates, and material preferences. Each record links one test method to one material with attributes that exist only in the context of this method-material pairing, enabling accurate inventory planning, cost allocation per test, and procurement forecasting for laboratory operations.. Existence Justification: Laboratory test methods require multiple materials (reagents, standards, calibration solutions, preservatives, consumables) to execute, and each material is used across multiple different test methods. The laboratory actively manages this bill-of-materials relationship, tracking consumption rates per method-material pair for inventory planning, cost allocation per test, and procurement forecasting. This is a genuine operational M:N relationship where the pairing itself carries critical business data.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` (
    `analyst_grant_allocation_id` BIGINT COMMENT 'Primary key for the analyst_grant_allocation association. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Foreign key linking to the certified laboratory analyst whose effort is being allocated to this grant. Ref: LabWare LIMS.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant receiving the analysts labor allocation. Ref: LabWare LIMS.',
    `allocation_period_end_date` DATE COMMENT 'End date of the period during which this effort allocation is effective. Used to track historical allocations and support quarterly effort certification reporting. Ref: LabWare LIMS.',
    `allocation_period_start_date` DATE COMMENT 'Start date of the period during which this effort allocation is effective. Typically aligns with grant quarters or fiscal periods for effort certification. Ref: LabWare LIMS.',
    `cost_category` STRING COMMENT 'Classification of the labor cost for grant accounting purposes. Distinguishes between direct labor, fringe benefits, and indirect costs applied to the analysts time. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the system. Ref: LabWare LIMS.',
    `effort_certification_date` DATE COMMENT 'Date on which the analyst or authorized representative certified the effort allocation for this grant period. Required for federal grant compliance. Ref: LabWare LIMS.',
    `effort_certification_status` STRING COMMENT 'Status of the quarterly effort certification for this analyst-grant allocation. Federal grants require analysts to certify their effort quarterly. Ref: LabWare LIMS.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'Percentage of the analysts total work time allocated to this grant. Used for quarterly effort certification required by federal grants. Must sum to 100% or less across all grants for each analyst. Ref: LabWare LIMS.',
    `grant_account_code` STRING COMMENT 'General ledger account code to which this analysts labor costs are charged. Links the allocation to the utilitys chart of accounts for grant accounting. Ref: LabWare LIMS.',
    `grant_role` STRING COMMENT 'The specific role the analyst performs on this grant project. Required for federal grant reporting to distinguish between PI, co-investigators, and support staff. Ref: LabWare LIMS.',
    `labor_cost_allocation` DECIMAL(18,2) COMMENT 'Dollar amount of the analysts labor costs charged to this grant during the allocation period. Calculated from effort percentage and analysts salary/benefits. Used for grant drawdown requests and SEFA reporting. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was most recently updated. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional notes about this allocation, such as special conditions, adjustments, or explanations for effort certification. Ref: LabWare LIMS.',
    `record_source` STRING COMMENT 'Identifier of the source system from which this allocation record originated (e.g., payroll system, grant management system, time tracking system). Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each analyst grant allocation in the laboratory domain.',
    CONSTRAINT pk_analyst_grant_allocation PRIMARY KEY(`analyst_grant_allocation_id`)
) COMMENT 'This association product represents the labor allocation between certified laboratory analysts and grants. It captures the effort certification and cost allocation required for federal grant compliance. Each record links one certified analyst to one grant with attributes that track the analysts role, effort percentage, labor costs, and allocation period for grant accounting and federal reporting requirements.. Existence Justification: Water utilities must track labor allocation of certified laboratory analysts across multiple federal and state grants for compliance with OMB Uniform Guidance effort certification requirements. One analyst can charge time to multiple grants simultaneously (split effort), and one grant employs multiple analysts in different roles. The business actively manages quarterly effort certification, where each analyst must certify their effort percentage across all grants, and finance must allocate labor costs to the correct grant accounts for drawdown requests and Single Audit SEFA reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` (
    `analyst_training_completion_id` BIGINT COMMENT 'Unique identifier for this analyst training completion record. Primary key. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Foreign key linking to the certified analyst who completed the training. Ref: LabWare LIMS.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to the training course that was completed. Ref: LabWare LIMS.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Percentage score achieved by the analyst on the training course assessment or exam. Null if no assessment was required. Ref: LabWare LIMS.',
    `attendance_hours` DECIMAL(18,2) COMMENT 'Actual number of hours the analyst attended or participated in the training. May differ from the course duration if partial attendance occurred. Ref: LabWare LIMS.',
    `certification_issued` STRING COMMENT 'Name or code of the certification or credential issued to the analyst upon completion of this training course. May be null if the course does not award a certification. Ref: LabWare LIMS.',
    `ceu_credits_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Education Unit credits earned by the analyst for this specific training completion. Used to track progress toward certification renewal requirements. Ref: LabWare LIMS.',
    `completion_date` DATE COMMENT 'Date on which the analyst successfully completed the training course. Critical for tracking certification renewal timelines and regulatory compliance windows. Ref: LabWare LIMS.',
    `cost_charged` DECIMAL(18,2) COMMENT 'Actual cost in US dollars charged for this analysts enrollment in this training course offering. May differ from standard cost due to discounts or group rates. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the system. Ref: LabWare LIMS.',
    `enrollment_date` DATE COMMENT 'Date on which the analyst enrolled in this training course offering. Ref: LabWare LIMS.',
    `expiration_date` DATE COMMENT 'Date on which the certification or qualification earned from this training completion expires and must be renewed. Null if the training does not expire. Ref: LabWare LIMS.',
    `funding_source` STRING COMMENT 'Department, grant, or budget code that funded this training enrollment. Ref: LabWare LIMS.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered this specific training session to the analyst. Ref: LabWare LIMS.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was most recently updated. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this specific training completion. Ref: LabWare LIMS.',
    `pass_fail_status` STRING COMMENT 'Status indicating whether the analyst passed, failed, or is still in progress with the training course. Ref: LabWare LIMS.',
    `training_completion_date` DATE COMMENT 'Date on which the analyst completed initial laboratory training and was authorized to perform independent analytical work. Marks the transition from trainee to qualified analyst status. [Moved from certified_analyst: This attribute in certified_analyst appears to track a single initial training completion date. In reality, analysts complete multiple training courses over time, each with its own completion date. This attribute should be removed from certified_analyst and tracked in the analyst_training_completion association where each training completion has its own date.]. Ref: LabWare LIMS.',
    `training_location` STRING COMMENT 'Physical location or online platform where the training was delivered for this completion record. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each analyst training completion in the laboratory domain.',
    CONSTRAINT pk_analyst_training_completion PRIMARY KEY(`analyst_training_completion_id`)
) COMMENT 'This association product represents the completion event between certified_analyst and training_course. It captures the regulatory compliance and continuing education tracking required for laboratory analyst certification maintenance. Each record links one certified_analyst to one training_course with completion dates, CEU credits earned, and certification issuance details that exist only in the context of this specific training completion.. Existence Justification: In water utility laboratory operations, certified analysts must complete multiple training courses over their careers to maintain certifications, earn continuing education credits, and stay current with regulatory requirements and analytical methods. Each training course is completed by multiple analysts across the organization. The business actively manages these training completion records to ensure regulatory compliance, track CEU credit accumulation toward certification renewals, and maintain analyst authorization for specific test methods.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory. Ref: LabWare LIMS.',
    `parent_laboratory_id` BIGINT COMMENT 'Self-referencing FK on laboratory (parent_laboratory_id). Ref: LabWare LIMS.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the laboratorys accreditation expires. Ref: LabWare LIMS.',
    `accreditation_number` STRING COMMENT 'Identifier of the laboratorys accreditation certificate (e.g., ISO 17025).',
    `calibration_schedule` STRING COMMENT 'Standard schedule for instrument calibration (e.g., quarterly, semi‑annual). Ref: LabWare LIMS.',
    `capacity_daily_tests` STRING COMMENT 'Maximum number of analytical tests the laboratory can process per day. Ref: LabWare LIMS.',
    `closure_date` DATE COMMENT 'Date the laboratory was decommissioned or ceased operations, if applicable. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was first created. Ref: LabWare LIMS.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long laboratory data is retained. Ref: LabWare LIMS.',
    `laboratory_description` STRING COMMENT 'Additional free‑text notes describing the laboratorys capabilities, specialties, or other relevant information. Ref: LabWare LIMS.',
    `email_address` STRING COMMENT 'Primary contact email address for the laboratory. Ref: LabWare LIMS.',
    `instrument_count` STRING COMMENT 'Total number of analytical instruments housed in the laboratory. Ref: LabWare LIMS.',
    `lab_code` STRING COMMENT 'Internal code used to uniquely identify the laboratory within the organization. Ref: LabWare LIMS.',
    `lab_type` STRING COMMENT 'Category of analytical testing performed by the laboratory. Ref: LabWare LIMS.',
    `location_address` STRING COMMENT 'Physical street address of the laboratory facility. Ref: LabWare LIMS.',
    `method_catalog_version` STRING COMMENT 'Version identifier of the test method catalog used for analyses. Ref: LabWare LIMS.',
    `laboratory_name` STRING COMMENT 'Descriptive name of the laboratory. Ref: LabWare LIMS.',
    `operating_hours` STRING COMMENT 'Standard daily operating hours (e.g., 08:00-17:00). Ref: LabWare LIMS.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the laboratory. Ref: LabWare LIMS.',
    `primary_analyst_name` STRING COMMENT 'Name of the lead certified analyst responsible for laboratory oversight. Ref: LabWare LIMS.',
    `qa_qc_protocol` STRING COMMENT 'Name or code of the quality assurance / quality control protocol applied in the laboratory. Ref: LabWare LIMS.',
    `safety_level` STRING COMMENT 'Overall safety classification of the laboratory based on hazard assessments. Ref: LabWare LIMS.',
    `laboratory_status` STRING COMMENT 'Current operational status of the laboratory. Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the laboratory record. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each laboratory in the laboratory domain.',
    `waste_disposal_method` STRING COMMENT 'Standard method used for disposal of laboratory waste. Ref: LabWare LIMS.',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master reference table for laboratory. Referenced by laboratory_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` (
    `calibration_curve_id` BIGINT COMMENT 'Primary key for calibration_curve. Ref: LabWare LIMS.',
    `certified_analyst_id` BIGINT COMMENT 'Identifier of the certified analyst who performed the calibration. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the instrument to which this calibration curve applies. Ref: LabWare LIMS.',
    `reference_calibration_curve_id` BIGINT COMMENT 'Self-referencing FK on calibration_curve (reference_calibration_curve_id). Ref: LabWare LIMS.',
    `calibration_date` DATE COMMENT 'Calendar date on which the calibration was performed. Ref: LabWare LIMS.',
    `calibration_equation` STRING COMMENT 'Mathematical equation representing the calibration curve. Ref: LabWare LIMS.',
    `calibration_method` STRING COMMENT 'Methodology used to generate the calibration curve. Ref: LabWare LIMS.',
    `calibration_time` TIMESTAMP COMMENT 'Exact timestamp of the calibration activity. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration curve record was first created. Ref: LabWare LIMS.',
    `curve_code` STRING COMMENT 'External code or identifier used to reference the calibration curve in laboratory systems. Ref: LabWare LIMS.',
    `curve_name` STRING COMMENT 'Human‑readable name of the calibration curve. Ref: LabWare LIMS.',
    `curve_type` STRING COMMENT 'Mathematical model used for the calibration curve. Ref: LabWare LIMS.',
    `data_source` STRING COMMENT 'System or process that supplied the calibration curve data. Ref: LabWare LIMS.',
    `calibration_curve_description` STRING COMMENT 'Free‑form description of the calibration curve purpose and characteristics. Ref: LabWare LIMS.',
    `effective_end_date` DATE COMMENT 'Date after which the calibration curve is no longer valid (nullable). Ref: LabWare LIMS.',
    `effective_start_date` DATE COMMENT 'Date from which the calibration curve is considered valid. Ref: LabWare LIMS.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage during calibration. Ref: LabWare LIMS.',
    `instrument_model` STRING COMMENT 'Model designation of the instrument associated with the curve. Ref: LabWare LIMS.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the calibration curve has passed QA verification. Ref: LabWare LIMS.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent use of this calibration curve. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Additional free‑text notes or comments about the calibration curve. Ref: LabWare LIMS.',
    `number_of_points` STRING COMMENT 'Count of data points used to generate the calibration curve. Ref: LabWare LIMS.',
    `r_squared` DECIMAL(18,2) COMMENT 'Statistical measure of fit quality for the calibration curve. Ref: LabWare LIMS.',
    `reference_value` DECIMAL(18,2) COMMENT 'Primary concentration value that the curve is anchored to. Ref: LabWare LIMS.',
    `standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of the residuals from the calibration fit. Ref: LabWare LIMS.',
    `calibration_curve_status` STRING COMMENT 'Current lifecycle status of the calibration curve. Ref: LabWare LIMS.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature (in degrees Celsius) at which the calibration was performed. Ref: LabWare LIMS.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the reference concentration and curve values. Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calibration curve record. Ref: LabWare LIMS.',
    `verification_date` DATE COMMENT 'Date on which the calibration curve was verified. Ref: LabWare LIMS.',
    `version_number` STRING COMMENT 'Version number for change control of the calibration curve. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each calibration curve in the laboratory domain.',
    CONSTRAINT pk_calibration_curve PRIMARY KEY(`calibration_curve_id`)
) COMMENT 'Master reference table for calibration_curve. Referenced by calibration_curve_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` (
    `validation_batch_id` BIGINT COMMENT 'Primary key for validation_batch. Ref: LabWare LIMS.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the laboratory instrument used for the batch. Ref: LabWare LIMS.',
    `parent_validation_batch_id` BIGINT COMMENT 'Self-referencing FK on validation_batch (parent_validation_batch_id). Ref: LabWare LIMS.',
    `batch_code` STRING COMMENT 'External or legacy code used to reference the batch in laboratory systems. Ref: LabWare LIMS.',
    `batch_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special notes for the batch. Ref: LabWare LIMS.',
    `batch_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch processing completed. Ref: LabWare LIMS.',
    `batch_name` STRING COMMENT 'Human‑readable name assigned to the batch for easy identification. Ref: LabWare LIMS.',
    `batch_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch processing began. Ref: LabWare LIMS.',
    `batch_type` STRING COMMENT 'Category describing the purpose of the batch. Ref: LabWare LIMS.',
    `batch_version` STRING COMMENT 'Version number of the batch definition, incremented on revisions. Ref: LabWare LIMS.',
    `comments` STRING COMMENT 'Additional remarks or observations recorded by the analyst. Ref: LabWare LIMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the system. Ref: LabWare LIMS.',
    `location_code` STRING COMMENT 'Code of the facility or laboratory where the batch was performed. Ref: LabWare LIMS.',
    `method_used` STRING COMMENT 'Standard method or protocol applied to the samples in the batch. Ref: LabWare LIMS.',
    `operator_name` STRING COMMENT 'Name of the certified analyst who oversaw the batch execution. Ref: LabWare LIMS.',
    `quality_flag` BOOLEAN COMMENT 'Overall quality assessment result for the batch. Ref: LabWare LIMS.',
    `validation_batch_status` STRING COMMENT 'Current lifecycle status of the batch. Ref: LabWare LIMS.',
    `total_samples` STRING COMMENT 'Number of individual samples included in the batch. Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record. Ref: LabWare LIMS.',
    `validation_result` STRING COMMENT 'Final outcome of the batch validation process. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each validation batch in the laboratory domain.',
    CONSTRAINT pk_validation_batch PRIMARY KEY(`validation_batch_id`)
) COMMENT 'Master reference table for validation_batch. Referenced by validation_batch_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` (
    `pt_provider_id` BIGINT COMMENT 'Primary key for pt_provider. Ref: LabWare LIMS.',
    `parent_pt_provider_id` BIGINT COMMENT 'Self-referencing FK on pt_provider (parent_pt_provider_id). Ref: LabWare LIMS.',
    `accreditation_body` STRING COMMENT 'Organization that issued the accreditation. Ref: LabWare LIMS.',
    `accreditation_effective_date` DATE COMMENT 'Date when the accreditation became effective. Ref: LabWare LIMS.',
    `accreditation_expiration_date` DATE COMMENT 'Date when the accreditation expires. Ref: LabWare LIMS.',
    `accreditation_number` STRING COMMENT 'Identifier of the accreditation granted to the provider. Ref: LabWare LIMS.',
    `accreditation_status` STRING COMMENT 'Current status of the providers accreditation. Ref: LabWare LIMS.',
    `address_line1` STRING COMMENT 'First line of the providers mailing address. Ref: LabWare LIMS.',
    `address_line2` STRING COMMENT 'Second line of the providers mailing address (optional). Ref: LabWare LIMS.',
    `bank_account_number` STRING COMMENT 'Bank account used for payments to the provider. Ref: LabWare LIMS.',
    `city` STRING COMMENT 'City component of the providers address. Ref: LabWare LIMS.',
    `classification` STRING COMMENT 'Business classification used for segmentation and compliance. Ref: LabWare LIMS.',
    `compliance_status` STRING COMMENT 'Overall compliance standing of the provider with utility regulations. Ref: LabWare LIMS.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the providers location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the provider record was first created. Ref: LabWare LIMS.',
    `daily_capacity_samples` STRING COMMENT 'Maximum number of samples the provider can process per day. Ref: LabWare LIMS.',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a data‑sharing agreement is in place (true) or not (false). Ref: LabWare LIMS.',
    `effective_date` DATE COMMENT 'Date when the provider relationship became effective. Ref: LabWare LIMS.',
    `expiration_date` DATE COMMENT 'Date when the provider relationship ends or is scheduled for review. Ref: LabWare LIMS.',
    `external_reference_code` STRING COMMENT 'Identifier used for the provider in external source systems. Ref: LabWare LIMS.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Monetary limit of the providers liability insurance. Ref: LabWare LIMS.',
    `legal_name` STRING COMMENT 'Legal registered name of the provider entity. Ref: LabWare LIMS.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability the provider assumes under contract. Ref: LabWare LIMS.',
    `pt_provider_name` STRING COMMENT 'Common name of the laboratory service provider. Ref: LabWare LIMS.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the provider. Ref: LabWare LIMS.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the provider. Ref: LabWare LIMS.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the providers address. Ref: LabWare LIMS.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact. Ref: LabWare LIMS.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary point‑of‑contact for the provider. Ref: LabWare LIMS.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary contact. Ref: LabWare LIMS.',
    `provider_code` STRING COMMENT 'External reference code assigned to the provider by the utility. Ref: LabWare LIMS.',
    `provider_type` STRING COMMENT 'Category describing the nature of the provider. Ref: LabWare LIMS.',
    `quality_certification` STRING COMMENT 'Quality management certifications held by the provider. Ref: LabWare LIMS.',
    `service_area` STRING COMMENT 'Geographic region(s) where the provider delivers services. Ref: LabWare LIMS.',
    `short_name` STRING COMMENT 'Abbreviated name used for reporting and UI displays. Ref: LabWare LIMS.',
    `specialties` STRING COMMENT 'Comma‑separated list of analytical test types the provider offers. Ref: LabWare LIMS.',
    `state_province` STRING COMMENT 'State or province of the providers address. Ref: LabWare LIMS.',
    `pt_provider_status` STRING COMMENT 'Current lifecycle status of the provider relationship. Ref: LabWare LIMS.',
    `tax_number` STRING COMMENT 'Government‑issued tax identifier for the provider. Ref: LabWare LIMS.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the provider record. Ref: LabWare LIMS.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each pt provider in the laboratory domain.',
    `website_url` STRING COMMENT 'Public website address of the provider. Ref: LabWare LIMS.',
    CONSTRAINT pk_pt_provider PRIMARY KEY(`pt_provider_id`)
) COMMENT 'Master reference table for pt_provider. Referenced by pt_provider_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_lab_work_order_id` FOREIGN KEY (`lab_work_order_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_work_order`(`lab_work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_sample_collection_event_id` FOREIGN KEY (`sample_collection_event_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event`(`sample_collection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_sample_collection_event_id` FOREIGN KEY (`sample_collection_event_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event`(`sample_collection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_calibration_curve_id` FOREIGN KEY (`calibration_curve_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`calibration_curve`(`calibration_curve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_tertiary_analytical_approved_by_analyst_certified_analyst_id` FOREIGN KEY (`tertiary_analytical_approved_by_analyst_certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_calibration_curve_id` FOREIGN KEY (`calibration_curve_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`calibration_curve`(`calibration_curve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_original_result_test_result_id` FOREIGN KEY (`original_result_test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_calibration_curve_id` FOREIGN KEY (`calibration_curve_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`calibration_curve`(`calibration_curve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_laboratory_reagent_standard_id` FOREIGN KEY (`laboratory_reagent_standard_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`reagent_standard`(`reagent_standard_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_reagent_standard_id` FOREIGN KEY (`reagent_standard_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`reagent_standard`(`reagent_standard_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ADD CONSTRAINT `fk_laboratory_qc_sample_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ADD CONSTRAINT `fk_laboratory_qc_sample_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ADD CONSTRAINT `fk_laboratory_qc_sample_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ADD CONSTRAINT `fk_laboratory_qc_sample_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ADD CONSTRAINT `fk_laboratory_qc_sample_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ADD CONSTRAINT `fk_laboratory_qc_sample_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_pt_provider_id` FOREIGN KEY (`pt_provider_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`pt_provider`(`pt_provider_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_validation_batch_id` FOREIGN KEY (`validation_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`validation_batch`(`validation_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_certified_analyst_id` FOREIGN KEY (`laboratory_certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_instrument_calibration_id` FOREIGN KEY (`laboratory_instrument_calibration_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration`(`laboratory_instrument_calibration_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_test_method_id` FOREIGN KEY (`laboratory_test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_verified_by_analyst_id` FOREIGN KEY (`laboratory_verified_by_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_proficiency_test_id` FOREIGN KEY (`proficiency_test_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`proficiency_test`(`proficiency_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_chain_of_custody_id` FOREIGN KEY (`chain_of_custody_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody`(`chain_of_custody_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_lab_work_order_id` FOREIGN KEY (`lab_work_order_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_work_order`(`lab_work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_revised_certificate_of_analysis_id` FOREIGN KEY (`revised_certificate_of_analysis_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_sample_collection_event_id` FOREIGN KEY (`sample_collection_event_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event`(`sample_collection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ADD CONSTRAINT `fk_laboratory_analyst_method_qualification_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ADD CONSTRAINT `fk_laboratory_analyst_method_qualification_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ADD CONSTRAINT `fk_laboratory_plan_analyte_requirement_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ADD CONSTRAINT `fk_laboratory_plan_analyte_requirement_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ADD CONSTRAINT `fk_laboratory_lab_accreditation_grant_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ADD CONSTRAINT `fk_laboratory_method_material_usage_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ADD CONSTRAINT `fk_laboratory_analyst_grant_allocation_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ADD CONSTRAINT `fk_laboratory_analyst_training_completion_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ADD CONSTRAINT `fk_laboratory_laboratory_parent_laboratory_id` FOREIGN KEY (`parent_laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ADD CONSTRAINT `fk_laboratory_calibration_curve_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ADD CONSTRAINT `fk_laboratory_calibration_curve_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ADD CONSTRAINT `fk_laboratory_calibration_curve_reference_calibration_curve_id` FOREIGN KEY (`reference_calibration_curve_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`calibration_curve`(`calibration_curve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ADD CONSTRAINT `fk_laboratory_validation_batch_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ADD CONSTRAINT `fk_laboratory_validation_batch_parent_validation_batch_id` FOREIGN KEY (`parent_validation_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`validation_batch`(`validation_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ADD CONSTRAINT `fk_laboratory_pt_provider_parent_pt_provider_id` FOREIGN KEY (`parent_pt_provider_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`pt_provider`(`pt_provider_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_chain_of_custody' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_lims' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_sample_management' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ALTER COLUMN `lab_sampler_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ALTER COLUMN `lab_sampler_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_tier' = 'mvm');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_collection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collector ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collector ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Equipment ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Equipment Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_event_number` SET TAGS ('dbx_business_glossary_term' = 'Collection Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_latitude` SET TAGS ('dbx_business_glossary_term' = 'Collection Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_location_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Location Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_longitude` SET TAGS ('dbx_business_glossary_term' = 'Collection Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_method_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_method_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Method Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Collector Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collector_name` SET TAGS ('dbx_business_glossary_term' = 'Collector Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `collector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `compliance_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `composite_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Composite Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `composite_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Composite Interval (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `field_conductivity_us_cm` SET TAGS ('dbx_business_glossary_term' = 'Field Conductivity (Microsiemens per Centimeter)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `field_dissolved_oxygen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Dissolved Oxygen (DO) (Milligrams per Liter)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `field_ph` SET TAGS ('dbx_business_glossary_term' = 'Field pH (Potential of Hydrogen)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `field_residual_chlorine_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Residual Chlorine (Milligrams per Liter)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `field_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Field Temperature (Celsius)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `field_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Field Turbidity (Nephelometric Turbidity Units)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `preservative_used` SET TAGS ('dbx_business_glossary_term' = 'Preservative Used');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_value_regex' = 'drinking_water|raw_water|wastewater|effluent|sludge|biosolids');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous|duplicate|blank|spike');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (Milliliters)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_cites' = 'OSHA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_tier' = 'mvm');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `chain_of_custody_id` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collected By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `sample_collection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `collector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Collector Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `collector_signature` SET TAGS ('dbx_business_glossary_term' = 'Collector Signature');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `collector_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `collector_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `courier_name` SET TAGS ('dbx_business_glossary_term' = 'Courier Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `courier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Courier Tracking Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `custody_document_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `custody_document_number` SET TAGS ('dbx_value_regex' = '^COC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `custody_status` SET TAGS ('dbx_business_glossary_term' = 'Custody Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `custody_status` SET TAGS ('dbx_value_regex' = 'initiated|in_transit|received|in_analysis|archived|disposed');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `discrepancy_noted` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Noted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `hold_time_compliant` SET TAGS ('dbx_business_glossary_term' = 'Hold Time Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `ice_present` SET TAGS ('dbx_business_glossary_term' = 'Ice Present Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `preservation_verified` SET TAGS ('dbx_business_glossary_term' = 'Preservation Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By (Receiving Party Name)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Received Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_signature` SET TAGS ('dbx_business_glossary_term' = 'Received Signature');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `received_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_by` SET TAGS ('dbx_business_glossary_term' = 'Relinquished By (Transferring Party Name)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_datetime` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_signature` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Signature');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `relinquished_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `sample_condition_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition at Transfer');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `seal_intact` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Custody Seal Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `temperature_at_receipt_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt (Celsius)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `temperature_compliant` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'collector_to_courier|courier_to_lab|lab_to_analyst|analyst_to_storage|storage_to_disposal');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending_accreditation|not_accredited|suspended|withdrawn');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `analysis_cost` SET TAGS ('dbx_business_glossary_term' = 'Analysis Cost');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `analysis_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `analyst_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Analyst Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `analyte_group` SET TAGS ('dbx_business_glossary_term' = 'Analyte Group');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `applicable_matrix_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Matrix Types');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `detection_technique` SET TAGS ('dbx_business_glossary_term' = 'Detection Technique');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `instrument_required` SET TAGS ('dbx_business_glossary_term' = 'Instrument Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `interferences` SET TAGS ('dbx_business_glossary_term' = 'Interferences');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `lims_method_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Method Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `mdl_unit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `mdl_value` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_category` SET TAGS ('dbx_business_glossary_term' = 'Method Category');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_category` SET TAGS ('dbx_value_regex' = 'inorganic|organic|microbiological|physical|radiological|emerging_contaminants');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]+$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_description` SET TAGS ('dbx_business_glossary_term' = 'Method Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_name` SET TAGS ('dbx_business_glossary_term' = 'Method Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_source` SET TAGS ('dbx_business_glossary_term' = 'Method Source');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_status` SET TAGS ('dbx_business_glossary_term' = 'Method Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_validation|obsolete|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `method_version` SET TAGS ('dbx_business_glossary_term' = 'Method Version');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `pql_unit` SET TAGS ('dbx_business_glossary_term' = 'Practical Quantitation Limit (PQL) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `pql_value` SET TAGS ('dbx_business_glossary_term' = 'Practical Quantitation Limit (PQL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `preservation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Preservation Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `proficiency_testing_required` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `qc_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `regulatory_acceptance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `reporting_limit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `reporting_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Limit Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `superseded_by_method_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Test Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `calibration_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Curve Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `tertiary_analytical_approved_by_analyst_certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Analyst Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `hold_time_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Time Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `lims_import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Import Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `matrix_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Percent Recovery (%)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `qualifier_code` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `raw_instrument_response` SET TAGS ('dbx_business_glossary_term' = 'Raw Instrument Response');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `reanalysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reanalysis Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Relative Percent Difference (RPD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `reporting_limit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Limit (RL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|regulatory|compliance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ALTER COLUMN `uncertainty_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_cites' = 'NPDWR');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_tier' = 'mvm');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `analytical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Test ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `calibration_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Curve ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Parameter ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Parameter ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `accreditation_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `analysis_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `approved_result_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Result Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `blank_contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Blank Contamination Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|exceedance|not_applicable|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `detection_status` SET TAGS ('dbx_business_glossary_term' = 'Detection Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `detection_status` SET TAGS ('dbx_value_regex' = 'detected|non-detect|trace|below_mdl|above_mdl');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `duplicate_relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Relative Percent Difference (RPD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `holding_time_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `lims_result_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `matrix_spike_recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike Recovery Percent');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `method_detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `proficiency_test_flag` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `reanalysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Reanalysis Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `regulatory_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `regulatory_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `reporting_limit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Limit (RL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `reporting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reporting Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `reporting_unit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `result_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'final|preliminary|rejected|under_review|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ALTER COLUMN `uncertainty_estimate` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty Estimate');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `certified_analyst_required` SET TAGS ('dbx_business_glossary_term' = 'Certified Analyst Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `chain_of_custody_required` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `compliance_threshold_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Reference');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `last_sample_collected_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collected Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `lims_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Integration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'regulatory|operational|investigational|proficiency|emergency|special');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `proficiency_testing_required` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `qaqc_protocol` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_value_regex' = 'SDWA|NPDES|LCRR|state_primacy|local_ordinance|none');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semiannual|annual|as_needed');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_value_regex' = 'CCR|DMR|MOR|state_report|internal|none');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous|field|split');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (mL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sampling_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `sampling_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|archived');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `total_samples_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Samples Collected');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Version Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `sampling_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `accessibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet (ft)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `is_compliance_location` SET TAGS ('dbx_business_glossary_term' = 'Is Compliance Location Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `is_public_access` SET TAGS ('dbx_business_glossary_term' = 'Is Public Access Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `last_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `lcrr_tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `lcrr_tier_classification` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `lims_location_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|decommissioned|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `npdes_outfall_number` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Outfall Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `npdes_outfall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Designation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `sample_point_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `service_area` SET TAGS ('dbx_business_glossary_term' = 'Service Area');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|purchased_water|blended|recycled_water');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_cites' = 'OSHA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_tier' = 'mvm');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Instrument Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `lab_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Analyst Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `annual_service_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Service Cost');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `annual_service_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Pending|Expired|Not Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `lims_instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Instrument Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `measurement_range_max` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `measurement_range_min` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `primary_test_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Test Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Purchase Cost');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `secondary_test_methods` SET TAGS ('dbx_business_glossary_term' = 'Secondary Test Methods');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_canonical_ref' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_duplicate' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_duplicate_of' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_master_for' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_pair' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_instrument_calibration_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for laboratory_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Calibrated By Analyst Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `laboratory_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `reagent_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `canonical_quality_instrument_calibration_id` SET TAGS ('dbx_ssot_canonical_ref' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `canonical_quality_instrument_calibration_id` SET TAGS ('dbx_resolution' = 'ADD_TYPE_DISCRIMINATOR');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `acceptance_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Met');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `acceptance_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Tolerance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `adjustment_made` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Made');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `adjustment_performed` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Performed');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `calibration_curve_r_squared` SET TAGS ('dbx_business_glossary_term' = 'Calibration Curve R Squared');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval Days');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `continuing_calibration_verification_pct` SET TAGS ('dbx_business_glossary_term' = 'Continuing Calibration Verification Pct');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `deviation_from_standard` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Standard');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `deviation_pct` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `initial_calibration_verification_pct` SET TAGS ('dbx_business_glossary_term' = 'Initial Calibration Verification Pct');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `intercept` SET TAGS ('dbx_business_glossary_term' = 'Intercept');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `is_passed` SET TAGS ('dbx_business_glossary_term' = 'Passed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `measured_value_after` SET TAGS ('dbx_business_glossary_term' = 'Post-Calibration Reading');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `measured_value_before` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Reading');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `method_reference` SET TAGS ('dbx_business_glossary_term' = 'Method Reference');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `number_of_calibration_points` SET TAGS ('dbx_business_glossary_term' = 'Number Of Calibration Points');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `number_of_standards` SET TAGS ('dbx_business_glossary_term' = 'Number of Standards');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `parameter_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameter Measured');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `post_calibration_response` SET TAGS ('dbx_business_glossary_term' = 'Post Calibration Response');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `pre_calibration_response` SET TAGS ('dbx_business_glossary_term' = 'Pre Calibration Response');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `quality_instrument_calibration_id` SET TAGS ('dbx_business_glossary_term' = 'Link to canonical SSOT record in quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `quality_instrument_calibration_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `quality_instrument_calibration_id` SET TAGS ('dbx_ssot_link' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `r_squared` SET TAGS ('dbx_business_glossary_term' = 'R Squared');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `r_squared_acceptance_limit` SET TAGS ('dbx_business_glossary_term' = 'R Squared Acceptance Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `slope` SET TAGS ('dbx_business_glossary_term' = 'Slope');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_ssot_discriminator' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_canonical' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'quality.quality_instrument_calibration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `standard_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `standard_value` SET TAGS ('dbx_business_glossary_term' = 'Standard Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `standard_vendor` SET TAGS ('dbx_business_glossary_term' = 'Standard Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_cites' = 'OSHA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_tier' = 'mvm');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Instrument Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Reviewer Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Reviewer Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Batch Completion Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_preparation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Batch Preparation Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_review_datetime` SET TAGS ('dbx_business_glossary_term' = 'Batch Review Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch Size');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'preparation_batch|analytical_batch|extraction_batch|digestion_batch|calibration_batch|validation_batch');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `duplicate_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Sample Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `duplicate_acceptance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `duplicate_relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Sample Relative Percent Difference (RPD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `duplicate_sample_included` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Sample Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `field_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Field Sample Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lcs_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Control Sample (LCS) Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lcs_acceptance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lcs_expected_value` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Control Sample (LCS) Expected Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lcs_included` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Control Sample (LCS) Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lcs_measured_value` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Control Sample (LCS) Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lcs_percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Control Sample (LCS) Percent Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lims_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Batch Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `lims_batch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `matrix_spike_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike (MS) Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `matrix_spike_acceptance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `matrix_spike_duplicate_included` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike Duplicate (MSD) Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `matrix_spike_included` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike (MS) Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `matrix_spike_percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike (MS) Percent Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `method_blank_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Method Blank Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `method_blank_acceptance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `method_blank_included` SET TAGS ('dbx_business_glossary_term' = 'Method Blank Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `method_blank_result` SET TAGS ('dbx_business_glossary_term' = 'Method Blank Result Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `msd_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike Duplicate (MSD) Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `msd_acceptance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `msd_percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike Duplicate (MSD) Percent Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `msd_relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Matrix Spike Duplicate (MSD) Relative Percent Difference (RPD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `overall_batch_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Batch Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `overall_batch_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditional|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `qc_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `surrogate_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Standard Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `surrogate_acceptance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `surrogate_included` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Standard Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ALTER COLUMN `surrogate_percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Surrogate Standard Percent Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `qc_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `expected_concentration` SET TAGS ('dbx_business_glossary_term' = 'Expected Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `lims_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Sample Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `lower_acceptance_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Acceptance Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `measured_concentration` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `native_concentration` SET TAGS ('dbx_business_glossary_term' = 'Native Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Percent Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `proficiency_test_flag` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `proficiency_test_provider` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test Provider');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `qc_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `qc_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|pending_review|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Relative Percent Difference (RPD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `reporting_limit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Limit (RL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `spike_concentration` SET TAGS ('dbx_business_glossary_term' = 'Spike Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_sample` ALTER COLUMN `upper_acceptance_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Acceptance Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_subdomain' = 'accreditation_credentialing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `primary_certified_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `primary_certified_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `primary_certified_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_first_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst First Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_last_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Last Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_middle_initial` SET TAGS ('dbx_business_glossary_term' = 'Analyst Middle Initial');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_middle_initial` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `analyst_middle_initial` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|advanced|master');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|inactive');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'state_drinking_water|wastewater_operator|nelac_signatory|laboratory_director|quality_assurance|specialty_method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `email_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `instrument_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Instrument Qualifications');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `laboratory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `last_proficiency_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Proficiency Test Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `lims_user_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) User ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `lims_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `lims_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `proficiency_testing_status` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `proficiency_testing_status` SET TAGS ('dbx_value_regex' = 'current|overdue|failed|not_required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `quality_control_role` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Role');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `quality_control_role` SET TAGS ('dbx_value_regex' = 'analyst|reviewer|qa_officer|technical_director|none');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `safety_training_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|on_call');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `signatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ALTER COLUMN `specialty_areas` SET TAGS ('dbx_business_glossary_term' = 'Specialty Areas');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_subdomain' = 'accreditation_credentialing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `lab_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_document_url` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending|provisional');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_value_regex' = 'state_primacy|nelac_tni|a2la|dod_elap|iso_17025|other');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `conditions_or_deficiencies_noted` SET TAGS ('dbx_business_glossary_term' = 'Conditions or Deficiencies Noted');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `initial_accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Accreditation Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `proficiency_test_id` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test (PT) ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test (PT) Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `proficiency_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `proficiency_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `proficiency_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `pt_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test (PT) Provider ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test (PT) Provider ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `accreditation_field` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Field');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `accreditation_impact` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Impact');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `accreditation_impact` SET TAGS ('dbx_value_regex' = 'none|warning|suspension_risk|revocation_risk');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `assigned_value` SET TAGS ('dbx_business_glossary_term' = 'Assigned Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `peer_group_mean` SET TAGS ('dbx_business_glossary_term' = 'Peer Group Mean');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `peer_group_standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Peer Group Standard Deviation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `percentile_rank` SET TAGS ('dbx_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `pt_round` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test (PT) Round');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `pt_study_name` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test (PT) Study Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `report_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Report Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `reported_value` SET TAGS ('dbx_business_glossary_term' = 'Reported Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|acceptable|unacceptable|warning|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `sample_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `result_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Result Validation ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `result_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `result_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `result_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `calibration_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Verification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `chain_of_custody_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `data_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Release Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `flags_raised_count` SET TAGS ('dbx_business_glossary_term' = 'Flags Raised Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `holding_time_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `method_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Method Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `qc_acceptance_criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Acceptance Criteria Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `qualifiers_applied` SET TAGS ('dbx_business_glossary_term' = 'Qualifiers Applied');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `regulatory_defensibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Defensibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `results_rejected_count` SET TAGS ('dbx_business_glossary_term' = 'Results Rejected Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_criteria_applied` SET TAGS ('dbx_business_glossary_term' = 'Validation Criteria Applied');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_disposition` SET TAGS ('dbx_business_glossary_term' = 'Validation Disposition');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_disposition` SET TAGS ('dbx_value_regex' = 'accepted|qualified|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Validation Duration Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_findings` SET TAGS ('dbx_business_glossary_term' = 'Validation Findings');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_level` SET TAGS ('dbx_business_glossary_term' = 'Validation Level');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_level` SET TAGS ('dbx_value_regex' = 'Level I|Level II|Level III|Level IV');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|on_hold');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validator_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Validator Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `validator_name` SET TAGS ('dbx_business_glossary_term' = 'Validator Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reagent_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Standard Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `associated_test_methods` SET TAGS ('dbx_business_glossary_term' = 'Associated Test Methods');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `catalog_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `certified_reference_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Reference Material (CRM) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `concentration_value` SET TAGS ('dbx_business_glossary_term' = 'Concentration Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `current_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reagent_name` SET TAGS ('dbx_business_glossary_term' = 'Reagent Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reagent_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Reagent Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reagent_standard_status` SET TAGS ('dbx_value_regex' = 'active|expired|depleted|quarantined|disposed');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reagent_type` SET TAGS ('dbx_business_glossary_term' = 'Reagent Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reagent_type` SET TAGS ('dbx_value_regex' = 'reagent|standard|reference_material|buffer|indicator|solvent');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `reorder_threshold` SET TAGS ('dbx_business_glossary_term' = 'Reorder Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `safety_data_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `stock_unit` SET TAGS ('dbx_business_glossary_term' = 'Stock Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `stock_unit` SET TAGS ('dbx_value_regex' = 'ml|l|g|kg|units|vials');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|dark|inert_atmosphere');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `action_level_value` SET TAGS ('dbx_business_glossary_term' = 'Action Level Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_group` SET TAGS ('dbx_business_glossary_term' = 'Analyte Group');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_group` SET TAGS ('dbx_value_regex' = 'inorganic|organic|microbiological|radiological|physical|emerging_contaminant');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_status` SET TAGS ('dbx_business_glossary_term' = 'Analyte Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending_approval|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `astm_method_code` SET TAGS ('dbx_business_glossary_term' = 'American Society for Testing and Materials (ASTM) Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_category` SET TAGS ('dbx_business_glossary_term' = 'Analyte Category');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `certified_analyst_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Analyst Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_code` SET TAGS ('dbx_business_glossary_term' = 'Analyte Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `default_reporting_unit` SET TAGS ('dbx_business_glossary_term' = 'Default Reporting Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `epa_method_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `health_effect` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `health_effect` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `health_effect` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Holding Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `lims_integration_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Integration Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `minimum_sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Minimum Sample Volume (Milliliters)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `monitoring_location_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `analyte_name` SET TAGS ('dbx_business_glossary_term' = 'Analyte Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyte Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `proficiency_testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `qaqc_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `quantitation_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Quantitation Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `sample_matrix_applicability` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `seasonal_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `source_of_contamination` SET TAGS ('dbx_business_glossary_term' = 'Source of Contamination');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `standard_method_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Methods Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ALTER COLUMN `treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_canonical' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_canonical_ref' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_dependent' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_duplicate_of' = 'quality.quality_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_pair' = 'quality.quality_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_reference' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for laboratory_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Analyte Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Test Method Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_assigned_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_assigned_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_assigned_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_initiated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_initiated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_verified_by_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `proficiency_test_id` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `qc_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Batch Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `accreditation_body_notified` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body Notified');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `affected_results_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Results Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `affected_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Sample Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `corrective_action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `effectiveness_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Evaluation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `impact_on_results` SET TAGS ('dbx_business_glossary_term' = 'Impact on Results');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `is_accreditation_impact` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Impact');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_canonical_compliance_corrective_action_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `laboratory_compliance_corrective_action_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `preventive_measure` SET TAGS ('dbx_business_glossary_term' = 'Preventive Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `required_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Required Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_ssot_discriminator' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_canonical' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'compliance.compliance_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `method_detection_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Study ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `acceptance_criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `accreditation_field` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Field of Testing (FOT)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `analyst_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Analyst Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `calculated_mdl` SET TAGS ('dbx_business_glossary_term' = 'Calculated Method Detection Limit (MDL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `calculated_mrl` SET TAGS ('dbx_business_glossary_term' = 'Calculated Minimum Reporting Level (MRL)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `lims_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Integration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `lims_mdl_code` SET TAGS ('dbx_business_glossary_term' = 'LIMS MDL Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `mdl_unit` SET TAGS ('dbx_business_glossary_term' = 'MDL Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `mdl_unit` SET TAGS ('dbx_value_regex' = 'mg/L|ug/L|ng/L|ppm|ppb|ppt');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `mean_recovery` SET TAGS ('dbx_business_glossary_term' = 'Mean Recovery Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `next_study_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next MDL Study Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `previous_mdl_value` SET TAGS ('dbx_business_glossary_term' = 'Previous MDL Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `previous_mrl_value` SET TAGS ('dbx_business_glossary_term' = 'Previous MRL Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_value_regex' = 'SDWA|CWA|NPDES|state_primacy');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `relative_standard_deviation_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Standard Deviation (RSD) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `replicate_count` SET TAGS ('dbx_business_glossary_term' = 'Replicate Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_value_regex' = 'drinking_water|wastewater|surface_water|groundwater|biosolids|sludge');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `spike_concentration` SET TAGS ('dbx_business_glossary_term' = 'Spike Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `spike_concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Spike Concentration Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `spike_concentration_unit` SET TAGS ('dbx_value_regex' = 'mg/L|ug/L|ng/L|ppm|ppb|ppt');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `study_date` SET TAGS ('dbx_business_glossary_term' = 'MDL Study Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `study_notes` SET TAGS ('dbx_business_glossary_term' = 'MDL Study Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `study_reason` SET TAGS ('dbx_business_glossary_term' = 'MDL Study Reason');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `study_reason` SET TAGS ('dbx_value_regex' = 'annual_renewal|method_change|instrument_change|matrix_change|regulatory_requirement|quality_issue');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'MDL Study Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|expired');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `t_value` SET TAGS ('dbx_business_glossary_term' = 'Students t-Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `lab_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `analysis_count` SET TAGS ('dbx_business_glossary_term' = 'Analysis Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `assigned_analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `assigned_analyst_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `compliance_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `data_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Release Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `holding_time_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Compliant Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `lims_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Batch ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Order Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|standard|high|urgent|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `qaqc_protocol` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requested_analyte_list` SET TAGS ('dbx_business_glossary_term' = 'Requested Analyte List');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requested_test_method_list` SET TAGS ('dbx_business_glossary_term' = 'Requested Test Method List');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requesting_entity` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requesting_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requesting_entity_type` SET TAGS ('dbx_value_regex' = 'internal_operations|compliance_team|external_client|regulatory_agency|research_partner');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `required_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Turnaround Time (TAT) Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_value_regex' = 'received|in_progress|pending_review|completed|invoiced|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'compliance|operational|research|external_client|emergency|routine');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for certificate_of_analysis');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certificate_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Analyst Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `lab_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `revised_certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Certificate Of Analysis Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `revised_certificate_of_analysis_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `all_results_compliant` SET TAGS ('dbx_business_glossary_term' = 'All Results Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `client_name` SET TAGS ('dbx_business_glossary_term' = 'Client Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `client_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `client_project_number` SET TAGS ('dbx_business_glossary_term' = 'Client Project Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `coa_version` SET TAGS ('dbx_business_glossary_term' = 'Coa Version');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `has_exceedances` SET TAGS ('dbx_business_glossary_term' = 'Has Exceedances');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `has_qualifiers` SET TAGS ('dbx_business_glossary_term' = 'Has Qualifiers');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `is_revised` SET TAGS ('dbx_business_glossary_term' = 'Is Revised');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `laboratory_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `laboratory_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `overall_result_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Result Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `report_narrative` SET TAGS ('dbx_business_glossary_term' = 'Report Narrative');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `total_analytes_tested` SET TAGS ('dbx_business_glossary_term' = 'Total Analytes Tested');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `total_exceedances` SET TAGS ('dbx_business_glossary_term' = 'Total Exceedances');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_subdomain' = 'accreditation_credentialing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_association_edges' = 'laboratory.certified_analyst,laboratory.test_method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `analyst_method_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Method Qualification ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Method Qualification - Certified Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Supervisor Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Method Qualification - Test Method Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `approved_test_methods` SET TAGS ('dbx_business_glossary_term' = 'Approved Test Methods');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `demonstration_of_capability_date` SET TAGS ('dbx_business_glossary_term' = 'Demonstration of Capability Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `initial_training_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Training Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `last_proficiency_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Proficiency Test Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `proficiency_test_status` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `signatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ALTER COLUMN `supervisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_association_edges' = 'laboratory.sampling_plan,laboratory.analyte');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `plan_analyte_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Analyte Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Analyte Requirement - Analyte Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Analyte Requirement - Sampling Plan Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `analyte_list` SET TAGS ('dbx_business_glossary_term' = 'Analyte List');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `compliance_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `compliance_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `minimum_sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Minimum Sample Volume');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `plan_analyte_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `qaqc_protocol` SET TAGS ('dbx_business_glossary_term' = 'QA/QC Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `required_detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Required Detection Limit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`plan_analyte_requirement` ALTER COLUMN `test_method_list` SET TAGS ('dbx_business_glossary_term' = 'Test Method List');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_subdomain' = 'accreditation_credentialing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_association_edges' = 'laboratory.lab_accreditation,compliance.regulatory_agency');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `lab_accreditation_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Accreditation Grant - Lab Accreditation Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `lab_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Accreditation Grant - Lab Accreditation Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Accreditation Grant - Regulatory Agency Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cost');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_document_url` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accredited_analyte_count` SET TAGS ('dbx_business_glossary_term' = 'Accredited Analyte Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accredited_matrix_list` SET TAGS ('dbx_business_glossary_term' = 'Accredited Matrix List');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accredited_method_list` SET TAGS ('dbx_business_glossary_term' = 'Accredited Method List');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `accrediting_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Organization Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `assessment_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `certificate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `conditions_or_deficiencies_noted` SET TAGS ('dbx_business_glossary_term' = 'Conditions or Deficiencies');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `current_certificate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Current Certificate Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `current_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Current Certificate Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `initial_accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Accreditation Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `last_onsite_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last On-Site Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `last_proficiency_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Proficiency Test Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `proficiency_test_pass_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Test Pass Rate (Percent)');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Provider');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `regulatory_defensibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Defensibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ALTER COLUMN `renewal_notification_days_prior` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Days Prior');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_association_edges' = 'laboratory.test_method,supply.material_master');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `method_material_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Method Material Usage ID');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Method Material Usage - Material Master Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Material Usage - Test Method Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `alternative_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Material Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `consumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Consumption Rate');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `consumption_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Consumption Rate Unit');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `cost_per_test` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Test');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Material Criticality');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `material_role` SET TAGS ('dbx_business_glossary_term' = 'Material Role');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `quantity_per_test` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Test');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_subdomain' = 'accreditation_credentialing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_association_edges' = 'laboratory.certified_analyst,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `analyst_grant_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Grant Allocation - Analyst Grant Allocation Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Grant Allocation - Certified Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Grant Allocation - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `allocation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `allocation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `effort_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `effort_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `grant_account_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `grant_role` SET TAGS ('dbx_business_glossary_term' = 'Grant Role');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `labor_cost_allocation` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Allocation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_subdomain' = 'accreditation_credentialing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_association_edges' = 'laboratory.certified_analyst,workforce.training_course');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `analyst_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Training Completion Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Training Completion - Certified Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Training Completion - Training Course Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `attendance_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Attendance Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `ceu_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'CEU Credits Earned');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `cost_charged` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Charged');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Training Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Instructor Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Training Pass/Fail Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Laboratory Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `calibration_schedule` SET TAGS ('dbx_business_glossary_term' = 'Calibration Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `capacity_daily_tests` SET TAGS ('dbx_business_glossary_term' = 'Capacity Daily Tests');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `instrument_count` SET TAGS ('dbx_business_glossary_term' = 'Instrument Count');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `lab_code` SET TAGS ('dbx_business_glossary_term' = 'Lab Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `lab_type` SET TAGS ('dbx_business_glossary_term' = 'Lab Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `method_catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Method Catalog Version');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `primary_analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Analyst Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `primary_analyst_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `primary_analyst_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `qa_qc_protocol` SET TAGS ('dbx_business_glossary_term' = 'Qa Qc Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `safety_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Level');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Curve Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `certified_analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `reference_calibration_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Calibration Curve Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `reference_calibration_curve_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_equation` SET TAGS ('dbx_business_glossary_term' = 'Calibration Equation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_time` SET TAGS ('dbx_business_glossary_term' = 'Calibration Time');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `curve_code` SET TAGS ('dbx_business_glossary_term' = 'Curve Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `curve_name` SET TAGS ('dbx_business_glossary_term' = 'Curve Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `curve_type` SET TAGS ('dbx_business_glossary_term' = 'Curve Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_curve_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `instrument_model` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `number_of_points` SET TAGS ('dbx_business_glossary_term' = 'Number Of Points');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `r_squared` SET TAGS ('dbx_business_glossary_term' = 'R Squared');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `reference_value` SET TAGS ('dbx_business_glossary_term' = 'Reference Value');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `calibration_curve_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`calibration_curve` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_cites' = 'OSHA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `validation_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Batch Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `parent_validation_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Validation Batch Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `parent_validation_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_code` SET TAGS ('dbx_business_glossary_term' = 'Batch Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_description` SET TAGS ('dbx_business_glossary_term' = 'Batch Description');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_name` SET TAGS ('dbx_business_glossary_term' = 'Batch Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `batch_version` SET TAGS ('dbx_business_glossary_term' = 'Batch Version');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `method_used` SET TAGS ('dbx_business_glossary_term' = 'Method Used');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `validation_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `total_samples` SET TAGS ('dbx_business_glossary_term' = 'Total Samples');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`validation_batch` ALTER COLUMN `validation_result` SET TAGS ('dbx_business_glossary_term' = 'Validation Result');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_mvm_eligible' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_system_of_record' = 'LabWare_LIMS');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `pt_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pt Provider Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `parent_pt_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Pt Provider Id');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `parent_pt_provider_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `accreditation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `daily_capacity_samples` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Samples');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `pt_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Code');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `service_area` SET TAGS ('dbx_business_glossary_term' = 'Service Area');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `specialties` SET TAGS ('dbx_business_glossary_term' = 'Specialties');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `pt_provider_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`pt_provider` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
