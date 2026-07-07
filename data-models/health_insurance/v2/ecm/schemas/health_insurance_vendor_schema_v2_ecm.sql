-- Schema for Domain: vendor | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`vendor` COMMENT 'Manages non-provider third-party vendor and supplier relationships — IT service providers, office supply vendors, facilities management companies, consulting firms, print/mail houses, and other business partners. Tracks vendor master data, contracts, performance, spend, compliance certifications, and risk assessments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` (
    `vendor_id` BIGINT COMMENT 'System-generated unique identifier for the vendor master record.',
    `parent_vendor_id` BIGINT COMMENT 'Self-referencing FK on vendor (parent_vendor_id)',
    `business_category` STRING COMMENT 'More specific business line or market segment of the vendor.',
    `compliance_status` STRING COMMENT 'Overall compliance standing of the vendor with internal policies and regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `contract_effective_date` DATE COMMENT 'Date the contract became legally effective.',
    `contract_expiration_date` DATE COMMENT 'Date the contract expires or is scheduled for renewal.',
    `contract_number` STRING COMMENT 'Unique identifier for the master contract with the vendor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system.',
    `credit_rating` STRING COMMENT 'Credit rating assigned by the finance team. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — promote to reference product]',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dba_name` STRING COMMENT 'Trade name or DBA under which the vendor operates.',
    `default_currency` STRING COMMENT 'Currency used for invoicing the vendor.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `duns_number` STRING COMMENT 'Unique DUNS identifier for the vendor used in credit and risk assessments.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `incorporation_state` STRING COMMENT 'U.S. state (or jurisdiction) where the vendor is legally incorporated.',
    `insurance_certifications` STRING COMMENT 'List of insurance certificates held by the vendor (e.g., liability, workers comp).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_risk_assessment_date` DATE COMMENT 'Date the most recent risk assessment was performed.',
    `legal_name` STRING COMMENT 'Full legal name of the vendor as registered with government authorities.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as minority‑owned.',
    `onboarding_status` STRING COMMENT 'Current status of the vendor onboarding process.. Valid values are `pending|completed|rejected|in_review`',
    `ownership_structure` STRING COMMENT 'Legal ownership model of the vendor organization.. Valid values are `public|private|nonprofit|government|joint_venture`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor.. Valid values are `net_30|net_45|net_60`',
    `primary_naics_code` STRING COMMENT 'Six‑digit North American Industry Classification System code representing the vendors primary industry.. Valid values are `^[0-9]{6}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relationship_end_date` DATE COMMENT 'Date when the vendor relationship ended or is scheduled to end; null if ongoing.',
    `relationship_start_date` DATE COMMENT 'Date when the vendor relationship officially began.',
    `risk_score` STRING COMMENT 'Numerical risk rating (0‑100) derived from assessments.',
    `secondary_naics_codes` STRING COMMENT 'Comma‑separated list of additional NAICS codes applicable to the vendor.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor qualifies as a small business under SBA criteria.',
    `tax_identifier` STRING COMMENT 'Federal employer identification number used for tax reporting.',
    `tier` STRING COMMENT 'Strategic importance tier used for sourcing and governance.. Valid values are `strategic|preferred|approved|conditional|onboarding`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor record.',
    `vendor_status` STRING COMMENT 'Overall lifecycle state of the vendor relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    `vendor_type` STRING COMMENT 'Broad category describing the nature of goods or services supplied.. Valid values are `service_provider|supplies|consulting|facility|staffing|other`',
    `website_url` STRING COMMENT 'Public website address for the vendor.',
    `women_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as women‑owned.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Authoritative master record for all non-provider third-party vendors and suppliers engaged by the health plan — IT service providers, office supply vendors, facilities management companies, consulting firms, print/mail houses, staffing agencies, and other business partners. Captures vendor legal name, DBA name, TIN/EIN, DUNS number, vendor type classification, business category, incorporation state, ownership structure (minority/women-owned, small business), primary NAICS code, vendor tier (strategic, preferred, approved, conditional), onboarding status, active/inactive flag, and relationship inception date. This is the SSOT for vendor identity across the enterprise.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` (
    `vendor_contact_id` BIGINT COMMENT 'System-generated unique identifier for the vendor contact record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor management assigns an internal employee as primary liaison; needed for responsibility and escalation reports.',
    `parent_vendor_contact_id` BIGINT COMMENT 'Self-referencing FK on vendor_contact (parent_vendor_contact_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor organization to which this contact belongs.',
    `address_line1` STRING COMMENT 'Primary street address of the contact.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `city` STRING COMMENT 'City component of the contacts address.',
    `compliance_certification_status` STRING COMMENT 'Current compliance certification state of the contact with respect to regulatory and contractual requirements.. Valid values are `compliant|non_compliant|pending`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the contacts address. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN|IND|BRA — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor contact record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department` STRING COMMENT 'Organizational department within the vendor company where the contact works.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'Primary email address used for communication with the vendor contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `end_date` DATE COMMENT 'Date when the contact relationship ended or is scheduled to end; null if still active.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_name` STRING COMMENT 'Legal first name of the vendor contact person.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for the vendor.',
    `last_name` STRING COMMENT 'Legal last name of the vendor contact person.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor contact record.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the contact, such as special instructions or historical observations.',
    `phone_number` STRING COMMENT 'Primary telephone number for the vendor contact, including country code.. Valid values are `^+?[0-9]{7,15}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the contacts address.',
    `preferred_communication_channel` STRING COMMENT 'Channel the contact prefers for ongoing communications.. Valid values are `email|phone|mail|portal`',
    `primary_contact_method` STRING COMMENT 'Preferred method for initial outreach to the contact.. Valid values are `email|phone|mail`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score (0‑100) representing the risk level associated with this contact based on vendor risk assessments.',
    `role_type` STRING COMMENT 'Business function the contact fulfills for the vendor relationship.. Valid values are `account_manager|sales_representative|technical_lead|billing_contact|legal_contact|executive_sponsor`',
    `start_date` DATE COMMENT 'Date when the contact relationship with the vendor began.',
    `state_province` STRING COMMENT 'State or province component of the contacts address.',
    `title` STRING COMMENT 'Job title or professional designation of the vendor contact.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vendor_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|pending|terminated`',
    CONSTRAINT pk_vendor_contact PRIMARY KEY(`vendor_contact_id`)
) COMMENT 'Master record for all contacts associated with a vendor organization — account managers, sales representatives, technical leads, billing contacts, legal contacts, and executive sponsors. Captures contact name, title, department, phone, email, preferred communication channel, contact role type, primary/secondary flag, and active status. Supports multi-contact vendor relationships and tracks the appropriate point of contact for each business function (contract negotiations, invoice disputes, incident escalation).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` (
    `vendor_address_id` BIGINT COMMENT 'System-generated unique identifier for each vendor address record.',
    `parent_vendor_address_id` BIGINT COMMENT 'Self-referencing FK on vendor_address (parent_vendor_address_id)',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor to which this address belongs.',
    `address_description` STRING COMMENT 'Additional free‑form description or notes about the address.',
    `address_name` STRING COMMENT 'Human‑readable label for the address (e.g., "Main Campus", "Billing Office").',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|closed|pending`',
    `address_type` STRING COMMENT 'Classification of the address purpose for the vendor.. Valid values are `headquarters|billing|remittance|service|mailing|other`',
    `change_reason` STRING COMMENT 'Reason why the address was added, changed, or deactivated.',
    `city` STRING COMMENT 'City component of the address.',
    `contact_email` STRING COMMENT 'Primary email address for the address location.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the address location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the address.',
    `county` STRING COMMENT 'County or district of the address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the address becomes effective for business use.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date when the address ceases to be effective (null if still active).',
    `fax_number` STRING COMMENT 'Fax number associated with the address location.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geocode_accuracy` STRING COMMENT 'Confidence level of the geocoding result.. Valid values are `high|medium|low`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_current` BOOLEAN COMMENT 'Flag indicating whether this address is the current active address for the vendor.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this address is the primary address for the vendor.',
    `last_verified_date` DATE COMMENT 'Date when the address was most recently verified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the address location.',
    `line1` STRING COMMENT 'First line of the street address.',
    `line2` STRING COMMENT 'Second line of the street address (optional).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the address location.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., "America/New_York").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `validation_source` STRING COMMENT 'Source system or service used to validate the address.. Valid values are `USPS|Google|Internal`',
    `validation_status` STRING COMMENT 'Result of address validation checks.. Valid values are `validated|pending|rejected`',
    `verification_notes` STRING COMMENT 'Free‑form notes from the verification process.',
    CONSTRAINT pk_vendor_address PRIMARY KEY(`vendor_address_id`)
) COMMENT 'Physical and mailing addresses associated with a vendor, including headquarters, billing address, remittance address, and service delivery locations. Captures address type, street lines, city, state, ZIP+4, country, county, address validation status, effective date, and end date. Supports multi-location vendors and tracks address history for remittance accuracy and regulatory correspondence.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` (
    `contract_term_id` BIGINT COMMENT 'System-generated unique identifier for the vendor contract term record.',
    `parent_contract_term_id` BIGINT COMMENT 'Self-referencing FK on contract_term (parent_contract_term_id)',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each contract term has a responsible internal employee; required for term‑ownership tracking and compliance reporting.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the parent vendor contract to which this term belongs.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment that introduced or modified this term.',
    `auto_renew_flag` BOOLEAN COMMENT 'True if the term is set to auto‑renew at the end of its period.',
    `clause_number` STRING COMMENT 'Sequential identifier of the clause within the contract (e.g., 1.2, 3.4).',
    `compliance_regulation` STRING COMMENT 'Regulatory regime governing the term, if any.. Valid values are `HIPAA_BAA|HIPAA_PRIVACY|PCI_DSS|GDPR|None`',
    `compliance_required` BOOLEAN COMMENT 'True if the term is subject to regulatory compliance (e.g., HIPAA BAA).',
    `contact_email` STRING COMMENT 'Email address of the responsible party for this term.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number of the responsible party for this term.',
    `contract_term_status` STRING COMMENT 'Current lifecycle status of the term.. Valid values are `Active|Inactive|Expired|Pending|Terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the term record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date when the term expires or is superseded (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the term becomes binding.',
    `escalation_procedure` STRING COMMENT 'Description of the process to follow when the term is breached.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the term is mandatory (vs. optional).',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the legal jurisdiction governing the term. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|... — promote to reference product]',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the term was last reviewed for compliance or performance.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `measurement_method` STRING COMMENT 'Methodology or tool used to capture the performance metric (e.g., monitoring system, manual report).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied if the term is breached.',
    `penalty_description` STRING COMMENT 'Narrative detail of the penalty calculation and enforcement.',
    `penalty_type` STRING COMMENT 'Indicates whether the penalty is a fixed sum, a percentage of invoice, or none.. Valid values are `Fixed|Percentage|None`',
    `performance_metric` STRING COMMENT 'Name of the metric used to measure compliance with the term (e.g., uptime, response time).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry that renewal notice must be given.',
    `renewal_option` STRING COMMENT 'Indicates whether the term renews automatically, manually, or not at all.. Valid values are `Auto|Manual|None`',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the term.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) assigned to the term based on compliance and financial impact.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired performance level that the vendor aims to achieve (e.g., 99.9).',
    `term_description` STRING COMMENT 'Full textual description of the contractual obligation or condition.',
    `term_type` STRING COMMENT 'Category of the contract term, such as Service Level Agreement (SLA) or Payment term.. Valid values are `SLA|Payment|Liability|Indemnification|DataSecurity|Audit`',
    `termination_fee` DECIMAL(18,2) COMMENT 'Fee payable upon early termination of the contract.',
    `termination_notice_days` STRING COMMENT 'Number of days required to give notice before terminating the contract.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Target value that must be met or not exceeded for the term (e.g., 99.5).',
    `unit_of_measure` STRING COMMENT 'Unit for the metric or threshold (e.g., percent, ms, transactions_per_hour).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the term record.',
    CONSTRAINT pk_contract_term PRIMARY KEY(`contract_term_id`)
) COMMENT 'Defines the specific terms, obligations, SLAs, and performance conditions within a vendor contract. Captures term type (SLA, payment term, liability cap, indemnification, data security obligation, HIPAA BAA requirement, audit right, termination for convenience), term description, numeric threshold or target value, unit of measure, penalty or remedy for breach, and effective date range. Enables granular tracking of contractual obligations and SLA compliance monitoring.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'System-generated unique identifier for the contract amendment record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Amendment approvals are performed by employees; linking provides audit trail for regulatory and risk reviews.',
    `parent_contract_amendment_id` BIGINT COMMENT 'Self-referencing FK on contract_amendment (parent_contract_amendment_id)',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the original vendor contract to which this amendment applies.',
    `amendment_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the amendment (e.g., price increase or discount).',
    `amendment_number` STRING COMMENT 'External sequential number or code assigned to the amendment by the vendor management process.',
    `amendment_reason` STRING COMMENT 'Business rationale or trigger for creating the amendment.',
    `amendment_type` STRING COMMENT 'Category describing the nature of the amendment (e.g., scope change, price adjustment).. Valid values are `scope_change|price_adjustment|term_extension|sla_modification|other`',
    `approval_date` DATE COMMENT 'Date on which the amendment was formally approved.',
    `change_summary` STRING COMMENT 'Concise summary of the key modifications made in the amendment.',
    `contract_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `pending|executed|rejected|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the amendment amount.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `contract_amendment_description` STRING COMMENT 'Narrative description of the changes introduced by the amendment.',
    `effective_date` DATE COMMENT 'Date on which the amendment becomes legally binding.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the amendment ceases to be effective, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the amendment record.',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'Tracks all formal amendments, addenda, and modifications to an existing vendor contract. Captures amendment number, amendment type (scope change, price adjustment, term extension, SLA modification), amendment effective date, description of changes, amendment status (pending, executed, rejected), and the approving authority. Maintains a complete audit trail of contract evolution over the vendor relationship lifecycle.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`spend` (
    `spend_id` BIGINT COMMENT 'System-generated unique identifier for each vendor spend transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor spend tracking per cost center requires linking spend records to cost_center for budgeting, variance analysis, and regulatory reporting.',
    `delegated_entity_id` BIGINT COMMENT 'Foreign key linking to credential.delegated_entity. Business justification: Financial reporting ties spend records to the specific delegated credentialing entity receiving the service.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who approved the spend.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Enables plan‑level spend analysis and allocation of vendor expenditures for budgeting and compliance.',
    `parent_spend_id` BIGINT COMMENT 'Self-referencing FK on spend (parent_spend_id)',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order linked to the spend transaction.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the contract under which the spend was incurred.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor providing the goods or services.',
    `amount_discount` DECIMAL(18,2) COMMENT 'Monetary value of any discounts granted on the spend.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total invoice amount before any discounts, taxes, or adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount payable after applying discounts and taxes.',
    `amount_original_currency` DECIMAL(18,2) COMMENT 'Spend amount expressed in the currency in which the vendor invoiced.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Total tax charged on the spend transaction.',
    `amount_usd` DECIMAL(18,2) COMMENT 'Spend amount after conversion to US dollars for consolidated reporting.',
    `approval_date` TIMESTAMP COMMENT 'Date and time the spend received approval.',
    `budget_period` STRING COMMENT 'Fiscal budgeting window to which the spend is allocated.',
    `spend_category` STRING COMMENT 'High‑level category describing the nature of the spend.. Valid values are `IT_Services|Professional_Services|Facilities|Print_Mail|Office_Supplies|Other`',
    `compliance_flag` BOOLEAN COMMENT 'True if the spend meets internal compliance policies and external regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor spend record was first loaded into the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter code of the currency in which the spend is recorded.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `spend_description` STRING COMMENT 'Narrative detail describing the goods or services purchased.',
    `due_date` DATE COMMENT 'Date by which payment must be made to avoid penalties.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Conversion factor from the transaction currency to USD at the time of posting.',
    `expense_type` STRING COMMENT 'Business classification of the expense for budgeting and reporting.. Valid values are `operational|capital|travel|marketing|training|misc`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fiscal_quarter` STRING COMMENT 'Quarter (1‑4) of the fiscal year for the spend.',
    `fiscal_year` STRING COMMENT 'Four‑digit year in which the spend is recorded for financial reporting.',
    `gl_account_code` STRING COMMENT 'Accounting code used to post the spend in the finance system.',
    `internal_order_number` STRING COMMENT 'Identifier used by finance to track internal orders linked to the spend.',
    `invoice_date` DATE COMMENT 'Date printed on the vendor invoice.',
    `invoice_number` STRING COMMENT 'Number assigned by the vendor to the invoice for this spend.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the spend has been formally approved.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_date` DATE COMMENT 'Date on which the payment was executed.',
    `payment_method` STRING COMMENT 'Instrument or channel used to settle the invoice.. Valid values are `credit_card|bank_transfer|check|purchase_card|cash`',
    `payment_reference` STRING COMMENT 'Identifier returned by the payment processor for the transaction.',
    `project_code` STRING COMMENT 'Code of the project or program that the spend supports.',
    `receipt_date` DATE COMMENT 'Date the physical or electronic receipt was issued.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) reflecting vendor financial and operational risk.',
    `spend_status` STRING COMMENT 'Current state of the spend transaction in its processing workflow.. Valid values are `pending|approved|rejected|paid|cancelled`',
    `tax_code` STRING COMMENT 'Code indicating the tax regime applied to the spend.. Valid values are `GST|VAT|SALES|NONE`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Percentage rate used to calculate the tax amount.',
    `transaction_date` TIMESTAMP COMMENT 'Timestamp representing when the spend event occurred in the real world.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the vendor spend record.',
    `vendor_rating` STRING COMMENT 'Qualitative rating of vendor performance used for category management.. Valid values are `A|B|C|D|E|F`',
    CONSTRAINT pk_spend PRIMARY KEY(`spend_id`)
) COMMENT 'Transactional record capturing all spend activity against vendor contracts and purchase orders — invoice payments, purchase card transactions, and non-PO payments. Captures spend transaction date, invoice reference, payment amount, currency, cost center, GL account code, spend category (IT services, professional services, facilities, print/mail, office supplies), budget period, contract reference, PO reference, and payment method. Serves as the SSOT for vendor spend analytics, budget tracking, and category management reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record.',
    `budget_line_id` BIGINT COMMENT 'Link to the budget line item funding this purchase order.',
    `parent_purchase_order_id` BIGINT COMMENT 'Self-referencing FK on purchase_order (parent_purchase_order_id)',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the vendor contract governing this purchase order.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom the purchase order is issued.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the purchase order received final approval.',
    `approval_workflow_code` BIGINT COMMENT 'Reference to the workflow definition governing approval routing.',
    `approved_by` BIGINT COMMENT 'Identifier of the user who approved the purchase order.',
    `bill_to_entity_code` BIGINT COMMENT 'Identifier of the entity responsible for payment of the purchase order.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the purchase order expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first captured.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the purchase order.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `purchase_order_description` STRING COMMENT 'Free‑form text describing the purpose or scope of the purchase order.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of discounts applied to the purchase order.',
    `discount_code` STRING COMMENT 'Code identifying any discount program applied to the purchase order.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied when the purchase order currency differs from the companys base currency.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `invoice_date` DATE COMMENT 'Date on the vendor invoice associated with the purchase order.',
    `invoice_number` STRING COMMENT 'Identifier of the vendor invoice linked to the purchase order.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_three_way_match_enabled` BOOLEAN COMMENT 'Indicates whether three‑way matching (PO, receipt, invoice) is required for this order.',
    `last_modified_by` BIGINT COMMENT 'Identifier of the user who performed the most recent update.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final monetary amount after tax, discounts, and adjustments.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `order_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order was created in the system.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount actually paid to the vendor.',
    `payment_date` DATE COMMENT 'Date on which the payment was executed.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the vendor.',
    `payment_status` STRING COMMENT 'Current status of the payment for the purchase order.. Valid values are `pending|paid|overdue|cancelled`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due (e.g., Net30, Net45).',
    `po_number` STRING COMMENT 'External business identifier assigned to the purchase order.',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement strategy.. Valid values are `standard|blanket|emergency`',
    `procurement_category` STRING COMMENT 'High‑level classification of the spend type for the purchase order.. Valid values are `goods|services|travel|consulting|maintenance|other`',
    `project_code` STRING COMMENT 'Project identifier associated with the purchase order, if applicable.',
    `purchase_order_status` STRING COMMENT 'Current lifecycle state of the purchase order.. Valid values are `draft|approved|issued|partially_received|closed|cancelled`',
    `receipt_received_date` DATE COMMENT 'Date when the goods or services were received against the purchase order.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `requesting_department` STRING COMMENT 'Organizational department that initiated the purchase order.',
    `required_delivery_date` DATE COMMENT 'Date by which the goods or services must be delivered.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk rating for the purchase order based on vendor and spend criteria.',
    `ship_to_location_code` BIGINT COMMENT 'Identifier of the location where the ordered items will be shipped.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the purchase order.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied to the purchase order.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the purchase order before taxes, discounts, and adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the purchase order record.',
    `created_by` BIGINT COMMENT 'Identifier of the user who initially created the purchase order record.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Master record for purchase orders (POs) issued to vendors for goods and services. Captures PO number, PO type (standard, blanket, emergency), issue date, required delivery date, PO status (draft, approved, issued, partially received, closed, cancelled), total PO amount, currency, ship-to location, bill-to entity, payment terms, and the requesting department. Links to vendor contract and budget line. Supports three-way match (PO, receipt, invoice) for accounts payable processing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` (
    `po_line_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order line item.',
    `parent_po_line_id` BIGINT COMMENT 'Self-referencing FK on po_line (parent_po_line_id)',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the parent purchase order header to which this line belongs.',
    `vendor_id` BIGINT COMMENT 'Identifier of the third‑party vendor supplying the item or service.',
    `actual_delivery_date` DATE COMMENT 'Date the goods or service were actually received.',
    `catalog_item_code` BIGINT COMMENT 'Identifier of the catalog item or service being procured on this line.',
    `compliance_flag` STRING COMMENT 'Indicates whether the line complies with internal or regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `contract_number` STRING COMMENT 'Reference to the contract governing this purchase.',
    `cost_center_code` STRING COMMENT 'Internal cost center identifier for budgeting and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values on this line. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|JPY|CHF|AUD|... — promote to reference product]',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_date` DATE COMMENT 'Date the vendor is expected to deliver the goods or complete the service.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date after which the line item is no longer valid (e.g., perishable goods).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_code` STRING COMMENT 'Financial account code to which this lines cost is charged.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_approved` BOOLEAN COMMENT 'True when the line has been approved for purchase.',
    `is_tax_exempt` BOOLEAN COMMENT 'True if the line is exempt from tax.',
    `item_category` STRING COMMENT 'Business classification of the item (e.g., medical device, software, consulting).',
    `item_description` STRING COMMENT 'Free‑text description of the goods or services on the line.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for the line before discounts and taxes (quantity × unit_price).',
    `line_number` STRING COMMENT 'Sequential number of the line within the purchase order.',
    `line_status` STRING COMMENT 'Current processing status of the line item.. Valid values are `open|partially_received|fully_received|cancelled|backordered`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after discounts and taxes (line_amount - discount_amount + tax_amount).',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the line.',
    `procurement_method` STRING COMMENT 'Method used to acquire the item (e.g., purchase, lease).. Valid values are `purchase|lease|service|subscription`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the item ordered, expressed in the specified unit of measure.',
    `receipt_status` STRING COMMENT 'Status of receipt matching for the line.. Valid values are `not_received|received|partial|rejected`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk assessment for the vendor or item on this line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax calculated for this line based on applicable tax codes.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `unit_of_measure` STRING COMMENT 'Standard unit used to quantify the quantity (e.g., each, box, hour).. Valid values are `EA|BOX|HRS|KG|LBS`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the item before discounts and taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the line record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the line.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Line-item detail within a purchase order, representing individual goods or services being procured. Captures line number, item description, item category, quantity ordered, unit of measure, unit price, line amount, delivery date, line status (open, partially received, fully received, cancelled), and GL account code. Enables granular spend tracking, receipt matching, and budget allocation at the line level.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the goods receipt record.',
    `parent_goods_receipt_id` BIGINT COMMENT 'Self-referencing FK on goods_receipt (parent_goods_receipt_id)',
    `purchase_order_id` BIGINT COMMENT 'Unique identifier of the purchase order linked to this receipt.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor who supplied the goods or services.',
    `accepted_quantity` STRING COMMENT 'Quantity of items accepted after inspection.',
    `comments` STRING COMMENT 'Free-text field for additional notes about the receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_note_number` STRING COMMENT 'Reference number from the vendors delivery documentation.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the gross amount.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost associated with delivering the goods.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the goods before any discounts or adjustments.',
    `inspection_date` DATE COMMENT 'Date when the received goods were inspected.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_inspection_required` BOOLEAN COMMENT 'Indicates whether the receipt requires formal inspection.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `match_status` STRING COMMENT 'Result of the three-way match between PO, receipt, and invoice.. Valid values are `matched|unmatched|pending`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discounts and adjustments.',
    `receipt_number` STRING COMMENT 'Business identifier assigned to the receipt, often used in three-way match processes.',
    `receipt_status` STRING COMMENT 'Current processing status of the receipt.. Valid values are `pending_inspection|accepted|partially_accepted|rejected`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were physically received.',
    `received_quantity` STRING COMMENT 'Total quantity of items received from the vendor.',
    `receiver_name` STRING COMMENT 'Name of the employee or person who recorded the receipt.',
    `receiving_location` STRING COMMENT 'Physical location or facility where the goods were received.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rejected_quantity` STRING COMMENT 'Quantity of items rejected during receipt inspection.',
    `rejection_reason` STRING COMMENT 'Explanation for why items were rejected.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the gross amount of the receipt.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the receipt record.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record confirming receipt of goods or services delivered by a vendor against a purchase order. Captures receipt date, received quantity, accepted quantity, rejected quantity, rejection reason, receiving location, receiver name, receipt status (pending inspection, accepted, partially accepted, rejected), and delivery note reference. Supports three-way match for invoice approval and tracks vendor delivery performance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` (
    `invoice_id` BIGINT COMMENT 'System-generated unique identifier for the vendor invoice record.',
    `ap_invoice_id` BIGINT COMMENT 'FK to finance.ap_invoice; links vendor-submitted invoice to GL-recorded AP invoice',
    `delegated_entity_id` BIGINT COMMENT 'Foreign key linking to credential.delegated_entity. Business justification: Invoices for credentialing services must reference the delegated entity to reconcile payments with contracts.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Associates invoices with the specific health plan for accurate financial reconciliation and audit trails.',
    `parent_invoice_id` BIGINT COMMENT 'Self-referencing FK on invoice (parent_invoice_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the invoice.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Invoice-to-enrollment mapping supports audit of vendor invoices to the specific enrollment transaction that generated the service.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the contract governing the goods or services billed.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor that submitted the invoice.',
    `approval_status` STRING COMMENT 'Current status of the invoice approval process.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the invoice was approved.',
    `compliance_certification_status` STRING COMMENT 'Current certification status of the invoice with respect to required compliance checks.. Valid values are `compliant|non_compliant|pending`',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the invoice expense is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the invoice.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if the invoice currency differs from the companys functional currency.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `invoice_description` STRING COMMENT 'Free‑form text describing the goods or services provided.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the invoice, if any.',
    `discount_reason` STRING COMMENT 'Reason or justification for the discount applied.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is currently under dispute.',
    `dispute_reason` STRING COMMENT 'Textual reason for the invoice dispute, if any.',
    `due_date` DATE COMMENT 'Date by which payment must be made according to payment terms.',
    `early_payment_discount_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the early‑payment discount, if applicable.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expense_category` STRING COMMENT 'High‑level classification of the expense type for budgeting and reporting.. Valid values are `supplies|services|consulting|maintenance|travel|other`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Invoice)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice (business event timestamp).',
    `invoice_number` STRING COMMENT 'External invoice number assigned by the vendor.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice within the AP workflow.. Valid values are `received|under_review|approved|disputed|paid|voided`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_early_payment_discount` BOOLEAN COMMENT 'Indicates whether an early‑payment discount was applied.',
    `line_item_count` STRING COMMENT 'Number of individual line items included on the invoice.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after tax, discounts, and retainage are applied.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments related to the invoice.',
    `payment_date` DATE COMMENT 'Date on which payment was made to the vendor.',
    `payment_method` STRING COMMENT 'Method used to remit payment to the vendor.. Valid values are `check|wire|ach|credit_card|eft`',
    `payment_status` STRING COMMENT 'Current payment state of the invoice.. Valid values are `not_paid|partial|paid|overpaid`',
    `payment_terms` STRING COMMENT 'Standard payment term code defining the number of days until payment is due.. Valid values are `net_30|net_45|net_60`',
    `po_number` STRING COMMENT 'Purchase order reference that the invoice is linked to, if applicable.',
    `receipt_date` DATE COMMENT 'Date the invoice was received into the accounts payable system.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the invoice complies with applicable regulatory requirements (e.g., HIPAA, ACA).',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount held back as retainage pending final acceptance of goods/services.',
    `retention_release_date` DATE COMMENT 'Date when retained funds are scheduled to be released to the vendor.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated on the invoice based on applicable tax rules.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason for tax exemption, if applicable.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) used to calculate tax_amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount billed by the vendor before taxes, discounts, or retainage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Vendor-submitted invoice artifact';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`performance` (
    `performance_id` BIGINT COMMENT 'Unique system-generated identifier for each vendor performance evaluation.',
    `delegated_entity_id` BIGINT COMMENT 'Foreign key linking to credential.delegated_entity. Business justification: Performance evaluations are conducted per credentialing vendor; need FK to the delegated entity for score aggregation.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee who performed the evaluation.',
    `parent_performance_id` BIGINT COMMENT 'Self-referencing FK on performance (parent_performance_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being evaluated.',
    `compliance_certification_status` STRING COMMENT 'Current status of required certifications (e.g., ISO, SOC) for the vendor.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the evaluation record was first created in the system.',
    `customer_satisfaction_rating` DECIMAL(18,2) COMMENT 'Average rating from internal customers regarding vendor performance.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `evaluation_end_date` DATE COMMENT 'Last calendar date covered by the evaluation period.',
    `evaluation_period` STRING COMMENT 'Frequency of the evaluation (e.g., monthly, quarterly, annual).. Valid values are `monthly|quarterly|annual`',
    `evaluation_start_date` DATE COMMENT 'First calendar date covered by the evaluation period.',
    `evaluation_status` STRING COMMENT 'Current lifecycle state of the evaluation record.. Valid values are `pending|completed|approved|rejected`',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the evaluation was finalized.',
    `evaluator_notes` STRING COMMENT 'Free‑form comments and observations recorded by the evaluator.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_stability_rating` DECIMAL(18,2) COMMENT 'Rating of the vendors financial health based on internal risk assessment.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issue_resolution_time_days` DECIMAL(18,2) COMMENT 'Average number of days to resolve reported vendor issues.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries completed on or before the agreed schedule.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated score representing overall vendor performance for the period.',
    `quality_defect_rate` DECIMAL(18,2) COMMENT 'Percentage of delivered items or services that required rework or were defective.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reference` STRING COMMENT 'External reference number or code used by business users to locate the evaluation.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from security, compliance, and operational risk factors.',
    `sla_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of Service Level Agreements met during the evaluation period.',
    `tier_decision` STRING COMMENT 'Resulting tier action based on the evaluation (e.g., retain, upgrade).. Valid values are `retain|downgrade|upgrade|terminate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the evaluation record.',
    CONSTRAINT pk_performance PRIMARY KEY(`performance_id`)
) COMMENT 'Periodic vendor performance evaluation record capturing scored assessments of vendor delivery quality, SLA compliance, responsiveness, and relationship health. Captures evaluation period (monthly, quarterly, annual), overall performance score, SLA compliance rate, on-time delivery rate, quality defect rate, issue resolution time, customer satisfaction rating, financial stability rating, and evaluator notes. Supports vendor tiering decisions, contract renewals, and strategic sourcing reviews.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` (
    `sla_event_id` BIGINT COMMENT 'Unique identifier for the SLA event.',
    `parent_sla_event_id` BIGINT COMMENT 'Self-referencing FK on sla_event (parent_sla_event_id)',
    `performance_id` BIGINT COMMENT 'add column performance_id (BIGINT) with FK to vendor.performance.performance_id - SLA events feed performance scoring',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the vendor contract associated with this SLA event.',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual measured value for the SLA metric.',
    `breach_severity` STRING COMMENT 'Severity level of the SLA breach.. Valid values are `minor|major|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA event record was created in the system.',
    `cure_period_end` DATE COMMENT 'End date of the cure period.',
    `cure_period_start` DATE COMMENT 'Start date of the cure period granted to the vendor to remediate the breach.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty amount.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA measurement event occurred.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `measurement_method` STRING COMMENT 'Method used to capture the SLA measurement.. Valid values are `automated|manual`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the SLA event.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the penalty applied.',
    `penalty_triggered` BOOLEAN COMMENT 'Indicates whether a penalty was triggered due to breach.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_date` DATE COMMENT 'Date when the breach was resolved.',
    `resolution_status` STRING COMMENT 'Status of the breach resolution process.. Valid values are `resolved|unresolved|in_progress`',
    `sla_metric_name` STRING COMMENT 'Name of the SLA metric measured (e.g., Response Time, Issue Resolution Time).',
    `sla_status` STRING COMMENT 'Current status of the SLA for this event.. Valid values are `met|breached|at_risk`',
    `target_value` DECIMAL(18,2) COMMENT 'Target SLA value as defined in the contract.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the SLA values.. Valid values are `hours|minutes|seconds|percent|days`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SLA event record.',
    `variance` DECIMAL(18,2) COMMENT 'Difference between actual and target values (actual - target).',
    CONSTRAINT pk_sla_event PRIMARY KEY(`sla_event_id`)
) COMMENT 'Transactional record capturing individual SLA measurement events and breaches for vendor contracts. Captures SLA metric name, measurement date, target value, actual value, variance, SLA status (met, breached, at-risk), breach severity (minor, major, critical), penalty triggered flag, penalty amount, cure period start/end, and resolution status. Provides the granular event-level data underlying vendor performance scorecards and contract compliance monitoring.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'System-generated unique identifier for the vendor risk assessment record.',
    `parent_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (parent_risk_assessment_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being assessed.',
    `assessment_conducted_by` STRING COMMENT 'Name of the individual or team that performed the assessment.',
    `assessment_date` TIMESTAMP COMMENT 'Timestamp when the risk assessment was performed.',
    `assessment_methodology` STRING COMMENT 'Methodology or framework used for the risk assessment (e.g., NIST, ISO 27001).',
    `assessment_reference_code` STRING COMMENT 'Business identifier assigned to the assessment for external reference and tracking.',
    `assessment_type` STRING COMMENT 'Indicates whether the assessment is an initial onboarding, scheduled periodic, or triggered by an event.. Valid values are `initial|periodic|triggered`',
    `business_continuity_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) evaluating the vendors business continuity capabilities.',
    `compliance_certifications` STRING COMMENT 'List of certifications the vendor holds (e.g., SOC 2, ISO 27001).',
    `concentration_risk_flag` BOOLEAN COMMENT 'True if the vendor represents a concentration risk to the organization.',
    `control_effectiveness_rating` STRING COMMENT 'Rating of the effectiveness of existing controls mitigating the inherent risk.. Valid values are `low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `cybersecurity_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) assessing the vendors cybersecurity posture.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_stability_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting the vendors financial health.',
    `inherent_risk_rating` STRING COMMENT 'Rating of the vendors risk before controls are applied.. Valid values are `low|medium|high|critical`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `key_risk_findings` STRING COMMENT 'Summary of the most significant risk issues identified during the assessment. [CONFIDENTIAL – business‑sensitive information].',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the next risk assessment of the vendor.',
    `notes` STRING COMMENT 'Free‑form notes captured by the assessor.',
    `overall_residual_score` DECIMAL(18,2) COMMENT 'Aggregated residual risk score after weighting all risk domains.',
    `recommended_mitigations` STRING COMMENT 'Actionable mitigation recommendations to address identified risks. [CONFIDENTIAL – business‑sensitive information].',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor meets required regulatory compliance standards.',
    `regulatory_compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) measuring compliance with applicable regulations.',
    `reputational_risk_flag` BOOLEAN COMMENT 'True if the vendor poses a reputational risk.',
    `residual_risk_rating` STRING COMMENT 'Rating of the remaining risk after controls are considered.. Valid values are `low|medium|high|critical`',
    `risk_assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment.. Valid values are `open|closed|archived|pending`',
    `risk_domain` STRING COMMENT 'Primary risk domain evaluated in this assessment.. Valid values are `financial|cybersecurity|business_continuity|regulatory_compliance|concentration|reputational`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing overall risk severity on a 0‑100 scale.',
    `risk_tier` STRING COMMENT 'Categorization of the vendor into risk tiers for TPRM program.. Valid values are `tier1|tier2|tier3|tier4`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Risk assessment record evaluating the operational, financial, cybersecurity, and compliance risk profile of a vendor. Captures assessment date, assessment type (initial onboarding, periodic, triggered), risk domain (financial stability, cybersecurity, business continuity, regulatory compliance, concentration risk, reputational), inherent risk rating, control effectiveness rating, residual risk rating (low, medium, high, critical), key risk findings, recommended mitigations, and next assessment due date. Supports vendor risk tiering and third-party risk management (TPRM) program requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` (
    `baa_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the Business Associate Agreement record.',
    `parent_baa_agreement_id` BIGINT COMMENT 'Self-referencing FK on baa_agreement (parent_baa_agreement_id)',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor party associated with this BAA.',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the BAA by the health plan.',
    `agreement_type` STRING COMMENT 'Category of the agreement indicating its legal form.. Valid values are `BAA|Data Use Agreement|Subcontract|Other`',
    `baa_agreement_status` STRING COMMENT 'Current lifecycle state of the BAA.. Valid values are `active|expired|terminated|pending|draft`',
    `breach_notification_obligation` BOOLEAN COMMENT 'Indicates whether the vendor is contractually required to notify the health plan of a PHI breach.',
    `breach_notification_period_days` STRING COMMENT 'Number of days within which the vendor must report a PHI breach to the health plan.',
    `compliance_certification_status` STRING COMMENT 'Current status of the vendors compliance certifications relevant to the BAA.. Valid values are `compliant|non_compliant|pending`',
    `covered_phi_elements` STRING COMMENT 'List or description of the Protected Health Information data elements the vendor may access under the BAA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BAA record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the BAA becomes legally binding.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date the BAA expires or terminates automatically (nullable for open‑ended agreements).',
    `execution_date` DATE COMMENT 'Date the BAA was signed by both parties.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the BAA was last reviewed for compliance or renewal.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the BAA.',
    `permitted_disclosures` STRING COMMENT 'Authorized disclosures of PHI that the vendor may make under the BAA.',
    `permitted_uses` STRING COMMENT 'Allowed purposes for which the vendor may use the PHI covered by the BAA.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory BAA reviews.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing the vendors risk level for handling PHI.',
    `security_safeguard_requirements` STRING COMMENT 'Technical and administrative safeguards the vendor must implement to protect PHI.',
    `signatory_email` STRING COMMENT 'Email address of the health plan signatory.',
    `signatory_name` STRING COMMENT 'Legal name of the health plan representative who signed the BAA.',
    `signatory_phone` STRING COMMENT 'Contact phone number for the health plan signatory.',
    `signatory_title` STRING COMMENT 'Job title of the health plan signatory.',
    `termination_notice_period_days` STRING COMMENT 'Required notice period (in days) the vendor must give before terminating the BAA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the BAA record.',
    `version` STRING COMMENT 'Version identifier of the BAA (e.g., v1.0, v2.1).',
    CONSTRAINT pk_baa_agreement PRIMARY KEY(`baa_agreement_id`)
) COMMENT 'Business Associate Agreement (BAA) record executed with vendors who handle Protected Health Information (PHI) on behalf of the health plan, as required under HIPAA Privacy and Security Rules (45 CFR §164.308). Captures BAA execution date, effective date, expiration date, BAA version, covered PHI data elements, permitted uses and disclosures, security safeguard requirements, breach notification obligations, BAA status (active, expired, terminated, pending), and the health plan signatory. Distinct from compliance.baa which is the compliance domains regulatory obligation tracker — this record is the operational vendor-level BAA management entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique system-generated identifier for each vendor incident.',
    `parent_incident_id` BIGINT COMMENT 'Self-referencing FK on incident (parent_incident_id)',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Incident Impact Reporting links vendor security incidents to affected providers for risk management.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor associated with this incident.',
    `affected_member_count` BIGINT COMMENT 'Count of individual members impacted when PHI is involved.',
    `breach_notification_date` DATE COMMENT 'Calendar date when members received breach notification.',
    `breach_notification_sent` BOOLEAN COMMENT 'True if affected members were notified per breach‑notification rules.',
    `compliance_certification_status` STRING COMMENT 'Current compliance certification state of the vendor (e.g., SOC 2, ISO 27001).. Valid values are `compliant|non_compliant|pending`',
    `corrective_action_required` STRING COMMENT 'Specific remediation steps mandated for the vendor or internal team.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp of initial record insertion.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `incident_description` STRING COMMENT 'Detailed narrative of the incident event, including observable symptoms.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `impacted_functions` STRING COMMENT 'Comma‑separated list of health‑plan functions (e.g., claims processing, member portal) affected.',
    `incident_date` DATE COMMENT 'Calendar date on which the incident was first observed.',
    `incident_number` STRING COMMENT 'Human‑readable incident number assigned by the vendor management process.',
    `incident_status` STRING COMMENT 'Current processing state of the incident within the incident management workflow.. Valid values are `open|under_investigation|resolved|escalated|closed`',
    `incident_type` STRING COMMENT 'Category describing the nature of the vendor incident.. Valid values are `service_outage|data_breach|sla_breach|regulatory_violation|fraud|billing_error`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_phi_involved` BOOLEAN COMMENT 'True if the incident involved protected health information as defined by HIPAA.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_notification_date` DATE COMMENT 'Date the required regulatory body was notified.',
    `regulatory_notification_required` BOOLEAN COMMENT 'True when the incident triggers mandatory reporting under HIPAA, CMS, or other regulations.',
    `reported_by` STRING COMMENT 'Name or identifier of the person/system that logged the incident.',
    `reporting_channel` STRING COMMENT 'Method used to submit the incident report.. Valid values are `email|phone|portal|api`',
    `resolution_date` DATE COMMENT 'Calendar date when corrective actions were completed and the incident was closed.',
    `risk_assessment_score` STRING COMMENT 'Numeric risk rating (e.g., 1‑10) reflecting vendor risk at incident occurrence.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the incident after investigation.',
    `severity_level` STRING COMMENT 'Business‑defined severity classification indicating impact and urgency.. Valid values are `critical|high|medium|low`',
    `severity_score` STRING COMMENT 'Numeric representation of severity used for reporting and trend analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the latest modification to the incident record.',
    `vendor_response_date` DATE COMMENT 'Date the vendor acknowledged the incident and supplied an initial response.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Transactional record for operational incidents, service disruptions, data breaches, and compliance violations involving a vendor. Captures incident date, incident type (service outage, data breach, SLA breach, regulatory violation, fraud, billing error, delivery failure), severity level, incident description, impacted health plan functions, affected member count (if PHI involved), vendor response date, resolution date, root cause, corrective action required, and incident status (open, under investigation, resolved, escalated). Supports vendor risk management, HIPAA breach notification workflows, and contract dispute processes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` (
    `onboarding_id` BIGINT COMMENT 'System-generated unique identifier for each vendor onboarding record.',
    `parent_onboarding_id` BIGINT COMMENT 'Self-referencing FK on onboarding (parent_onboarding_id)',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the contract associated with the vendor onboarding.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being onboarded, linking to the vendor master record.',
    `approval_date` DATE COMMENT 'Date the onboarding was approved.',
    `approved_by` STRING COMMENT 'Name of the individual who authorized the vendor onboarding.',
    `business_justification` STRING COMMENT 'Narrative explaining the business need for engaging the vendor.',
    `checklist_baa_executed` BOOLEAN COMMENT 'Indicates whether a Business Associate Agreement has been executed with the vendor.',
    `checklist_diversity_cert_verified` BOOLEAN COMMENT 'Indicates whether the vendors diversity certification has been verified.',
    `checklist_financial_due_diligence` BOOLEAN COMMENT 'Indicates whether financial due diligence on the vendor has been completed.',
    `checklist_insurance_verified` BOOLEAN COMMENT 'Indicates whether the vendors insurance certificate has been verified.',
    `checklist_security_questionnaire` BOOLEAN COMMENT 'Indicates whether the vendors security questionnaire has been completed.',
    `checklist_w9_received` BOOLEAN COMMENT 'Indicates whether the vendors W-9 tax form has been received.',
    `completion_date` DATE COMMENT 'Date when the onboarding process was completed and the vendor was approved for activation.',
    `compliance_certification_status` STRING COMMENT 'Current compliance certification status of the vendor.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date when the vendors active status ends, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the vendor becomes active in the system after successful onboarding.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the onboarding.',
    `onboarding_status` STRING COMMENT 'Current lifecycle status of the onboarding process.. Valid values are `pending|in_review|approved|conditionally_approved|rejected|cancelled`',
    `outcome` STRING COMMENT 'Final result of the onboarding process.. Valid values are `approved|conditionally_approved|rejected`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_date` DATE COMMENT 'Date the onboarding request was submitted.',
    `request_number` STRING COMMENT 'Unique business identifier assigned to the onboarding request.. Valid values are `^[A-Z0-9]{8}$`',
    `requestor_department` STRING COMMENT 'Internal department that initiated the vendor onboarding request.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing the vendors risk assessment result.',
    `stage` STRING COMMENT 'Current stage of the onboarding workflow.. Valid values are `initial|documentation|compliance|approval|completion`',
    `total_onboarding_cost` DECIMAL(18,2) COMMENT 'Aggregated monetary cost incurred during the onboarding process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the onboarding record.',
    CONSTRAINT pk_onboarding PRIMARY KEY(`onboarding_id`)
) COMMENT 'Transactional record managing the end-to-end vendor onboarding lifecycle from initial request through approved vendor status. Captures onboarding request date, requestor department, business justification, vendor type, onboarding checklist status (W-9 received, insurance certificate verified, BAA executed, security questionnaire completed, financial due diligence completed, diversity certification verified), onboarding stage, approvals obtained, onboarding completion date, and onboarding outcome (approved, conditionally approved, rejected). Ensures all compliance and risk gates are cleared before a vendor is activated in the vendor master.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` (
    `rfp_id` BIGINT COMMENT 'System-generated unique identifier for the RFP record.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor that was awarded the contract, if any.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who approved the solicitation.',
    `parent_rfp_id` BIGINT COMMENT 'Self-referencing FK on rfp (parent_rfp_id)',
    `approval_date` DATE COMMENT 'Date the solicitation received final approval to be issued.',
    `approval_status` STRING COMMENT 'Current approval state of the solicitation before issuance.. Valid values are `pending|approved|rejected`',
    `award_amount` DECIMAL(18,2) COMMENT 'Final monetary amount of the awarded contract.',
    `award_currency` STRING COMMENT 'Currency in which the award amount is expressed.',
    `award_date` DATE COMMENT 'Date the contract was formally awarded to the selected vendor.',
    `award_status` STRING COMMENT 'Current status of the award decision.. Valid values are `pending|awarded|rejected|withdrawn`',
    `compliance_requirements` STRING COMMENT 'List of regulatory or internal compliance obligations tied to the solicitation.',
    `contract_end_estimate` DATE COMMENT 'Projected end date of the contract based on the term.',
    `contract_start_estimate` DATE COMMENT 'Projected start date of the contract once awarded.',
    `contract_term_months` STRING COMMENT 'Planned duration of the contract in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RFP record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the estimated value.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `rfp_description` STRING COMMENT 'Detailed narrative describing the goods or services being sourced.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Projected monetary value of the contract before award.',
    `evaluation_criteria` STRING COMMENT 'Set of criteria used to assess vendor responses (e.g., cost, compliance, capability).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `invited_vendor_count` STRING COMMENT 'Count of distinct vendors that were invited to participate in the solicitation.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issue_date` DATE COMMENT 'Date the solicitation was formally issued to vendors.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `received_response_count` STRING COMMENT 'Count of vendor responses received by the response due date.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `response_due_date` DATE COMMENT 'Deadline by which vendors must submit their responses.',
    `rfp_status` STRING COMMENT 'Current lifecycle status of the solicitation.. Valid values are `draft|issued|evaluation|awarded|cancelled`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating assigned to the solicitation (0‑100 scale).',
    `solicitation_number` STRING COMMENT 'External business identifier assigned to the solicitation for tracking and reference.',
    `solicitation_type` STRING COMMENT 'Indicates whether the solicitation is a Request for Proposal, Request for Information, or Request for Quote.. Valid values are `RFP|RFI|RFQ`',
    `spend_category` STRING COMMENT 'Business classification of the spend (e.g., IT services, office supplies, facilities).',
    `title` STRING COMMENT 'Descriptive title of the solicitation that summarizes its purpose.',
    `updated_by` STRING COMMENT 'User name or identifier of the person who last updated the RFP record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the RFP record.',
    `created_by` STRING COMMENT 'User name or identifier of the person who created the RFP record.',
    CONSTRAINT pk_rfp PRIMARY KEY(`rfp_id`)
) COMMENT 'Master record for Request for Proposal (RFP), Request for Information (RFI), and Request for Quote (RFQ) events issued to prospective vendors during the sourcing and procurement process. Captures solicitation type (RFP, RFI, RFQ), solicitation title, category of spend, issue date, response due date, evaluation criteria, number of vendors invited, number of responses received, solicitation status (draft, issued, evaluation, awarded, cancelled), awarded vendor reference, and estimated contract value. Supports strategic sourcing, competitive bidding, and procurement governance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` (
    `rfp_response_id` BIGINT COMMENT 'System-generated unique identifier for the RFP response record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or analyst who performed the evaluation.',
    `parent_rfp_response_id` BIGINT COMMENT 'Self-referencing FK on rfp_response (parent_rfp_response_id)',
    `rfp_id` BIGINT COMMENT 'Foreign key linking to vendor.rfp. Business justification: Capture which RFP a response belongs to; a response can only belong to one RFP, while an RFP can have many responses.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the responding vendor (master party).',
    `commercial_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting the commercial/price competitiveness of the proposal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFP response record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for all monetary values (e.g., USD, EUR).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount offered by the vendor, if any.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `evaluation_comments` STRING COMMENT 'Detailed comments from the evaluator explaining the scores and decision rationale.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the response within the evaluation workflow.. Valid values are `received|under_evaluation|shortlisted|selected|rejected`',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the evaluation of the response was completed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_price` DECIMAL(18,2) COMMENT 'Final monetary amount after discounts and taxes (total_price - discount_amount + tax_amount).',
    `notes` STRING COMMENT 'Free‑form text for additional remarks captured during intake.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated score combining technical and commercial evaluations, typically weighted per business policy.',
    `proposal_reference_number` STRING COMMENT 'External reference number assigned to the vendors proposal for tracking and audit.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `response_type` STRING COMMENT 'Type of solicitation the response addresses: Request for Proposal (RFP), Request for Information (RFI), or Request for Quote (RFQ).. Valid values are `RFP|RFI|RFQ`',
    `short_list_flag` BOOLEAN COMMENT 'Indicates whether the response was placed on the short‑list for further consideration.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor submitted the response.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax applicable to the total price based on jurisdiction.',
    `technical_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting the technical merit of the vendors solution.',
    `total_price` DECIMAL(18,2) COMMENT 'Total monetary amount proposed by the vendor before discounts, taxes, or adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the RFP response record.',
    CONSTRAINT pk_rfp_response PRIMARY KEY(`rfp_response_id`)
) COMMENT 'Transactional record capturing each vendors response to an RFP, RFI, or RFQ solicitation. Captures responding vendor, submission date, proposal reference number, proposed price/total cost of ownership, technical score, commercial score, overall evaluation score, evaluator notes, shortlist flag, and response status (received, under evaluation, shortlisted, selected, rejected). Enables competitive bid evaluation, vendor selection documentation, and sourcing audit trails.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` (
    `insurance_id` BIGINT COMMENT 'System-generated unique identifier for the vendor insurance record.',
    `parent_insurance_id` BIGINT COMMENT 'Self-referencing FK on insurance (parent_insurance_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to which this insurance certificate applies.',
    `employee_id` BIGINT COMMENT 'Employee who verified the insurance certificate.',
    `additional_insured` BOOLEAN COMMENT 'Indicates whether the health plan is listed as an additional insured on the policy.',
    `additional_insured_entity` STRING COMMENT 'Name of the entity (e.g., health plan) listed as additional insured.',
    `aggregate_limit_amount` DECIMAL(18,2) COMMENT 'Aggregate coverage limit across the policy period.',
    `cancellation_date` DATE COMMENT 'Date the policy was cancelled, if applicable.',
    `carrier_am_best_rating` STRING COMMENT 'AM Best financial strength rating of the carrier.',
    `carrier_naic_code` STRING COMMENT 'NAIC code of the insurance carrier.',
    `carrier_name` STRING COMMENT 'Insurance carrier name',
    `certificate_document_url` STRING COMMENT 'Link to the stored digital copy of the insurance certificate.',
    `certificate_issue_date` DATE COMMENT 'Date the certificate of insurance was issued to the vendor.',
    `certificate_status` STRING COMMENT 'Current status of the insurance certificate.. Valid values are `current|expiring|expired|waived`',
    `compliance_status` STRING COMMENT 'Indicates whether the vendors insurance meets contractual compliance requirements.. Valid values are `compliant|non_compliant|pending_review`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Insurance coverage amount',
    `coverage_effective_date` DATE COMMENT 'Date when the insurance coverage becomes effective.',
    `coverage_expiration_date` DATE COMMENT 'Date when the insurance coverage expires.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the policy will pay for a covered loss.',
    `coverage_limit_currency` STRING COMMENT 'Currency of the coverage limit amount.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `coverage_type_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the vendor must pay out-of-pocket before insurance coverage applies.',
    `deductible_currency` STRING COMMENT 'Currency of the deductible amount.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `insurance_type` STRING COMMENT 'Category of insurance coverage required from the vendor.. Valid values are `general_liability|professional_liability|cyber_liability|workers_compensation|umbrella|auto_liability`',
    `insurer_name` STRING COMMENT 'Name of the insurance carrier providing the coverage.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the insurance record is currently active (true) or inactive (false).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minimum_coverage_threshold_amount` DECIMAL(18,2) COMMENT 'Contractually required minimum coverage amount for the vendor.',
    `minimum_coverage_threshold_currency` STRING COMMENT 'Currency of the minimum coverage threshold.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the insurance certificate.',
    `per_occurrence_limit_amount` DECIMAL(18,2) COMMENT 'Per-occurrence coverage limit.',
    `policy_number` STRING COMMENT 'Unique policy number assigned by the insurer.',
    `policy_period_end` DATE COMMENT 'End date of the insurance policy coverage period.',
    `policy_period_start` DATE COMMENT 'Start date of the insurance policy coverage period.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Premium amount paid for the insurance policy.',
    `premium_currency` STRING COMMENT 'Currency of the premium amount.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the insurance record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the insurance record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `renewal_date` DATE COMMENT 'Next renewal date of the policy.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Score assessing the vendors insurance risk based on coverage and limits.',
    `type_code` STRING COMMENT 'Type of insurance coverage',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verification_date` DATE COMMENT 'Date the certificate of insurance was verified.',
    CONSTRAINT pk_insurance PRIMARY KEY(`insurance_id`)
) COMMENT 'Master record tracking insurance certificates and coverage requirements for vendors. Captures insurance type (general liability, professional liability/E&O, cyber liability, workers compensation, umbrella/excess, auto liability), insurer name, policy number, coverage limit, deductible amount, certificate effective date, certificate expiration date, additional insured status (health plan named as additional insured), certificate status (current, expiring, expired, waived), and required minimum coverage threshold. Ensures vendors maintain contractually required insurance coverage throughout the relationship.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'System-generated unique identifier for each spend category record.',
    `ledger_id` BIGINT COMMENT 'add column ledger_id (BIGINT) with FK to finance.ledger.ledger_id - spend categories map to GL accounts',
    `parent_spend_category_id` BIGINT COMMENT 'Self-referencing FK on spend_category (parent_spend_category_id)',
    `applicable_vendor_type` STRING COMMENT 'Vendor type(s) for which this spend category is relevant.. Valid values are `IT Services|Professional Services|Facilities|Other`',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'Annual budget amount allocated to this spend category (in corporate currency).',
    `category_code` STRING COMMENT 'Business code used to uniquely identify the spend category within the organization.',
    `category_level` STRING COMMENT 'Indicates the depth of the category in the hierarchy: L1 (major), L2 (sub‑category), L3 (detail).. Valid values are `L1|L2|L3`',
    `category_name` STRING COMMENT 'Human‑readable name of the spend category.',
    `category_owner` STRING COMMENT 'Name or role of the internal stakeholder responsible for the category.',
    `compliance_requirements` STRING COMMENT 'Textual list of regulatory or policy requirements applicable to the category.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier linked to the category for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the category record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `spend_category_description` STRING COMMENT 'Detailed narrative describing the scope and purpose of the category.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the category definition becomes active.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the category definition expires or is superseded; null if indefinite.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems (e.g., ERP, procurement) to reference this spend category.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_code` STRING COMMENT 'GL account code used for posting spend transactions classified under this category.',
    `hierarchy_path` STRING COMMENT 'Delimited string representing the full path from the top‑level category to this node (e.g., "IT Services/Software/SaaS").',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the category was last reviewed for relevance or compliance.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `preferred_sourcing_strategy` STRING COMMENT 'Strategic sourcing approach recommended for this category.. Valid values are `single-source|dual-source|competitive-bid`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the category.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of risk associated with the category (0‑100 scale).',
    `spend_category_status` STRING COMMENT 'Current lifecycle status of the category.. Valid values are `active|inactive|deprecated`',
    `unspsc_code` STRING COMMENT 'Universal Standard Classification code that aligns the spend category to the global UNSPSC taxonomy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the category record.',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Reference master defining the hierarchical spend category taxonomy used to classify all vendor spend — enabling category management, budget allocation, and strategic sourcing analysis. Captures category code, category name, parent category (for hierarchy), category level (L1: major category, L2: sub-category, L3: detail category), UNSPSC code alignment, applicable vendor types, preferred sourcing strategy (single-source, dual-source, competitive bid), and category owner. Examples: IT Services > Software > SaaS Applications; Professional Services > Consulting > Management Consulting; Facilities > Maintenance > HVAC Services.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` (
    `relationship_id` BIGINT COMMENT 'System-generated unique identifier for the vendor relationship record.',
    `parent_relationship_id` BIGINT COMMENT 'Self-referencing FK on relationship (parent_relationship_id)',
    `employee_id` BIGINT COMMENT 'add column relationship_owner_employee_id (BIGINT) with FK to workforce.employee.employee_id - vendor relationships have an internal owner',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the primary contract governing this vendor relationship.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor organization involved in the relationship.',
    `annual_review_date` DATE COMMENT 'Date of the most recent or upcoming annual performance and compliance review.',
    `relationship_code` STRING COMMENT 'External business identifier or code used to reference the vendor relationship in contracts and reports.',
    `compliance_certification_status` STRING COMMENT 'Overall status of required certifications (e.g., SOC, ISO) for the vendor.',
    `concentration_risk_flag` BOOLEAN COMMENT 'True when the vendor represents a high concentration of spend or risk across the portfolio.',
    `confidentiality_level` STRING COMMENT 'Data classification level applied to the relationship information.. Valid values are `internal|confidential|restricted|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor relationship record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_security_requirements` STRING COMMENT 'Specific security controls required of the vendor (e.g., encryption, access controls).',
    `dependency_level` STRING COMMENT 'Assessment of how critical the vendors services are to core business operations.. Valid values are `critical|high|medium|low`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the vendor relationship became active and binding.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date the vendor relationship is scheduled to terminate or expire (null for open‑ended).',
    `executive_sponsor_name` STRING COMMENT 'Name of the senior executive championing the vendor partnership.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last completed annual or ad‑hoc relationship review.',
    `manager_name` STRING COMMENT 'Name of the internal employee responsible for day‑to‑day management of the vendor relationship.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form text for additional context, observations, or action items.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance` STRING COMMENT 'Regulatory frameworks the vendor must adhere to (e.g., HIPAA, PCI, SOC 2).',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the vendor relationship.. Valid values are `active|inactive|suspended|pending|terminated`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from financial, compliance, and operational assessments.',
    `single_source_flag` BOOLEAN COMMENT 'True if the organization relies on this vendor as the sole source for a given service or product.',
    `strategic_importance_rating` STRING COMMENT 'Numeric rating (1‑5) indicating the strategic value of the vendor to the organization.',
    `tier` STRING COMMENT 'Classification of the vendor relationship based on strategic importance and spend volume.. Valid values are `strategic_partner|preferred_vendor|approved_vendor|spot_buy_vendor`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor relationship record.',
    CONSTRAINT pk_relationship PRIMARY KEY(`relationship_id`)
) COMMENT 'Master record capturing the strategic relationship classification and account management structure for each vendor. Captures relationship tier (strategic partner, preferred vendor, approved vendor, spot-buy vendor), relationship manager (internal owner), executive sponsor, relationship inception date, annual review date, strategic importance rating, dependency level (critical, high, medium, low), single-source flag, concentration risk flag, and relationship notes. Supports vendor portfolio management, strategic sourcing decisions, and business continuity planning.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` (
    `vendor_dispute_id` BIGINT COMMENT 'System-generated unique identifier for the vendor dispute record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: REQUIRED: Vendor disputes often stem from appeal decisions; linking provides audit trail and regulatory reporting of dispute origins.',
    `parent_vendor_dispute_id` BIGINT COMMENT 'Self-referencing FK on vendor_dispute (parent_vendor_dispute_id)',
    `contract_dispute_id` BIGINT COMMENT 'SSOT reference to canonical dispute master contract.contract_dispute',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order associated with the disputed invoice or service.',
    `header_id` BIGINT COMMENT 'Identifier of a claim linked to the dispute, when the dispute originates from a claim payment.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the vendor contract related to the dispute, if applicable.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor against which the dispute is raised.',
    `dispute_id` BIGINT COMMENT '',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the dispute involves regulatory or contractual compliance considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the disputed amount.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_category` STRING COMMENT 'High‑level classification of the dispute for reporting and analytics.. Valid values are `financial|operational|legal|quality|other`',
    `dispute_description` STRING COMMENT 'Detailed narrative describing the issue, cause, and context of the dispute.',
    `dispute_number` STRING COMMENT 'Business-visible identifier assigned to the dispute, used in communications and tracking.',
    `dispute_type` STRING COMMENT 'Category describing the nature of the dispute (e.g., invoice, service delivery, SLA, contract interpretation).. Valid values are `invoice|service|sla|contract|other`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount that is being contested by the vendor.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute was escalated to higher management or external arbitration.',
    `escalation_reason` STRING COMMENT 'Reason provided for escalating the dispute.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `internal_recommendation` STRING COMMENT 'Recommendation from internal stakeholders (e.g., finance, legal) on how to resolve the dispute.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or additional information captured by users.',
    `open_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute was formally opened in the system.',
    `priority` STRING COMMENT 'Business-assigned priority indicating the urgency of resolution.. Valid values are `low|medium|high`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Identifier of any regulatory filing, audit, or statutory requirement linked to the dispute.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute was formally resolved or closed.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating associated with the dispute, used for prioritization and reporting.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final monetary amount agreed upon to settle the dispute.',
    `supporting_evidence_refs` STRING COMMENT 'Comma‑separated list of URLs or document identifiers that provide evidence for the dispute.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dispute record.',
    `vendor_dispute_status` STRING COMMENT 'Current lifecycle state of the dispute.. Valid values are `open|under_negotiation|escalated|resolved|arbitration|closed`',
    `vendor_position` STRING COMMENT 'Vendors stated stance or explanation regarding the disputed amount.',
    `vendor_response_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor submitted their response or position on the dispute.',
    `created_by` STRING COMMENT 'User identifier of the person who created the dispute record.',
    CONSTRAINT pk_vendor_dispute PRIMARY KEY(`vendor_dispute_id`)
) COMMENT 'Vendor-domain dispute; references the contract.dispute SSOT via ssot_dispute_ref_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` (
    `vendor_lifecycle_event_id` BIGINT COMMENT 'System-generated unique identifier for each immutable vendor lifecycle event record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that initiated the event.',
    `parent_vendor_lifecycle_event_id` BIGINT COMMENT 'Self-referencing FK on vendor_lifecycle_event (parent_vendor_lifecycle_event_id)',
    `vendor_contract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor to which this lifecycle event applies.',
    `approving_authority` STRING COMMENT 'Name or role of the individual or committee that approved the event.',
    `compliance_flag` BOOLEAN COMMENT 'True if the event required a compliance check or regulatory review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was first inserted into the lakehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT '',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_description` STRING COMMENT '',
    `event_number` STRING COMMENT '',
    `event_origin_system` STRING COMMENT 'Name of the source system that generated the event (e.g., Facets, ProviderSource, PBM).',
    `event_reason` STRING COMMENT '',
    `event_sequence` STRING COMMENT 'Monotonically increasing number to preserve chronological order within a vendors lifecycle.',
    `event_status` STRING COMMENT '',
    `event_subtype` STRING COMMENT '',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event occurred in the vendors relationship.',
    `event_type` STRING COMMENT 'Categorical code describing the nature of the lifecycle event.. Valid values are `onboarding_approval|tier_reclassification|contract_execution|suspension|reinstatement|termination`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `initiated_by` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the event is considered critical for compliance or risk management.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `new_status` STRING COMMENT 'Vendor status after the event was applied.. Valid values are `pending|active|suspended|terminated|offboarded`',
    `notes` STRING COMMENT 'Additional comments or observations related to the event.',
    `previous_status` STRING COMMENT 'Vendor status before the event was applied.. Valid values are `pending|active|suspended|terminated|offboarded`',
    `reason` STRING COMMENT 'Free‑text explanation of why the lifecycle event was triggered.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reference` STRING COMMENT 'Identifier of the regulatory requirement or guideline that triggered the event (e.g., HIPAA, CMS).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating (0‑100) assigned to the vendor at the time of the event.',
    `supporting_document_url` STRING COMMENT 'Link to any external document that substantiates the event (e.g., contract amendment, approval memo).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this event record.',
    CONSTRAINT pk_vendor_lifecycle_event PRIMARY KEY(`vendor_lifecycle_event_id`)
) COMMENT 'Vendor-domain lifecycle_event; event_type_code constrained to vendor events, distinct from contract/credential/member lifecycle_event.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` (
    `vendor_document_id` BIGINT COMMENT 'Unique system-generated identifier for the vendor document record.',
    `parent_vendor_document_id` BIGINT COMMENT 'Self-referencing FK on vendor_document (parent_vendor_document_id)',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the vendor contract to which this document is attached.',
    `business_owner` STRING COMMENT 'Internal business owner responsible for the document and its compliance.',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) used to verify file integrity.',
    `compliance_requirements` STRING COMMENT 'Regulatory or contractual compliance standards applicable to the document (e.g., HIPAA, GDPR, SOC2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `vendor_document_description` STRING COMMENT 'Brief free‑text description providing context or summary of the document content.',
    `document_number` STRING COMMENT 'External business identifier or reference number assigned to the document by the vendor or the organization.',
    `document_type` STRING COMMENT 'Category of the vendor document (e.g., contract, SOW, BAA, insurance certificate, W‑9, NDA, etc.). [ENUM-REF-CANDIDATE: contract|sow|baa|insurance_certificate|w9|certification|audit_report|rfp_response|nda|correspondence — promote to reference product]',
    `document_type_code` STRING COMMENT 'Constrains scope to vendor documents, distinct from appeal/credential documents.',
    `effective_date` DATE COMMENT 'Date on which the document becomes effective or binding for the vendor relationship.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the document expires or is no longer valid.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: DocumentReference)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored document file in bytes.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the document is a mandatory requirement for the vendor relationship.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained to satisfy legal or policy requirements.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing the risk associated with the document or its underlying agreement.',
    `storage_location_uri` STRING COMMENT 'Uniform Resource Identifier pointing to the physical or cloud storage location of the document.',
    `title` STRING COMMENT 'Human‑readable title of the document, used to identify its purpose (e.g., "Master Services Agreement").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `uploaded_by` STRING COMMENT 'Name of the internal user who uploaded the document.',
    `vendor_document_status` STRING COMMENT 'Current lifecycle status of the document within the vendor management process.. Valid values are `current|superseded|expired|draft|pending_approval`',
    `version` STRING COMMENT 'Version identifier of the document, typically following a numeric or alphanumeric scheme (e.g., "1.0", "2.1a").',
    CONSTRAINT pk_vendor_document PRIMARY KEY(`vendor_document_id`)
) COMMENT 'Vendor-domain document subtype; document_type_code scoped to vendor documents.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` (
    `vendor_audit_id` BIGINT COMMENT 'System-generated unique identifier for the vendor audit record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Vendor audits are a type of audit engagement; linking them enables consolidating audit findings, risk scores, and compliance metrics across internal and vendor audits.',
    `parent_vendor_audit_id` BIGINT COMMENT 'Self-referencing FK on vendor_audit (parent_vendor_audit_id)',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor being audited.',
    `audit_end_date` DATE COMMENT '',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit, used for tracking and reference in reports.',
    `audit_scope` STRING COMMENT 'Narrative description of the functional, geographic, and regulatory scope covered by the audit.',
    `audit_start_date` DATE COMMENT '',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `planned|in_progress|completed|findings_remediated`',
    `audit_type` STRING COMMENT 'Category of the audit performed (e.g., HIPAA security, SOC 2, contract compliance, financial, operational).. Valid values are `hipaa_security|soc2|contract_compliance|financial|operational`',
    `auditor_email` STRING COMMENT 'Primary email address for the auditor.',
    `auditor_name` STRING COMMENT 'Full legal name of the individual or organization conducting the audit.',
    `auditor_phone` STRING COMMENT 'Contact phone number for the auditor.',
    `auditor_type` STRING COMMENT 'Indicates whether the auditor is an internal employee or an external third‑party.. Valid values are `internal|external`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was officially completed.',
    `compliance_certification_status` STRING COMMENT '',
    `compliance_framework` STRING COMMENT 'Regulatory or industry framework(s) the audit assesses (e.g., HIPAA, SOC 2, ISO 27001).',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all required corrective actions must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any corrective actions were mandated as a result of the audit.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total monetary cost incurred to perform the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the audit cost.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `document_url` STRING COMMENT 'Link to the stored audit report or supporting documentation.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `finding_count` STRING COMMENT '',
    `findings_high_count` STRING COMMENT 'Number of audit findings classified as high severity.',
    `findings_low_count` STRING COMMENT 'Number of audit findings classified as low severity.',
    `findings_medium_count` STRING COMMENT 'Number of audit findings classified as medium severity.',
    `follow_up_date` DATE COMMENT '',
    `initiation_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was formally started.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes captured by the auditor during the audit.',
    `overall_rating` STRING COMMENT 'Overall rating assigned to the audit based on findings and compliance.. Valid values are `excellent|good|fair|poor`',
    `period_end` DATE COMMENT 'Last day of the period examined by the audit.',
    `period_start` DATE COMMENT 'First day of the period examined by the audit.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Governing body or standard organization relevant to the audit.. Valid values are `HIPAA|SOC2|PCI|ISO27001|NIST`',
    `report_issued_date` DATE COMMENT '',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score derived from audit findings, on a 0‑100 scale.',
    `risk_score` DECIMAL(18,2) COMMENT '',
    `status_reason` STRING COMMENT 'Explanation for the current audit status, e.g., reason for delay or remediation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    CONSTRAINT pk_vendor_audit PRIMARY KEY(`vendor_audit_id`)
) COMMENT 'Transactional record for formal audits and compliance reviews conducted on vendors — HIPAA security audits, SOC 2 review assessments, contract compliance audits, financial audits, and operational performance audits. Captures audit type, audit scope, audit period, audit initiation date, audit completion date, auditor (internal or external), audit findings count by severity, overall audit rating, corrective action required flag, corrective action due date, and audit status (planned, in progress, completed, findings remediated). Supports third-party risk management and regulatory compliance obligations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'System‑generated unique identifier for the vendor contract record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract ownership is vested in a specific employee; linking enables ownership audit and approval workflow.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Contracts must reference the specific regulatory obligations they satisfy, supporting compliance reporting and audit of contractual obligations.',
    `delegated_entity_id` BIGINT COMMENT 'Foreign key linking to credential.delegated_entity. Business justification: Contract management process links each credentialing service contract to the specific delegated credentialing entity.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Contract Management report requires linking each vendor contract to the employer group that signed it for compliance and renewal tracking.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Tracks which health plan each vendor contract applies to for regulatory filing and financial reporting.',
    `parent_vendor_contract_id` BIGINT COMMENT 'Self-referencing FK on vendor_contract (parent_vendor_contract_id)',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Provider Contract Management report requires linking each vendor contract to the specific provider it serves.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Vendor Contract Management per Provider Network links contracts to the specific network they serve, required for network‑level compliance reporting.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor party associated with this contract.',
    `amendment_count` STRING COMMENT 'Total number of amendments made to the contract.',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Projected yearly spend under the contract.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiration.',
    `compliance_certifications` STRING COMMENT 'List of certifications (e.g., HIPAA, SOC 2) the vendor holds to satisfy regulatory requirements.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the contract information.. Valid values are `public|internal|confidential|restricted`',
    `contract_description` STRING COMMENT 'Free‑text description of the contract scope and purpose.',
    `contract_number` STRING COMMENT 'External contract number assigned by the health plan or vendor.',
    `contract_type` STRING COMMENT 'Category of the agreement defining its legal and operational nature.. Valid values are `MSA|SOW|SaaS|Maintenance|Professional Services`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the contract record.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_security_requirements` STRING COMMENT 'Security controls the vendor must adhere to (e.g., encryption, access controls).',
    `effective_date` DATE COMMENT 'Date the contract becomes legally binding.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `execution_date` DATE COMMENT 'Date the contract was put into effect (may differ from signed date).',
    `expiration_date` DATE COMMENT 'Date the contract ends unless renewed or terminated earlier.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `governing_law` STRING COMMENT 'State or jurisdiction whose law governs the contract.',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage the vendor must maintain (e.g., liability, workers comp).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exclusive` BOOLEAN COMMENT 'True if the vendor is the sole provider for the contracted service.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the contract is required for core business operations.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notice_sent_date` DATE COMMENT 'Date the renewal notice was transmitted.',
    `notice_sent_flag` BOOLEAN COMMENT 'Indicates whether a renewal notice has been sent to the vendor.',
    `payment_terms` STRING COMMENT 'Standard payment schedule and conditions.. Valid values are `Net30|Net45|Net60|Quarterly|Annual`',
    `penalty_clause` STRING COMMENT 'Terms describing penalties for non‑performance or early termination.',
    `performance_metric` STRING COMMENT 'Key performance indicator used to evaluate vendor performance under the contract.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance` STRING COMMENT 'Regulatory frameworks (HIPAA, PCI, etc.) the contract must satisfy.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiration when a renewal notice must be issued.',
    `renewal_option` STRING COMMENT 'Method by which the contract may be renewed.. Valid values are `auto|manual|none`',
    `risk_score` STRING COMMENT 'Internal risk rating assigned to the vendor contract, where 1 is low risk and 5 is high risk.',
    `service_scope` STRING COMMENT 'Detailed description of services covered by the contract.',
    `signed_date` DATE COMMENT 'Date the contract was signed by all parties.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., pending legal review).',
    `termination_date` DATE COMMENT 'Actual date the contract was terminated before its expiration, if applicable.',
    `title` STRING COMMENT 'Descriptive title of the contract for easy identification.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Overall monetary value of the contract over its full term.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `url` STRING COMMENT 'Link to the electronic copy of the signed contract.',
    `vendor_contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `draft|executed|active|expired|terminated|suspended`',
    `version` STRING COMMENT 'Version label for the contract document (e.g., v1.0, v2.1).',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Vendor-domain contract instance referencing vendor.vendor SSOT; distinct from contract.contract SSOT.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` (
    `vendor_certification_id` BIGINT COMMENT 'System-generated unique identifier for each vendor certification record.',
    `parent_vendor_certification_id` BIGINT COMMENT 'Self-referencing FK on vendor_certification (parent_vendor_certification_id)',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor to which the certification belongs.',
    `certification_name` STRING COMMENT 'Full descriptive name of the certification (e.g., "SOC 2 Type II – Security").',
    `certification_number` STRING COMMENT 'Unique reference number assigned by the issuing body to the certification.',
    `certification_type` STRING COMMENT 'Standardized type of certification held by the vendor. [ENUM-REF-CANDIDATE: minority_owned|women_owned|small_business — promote to reference product]. Valid values are `soc_2_type_ii|iso_27001|hitrust_csf|pci_dss|hipaa_attestation|ssae_18`',
    `compliance_category` STRING COMMENT 'High-level category of compliance (e.g., security, privacy, financial).',
    `compliance_requirements` STRING COMMENT 'Key requirements or controls that the certification attests to.',
    `compliance_scope` STRING COMMENT 'Specific regulatory or industry scope covered by the certification (e.g., HIPAA Security Rule, PCI DSS v4.0).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `document_reference` STRING COMMENT 'Internal reference or file name for the stored certification document.',
    `document_url` STRING COMMENT 'Secure link to the digital copy of the certification document.',
    `effective_date` DATE COMMENT 'Date the certification became effective for the vendor (may differ from issue date).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date the certification expires and must be renewed.',
    `expiration_notice_date` DATE COMMENT 'Date on which the expiration notice was sent.',
    `expiration_notice_sent` BOOLEAN COMMENT 'Flag indicating whether an expiration reminder has been sent to the vendor.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issue_date` DATE COMMENT 'Date the certification was originally issued to the vendor.',
    `issuing_body` STRING COMMENT 'Organization or authority that issued the certification (e.g., AICPA, HITRUST, PCI SSC).',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction applicable to the certification (ISO 3166‑1 alpha‑3 country code).',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the certifications validity and relevance.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_review_due_date` DATE COMMENT 'Planned date for the next periodic review of the certification.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special conditions.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `renewal_due_date` DATE COMMENT 'Date by which renewal activities should be initiated to avoid lapse.',
    `risk_assessment_level` STRING COMMENT 'Categorical risk level derived from the risk assessment score.. Valid values are `low|medium|high`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing the vendors risk posture based on the certification.',
    `status_date` DATE COMMENT 'Date when the current certification status was last changed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `vendor_certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|pending_renewal|revoked|suspended`',
    CONSTRAINT pk_vendor_certification PRIMARY KEY(`vendor_certification_id`)
) COMMENT 'Master record for compliance certifications, regulatory attestations, and industry accreditations held by a vendor. Captures certification type (SOC 2 Type II, ISO 27001, HITRUST CSF, PCI-DSS, HIPAA attestation, SSAE 18, minority/women-owned business certification, small business certification), issuing body, certification number, issue date, expiration date, certification status (active, expired, pending renewal, revoked), and document reference. Tracks vendor compliance posture and supports BAA and HIPAA security rule requirements for business associates.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ADD CONSTRAINT `fk_vendor_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_parent_vendor_contact_id` FOREIGN KEY (`parent_vendor_contact_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ADD CONSTRAINT `fk_vendor_vendor_address_parent_vendor_address_id` FOREIGN KEY (`parent_vendor_address_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_address`(`vendor_address_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ADD CONSTRAINT `fk_vendor_vendor_address_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ADD CONSTRAINT `fk_vendor_contract_term_parent_contract_term_id` FOREIGN KEY (`parent_contract_term_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`contract_term`(`contract_term_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ADD CONSTRAINT `fk_vendor_contract_term_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_parent_contract_amendment_id` FOREIGN KEY (`parent_contract_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_parent_spend_id` FOREIGN KEY (`parent_spend_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`spend`(`spend_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_parent_purchase_order_id` FOREIGN KEY (`parent_purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ADD CONSTRAINT `fk_vendor_po_line_parent_po_line_id` FOREIGN KEY (`parent_po_line_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ADD CONSTRAINT `fk_vendor_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ADD CONSTRAINT `fk_vendor_po_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ADD CONSTRAINT `fk_vendor_goods_receipt_parent_goods_receipt_id` FOREIGN KEY (`parent_goods_receipt_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ADD CONSTRAINT `fk_vendor_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ADD CONSTRAINT `fk_vendor_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_parent_invoice_id` FOREIGN KEY (`parent_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ADD CONSTRAINT `fk_vendor_performance_parent_performance_id` FOREIGN KEY (`parent_performance_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`performance`(`performance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ADD CONSTRAINT `fk_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ADD CONSTRAINT `fk_vendor_sla_event_parent_sla_event_id` FOREIGN KEY (`parent_sla_event_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`sla_event`(`sla_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ADD CONSTRAINT `fk_vendor_sla_event_performance_id` FOREIGN KEY (`performance_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`performance`(`performance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ADD CONSTRAINT `fk_vendor_sla_event_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_parent_risk_assessment_id` FOREIGN KEY (`parent_risk_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ADD CONSTRAINT `fk_vendor_baa_agreement_parent_baa_agreement_id` FOREIGN KEY (`parent_baa_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`baa_agreement`(`baa_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ADD CONSTRAINT `fk_vendor_baa_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_parent_incident_id` FOREIGN KEY (`parent_incident_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`incident`(`incident_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_parent_onboarding_id` FOREIGN KEY (`parent_onboarding_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`onboarding`(`onboarding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ADD CONSTRAINT `fk_vendor_rfp_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ADD CONSTRAINT `fk_vendor_rfp_parent_rfp_id` FOREIGN KEY (`parent_rfp_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`rfp`(`rfp_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_parent_rfp_response_id` FOREIGN KEY (`parent_rfp_response_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`rfp_response`(`rfp_response_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_rfp_id` FOREIGN KEY (`rfp_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`rfp`(`rfp_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ADD CONSTRAINT `fk_vendor_insurance_parent_insurance_id` FOREIGN KEY (`parent_insurance_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`insurance`(`insurance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ADD CONSTRAINT `fk_vendor_insurance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ADD CONSTRAINT `fk_vendor_spend_category_parent_spend_category_id` FOREIGN KEY (`parent_spend_category_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_parent_relationship_id` FOREIGN KEY (`parent_relationship_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`relationship`(`relationship_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_parent_vendor_dispute_id` FOREIGN KEY (`parent_vendor_dispute_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_dispute`(`vendor_dispute_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_parent_vendor_lifecycle_event_id` FOREIGN KEY (`parent_vendor_lifecycle_event_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event`(`vendor_lifecycle_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_parent_vendor_document_id` FOREIGN KEY (`parent_vendor_document_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ADD CONSTRAINT `fk_vendor_vendor_audit_parent_vendor_audit_id` FOREIGN KEY (`parent_vendor_audit_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ADD CONSTRAINT `fk_vendor_vendor_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_parent_vendor_contract_id` FOREIGN KEY (`parent_vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ADD CONSTRAINT `fk_vendor_vendor_certification_parent_vendor_certification_id` FOREIGN KEY (`parent_vendor_certification_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_certification`(`vendor_certification_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ADD CONSTRAINT `fk_vendor_vendor_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`vendor` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`vendor` SET TAGS ('pii_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `business_category` SET TAGS ('pii_business_glossary_term' = 'Business Category');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `contract_effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `contract_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `credit_rating` SET TAGS ('pii_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('pii_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `default_currency` SET TAGS ('pii_business_glossary_term' = 'Default Currency');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `default_currency` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('pii_business_glossary_term' = 'Dun & Bradstreet (DUNS) Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `incorporation_state` SET TAGS ('pii_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `insurance_certifications` SET TAGS ('pii_business_glossary_term' = 'Insurance Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `last_risk_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Last Risk Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('pii_business_glossary_term' = 'Legal Vendor Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('pii_business_glossary_term' = 'Minority Owned Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('pii_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('pii_value_regex' = 'pending|completed|rejected|in_review');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `ownership_structure` SET TAGS ('pii_business_glossary_term' = 'Ownership Structure');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `ownership_structure` SET TAGS ('pii_value_regex' = 'public|private|nonprofit|government|joint_venture');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('pii_value_regex' = 'net_30|net_45|net_60');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `primary_naics_code` SET TAGS ('pii_business_glossary_term' = 'Primary NAICS Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `primary_naics_code` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `primary_naics_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `relationship_end_date` SET TAGS ('pii_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `relationship_start_date` SET TAGS ('pii_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Vendor Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `secondary_naics_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary NAICS Codes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('pii_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN/EIN)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tier` SET TAGS ('pii_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tier` SET TAGS ('pii_value_regex' = 'strategic|preferred|approved|conditional|onboarding');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('pii_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('pii_value_regex' = 'service_provider|supplies|consulting|facility|staffing|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `women_owned_flag` SET TAGS ('pii_business_glossary_term' = 'Women Owned Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `vendor_contact_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `parent_vendor_contact_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Contact Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `parent_vendor_contact_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1 (ADDR_LINE1)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2 (ADDR_LINE2)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Contact Department (DEPARTMENT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address (EMAIL)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Contact End Date (END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Contact First Name (FIRST_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Flag (IS_PRIMARY)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Contact Last Name (LAST_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('pii_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Contact Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number (PHONE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Communication Channel (PREF_CHANNEL)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('pii_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Method (PRIMARY_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_value_regex' = 'email|phone|mail');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `role_type` SET TAGS ('pii_business_glossary_term' = 'Contact Role Type (ROLE_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `role_type` SET TAGS ('pii_value_regex' = 'account_manager|sales_representative|technical_lead|billing_contact|legal_contact|executive_sponsor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Contact Start Date (START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State or Province (STATE_PROV)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Contact Title (TITLE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `vendor_contact_status` SET TAGS ('pii_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `vendor_contact_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Address Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `parent_vendor_address_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Address Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `parent_vendor_address_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `parent_vendor_address_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `parent_vendor_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_description` SET TAGS ('pii_business_glossary_term' = 'Address Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_description` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('pii_business_glossary_term' = 'Address Name (ADDR_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('pii_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('pii_business_glossary_term' = 'Address Type (ADDR_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('pii_value_regex' = 'headquarters|billing|remittance|service|mailing|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `county` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `county` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `geocode_accuracy` SET TAGS ('pii_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `geocode_accuracy` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Address Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State / Province');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `time_zone` SET TAGS ('pii_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `validation_source` SET TAGS ('pii_business_glossary_term' = 'Validation Source');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `validation_source` SET TAGS ('pii_value_regex' = 'USPS|Google|Internal');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `validation_status` SET TAGS ('pii_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `validation_status` SET TAGS ('pii_value_regex' = 'validated|pending|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `verification_notes` SET TAGS ('pii_business_glossary_term' = 'Address Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contract_term_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract Term ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `parent_contract_term_id` SET TAGS ('pii_business_glossary_term' = 'Parent Contract Term Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `parent_contract_term_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `auto_renew_flag` SET TAGS ('pii_business_glossary_term' = 'Auto‑Renew Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `clause_number` SET TAGS ('pii_business_glossary_term' = 'Clause Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `clause_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `compliance_regulation` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `compliance_regulation` SET TAGS ('pii_value_regex' = 'HIPAA_BAA|HIPAA_PRIVACY|PCI_DSS|GDPR|None');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `compliance_required` SET TAGS ('pii_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contract_term_status` SET TAGS ('pii_business_glossary_term' = 'Term Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contract_term_status` SET TAGS ('pii_value_regex' = 'Active|Inactive|Expired|Pending|Terminated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `escalation_procedure` SET TAGS ('pii_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `penalty_description` SET TAGS ('pii_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `penalty_type` SET TAGS ('pii_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `penalty_type` SET TAGS ('pii_value_regex' = 'Fixed|Percentage|None');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `performance_metric` SET TAGS ('pii_business_glossary_term' = 'Performance Metric');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `renewal_notice_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `renewal_option` SET TAGS ('pii_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `renewal_option` SET TAGS ('pii_value_regex' = 'Auto|Manual|None');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `review_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `risk_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `term_description` SET TAGS ('pii_business_glossary_term' = 'Term Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `term_type` SET TAGS ('pii_business_glossary_term' = 'Term Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `term_type` SET TAGS ('pii_value_regex' = 'SLA|Payment|Liability|Indemnification|DataSecurity|Audit');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `termination_fee` SET TAGS ('pii_business_glossary_term' = 'Termination Fee');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `threshold_value` SET TAGS ('pii_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `contract_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract Amendment ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approving Authority Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `parent_contract_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Parent Contract Amendment Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `parent_contract_amendment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_amount` SET TAGS ('pii_business_glossary_term' = 'Amendment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_value_regex' = 'scope_change|price_adjustment|term_extension|sla_modification|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `contract_amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `contract_amendment_status` SET TAGS ('pii_value_regex' = 'pending|executed|rejected|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `contract_amendment_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `spend_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Spend Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Identifier (APPROVER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `parent_spend_id` SET TAGS ('pii_business_glossary_term' = 'Parent Spend Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `parent_spend_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Identifier (PO_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier (VENDOR_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `amount_discount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (AMT_DISC)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `amount_gross` SET TAGS ('pii_business_glossary_term' = 'Gross Amount (AMT_GROSS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `amount_net` SET TAGS ('pii_business_glossary_term' = 'Net Amount (AMT_NET)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `amount_original_currency` SET TAGS ('pii_business_glossary_term' = 'Original Currency Amount (AMT_ORIG)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `amount_tax` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (AMT_TAX)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `amount_usd` SET TAGS ('pii_business_glossary_term' = 'Amount in USD (AMT_USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `budget_period` SET TAGS ('pii_business_glossary_term' = 'Budget Period (BUDG_PER)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `spend_category` SET TAGS ('pii_business_glossary_term' = 'Spend Category (SPEND_CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `spend_category` SET TAGS ('pii_value_regex' = 'IT_Services|Professional_Services|Facilities|Print_Mail|Office_Supplies|Other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag (COMPLIANCE_OK)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `spend_description` SET TAGS ('pii_business_glossary_term' = 'Spend Description (SPEND_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `expense_type` SET TAGS ('pii_business_glossary_term' = 'Expense Type (EXP_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `expense_type` SET TAGS ('pii_value_regex' = 'operational|capital|travel|marketing|training|misc');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fiscal_quarter` SET TAGS ('pii_business_glossary_term' = 'Fiscal Quarter (FQ)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Code (GL_ACCT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `internal_order_number` SET TAGS ('pii_business_glossary_term' = 'Internal Order Number (INT_ORD_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `internal_order_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date (INV_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number (INV_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `is_approved` SET TAGS ('pii_business_glossary_term' = 'Approval Flag (APPROVED)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date (PAY_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'credit_card|bank_transfer|check|purchase_card|cash');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `payment_reference` SET TAGS ('pii_business_glossary_term' = 'Payment Reference (PAY_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `project_code` SET TAGS ('pii_business_glossary_term' = 'Project Code (PROJ_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `project_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date (RCPT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Vendor Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `spend_status` SET TAGS ('pii_business_glossary_term' = 'Transaction Status (TXN_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `spend_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|paid|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `tax_code` SET TAGS ('pii_value_regex' = 'GST|VAT|SALES|NONE');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `tax_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `transaction_date` SET TAGS ('pii_business_glossary_term' = 'Transaction Date (TXN_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `vendor_rating` SET TAGS ('pii_business_glossary_term' = 'Vendor Rating (VENDOR_RATING)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `vendor_rating` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Identifier (BUDGET_LINE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `parent_purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Parent Purchase Order Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `parent_purchase_order_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier (VENDOR_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `approval_workflow_code` SET TAGS ('pii_business_glossary_term' = 'Approval Workflow Identifier (APPROVAL_WF_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `approval_workflow_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By User Identifier (APPROVED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `bill_to_entity_code` SET TAGS ('pii_business_glossary_term' = 'Bill‑To Entity Identifier (BILL_TO_ENT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `bill_to_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code (COST_CENTER_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `purchase_order_description` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Description (PO_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `discount_code` SET TAGS ('pii_business_glossary_term' = 'Discount Code (DISCOUNT_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `discount_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate to Base Currency (EXCH_RATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date (INVOICE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number (INVOICE_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `is_three_way_match_enabled` SET TAGS ('pii_business_glossary_term' = 'Three‑Way Match Enabled Flag (THREE_WAY_MATCH_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Identifier (LAST_MODIFIED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Purchase Order Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `order_timestamp` SET TAGS ('pii_business_glossary_term' = 'Order Placement Timestamp (ORDER_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount (PAYMENT_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date (PAYMENT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date (PAYMENT_DUE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status (PAYMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'pending|paid|overdue|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Type (PO_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_value_regex' = 'standard|blanket|emergency');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `procurement_category` SET TAGS ('pii_business_glossary_term' = 'Procurement Category (PROC_CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `procurement_category` SET TAGS ('pii_value_regex' = 'goods|services|travel|consulting|maintenance|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `project_code` SET TAGS ('pii_business_glossary_term' = 'Project Code (PROJECT_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `project_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Status (PO_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('pii_value_regex' = 'draft|approved|issued|partially_received|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `receipt_received_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Received Date (RECEIPT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `requesting_department` SET TAGS ('pii_business_glossary_term' = 'Requesting Department (REQ_DEPT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `required_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Required Delivery Date (REQ_DELIVERY_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `ship_to_location_code` SET TAGS ('pii_business_glossary_term' = 'Ship‑To Location Identifier (SHIP_TO_LOC_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `ship_to_location_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `tax_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Total Purchase Order Amount (TOTAL_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (CREATED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `parent_po_line_id` SET TAGS ('pii_business_glossary_term' = 'Parent Po Line Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `parent_po_line_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `catalog_item_code` SET TAGS ('pii_business_glossary_term' = 'Catalog Item ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `catalog_item_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `compliance_flag` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('pii_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `is_approved` SET TAGS ('pii_business_glossary_term' = 'Approval Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `is_tax_exempt` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `item_category` SET TAGS ('pii_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `line_amount` SET TAGS ('pii_business_glossary_term' = 'Line Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `line_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'open|partially_received|fully_received|cancelled|backordered');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `procurement_method` SET TAGS ('pii_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `procurement_method` SET TAGS ('pii_value_regex' = 'purchase|lease|service|subscription');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `receipt_status` SET TAGS ('pii_value_regex' = 'not_received|received|partial|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'EA|BOX|HRS|KG|LBS');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `parent_goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Parent Goods Receipt Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `parent_goods_receipt_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('pii_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `freight_cost` SET TAGS ('pii_business_glossary_term' = 'Freight Cost (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `is_inspection_required` SET TAGS ('pii_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `match_status` SET TAGS ('pii_value_regex' = 'matched|unmatched|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_value_regex' = 'pending_inspection|accepted|partially_accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('pii_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receiver_name` SET TAGS ('pii_business_glossary_term' = 'Receiver Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receiver_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receiver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receiving_location` SET TAGS ('pii_business_glossary_term' = 'Receiving Location');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('pii_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_fhir_resource' = 'Invoice');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `parent_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Parent Invoice Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `parent_invoice_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `currency_rate` SET TAGS ('pii_business_glossary_term' = 'Invoice Currency Exchange Rate');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `discount_reason` SET TAGS ('pii_business_glossary_term' = 'Discount Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `early_payment_discount_amount` SET TAGS ('pii_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `expense_category` SET TAGS ('pii_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `expense_category` SET TAGS ('pii_value_regex' = 'supplies|services|consulting|maintenance|travel|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_value_regex' = 'received|under_review|approved|disputed|paid|voided');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `is_early_payment_discount` SET TAGS ('pii_business_glossary_term' = 'Early Payment Discount Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `line_item_count` SET TAGS ('pii_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|wire|ach|credit_card|eft');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'not_paid|partial|paid|overpaid');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_value_regex' = 'net_30|net_45|net_60');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `po_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `retention_amount` SET TAGS ('pii_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `retention_release_date` SET TAGS ('pii_business_glossary_term' = 'Retention Release Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `tax_exempt_reason` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('pii_business_glossary_term' = 'Invoice Total Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `performance_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `parent_performance_id` SET TAGS ('pii_business_glossary_term' = 'Parent Performance Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `parent_performance_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('pii_business_glossary_term' = 'Customer Satisfaction Rating (Scale 1‑5)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_end_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_period` SET TAGS ('pii_business_glossary_term' = 'Evaluation Period');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_period` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_start_date` SET TAGS ('pii_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_status` SET TAGS ('pii_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_status` SET TAGS ('pii_value_regex' = 'pending|completed|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `evaluator_notes` SET TAGS ('pii_business_glossary_term' = 'Evaluator Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `financial_stability_rating` SET TAGS ('pii_business_glossary_term' = 'Financial Stability Rating (Scale 1‑5)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `issue_resolution_time_days` SET TAGS ('pii_business_glossary_term' = 'Issue Resolution Time (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('pii_business_glossary_term' = 'On‑Time Delivery Rate (%)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Score (OUT OF 100)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `quality_defect_rate` SET TAGS ('pii_business_glossary_term' = 'Quality Defect Rate (%)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `reference` SET TAGS ('pii_business_glossary_term' = 'Performance Record Reference');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score (Scale 1‑5)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `sla_compliance_rate` SET TAGS ('pii_business_glossary_term' = 'SLA Compliance Rate (%)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `tier_decision` SET TAGS ('pii_business_glossary_term' = 'Vendor Tier Decision');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `tier_decision` SET TAGS ('pii_value_regex' = 'retain|downgrade|upgrade|terminate');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `sla_event_id` SET TAGS ('pii_business_glossary_term' = 'SLA Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `parent_sla_event_id` SET TAGS ('pii_business_glossary_term' = 'Parent Sla Event Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `parent_sla_event_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `actual_value` SET TAGS ('pii_business_glossary_term' = 'Actual SLA Value');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `breach_severity` SET TAGS ('pii_business_glossary_term' = 'Breach Severity');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `breach_severity` SET TAGS ('pii_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `cure_period_end` SET TAGS ('pii_business_glossary_term' = 'Cure Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `cure_period_start` SET TAGS ('pii_business_glossary_term' = 'Cure Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'automated|manual');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'SLA Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `penalty_triggered` SET TAGS ('pii_business_glossary_term' = 'Penalty Triggered Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `resolution_status` SET TAGS ('pii_value_regex' = 'resolved|unresolved|in_progress');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `sla_metric_name` SET TAGS ('pii_business_glossary_term' = 'SLA Metric Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `sla_status` SET TAGS ('pii_business_glossary_term' = 'SLA Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `sla_status` SET TAGS ('pii_value_regex' = 'met|breached|at_risk');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target SLA Value');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'hours|minutes|seconds|percent|days');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `variance` SET TAGS ('pii_business_glossary_term' = 'SLA Variance');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Risk Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `parent_risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Parent Risk Assessment Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `parent_risk_assessment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_conducted_by` SET TAGS ('pii_business_glossary_term' = 'Assessment Conducted By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_conducted_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_conducted_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('pii_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Reference Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'initial|periodic|triggered');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `business_continuity_score` SET TAGS ('pii_business_glossary_term' = 'Business Continuity Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `compliance_certifications` SET TAGS ('pii_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `compliance_certifications` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `concentration_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Concentration Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('pii_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `cybersecurity_score` SET TAGS ('pii_business_glossary_term' = 'Cybersecurity Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `financial_stability_score` SET TAGS ('pii_business_glossary_term' = 'Financial Stability Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `key_risk_findings` SET TAGS ('pii_business_glossary_term' = 'Key Risk Findings');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `key_risk_findings` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `overall_residual_score` SET TAGS ('pii_business_glossary_term' = 'Overall Residual Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `recommended_mitigations` SET TAGS ('pii_business_glossary_term' = 'Recommended Mitigations');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `recommended_mitigations` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `regulatory_compliance_score` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `reputational_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Reputational Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('pii_value_regex' = 'open|closed|archived|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_domain` SET TAGS ('pii_business_glossary_term' = 'Risk Domain');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_domain` SET TAGS ('pii_value_regex' = 'financial|cybersecurity|business_continuity|regulatory_compliance|concentration|reputational');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `risk_tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `baa_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `parent_baa_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Parent Baa Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `parent_baa_agreement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'BAA|Data Use Agreement|Subcontract|Other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `baa_agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `baa_agreement_status` SET TAGS ('pii_value_regex' = 'active|expired|terminated|pending|draft');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `breach_notification_obligation` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Obligation');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `breach_notification_period_days` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `covered_phi_elements` SET TAGS ('pii_business_glossary_term' = 'Covered PHI Elements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `permitted_disclosures` SET TAGS ('pii_business_glossary_term' = 'Permitted Disclosures of PHI');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `permitted_uses` SET TAGS ('pii_business_glossary_term' = 'Permitted Uses of PHI');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `review_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `security_safeguard_requirements` SET TAGS ('pii_business_glossary_term' = 'Security Safeguard Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_email` SET TAGS ('pii_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_business_glossary_term' = 'Signatory Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('pii_business_glossary_term' = 'Signatory Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_title` SET TAGS ('pii_business_glossary_term' = 'Signatory Title');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Agreement Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Incident ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `parent_incident_id` SET TAGS ('pii_business_glossary_term' = 'Parent Incident Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `parent_incident_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `affected_member_count` SET TAGS ('pii_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `affected_member_count` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `breach_notification_date` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `breach_notification_sent` SET TAGS ('pii_business_glossary_term' = 'Breach Notification Sent');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `impacted_functions` SET TAGS ('pii_business_glossary_term' = 'Impacted Functions');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_status` SET TAGS ('pii_value_regex' = 'open|under_investigation|resolved|escalated|closed');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_type` SET TAGS ('pii_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `incident_type` SET TAGS ('pii_value_regex' = 'service_outage|data_breach|sla_breach|regulatory_violation|fraud|billing_error');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `is_phi_involved` SET TAGS ('pii_business_glossary_term' = 'PHI Involvement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `is_phi_involved` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `is_phi_involved` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `reported_by` SET TAGS ('pii_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `reporting_channel` SET TAGS ('pii_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `reporting_channel` SET TAGS ('pii_value_regex' = 'email|phone|portal|api');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `severity_score` SET TAGS ('pii_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ALTER COLUMN `vendor_response_date` SET TAGS ('pii_business_glossary_term' = 'Vendor Response Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `onboarding_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Onboarding ID (VID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `parent_onboarding_id` SET TAGS ('pii_business_glossary_term' = 'Parent Onboarding Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `parent_onboarding_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID (CID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID (VID)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `business_justification` SET TAGS ('pii_business_glossary_term' = 'Business Justification (BJ)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `checklist_baa_executed` SET TAGS ('pii_business_glossary_term' = 'BAA Executed Flag (BAA)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `checklist_diversity_cert_verified` SET TAGS ('pii_business_glossary_term' = 'Diversity Certification Verified Flag (DIV)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `checklist_financial_due_diligence` SET TAGS ('pii_business_glossary_term' = 'Financial Due Diligence Completed Flag (FIN_DD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `checklist_insurance_verified` SET TAGS ('pii_business_glossary_term' = 'Insurance Certificate Verified Flag (ICV)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `checklist_security_questionnaire` SET TAGS ('pii_business_glossary_term' = 'Security Questionnaire Completed Flag (SEC_Q)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `checklist_w9_received` SET TAGS ('pii_business_glossary_term' = 'W-9 Received Flag (W9)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Completion Date (OCD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status (CCS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Onboarding Notes (ON)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('pii_business_glossary_term' = 'Onboarding Status (OS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('pii_value_regex' = 'pending|in_review|approved|conditionally_approved|rejected|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Onboarding Outcome (OO)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'approved|conditionally_approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Request Date (ORD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Onboarding Request Number (ORN)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `request_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `requestor_department` SET TAGS ('pii_business_glossary_term' = 'Requestor Department (RD)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score (RAS)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `stage` SET TAGS ('pii_business_glossary_term' = 'Onboarding Stage (OSG)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `stage` SET TAGS ('pii_value_regex' = 'initial|documentation|compliance|approval|completion');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `total_onboarding_cost` SET TAGS ('pii_business_glossary_term' = 'Total Onboarding Cost (TOC)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `rfp_id` SET TAGS ('pii_business_glossary_term' = 'Request for Proposal (RFP) Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Awarded Vendor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `parent_rfp_id` SET TAGS ('pii_business_glossary_term' = 'Parent Rfp Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `parent_rfp_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `award_amount` SET TAGS ('pii_business_glossary_term' = 'Awarded Contract Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `award_currency` SET TAGS ('pii_business_glossary_term' = 'Award Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `award_status` SET TAGS ('pii_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `award_status` SET TAGS ('pii_value_regex' = 'pending|awarded|rejected|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `contract_end_estimate` SET TAGS ('pii_business_glossary_term' = 'Estimated Contract End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `contract_start_estimate` SET TAGS ('pii_business_glossary_term' = 'Estimated Contract Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `contract_term_months` SET TAGS ('pii_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `rfp_description` SET TAGS ('pii_business_glossary_term' = 'Solicitation Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `estimated_value` SET TAGS ('pii_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `evaluation_criteria` SET TAGS ('pii_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `invited_vendor_count` SET TAGS ('pii_business_glossary_term' = 'Number of Invited Vendors');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `received_response_count` SET TAGS ('pii_business_glossary_term' = 'Number of Received Responses');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `rfp_status` SET TAGS ('pii_business_glossary_term' = 'Solicitation Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `rfp_status` SET TAGS ('pii_value_regex' = 'draft|issued|evaluation|awarded|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `solicitation_number` SET TAGS ('pii_business_glossary_term' = 'Solicitation Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `solicitation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `solicitation_type` SET TAGS ('pii_business_glossary_term' = 'Solicitation Type (RFP/RFI/RFQ)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `solicitation_type` SET TAGS ('pii_value_regex' = 'RFP|RFI|RFQ');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `spend_category` SET TAGS ('pii_business_glossary_term' = 'Spend Category');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Solicitation Title');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `rfp_response_id` SET TAGS ('pii_business_glossary_term' = 'RFP Response ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `parent_rfp_response_id` SET TAGS ('pii_business_glossary_term' = 'Parent Rfp Response Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `parent_rfp_response_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `rfp_id` SET TAGS ('pii_business_glossary_term' = 'Rfp Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `commercial_score` SET TAGS ('pii_business_glossary_term' = 'Commercial Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `evaluation_comments` SET TAGS ('pii_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `evaluation_status` SET TAGS ('pii_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `evaluation_status` SET TAGS ('pii_value_regex' = 'received|under_evaluation|shortlisted|selected|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `evaluation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `net_price` SET TAGS ('pii_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Evaluation Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `proposal_reference_number` SET TAGS ('pii_business_glossary_term' = 'Proposal Reference Number (PRN)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `proposal_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `response_type` SET TAGS ('pii_business_glossary_term' = 'Response Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `response_type` SET TAGS ('pii_value_regex' = 'RFP|RFI|RFQ');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `short_list_flag` SET TAGS ('pii_business_glossary_term' = 'Short‑List Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `technical_score` SET TAGS ('pii_business_glossary_term' = 'Technical Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `total_price` SET TAGS ('pii_business_glossary_term' = 'Total Price');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('pii_thin_product_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `insurance_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Insurance ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `parent_insurance_id` SET TAGS ('pii_business_glossary_term' = 'Parent Insurance Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `parent_insurance_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `additional_insured` SET TAGS ('pii_business_glossary_term' = 'Additional Insured Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `additional_insured_entity` SET TAGS ('pii_business_glossary_term' = 'Additional Insured Entity');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `certificate_document_url` SET TAGS ('pii_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `certificate_issue_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `certificate_status` SET TAGS ('pii_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `certificate_status` SET TAGS ('pii_value_regex' = 'current|expiring|expired|waived');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `coverage_effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `coverage_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `coverage_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `coverage_limit_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `coverage_limit_currency` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `coverage_limit_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `deductible_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `deductible_currency` SET TAGS ('pii_business_glossary_term' = 'Deductible Currency');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `deductible_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `insurance_type` SET TAGS ('pii_business_glossary_term' = 'Insurance Type (e.g., General Liability, Professional Liability)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `insurance_type` SET TAGS ('pii_value_regex' = 'general_liability|professional_liability|cyber_liability|workers_compensation|umbrella|auto_liability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `insurer_name` SET TAGS ('pii_business_glossary_term' = 'Insurer Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `minimum_coverage_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Minimum Coverage Threshold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `minimum_coverage_threshold_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `minimum_coverage_threshold_currency` SET TAGS ('pii_business_glossary_term' = 'Minimum Coverage Threshold Currency');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `minimum_coverage_threshold_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number (Insurance Policy Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `policy_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `policy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `spend_category_id` SET TAGS ('pii_business_glossary_term' = 'Spend Category Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `parent_spend_category_id` SET TAGS ('pii_business_glossary_term' = 'Parent Spend Category Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `parent_spend_category_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `applicable_vendor_type` SET TAGS ('pii_business_glossary_term' = 'Applicable Vendor Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `applicable_vendor_type` SET TAGS ('pii_value_regex' = 'IT Services|Professional Services|Facilities|Other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `budget_allocation_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_code` SET TAGS ('pii_business_glossary_term' = 'Spend Category Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_level` SET TAGS ('pii_business_glossary_term' = 'Spend Category Level');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_level` SET TAGS ('pii_value_regex' = 'L1|L2|L3');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_name` SET TAGS ('pii_business_glossary_term' = 'Spend Category Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_owner` SET TAGS ('pii_business_glossary_term' = 'Category Owner');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `spend_category_description` SET TAGS ('pii_business_glossary_term' = 'Spend Category Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `external_reference_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `hierarchy_path` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('pii_business_glossary_term' = 'Preferred Sourcing Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('pii_value_regex' = 'single-source|dual-source|competitive-bid');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `review_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `spend_category_status` SET TAGS ('pii_business_glossary_term' = 'Spend Category Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `spend_category_status` SET TAGS ('pii_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `unspsc_code` SET TAGS ('pii_business_glossary_term' = 'UNSPSC Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `unspsc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_subdomain' = 'supplier_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `relationship_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Relationship ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `parent_relationship_id` SET TAGS ('pii_business_glossary_term' = 'Parent Relationship Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `parent_relationship_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `annual_review_date` SET TAGS ('pii_business_glossary_term' = 'Annual Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `relationship_code` SET TAGS ('pii_business_glossary_term' = 'Vendor Relationship Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `relationship_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `concentration_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Concentration Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'internal|confidential|restricted|public');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `data_security_requirements` SET TAGS ('pii_business_glossary_term' = 'Data Security Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `dependency_level` SET TAGS ('pii_business_glossary_term' = 'Dependency Level');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `dependency_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Relationship Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Relationship Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `executive_sponsor_name` SET TAGS ('pii_business_glossary_term' = 'Executive Sponsor Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `manager_name` SET TAGS ('pii_business_glossary_term' = 'Relationship Manager Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `regulatory_compliance` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `relationship_status` SET TAGS ('pii_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `relationship_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Vendor Relationship Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `single_source_flag` SET TAGS ('pii_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `strategic_importance_rating` SET TAGS ('pii_business_glossary_term' = 'Strategic Importance Rating');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `tier` SET TAGS ('pii_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `tier` SET TAGS ('pii_value_regex' = 'strategic_partner|preferred_vendor|approved_vendor|spot_buy_vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_source_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_duplicate_of' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_alias_of' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_canonical' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_master' = 'billing.billing_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_ref' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('pii_ssot_concept' = 'contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_dispute_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Dispute Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `parent_vendor_dispute_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Dispute Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `parent_vendor_dispute_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `contract_dispute_id` SET TAGS ('pii_business_glossary_term' = 'Contract Contract Dispute Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `contract_dispute_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Related Claim Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_category` SET TAGS ('pii_business_glossary_term' = 'Dispute Category');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_category` SET TAGS ('pii_value_regex' = 'financial|operational|legal|quality|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_description` SET TAGS ('pii_business_glossary_term' = 'Dispute Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_business_glossary_term' = 'Dispute Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_type` SET TAGS ('pii_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `dispute_type` SET TAGS ('pii_value_regex' = 'invoice|service|sla|contract|other');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('pii_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `escalation_reason` SET TAGS ('pii_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `internal_recommendation` SET TAGS ('pii_business_glossary_term' = 'Internal Recommendation');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `open_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dispute Open Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `settlement_amount` SET TAGS ('pii_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `supporting_evidence_refs` SET TAGS ('pii_business_glossary_term' = 'Supporting Evidence References');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_dispute_status` SET TAGS ('pii_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_dispute_status` SET TAGS ('pii_value_regex' = 'open|under_negotiation|escalated|resolved|arbitration|closed');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_position` SET TAGS ('pii_business_glossary_term' = 'Vendor Position');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `vendor_response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Vendor Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_source_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_duplicate_of' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_alias_of' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_canonical' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_master' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_ref' = 'member.member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('pii_ssot_concept' = 'member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `vendor_lifecycle_event_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Lifecycle Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiator ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `parent_vendor_lifecycle_event_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Lifecycle Event Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `parent_vendor_lifecycle_event_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `approving_authority` SET TAGS ('pii_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('pii_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_number` SET TAGS ('pii_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_origin_system` SET TAGS ('pii_business_glossary_term' = 'Event Origin System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('pii_business_glossary_term' = 'Event Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_sequence` SET TAGS ('pii_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('pii_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_subtype` SET TAGS ('pii_business_glossary_term' = 'Event Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'onboarding_approval|tier_reclassification|contract_execution|suspension|reinstatement|termination');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `initiated_by` SET TAGS ('pii_business_glossary_term' = 'Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Event Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('pii_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('pii_value_regex' = 'pending|active|suspended|terminated|offboarded');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('pii_business_glossary_term' = 'Previous Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('pii_value_regex' = 'pending|active|suspended|terminated|offboarded');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Event Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `supporting_document_url` SET TAGS ('pii_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_source_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_duplicate_of' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_alias_of' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_canonical' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_master' = 'appeal.appeal_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot' = 'false');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_ref' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('pii_ssot_concept' = 'credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `vendor_document_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `parent_vendor_document_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `parent_vendor_document_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Related Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `business_owner` SET TAGS ('pii_business_glossary_term' = 'Business Owner');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `business_owner` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `business_owner` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `checksum` SET TAGS ('pii_business_glossary_term' = 'File Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `vendor_document_description` SET TAGS ('pii_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `document_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `storage_location_uri` SET TAGS ('pii_business_glossary_term' = 'Storage Location URI');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `uploaded_by` SET TAGS ('pii_business_glossary_term' = 'Uploaded By');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `uploaded_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `uploaded_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `vendor_document_status` SET TAGS ('pii_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `vendor_document_status` SET TAGS ('pii_value_regex' = 'current|superseded|expired|draft|pending_approval');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `vendor_audit_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_engagement_id` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `parent_vendor_audit_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Audit Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `parent_vendor_audit_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|findings_remediated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'hipaa_security|soc2|contract_compliance|financial|operational');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_email` SET TAGS ('pii_business_glossary_term' = 'Auditor Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_phone` SET TAGS ('pii_business_glossary_term' = 'Auditor Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_type` SET TAGS ('pii_business_glossary_term' = 'Auditor Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_type` SET TAGS ('pii_value_regex' = 'internal|external');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `completion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Completion Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `compliance_certification_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Audit Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `finding_count` SET TAGS ('pii_business_glossary_term' = 'Finding Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `findings_high_count` SET TAGS ('pii_business_glossary_term' = 'High Severity Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `findings_low_count` SET TAGS ('pii_business_glossary_term' = 'Low Severity Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `findings_medium_count` SET TAGS ('pii_business_glossary_term' = 'Medium Severity Findings Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `initiation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Initiation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `overall_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Audit Rating');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `overall_rating` SET TAGS ('pii_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `period_end` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `period_start` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'HIPAA|SOC2|PCI|ISO27001|NIST');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `report_issued_date` SET TAGS ('pii_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Audit Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_subdomain' = 'contract_procurement');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Business Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `parent_vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `parent_vendor_contract_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `annual_contract_value` SET TAGS ('pii_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `audit_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `compliance_certifications` SET TAGS ('pii_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `contract_description` SET TAGS ('pii_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type (e.g., Master Service Agreement, Statement of Work, Software as a Service Agreement)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'MSA|SOW|SaaS|Maintenance|Professional Services');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `created_by_user` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `data_security_requirements` SET TAGS ('pii_business_glossary_term' = 'Data Security Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `governing_law` SET TAGS ('pii_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('pii_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `is_exclusive` SET TAGS ('pii_business_glossary_term' = 'Exclusive Vendor Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Contract Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('pii_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `notice_sent_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `notice_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Sent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `payment_terms` SET TAGS ('pii_value_regex' = 'Net30|Net45|Net60|Quarterly|Annual');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `penalty_clause` SET TAGS ('pii_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `performance_metric` SET TAGS ('pii_business_glossary_term' = 'Performance Metric (e.g., SLA Compliance)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `regulatory_compliance` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `renewal_option` SET TAGS ('pii_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `renewal_option` SET TAGS ('pii_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (1-5)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `service_scope` SET TAGS ('pii_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `signed_date` SET TAGS ('pii_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Contract Title');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `total_contract_value` SET TAGS ('pii_business_glossary_term' = 'Total Contract Value (TCV)');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `url` SET TAGS ('pii_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_contract_status` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_contract_status` SET TAGS ('pii_value_regex' = 'draft|executed|active|expired|terminated|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Contract Version Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_subdomain' = 'risk_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `vendor_certification_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Certification ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `parent_vendor_certification_id` SET TAGS ('pii_business_glossary_term' = 'Parent Vendor Certification Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `parent_vendor_certification_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `certification_name` SET TAGS ('pii_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `certification_number` SET TAGS ('pii_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `certification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_value_regex' = 'soc_2_type_ii|iso_27001|hitrust_csf|pci_dss|hipaa_attestation|ssae_18');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `compliance_scope` SET TAGS ('pii_business_glossary_term' = 'Compliance Scope');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `expiration_notice_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `expiration_notice_sent` SET TAGS ('pii_business_glossary_term' = 'Expiration Notice Sent');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `issuing_body` SET TAGS ('pii_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `risk_assessment_level` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `risk_assessment_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `status_date` SET TAGS ('pii_business_glossary_term' = 'Certification Status Date');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `vendor_certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `vendor_certification_status` SET TAGS ('pii_value_regex' = 'active|expired|pending_renewal|revoked|suspended');
