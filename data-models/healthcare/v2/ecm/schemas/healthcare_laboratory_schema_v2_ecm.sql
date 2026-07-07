-- Schema for Domain: laboratory | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`laboratory` COMMENT 'Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` (
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory lab order record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory lab order record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory lab order record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the diagnosis icd code within the laboratory lab order record.',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel within the laboratory lab order record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory lab order record.',
    `monitoring_activity_id` BIGINT COMMENT 'Unique identifier for the monitoring activity within the laboratory lab order record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory lab order record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary lab clinician within the laboratory lab order record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the quality measure within the laboratory lab order record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the laboratory lab order record.',
    `tertiary_lab_cancelled_by_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the tertiary lab cancelled by provider clinician within the laboratory lab order record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory lab order record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory lab order record.',
    `authorization_number` STRING COMMENT 'The authorization number of the laboratory lab order record.',
    `authorization_required` BOOLEAN COMMENT 'The authorization required of the laboratory lab order record.',
    `billing_code` STRING COMMENT 'The billing code value classifying the laboratory lab order record.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the laboratory lab order record.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The cancelled timestamp of the laboratory lab order record.',
    `clinical_indication` STRING COMMENT 'The clinical indication of the laboratory lab order record.',
    `collection_date` DATE COMMENT 'Timestamp capturing the collection date associated with the laboratory lab order record.',
    `collection_method` STRING COMMENT 'The collection method of the laboratory lab order record.',
    `collection_timestamp` TIMESTAMP COMMENT 'The collection timestamp of the laboratory lab order record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory lab order record.',
    `diagnosis_code` STRING COMMENT 'The diagnosis code value classifying the laboratory lab order record.',
    `expected_turnaround_time_hours` STRING COMMENT 'The expected turnaround time hours of the laboratory lab order record.',
    `fasting_required` BOOLEAN COMMENT 'The fasting required of the laboratory lab order record.',
    `is_send_out` BOOLEAN COMMENT 'Boolean flag indicating the is send out status of the laboratory lab order record.',
    `order_date` DATE COMMENT 'Timestamp capturing the order date associated with the laboratory lab order record.',
    `order_number` STRING COMMENT 'The order number of the laboratory lab order record.',
    `order_priority` STRING COMMENT 'The order priority of the laboratory lab order record.',
    `order_set_name` STRING COMMENT 'The order set name of the laboratory lab order record.',
    `order_status` STRING COMMENT 'The order status value classifying the laboratory lab order record.',
    `order_timestamp` TIMESTAMP COMMENT 'The order timestamp of the laboratory lab order record.',
    `performing_lab_location` STRING COMMENT 'The performing lab location of the laboratory lab order record.',
    `point_of_care_test` BOOLEAN COMMENT 'The point of care test of the laboratory lab order record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory lab order record.',
    `reference_lab_accession_number` STRING COMMENT 'The reference lab accession number of the laboratory lab order record.',
    `reference_lab_name` STRING COMMENT 'The reference lab name of the laboratory lab order record.',
    `result_integration_status` STRING COMMENT 'The result integration status value classifying the laboratory lab order record.',
    `result_received_timestamp` TIMESTAMP COMMENT 'The result received timestamp of the laboratory lab order record.',
    `shipping_carrier` STRING COMMENT 'The shipping carrier of the laboratory lab order record.',
    `shipping_tracking_number` STRING COMMENT 'The shipping tracking number of the laboratory lab order record.',
    `source_system_order_number` STRING COMMENT 'The source system order number of the laboratory lab order record.',
    `specimen_shipped_timestamp` TIMESTAMP COMMENT 'The specimen shipped timestamp of the laboratory lab order record.',
    `specimen_source` STRING COMMENT 'The specimen source of the laboratory lab order record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory lab order record.',
    `standing_order` BOOLEAN COMMENT 'The standing order of the laboratory lab order record.',
    `lab_order_status` STRING COMMENT 'The lab order status value classifying the laboratory lab order record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory lab order record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory lab order record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory lab order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_lab_order PRIMARY KEY(`lab_order_id`)
) COMMENT 'Core transactional record of every laboratory test order placed via CPOE (Computerized Physician Order Entry) in Epic Beaker or Cerner PathNet, including orders routed to external reference laboratories (send-outs). Captures the ordering provider, ordering encounter, ordered test (LOINC code from test catalog), order priority (STAT, routine, ASAP, timed), order status lifecycle (ordered, collected, in-process, sent-out, resulted, cancelled), clinical indication, order date/time, source system identifiers. For send-out orders: reference lab name, reference lab accession number, specimen shipping date/time, shipping carrier and tracking, expected turnaround time, result receipt date/time, and result integration status. SSOT for all lab order identity and lifecycle within the laboratory domain, including both internal and send-out orders.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` (
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory specimen record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory specimen record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory specimen record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the laboratory specimen record.',
    `parent_specimen_id` BIGINT COMMENT 'Unique identifier for the parent specimen within the laboratory specimen record.',
    `scheduling_appointment_id` BIGINT COMMENT 'Unique identifier for the scheduling appointment within the laboratory specimen record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the specimen collected by employee within the laboratory specimen record.',
    `specimen_employee_id` BIGINT COMMENT 'Unique identifier for the specimen employee within the laboratory specimen record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory specimen record.',
    `accession_datetime` TIMESTAMP COMMENT 'Timestamp capturing the accession datetime associated with the laboratory specimen record.',
    `accession_number` STRING COMMENT 'The accession number of the laboratory specimen record.',
    `accession_status` STRING COMMENT 'The accession status value classifying the laboratory specimen record.',
    `biohazard_level` STRING COMMENT 'The biohazard level of the laboratory specimen record.',
    `body_site` STRING COMMENT 'The body site of the laboratory specimen record.',
    `chain_of_custody_status` STRING COMMENT 'The chain of custody status value classifying the laboratory specimen record.',
    `collection_date` DATE COMMENT 'Timestamp capturing the collection date associated with the laboratory specimen record.',
    `collection_datetime` TIMESTAMP COMMENT 'Timestamp capturing the collection datetime associated with the laboratory specimen record.',
    `collection_duration_minutes` STRING COMMENT 'The collection duration minutes of the laboratory specimen record.',
    `collection_method` STRING COMMENT 'The collection method of the laboratory specimen record.',
    `collection_timestamp` TIMESTAMP COMMENT 'The collection timestamp of the laboratory specimen record.',
    `collector_role` STRING COMMENT 'The collector role of the laboratory specimen record.',
    `comments` STRING COMMENT 'The comments of the laboratory specimen record.',
    `condition_at_receipt` STRING COMMENT 'The condition at receipt of the laboratory specimen record.',
    `container_type` STRING COMMENT 'The container type value classifying the laboratory specimen record.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp capturing the created datetime associated with the laboratory specimen record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory specimen record.',
    `disposal_datetime` TIMESTAMP COMMENT 'Timestamp capturing the disposal datetime associated with the laboratory specimen record.',
    `disposal_method` STRING COMMENT 'The disposal method of the laboratory specimen record.',
    `fasting_flag` BOOLEAN COMMENT 'The fasting flag of the laboratory specimen record.',
    `fasting_status` STRING COMMENT 'The fasting status value classifying the laboratory specimen record.',
    `hemolysis_index` STRING COMMENT 'The hemolysis index of the laboratory specimen record.',
    `number_of_aliquots` STRING COMMENT 'The number of aliquots of the laboratory specimen record.',
    `priority` STRING COMMENT 'The priority of the laboratory specimen record.',
    `received_timestamp` TIMESTAMP COMMENT 'The received timestamp of the laboratory specimen record.',
    `receiving_lab_location` STRING COMMENT 'The receiving lab location of the laboratory specimen record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory specimen record.',
    `rejection_reason` STRING COMMENT 'The rejection reason of the laboratory specimen record.',
    `retention_expiration_date` DATE COMMENT 'Timestamp capturing the retention expiration date associated with the laboratory specimen record.',
    `retention_status` STRING COMMENT 'The retention status value classifying the laboratory specimen record.',
    `source` STRING COMMENT 'The source of the laboratory specimen record.',
    `special_handling_instructions` STRING COMMENT 'The special handling instructions of the laboratory specimen record.',
    `specimen_status` STRING COMMENT 'The specimen status value classifying the laboratory specimen record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory specimen record.',
    `storage_location` STRING COMMENT 'The storage location of the laboratory specimen record.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'The storage temperature c of the laboratory specimen record.',
    `transport_duration_minutes` STRING COMMENT 'The transport duration minutes of the laboratory specimen record.',
    `transport_temperature_c` DECIMAL(18,2) COMMENT 'The transport temperature c of the laboratory specimen record.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp capturing the updated datetime associated with the laboratory specimen record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory specimen record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory specimen record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory specimen record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `volume_collected_ml` DECIMAL(18,2) COMMENT 'The volume collected ml of the laboratory specimen record.',
    `volume_ml` DECIMAL(18,2) COMMENT 'The volume ml of the laboratory specimen record.',
    CONSTRAINT pk_specimen PRIMARY KEY(`specimen_id`)
) COMMENT 'Master record for every biological specimen collected for laboratory testing and the SSOT for specimen identity, accessioning, chain of custody, and full specimen lifecycle. Tracks specimen type (blood, urine, tissue, CSF, swab), collection method, collection date/time, collector identity and role, collection site (body location), container type, volume, accession number (LIS-assigned unique work-unit identifier), accession date/time, accession status (received, processing, resulted, archived), receiving lab location, priority, chain-of-custody status, storage location, specimen condition at receipt, number of aliquots, and disposal/retention status. Consolidates the former accession and specimen collection event concepts — the accession is the specimens operational identity in Epic Beaker and Cerner PathNet. Supports CLIA-compliant specimen tracking from collection through accessioning, testing, and disposal.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the test result within the laboratory test result record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory test result record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory test result record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the diagnosis icd code within the laboratory test result record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory test result record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the laboratory test result record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary test clinician within the laboratory test result record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary test employee within the laboratory test result record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the quality measure within the laboratory test result record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory test result record.',
    `reference_range_id` BIGINT COMMENT 'Unique identifier for the reference range within the laboratory test result record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the laboratory test result record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the result snomed concept within the laboratory test result record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory test result record.',
    `tertiary_test_amending_user_employee_id` BIGINT COMMENT 'Unique identifier for the tertiary test amending user employee within the laboratory test result record.',
    `tertiary_test_ordering_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the tertiary test ordering provider clinician within the laboratory test result record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory test result record.',
    `test_resulting_clinician_id` BIGINT COMMENT 'Unique identifier for the test resulting clinician within the laboratory test result record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory test result record.',
    `abnormal_flag` BOOLEAN COMMENT 'The abnormal flag of the laboratory test result record.',
    `amendment_datetime` TIMESTAMP COMMENT 'Timestamp capturing the amendment datetime associated with the laboratory test result record.',
    `amendment_reason` STRING COMMENT 'The amendment reason of the laboratory test result record.',
    `clia_number` STRING COMMENT 'The clia number of the laboratory test result record.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp capturing the created datetime associated with the laboratory test result record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory test result record.',
    `critical_flag` BOOLEAN COMMENT 'The critical flag of the laboratory test result record.',
    `critical_value_acknowledgment_datetime` TIMESTAMP COMMENT 'Timestamp capturing the critical value acknowledgment datetime associated with the laboratory test result record.',
    `critical_value_alert_generated_datetime` TIMESTAMP COMMENT 'Timestamp capturing the critical value alert generated datetime associated with the laboratory test result record.',
    `critical_value_escalation_action` STRING COMMENT 'The critical value escalation action of the laboratory test result record.',
    `critical_value_notification_datetime` TIMESTAMP COMMENT 'Timestamp capturing the critical value notification datetime associated with the laboratory test result record.',
    `critical_value_notification_method` STRING COMMENT 'The critical value notification method of the laboratory test result record.',
    `critical_value_resolution_note` STRING COMMENT 'The critical value resolution note of the laboratory test result record.',
    `delta_check_flag` BOOLEAN COMMENT 'The delta check flag of the laboratory test result record.',
    `interpretation` STRING COMMENT 'The interpretation of the laboratory test result record.',
    `is_amended` BOOLEAN COMMENT 'Boolean flag indicating the is amended status of the laboratory test result record.',
    `is_critical_value` BOOLEAN COMMENT 'Boolean flag indicating the is critical value status of the laboratory test result record.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Timestamp capturing the last updated datetime associated with the laboratory test result record.',
    `original_result_value_numeric` DECIMAL(18,2) COMMENT 'The original result value numeric of the laboratory test result record.',
    `original_result_value_text` STRING COMMENT 'The original result value text of the laboratory test result record.',
    `performing_lab_facility` STRING COMMENT 'The performing lab facility of the laboratory test result record.',
    `performing_lab_section` STRING COMMENT 'The performing lab section of the laboratory test result record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory test result record.',
    `result_comment` STRING COMMENT 'The result comment of the laboratory test result record.',
    `result_datetime` TIMESTAMP COMMENT 'Timestamp capturing the result datetime associated with the laboratory test result record.',
    `result_interpretation` STRING COMMENT 'The result interpretation of the laboratory test result record.',
    `result_numeric` DECIMAL(18,2) COMMENT 'The result numeric of the laboratory test result record.',
    `result_released_datetime` TIMESTAMP COMMENT 'Timestamp capturing the result released datetime associated with the laboratory test result record.',
    `result_status` STRING COMMENT 'The result status value classifying the laboratory test result record.',
    `result_timestamp` TIMESTAMP COMMENT 'The result timestamp of the laboratory test result record.',
    `result_unit` STRING COMMENT 'The result unit of the laboratory test result record.',
    `result_units` STRING COMMENT 'The result units of the laboratory test result record.',
    `result_value` DECIMAL(18,2) COMMENT 'The result value of the laboratory test result record.',
    `result_value_coded` STRING COMMENT 'The result value coded of the laboratory test result record.',
    `result_value_numeric` DECIMAL(18,2) COMMENT 'The result value numeric of the laboratory test result record.',
    `result_value_text` STRING COMMENT 'The result value text of the laboratory test result record.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'Timestamp capturing the specimen received datetime associated with the laboratory test result record.',
    `test_result_status` STRING COMMENT 'The test result status value classifying the laboratory test result record.',
    `test_code` STRING COMMENT 'The test code value classifying the laboratory test result record.',
    `test_name` STRING COMMENT 'The test name of the laboratory test result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory test result record.',
    `verified_by` STRING COMMENT 'The verified by of the laboratory test result record.',
    `verified_timestamp` TIMESTAMP COMMENT 'The verified timestamp of the laboratory test result record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory test result record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory test result record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Transactional record of every individual laboratory test result produced for a specimen, including result amendments and critical value notifications. Stores LOINC-coded test identifier, result value (numeric, text, coded), result unit of measure, reference range applied, result status lifecycle (preliminary, final, corrected, cancelled), abnormal flag (normal, low, high, critical low, critical high), result date/time, performing lab section, instrument identifier, verifying technologist. Owns the full amendment/correction history: original value, amended value, amendment reason, amending user, amendment timestamp. When a result exceeds critical thresholds, owns the critical value alert lifecycle: alert generation timestamp, notified provider, notification method (phone, secure message, EHR alert), acknowledgment timestamp, acknowledging clinician, escalation actions, and resolution notes. Consolidates the former critical_value_alert and result_amendment concepts. Supports CLIA critical value compliance, Joint Commission NPSG requirements, HIM audit requirements, and downstream clinical decision-making.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` (
    `reference_range_id` BIGINT COMMENT 'Unique identifier for the reference range within the laboratory reference range record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the laboratory reference range record.',
    `age_group` STRING COMMENT 'The age group of the laboratory reference range record.',
    `age_high` STRING COMMENT 'The age high of the laboratory reference range record.',
    `age_low` STRING COMMENT 'The age low of the laboratory reference range record.',
    `alert_priority` STRING COMMENT 'The alert priority of the laboratory reference range record.',
    `alert_trigger_flag` BOOLEAN COMMENT 'The alert trigger flag of the laboratory reference range record.',
    `clinical_significance` STRING COMMENT 'The clinical significance of the laboratory reference range record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory reference range record.',
    `critical_high` DECIMAL(18,2) COMMENT 'The critical high of the laboratory reference range record.',
    `critical_high_threshold` DECIMAL(18,2) COMMENT 'The critical high threshold of the laboratory reference range record.',
    `critical_low` DECIMAL(18,2) COMMENT 'The critical low of the laboratory reference range record.',
    `critical_low_threshold` DECIMAL(18,2) COMMENT 'The critical low threshold of the laboratory reference range record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory reference range record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the laboratory reference range record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the laboratory reference range record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory reference range record.',
    `high_value` DECIMAL(18,2) COMMENT 'The high value of the laboratory reference range record.',
    `instrument_platform` STRING COMMENT 'The instrument platform of the laboratory reference range record.',
    `interpretation_code` STRING COMMENT 'The interpretation code value classifying the laboratory reference range record.',
    `last_review_date` DATE COMMENT 'Timestamp capturing the last review date associated with the laboratory reference range record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory reference range record.',
    `lis_system_code` STRING COMMENT 'The lis system code value classifying the laboratory reference range record.',
    `low_value` DECIMAL(18,2) COMMENT 'The low value of the laboratory reference range record.',
    `lower_normal_limit` DECIMAL(18,2) COMMENT 'The lower normal limit of the laboratory reference range record.',
    `medical_director_override_flag` BOOLEAN COMMENT 'The medical director override flag of the laboratory reference range record.',
    `methodology` STRING COMMENT 'The methodology of the laboratory reference range record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the laboratory reference range record.',
    `notes` STRING COMMENT 'The notes of the laboratory reference range record.',
    `override_justification` STRING COMMENT 'The override justification of the laboratory reference range record.',
    `population_basis` STRING COMMENT 'The population basis of the laboratory reference range record.',
    `pregnancy_status` STRING COMMENT 'The pregnancy status value classifying the laboratory reference range record.',
    `race_ethnicity` STRING COMMENT 'The race ethnicity of the laboratory reference range record.',
    `range_name` STRING COMMENT 'The range name of the laboratory reference range record.',
    `range_status` STRING COMMENT 'The range status value classifying the laboratory reference range record.',
    `review_status` STRING COMMENT 'The review status value classifying the laboratory reference range record.',
    `sample_size` STRING COMMENT 'The sample size of the laboratory reference range record.',
    `sex` STRING COMMENT 'The sex of the laboratory reference range record.',
    `source_citation` STRING COMMENT 'The source citation of the laboratory reference range record.',
    `source_type` STRING COMMENT 'The source type value classifying the laboratory reference range record.',
    `statistical_method` STRING COMMENT 'The statistical method of the laboratory reference range record.',
    `reference_range_status` STRING COMMENT 'The reference range status value classifying the laboratory reference range record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the laboratory reference range record.',
    `units` STRING COMMENT 'The units of the laboratory reference range record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory reference range record.',
    `upper_normal_limit` DECIMAL(18,2) COMMENT 'The upper normal limit of the laboratory reference range record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory reference range record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory reference range record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_reference_range PRIMARY KEY(`reference_range_id`)
) COMMENT 'Reference data defining normal, abnormal, and critical value thresholds for each laboratory test, stratified by patient demographics (age group, sex, pregnancy status, race/ethnicity where clinically validated) and specimen type. Includes lower and upper normal limits, critical low and critical high thresholds, panic value definitions, unit of measure, effective date range, and the authoritative source (CAP, CLIA, manufacturer insert, institutional medical director override). Used by result interpretation logic to assign abnormal flags and trigger critical value alerts in test_result. Supports CLIA-required documentation of reference range sources and periodic review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` (
    `pathology_report_id` BIGINT COMMENT 'Unique identifier for the pathology report within the laboratory pathology report record.',
    `cda_document_id` BIGINT COMMENT 'Unique identifier for the cda document within the laboratory pathology report record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory pathology report record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory pathology report record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the diagnosis icd code within the laboratory pathology report record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory pathology report record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory pathology report record.',
    `phi_access_log_id` BIGINT COMMENT 'Unique identifier for the phi access log within the laboratory pathology report record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary pathology clinician within the laboratory pathology report record.',
    `quality_peer_review_id` BIGINT COMMENT 'Unique identifier for the quality peer review within the laboratory pathology report record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory pathology report record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the laboratory pathology report record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the snomed concept within the laboratory pathology report record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory pathology report record.',
    `surgical_case_id` BIGINT COMMENT 'Unique identifier for the surgical case within the laboratory pathology report record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory pathology report record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory pathology report record.',
    `accession_number` STRING COMMENT 'The accession number of the laboratory pathology report record.',
    `addendum_history` STRING COMMENT 'The addendum history of the laboratory pathology report record.',
    `amended_timestamp` TIMESTAMP COMMENT 'The amended timestamp of the laboratory pathology report record.',
    `amendment_reason` STRING COMMENT 'The amendment reason of the laboratory pathology report record.',
    `cancer_registry_reportable_flag` BOOLEAN COMMENT 'The cancer registry reportable flag of the laboratory pathology report record.',
    `case_number` STRING COMMENT 'The case number of the laboratory pathology report record.',
    `clia_number` STRING COMMENT 'The clia number of the laboratory pathology report record.',
    `comment` STRING COMMENT 'The comment of the laboratory pathology report record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory pathology report record.',
    `critical_value_flag` BOOLEAN COMMENT 'The critical value flag of the laboratory pathology report record.',
    `critical_value_notification_timestamp` TIMESTAMP COMMENT 'The critical value notification timestamp of the laboratory pathology report record.',
    `final_diagnosis` STRING COMMENT 'The final diagnosis of the laboratory pathology report record.',
    `gross_description` STRING COMMENT 'The gross description of the laboratory pathology report record.',
    `histologic_grade` STRING COMMENT 'The histologic grade of the laboratory pathology report record.',
    `histologic_type` STRING COMMENT 'The histologic type value classifying the laboratory pathology report record.',
    `immunohistochemistry_results` STRING COMMENT 'The immunohistochemistry results of the laboratory pathology report record.',
    `lymph_nodes_examined` STRING COMMENT 'The lymph nodes examined of the laboratory pathology report record.',
    `lymph_nodes_positive` STRING COMMENT 'The lymph nodes positive of the laboratory pathology report record.',
    `margin_status` STRING COMMENT 'The margin status value classifying the laboratory pathology report record.',
    `microscopic_description` STRING COMMENT 'The microscopic description of the laboratory pathology report record.',
    `molecular_testing_results` STRING COMMENT 'The molecular testing results of the laboratory pathology report record.',
    `performing_laboratory` STRING COMMENT 'The performing laboratory of the laboratory pathology report record.',
    `preliminary_report_timestamp` TIMESTAMP COMMENT 'The preliminary report timestamp of the laboratory pathology report record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the laboratory pathology report record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory pathology report record.',
    `report_status` STRING COMMENT 'The report status value classifying the laboratory pathology report record.',
    `report_type` STRING COMMENT 'The report type value classifying the laboratory pathology report record.',
    `sign_out_timestamp` TIMESTAMP COMMENT 'The sign out timestamp of the laboratory pathology report record.',
    `special_stains_performed` STRING COMMENT 'The special stains performed of the laboratory pathology report record.',
    `pathology_report_status` STRING COMMENT 'The pathology report status value classifying the laboratory pathology report record.',
    `synoptic_report_elements` STRING COMMENT 'The synoptic report elements of the laboratory pathology report record.',
    `tnm_stage` STRING COMMENT 'The tnm stage of the laboratory pathology report record.',
    `tumor_board_reviewed_flag` BOOLEAN COMMENT 'The tumor board reviewed flag of the laboratory pathology report record.',
    `tumor_site` STRING COMMENT 'The tumor site of the laboratory pathology report record.',
    `tumor_size_cm` DECIMAL(18,2) COMMENT 'The tumor size cm of the laboratory pathology report record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory pathology report record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory pathology report record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory pathology report record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_pathology_report PRIMARY KEY(`pathology_report_id`)
) COMMENT 'Master record for surgical pathology and cytology reports generated by pathologists. Includes case number, specimen source, gross description, microscopic description, final diagnosis (ICD-10 coded), synoptic reporting elements (CAP cancer protocols), pathologist of record, sign-out date/time, report status (preliminary, final, amended), and addendum history. Supports oncology care coordination, tumor board workflows, and cancer registry reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` (
    `microbiology_culture_id` BIGINT COMMENT 'Unique identifier for the microbiology culture within the laboratory microbiology culture record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the laboratory microbiology culture record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the laboratory microbiology culture record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory microbiology culture record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory microbiology culture record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the diagnosis icd code within the laboratory microbiology culture record.',
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory microbiology culture record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory microbiology culture record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory microbiology culture record.',
    `message_log_id` BIGINT COMMENT 'Unique identifier for the message log within the laboratory microbiology culture record.',
    `organism_id` BIGINT COMMENT 'Unique identifier for the organism within the laboratory microbiology culture record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the organism snomed concept within the laboratory microbiology culture record.',
    `osha_exposure_incident_id` BIGINT COMMENT 'Unique identifier for the osha exposure incident within the laboratory microbiology culture record.',
    `patient_safety_event_id` BIGINT COMMENT 'Unique identifier for the patient safety event within the laboratory microbiology culture record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory microbiology culture record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary microbiology employee within the laboratory microbiology culture record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory microbiology culture record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the laboratory microbiology culture record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory microbiology culture record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory microbiology culture record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory microbiology culture record.',
    `accession_number` STRING COMMENT 'The accession number of the laboratory microbiology culture record.',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'The antibiotic stewardship flag of the laboratory microbiology culture record.',
    `collection_datetime` TIMESTAMP COMMENT 'Timestamp capturing the collection datetime associated with the laboratory microbiology culture record.',
    `colony_count` BIGINT COMMENT 'The colony count of the laboratory microbiology culture record.',
    `colony_count_unit` STRING COMMENT 'The colony count unit of the laboratory microbiology culture record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory microbiology culture record.',
    `critical_value_flag` BOOLEAN COMMENT 'The critical value flag of the laboratory microbiology culture record.',
    `critical_value_notified_datetime` TIMESTAMP COMMENT 'Timestamp capturing the critical value notified datetime associated with the laboratory microbiology culture record.',
    `culture_status` STRING COMMENT 'The culture status value classifying the laboratory microbiology culture record.',
    `culture_type` STRING COMMENT 'The culture type value classifying the laboratory microbiology culture record.',
    `gram_stain_result` STRING COMMENT 'The gram stain result of the laboratory microbiology culture record.',
    `growth_result` STRING COMMENT 'The growth result of the laboratory microbiology culture record.',
    `hai_associated_flag` BOOLEAN COMMENT 'The hai associated flag of the laboratory microbiology culture record.',
    `hai_event_type` STRING COMMENT 'The hai event type value classifying the laboratory microbiology culture record.',
    `incubation_start_datetime` TIMESTAMP COMMENT 'Timestamp capturing the incubation start datetime associated with the laboratory microbiology culture record.',
    `infection_control_notified_flag` BOOLEAN COMMENT 'The infection control notified flag of the laboratory microbiology culture record.',
    `isolation_datetime` TIMESTAMP COMMENT 'Timestamp capturing the isolation datetime associated with the laboratory microbiology culture record.',
    `mdro_flag` BOOLEAN COMMENT 'The mdro flag of the laboratory microbiology culture record.',
    `mdro_type` STRING COMMENT 'The mdro type value classifying the laboratory microbiology culture record.',
    `morphology` STRING COMMENT 'The morphology of the laboratory microbiology culture record.',
    `public_health_reportable_flag` BOOLEAN COMMENT 'The public health reportable flag of the laboratory microbiology culture record.',
    `quality_control_passed_flag` BOOLEAN COMMENT 'The quality control passed flag of the laboratory microbiology culture record.',
    `received_datetime` TIMESTAMP COMMENT 'Timestamp capturing the received datetime associated with the laboratory microbiology culture record.',
    `result_comments` STRING COMMENT 'The result comments of the laboratory microbiology culture record.',
    `result_datetime` TIMESTAMP COMMENT 'Timestamp capturing the result datetime associated with the laboratory microbiology culture record.',
    `result_interpretation` STRING COMMENT 'The result interpretation of the laboratory microbiology culture record.',
    `specimen_source_code` STRING COMMENT 'The specimen source code value classifying the laboratory microbiology culture record.',
    `microbiology_culture_status` STRING COMMENT 'The microbiology culture status value classifying the laboratory microbiology culture record.',
    `susceptibility_method` STRING COMMENT 'The susceptibility method of the laboratory microbiology culture record.',
    `susceptibility_panel_performed` BOOLEAN COMMENT 'The susceptibility panel performed of the laboratory microbiology culture record.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'The turnaround time hours of the laboratory microbiology culture record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory microbiology culture record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory microbiology culture record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory microbiology culture record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_microbiology_culture PRIMARY KEY(`microbiology_culture_id`)
) COMMENT 'Transactional record for microbiology culture and sensitivity (C&S) testing. Tracks organism identification (SNOMED CT coded), culture type (aerobic, anaerobic, fungal, AFB, viral), growth result, colony count, isolation date/time, and the associated antimicrobial susceptibility panel. Supports infection control surveillance, antibiotic stewardship programs, and HAI (Healthcare-Associated Infection) reporting including CLABSI and CAUTI tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` (
    `susceptibility_result_id` BIGINT COMMENT 'Unique identifier for the susceptibility result within the laboratory susceptibility result record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the laboratory susceptibility result record.',
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory susceptibility result record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory susceptibility result record.',
    `microbiology_culture_id` BIGINT COMMENT 'Unique identifier for the microbiology culture within the laboratory susceptibility result record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the laboratory susceptibility result record.',
    `organism_id` BIGINT COMMENT 'Unique identifier for the organism within the laboratory susceptibility result record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory susceptibility result record.',
    `antibiotic_agent_code` STRING COMMENT 'The antibiotic agent code value classifying the laboratory susceptibility result record.',
    `antibiotic_agent_name` STRING COMMENT 'The antibiotic agent name of the laboratory susceptibility result record.',
    `antibiotic_class` STRING COMMENT 'The antibiotic class of the laboratory susceptibility result record.',
    `antibiotic_name` STRING COMMENT 'The antibiotic name of the laboratory susceptibility result record.',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'The antibiotic stewardship flag of the laboratory susceptibility result record.',
    `clsi_breakpoint_version` STRING COMMENT 'The clsi breakpoint version of the laboratory susceptibility result record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory susceptibility result record.',
    `disk_diffusion_zone_diameter_mm` DECIMAL(18,2) COMMENT 'The disk diffusion zone diameter mm of the laboratory susceptibility result record.',
    `inducible_resistance_flag` BOOLEAN COMMENT 'The inducible resistance flag of the laboratory susceptibility result record.',
    `infection_control_alert_flag` BOOLEAN COMMENT 'The infection control alert flag of the laboratory susceptibility result record.',
    `interpretation` STRING COMMENT 'The interpretation of the laboratory susceptibility result record.',
    `loinc_code` STRING COMMENT 'The loinc code value classifying the laboratory susceptibility result record.',
    `method` STRING COMMENT 'The method of the laboratory susceptibility result record.',
    `mic_operator` STRING COMMENT 'The mic operator of the laboratory susceptibility result record.',
    `mic_unit` STRING COMMENT 'The mic unit of the laboratory susceptibility result record.',
    `mic_value` DECIMAL(18,2) COMMENT 'The mic value of the laboratory susceptibility result record.',
    `panel_code` STRING COMMENT 'The panel code value classifying the laboratory susceptibility result record.',
    `panel_name` STRING COMMENT 'The panel name of the laboratory susceptibility result record.',
    `performing_lab_code` STRING COMMENT 'The performing lab code value classifying the laboratory susceptibility result record.',
    `performing_lab_name` STRING COMMENT 'The performing lab name of the laboratory susceptibility result record.',
    `quality_control_status` STRING COMMENT 'The quality control status value classifying the laboratory susceptibility result record.',
    `reportable_to_public_health_flag` BOOLEAN COMMENT 'The reportable to public health flag of the laboratory susceptibility result record.',
    `resistance_flag` BOOLEAN COMMENT 'The resistance flag of the laboratory susceptibility result record.',
    `resistance_gene` STRING COMMENT 'The resistance gene of the laboratory susceptibility result record.',
    `resistance_mechanism` STRING COMMENT 'The resistance mechanism of the laboratory susceptibility result record.',
    `resistant_breakpoint` DECIMAL(18,2) COMMENT 'The resistant breakpoint of the laboratory susceptibility result record.',
    `result_comment` STRING COMMENT 'The result comment of the laboratory susceptibility result record.',
    `result_status` STRING COMMENT 'The result status value classifying the laboratory susceptibility result record.',
    `result_timestamp` TIMESTAMP COMMENT 'The result timestamp of the laboratory susceptibility result record.',
    `snomed_code` STRING COMMENT 'The snomed code value classifying the laboratory susceptibility result record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the laboratory susceptibility result record.',
    `susceptibility_result_status` STRING COMMENT 'The susceptibility result status value classifying the laboratory susceptibility result record.',
    `susceptibility_interpretation` STRING COMMENT 'The susceptibility interpretation of the laboratory susceptibility result record.',
    `susceptible_breakpoint` DECIMAL(18,2) COMMENT 'The susceptible breakpoint of the laboratory susceptibility result record.',
    `synergy_test_result` STRING COMMENT 'The synergy test result of the laboratory susceptibility result record.',
    `testing_method` STRING COMMENT 'The testing method of the laboratory susceptibility result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory susceptibility result record.',
    `verified_timestamp` TIMESTAMP COMMENT 'The verified timestamp of the laboratory susceptibility result record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory susceptibility result record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory susceptibility result record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_susceptibility_result PRIMARY KEY(`susceptibility_result_id`)
) COMMENT 'Transactional record of individual antimicrobial susceptibility test results within a microbiology culture workup. Captures the antibiotic agent (NDC or SNOMED coded), minimum inhibitory concentration (MIC) value, disk diffusion zone diameter, interpretation (susceptible, intermediate, resistant, susceptible-dose dependent), testing method (Kirby-Bauer, broth microdilution, E-test), and CLSI breakpoint version applied. Supports antibiotic stewardship and infection control programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` (
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the blood bank unit within the laboratory blood bank unit record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory blood bank unit record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the crossmatch specimen within the laboratory blood bank unit record.',
    `hcpcs_code_id` BIGINT COMMENT 'Unique identifier for the hcpcs code within the laboratory blood bank unit record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory blood bank unit record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory blood bank unit record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the storage room within the laboratory blood bank unit record.',
    `abo_blood_group` STRING COMMENT 'The abo blood group of the laboratory blood bank unit record.',
    `bacterial_contamination_testing_status` STRING COMMENT 'The bacterial contamination testing status value classifying the laboratory blood bank unit record.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The charge amount of the laboratory blood bank unit record.',
    `cmv_status` STRING COMMENT 'The cmv status value classifying the laboratory blood bank unit record.',
    `collection_facility_code` STRING COMMENT 'The collection facility code value classifying the laboratory blood bank unit record.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost amount of the laboratory blood bank unit record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory blood bank unit record.',
    `crossmatch_required_flag` BOOLEAN COMMENT 'The crossmatch required flag of the laboratory blood bank unit record.',
    `discard_reason` STRING COMMENT 'The discard reason of the laboratory blood bank unit record.',
    `discard_timestamp` TIMESTAMP COMMENT 'The discard timestamp of the laboratory blood bank unit record.',
    `donation_date` DATE COMMENT 'Timestamp capturing the donation date associated with the laboratory blood bank unit record.',
    `donation_identification_number` STRING COMMENT 'The donation identification number of the laboratory blood bank unit record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory blood bank unit record.',
    `extended_phenotype` STRING COMMENT 'The extended phenotype of the laboratory blood bank unit record.',
    `hemoglobin_s_status` STRING COMMENT 'The hemoglobin s status value classifying the laboratory blood bank unit record.',
    `infectious_disease_testing_status` STRING COMMENT 'The infectious disease testing status value classifying the laboratory blood bank unit record.',
    `irradiation_date` DATE COMMENT 'Timestamp capturing the irradiation date associated with the laboratory blood bank unit record.',
    `irradiation_status` STRING COMMENT 'The irradiation status value classifying the laboratory blood bank unit record.',
    `issue_timestamp` TIMESTAMP COMMENT 'The issue timestamp of the laboratory blood bank unit record.',
    `issued_to_location` STRING COMMENT 'The issued to location of the laboratory blood bank unit record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory blood bank unit record.',
    `leukoreduction_status` STRING COMMENT 'The leukoreduction status value classifying the laboratory blood bank unit record.',
    `lot_number` STRING COMMENT 'The lot number of the laboratory blood bank unit record.',
    `product_code` STRING COMMENT 'The product code value classifying the laboratory blood bank unit record.',
    `product_type` STRING COMMENT 'The product type value classifying the laboratory blood bank unit record.',
    `quarantine_reason` STRING COMMENT 'The quarantine reason of the laboratory blood bank unit record.',
    `quarantine_timestamp` TIMESTAMP COMMENT 'The quarantine timestamp of the laboratory blood bank unit record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory blood bank unit record.',
    `reservation_timestamp` TIMESTAMP COMMENT 'The reservation timestamp of the laboratory blood bank unit record.',
    `reserved_for_patient_mrn` STRING COMMENT 'The reserved for patient mrn of the laboratory blood bank unit record.',
    `return_timestamp` TIMESTAMP COMMENT 'The return timestamp of the laboratory blood bank unit record.',
    `rh_type` STRING COMMENT 'The rh type value classifying the laboratory blood bank unit record.',
    `special_processing_codes` STRING COMMENT 'The special processing codes of the laboratory blood bank unit record.',
    `blood_bank_unit_status` STRING COMMENT 'The blood bank unit status value classifying the laboratory blood bank unit record.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'The storage temperature c of the laboratory blood bank unit record.',
    `supplier_facility_code` STRING COMMENT 'The supplier facility code value classifying the laboratory blood bank unit record.',
    `temperature_alarm_flag` BOOLEAN COMMENT 'The temperature alarm flag of the laboratory blood bank unit record.',
    `transfusion_timestamp` TIMESTAMP COMMENT 'The transfusion timestamp of the laboratory blood bank unit record.',
    `unit_number` STRING COMMENT 'The unit number of the laboratory blood bank unit record.',
    `unit_status` STRING COMMENT 'The unit status value classifying the laboratory blood bank unit record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory blood bank unit record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory blood bank unit record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory blood bank unit record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `volume_ml` DECIMAL(18,2) COMMENT 'The volume ml of the laboratory blood bank unit record.',
    CONSTRAINT pk_blood_bank_unit PRIMARY KEY(`blood_bank_unit_id`)
) COMMENT 'Master record for each blood product unit managed by the transfusion medicine / blood bank service. Tracks unit number (ISBT 128 coded), product type (packed red cells, platelets, FFP, cryoprecipitate, whole blood, granulocytes), ABO/Rh type, donation date, expiration date, irradiation status, leukoreduction status, CMV status, sickle trait status, unit status lifecycle (available, reserved, crossmatched, issued, transfused, discarded, returned, quarantined), storage location, and temperature monitoring. SSOT for blood product inventory, traceability, and regulatory compliance. Supports AABB standards, FDA blood establishment regulations, and hemovigilance reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` (
    `transfusion_event_id` BIGINT COMMENT 'Unique identifier for the transfusion event within the laboratory transfusion event record.',
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the blood bank unit within the laboratory transfusion event record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the laboratory transfusion event record.',
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge within the laboratory transfusion event record.',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order within the laboratory transfusion event record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory transfusion event record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory transfusion event record.',
    `hcpcs_code_id` BIGINT COMMENT 'Unique identifier for the hcpcs code within the laboratory transfusion event record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the laboratory transfusion event record.',
    `patient_safety_event_id` BIGINT COMMENT 'Unique identifier for the patient safety event within the laboratory transfusion event record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary transfusion employee within the laboratory transfusion event record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory transfusion event record.',
    `surgical_case_id` BIGINT COMMENT 'Unique identifier for the surgical case within the laboratory transfusion event record.',
    `transfusion_administering_employee_id` BIGINT COMMENT 'Unique identifier for the transfusion administering employee within the laboratory transfusion event record.',
    `treatment_consent_id` BIGINT COMMENT 'Unique identifier for the treatment consent within the laboratory transfusion event record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory transfusion event record.',
    `antibody_screen_result` STRING COMMENT 'The antibody screen result of the laboratory transfusion event record.',
    `clinical_indication` STRING COMMENT 'The clinical indication of the laboratory transfusion event record.',
    `consent_datetime` TIMESTAMP COMMENT 'Timestamp capturing the consent datetime associated with the laboratory transfusion event record.',
    `consent_obtained` BOOLEAN COMMENT 'The consent obtained of the laboratory transfusion event record.',
    `consent_obtained_flag` BOOLEAN COMMENT 'The consent obtained flag of the laboratory transfusion event record.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp capturing the created datetime associated with the laboratory transfusion event record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory transfusion event record.',
    `crossmatch_datetime` TIMESTAMP COMMENT 'Timestamp capturing the crossmatch datetime associated with the laboratory transfusion event record.',
    `crossmatch_result` STRING COMMENT 'The crossmatch result of the laboratory transfusion event record.',
    `crossmatch_type` STRING COMMENT 'The crossmatch type value classifying the laboratory transfusion event record.',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the laboratory transfusion event record.',
    `hemovigilance_reported` BOOLEAN COMMENT 'The hemovigilance reported of the laboratory transfusion event record.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Timestamp capturing the last updated datetime associated with the laboratory transfusion event record.',
    `notes` STRING COMMENT 'The notes of the laboratory transfusion event record.',
    `post_transfusion_blood_pressure_diastolic` STRING COMMENT 'The post transfusion blood pressure diastolic of the laboratory transfusion event record.',
    `post_transfusion_blood_pressure_systolic` STRING COMMENT 'The post transfusion blood pressure systolic of the laboratory transfusion event record.',
    `post_transfusion_pulse` STRING COMMENT 'The post transfusion pulse of the laboratory transfusion event record.',
    `post_transfusion_respiratory_rate` STRING COMMENT 'The post transfusion respiratory rate of the laboratory transfusion event record.',
    `post_transfusion_temperature` DECIMAL(18,2) COMMENT 'The post transfusion temperature of the laboratory transfusion event record.',
    `pre_transfusion_blood_pressure_diastolic` STRING COMMENT 'The pre transfusion blood pressure diastolic of the laboratory transfusion event record.',
    `pre_transfusion_blood_pressure_systolic` STRING COMMENT 'The pre transfusion blood pressure systolic of the laboratory transfusion event record.',
    `pre_transfusion_pulse` STRING COMMENT 'The pre transfusion pulse of the laboratory transfusion event record.',
    `pre_transfusion_respiratory_rate` STRING COMMENT 'The pre transfusion respiratory rate of the laboratory transfusion event record.',
    `pre_transfusion_temperature` DECIMAL(18,2) COMMENT 'The pre transfusion temperature of the laboratory transfusion event record.',
    `product_type` STRING COMMENT 'The product type value classifying the laboratory transfusion event record.',
    `reaction_description` STRING COMMENT 'The reaction description of the laboratory transfusion event record.',
    `reaction_flag` BOOLEAN COMMENT 'The reaction flag of the laboratory transfusion event record.',
    `reaction_onset_datetime` TIMESTAMP COMMENT 'Timestamp capturing the reaction onset datetime associated with the laboratory transfusion event record.',
    `reaction_severity` STRING COMMENT 'The reaction severity of the laboratory transfusion event record.',
    `reaction_type` STRING COMMENT 'The reaction type value classifying the laboratory transfusion event record.',
    `special_requirements` STRING COMMENT 'The special requirements of the laboratory transfusion event record.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the laboratory transfusion event record.',
    `transfusion_event_status` STRING COMMENT 'The transfusion event status value classifying the laboratory transfusion event record.',
    `transfusion_end_datetime` TIMESTAMP COMMENT 'Timestamp capturing the transfusion end datetime associated with the laboratory transfusion event record.',
    `transfusion_number` STRING COMMENT 'The transfusion number of the laboratory transfusion event record.',
    `transfusion_rate` DECIMAL(18,2) COMMENT 'The transfusion rate of the laboratory transfusion event record.',
    `transfusion_reaction_occurred` BOOLEAN COMMENT 'The transfusion reaction occurred of the laboratory transfusion event record.',
    `transfusion_reaction_type` STRING COMMENT 'The transfusion reaction type value classifying the laboratory transfusion event record.',
    `transfusion_site` STRING COMMENT 'The transfusion site of the laboratory transfusion event record.',
    `transfusion_start_datetime` TIMESTAMP COMMENT 'Timestamp capturing the transfusion start datetime associated with the laboratory transfusion event record.',
    `transfusion_status` STRING COMMENT 'The transfusion status value classifying the laboratory transfusion event record.',
    `unexpected_antibody_identified` STRING COMMENT 'The unexpected antibody identified of the laboratory transfusion event record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory transfusion event record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory transfusion event record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory transfusion event record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `volume_ml` DECIMAL(18,2) COMMENT 'The volume ml of the laboratory transfusion event record.',
    `volume_transfused_ml` STRING COMMENT 'The volume transfused ml of the laboratory transfusion event record.',
    CONSTRAINT pk_transfusion_event PRIMARY KEY(`transfusion_event_id`)
) COMMENT 'Transactional record of the full blood product transfusion lifecycle from crossmatch/compatibility testing through administration and post-transfusion monitoring. Owns crossmatch and compatibility testing: crossmatch type (electronic, immediate spin, full serologic), compatibility result (compatible, incompatible), antibody screen result, unexpected antibody identification, patient blood sample reference, performing technologist, crossmatch date/time. Owns transfusion administration: blood bank unit transfused, transfusion start and end date/time, transfusion site, administering nurse, pre- and post-transfusion vital signs, transfusion reaction indicator and type, reaction severity, and clinical indication. Consolidates the former crossmatch product. Supports hemovigilance reporting, AABB compliance, blood bank audit trails, and patient safety surveillance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` (
    `point_of_care_test_id` BIGINT COMMENT 'Unique identifier for the point of care test within the laboratory point of care test record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the laboratory point of care test record.',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order within the laboratory point of care test record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the laboratory point of care test record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory point of care test record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory point of care test record.',
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory point of care test record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory point of care test record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the laboratory point of care test record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the point employee within the laboratory point of care test record.',
    `point_performed_by_employee_id` BIGINT COMMENT 'Unique identifier for the point performed by employee within the laboratory point of care test record.',
    `previous_result_point_of_care_test_id` BIGINT COMMENT 'Unique identifier for the previous result point of care test within the laboratory point of care test record.',
    `qc_run_id` BIGINT COMMENT 'Unique identifier for the qc run within the laboratory point of care test record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory point of care test record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory point of care test record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory point of care test record.',
    `abnormal_flag` BOOLEAN COMMENT 'The abnormal flag of the laboratory point of care test record.',
    `clia_waived_flag` BOOLEAN COMMENT 'The clia waived flag of the laboratory point of care test record.',
    `collection_datetime` TIMESTAMP COMMENT 'Timestamp capturing the collection datetime associated with the laboratory point of care test record.',
    `corrected_result_flag` BOOLEAN COMMENT 'The corrected result flag of the laboratory point of care test record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory point of care test record.',
    `critical_value_flag` BOOLEAN COMMENT 'The critical value flag of the laboratory point of care test record.',
    `device_type` STRING COMMENT 'The device type value classifying the laboratory point of care test record.',
    `ehr_transmission_datetime` TIMESTAMP COMMENT 'Timestamp capturing the ehr transmission datetime associated with the laboratory point of care test record.',
    `ehr_transmission_status` STRING COMMENT 'The ehr transmission status value classifying the laboratory point of care test record.',
    `mrn` STRING COMMENT 'The mrn of the laboratory point of care test record.',
    `operator_competency_date` DATE COMMENT 'Timestamp capturing the operator competency date associated with the laboratory point of care test record.',
    `operator_competency_status` STRING COMMENT 'The operator competency status value classifying the laboratory point of care test record.',
    `operator_name` STRING COMMENT 'The operator name of the laboratory point of care test record.',
    `performed_timestamp` TIMESTAMP COMMENT 'The performed timestamp of the laboratory point of care test record.',
    `performing_location_name` STRING COMMENT 'The performing location name of the laboratory point of care test record.',
    `qc_datetime` TIMESTAMP COMMENT 'Timestamp capturing the qc datetime associated with the laboratory point of care test record.',
    `qc_lot_number` STRING COMMENT 'The qc lot number of the laboratory point of care test record.',
    `qc_passed_flag` BOOLEAN COMMENT 'The qc passed flag of the laboratory point of care test record.',
    `qc_status` STRING COMMENT 'The qc status value classifying the laboratory point of care test record.',
    `reference_range_high` DECIMAL(18,2) COMMENT 'The reference range high of the laboratory point of care test record.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'The reference range low of the laboratory point of care test record.',
    `result_comment` STRING COMMENT 'The result comment of the laboratory point of care test record.',
    `result_datetime` TIMESTAMP COMMENT 'Timestamp capturing the result datetime associated with the laboratory point of care test record.',
    `result_numeric` DECIMAL(18,2) COMMENT 'The result numeric of the laboratory point of care test record.',
    `result_unit` STRING COMMENT 'The result unit of the laboratory point of care test record.',
    `result_units` STRING COMMENT 'The result units of the laboratory point of care test record.',
    `result_value` DECIMAL(18,2) COMMENT 'The result value of the laboratory point of care test record.',
    `specimen_source` STRING COMMENT 'The specimen source of the laboratory point of care test record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory point of care test record.',
    `point_of_care_test_status` STRING COMMENT 'The point of care test status value classifying the laboratory point of care test record.',
    `test_category` STRING COMMENT 'The test category of the laboratory point of care test record.',
    `test_datetime` TIMESTAMP COMMENT 'Timestamp capturing the test datetime associated with the laboratory point of care test record.',
    `test_name` STRING COMMENT 'The test name of the laboratory point of care test record.',
    `test_status` STRING COMMENT 'The test status value classifying the laboratory point of care test record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory point of care test record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory point of care test record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory point of care test record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_point_of_care_test PRIMARY KEY(`point_of_care_test_id`)
) COMMENT 'Transactional record for Point-of-Care Testing (POCT) performed outside the central laboratory — at bedside, in the ED, ICU, or clinic. Captures device identifier, device type (glucometer, iSTAT, CoaguChek, rapid strep, influenza), LOINC-coded test, result value, result unit, operator identifier, operator competency status, patient identifier, test date/time, QC status at time of test, and result transmission status to the EHR. Supports CLIA waived and non-waived POCT compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` (
    `qc_run_id` BIGINT COMMENT 'Unique identifier for the qc run within the laboratory qc run record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory qc run record.',
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory qc run record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary qc employee within the laboratory qc run record.',
    `qc_performed_by_employee_id` BIGINT COMMENT 'Unique identifier for the qc performed by employee within the laboratory qc run record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory qc run record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory qc run record.',
    `comments` STRING COMMENT 'The comments of the laboratory qc run record.',
    `corrective_action_taken` STRING COMMENT 'The corrective action taken of the laboratory qc run record.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'The corrective action timestamp of the laboratory qc run record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory qc run record.',
    `expected_mean` DECIMAL(18,2) COMMENT 'The expected mean of the laboratory qc run record.',
    `expected_standard_deviation` DECIMAL(18,2) COMMENT 'The expected standard deviation of the laboratory qc run record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory qc run record.',
    `observed_result` DECIMAL(18,2) COMMENT 'The observed result of the laboratory qc run record.',
    `observed_value` DECIMAL(18,2) COMMENT 'The observed value of the laboratory qc run record.',
    `pass_fail_indicator` BOOLEAN COMMENT 'The pass fail indicator of the laboratory qc run record.',
    `pt_attestation_date` DATE COMMENT 'Timestamp capturing the pt attestation date associated with the laboratory qc run record.',
    `pt_corrective_action_plan` STRING COMMENT 'The pt corrective action plan of the laboratory qc run record.',
    `pt_event_code` STRING COMMENT 'The pt event code value classifying the laboratory qc run record.',
    `pt_graded_result` STRING COMMENT 'The pt graded result of the laboratory qc run record.',
    `pt_peer_group_mean` DECIMAL(18,2) COMMENT 'The pt peer group mean of the laboratory qc run record.',
    `pt_peer_group_standard_deviation` DECIMAL(18,2) COMMENT 'The pt peer group standard deviation of the laboratory qc run record.',
    `pt_program_name` STRING COMMENT 'The pt program name of the laboratory qc run record.',
    `pt_sample_number` STRING COMMENT 'The pt sample number of the laboratory qc run record.',
    `pt_submitted_result` STRING COMMENT 'The pt submitted result of the laboratory qc run record.',
    `pt_z_score` DECIMAL(18,2) COMMENT 'The pt z score of the laboratory qc run record.',
    `qc_level` STRING COMMENT 'The qc level of the laboratory qc run record.',
    `qc_material_lot_number` STRING COMMENT 'The qc material lot number of the laboratory qc run record.',
    `qc_run_status` STRING COMMENT 'The qc run status value classifying the laboratory qc run record.',
    `qc_run_timestamp` TIMESTAMP COMMENT 'The qc run timestamp of the laboratory qc run record.',
    `qc_status` STRING COMMENT 'The qc status value classifying the laboratory qc run record.',
    `qc_type` STRING COMMENT 'The qc type value classifying the laboratory qc run record.',
    `reagent_storage_temperature` STRING COMMENT 'The reagent storage temperature of the laboratory qc run record.',
    `result_unit_of_measure` STRING COMMENT 'The result unit of measure of the laboratory qc run record.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'The reviewed timestamp of the laboratory qc run record.',
    `run_timestamp` TIMESTAMP COMMENT 'The run timestamp of the laboratory qc run record.',
    `standard_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of the laboratory qc run record.',
    `target_value` DECIMAL(18,2) COMMENT 'The target value of the laboratory qc run record.',
    `test_code` STRING COMMENT 'The test code value classifying the laboratory qc run record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory qc run record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory qc run record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory qc run record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `westgard_rule_evaluation` STRING COMMENT 'The westgard rule evaluation of the laboratory qc run record.',
    `westgard_violation_flag` BOOLEAN COMMENT 'The westgard violation flag of the laboratory qc run record.',
    CONSTRAINT pk_qc_run PRIMARY KEY(`qc_run_id`)
) COMMENT 'Transactional record of all quality control activities performed to verify laboratory analytical performance, including internal QC runs on instruments, external proficiency testing (PT) events, and reagent/consumable lot management. For internal QC: captures instrument identifier, QC material lot number, QC level (low, normal, high), expected mean and standard deviation, observed result, Westgard rule evaluation outcome (pass/fail), QC run date/time, performing technologist, and corrective action taken if failed. For proficiency testing (PT): captures PT program name (CAP, AAFP, COLA), analyte or test surveyed, PT event date, submitted result value, graded result (acceptable, unacceptable), peer group mean, peer group SD, z-score, corrective action plan if failed, and attestation date. For reagent and consumable lot tracking: captures reagent name, manufacturer, catalog number, lot number, expiration date, receipt date, storage requirements (temperature, light sensitivity), open/unopened status, assigned instrument or test method, QC validation status (passed, failed, pending), quantity on hand, lot-to-lot validation results, and lot-to-result traceability for quality investigations. Consolidates the former proficiency_test and reagent_lot products. Mandatory for CLIA compliance, CAP accreditation, and reagent documentation requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory instrument record.',
    `clia_certificate_id` BIGINT COMMENT 'Unique identifier for the clia certificate within the laboratory instrument record.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the laboratory instrument record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory instrument record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the laboratory instrument record.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset within the laboratory instrument record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the laboratory instrument record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the laboratory instrument record.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The acquisition cost of the laboratory instrument record.',
    `asset_tag` STRING COMMENT 'The asset tag of the laboratory instrument record.',
    `calibration_frequency` STRING COMMENT 'The calibration frequency of the laboratory instrument record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory instrument record.',
    `decommission_date` DATE COMMENT 'Timestamp capturing the decommission date associated with the laboratory instrument record.',
    `decommission_reason` STRING COMMENT 'The decommission reason of the laboratory instrument record.',
    `installation_date` DATE COMMENT 'Timestamp capturing the installation date associated with the laboratory instrument record.',
    `instrument_type` STRING COMMENT 'The instrument type value classifying the laboratory instrument record.',
    `lab_section` STRING COMMENT 'The lab section of the laboratory instrument record.',
    `last_calibration_date` DATE COMMENT 'Timestamp capturing the last calibration date associated with the laboratory instrument record.',
    `last_calibration_result` STRING COMMENT 'The last calibration result of the laboratory instrument record.',
    `last_corrective_maintenance_date` DATE COMMENT 'Timestamp capturing the last corrective maintenance date associated with the laboratory instrument record.',
    `last_preventive_maintenance_date` DATE COMMENT 'Timestamp capturing the last preventive maintenance date associated with the laboratory instrument record.',
    `last_quality_control_date` DATE COMMENT 'Timestamp capturing the last quality control date associated with the laboratory instrument record.',
    `last_quality_control_result` STRING COMMENT 'The last quality control result of the laboratory instrument record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory instrument record.',
    `lis_connectivity_status` STRING COMMENT 'The lis connectivity status value classifying the laboratory instrument record.',
    `lis_interface_code` STRING COMMENT 'The lis interface code value classifying the laboratory instrument record.',
    `manufacturer` STRING COMMENT 'The manufacturer of the laboratory instrument record.',
    `model_number` STRING COMMENT 'The model number of the laboratory instrument record.',
    `instrument_name` STRING COMMENT 'The instrument name of the laboratory instrument record.',
    `next_calibration_date` DATE COMMENT 'Timestamp capturing the next calibration date associated with the laboratory instrument record.',
    `next_preventive_maintenance_date` DATE COMMENT 'Timestamp capturing the next preventive maintenance date associated with the laboratory instrument record.',
    `notes` STRING COMMENT 'The notes of the laboratory instrument record.',
    `operational_status` STRING COMMENT 'The operational status value classifying the laboratory instrument record.',
    `preventive_maintenance_frequency` STRING COMMENT 'The preventive maintenance frequency of the laboratory instrument record.',
    `quality_control_frequency` STRING COMMENT 'The quality control frequency of the laboratory instrument record.',
    `serial_number` STRING COMMENT 'The serial number of the laboratory instrument record.',
    `service_contract_expiration_date` DATE COMMENT 'Timestamp capturing the service contract expiration date associated with the laboratory instrument record.',
    `service_contract_number` STRING COMMENT 'The service contract number of the laboratory instrument record.',
    `instrument_status` STRING COMMENT 'The instrument status value classifying the laboratory instrument record.',
    `total_downtime_hours` DECIMAL(18,2) COMMENT 'The total downtime hours of the laboratory instrument record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory instrument record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory instrument record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory instrument record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `warranty_expiration_date` DATE COMMENT 'Timestamp capturing the warranty expiration date associated with the laboratory instrument record.',
    CONSTRAINT pk_instrument PRIMARY KEY(`instrument_id`)
) COMMENT 'Master record for every analytical instrument and analyzer operated within the laboratory, including its full maintenance, calibration, and service lifecycle. Tracks instrument identity: name, manufacturer, model, serial number, asset tag, lab section assignment, location (lab room/bench), CLIA certificate association, installation date, current operational status (active, down, maintenance, decommissioned), LIS interface connectivity. Owns all maintenance events: preventive maintenance schedules (daily, weekly, monthly), corrective maintenance events, calibration verification results, maintenance date/time, performing technician or vendor, tasks completed, parts replaced, downtime duration, and return-to-service authorization. Consolidates the former instrument_maintenance product. SSOT for laboratory instrument inventory, operational readiness, and CLIA/CAP maintenance documentation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` (
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory test catalog record.',
    `clia_certificate_id` BIGINT COMMENT 'Unique identifier for the clia certificate within the laboratory test catalog record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the laboratory test catalog record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the laboratory test catalog record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory test catalog record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the quality measure within the laboratory test catalog record.',
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change within the laboratory test catalog record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the snomed concept within the laboratory test catalog record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the laboratory test catalog record.',
    `authorization_required_flag` BOOLEAN COMMENT 'The authorization required flag of the laboratory test catalog record.',
    `clia_complexity` STRING COMMENT 'The clia complexity of the laboratory test catalog record.',
    `clinical_indication` STRING COMMENT 'The clinical indication of the laboratory test catalog record.',
    `collection_instructions` STRING COMMENT 'The collection instructions of the laboratory test catalog record.',
    `consent_required_flag` BOOLEAN COMMENT 'The consent required flag of the laboratory test catalog record.',
    `cpt_code` STRING COMMENT 'The cpt code value classifying the laboratory test catalog record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory test catalog record.',
    `critical_high_value` DECIMAL(18,2) COMMENT 'The critical high value of the laboratory test catalog record.',
    `critical_low_value` DECIMAL(18,2) COMMENT 'The critical low value of the laboratory test catalog record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory test catalog record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory test catalog record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory test catalog record.',
    `methodology` STRING COMMENT 'The methodology of the laboratory test catalog record.',
    `minimum_volume` STRING COMMENT 'The minimum volume of the laboratory test catalog record.',
    `orderable_flag` BOOLEAN COMMENT 'The orderable flag of the laboratory test catalog record.',
    `orderable_status` STRING COMMENT 'The orderable status value classifying the laboratory test catalog record.',
    `ordering_instructions` STRING COMMENT 'The ordering instructions of the laboratory test catalog record.',
    `panic_value_flag` BOOLEAN COMMENT 'The panic value flag of the laboratory test catalog record.',
    `patient_preparation` STRING COMMENT 'The patient preparation of the laboratory test catalog record.',
    `performing_lab_location` STRING COMMENT 'The performing lab location of the laboratory test catalog record.',
    `preferred_volume` STRING COMMENT 'The preferred volume of the laboratory test catalog record.',
    `reference_lab_code` STRING COMMENT 'The reference lab code value classifying the laboratory test catalog record.',
    `reference_lab_name` STRING COMMENT 'The reference lab name of the laboratory test catalog record.',
    `reference_range_adult` STRING COMMENT 'The reference range adult of the laboratory test catalog record.',
    `reference_range_pediatric` STRING COMMENT 'The reference range pediatric of the laboratory test catalog record.',
    `result_type` STRING COMMENT 'The result type value classifying the laboratory test catalog record.',
    `specimen_container` STRING COMMENT 'The specimen container of the laboratory test catalog record.',
    `specimen_stability` STRING COMMENT 'The specimen stability of the laboratory test catalog record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory test catalog record.',
    `test_catalog_status` STRING COMMENT 'The test catalog status value classifying the laboratory test catalog record.',
    `storage_temperature` STRING COMMENT 'The storage temperature of the laboratory test catalog record.',
    `test_abbreviation` STRING COMMENT 'The test abbreviation of the laboratory test catalog record.',
    `test_category` STRING COMMENT 'The test category of the laboratory test catalog record.',
    `test_code` STRING COMMENT 'The test code value classifying the laboratory test catalog record.',
    `test_name` STRING COMMENT 'The test name of the laboratory test catalog record.',
    `test_type` STRING COMMENT 'The test type value classifying the laboratory test catalog record.',
    `transport_conditions` STRING COMMENT 'The transport conditions of the laboratory test catalog record.',
    `turnaround_time_hours` STRING COMMENT 'The turnaround time hours of the laboratory test catalog record.',
    `turnaround_time_routine` STRING COMMENT 'The turnaround time routine of the laboratory test catalog record.',
    `turnaround_time_stat` STRING COMMENT 'The turnaround time stat of the laboratory test catalog record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the laboratory test catalog record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory test catalog record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory test catalog record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory test catalog record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_test_catalog PRIMARY KEY(`test_catalog_id`)
) COMMENT 'Reference master of all laboratory tests and test panels offered by the health system, serving as the SSOT for the laboratory test compendium. For individual tests: captures LOINC code, test name, CPT code(s) for billing, specimen requirements, container type, minimum volume, storage and transport conditions, turnaround time targets (routine and STAT), performing lab (internal section or reference lab name), methodology, and orderable flag. For panels and profiles (e.g., BMP, CMP, CBC with differential, lipid panel, hepatic function panel): captures panel LOINC code, panel name, component test relationships, clinical use case, panel-specific ordering rules, and orderable status. Also covers send-out test catalog entries with reference lab routing information. Consolidates the former test_panel product. Used by clinicians, order entry systems (CPOE), clinical decision support, and CDM charge alignment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` (
    `lab_charge_id` BIGINT COMMENT 'Unique identifier for the lab charge within the laboratory lab charge record.',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the laboratory lab charge record.',
    `billing_coverage_id` BIGINT COMMENT 'Unique identifier for the billing coverage within the laboratory lab charge record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the laboratory lab charge record.',
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge within the laboratory lab charge record.',
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts within the laboratory lab charge record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the laboratory lab charge record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory lab charge record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the laboratory lab charge record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory lab charge record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory lab charge record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory lab charge record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory lab charge record.',
    `test_result_id` BIGINT COMMENT 'Unique identifier for the test result within the laboratory lab charge record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory lab charge record.',
    `billing_provider_npi` STRING COMMENT 'The billing provider npi of the laboratory lab charge record.',
    `cdm_code` STRING COMMENT 'The cdm code value classifying the laboratory lab charge record.',
    `charge_created_timestamp` TIMESTAMP COMMENT 'The charge created timestamp of the laboratory lab charge record.',
    `charge_entry_method` STRING COMMENT 'The charge entry method of the laboratory lab charge record.',
    `charge_submitted_timestamp` TIMESTAMP COMMENT 'The charge submitted timestamp of the laboratory lab charge record.',
    `charge_updated_timestamp` TIMESTAMP COMMENT 'The charge updated timestamp of the laboratory lab charge record.',
    `charge_voided_by` STRING COMMENT 'The charge voided by of the laboratory lab charge record.',
    `charge_voided_reason` STRING COMMENT 'The charge voided reason of the laboratory lab charge record.',
    `charge_voided_timestamp` TIMESTAMP COMMENT 'The charge voided timestamp of the laboratory lab charge record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory lab charge record.',
    `diagnosis_code_1` STRING COMMENT 'The diagnosis code 1 of the laboratory lab charge record.',
    `diagnosis_code_2` STRING COMMENT 'The diagnosis code 2 of the laboratory lab charge record.',
    `diagnosis_code_3` STRING COMMENT 'The diagnosis code 3 of the laboratory lab charge record.',
    `diagnosis_code_4` STRING COMMENT 'The diagnosis code 4 of the laboratory lab charge record.',
    `insurance_authorization_number` STRING COMMENT 'The insurance authorization number of the laboratory lab charge record.',
    `ordering_provider_name` STRING COMMENT 'The ordering provider name of the laboratory lab charge record.',
    `ordering_provider_npi` STRING COMMENT 'The ordering provider npi of the laboratory lab charge record.',
    `performing_lab_section` STRING COMMENT 'The performing lab section of the laboratory lab charge record.',
    `performing_provider_npi` STRING COMMENT 'The performing provider npi of the laboratory lab charge record.',
    `point_of_care_indicator` BOOLEAN COMMENT 'The point of care indicator of the laboratory lab charge record.',
    `reference_lab_indicator` BOOLEAN COMMENT 'The reference lab indicator of the laboratory lab charge record.',
    `reference_lab_name` STRING COMMENT 'The reference lab name of the laboratory lab charge record.',
    `service_location_code` STRING COMMENT 'The service location code value classifying the laboratory lab charge record.',
    `stat_surcharge_amount` DECIMAL(18,2) COMMENT 'The stat surcharge amount of the laboratory lab charge record.',
    `lab_charge_status` STRING COMMENT 'The lab charge status value classifying the laboratory lab charge record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory lab charge record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory lab charge record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory lab charge record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_lab_charge PRIMARY KEY(`lab_charge_id`)
) COMMENT 'Transactional record capturing laboratory-specific charge events generated upon test completion for revenue cycle processing. Tracks the CPT or HCPCS procedure code, charge amount from the CDM (Charge Description Master), charge date, ordering provider NPI, performing facility, insurance authorization reference, charge status (pending, submitted, voided), and the associated lab order and test result. Serves as the laboratory domains charge origination record that feeds into the billing domain for RCM processing. Does not duplicate billing domain charge master — owns only the lab-originated charge event with lab-specific context (specimen type, performing section, STAT surcharge).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` (
    `clia_certificate_id` BIGINT COMMENT 'Unique identifier for the clia certificate within the laboratory clia certificate record.',
    `accreditation_program_id` BIGINT COMMENT 'Unique identifier for the accreditation program within the laboratory clia certificate record.',
    `accreditation_status_id` BIGINT COMMENT 'Unique identifier for the accreditation status within the laboratory clia certificate record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the laboratory clia certificate record.',
    `cms_condition_status_id` BIGINT COMMENT 'Unique identifier for the cms condition status within the laboratory clia certificate record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory clia certificate record.',
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change within the laboratory clia certificate record.',
    `accrediting_organization` STRING COMMENT 'The accrediting organization of the laboratory clia certificate record.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'The annual fee amount of the laboratory clia certificate record.',
    `annual_test_volume` STRING COMMENT 'The annual test volume of the laboratory clia certificate record.',
    `application_date` DATE COMMENT 'Timestamp capturing the application date associated with the laboratory clia certificate record.',
    `certificate_number` STRING COMMENT 'The certificate number of the laboratory clia certificate record.',
    `certificate_status` STRING COMMENT 'The certificate status value classifying the laboratory clia certificate record.',
    `certificate_type` STRING COMMENT 'The certificate type value classifying the laboratory clia certificate record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory clia certificate record.',
    `deficiency_count` STRING COMMENT 'The deficiency count of the laboratory clia certificate record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory clia certificate record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory clia certificate record.',
    `fee_payment_status` STRING COMMENT 'The fee payment status value classifying the laboratory clia certificate record.',
    `fee_schedule_category` STRING COMMENT 'The fee schedule category of the laboratory clia certificate record.',
    `inspection_outcome` STRING COMMENT 'The inspection outcome of the laboratory clia certificate record.',
    `issuing_agency` STRING COMMENT 'The issuing agency of the laboratory clia certificate record.',
    `issuing_state` STRING COMMENT 'The issuing state of the laboratory clia certificate record.',
    `laboratory_director_license_number` STRING COMMENT 'The laboratory director license number of the laboratory clia certificate record.',
    `laboratory_director_license_state` STRING COMMENT 'The laboratory director license state of the laboratory clia certificate record.',
    `laboratory_director_name` STRING COMMENT 'The laboratory director name of the laboratory clia certificate record.',
    `laboratory_director_npi` STRING COMMENT 'The laboratory director npi of the laboratory clia certificate record.',
    `laboratory_type` STRING COMMENT 'The laboratory type value classifying the laboratory clia certificate record.',
    `last_fee_payment_date` DATE COMMENT 'Timestamp capturing the last fee payment date associated with the laboratory clia certificate record.',
    `last_inspection_date` DATE COMMENT 'Timestamp capturing the last inspection date associated with the laboratory clia certificate record.',
    `last_proficiency_testing_date` DATE COMMENT 'Timestamp capturing the last proficiency testing date associated with the laboratory clia certificate record.',
    `next_inspection_due_date` DATE COMMENT 'Timestamp capturing the next inspection due date associated with the laboratory clia certificate record.',
    `notes` STRING COMMENT 'The notes of the laboratory clia certificate record.',
    `plan_of_correction_due_date` DATE COMMENT 'Timestamp capturing the plan of correction due date associated with the laboratory clia certificate record.',
    `plan_of_correction_status` STRING COMMENT 'The plan of correction status value classifying the laboratory clia certificate record.',
    `proficiency_testing_enrollment` BOOLEAN COMMENT 'The proficiency testing enrollment of the laboratory clia certificate record.',
    `proficiency_testing_outcome` STRING COMMENT 'The proficiency testing outcome of the laboratory clia certificate record.',
    `proficiency_testing_provider` STRING COMMENT 'The proficiency testing provider of the laboratory clia certificate record.',
    `renewal_date` DATE COMMENT 'Timestamp capturing the renewal date associated with the laboratory clia certificate record.',
    `renewal_status` STRING COMMENT 'The renewal status value classifying the laboratory clia certificate record.',
    `sanction_effective_date` DATE COMMENT 'Timestamp capturing the sanction effective date associated with the laboratory clia certificate record.',
    `sanction_lifted_date` DATE COMMENT 'Timestamp capturing the sanction lifted date associated with the laboratory clia certificate record.',
    `sanction_type` STRING COMMENT 'The sanction type value classifying the laboratory clia certificate record.',
    `sanctions_imposed` BOOLEAN COMMENT 'The sanctions imposed of the laboratory clia certificate record.',
    `specialty_codes` STRING COMMENT 'The specialty codes of the laboratory clia certificate record.',
    `clia_certificate_status` STRING COMMENT 'The clia certificate status value classifying the laboratory clia certificate record.',
    `testing_complexity_level` STRING COMMENT 'The testing complexity level of the laboratory clia certificate record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory clia certificate record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory clia certificate record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory clia certificate record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory clia certificate record.',
    CONSTRAINT pk_clia_certificate PRIMARY KEY(`clia_certificate_id`)
) COMMENT 'Master record for each CLIA (Clinical Laboratory Improvement Amendments) certificate held by the organizations laboratory facilities. Captures CLIA certificate number, certificate type (waived, provider-performed microscopy, accreditation), issuing state, effective date, expiration date, accrediting organization (CAP, Joint Commission, COLA), laboratory director name and NPI, certificate status, and associated facility. SSOT for CLIA compliance identity across all lab locations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` (
    `molecular_test_id` BIGINT COMMENT 'Unique identifier for the molecular test within the laboratory molecular test record.',
    `cda_document_id` BIGINT COMMENT 'Unique identifier for the cda document within the laboratory molecular test record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory molecular test record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory molecular test record.',
    `genetic_testing_consent_id` BIGINT COMMENT 'Unique identifier for the genetic testing consent within the laboratory molecular test record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the laboratory molecular test record.',
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory molecular test record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory molecular test record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the laboratory molecular test record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory molecular test record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory molecular test record.',
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory molecular test record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the laboratory molecular test record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory molecular test record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory molecular test record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the variant snomed concept within the laboratory molecular test record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory molecular test record.',
    `accession_number` STRING COMMENT 'The accession number of the laboratory molecular test record.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'The allele frequency of the laboratory molecular test record.',
    `amended` BOOLEAN COMMENT 'The amended of the laboratory molecular test record.',
    `amendment_reason` STRING COMMENT 'The amendment reason of the laboratory molecular test record.',
    `amendment_timestamp` TIMESTAMP COMMENT 'The amendment timestamp of the laboratory molecular test record.',
    `assay_platform` STRING COMMENT 'The assay platform of the laboratory molecular test record.',
    `associated_drug` STRING COMMENT 'The associated drug of the laboratory molecular test record.',
    `bioinformatics_pipeline_version` STRING COMMENT 'The bioinformatics pipeline version of the laboratory molecular test record.',
    `clinical_indication` STRING COMMENT 'The clinical indication of the laboratory molecular test record.',
    `clinical_interpretation` STRING COMMENT 'The clinical interpretation of the laboratory molecular test record.',
    `clinical_significance` STRING COMMENT 'The clinical significance of the laboratory molecular test record.',
    `collection_datetime` TIMESTAMP COMMENT 'Timestamp capturing the collection datetime associated with the laboratory molecular test record.',
    `consent_required_flag` BOOLEAN COMMENT 'The consent required flag of the laboratory molecular test record.',
    `copy_number` DECIMAL(18,2) COMMENT 'The copy number of the laboratory molecular test record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory molecular test record.',
    `detected_flag` BOOLEAN COMMENT 'The detected flag of the laboratory molecular test record.',
    `gene_name` STRING COMMENT 'The gene name of the laboratory molecular test record.',
    `gene_target` STRING COMMENT 'The gene target of the laboratory molecular test record.',
    `germline_flag` BOOLEAN COMMENT 'The germline flag of the laboratory molecular test record.',
    `germline_somatic` STRING COMMENT 'The germline somatic of the laboratory molecular test record.',
    `interpretation_summary` STRING COMMENT 'The interpretation summary of the laboratory molecular test record.',
    `methodology` STRING COMMENT 'The methodology of the laboratory molecular test record.',
    `pathogen_target` STRING COMMENT 'The pathogen target of the laboratory molecular test record.',
    `pathogenicity_classification` STRING COMMENT 'The pathogenicity classification of the laboratory molecular test record.',
    `reference_transcript` STRING COMMENT 'The reference transcript of the laboratory molecular test record.',
    `reportable_flag` BOOLEAN COMMENT 'The reportable flag of the laboratory molecular test record.',
    `result_datetime` TIMESTAMP COMMENT 'Timestamp capturing the result datetime associated with the laboratory molecular test record.',
    `result_interpretation` STRING COMMENT 'The result interpretation of the laboratory molecular test record.',
    `result_status` STRING COMMENT 'The result status value classifying the laboratory molecular test record.',
    `resulted_value` DECIMAL(18,2) COMMENT 'The resulted value of the laboratory molecular test record.',
    `sequencing_depth` STRING COMMENT 'The sequencing depth of the laboratory molecular test record.',
    `somatic_flag` BOOLEAN COMMENT 'The somatic flag of the laboratory molecular test record.',
    `molecular_test_status` STRING COMMENT 'The molecular test status value classifying the laboratory molecular test record.',
    `test_methodology` STRING COMMENT 'The test methodology of the laboratory molecular test record.',
    `test_name` STRING COMMENT 'The test name of the laboratory molecular test record.',
    `test_platform` STRING COMMENT 'The test platform of the laboratory molecular test record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory molecular test record.',
    `variant_allele_frequency` DECIMAL(18,2) COMMENT 'The variant allele frequency of the laboratory molecular test record.',
    `variant_classification` STRING COMMENT 'The variant classification of the laboratory molecular test record.',
    `variant_detected` STRING COMMENT 'The variant detected of the laboratory molecular test record.',
    `variant_nomenclature` STRING COMMENT 'The variant nomenclature of the laboratory molecular test record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory molecular test record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory molecular test record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory molecular test record.',
    `viral_load` DECIMAL(18,2) COMMENT 'The viral load of the laboratory molecular test record.',
    `viral_load_unit` STRING COMMENT 'The viral load unit of the laboratory molecular test record.',
    `viral_load_value` DECIMAL(18,2) COMMENT 'The viral load value of the laboratory molecular test record.',
    CONSTRAINT pk_molecular_test PRIMARY KEY(`molecular_test_id`)
) COMMENT 'Transactional record for molecular diagnostic tests including PCR, NGS (Next Generation Sequencing), FISH, and other nucleic acid amplification tests (NAATs). Captures assay name, target gene or pathogen, methodology (RT-PCR, ddPCR, NGS panel, whole exome sequencing), result interpretation (detected/not detected, variant classification per ACMG guidelines, copy number), variant nomenclature (HGVS), clinical significance (pathogenic, likely pathogenic, VUS, likely benign, benign), turnaround time, laboratory developed test (LDT) or FDA-cleared status, bioinformatics pipeline version, and quality metrics (read depth, coverage). Supports oncology genomics (tumor profiling, companion diagnostics), infectious disease molecular testing, pharmacogenomics workflows, and hereditary genetic testing. Remains independent from test_result because molecular diagnostics have fundamentally different attribute structures (variant nomenclature, gene targets, bioinformatics metadata) and distinct operational workflows (wet lab + bioinformatics pipeline) that justify first-class entity status, consistent with the separation between FHIR DiagnosticReport (molecular) and Observation (standard lab result).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` (
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot within the laboratory reagent lot record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the laboratory reagent lot record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the laboratory reagent lot record.',
    `recall_notice_id` BIGINT COMMENT 'Unique identifier for the recall notice within the laboratory reagent lot record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory reagent lot record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor within the laboratory reagent lot record.',
    `catalog_number` STRING COMMENT 'The catalog number of the laboratory reagent lot record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory reagent lot record.',
    `current_quantity_on_hand` STRING COMMENT 'The current quantity on hand of the laboratory reagent lot record.',
    `disposal_date` DATE COMMENT 'Timestamp capturing the disposal date associated with the laboratory reagent lot record.',
    `disposal_method` STRING COMMENT 'The disposal method of the laboratory reagent lot record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory reagent lot record.',
    `in_use_date` DATE COMMENT 'Timestamp capturing the in use date associated with the laboratory reagent lot record.',
    `in_use_expiration_date` DATE COMMENT 'Timestamp capturing the in use expiration date associated with the laboratory reagent lot record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory reagent lot record.',
    `lot_number` STRING COMMENT 'The lot number of the laboratory reagent lot record.',
    `lot_status` STRING COMMENT 'The lot status value classifying the laboratory reagent lot record.',
    `manufacturer` STRING COMMENT 'The manufacturer of the laboratory reagent lot record.',
    `manufacturer_lot_number` STRING COMMENT 'The manufacturer lot number of the laboratory reagent lot record.',
    `msds_document_url` STRING COMMENT 'The msds document url of the laboratory reagent lot record.',
    `open_date` DATE COMMENT 'Timestamp capturing the open date associated with the laboratory reagent lot record.',
    `opened_date` DATE COMMENT 'Timestamp capturing the opened date associated with the laboratory reagent lot record.',
    `product_name` STRING COMMENT 'The product name of the laboratory reagent lot record.',
    `qc_validated_flag` BOOLEAN COMMENT 'The qc validated flag of the laboratory reagent lot record.',
    `qc_validation_status` STRING COMMENT 'The qc validation status value classifying the laboratory reagent lot record.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The quantity on hand of the laboratory reagent lot record.',
    `quantity_received` STRING COMMENT 'The quantity received of the laboratory reagent lot record.',
    `quantity_remaining` STRING COMMENT 'The quantity remaining of the laboratory reagent lot record.',
    `reagent_name` STRING COMMENT 'The reagent name of the laboratory reagent lot record.',
    `reagent_type` STRING COMMENT 'The reagent type value classifying the laboratory reagent lot record.',
    `recall_flag` BOOLEAN COMMENT 'The recall flag of the laboratory reagent lot record.',
    `recall_reason` STRING COMMENT 'The recall reason of the laboratory reagent lot record.',
    `recalled_flag` BOOLEAN COMMENT 'The recalled flag of the laboratory reagent lot record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the laboratory reagent lot record.',
    `reagent_lot_status` STRING COMMENT 'The reagent lot status value classifying the laboratory reagent lot record.',
    `storage_conditions` STRING COMMENT 'The storage conditions of the laboratory reagent lot record.',
    `storage_location` STRING COMMENT 'The storage location of the laboratory reagent lot record.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'The storage temperature c of the laboratory reagent lot record.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the laboratory reagent lot record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory reagent lot record.',
    `validation_status` STRING COMMENT 'The validation status value classifying the laboratory reagent lot record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory reagent lot record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory reagent lot record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory reagent lot record.',
    CONSTRAINT pk_reagent_lot PRIMARY KEY(`reagent_lot_id`)
) COMMENT 'Master record for laboratory reagent and consumable lots used in analytical testing. Tracks reagent name, manufacturer, catalog number, lot number, expiration date, receipt date, storage requirements (temperature, light sensitivity), open/unopened status, assigned instrument or test method, QC validation status (passed, failed, pending), and quantity on hand. Supports CLIA reagent documentation requirements, lot-to-lot validation tracking, lot-to-result traceability for quality investigations, and integration with supply chain for reorder management. Owned by the laboratory domain because reagent lot management is a CLIA-regulated laboratory function distinct from general supply chain inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` (
    `test_coverage_policy_id` BIGINT COMMENT 'Unique identifier for the test coverage policy within the laboratory test coverage policy record.',
    `coverage_policy_id` BIGINT COMMENT 'Unique identifier for the coverage policy within the laboratory test coverage policy record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the laboratory test coverage policy record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the laboratory test coverage policy record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the laboratory test coverage policy record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory test coverage policy record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory test coverage policy record.',
    `age_restriction` STRING COMMENT 'The age restriction of the laboratory test coverage policy record.',
    `authorization_required` BOOLEAN COMMENT 'The authorization required of the laboratory test coverage policy record.',
    `authorization_required_flag` BOOLEAN COMMENT 'The authorization required flag of the laboratory test coverage policy record.',
    `clinical_criteria` STRING COMMENT 'The clinical criteria of the laboratory test coverage policy record.',
    `coverage_determination_date` DATE COMMENT 'Timestamp capturing the coverage determination date associated with the laboratory test coverage policy record.',
    `coverage_status` STRING COMMENT 'The coverage status value classifying the laboratory test coverage policy record.',
    `covered_diagnosis_codes` STRING COMMENT 'The covered diagnosis codes of the laboratory test coverage policy record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory test coverage policy record.',
    `diagnosis_restriction` STRING COMMENT 'The diagnosis restriction of the laboratory test coverage policy record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory test coverage policy record.',
    `exclusion_criteria` STRING COMMENT 'The exclusion criteria of the laboratory test coverage policy record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory test coverage policy record.',
    `frequency_limit` STRING COMMENT 'The frequency limit of the laboratory test coverage policy record.',
    `frequency_limitation` STRING COMMENT 'The frequency limitation of the laboratory test coverage policy record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory test coverage policy record.',
    `lcd_number` STRING COMMENT 'The lcd number of the laboratory test coverage policy record.',
    `medical_necessity_criteria` STRING COMMENT 'The medical necessity criteria of the laboratory test coverage policy record.',
    `ncd_number` STRING COMMENT 'The ncd number of the laboratory test coverage policy record.',
    `non_covered_reason` STRING COMMENT 'The non covered reason of the laboratory test coverage policy record.',
    `notes` STRING COMMENT 'The notes of the laboratory test coverage policy record.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The patient responsibility amount of the laboratory test coverage policy record.',
    `policy_document_url` STRING COMMENT 'The policy document url of the laboratory test coverage policy record.',
    `policy_name` STRING COMMENT 'The policy name of the laboratory test coverage policy record.',
    `policy_number` STRING COMMENT 'The policy number of the laboratory test coverage policy record.',
    `policy_source` STRING COMMENT 'The policy source of the laboratory test coverage policy record.',
    `policy_type` STRING COMMENT 'The policy type value classifying the laboratory test coverage policy record.',
    `prior_auth_required` BOOLEAN COMMENT 'The prior auth required of the laboratory test coverage policy record.',
    `prior_auth_required_flag` BOOLEAN COMMENT 'The prior auth required flag of the laboratory test coverage policy record.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'The prior authorization required flag of the laboratory test coverage policy record.',
    `reimbursement_rate` DECIMAL(18,2) COMMENT 'The reimbursement rate of the laboratory test coverage policy record.',
    `test_coverage_policy_status` STRING COMMENT 'The test coverage policy status value classifying the laboratory test coverage policy record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the laboratory test coverage policy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory test coverage policy record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory test coverage policy record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory test coverage policy record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory test coverage policy record.',
    CONSTRAINT pk_test_coverage_policy PRIMARY KEY(`test_coverage_policy_id`)
) COMMENT 'This association product represents the coverage determination between laboratory tests and payer coverage policies. It captures the specific coverage rules, authorization requirements, and clinical criteria that apply when a specific lab test is ordered under a specific payer policy. Each record links one test catalog entry to one coverage policy with attributes that define the coverage terms, medical necessity criteria, and authorization workflow for that specific test-policy combination.. Existence Justification: In healthcare operations, each laboratory test can have different coverage determinations across multiple payer policies (e.g., a genetic test may be covered with prior authorization by Blue Cross, excluded by Medicare, and covered without authorization by Aetna). Conversely, each coverage policy applies to hundreds or thousands of different lab tests with varying authorization requirements, frequency limits, and medical necessity criteria. Payers actively manage these test-policy coverage determinations as operational records, updating authorization requirements, adding/removing tests from coverage, and modifying clinical criteria on an ongoing basis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` (
    `study_test_requirement_id` BIGINT COMMENT 'Unique identifier for the study test requirement within the laboratory study test requirement record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the laboratory study test requirement record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the laboratory study test requirement record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the laboratory study test requirement record.',
    `study_visit_id` BIGINT COMMENT 'Unique identifier for the study visit within the laboratory study test requirement record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory study test requirement record.',
    `central_lab_flag` BOOLEAN COMMENT 'The central lab flag of the laboratory study test requirement record.',
    `collection_instructions` STRING COMMENT 'The collection instructions of the laboratory study test requirement record.',
    `collection_window_days` STRING COMMENT 'The collection window days of the laboratory study test requirement record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory study test requirement record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory study test requirement record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory study test requirement record.',
    `frequency` STRING COMMENT 'The frequency of the laboratory study test requirement record.',
    `local_lab_flag` BOOLEAN COMMENT 'The local lab flag of the laboratory study test requirement record.',
    `mandatory_flag` BOOLEAN COMMENT 'The mandatory flag of the laboratory study test requirement record.',
    `notes` STRING COMMENT 'The notes of the laboratory study test requirement record.',
    `processing_instructions` STRING COMMENT 'The processing instructions of the laboratory study test requirement record.',
    `protocol_reference` STRING COMMENT 'The protocol reference of the laboratory study test requirement record.',
    `protocol_section` STRING COMMENT 'The protocol section of the laboratory study test requirement record.',
    `protocol_visit_name` STRING COMMENT 'The protocol visit name of the laboratory study test requirement record.',
    `required_flag` BOOLEAN COMMENT 'The required flag of the laboratory study test requirement record.',
    `requirement_name` STRING COMMENT 'The requirement name of the laboratory study test requirement record.',
    `requirement_status` STRING COMMENT 'The requirement status value classifying the laboratory study test requirement record.',
    `shipping_instructions` STRING COMMENT 'The shipping instructions of the laboratory study test requirement record.',
    `specimen_handling_instructions` STRING COMMENT 'The specimen handling instructions of the laboratory study test requirement record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory study test requirement record.',
    `specimen_volume` STRING COMMENT 'The specimen volume of the laboratory study test requirement record.',
    `sponsor_billed_flag` BOOLEAN COMMENT 'The sponsor billed flag of the laboratory study test requirement record.',
    `study_test_requirement_status` STRING COMMENT 'The study test requirement status value classifying the laboratory study test requirement record.',
    `storage_requirements` STRING COMMENT 'The storage requirements of the laboratory study test requirement record.',
    `study_day` STRING COMMENT 'The study day of the laboratory study test requirement record.',
    `test_name` STRING COMMENT 'The test name of the laboratory study test requirement record.',
    `timepoint` STRING COMMENT 'The timepoint of the laboratory study test requirement record.',
    `timing_window` STRING COMMENT 'The timing window of the laboratory study test requirement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory study test requirement record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory study test requirement record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory study test requirement record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory study test requirement record.',
    `visit_name` STRING COMMENT 'The visit name of the laboratory study test requirement record.',
    `visit_window_days` STRING COMMENT 'The visit window days of the laboratory study test requirement record.',
    CONSTRAINT pk_study_test_requirement PRIMARY KEY(`study_test_requirement_id`)
) COMMENT 'This association product represents the protocol-specific laboratory test requirements for research studies. It captures which laboratory tests are required for each research protocol, including visit scheduling, collection timepoints, coverage determination, and whether tests are standard-of-care or research-only. Each record links one test from the test catalog to one research study with protocol-specific collection and coverage metadata that exists only in the context of this research protocol requirement.. Existence Justification: Research protocols routinely require multiple laboratory tests (CBC, CMP, tumor markers, pharmacokinetic assays, etc.) across different visit timepoints, and each laboratory test can be used across multiple research studies with different protocol-specific requirements. Research coordinators actively manage these study test requirements as operational entities, tracking protocol-mandated collection schedules, coverage determination (sponsor-paid vs. standard-of-care), visit timepoints, and collection frequencies that vary by protocol.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` (
    `lab_fee_schedule_line_id` BIGINT COMMENT 'Unique identifier for the lab fee schedule line within the laboratory lab fee schedule line record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the laboratory lab fee schedule line record.',
    `fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fee schedule within the laboratory lab fee schedule line record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the laboratory lab fee schedule line record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory lab fee schedule line record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory lab fee schedule line record.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The allowed amount of the laboratory lab fee schedule line record.',
    `base_fee_amount` DECIMAL(18,2) COMMENT 'The base fee amount of the laboratory lab fee schedule line record.',
    `billing_unit` STRING COMMENT 'The billing unit of the laboratory lab fee schedule line record.',
    `cdm_code` STRING COMMENT 'The cdm code value classifying the laboratory lab fee schedule line record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory lab fee schedule line record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory lab fee schedule line record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the laboratory lab fee schedule line record.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The fee amount of the laboratory lab fee schedule line record.',
    `hcpcs_code` STRING COMMENT 'The hcpcs code value classifying the laboratory lab fee schedule line record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory lab fee schedule line record.',
    `line_status` STRING COMMENT 'The line status value classifying the laboratory lab fee schedule line record.',
    `medicaid_rate` DECIMAL(18,2) COMMENT 'The medicaid rate of the laboratory lab fee schedule line record.',
    `medicare_rate` DECIMAL(18,2) COMMENT 'The medicare rate of the laboratory lab fee schedule line record.',
    `modifier` STRING COMMENT 'The modifier of the laboratory lab fee schedule line record.',
    `modifier_1` STRING COMMENT 'The modifier 1 of the laboratory lab fee schedule line record.',
    `modifier_2` STRING COMMENT 'The modifier 2 of the laboratory lab fee schedule line record.',
    `modifier_code` STRING COMMENT 'The modifier code value classifying the laboratory lab fee schedule line record.',
    `negotiated_rate` DECIMAL(18,2) COMMENT 'The negotiated rate of the laboratory lab fee schedule line record.',
    `notes` STRING COMMENT 'The notes of the laboratory lab fee schedule line record.',
    `place_of_service` STRING COMMENT 'The place of service of the laboratory lab fee schedule line record.',
    `stat_surcharge_amount` DECIMAL(18,2) COMMENT 'The stat surcharge amount of the laboratory lab fee schedule line record.',
    `lab_fee_schedule_line_status` STRING COMMENT 'The lab fee schedule line status value classifying the laboratory lab fee schedule line record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the laboratory lab fee schedule line record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory lab fee schedule line record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory lab fee schedule line record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory lab fee schedule line record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory lab fee schedule line record.',
    CONSTRAINT pk_lab_fee_schedule_line PRIMARY KEY(`lab_fee_schedule_line_id`)
) COMMENT 'This association product represents the contracted reimbursement rate between a specific laboratory test and a payer fee schedule. It captures the negotiated payment terms, authorization requirements, and service delivery constraints that exist only in the context of this payer-test combination. Each record links one test from the test catalog to one fee schedule with the contracted rate, effective dates, and billing modifiers specific to that payer-test relationship. This is the operational record used by revenue cycle systems for claim pricing, underpayment detection, and contract compliance validation.. Existence Justification: In healthcare revenue cycle operations, each laboratory test has different contracted reimbursement rates across multiple payer fee schedules (e.g., Test X reimbursed at $50 by Blue Cross, $45 by Aetna, $60 by Medicare Advantage Plan Y). Conversely, each payer fee schedule covers hundreds or thousands of laboratory tests, each with its own negotiated rate, authorization requirements, and billing rules. This is a true operational many-to-many relationship that revenue cycle teams actively manage for claim pricing, underpayment detection, and contract compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` (
    `instrument_policy_compliance_id` BIGINT COMMENT 'Unique identifier for the instrument policy compliance within the laboratory instrument policy compliance record.',
    `audit_finding_id` BIGINT COMMENT 'Added to expand thin product compliance.instrument_policy_compliance',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the laboratory instrument policy compliance record.',
    `clia_certificate_id` BIGINT COMMENT 'Unique identifier for the clia certificate within the laboratory instrument policy compliance record.',
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy within the laboratory instrument policy compliance record.',
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the compliance program within the laboratory instrument policy compliance record.',
    `corrective_action_plan_id` BIGINT COMMENT 'Added to expand thin product compliance.instrument_policy_compliance',
    `employee_id` BIGINT COMMENT 'Unique identifier for the instrument assessed by employee within the laboratory instrument policy compliance record.',
    `instrument_assessor_employee_id` BIGINT COMMENT 'Unique identifier for the instrument assessor employee within the laboratory instrument policy compliance record.',
    `instrument_corrective_action_plan_id` BIGINT COMMENT 'Corrective action plan addressing findings',
    `instrument_id` BIGINT COMMENT 'Unique identifier for the instrument within the laboratory instrument policy compliance record.',
    `monitoring_activity_id` BIGINT COMMENT 'Unique identifier for the monitoring activity within the laboratory instrument policy compliance record.',
    `policy_version_id` BIGINT COMMENT 'Added to expand thin product compliance.instrument_policy_compliance',
    `reviewer_employee_id` BIGINT COMMENT 'Added to expand thin product workforce.instrument_policy_compliance',
    `assessed_by` STRING COMMENT 'The assessed by of the laboratory instrument policy compliance record.',
    `assessment_date` DATE COMMENT 'Timestamp capturing the assessment date associated with the laboratory instrument policy compliance record.',
    `assessment_type` STRING COMMENT 'Type of compliance assessment',
    `attestation_date` DATE COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `attestation_flag` BOOLEAN COMMENT 'The attestation flag of the laboratory instrument policy compliance record.',
    `attestation_status` STRING COMMENT 'The attestation status value classifying the laboratory instrument policy compliance record.',
    `audit_finding_count` STRING COMMENT 'Number of audit findings',
    `audit_trail_reference` STRING COMMENT 'Reference to audit trail',
    `compliance_category` STRING COMMENT 'Category of compliance (safety, quality, regulatory, operational)',
    `compliance_deficiency_count` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `compliance_status` STRING COMMENT 'The compliance status value classifying the laboratory instrument policy compliance record.',
    `compliance_type` STRING COMMENT 'The compliance type value classifying the laboratory instrument policy compliance record.',
    `corrective_action` STRING COMMENT 'The corrective action of the laboratory instrument policy compliance record.',
    `corrective_action_completed_date` DATE COMMENT 'Date when corrective action was completed.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing required corrective actions.',
    `corrective_action_plan` STRING COMMENT 'The corrective action plan of the laboratory instrument policy compliance record.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required for non-compliance.',
    `corrective_action_status` STRING COMMENT 'The corrective action status value classifying the laboratory instrument policy compliance record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory instrument policy compliance record.',
    `critical_finding_count` STRING COMMENT 'Number of critical findings requiring immediate action',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the laboratory instrument policy compliance record.',
    `evaluation_date` DATE COMMENT 'Timestamp capturing the evaluation date associated with the laboratory instrument policy compliance record.',
    `evidence_document_reference` BIGINT COMMENT 'Added to expand thin product laboratory.instrument_policy_compliance',
    `exception_reason` STRING COMMENT 'Added to expand thin product laboratory.instrument_policy_compliance',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the laboratory instrument policy compliance record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the laboratory instrument policy compliance record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the laboratory instrument policy compliance record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the laboratory instrument policy compliance record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the laboratory instrument policy compliance record.',
    `finding_count` STRING COMMENT 'Number of compliance findings identified',
    `finding_description` STRING COMMENT 'The finding description of the laboratory instrument policy compliance record.',
    `finding_severity` STRING COMMENT 'The finding severity of the laboratory instrument policy compliance record.',
    `finding_summary` STRING COMMENT 'The finding summary of the laboratory instrument policy compliance record.',
    `last_assessment_date` DATE COMMENT 'Timestamp capturing the last assessment date associated with the laboratory instrument policy compliance record.',
    `last_review_date` DATE COMMENT 'Added to expand thin product laboratory.instrument_policy_compliance',
    `next_assessment_date` DATE COMMENT 'Timestamp capturing the next assessment date associated with the laboratory instrument policy compliance record.',
    `next_evaluation_date` DATE COMMENT 'Timestamp capturing the next evaluation date associated with the laboratory instrument policy compliance record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the laboratory instrument policy compliance record.',
    `non_compliance_notes` STRING COMMENT 'The non compliance notes of the laboratory instrument policy compliance record.',
    `notes` STRING COMMENT 'The notes of the laboratory instrument policy compliance record.',
    `policy_category` STRING COMMENT 'Category of the compliance policy (e.g., calibration, maintenance, safety).',
    `policy_effective_from` DATE COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `policy_effective_to` DATE COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `policy_requirement` STRING COMMENT 'The policy requirement of the laboratory instrument policy compliance record.',
    `policy_version` STRING COMMENT 'Version of the compliance policy assessed',
    `regulatory_authority` STRING COMMENT 'Regulatory authority requiring compliance (CLIA, CAP, FDA, state)',
    `remediation_action` STRING COMMENT 'The remediation action of the laboratory instrument policy compliance record.',
    `remediation_completed_date` DATE COMMENT 'Date remediation was completed',
    `remediation_due_date` DATE COMMENT 'Due date for remediation completion',
    `remediation_plan` STRING COMMENT 'Plan to remediate non-compliance issues',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance (e.g., high, medium, low).',
    `risk_rating` STRING COMMENT 'Added to expand thin product laboratory.instrument_policy_compliance',
    `instrument_policy_compliance_status` STRING COMMENT 'The instrument policy compliance status value classifying the laboratory instrument policy compliance record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory instrument policy compliance record.',
    `verification_evidence` STRING COMMENT 'Evidence supporting compliance verification',
    `verification_method` STRING COMMENT 'Method used to verify compliance',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory instrument policy compliance record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory instrument policy compliance record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory instrument policy compliance record.',
    `waiver_expiration_date` DATE COMMENT 'Timestamp capturing the waiver expiration date associated with the laboratory instrument policy compliance record.',
    `waiver_justification` STRING COMMENT 'The waiver justification of the laboratory instrument policy compliance record.',
    CONSTRAINT pk_instrument_policy_compliance PRIMARY KEY(`instrument_policy_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between laboratory instruments and organizational policies. It captures which policies apply to which instruments and tracks the compliance status, assessment dates, and attestation status for each instrument-policy pairing. Each record links one instrument to one policy with attributes that exist only in the context of this compliance relationship.. Existence Justification: In healthcare laboratory operations, instruments are governed by multiple organizational policies simultaneously (maintenance policy, quality control policy, safety policy, calibration policy, CLIA compliance policy), and each policy applies to multiple instruments across the laboratory. The compliance relationship itself carries operational data including compliance status, assessment dates, review schedules, and attestation status that belong to neither the instrument nor the policy alone but to the specific instrument-policy pairing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`organism` (
    `organism_id` BIGINT COMMENT 'Unique identifier for the organism within the laboratory organism record.',
    `parent_organism_id` BIGINT COMMENT 'Unique identifier for the parent organism within the laboratory organism record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the snomed concept within the laboratory organism record.',
    `taxonomy_id` BIGINT COMMENT 'Unique identifier for the taxonomy within the laboratory organism record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the laboratory organism record.',
    `antibiotic_resistance_profile` STRING COMMENT 'The antibiotic resistance profile of the laboratory organism record.',
    `biosafety_level` STRING COMMENT 'The biosafety level of the laboratory organism record.',
    `organism_category` STRING COMMENT 'The organism category of the laboratory organism record.',
    `cdc_reportable_flag` BOOLEAN COMMENT 'The cdc reportable flag of the laboratory organism record.',
    `clinical_significance` STRING COMMENT 'The clinical significance of the laboratory organism record.',
    `organism_code` STRING COMMENT 'The organism code value classifying the laboratory organism record.',
    `common_name` STRING COMMENT 'The common name of the laboratory organism record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory organism record.',
    `family` STRING COMMENT 'The family of the laboratory organism record.',
    `genus` STRING COMMENT 'The genus of the laboratory organism record.',
    `gram_stain` STRING COMMENT 'The gram stain of the laboratory organism record.',
    `gram_stain_class` STRING COMMENT 'The gram stain class of the laboratory organism record.',
    `gram_stain_classification` STRING COMMENT 'The gram stain classification of the laboratory organism record.',
    `is_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating the is reportable flag status of the laboratory organism record.',
    `loinc_code` STRING COMMENT 'The loinc code value classifying the laboratory organism record.',
    `mdro_classification` STRING COMMENT 'The mdro classification of the laboratory organism record.',
    `mdro_flag` BOOLEAN COMMENT 'The mdro flag of the laboratory organism record.',
    `morphology` STRING COMMENT 'The morphology of the laboratory organism record.',
    `organism_name` STRING COMMENT 'The organism name of the laboratory organism record.',
    `notes` STRING COMMENT 'The notes of the laboratory organism record.',
    `organism_type` STRING COMMENT 'The organism type value classifying the laboratory organism record.',
    `reportable_flag` BOOLEAN COMMENT 'The reportable flag of the laboratory organism record.',
    `scientific_name` STRING COMMENT 'The scientific name of the laboratory organism record.',
    `snomed_code` STRING COMMENT 'The snomed code value classifying the laboratory organism record.',
    `species` STRING COMMENT 'The species of the laboratory organism record.',
    `organism_status` STRING COMMENT 'The organism status value classifying the laboratory organism record.',
    `subspecies` STRING COMMENT 'The subspecies of the laboratory organism record.',
    `typical_specimen_sources` STRING COMMENT 'The typical specimen sources of the laboratory organism record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory organism record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory organism record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory organism record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the laboratory organism record.',
    CONSTRAINT pk_organism PRIMARY KEY(`organism_id`)
) COMMENT 'Master reference table for organism. Referenced by organism_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_parent_specimen_id` FOREIGN KEY (`parent_specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`organism`(`organism_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`organism`(`organism_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_blood_bank_unit_id` FOREIGN KEY (`blood_bank_unit_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`(`blood_bank_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_previous_result_point_of_care_test_id` FOREIGN KEY (`previous_result_point_of_care_test_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`point_of_care_test`(`point_of_care_test_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_qc_run_id` FOREIGN KEY (`qc_run_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`qc_run`(`qc_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_clia_certificate_id` FOREIGN KEY (`clia_certificate_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`clia_certificate`(`clia_certificate_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_clia_certificate_id` FOREIGN KEY (`clia_certificate_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`clia_certificate`(`clia_certificate_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_clia_certificate_id` FOREIGN KEY (`clia_certificate_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`clia_certificate`(`clia_certificate_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_parent_organism_id` FOREIGN KEY (`parent_organism_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`organism`(`organism_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('pii_domain' = 'laboratory');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_received_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `source` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_amending_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_amending_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_resulting_clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_released_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_unit` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_subdomain' = 'catalog_reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_sensitivity' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('pii_sensitivity' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `organism_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_panel_performed` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_result_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `microbiology_culture_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `organism_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_class` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `loinc_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_comment` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `snomed_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_interpretation` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptible_breakpoint` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `transfusion_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_event_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `employee_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_administering_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_administering_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_pulse` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_respiratory_rate` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_temperature` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_pulse` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_respiratory_rate` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_temperature` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_onset_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_end_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_rate` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_occurred` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_site` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_start_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `point_performed_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `point_performed_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `previous_result_point_of_care_test_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `corrected_result_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_comment` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_numeric` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_unit` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_performed_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_performed_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `observed_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_graded_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_submitted_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `result_unit_of_measure` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_subdomain' = 'catalog_reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_subdomain' = 'revenue_coverage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cms_condition_status_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_subdomain' = 'testing_operations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_interpretation` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pathogenicity_classification` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pathogenicity_classification` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pathogenicity_classification` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pathogenicity_classification` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pathogenicity_classification` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pathogenicity_classification` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_datetime` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `resulted_value` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `product_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `product_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `product_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `product_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `product_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `product_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_conditions` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_subdomain' = 'revenue_coverage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_association_edges' = 'laboratory.test_catalog,insurance.coverage_policy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `clinical_criteria` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `covered_diagnosis_codes` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_restriction` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_subdomain' = 'catalog_reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_association_edges' = 'laboratory.test_catalog,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_visit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_handling_instructions` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_subdomain' = 'revenue_coverage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_association_edges' = 'laboratory.test_catalog,insurance.fee_schedule');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_association_edges' = 'laboratory.instrument,compliance.policy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_assessor_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_assessor_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_category` SET TAGS ('pii_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_subdomain' = 'catalog_reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `typical_specimen_sources` SET TAGS ('pii_mask_non_prod' = 'true');
