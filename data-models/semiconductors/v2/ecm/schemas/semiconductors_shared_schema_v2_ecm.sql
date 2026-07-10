-- Schema for Domain: shared | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:17:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`shared` COMMENT 'Shared domain (auto-created for table site)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `parent_site_id` BIGINT COMMENT 'Self-referencing FK on site (parent_site_id)',
    `location_id` BIGINT COMMENT 'Foreign key linking to shared.location. Business justification: Site belongs to a geographic location; adding site_location_id creates a child→parent FK and eliminates potential duplicate address data.',
    `address_line1` STRING COMMENT 'First line of the site’s street address.',
    `address_line2` STRING COMMENT 'Second line of the site’s street address (optional).',
    `capacity_per_day` STRING COMMENT 'Maximum number of units the site can produce per day.',
    `city` STRING COMMENT 'City where the site is located.',
    `closing_date` DATE COMMENT 'Date the site ceased operations, if applicable.',
    `site_code` STRING COMMENT 'External code used to reference the site in enterprise systems.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance state of the site.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the site resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the data lake.',
    `data_center_flag` BOOLEAN COMMENT 'True if the site hosts data‑center facilities.',
    `site_description` STRING COMMENT 'Free‑form description of the site’s purpose or characteristics.',
    `environmental_certification` STRING COMMENT 'Environmental sustainability certification held by the site.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site in decimal degrees.',
    `manager_email` STRING COMMENT 'Email address of the site manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for site operations.',
    `manager_phone` STRING COMMENT 'Contact phone number of the site manager.',
    `site_name` STRING COMMENT 'Human‑readable name of the site.',
    `number_of_employees` STRING COMMENT 'Total number of staff assigned to the site.',
    `opening_date` DATE COMMENT 'Date the site began operations.',
    `operational_since` TIMESTAMP COMMENT 'Exact timestamp when the site became operational.',
    `owner` STRING COMMENT 'Organizational unit that owns the site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `power_capacity_kw` BIGINT COMMENT 'Maximum electrical power capacity of the site in kilowatts.',
    `primary_contact_phone` STRING COMMENT 'General contact phone number for the site.',
    `region` STRING COMMENT 'Broad geographic region grouping for the site.',
    `security_classification` STRING COMMENT 'Data security level assigned to the site.',
    `site_type` STRING COMMENT 'Category describing the primary function of the site.',
    `square_footage` BIGINT COMMENT 'Total usable floor area of the site in square feet.',
    `state_province` STRING COMMENT 'State or province of the site location.',
    `site_status` STRING COMMENT 'Current operational status of the site.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the site (e.g., America/Los_Angeles).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by site_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Identifier of the parent location in a hierarchical geography (e.g., campus > building).',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_per_day` DECIMAL(18,2) COMMENT 'Maximum number of units the facility can produce per day.',
    `city` STRING COMMENT 'City where the location is situated.',
    `closing_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `location_code` STRING COMMENT 'External business code used to reference the location in contracts, shipping documents and ERP systems.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center identifier linked to the location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the data lake.',
    `location_description` STRING COMMENT 'Free‑form description providing additional context about the location.',
    `email_address` STRING COMMENT 'Primary email address for the location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `manager_name` STRING COMMENT 'Name of the person responsible for day‑to‑day operations.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility, plant, warehouse or office.',
    `number_of_employees` STRING COMMENT 'Number of staff assigned to the location.',
    `opening_date` DATE COMMENT 'Date the location became operational.',
    `phone_number` STRING COMMENT 'Primary telephone number for the location.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the locations mailing address.',
    `region` STRING COMMENT 'Broad geographic region (e.g., EMEA, APAC, AMER) for reporting aggregation.',
    `source_system_code` STRING COMMENT 'Native identifier of the location in the source system.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total usable floor area of the location in square feet.',
    `state_province` STRING COMMENT 'State or province abbreviation for the location.',
    `location_status` STRING COMMENT 'Current lifecycle status of the location.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/Los_Angeles).',
    `location_type` STRING COMMENT 'Category of the location indicating its primary function within the semiconductor business.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    `website_url` STRING COMMENT 'Public website URL for the location, if applicable.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ADD CONSTRAINT `fk_shared_site_parent_site_id` FOREIGN KEY (`parent_site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ADD CONSTRAINT `fk_shared_site_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ADD CONSTRAINT `fk_shared_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` SET TAGS ('dbx_subdomain' = 'shared_core');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Site Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `data_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Center Flag');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `operational_since` SET TAGS ('dbx_business_glossary_term' = 'Operational Since');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Site Owner');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `power_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Kw');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` SET TAGS ('dbx_subdomain' = 'shared_core');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
