-- Schema for Domain: genomics | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`genomics` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` (
    `genetic_variant_id` BIGINT COMMENT 'Unique identifier for the genetic variant within the genomics genetic variant record.',
    `biobank_specimen_id` BIGINT COMMENT 'Unique identifier for the biobank specimen within the genomics genetic variant record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the genomics genetic variant record.',
    `test_result_id` BIGINT COMMENT 'Unique identifier for the test result within the genomics genetic variant record.',
    `acmg_classification` STRING COMMENT 'The acmg classification of the genomics genetic variant record.',
    `actionable_flag` BOOLEAN COMMENT 'The actionable flag of the genomics genetic variant record.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'The allele frequency of the genomics genetic variant record.',
    `alternate_allele` STRING COMMENT 'The alternate allele of the genomics genetic variant record.',
    `assay_method` STRING COMMENT 'The assay method of the genomics genetic variant record.',
    `chromosome` STRING COMMENT 'The chromosome of the genomics genetic variant record.',
    `clinical_significance` STRING COMMENT 'The clinical significance of the genomics genetic variant record.',
    `clinvar_accession` STRING COMMENT 'The clinvar accession of the genomics genetic variant record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the genomics genetic variant record.',
    `dbsnp_rsid` STRING COMMENT 'The dbsnp rsid of the genomics genetic variant record.',
    `gene_symbol` STRING COMMENT 'The gene symbol of the genomics genetic variant record.',
    `genomic_position` BIGINT COMMENT 'The genomic position of the genomics genetic variant record.',
    `genotype` STRING COMMENT 'The genotype of the genomics genetic variant record.',
    `hgvs_c` STRING COMMENT 'The hgvs c of the genomics genetic variant record.',
    `hgvs_notation` STRING COMMENT 'The hgvs notation of the genomics genetic variant record.',
    `hgvs_p` STRING COMMENT 'The hgvs p of the genomics genetic variant record.',
    `interpretation_date` DATE COMMENT 'Timestamp capturing the interpretation date associated with the genomics genetic variant record.',
    `pathogenic_flag` BOOLEAN COMMENT 'The pathogenic flag of the genomics genetic variant record.',
    `position` BIGINT COMMENT 'The position of the genomics genetic variant record.',
    `reference_allele` STRING COMMENT 'The reference allele of the genomics genetic variant record.',
    `reported_date` DATE COMMENT 'Timestamp capturing the reported date associated with the genomics genetic variant record.',
    `genetic_variant_status` STRING COMMENT 'The genetic variant status value classifying the genomics genetic variant record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the genomics genetic variant record.',
    `variant_allele_frequency` DECIMAL(18,2) COMMENT 'The variant allele frequency of the genomics genetic variant record.',
    `variant_hgvs` STRING COMMENT 'The variant hgvs of the genomics genetic variant record.',
    `variant_type` STRING COMMENT 'The variant type value classifying the genomics genetic variant record.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the genomics genetic variant record.',
    `zygosity` STRING COMMENT 'The zygosity of the genomics genetic variant record.',
    CONSTRAINT pk_genetic_variant PRIMARY KEY(`genetic_variant_id`)
) COMMENT 'Data product for genetic variant in the genomics domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` (
    `biobank_specimen_id` BIGINT COMMENT 'Unique identifier for the biobank specimen within the genomics biobank specimen record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the genomics biobank specimen record.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen within the genomics biobank specimen record.',
    `aliquot_count` STRING COMMENT 'The aliquot count of the genomics biobank specimen record.',
    `biobank_accession_number` STRING COMMENT 'The biobank accession number of the genomics biobank specimen record.',
    `collection_date` DATE COMMENT 'Timestamp capturing the collection date associated with the genomics biobank specimen record.',
    `consent_flag` BOOLEAN COMMENT 'The consent flag of the genomics biobank specimen record.',
    `consent_for_future_contact` BOOLEAN COMMENT 'The consent for future contact of the genomics biobank specimen record.',
    `consent_for_research` BOOLEAN COMMENT 'The consent for research of the genomics biobank specimen record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the genomics biobank specimen record.',
    `deidentified_flag` BOOLEAN COMMENT 'The deidentified flag of the genomics biobank specimen record.',
    `freezer_temperature_c` DECIMAL(18,2) COMMENT 'The freezer temperature c of the genomics biobank specimen record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the genomics biobank specimen record.',
    `biobank_specimen_status` STRING COMMENT 'The biobank specimen status value classifying the genomics biobank specimen record.',
    `storage_location` STRING COMMENT 'The storage location of the genomics biobank specimen record.',
    `storage_temperature` STRING COMMENT 'The storage temperature of the genomics biobank specimen record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the genomics biobank specimen record.',
    `volume_ml` DECIMAL(18,2) COMMENT 'The volume ml of the genomics biobank specimen record.',
    CONSTRAINT pk_biobank_specimen PRIMARY KEY(`biobank_specimen_id`)
) COMMENT 'Data product representing biobank specimen within the genomics domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` (
    `pharmacogenomics_result_id` BIGINT COMMENT 'Unique identifier for the pharmacogenomics result within the genomics pharmacogenomics result record.',
    `drug_master_id` BIGINT COMMENT 'Unique identifier for the drug master within the genomics pharmacogenomics result record.',
    `genetic_variant_id` BIGINT COMMENT 'Unique identifier for the genetic variant within the genomics pharmacogenomics result record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the genomics pharmacogenomics result record.',
    `affected_drug` STRING COMMENT 'The affected drug of the genomics pharmacogenomics result record.',
    `cpic_guideline` STRING COMMENT 'The cpic guideline of the genomics pharmacogenomics result record.',
    `cpic_guideline_flag` BOOLEAN COMMENT 'The cpic guideline flag of the genomics pharmacogenomics result record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the genomics pharmacogenomics result record.',
    `diplotype` STRING COMMENT 'The diplotype of the genomics pharmacogenomics result record.',
    `drug_class` STRING COMMENT 'The drug class of the genomics pharmacogenomics result record.',
    `drug_name` STRING COMMENT 'The drug name of the genomics pharmacogenomics result record.',
    `evidence_level` STRING COMMENT 'The evidence level of the genomics pharmacogenomics result record.',
    `gene_symbol` STRING COMMENT 'The gene symbol of the genomics pharmacogenomics result record.',
    `guideline_source` STRING COMMENT 'The guideline source of the genomics pharmacogenomics result record.',
    `metabolizer_status` STRING COMMENT 'The metabolizer status value classifying the genomics pharmacogenomics result record.',
    `phenotype` STRING COMMENT 'The phenotype of the genomics pharmacogenomics result record.',
    `recommendation` STRING COMMENT 'The recommendation of the genomics pharmacogenomics result record.',
    `reported_date` DATE COMMENT 'Timestamp capturing the reported date associated with the genomics pharmacogenomics result record.',
    `result_date` DATE COMMENT 'Timestamp capturing the result date associated with the genomics pharmacogenomics result record.',
    `pharmacogenomics_result_status` STRING COMMENT 'The pharmacogenomics result status value classifying the genomics pharmacogenomics result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the genomics pharmacogenomics result record.',
    CONSTRAINT pk_pharmacogenomics_result PRIMARY KEY(`pharmacogenomics_result_id`)
) COMMENT 'Records pharmacogenomics result data for the pharmacogenomics result table in the genomics domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ADD CONSTRAINT `fk_genomics_genetic_variant_biobank_specimen_id` FOREIGN KEY (`biobank_specimen_id`) REFERENCES `vibe_healthcare_v1`.`genomics`.`biobank_specimen`(`biobank_specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ADD CONSTRAINT `fk_genomics_pharmacogenomics_result_genetic_variant_id` FOREIGN KEY (`genetic_variant_id`) REFERENCES `vibe_healthcare_v1`.`genomics`.`genetic_variant`(`genetic_variant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`genomics` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`genomics` SET TAGS ('pii_domain' = 'genomics');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` SET TAGS ('pii_subdomain' = 'genomics_core');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `test_result_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `alternate_allele` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `chromosome` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `gene_symbol` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genotype` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `hgvs_notation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `position` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `reference_allele` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `genetic_variant_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ALTER COLUMN `variant_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` SET TAGS ('pii_subdomain' = 'genomics_core');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_accession_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `collection_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `consent_for_future_contact` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `consent_for_research` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ALTER COLUMN `biobank_specimen_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` SET TAGS ('pii_subdomain' = 'genomics_core');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `pharmacogenomics_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `drug_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `drug_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `drug_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `drug_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `drug_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `drug_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `gene_symbol` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `phenotype` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `recommendation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ALTER COLUMN `result_date` SET TAGS ('pii_phi' = 'true');
