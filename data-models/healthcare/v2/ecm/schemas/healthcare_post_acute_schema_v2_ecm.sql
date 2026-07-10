-- Schema for Domain: post_acute | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`post_acute` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` (
    `snf_stay_id` BIGINT COMMENT 'Unique identifier for the snf stay within the post acute snf stay record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the post acute snf stay record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the post acute snf stay record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the post acute snf stay record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the post acute snf stay record.',
    `admission_date` DATE COMMENT 'Timestamp capturing the admission date associated with the post acute snf stay record.',
    `admission_source` STRING COMMENT 'The admission source of the post acute snf stay record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the post acute snf stay record.',
    `daily_rate` DECIMAL(18,2) COMMENT 'The daily rate of the post acute snf stay record.',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the post acute snf stay record.',
    `discharge_disposition` STRING COMMENT 'The discharge disposition of the post acute snf stay record.',
    `length_of_stay_days` STRING COMMENT 'The length of stay days of the post acute snf stay record.',
    `los_days` STRING COMMENT 'The los days of the post acute snf stay record.',
    `mds_assessment_date` DATE COMMENT 'Timestamp capturing the mds assessment date associated with the post acute snf stay record.',
    `medicare_covered_days` STRING COMMENT 'The medicare covered days of the post acute snf stay record.',
    `primary_diagnosis_code` STRING COMMENT 'The primary diagnosis code value classifying the post acute snf stay record.',
    `readmission_flag` BOOLEAN COMMENT 'The readmission flag of the post acute snf stay record.',
    `rug_category` STRING COMMENT 'The rug category of the post acute snf stay record.',
    `rug_iv_category` STRING COMMENT 'The rug iv category of the post acute snf stay record.',
    `rug_iv_group` STRING COMMENT 'The rug iv group of the post acute snf stay record.',
    `rug_pdpm_code` STRING COMMENT 'The rug pdpm code value classifying the post acute snf stay record.',
    `snf_stay_status` STRING COMMENT 'The snf stay status value classifying the post acute snf stay record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the post acute snf stay record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the post acute snf stay record.',
    CONSTRAINT pk_snf_stay PRIMARY KEY(`snf_stay_id`)
) COMMENT 'Records for post acute snf stay.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` (
    `home_health_episode_id` BIGINT COMMENT 'Unique identifier for the home health episode within the post acute home health episode record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the post acute home health episode record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the post acute home health episode record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the post acute home health episode record.',
    `certification_period_start` DATE COMMENT 'The certification period start of the post acute home health episode record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the post acute home health episode record.',
    `discipline_types` STRING COMMENT 'The discipline types of the post acute home health episode record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the post acute home health episode record.',
    `end_of_care_date` DATE COMMENT 'Timestamp capturing the end of care date associated with the post acute home health episode record.',
    `episode_amount` DECIMAL(18,2) COMMENT 'The episode amount of the post acute home health episode record.',
    `episode_end_date` DATE COMMENT 'Timestamp capturing the episode end date associated with the post acute home health episode record.',
    `episode_payment_amount` DECIMAL(18,2) COMMENT 'The episode payment amount of the post acute home health episode record.',
    `episode_start_date` DATE COMMENT 'Timestamp capturing the episode start date associated with the post acute home health episode record.',
    `episode_status` STRING COMMENT 'The episode status value classifying the post acute home health episode record.',
    `hhrg_code` STRING COMMENT 'The hhrg code value classifying the post acute home health episode record.',
    `hipps_code` STRING COMMENT 'The hipps code value classifying the post acute home health episode record.',
    `oasis_assessment_date` DATE COMMENT 'Timestamp capturing the oasis assessment date associated with the post acute home health episode record.',
    `oasis_score` STRING COMMENT 'The oasis score of the post acute home health episode record.',
    `primary_diagnosis_code` STRING COMMENT 'The primary diagnosis code value classifying the post acute home health episode record.',
    `referral_source` STRING COMMENT 'The referral source of the post acute home health episode record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the post acute home health episode record.',
    `start_of_care_date` DATE COMMENT 'Timestamp capturing the start of care date associated with the post acute home health episode record.',
    `home_health_episode_status` STRING COMMENT 'The home health episode status value classifying the post acute home health episode record.',
    `total_visits` STRING COMMENT 'The total visits of the post acute home health episode record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the post acute home health episode record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the post acute home health episode record.',
    `visit_count` STRING COMMENT 'The visit count of the post acute home health episode record.',
    CONSTRAINT pk_home_health_episode PRIMARY KEY(`home_health_episode_id`)
) COMMENT 'Data product representing home health episode records within the post_acute domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` (
    `hospice_episode_id` BIGINT COMMENT 'Unique identifier for the hospice episode within the post acute hospice episode record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the post acute hospice episode record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the post acute hospice episode record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the post acute hospice episode record.',
    `admission_date` DATE COMMENT 'Timestamp capturing the admission date associated with the post acute hospice episode record.',
    `advance_directive_on_file` BOOLEAN COMMENT 'The advance directive on file of the post acute hospice episode record.',
    `attending_physician_npi` STRING COMMENT 'The attending physician npi of the post acute hospice episode record.',
    `benefit_period` STRING COMMENT 'The benefit period of the post acute hospice episode record.',
    `benefit_period_number` STRING COMMENT 'The benefit period number of the post acute hospice episode record.',
    `certification_date` DATE COMMENT 'Timestamp capturing the certification date associated with the post acute hospice episode record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the post acute hospice episode record.',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the post acute hospice episode record.',
    `discharge_reason` STRING COMMENT 'The discharge reason of the post acute hospice episode record.',
    `dnr_status` STRING COMMENT 'The dnr status value classifying the post acute hospice episode record.',
    `election_date` DATE COMMENT 'Timestamp capturing the election date associated with the post acute hospice episode record.',
    `episode_status` STRING COMMENT 'The episode status value classifying the post acute hospice episode record.',
    `level_of_care` STRING COMMENT 'The level of care of the post acute hospice episode record.',
    `per_diem_amount` DECIMAL(18,2) COMMENT 'The per diem amount of the post acute hospice episode record.',
    `primary_diagnosis_code` STRING COMMENT 'The primary diagnosis code value classifying the post acute hospice episode record.',
    `prognosis_months` STRING COMMENT 'The prognosis months of the post acute hospice episode record.',
    `revocation_date` DATE COMMENT 'Timestamp capturing the revocation date associated with the post acute hospice episode record.',
    `hospice_episode_status` STRING COMMENT 'The hospice episode status value classifying the post acute hospice episode record.',
    `terminal_diagnosis_code` STRING COMMENT 'The terminal diagnosis code value classifying the post acute hospice episode record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the post acute hospice episode record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the post acute hospice episode record.',
    CONSTRAINT pk_hospice_episode PRIMARY KEY(`hospice_episode_id`)
) COMMENT 'Data product representing hospice episode records in the post_acute domain.';

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`post_acute` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`post_acute` SET TAGS ('pii_domain' = 'post_acute');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` SET TAGS ('pii_subdomain' = 'post_acute');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `snf_stay_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `admission_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `discharge_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` SET TAGS ('pii_subdomain' = 'post_acute');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `end_of_care_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `oasis_assessment_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `oasis_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `start_of_care_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ALTER COLUMN `home_health_episode_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` SET TAGS ('pii_subdomain' = 'post_acute');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `hospice_episode_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `admission_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `advance_directive_on_file` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `attending_physician_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `discharge_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `dnr_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `prognosis_months` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ALTER COLUMN `terminal_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
