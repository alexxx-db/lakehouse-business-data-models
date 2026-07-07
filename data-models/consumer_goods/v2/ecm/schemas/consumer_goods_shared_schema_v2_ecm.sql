-- Schema for Domain: shared | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`shared` COMMENT 'Shared domain (auto-created for table region)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`region` (
    `region_id` BIGINT COMMENT 'Primary key for region',
    `parent_region_id` BIGINT COMMENT 'Identifier of the immediate parent region in the geographic hierarchy.',
    `jurisdiction_id` BIGINT COMMENT 'Regulatory jurisdiction this region maps to.',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Total land area of the region expressed in square kilometres.',
    `climate_zone` STRING COMMENT 'Primary climate classification of the region.',
    `region_code` STRING COMMENT 'Internal alphanumeric code used to reference the region within the enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the region record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for transactions in the region.',
    `region_description` STRING COMMENT 'Free‑form description providing additional context about the region.',
    `effective_from` DATE COMMENT 'Date when the region became valid for business use.',
    `effective_until` DATE COMMENT 'Date when the region ceases to be valid (null if open‑ended).',
    `external_reference` STRING COMMENT 'Reference identifier from external standards such as UN M49 or World Bank.',
    `gdp_usd` DECIMAL(18,2) COMMENT 'Estimated annual GDP of the region expressed in US dollars.',
    `geographic_center_name` STRING COMMENT 'Name of the city or landmark that best represents the regions center.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the region within the geographic hierarchy (e.g., 1 = continent, 2 = country).',
    `is_cross_border` BOOLEAN COMMENT 'True if the region spans more than one sovereign country.',
    `iso_country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code for the country containing the region.',
    `iso_region_code` STRING COMMENT 'Standardized region code as defined by ISO 3166‑2.',
    `latitude_center` DOUBLE COMMENT 'Latitude coordinate of the regions geographic centroid.',
    `longitude_center` DOUBLE COMMENT 'Longitude coordinate of the regions geographic centroid.',
    `median_income_usd` DECIMAL(18,2) COMMENT 'Median annual household income within the region, expressed in US dollars.',
    `region_name` STRING COMMENT 'Human‑readable name of the region (e.g., "Midwest", "Bavaria").',
    `population` BIGINT COMMENT 'Estimated resident population of the region.',
    `primary_language` STRING COMMENT 'Most commonly spoken language in the region.',
    `region_status` STRING COMMENT 'Current operational status of the region.',
    `region_type` STRING COMMENT 'Category that defines the hierarchical level of the region.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier representing the primary time zone of the region.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the region record.',
    `urbanization_rate` DECIMAL(18,2) COMMENT 'Percentage of the regions population living in urban areas.',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Master reference table for region. Referenced by region_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ADD CONSTRAINT `fk_shared_region_parent_region_id` FOREIGN KEY (`parent_region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `parent_region_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Region Id');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Area Sq Km');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `region_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `gdp_usd` SET TAGS ('dbx_business_glossary_term' = 'Gdp Usd');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `geographic_center_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Center Name');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `geographic_center_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `geographic_center_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Is Cross Border');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `iso_country_code` SET TAGS ('dbx_business_glossary_term' = 'Iso Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `iso_region_code` SET TAGS ('dbx_business_glossary_term' = 'Iso Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `latitude_center` SET TAGS ('dbx_business_glossary_term' = 'Latitude Center');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `latitude_center` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `latitude_center` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `longitude_center` SET TAGS ('dbx_business_glossary_term' = 'Longitude Center');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `longitude_center` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `longitude_center` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `median_income_usd` SET TAGS ('dbx_business_glossary_term' = 'Median Income Usd');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Population');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `population` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `population` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `region_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `region_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `urbanization_rate` SET TAGS ('dbx_business_glossary_term' = 'Urbanization Rate');
