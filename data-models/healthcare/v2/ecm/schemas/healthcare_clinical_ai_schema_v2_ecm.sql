-- Schema for Domain: clinical_ai | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`clinical_ai` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` (
    `patient_risk_score_id` BIGINT COMMENT 'Unique identifier for the patient risk score within the clinical ai patient risk score record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the clinical ai patient risk score record.',
    `feature_store_entity_id` BIGINT COMMENT 'Unique identifier for the feature store entity within the clinical ai patient risk score record.',
    `model_card_id` BIGINT COMMENT 'Unique identifier for the model card within the clinical ai patient risk score record.',
    `model_inference_log_id` BIGINT COMMENT 'Unique identifier for the model inference log within the clinical ai patient risk score record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient mpi record within the clinical ai patient risk score record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the quality measure within the clinical ai patient risk score record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the clinical ai patient risk score record.',
    `above_threshold_flag` BOOLEAN COMMENT 'The above threshold flag of the clinical ai patient risk score record.',
    `alert_generated_flag` BOOLEAN COMMENT 'The alert generated flag of the clinical ai patient risk score record.',
    `alert_triggered_flag` BOOLEAN COMMENT 'The alert triggered flag of the clinical ai patient risk score record.',
    `clinical_action_taken` STRING COMMENT 'The clinical action taken of the clinical ai patient risk score record.',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'The confidence interval high of the clinical ai patient risk score record.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'The confidence interval low of the clinical ai patient risk score record.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The confidence interval lower of the clinical ai patient risk score record.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The confidence interval upper of the clinical ai patient risk score record.',
    `confidence_score` DECIMAL(18,2) COMMENT 'The confidence score of the clinical ai patient risk score record.',
    `contributing_factors` STRING COMMENT 'The contributing factors of the clinical ai patient risk score record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai patient risk score record.',
    `deterioration_flag` BOOLEAN COMMENT 'The deterioration flag of the clinical ai patient risk score record.',
    `deterioration_index_score` DECIMAL(18,2) COMMENT 'The deterioration index score of the clinical ai patient risk score record.',
    `deterioration_risk_score` DECIMAL(18,2) COMMENT 'The deterioration risk score of the clinical ai patient risk score record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the clinical ai patient risk score record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the clinical ai patient risk score record.',
    `fall_flag` BOOLEAN COMMENT 'The fall flag of the clinical ai patient risk score record.',
    `fall_risk_score` DECIMAL(18,2) COMMENT 'The fall risk score of the clinical ai patient risk score record.',
    `feature_importance_json` STRING COMMENT 'The feature importance json of the clinical ai patient risk score record.',
    `high_risk_flag` BOOLEAN COMMENT 'The high risk flag of the clinical ai patient risk score record.',
    `intervention_recommendation` STRING COMMENT 'The intervention recommendation of the clinical ai patient risk score record.',
    `intervention_recommended_flag` BOOLEAN COMMENT 'The intervention recommended flag of the clinical ai patient risk score record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the clinical ai patient risk score record.',
    `is_current_flag` BOOLEAN COMMENT 'Boolean flag indicating the is current flag status of the clinical ai patient risk score record.',
    `model_name` STRING COMMENT 'The model name of the clinical ai patient risk score record.',
    `model_version` STRING COMMENT 'The model version of the clinical ai patient risk score record.',
    `prediction_window_days` STRING COMMENT 'The prediction window days of the clinical ai patient risk score record.',
    `readmission_flag` BOOLEAN COMMENT 'The readmission flag of the clinical ai patient risk score record.',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'The readmission risk score of the clinical ai patient risk score record.',
    `reference_period_days` STRING COMMENT 'The reference period days of the clinical ai patient risk score record.',
    `risk_category` STRING COMMENT 'The risk category of the clinical ai patient risk score record.',
    `risk_model_name` STRING COMMENT 'The risk model name of the clinical ai patient risk score record.',
    `risk_model_type` STRING COMMENT 'The risk model type value classifying the clinical ai patient risk score record.',
    `risk_model_version` STRING COMMENT 'The risk model version of the clinical ai patient risk score record.',
    `risk_percentile` DECIMAL(18,2) COMMENT 'The risk percentile of the clinical ai patient risk score record.',
    `risk_probability` DECIMAL(18,2) COMMENT 'The risk probability of the clinical ai patient risk score record.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score of the clinical ai patient risk score record.',
    `risk_score_type` STRING COMMENT 'The risk score type value classifying the clinical ai patient risk score record.',
    `risk_score_value` DECIMAL(18,2) COMMENT 'The risk score value of the clinical ai patient risk score record.',
    `risk_tier` STRING COMMENT 'The risk tier of the clinical ai patient risk score record.',
    `risk_type` STRING COMMENT 'The risk type value classifying the clinical ai patient risk score record.',
    `score_date` DATE COMMENT 'Timestamp capturing the score date associated with the clinical ai patient risk score record.',
    `score_datetime` TIMESTAMP COMMENT 'Timestamp capturing the score datetime associated with the clinical ai patient risk score record.',
    `score_generated_at` TIMESTAMP COMMENT 'Timestamp capturing the score generated at associated with the clinical ai patient risk score record.',
    `score_percentile` DECIMAL(18,2) COMMENT 'The score percentile of the clinical ai patient risk score record.',
    `score_timestamp` TIMESTAMP COMMENT 'The score timestamp of the clinical ai patient risk score record.',
    `score_type` STRING COMMENT 'The score type value classifying the clinical ai patient risk score record.',
    `score_value` DECIMAL(18,2) COMMENT 'The score value of the clinical ai patient risk score record.',
    `scored_timestamp` TIMESTAMP COMMENT 'The scored timestamp of the clinical ai patient risk score record.',
    `scoring_timestamp` TIMESTAMP COMMENT 'The scoring timestamp of the clinical ai patient risk score record.',
    `scoring_window_days` STRING COMMENT 'The scoring window days of the clinical ai patient risk score record.',
    `sepsis_flag` BOOLEAN COMMENT 'The sepsis flag of the clinical ai patient risk score record.',
    `sepsis_risk_score` DECIMAL(18,2) COMMENT 'The sepsis risk score of the clinical ai patient risk score record.',
    `shap_values_json` STRING COMMENT 'The shap values json of the clinical ai patient risk score record.',
    `patient_risk_score_status` STRING COMMENT 'The patient risk score status value classifying the clinical ai patient risk score record.',
    `threshold_crossed_flag` BOOLEAN COMMENT 'The threshold crossed flag of the clinical ai patient risk score record.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value of the clinical ai patient risk score record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai patient risk score record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'The valid from timestamp of the clinical ai patient risk score record.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'The valid to timestamp of the clinical ai patient risk score record.',
    `valid_until_timestamp` TIMESTAMP COMMENT 'The valid until timestamp of the clinical ai patient risk score record.',
    CONSTRAINT pk_patient_risk_score PRIMARY KEY(`patient_risk_score_id`)
) COMMENT 'ML-generated patient risk scores (readmission/sepsis/fall/deterioration)';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` (
    `clinical_nlp_result_id` BIGINT COMMENT 'Unique identifier for the clinical nlp result within the clinical ai clinical nlp result record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the icd code within the clinical ai clinical nlp result record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the clinical ai clinical nlp result record.',
    `model_inference_log_id` BIGINT COMMENT 'Unique identifier for the model inference log within the clinical ai clinical nlp result record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical ai clinical nlp result record.',
    `note_id` BIGINT COMMENT 'Unique identifier for the note within the clinical ai clinical nlp result record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the snomed concept within the clinical ai clinical nlp result record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the clinical ai clinical nlp result record.',
    `assertion_status` STRING COMMENT 'The assertion status value classifying the clinical ai clinical nlp result record.',
    `char_end_offset` STRING COMMENT 'The char end offset of the clinical ai clinical nlp result record.',
    `char_offset_end` STRING COMMENT 'The char offset end of the clinical ai clinical nlp result record.',
    `char_offset_start` STRING COMMENT 'The char offset start of the clinical ai clinical nlp result record.',
    `char_start_offset` STRING COMMENT 'The char start offset of the clinical ai clinical nlp result record.',
    `code_system` STRING COMMENT 'The code system of the clinical ai clinical nlp result record.',
    `concept_code` STRING COMMENT 'The concept code value classifying the clinical ai clinical nlp result record.',
    `concept_code_system` STRING COMMENT 'The concept code system of the clinical ai clinical nlp result record.',
    `confidence_score` DECIMAL(18,2) COMMENT 'The confidence score of the clinical ai clinical nlp result record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai clinical nlp result record.',
    `end_offset` STRING COMMENT 'The end offset of the clinical ai clinical nlp result record.',
    `entity_category` STRING COMMENT 'The entity category of the clinical ai clinical nlp result record.',
    `entity_code` STRING COMMENT 'The entity code value classifying the clinical ai clinical nlp result record.',
    `entity_code_system` STRING COMMENT 'The entity code system of the clinical ai clinical nlp result record.',
    `entity_text` STRING COMMENT 'The entity text of the clinical ai clinical nlp result record.',
    `entity_type` STRING COMMENT 'The entity type value classifying the clinical ai clinical nlp result record.',
    `extracted_at` TIMESTAMP COMMENT 'Timestamp capturing the extracted at associated with the clinical ai clinical nlp result record.',
    `extracted_entity` STRING COMMENT 'The extracted entity of the clinical ai clinical nlp result record.',
    `extracted_text` STRING COMMENT 'The extracted text of the clinical ai clinical nlp result record.',
    `extracted_timestamp` TIMESTAMP COMMENT 'The extracted timestamp of the clinical ai clinical nlp result record.',
    `extraction_timestamp` TIMESTAMP COMMENT 'The extraction timestamp of the clinical ai clinical nlp result record.',
    `extraction_type` STRING COMMENT 'The extraction type value classifying the clinical ai clinical nlp result record.',
    `family_history_flag` BOOLEAN COMMENT 'The family history flag of the clinical ai clinical nlp result record.',
    `icd10_code` STRING COMMENT 'The icd10 code value classifying the clinical ai clinical nlp result record.',
    `model_name` STRING COMMENT 'The model name of the clinical ai clinical nlp result record.',
    `model_version` STRING COMMENT 'The model version of the clinical ai clinical nlp result record.',
    `negation_flag` BOOLEAN COMMENT 'The negation flag of the clinical ai clinical nlp result record.',
    `nlp_model_name` STRING COMMENT 'The nlp model name of the clinical ai clinical nlp result record.',
    `nlp_model_version` STRING COMMENT 'The nlp model version of the clinical ai clinical nlp result record.',
    `nlp_pipeline_version` STRING COMMENT 'The nlp pipeline version of the clinical ai clinical nlp result record.',
    `normalized_concept` STRING COMMENT 'The normalized concept of the clinical ai clinical nlp result record.',
    `processed_timestamp` TIMESTAMP COMMENT 'The processed timestamp of the clinical ai clinical nlp result record.',
    `section_name` STRING COMMENT 'The section name of the clinical ai clinical nlp result record.',
    `span_end` STRING COMMENT 'The span end of the clinical ai clinical nlp result record.',
    `span_end_offset` STRING COMMENT 'The span end offset of the clinical ai clinical nlp result record.',
    `span_start` STRING COMMENT 'The span start of the clinical ai clinical nlp result record.',
    `span_start_offset` STRING COMMENT 'The span start offset of the clinical ai clinical nlp result record.',
    `start_offset` STRING COMMENT 'The start offset of the clinical ai clinical nlp result record.',
    `clinical_nlp_result_status` STRING COMMENT 'The clinical nlp result status value classifying the clinical ai clinical nlp result record.',
    `temporal_status` STRING COMMENT 'The temporal status value classifying the clinical ai clinical nlp result record.',
    `uncertainty_flag` BOOLEAN COMMENT 'The uncertainty flag of the clinical ai clinical nlp result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai clinical nlp result record.',
    CONSTRAINT pk_clinical_nlp_result PRIMARY KEY(`clinical_nlp_result_id`)
) COMMENT 'Clinical NLP NER extractions from unstructured notes';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` (
    `care_gap_id` BIGINT COMMENT 'Unique identifier for the care gap within the clinical ai care gap record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the care measure within the clinical ai care gap record.',
    `care_mpi_record_id` BIGINT COMMENT 'Unique identifier for the care mpi record within the clinical ai care gap record.',
    `care_quality_measure_id` BIGINT COMMENT 'Unique identifier for the care quality measure within the clinical ai care gap record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the clinical ai care gap record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical ai care gap record.',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the clinical ai care gap record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the clinical ai care gap record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the clinical ai care gap record.',
    `care_gap_priority_score` DECIMAL(18,2) COMMENT 'The care gap priority score of the clinical ai care gap record.',
    `closed_date` DATE COMMENT 'Timestamp capturing the closed date associated with the clinical ai care gap record.',
    `closed_flag` BOOLEAN COMMENT 'The closed flag of the clinical ai care gap record.',
    `closure_action` STRING COMMENT 'The closure action of the clinical ai care gap record.',
    `closure_date` DATE COMMENT 'Timestamp capturing the closure date associated with the clinical ai care gap record.',
    `closure_evidence` STRING COMMENT 'The closure evidence of the clinical ai care gap record.',
    `closure_method` STRING COMMENT 'The closure method of the clinical ai care gap record.',
    `closure_reason` STRING COMMENT 'The closure reason of the clinical ai care gap record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai care gap record.',
    `denominator_eligible_flag` BOOLEAN COMMENT 'The denominator eligible flag of the clinical ai care gap record.',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the clinical ai care gap record.',
    `exclusion_flag` BOOLEAN COMMENT 'The exclusion flag of the clinical ai care gap record.',
    `exclusion_reason` STRING COMMENT 'The exclusion reason of the clinical ai care gap record.',
    `gap_closed_at` TIMESTAMP COMMENT 'Timestamp capturing the gap closed at associated with the clinical ai care gap record.',
    `gap_closed_date` DATE COMMENT 'Timestamp capturing the gap closed date associated with the clinical ai care gap record.',
    `gap_identified_at` TIMESTAMP COMMENT 'Timestamp capturing the gap identified at associated with the clinical ai care gap record.',
    `gap_identified_date` DATE COMMENT 'Timestamp capturing the gap identified date associated with the clinical ai care gap record.',
    `gap_status` STRING COMMENT 'The gap status value classifying the clinical ai care gap record.',
    `gap_type` STRING COMMENT 'The gap type value classifying the clinical ai care gap record.',
    `identified_date` DATE COMMENT 'Timestamp capturing the identified date associated with the clinical ai care gap record.',
    `intervention_recommended` STRING COMMENT 'The intervention recommended of the clinical ai care gap record.',
    `is_closed_flag` BOOLEAN COMMENT 'Boolean flag indicating the is closed flag status of the clinical ai care gap record.',
    `is_excluded_flag` BOOLEAN COMMENT 'Boolean flag indicating the is excluded flag status of the clinical ai care gap record.',
    `is_open_flag` BOOLEAN COMMENT 'Boolean flag indicating the is open flag status of the clinical ai care gap record.',
    `last_outreach_date` DATE COMMENT 'Timestamp capturing the last outreach date associated with the clinical ai care gap record.',
    `measurement_period` STRING COMMENT 'The measurement period of the clinical ai care gap record.',
    `measurement_period_end` DATE COMMENT 'The measurement period end of the clinical ai care gap record.',
    `measurement_period_end_date` DATE COMMENT 'Timestamp capturing the measurement period end date associated with the clinical ai care gap record.',
    `measurement_period_start` DATE COMMENT 'The measurement period start of the clinical ai care gap record.',
    `measurement_period_start_date` DATE COMMENT 'Timestamp capturing the measurement period start date associated with the clinical ai care gap record.',
    `numerator_compliant_flag` BOOLEAN COMMENT 'The numerator compliant flag of the clinical ai care gap record.',
    `open_flag` BOOLEAN COMMENT 'The open flag of the clinical ai care gap record.',
    `outreach_attempted_flag` BOOLEAN COMMENT 'The outreach attempted flag of the clinical ai care gap record.',
    `outreach_count` STRING COMMENT 'The outreach count of the clinical ai care gap record.',
    `outreach_date` DATE COMMENT 'Timestamp capturing the outreach date associated with the clinical ai care gap record.',
    `priority` STRING COMMENT 'The priority of the clinical ai care gap record.',
    `priority_score` DECIMAL(18,2) COMMENT 'The priority score of the clinical ai care gap record.',
    `care_gap_status` STRING COMMENT 'The care gap status value classifying the clinical ai care gap record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai care gap record.',
    `z_code` STRING COMMENT 'The z code value classifying the clinical ai care gap record.',
    CONSTRAINT pk_care_gap PRIMARY KEY(`care_gap_id`)
) COMMENT 'Patient x measure x gap status care gap tracking';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` (
    `model_inference_log_id` BIGINT COMMENT 'Unique identifier for the model inference log within the clinical ai model inference log record.',
    `feature_store_entity_id` BIGINT COMMENT 'Unique identifier for the feature store entity within the clinical ai model inference log record.',
    `model_card_id` BIGINT COMMENT 'Unique identifier for the model card within the clinical ai model inference log record.',
    `model_feature_store_entity_id` BIGINT COMMENT 'Unique identifier for the model feature store entity within the clinical ai model inference log record.',
    `model_mpi_record_id` BIGINT COMMENT 'Unique identifier for the model mpi record within the clinical ai model inference log record.',
    `model_visit_id` BIGINT COMMENT 'Unique identifier for the model visit within the clinical ai model inference log record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical ai model inference log record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the related visit within the clinical ai model inference log record.',
    `batch_inference_flag` BOOLEAN COMMENT 'The batch inference flag of the clinical ai model inference log record.',
    `compute_environment` STRING COMMENT 'The compute environment of the clinical ai model inference log record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai model inference log record.',
    `drift_detected_flag` BOOLEAN COMMENT 'The drift detected flag of the clinical ai model inference log record.',
    `endpoint_name` STRING COMMENT 'The endpoint name of the clinical ai model inference log record.',
    `environment` STRING COMMENT 'The environment of the clinical ai model inference log record.',
    `error_flag` BOOLEAN COMMENT 'The error flag of the clinical ai model inference log record.',
    `error_message` STRING COMMENT 'The error message of the clinical ai model inference log record.',
    `inference_at` TIMESTAMP COMMENT 'Timestamp capturing the inference at associated with the clinical ai model inference log record.',
    `inference_input_ref` STRING COMMENT 'The inference input ref of the clinical ai model inference log record.',
    `inference_latency_ms` STRING COMMENT 'The inference latency ms of the clinical ai model inference log record.',
    `inference_output_ref` STRING COMMENT 'The inference output ref of the clinical ai model inference log record.',
    `inference_timestamp` TIMESTAMP COMMENT 'The inference timestamp of the clinical ai model inference log record.',
    `inference_type` STRING COMMENT 'The inference type value classifying the clinical ai model inference log record.',
    `input_feature_count` STRING COMMENT 'The input feature count of the clinical ai model inference log record.',
    `input_feature_hash` STRING COMMENT 'The input feature hash of the clinical ai model inference log record.',
    `input_feature_vector_json` STRING COMMENT 'The input feature vector json of the clinical ai model inference log record.',
    `input_hash` STRING COMMENT 'The input hash of the clinical ai model inference log record.',
    `latency_ms` STRING COMMENT 'The latency ms of the clinical ai model inference log record.',
    `mlflow_experiment_key` STRING COMMENT 'The mlflow experiment key of the clinical ai model inference log record.',
    `mlflow_model_name` STRING COMMENT 'The mlflow model name of the clinical ai model inference log record.',
    `mlflow_model_uri` STRING COMMENT 'The mlflow model uri of the clinical ai model inference log record.',
    `mlflow_model_version` STRING COMMENT 'The mlflow model version of the clinical ai model inference log record.',
    `mlflow_run_key` STRING COMMENT 'The mlflow run key of the clinical ai model inference log record.',
    `model_name` STRING COMMENT 'The model name of the clinical ai model inference log record.',
    `model_stage` STRING COMMENT 'The model stage of the clinical ai model inference log record.',
    `model_uri` STRING COMMENT 'The model uri of the clinical ai model inference log record.',
    `model_version` STRING COMMENT 'The model version of the clinical ai model inference log record.',
    `output_payload` STRING COMMENT 'The output payload of the clinical ai model inference log record.',
    `output_prediction_json` STRING COMMENT 'The output prediction json of the clinical ai model inference log record.',
    `output_probability` DECIMAL(18,2) COMMENT 'The output probability of the clinical ai model inference log record.',
    `output_score` DECIMAL(18,2) COMMENT 'The output score of the clinical ai model inference log record.',
    `output_value` DECIMAL(18,2) COMMENT 'The output value of the clinical ai model inference log record.',
    `prediction_class` STRING COMMENT 'The prediction class of the clinical ai model inference log record.',
    `prediction_confidence` DECIMAL(18,2) COMMENT 'The prediction confidence of the clinical ai model inference log record.',
    `prediction_label` STRING COMMENT 'The prediction label of the clinical ai model inference log record.',
    `prediction_value` DECIMAL(18,2) COMMENT 'The prediction value of the clinical ai model inference log record.',
    `serving_endpoint` STRING COMMENT 'The serving endpoint of the clinical ai model inference log record.',
    `serving_environment` STRING COMMENT 'The serving environment of the clinical ai model inference log record.',
    `model_inference_log_status` STRING COMMENT 'The model inference log status value classifying the clinical ai model inference log record.',
    `success_flag` BOOLEAN COMMENT 'The success flag of the clinical ai model inference log record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai model inference log record.',
    CONSTRAINT pk_model_inference_log PRIMARY KEY(`model_inference_log_id`)
) COMMENT 'MLflow model inference lineage log';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` (
    `feature_store_entity_id` BIGINT COMMENT 'Unique identifier for the feature store entity within the clinical ai feature store entity record.',
    `feature_mpi_record_id` BIGINT COMMENT 'Unique identifier for the feature mpi record within the clinical ai feature store entity record.',
    `feature_visit_id` BIGINT COMMENT 'Unique identifier for the feature visit within the clinical ai feature store entity record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical ai feature store entity record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the clinical ai feature store entity record.',
    `computation_logic` STRING COMMENT 'The computation logic of the clinical ai feature store entity record.',
    `computation_source` STRING COMMENT 'The computation source of the clinical ai feature store entity record.',
    `created_at` TIMESTAMP COMMENT 'Timestamp capturing the created at associated with the clinical ai feature store entity record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai feature store entity record.',
    `entity_key` STRING COMMENT 'The entity key of the clinical ai feature store entity record.',
    `entity_level` STRING COMMENT 'The entity level of the clinical ai feature store entity record.',
    `entity_type` STRING COMMENT 'The entity type value classifying the clinical ai feature store entity record.',
    `feature_data_type` STRING COMMENT 'The feature data type value classifying the clinical ai feature store entity record.',
    `feature_group` STRING COMMENT 'The feature group of the clinical ai feature store entity record.',
    `feature_group_name` STRING COMMENT 'The feature group name of the clinical ai feature store entity record.',
    `feature_name` STRING COMMENT 'The feature name of the clinical ai feature store entity record.',
    `feature_set_version` STRING COMMENT 'The feature set version of the clinical ai feature store entity record.',
    `feature_snapshot_timestamp` TIMESTAMP COMMENT 'The feature snapshot timestamp of the clinical ai feature store entity record.',
    `feature_table_name` STRING COMMENT 'The feature table name of the clinical ai feature store entity record.',
    `feature_timestamp` TIMESTAMP COMMENT 'The feature timestamp of the clinical ai feature store entity record.',
    `feature_value_boolean` BOOLEAN COMMENT 'The feature value boolean of the clinical ai feature store entity record.',
    `feature_value_numeric` DECIMAL(18,2) COMMENT 'The feature value numeric of the clinical ai feature store entity record.',
    `feature_value_string` STRING COMMENT 'The feature value string of the clinical ai feature store entity record.',
    `feature_vector` STRING COMMENT 'The feature vector of the clinical ai feature store entity record.',
    `feature_vector_json` STRING COMMENT 'The feature vector json of the clinical ai feature store entity record.',
    `feature_vector_ref` STRING COMMENT 'The feature vector ref of the clinical ai feature store entity record.',
    `feature_version` STRING COMMENT 'The feature version of the clinical ai feature store entity record.',
    `is_current_flag` BOOLEAN COMMENT 'Boolean flag indicating the is current flag status of the clinical ai feature store entity record.',
    `is_offline_flag` BOOLEAN COMMENT 'Boolean flag indicating the is offline flag status of the clinical ai feature store entity record.',
    `is_online_flag` BOOLEAN COMMENT 'Boolean flag indicating the is online flag status of the clinical ai feature store entity record.',
    `offline_store_flag` BOOLEAN COMMENT 'The offline store flag of the clinical ai feature store entity record.',
    `online_store_flag` BOOLEAN COMMENT 'The online store flag of the clinical ai feature store entity record.',
    `point_in_time_correct_flag` BOOLEAN COMMENT 'The point in time correct flag of the clinical ai feature store entity record.',
    `point_in_time_date` DATE COMMENT 'Timestamp capturing the point in time date associated with the clinical ai feature store entity record.',
    `point_in_time_key` STRING COMMENT 'The point in time key of the clinical ai feature store entity record.',
    `snapshot_date` DATE COMMENT 'Timestamp capturing the snapshot date associated with the clinical ai feature store entity record.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The snapshot timestamp of the clinical ai feature store entity record.',
    `snapshot_version` STRING COMMENT 'The snapshot version of the clinical ai feature store entity record.',
    `feature_store_entity_status` STRING COMMENT 'The feature store entity status value classifying the clinical ai feature store entity record.',
    `ttl_seconds` STRING COMMENT 'The ttl seconds of the clinical ai feature store entity record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai feature store entity record.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'The valid from timestamp of the clinical ai feature store entity record.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'The valid to timestamp of the clinical ai feature store entity record.',
    CONSTRAINT pk_feature_store_entity PRIMARY KEY(`feature_store_entity_id`)
) COMMENT 'Patient/encounter-level feature snapshots for ML feature store';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` (
    `model_card_id` BIGINT COMMENT 'Unique identifier for the model card within the clinical ai model card record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the owner org unit within the clinical ai model card record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the clinical ai model card record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the clinical ai model card record.',
    `approved_by` STRING COMMENT 'The approved by of the clinical ai model card record.',
    `approved_flag` BOOLEAN COMMENT 'The approved flag of the clinical ai model card record.',
    `auc_roc` DECIMAL(18,2) COMMENT 'The auc roc of the clinical ai model card record.',
    `auc_score` DECIMAL(18,2) COMMENT 'The auc score of the clinical ai model card record.',
    `bias_assessment_summary` STRING COMMENT 'The bias assessment summary of the clinical ai model card record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai model card record.',
    `deployed_flag` BOOLEAN COMMENT 'The deployed flag of the clinical ai model card record.',
    `deployment_status` STRING COMMENT 'The deployment status value classifying the clinical ai model card record.',
    `ethical_considerations` STRING COMMENT 'The ethical considerations of the clinical ai model card record.',
    `fairness_assessment_flag` BOOLEAN COMMENT 'The fairness assessment flag of the clinical ai model card record.',
    `fairness_assessment_summary` STRING COMMENT 'The fairness assessment summary of the clinical ai model card record.',
    `fairness_metric` DECIMAL(18,2) COMMENT 'The fairness metric of the clinical ai model card record.',
    `fairness_metrics_json` STRING COMMENT 'The fairness metrics json of the clinical ai model card record.',
    `fda_samd_class` STRING COMMENT 'The fda samd class of the clinical ai model card record.',
    `intended_use` STRING COMMENT 'The intended use of the clinical ai model card record.',
    `last_reviewed_date` DATE COMMENT 'Timestamp capturing the last reviewed date associated with the clinical ai model card record.',
    `limitations` STRING COMMENT 'The limitations of the clinical ai model card record.',
    `mlflow_model_uri` STRING COMMENT 'The mlflow model uri of the clinical ai model card record.',
    `model_name` STRING COMMENT 'The model name of the clinical ai model card record.',
    `model_purpose` STRING COMMENT 'The model purpose of the clinical ai model card record.',
    `model_type` STRING COMMENT 'The model type value classifying the clinical ai model card record.',
    `model_version` STRING COMMENT 'The model version of the clinical ai model card record.',
    `owner_name` STRING COMMENT 'The owner name of the clinical ai model card record.',
    `performance_metric_auc` DECIMAL(18,2) COMMENT 'The performance metric auc of the clinical ai model card record.',
    `performance_metric_summary` STRING COMMENT 'The performance metric summary of the clinical ai model card record.',
    `performance_metrics` STRING COMMENT 'The performance metrics of the clinical ai model card record.',
    `performance_metrics_json` STRING COMMENT 'The performance metrics json of the clinical ai model card record.',
    `precision_metric` DECIMAL(18,2) COMMENT 'The precision metric of the clinical ai model card record.',
    `recall_metric` DECIMAL(18,2) COMMENT 'The recall metric of the clinical ai model card record.',
    `regulatory_status` STRING COMMENT 'The regulatory status value classifying the clinical ai model card record.',
    `retired_flag` BOOLEAN COMMENT 'The retired flag of the clinical ai model card record.',
    `review_frequency` STRING COMMENT 'The review frequency of the clinical ai model card record.',
    `sensitivity_metric` DECIMAL(18,2) COMMENT 'The sensitivity metric of the clinical ai model card record.',
    `specificity_metric` DECIMAL(18,2) COMMENT 'The specificity metric of the clinical ai model card record.',
    `model_card_status` STRING COMMENT 'The model card status value classifying the clinical ai model card record.',
    `training_data_description` STRING COMMENT 'The training data description of the clinical ai model card record.',
    `training_data_end_date` DATE COMMENT 'Timestamp capturing the training data end date associated with the clinical ai model card record.',
    `training_data_start_date` DATE COMMENT 'Timestamp capturing the training data start date associated with the clinical ai model card record.',
    `training_data_summary` STRING COMMENT 'The training data summary of the clinical ai model card record.',
    `training_dataset_description` STRING COMMENT 'The training dataset description of the clinical ai model card record.',
    `training_date` DATE COMMENT 'Timestamp capturing the training date associated with the clinical ai model card record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai model card record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the clinical ai model card record.',
    CONSTRAINT pk_model_card PRIMARY KEY(`model_card_id`)
) COMMENT 'Clinical AI model card / governance metadata';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` (
    `bias_monitoring_id` BIGINT COMMENT 'Unique identifier for the bias monitoring within the clinical ai bias monitoring record.',
    `model_card_id` BIGINT COMMENT 'Unique identifier for the model card within the clinical ai bias monitoring record.',
    `bias_detected_flag` BOOLEAN COMMENT 'The bias detected flag of the clinical ai bias monitoring record.',
    `bias_flag` BOOLEAN COMMENT 'The bias flag of the clinical ai bias monitoring record.',
    `cohort_dimension` STRING COMMENT 'The cohort dimension of the clinical ai bias monitoring record.',
    `cohort_value` DECIMAL(18,2) COMMENT 'The cohort value of the clinical ai bias monitoring record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai bias monitoring record.',
    `disparate_impact_ratio` DECIMAL(18,2) COMMENT 'The disparate impact ratio of the clinical ai bias monitoring record.',
    `disparity_ratio` DECIMAL(18,2) COMMENT 'The disparity ratio of the clinical ai bias monitoring record.',
    `equal_opportunity_difference` DECIMAL(18,2) COMMENT 'The equal opportunity difference of the clinical ai bias monitoring record.',
    `evaluation_date` DATE COMMENT 'Timestamp capturing the evaluation date associated with the clinical ai bias monitoring record.',
    `evaluation_period_end` DATE COMMENT 'The evaluation period end of the clinical ai bias monitoring record.',
    `evaluation_period_start` DATE COMMENT 'The evaluation period start of the clinical ai bias monitoring record.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'The evaluation timestamp of the clinical ai bias monitoring record.',
    `fairness_metric` STRING COMMENT 'The fairness metric of the clinical ai bias monitoring record.',
    `fairness_metric_name` STRING COMMENT 'The fairness metric name of the clinical ai bias monitoring record.',
    `fairness_metric_value` DECIMAL(18,2) COMMENT 'The fairness metric value of the clinical ai bias monitoring record.',
    `measured_timestamp` TIMESTAMP COMMENT 'The measured timestamp of the clinical ai bias monitoring record.',
    `metric_name` STRING COMMENT 'The metric name of the clinical ai bias monitoring record.',
    `metric_value` DECIMAL(18,2) COMMENT 'The metric value of the clinical ai bias monitoring record.',
    `mitigation_action` STRING COMMENT 'The mitigation action of the clinical ai bias monitoring record.',
    `monitored_subgroup` STRING COMMENT 'The monitored subgroup of the clinical ai bias monitoring record.',
    `monitoring_date` DATE COMMENT 'Timestamp capturing the monitoring date associated with the clinical ai bias monitoring record.',
    `monitoring_period_end` DATE COMMENT 'The monitoring period end of the clinical ai bias monitoring record.',
    `monitoring_period_end_date` DATE COMMENT 'Timestamp capturing the monitoring period end date associated with the clinical ai bias monitoring record.',
    `monitoring_period_start` DATE COMMENT 'The monitoring period start of the clinical ai bias monitoring record.',
    `monitoring_period_start_date` DATE COMMENT 'Timestamp capturing the monitoring period start date associated with the clinical ai bias monitoring record.',
    `performance_metric_name` STRING COMMENT 'The performance metric name of the clinical ai bias monitoring record.',
    `performance_metric_value` DECIMAL(18,2) COMMENT 'The performance metric value of the clinical ai bias monitoring record.',
    `protected_attribute` STRING COMMENT 'The protected attribute of the clinical ai bias monitoring record.',
    `reference_group_value` DECIMAL(18,2) COMMENT 'The reference group value of the clinical ai bias monitoring record.',
    `remediation_action` STRING COMMENT 'The remediation action of the clinical ai bias monitoring record.',
    `remediation_status` STRING COMMENT 'The remediation status value classifying the clinical ai bias monitoring record.',
    `reviewed_by` STRING COMMENT 'The reviewed by of the clinical ai bias monitoring record.',
    `sample_size` STRING COMMENT 'The sample size of the clinical ai bias monitoring record.',
    `bias_monitoring_status` STRING COMMENT 'The bias monitoring status value classifying the clinical ai bias monitoring record.',
    `subgroup` STRING COMMENT 'The subgroup of the clinical ai bias monitoring record.',
    `subgroup_dimension` STRING COMMENT 'The subgroup dimension of the clinical ai bias monitoring record.',
    `subgroup_name` STRING COMMENT 'The subgroup name of the clinical ai bias monitoring record.',
    `subgroup_size` STRING COMMENT 'The subgroup size of the clinical ai bias monitoring record.',
    `subgroup_value` DECIMAL(18,2) COMMENT 'The subgroup value of the clinical ai bias monitoring record.',
    `threshold_breached_flag` BOOLEAN COMMENT 'The threshold breached flag of the clinical ai bias monitoring record.',
    `threshold_exceeded_flag` BOOLEAN COMMENT 'The threshold exceeded flag of the clinical ai bias monitoring record.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value of the clinical ai bias monitoring record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai bias monitoring record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the clinical ai bias monitoring record.',
    CONSTRAINT pk_bias_monitoring PRIMARY KEY(`bias_monitoring_id`)
) COMMENT 'Model bias monitoring across demographic cohorts';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` (
    `samd_regulatory_tracking_id` BIGINT COMMENT 'Unique identifier for the samd regulatory tracking within the clinical ai samd regulatory tracking record.',
    `model_card_id` BIGINT COMMENT 'Unique identifier for the model card within the clinical ai samd regulatory tracking record.',
    `approval_date` DATE COMMENT 'Timestamp capturing the approval date associated with the clinical ai samd regulatory tracking record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the clinical ai samd regulatory tracking record.',
    `clearance_date` DATE COMMENT 'Timestamp capturing the clearance date associated with the clinical ai samd regulatory tracking record.',
    `clearance_status` STRING COMMENT 'The clearance status value classifying the clinical ai samd regulatory tracking record.',
    `cleared_flag` BOOLEAN COMMENT 'The cleared flag of the clinical ai samd regulatory tracking record.',
    `clinical_validation_required` BOOLEAN COMMENT 'The clinical validation required of the clinical ai samd regulatory tracking record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical ai samd regulatory tracking record.',
    `device_classification` STRING COMMENT 'The device classification of the clinical ai samd regulatory tracking record.',
    `fda_classification` STRING COMMENT 'The fda classification of the clinical ai samd regulatory tracking record.',
    `fda_clearance_number` STRING COMMENT 'The fda clearance number of the clinical ai samd regulatory tracking record.',
    `fda_submission_number` STRING COMMENT 'The fda submission number of the clinical ai samd regulatory tracking record.',
    `fda_submission_type` STRING COMMENT 'The fda submission type value classifying the clinical ai samd regulatory tracking record.',
    `intended_use_statement` STRING COMMENT 'The intended use statement of the clinical ai samd regulatory tracking record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the clinical ai samd regulatory tracking record.',
    `post_market_surveillance_plan` STRING COMMENT 'The post market surveillance plan of the clinical ai samd regulatory tracking record.',
    `predetermined_change_control_plan` STRING COMMENT 'The predetermined change control plan of the clinical ai samd regulatory tracking record.',
    `predetermined_change_control_plan_flag` BOOLEAN COMMENT 'The predetermined change control plan flag of the clinical ai samd regulatory tracking record.',
    `predicate_device` STRING COMMENT 'The predicate device of the clinical ai samd regulatory tracking record.',
    `premarket_pathway` STRING COMMENT 'The premarket pathway of the clinical ai samd regulatory tracking record.',
    `regulatory_body` STRING COMMENT 'The regulatory body of the clinical ai samd regulatory tracking record.',
    `regulatory_classification` STRING COMMENT 'The regulatory classification of the clinical ai samd regulatory tracking record.',
    `regulatory_owner` STRING COMMENT 'The regulatory owner of the clinical ai samd regulatory tracking record.',
    `regulatory_pathway` STRING COMMENT 'The regulatory pathway of the clinical ai samd regulatory tracking record.',
    `regulatory_status` STRING COMMENT 'The regulatory status value classifying the clinical ai samd regulatory tracking record.',
    `responsible_party` STRING COMMENT 'The responsible party of the clinical ai samd regulatory tracking record.',
    `risk_categorization` STRING COMMENT 'The risk categorization of the clinical ai samd regulatory tracking record.',
    `risk_category` STRING COMMENT 'The risk category of the clinical ai samd regulatory tracking record.',
    `risk_classification` STRING COMMENT 'The risk classification of the clinical ai samd regulatory tracking record.',
    `samd_class` STRING COMMENT 'The samd class of the clinical ai samd regulatory tracking record.',
    `samd_classification` STRING COMMENT 'The samd classification of the clinical ai samd regulatory tracking record.',
    `samd_risk_category` STRING COMMENT 'The samd risk category of the clinical ai samd regulatory tracking record.',
    `samd_regulatory_tracking_status` STRING COMMENT 'The samd regulatory tracking status value classifying the clinical ai samd regulatory tracking record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the clinical ai samd regulatory tracking record.',
    `submission_number` STRING COMMENT 'The submission number of the clinical ai samd regulatory tracking record.',
    `submission_type` STRING COMMENT 'The submission type value classifying the clinical ai samd regulatory tracking record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical ai samd regulatory tracking record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the clinical ai samd regulatory tracking record.',
    CONSTRAINT pk_samd_regulatory_tracking PRIMARY KEY(`samd_regulatory_tracking_id`)
) COMMENT 'FDA SaMD regulatory tracking for clinical AI';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_feature_store_entity_id` FOREIGN KEY (`feature_store_entity_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity`(`feature_store_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_model_inference_log_id` FOREIGN KEY (`model_inference_log_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log`(`model_inference_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_model_inference_log_id` FOREIGN KEY (`model_inference_log_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log`(`model_inference_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_feature_store_entity_id` FOREIGN KEY (`feature_store_entity_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity`(`feature_store_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_model_feature_store_entity_id` FOREIGN KEY (`model_feature_store_entity_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity`(`feature_store_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ADD CONSTRAINT `fk_clinical_ai_bias_monitoring_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ADD CONSTRAINT `fk_clinical_ai_samd_regulatory_tracking_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`model_card`(`model_card_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`clinical_ai` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`clinical_ai` SET TAGS ('pii_domain' = 'clinical_ai');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` SET TAGS ('pii_subdomain' = 'model_inference');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `clinical_action_taken` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `fall_risk_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `readmission_risk_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `sepsis_risk_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` SET TAGS ('pii_subdomain' = 'model_inference');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `note_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `entity_text` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `extracted_text` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `nlp_model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `nlp_model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `nlp_model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `nlp_model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `nlp_model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `nlp_model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` SET TAGS ('pii_subdomain' = 'model_inference');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `care_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `care_mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` SET TAGS ('pii_subdomain' = 'model_inference');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `visit_id` SET TAGS ('pii_source_attribute' = 'visit_id');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `endpoint_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `endpoint_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `endpoint_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `endpoint_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `endpoint_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `endpoint_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `input_feature_vector_json` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `output_prediction_json` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` SET TAGS ('pii_subdomain' = 'model_inference');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_store_entity_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_group_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_group_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_group_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_group_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_group_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_group_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_vector_json` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` SET TAGS ('pii_subdomain' = 'governance_compliance');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `specificity_metric` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `specificity_metric` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `specificity_metric` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `specificity_metric` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `specificity_metric` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ALTER COLUMN `specificity_metric` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` SET TAGS ('pii_subdomain' = 'governance_compliance');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `fairness_metric_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `fairness_metric_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `fairness_metric_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `fairness_metric_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `fairness_metric_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `fairness_metric_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `performance_metric_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `performance_metric_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `performance_metric_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `performance_metric_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `performance_metric_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `performance_metric_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `reviewed_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `subgroup_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `subgroup_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `subgroup_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `subgroup_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `subgroup_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `subgroup_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` SET TAGS ('pii_subdomain' = 'governance_compliance');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `clinical_validation_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `intended_use_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `intended_use_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `intended_use_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `intended_use_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `intended_use_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `intended_use_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `regulatory_owner` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`samd_regulatory_tracking` ALTER COLUMN `responsible_party` SET TAGS ('pii_sensitivity' = 'pii');
