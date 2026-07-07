-- Schema for Domain: population_health | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`population_health` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` (
    `cohort_definition_id` BIGINT COMMENT 'Unique identifier for the cohort definition within the population health cohort definition record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the population health cohort definition record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the owner org unit within the population health cohort definition record.',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the population health cohort definition record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the population health cohort definition record.',
    `cohort_description` STRING COMMENT 'The cohort description of the population health cohort definition record.',
    `cohort_name` STRING COMMENT 'The cohort name of the population health cohort definition record.',
    `cohort_type` STRING COMMENT 'The cohort type value classifying the population health cohort definition record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the population health cohort definition record.',
    `criteria_logic` STRING COMMENT 'The criteria logic of the population health cohort definition record.',
    `definition_logic` STRING COMMENT 'The definition logic of the population health cohort definition record.',
    `cohort_definition_description` STRING COMMENT 'The cohort definition description of the population health cohort definition record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the population health cohort definition record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the population health cohort definition record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the population health cohort definition record.',
    `exclusion_criteria` STRING COMMENT 'The exclusion criteria of the population health cohort definition record.',
    `exclusion_criteria_json` STRING COMMENT 'The exclusion criteria json of the population health cohort definition record.',
    `inclusion_criteria` STRING COMMENT 'The inclusion criteria of the population health cohort definition record.',
    `inclusion_criteria_json` STRING COMMENT 'The inclusion criteria json of the population health cohort definition record.',
    `is_dynamic_flag` BOOLEAN COMMENT 'Boolean flag indicating the is dynamic flag status of the population health cohort definition record.',
    `last_refreshed_timestamp` TIMESTAMP COMMENT 'The last refreshed timestamp of the population health cohort definition record.',
    `measurement_period` STRING COMMENT 'The measurement period of the population health cohort definition record.',
    `member_count` STRING COMMENT 'The member count of the population health cohort definition record.',
    `owner_name` STRING COMMENT 'The owner name of the population health cohort definition record.',
    `refresh_frequency` STRING COMMENT 'The refresh frequency of the population health cohort definition record.',
    `sql_logic` STRING COMMENT 'The sql logic of the population health cohort definition record.',
    `cohort_definition_status` STRING COMMENT 'The cohort definition status value classifying the population health cohort definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the population health cohort definition record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the population health cohort definition record.',
    `created_by` STRING COMMENT 'The created by of the population health cohort definition record.',
    CONSTRAINT pk_cohort_definition PRIMARY KEY(`cohort_definition_id`)
) COMMENT 'Represents cohort definition records within the population health domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` (
    `cohort_membership_id` BIGINT COMMENT 'Unique identifier for the cohort membership within the population health cohort membership record.',
    `cohort_definition_id` BIGINT COMMENT 'Unique identifier for the cohort definition within the population health cohort membership record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the population health cohort membership record.',
    `added_date` DATE COMMENT 'Timestamp capturing the added date associated with the population health cohort membership record.',
    `attribution_flag` BOOLEAN COMMENT 'The attribution flag of the population health cohort membership record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the population health cohort membership record.',
    `entry_date` DATE COMMENT 'Timestamp capturing the entry date associated with the population health cohort membership record.',
    `entry_reason` STRING COMMENT 'The entry reason of the population health cohort membership record.',
    `exclusion_reason` STRING COMMENT 'The exclusion reason of the population health cohort membership record.',
    `exit_date` DATE COMMENT 'Timestamp capturing the exit date associated with the population health cohort membership record.',
    `exit_reason` STRING COMMENT 'The exit reason of the population health cohort membership record.',
    `inclusion_reason` STRING COMMENT 'The inclusion reason of the population health cohort membership record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the population health cohort membership record.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'The last evaluated timestamp of the population health cohort membership record.',
    `membership_end_date` DATE COMMENT 'Timestamp capturing the membership end date associated with the population health cohort membership record.',
    `membership_reason` STRING COMMENT 'The membership reason of the population health cohort membership record.',
    `membership_start_date` DATE COMMENT 'Timestamp capturing the membership start date associated with the population health cohort membership record.',
    `membership_status` STRING COMMENT 'The membership status value classifying the population health cohort membership record.',
    `removed_date` DATE COMMENT 'Timestamp capturing the removed date associated with the population health cohort membership record.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score of the population health cohort membership record.',
    `cohort_membership_status` STRING COMMENT 'The cohort membership status value classifying the population health cohort membership record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the population health cohort membership record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the population health cohort membership record.',
    CONSTRAINT pk_cohort_membership PRIMARY KEY(`cohort_membership_id`)
) COMMENT 'Data product representing cohort membership within the population health domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` (
    `trial_match_evaluation_id` BIGINT COMMENT 'Unique identifier for the trial match evaluation within the population health trial match evaluation record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the population health trial match evaluation record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the population health trial match evaluation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the population health trial match evaluation record.',
    `criteria_failed_count` STRING COMMENT 'The criteria failed count of the population health trial match evaluation record.',
    `criteria_met_count` STRING COMMENT 'The criteria met count of the population health trial match evaluation record.',
    `criteria_total_count` STRING COMMENT 'The criteria total count of the population health trial match evaluation record.',
    `eligibility_score` DECIMAL(18,2) COMMENT 'The eligibility score of the population health trial match evaluation record.',
    `eligibility_status` STRING COMMENT 'The eligibility status value classifying the population health trial match evaluation record.',
    `eligible_flag` BOOLEAN COMMENT 'The eligible flag of the population health trial match evaluation record.',
    `evaluation_date` DATE COMMENT 'Timestamp capturing the evaluation date associated with the population health trial match evaluation record.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'The evaluation timestamp of the population health trial match evaluation record.',
    `exclusion_criteria_total` STRING COMMENT 'The exclusion criteria total of the population health trial match evaluation record.',
    `exclusion_criteria_violated` STRING COMMENT 'The exclusion criteria violated of the population health trial match evaluation record.',
    `failed_criteria_json` STRING COMMENT 'The failed criteria json of the population health trial match evaluation record.',
    `inclusion_criteria_met` STRING COMMENT 'The inclusion criteria met of the population health trial match evaluation record.',
    `inclusion_criteria_total` STRING COMMENT 'The inclusion criteria total of the population health trial match evaluation record.',
    `match_score` DECIMAL(18,2) COMMENT 'The match score of the population health trial match evaluation record.',
    `match_status` STRING COMMENT 'The match status value classifying the population health trial match evaluation record.',
    `matching_algorithm` STRING COMMENT 'The matching algorithm of the population health trial match evaluation record.',
    `patient_contacted_flag` BOOLEAN COMMENT 'The patient contacted flag of the population health trial match evaluation record.',
    `patient_interest_flag` BOOLEAN COMMENT 'The patient interest flag of the population health trial match evaluation record.',
    `trial_match_evaluation_status` STRING COMMENT 'The trial match evaluation status value classifying the population health trial match evaluation record.',
    `unmet_criteria` STRING COMMENT 'The unmet criteria of the population health trial match evaluation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the population health trial match evaluation record.',
    CONSTRAINT pk_trial_match_evaluation PRIMARY KEY(`trial_match_evaluation_id`)
) COMMENT 'Data product representing trial match evaluation within the population_health domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_membership_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `vibe_healthcare_v1`.`population_health`.`cohort_definition`(`cohort_definition_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`population_health` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`population_health` SET TAGS ('pii_domain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` ALTER COLUMN `cohort_membership_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` ALTER COLUMN `membership_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` ALTER COLUMN `membership_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` ALTER COLUMN `trial_match_evaluation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
