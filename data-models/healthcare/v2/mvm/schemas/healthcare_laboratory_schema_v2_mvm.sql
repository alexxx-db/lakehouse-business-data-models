-- Schema for Domain: laboratory | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`laboratory` COMMENT 'Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` (
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory lab order record.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Prior authorization workflow: lab orders with authorization_required=true must be validated against a specific coverage policy. Billing and compliance teams need this link to audit PA determinations, ',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory lab order record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Clinical workflow: a diagnosis drives lab orders (e.g., HbA1c for diabetes, troponin for ACS). Enables medical necessity validation, payer authorization, and CDI reporting. diagnosis_code on lab_order',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory lab order record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Lab orders must be linked to the performing facility (org_provider) for billing, CLIA compliance, and network adequacy reporting. The existing performing_lab_location text column is a denormalized rep',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary lab clinician within the laboratory lab order record.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Procedures generate associated lab orders (pre-op labs, intraoperative blood gases, post-procedure cultures). Surgical workflow and anesthesia safety protocols require linking lab orders to the origin',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Standing order utilization tracking and renewal compliance: recurring lab orders (e.g., weekly CBC for chemotherapy) must reference the authorizing standing_order protocol for utilization reporting, r',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Pre-operative lab clearance is a named surgical workflow: lab orders (CBC, BMP, coagulation panels) are placed specifically against a surgical case for surgical readiness determination. OR scheduling ',
    `tertiary_lab_cancelled_by_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the tertiary lab cancelled by provider clinician within the laboratory lab order record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory lab order record.',
    `triage_assessment_id` BIGINT COMMENT 'Foreign key linking to encounter.triage_assessment. Business justification: ED sepsis and stroke protocols require STAT lab orders triggered directly by triage assessments. Linking lab_order to the initiating triage_assessment supports ED throughput metrics, door-to-lab-resul',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the laboratory lab order record.',
    `authorization_required` BOOLEAN COMMENT 'The authorization required of the laboratory lab order record.',
    `billing_code` STRING COMMENT 'The billing code value classifying the laboratory lab order record.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the laboratory lab order record.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The cancelled timestamp of the laboratory lab order record.',
    `clinical_indication` STRING COMMENT 'The clinical indication of the laboratory lab order record.',
    `collection_date` DATE COMMENT 'Timestamp capturing the collection date associated with the laboratory lab order record.',
    `collection_method` STRING COMMENT 'The collection method of the laboratory lab order record.',
    `collection_timestamp` TIMESTAMP COMMENT 'The collection timestamp of the laboratory lab order record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the laboratory lab order record.',
    `expected_turnaround_time_hours` STRING COMMENT 'The expected turnaround time hours of the laboratory lab order record.',
    `fasting_required` BOOLEAN COMMENT 'The fasting required of the laboratory lab order record.',
    `is_send_out` BOOLEAN COMMENT 'Boolean flag indicating the is send out status of the laboratory lab order record.',
    `lab_order_status` STRING COMMENT 'The lab order status value classifying the laboratory lab order record.',
    `order_date` DATE COMMENT 'Timestamp capturing the order date associated with the laboratory lab order record.',
    `order_number` STRING COMMENT 'The order number of the laboratory lab order record.',
    `order_priority` STRING COMMENT 'The order priority of the laboratory lab order record.',
    `order_set_name` STRING COMMENT 'The order set name of the laboratory lab order record.',
    `order_status` STRING COMMENT 'The order status value classifying the laboratory lab order record.',
    `order_timestamp` TIMESTAMP COMMENT 'The order timestamp of the laboratory lab order record.',
    `point_of_care_test` BOOLEAN COMMENT 'The point of care test of the laboratory lab order record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory lab order record.',
    `reference_lab_accession_number` STRING COMMENT 'The reference lab accession number of the laboratory lab order record.',
    `reference_lab_name` STRING COMMENT 'The reference lab name of the laboratory lab order record.',
    `result_integration_status` STRING COMMENT 'The result integration status value classifying the laboratory lab order record.',
    `result_received_timestamp` TIMESTAMP COMMENT 'The result received timestamp of the laboratory lab order record.',
    `shipping_carrier` STRING COMMENT 'The shipping carrier of the laboratory lab order record.',
    `shipping_tracking_number` STRING COMMENT 'The shipping tracking number of the laboratory lab order record.',
    `specimen_shipped_timestamp` TIMESTAMP COMMENT 'The specimen shipped timestamp of the laboratory lab order record.',
    `specimen_source` STRING COMMENT 'The specimen source of the laboratory lab order record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory lab order record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory lab order record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory lab order record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory lab order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_lab_order PRIMARY KEY(`lab_order_id`)
) COMMENT 'Core transactional record of every laboratory test order placed via CPOE (Computerized Physician Order Entry) in Epic Beaker or Cerner PathNet, including orders routed to external reference laboratories (send-outs). Captures the ordering provider, ordering encounter, ordered test (LOINC code from test catalog), order priority (STAT, routine, ASAP, timed), order status lifecycle (ordered, collected, in-process, sent-out, resulted, cancelled), clinical indication, order date/time, source system identifiers. For send-out orders: reference lab name, reference lab accession number, specimen shipping date/time, shipping carrier and tracking, expected turnaround time, result receipt date/time, and result integration status. SSOT for all lab order identity and lifecycle within the laboratory domain, including both internal and send-out orders.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` (
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory specimen record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory specimen record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the laboratory specimen record.',
    `parent_specimen_id` BIGINT COMMENT 'Unique identifier for the parent specimen within the laboratory specimen record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Specimens are received and processed at specific org_provider facilities. CAP/CLIA accreditation audits and chain-of-custody workflows require a proper FK to the receiving facility. The receiving_lab_',
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
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory test result record.',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory test result record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Test results must be traceable to the performing org_provider facility for CLIA compliance, result routing, and quality management reporting. The performing_lab_facility text column is a denormalized ',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary test clinician within the laboratory test result record.',
    `reference_range_id` BIGINT COMMENT 'Unique identifier for the reference range within the laboratory test result record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory test result record.',
    `tertiary_test_ordering_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the tertiary test ordering provider clinician within the laboratory test result record.',
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory test result record.',
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
    `test_code` STRING COMMENT 'The test code value classifying the laboratory test result record.',
    `test_name` STRING COMMENT 'The test name of the laboratory test result record.',
    `test_result_status` STRING COMMENT 'The test result status value classifying the laboratory test result record.',
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
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: A reference range defines normal/abnormal/critical thresholds for a specific laboratory test. The test_catalog is the authoritative master of all tests. Adding test_catalog_id to reference_range estab',
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
    `reference_range_status` STRING COMMENT 'The reference range status value classifying the laboratory reference range record.',
    `review_status` STRING COMMENT 'The review status value classifying the laboratory reference range record.',
    `sample_size` STRING COMMENT 'The sample size of the laboratory reference range record.',
    `sex` STRING COMMENT 'The sex of the laboratory reference range record.',
    `source_citation` STRING COMMENT 'The source citation of the laboratory reference range record.',
    `source_type` STRING COMMENT 'The source type value classifying the laboratory reference range record.',
    `statistical_method` STRING COMMENT 'The statistical method of the laboratory reference range record.',
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
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Pathology and molecular testing (IHC, molecular_testing_results) are governed by specific payer coverage policies with medical necessity criteria. Pathology billing teams reference coverage policies f',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory pathology report record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Pathology reports establish or confirm coded diagnoses (cancer staging, histologic diagnosis). Cancer registry reporting, CDI query workflows, and ICD-10 coding validation require linking pathology_re',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory pathology report record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the laboratory pathology report record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Pathology reports must be linked to the performing laboratory facility (org_provider) for CAP accreditation, billing, and result routing. The performing_laboratory text column is a denormalized repres',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary pathology clinician within the laboratory pathology report record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the laboratory pathology report record.',
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
    `pathology_report_status` STRING COMMENT 'The pathology report status value classifying the laboratory pathology report record.',
    `preliminary_report_timestamp` TIMESTAMP COMMENT 'The preliminary report timestamp of the laboratory pathology report record.',
    `received_date` DATE COMMENT 'Timestamp capturing the received date associated with the laboratory pathology report record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory pathology report record.',
    `report_status` STRING COMMENT 'The report status value classifying the laboratory pathology report record.',
    `report_type` STRING COMMENT 'The report type value classifying the laboratory pathology report record.',
    `sign_out_timestamp` TIMESTAMP COMMENT 'The sign out timestamp of the laboratory pathology report record.',
    `special_stains_performed` STRING COMMENT 'The special stains performed of the laboratory pathology report record.',
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
    `bed_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.bed_assignment. Business justification: HAI surveillance and infection control outbreak investigations require linking positive cultures to the specific bed/unit where the patient was located at time of specimen collection. This supports NH',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the laboratory microbiology culture record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the laboratory microbiology culture record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Infection diagnoses (sepsis, pneumonia, UTI) are directly linked to microbiology culture results for antibiotic stewardship program reporting, HAI surveillance, and infection control dashboards. Regul',
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the lab order within the laboratory microbiology culture record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Microbiology cultures are processed at specific org_provider facilities. Public health HAI/MDRO reporting and infection control workflows (flags already on this table) require knowing which facility p',
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
    `microbiology_culture_status` STRING COMMENT 'The microbiology culture status value classifying the laboratory microbiology culture record.',
    `morphology` STRING COMMENT 'The morphology of the laboratory microbiology culture record.',
    `public_health_reportable_flag` BOOLEAN COMMENT 'The public health reportable flag of the laboratory microbiology culture record.',
    `quality_control_passed_flag` BOOLEAN COMMENT 'The quality control passed flag of the laboratory microbiology culture record.',
    `received_datetime` TIMESTAMP COMMENT 'Timestamp capturing the received datetime associated with the laboratory microbiology culture record.',
    `result_comments` STRING COMMENT 'The result comments of the laboratory microbiology culture record.',
    `result_datetime` TIMESTAMP COMMENT 'Timestamp capturing the result datetime associated with the laboratory microbiology culture record.',
    `result_interpretation` STRING COMMENT 'The result interpretation of the laboratory microbiology culture record.',
    `specimen_source_code` STRING COMMENT 'The specimen source code value classifying the laboratory microbiology culture record.',
    `susceptibility_method` STRING COMMENT 'The susceptibility method of the laboratory microbiology culture record.',
    `susceptibility_panel_performed` BOOLEAN COMMENT 'The susceptibility panel performed of the laboratory microbiology culture record.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'The turnaround time hours of the laboratory microbiology culture record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the laboratory microbiology culture record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the laboratory microbiology culture record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the laboratory microbiology culture record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_microbiology_culture PRIMARY KEY(`microbiology_culture_id`)
) COMMENT 'Transactional record for microbiology culture and sensitivity (C&S) testing. Tracks organism identification (SNOMED CT coded), culture type (aerobic, anaerobic, fungal, AFB, viral), growth result, colony count, isolation date/time, and the associated antimicrobial susceptibility panel. Supports infection control surveillance, antibiotic stewardship programs, and HAI (Healthcare-Associated Infection) reporting including CLABSI and CAUTI tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` (
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the blood bank unit within the laboratory blood bank unit record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the crossmatch specimen within the laboratory blood bank unit record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Blood bank units are issued from specific org_provider facilities. AABB transfusion medicine standards and blood product traceability require a proper FK to the issuing facility. The issued_to_locatio',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Blood bank transfusion requests are placed as laboratory orders (CPOE). A blood_bank_unit is issued in fulfillment of a transfusion lab order. Adding lab_order_id to blood_bank_unit links each blood p',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Transfusion medicine requires direct patient identity linkage for blood unit reservation, issuance, and post-transfusion reaction tracking. AABB regulatory standards mandate traceable patient-unit ass',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Blood product reservation and transfusion tracking per surgical case is a core blood bank workflow. surgical_case.requires_blood_products flag drives blood bank reservations; linking blood_bank_unit t',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Transfusion administration must be tied to the patient encounter for billing, transfusion reaction investigation, blood utilization reporting, and Joint Commission compliance. blood_bank_unit currentl',
    `abo_blood_group` STRING COMMENT 'The abo blood group of the laboratory blood bank unit record.',
    `bacterial_contamination_testing_status` STRING COMMENT 'The bacterial contamination testing status value classifying the laboratory blood bank unit record.',
    `blood_bank_unit_status` STRING COMMENT 'The blood bank unit status value classifying the laboratory blood bank unit record.',
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
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the laboratory blood bank unit record.',
    `leukoreduction_status` STRING COMMENT 'The leukoreduction status value classifying the laboratory blood bank unit record.',
    `lot_number` STRING COMMENT 'The lot number of the laboratory blood bank unit record.',
    `product_code` STRING COMMENT 'The product code value classifying the laboratory blood bank unit record.',
    `product_type` STRING COMMENT 'The product type value classifying the laboratory blood bank unit record.',
    `quarantine_reason` STRING COMMENT 'The quarantine reason of the laboratory blood bank unit record.',
    `quarantine_timestamp` TIMESTAMP COMMENT 'The quarantine timestamp of the laboratory blood bank unit record.',
    `record_number` BIGINT COMMENT 'The record number of the laboratory blood bank unit record.',
    `reservation_timestamp` TIMESTAMP COMMENT 'The reservation timestamp of the laboratory blood bank unit record.',
    `return_timestamp` TIMESTAMP COMMENT 'The return timestamp of the laboratory blood bank unit record.',
    `rh_type` STRING COMMENT 'The rh type value classifying the laboratory blood bank unit record.',
    `special_processing_codes` STRING COMMENT 'The special processing codes of the laboratory blood bank unit record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` (
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the test catalog within the laboratory test catalog record.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Lab test-to-CDM mapping: each orderable test in the test catalog must link to its CDM entry for automated charge capture, price transparency reporting (CMS mandate), and ensuring correct CPT/revenue c',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Test catalog entries are facility-specific — each org_provider maintains its own orderable test menu for LIS management and network adequacy reporting. The performing_lab_location text column is a den',
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
    `preferred_volume` STRING COMMENT 'The preferred volume of the laboratory test catalog record.',
    `reference_lab_code` STRING COMMENT 'The reference lab code value classifying the laboratory test catalog record.',
    `reference_lab_name` STRING COMMENT 'The reference lab name of the laboratory test catalog record.',
    `reference_range_adult` STRING COMMENT 'The reference range adult of the laboratory test catalog record.',
    `reference_range_pediatric` STRING COMMENT 'The reference range pediatric of the laboratory test catalog record.',
    `result_type` STRING COMMENT 'The result type value classifying the laboratory test catalog record.',
    `specimen_container` STRING COMMENT 'The specimen container of the laboratory test catalog record.',
    `specimen_stability` STRING COMMENT 'The specimen stability of the laboratory test catalog record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the laboratory test catalog record.',
    `storage_temperature` STRING COMMENT 'The storage temperature of the laboratory test catalog record.',
    `test_abbreviation` STRING COMMENT 'The test abbreviation of the laboratory test catalog record.',
    `test_catalog_status` STRING COMMENT 'The test catalog status value classifying the laboratory test catalog record.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_parent_specimen_id` FOREIGN KEY (`parent_specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_received_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `source` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('dbx_subdomain' = 'result_reporting');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_datetime` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_released_datetime` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_unit` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('dbx_subdomain' = 'result_reporting');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `range_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('dbx_subdomain' = 'diagnostic_services');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_subdomain' = 'diagnostic_services');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `bed_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_datetime` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_panel_performed` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `transfusion_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_mask_non_prod' = 'true');
