-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`compliance` COMMENT 'Regulatory compliance including export controls (EAR, ITAR), environmental regulations (RoHS, REACH, TSCA), trade compliance, CHIPS Act reporting, and industry standards adherence (SEMI, JEDEC, ISO). Manages compliance audits, certifications, product substance declarations, export license records, and regulatory filings.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` (
    `export_license_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'Customer account associated with the license',
    `employee_id` BIGINT COMMENT 'Employee authorized to manage export license',
    `authorized_commodities` STRING COMMENT 'List of commodities authorized under this license',
    `authorized_countries` STRING COMMENT 'Countries authorized for export',
    `authorized_end_users` STRING COMMENT 'Approved end users',
    `compliance_agreement` STRING COMMENT 'Reference to compliance agreement',
    `conditions` STRING COMMENT 'Conditions attached to the license',
    `effective_from` DATE COMMENT 'Start date of license validity',
    `effective_until` DATE COMMENT 'End date of license validity',
    `end_use_certificate_type` STRING COMMENT 'Type of end-use certificate',
    `end_use_description` STRING COMMENT 'Description of intended end use',
    `end_user_address` STRING COMMENT 'Address of end user',
    `end_user_name` STRING COMMENT 'Name of end user',
    `export_license_status` STRING COMMENT 'Current status of the export license',
    `issue_date` DATE COMMENT 'Date license was issued',
    `issuing_authority` STRING COMMENT 'Government authority that issued the license',
    `license_number` STRING COMMENT 'Unique license number',
    `license_type` STRING COMMENT 'Type of export license',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `registration_category` STRING COMMENT 'Category of registration',
    `renewal_date` DATE COMMENT 'Date license must be renewed',
    `renewal_required` BOOLEAN COMMENT 'Whether renewal is required',
    `usml_category` STRING COMMENT 'US Munitions List category',
    `value_ceiling` DECIMAL(18,2) COMMENT 'Maximum value authorized under license',
    `verification_date` DATE COMMENT 'Date of last verification',
    `verification_status` STRING COMMENT 'Status of verification',
    CONSTRAINT pk_export_license PRIMARY KEY(`export_license_id`)
) COMMENT 'Export license records for controlled semiconductor technology and products';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` (
    `export_license_usage_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'Customer account',
    `employee_id` BIGINT COMMENT 'Employee who created the record',
    `eccn_classification_id` BIGINT COMMENT 'FK to ECCN classification',
    `export_license_id` BIGINT COMMENT 'Primary export license being consumed',
    `to_export_license_id` BIGINT COMMENT 'Target export license',
    `audit_trail` STRING COMMENT 'Audit trail reference',
    `commodity_usml_category` STRING COMMENT 'USML category of commodity',
    `compliance_status` STRING COMMENT 'Current compliance status',
    `consignee_name` STRING COMMENT 'Name of consignee',
    `cumulative_license_utilization_percent` DECIMAL(18,2) COMMENT 'Cumulative utilization percentage',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the export license usage compliance record.',
    `declared_value` DECIMAL(18,2) COMMENT 'Declared value of export',
    `destination_country_code` STRING COMMENT 'Destination country ISO code',
    `end_user_name` STRING COMMENT 'The end user name of the export license usage record in the compliance domain.',
    `export_control_regulation` STRING COMMENT 'Applicable export control regulation',
    `export_date` DATE COMMENT 'Date of export',
    `export_license_type` STRING COMMENT 'Type of export license used',
    `export_license_usage_status` STRING COMMENT 'Status of usage record',
    `is_sensitive` BOOLEAN COMMENT 'Whether shipment is sensitive',
    `quantity_exported` STRING COMMENT 'Number of units exported',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `shipment_reference` STRING COMMENT 'Reference to shipment',
    CONSTRAINT pk_export_license_usage PRIMARY KEY(`export_license_usage_id`)
) COMMENT 'Tracks usage/consumption of export license allocations for semiconductor shipments';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` (
    `eccn_classification_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee who performed classification',
    `classification_basis` STRING COMMENT 'Basis for classification determination',
    `classification_date` DATE COMMENT 'Date classification was made',
    `classification_status` STRING COMMENT 'Status of classification',
    `commodity_jurisdiction` STRING COMMENT 'Jurisdiction determination (EAR vs ITAR)',
    `control_reason` STRING COMMENT 'Reason for export control',
    `eccn_code` STRING COMMENT 'Export Control Classification Number',
    `effective_date` DATE COMMENT 'Date classification becomes effective',
    `expiry_date` DATE COMMENT 'Date classification expires',
    `license_exception_available` BOOLEAN COMMENT 'Whether a license exception is available',
    `license_exception_type` STRING COMMENT 'Type of license exception',
    `notes` STRING COMMENT 'Classification notes',
    `performance_parameter` STRING COMMENT 'Key performance parameter driving classification',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `review_date` DATE COMMENT 'Next review date',
    `technology_level` STRING COMMENT 'Technology level for classification',
    CONSTRAINT pk_eccn_classification PRIMARY KEY(`eccn_classification_id`)
) COMMENT 'Export Control Classification Number assignments for semiconductor products';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` (
    `restricted_party_screening_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'Customer account screened',
    `employee_id` BIGINT COMMENT 'Employee who performed screening',
    `entity_country` STRING COMMENT 'Country of entity',
    `entity_name` STRING COMMENT 'Name of entity screened',
    `entity_type` STRING COMMENT 'Type of entity (customer, supplier, end-user)',
    `false_positive_flag` BOOLEAN COMMENT 'Whether match was a false positive',
    `list_matched` STRING COMMENT 'Restricted party list that matched',
    `match_score` DECIMAL(18,2) COMMENT 'Confidence score of match',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `resolution_action` STRING COMMENT 'Action taken to resolve hit',
    `resolution_date` DATE COMMENT 'Date hit was resolved',
    `resolved_by` STRING COMMENT 'Person who resolved the hit',
    `screening_date` DATE COMMENT 'Date screening was performed',
    `screening_provider` STRING COMMENT 'Third-party screening provider used',
    `screening_result` STRING COMMENT 'Result (clear, hit, potential_match)',
    `screening_status` STRING COMMENT 'Status of screening',
    `transaction_reference` STRING COMMENT 'Reference to triggering transaction',
    CONSTRAINT pk_restricted_party_screening PRIMARY KEY(`restricted_party_screening_id`)
) COMMENT 'Screening results against denied/restricted party lists for semiconductor transactions';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` (
    `reach_svhc_declaration_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee who made declaration',
    `ic_catalog_id` BIGINT COMMENT 'Product declared',
    `supplier_id` BIGINT COMMENT 'Supplier providing declaration data',
    `article_weight_grams` DECIMAL(18,2) COMMENT 'Weight of article in grams',
    `candidate_list_version` STRING COMMENT 'ECHA candidate list version',
    `concentration_percent` DECIMAL(18,2) COMMENT 'Concentration percentage',
    `declaration_date` DATE COMMENT 'Date of declaration',
    `declaration_status` STRING COMMENT 'Status of declaration',
    `expiry_date` DATE COMMENT 'Expiry date of declaration',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `safe_use_instructions` STRING COMMENT 'Instructions for safe use',
    `svhc_above_threshold_flag` BOOLEAN COMMENT 'Whether SVHC exceeds 0.1% w/w threshold',
    `svhc_cas_number` STRING COMMENT 'CAS number of substance',
    `svhc_substance_name` STRING COMMENT 'Name of SVHC substance',
    CONSTRAINT pk_reach_svhc_declaration PRIMARY KEY(`reach_svhc_declaration_id`)
) COMMENT 'REACH SVHC (Substances of Very High Concern) declarations for semiconductor products';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` (
    `substance_inventory_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee managing substance record',
    `supplier_id` BIGINT COMMENT 'Supplier of substance',
    `annual_usage_kg` DECIMAL(18,2) COMMENT 'Annual usage in kilograms',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service number',
    `ec_number` STRING COMMENT 'European Community number',
    `hazard_classification` STRING COMMENT 'GHS hazard classification',
    `phase_out_date` DATE COMMENT 'Planned phase-out date',
    `reach_registered_flag` BOOLEAN COMMENT 'Whether substance is REACH registered',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `regulatory_status` STRING COMMENT 'Current regulatory status',
    `rohs_restricted_flag` BOOLEAN COMMENT 'Whether restricted under RoHS',
    `safety_data_sheet_reference` STRING COMMENT 'The safety data sheet reference of the substance inventory record in the compliance domain.',
    `storage_location` STRING COMMENT 'Where substance is stored',
    `substance_category` STRING COMMENT 'Category of substance',
    `substance_name` STRING COMMENT 'Chemical substance name',
    `substitute_substance` STRING COMMENT 'Proposed substitute substance',
    `svhc_flag` BOOLEAN COMMENT 'Whether substance is SVHC',
    CONSTRAINT pk_substance_inventory PRIMARY KEY(`substance_inventory_id`)
) COMMENT 'Inventory of chemical substances used in semiconductor manufacturing for regulatory tracking';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`certification` (
    `certification_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - certifications apply to specific products',
    `employee_id` BIGINT COMMENT 'Employee responsible for certification',
    `site_id` BIGINT COMMENT 'Site holding certification',
    `body` STRING COMMENT 'Certifying organization',
    `certification_number` STRING COMMENT 'Certificate number',
    `certification_status` STRING COMMENT 'Current status',
    `effective_date` DATE COMMENT 'Start of validity',
    `expiry_date` DATE COMMENT 'End of validity',
    `last_audit_date` DATE COMMENT 'Date of last surveillance audit',
    `next_audit_date` DATE COMMENT 'Date of next scheduled audit',
    `nonconformity_count` STRING COMMENT 'Number of open nonconformities',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `scope` STRING COMMENT 'Scope of certification',
    `standard` STRING COMMENT 'Standard (ISO 9001, IATF 16949, etc.)',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Compliance certifications (ISO, IATF, etc.) held by the semiconductor organization';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` (
    `audit_event_id` BIGINT COMMENT 'Primary key',
    `certification_id` BIGINT COMMENT 'Related certification',
    `employee_id` BIGINT COMMENT 'Lead auditor employee',
    `site_id` BIGINT COMMENT 'Site being audited',
    `actual_end_date` DATE COMMENT 'The actual end date associated with the audit event compliance record.',
    `actual_start_date` DATE COMMENT 'The actual start date associated with the audit event compliance record.',
    `audit_conclusion` STRING COMMENT 'The audit conclusion of the audit event record in the compliance domain.',
    `audit_scope` STRING COMMENT 'Scope of audit',
    `audit_standard` STRING COMMENT 'Standard being audited against',
    `audit_status` STRING COMMENT 'Current status',
    `audit_type` STRING COMMENT 'Type of audit (internal, external, regulatory)',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective actions',
    `finding_count` STRING COMMENT 'Number of findings',
    `major_nonconformity_count` STRING COMMENT 'Number of major nonconformities',
    `minor_nonconformity_count` STRING COMMENT 'Number of minor nonconformities',
    `notes` STRING COMMENT 'Additional notes',
    `observation_count` STRING COMMENT 'Number of observations',
    `planned_end_date` DATE COMMENT 'The planned end date associated with the audit event compliance record.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the audit event compliance record.',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_audit_event PRIMARY KEY(`audit_event_id`)
) COMMENT 'Compliance audit events including internal, external, and regulatory audits';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` (
    `compliance_audit_finding_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee assigned to resolve finding',
    `audit_event_id` BIGINT COMMENT 'Parent audit event',
    `clause_reference` STRING COMMENT 'Standard clause reference',
    `closure_date` DATE COMMENT 'Date finding was closed',
    `corrective_action` STRING COMMENT 'Corrective action taken',
    `due_date` DATE COMMENT 'Due date for resolution',
    `effectiveness_verified_flag` BOOLEAN COMMENT 'Whether effectiveness was verified',
    `finding_description` STRING COMMENT 'Description of finding',
    `finding_number` STRING COMMENT 'Unique finding number',
    `finding_status` STRING COMMENT 'Current status',
    `finding_type` STRING COMMENT 'Type (major NC, minor NC, observation, opportunity)',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `risk_level` STRING COMMENT 'Risk level of finding',
    `root_cause` STRING COMMENT 'Root cause analysis',
    `verification_date` DATE COMMENT 'Date corrective action was verified',
    CONSTRAINT pk_compliance_audit_finding PRIMARY KEY(`compliance_audit_finding_id`)
) COMMENT 'Findings from compliance audits - authoritative source for compliance-specific audit findings (quality audit findings owned by quality domain)';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - regulatory filings reference specific products',
    `employee_id` BIGINT COMMENT 'Employee responsible for filing',
    `site_id` BIGINT COMMENT 'Site related to filing',
    `approval_date` DATE COMMENT 'Date approved',
    `regulatory_filing_description` STRING COMMENT 'Filing description',
    `expiry_date` DATE COMMENT 'The expiry date associated with the regulatory filing compliance record.',
    `filing_number` STRING COMMENT 'Filing reference number',
    `filing_status` STRING COMMENT 'Current status',
    `filing_type` STRING COMMENT 'Type of regulatory filing',
    `jurisdiction` STRING COMMENT 'Applicable jurisdiction',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `regulatory_body` STRING COMMENT 'Regulatory authority',
    `renewal_due_date` DATE COMMENT 'The renewal due date associated with the regulatory filing compliance record.',
    `submission_date` DATE COMMENT 'Date filed',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Regulatory filings and submissions for semiconductor products and operations';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` (
    `chips_act_obligation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee responsible',
    `site_id` BIGINT COMMENT 'Site subject to obligation',
    `clawback_risk_flag` BOOLEAN COMMENT 'Whether there is clawback risk',
    `compliance_deadline` DATE COMMENT 'The compliance deadline of the chips act obligation record in the compliance domain.',
    `funding_agreement_number` STRING COMMENT 'CHIPS Act funding agreement number',
    `funding_amount_usd` DECIMAL(18,2) COMMENT 'Funding amount in USD',
    `guardrail_provision` STRING COMMENT 'Applicable guardrail provision',
    `last_report_date` DATE COMMENT 'Date of last compliance report',
    `next_report_due_date` DATE COMMENT 'The next report due date associated with the chips act obligation compliance record.',
    `notes` STRING COMMENT 'Additional notes',
    `obligation_description` STRING COMMENT 'Description of obligation',
    `obligation_status` STRING COMMENT 'Current compliance status',
    `obligation_type` STRING COMMENT 'Type of obligation',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `reporting_frequency` STRING COMMENT 'Required reporting frequency',
    CONSTRAINT pk_chips_act_obligation PRIMARY KEY(`chips_act_obligation_id`)
) COMMENT 'Obligations under CHIPS Act funding agreements for semiconductor manufacturing incentives';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` (
    `conflict_minerals_declaration_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'Product covered',
    `employee_id` BIGINT COMMENT 'Employee who reviewed declaration',
    `supplier_id` BIGINT COMMENT 'Supplier providing declaration',
    `cmrt_version` STRING COMMENT 'Conflict Minerals Reporting Template version',
    `declaration_scope` STRING COMMENT 'Scope of declaration',
    `declaration_status` STRING COMMENT 'Current status',
    `drc_conflict_free_flag` BOOLEAN COMMENT 'Whether DRC conflict-free',
    `due_diligence_status` STRING COMMENT 'Status of due diligence',
    `gold_present_flag` BOOLEAN COMMENT 'Whether gold is present',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `reporting_year` STRING COMMENT 'Year of reporting',
    `smelter_list_provided_flag` BOOLEAN COMMENT 'Whether smelter list was provided',
    `submission_date` DATE COMMENT 'Date declaration submitted',
    `tantalum_present_flag` BOOLEAN COMMENT 'Whether tantalum is present',
    `tin_present_flag` BOOLEAN COMMENT 'Whether tin is present',
    `tungsten_present_flag` BOOLEAN COMMENT 'Whether tungsten is present',
    CONSTRAINT pk_conflict_minerals_declaration PRIMARY KEY(`conflict_minerals_declaration_id`)
) COMMENT 'Conflict minerals (3TG) declarations and due diligence records';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` (
    `trade_compliance_hold_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'Customer account',
    `export_license_id` BIGINT COMMENT 'Related export license',
    `employee_id` BIGINT COMMENT 'Employee who placed hold',
    `escalation_flag` BOOLEAN COMMENT 'Whether hold was escalated',
    `hold_reason` STRING COMMENT 'Reason for hold',
    `hold_status` STRING COMMENT 'Current status',
    `hold_type` STRING COMMENT 'Type of hold',
    `order_reference` STRING COMMENT 'Reference to held order',
    `placed_date` DATE COMMENT 'Date hold was placed',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `released_by` STRING COMMENT 'Person who released hold',
    `released_date` DATE COMMENT 'Date hold was released',
    `resolution_notes` STRING COMMENT 'Notes on resolution',
    `screening_result_reference` STRING COMMENT 'Reference to screening result',
    `shipment_reference` STRING COMMENT 'Reference to held shipment',
    CONSTRAINT pk_trade_compliance_hold PRIMARY KEY(`trade_compliance_hold_id`)
) COMMENT 'Holds placed on orders/shipments due to trade compliance concerns';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` (
    `obligation_register_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - obligations may apply to specific products',
    `employee_id` BIGINT COMMENT 'Employee owning the obligation',
    `site_id` BIGINT COMMENT 'Applicable site',
    `effective_date` DATE COMMENT 'Date obligation becomes effective',
    `jurisdiction` STRING COMMENT 'Applicable jurisdiction',
    `last_review_date` DATE COMMENT 'Date of last review',
    `next_review_date` DATE COMMENT 'Date of next review',
    `notes` STRING COMMENT 'Additional notes',
    `obligation_name` STRING COMMENT 'Name of obligation',
    `obligation_source` STRING COMMENT 'Source of obligation',
    `obligation_status` STRING COMMENT 'Current compliance status',
    `obligation_type` STRING COMMENT 'Type (regulatory, contractual, voluntary)',
    `penalty_description` STRING COMMENT 'Penalty for non-compliance',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `review_frequency` STRING COMMENT 'How often obligation is reviewed',
    `risk_rating` STRING COMMENT 'The risk rating of the obligation register record in the compliance domain.',
    CONSTRAINT pk_obligation_register PRIMARY KEY(`obligation_register_id`)
) COMMENT 'Register of all compliance obligations (regulatory, contractual, voluntary) tracked by the organization';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` (
    `technology_control_plan_id` BIGINT COMMENT 'Primary key',
    `eccn_classification_id` BIGINT COMMENT 'Related ECCN classification',
    `employee_id` BIGINT COMMENT 'Employee owning the TCP',
    `site_id` BIGINT COMMENT 'Site where TCP applies',
    `access_controls` STRING COMMENT 'Physical and logical access controls',
    `approved_by` STRING COMMENT 'Person who approved plan',
    `approved_date` DATE COMMENT 'Date plan was approved',
    `effective_date` DATE COMMENT 'Date plan becomes effective',
    `notes` STRING COMMENT 'Additional notes',
    `personnel_restrictions` STRING COMMENT 'Personnel access restrictions',
    `plan_name` STRING COMMENT 'Name of technology control plan',
    `plan_number` STRING COMMENT 'Plan reference number',
    `plan_status` STRING COMMENT 'Current status',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `review_date` DATE COMMENT 'Next review date',
    `technology_description` STRING COMMENT 'Description of controlled technology',
    `visitor_procedures` STRING COMMENT 'Visitor management procedures',
    CONSTRAINT pk_technology_control_plan PRIMARY KEY(`technology_control_plan_id`)
) COMMENT 'Technology control plans for managing access to controlled semiconductor technology';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` (
    `declaration_substance_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'Product containing substance',
    `reach_svhc_declaration_id` BIGINT COMMENT 'Parent REACH declaration',
    `substance_inventory_id` BIGINT COMMENT 'Reference to substance inventory',
    `above_threshold_flag` BOOLEAN COMMENT 'Whether concentration exceeds threshold',
    `analytical_method` STRING COMMENT 'Method used for analysis',
    `cas_number` STRING COMMENT 'CAS registry number',
    `concentration_pct` DECIMAL(18,2) COMMENT 'The concentration pct of the declaration substance record in the compliance domain.',
    `concentration_percent` DECIMAL(18,2) COMMENT 'Concentration as weight percentage',
    `concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration in parts per million',
    `concentration_unit` STRING COMMENT 'The concentration unit of the declaration substance record in the compliance domain.',
    `declaration_date` DATE COMMENT 'Date of substance declaration',
    `declaration_status` STRING COMMENT 'The declaration status of the declaration substance record in the compliance domain.',
    `ec_number` STRING COMMENT 'The ec number of the declaration substance record in the compliance domain.',
    `exemption_code` STRING COMMENT 'Applicable regulatory exemption code',
    `exemption_expiry_date` DATE COMMENT 'Date exemption expires',
    `homogeneous_material` STRING COMMENT 'The homogeneous material of the declaration substance record in the compliance domain.',
    `material_category` STRING COMMENT 'The material category of the declaration substance record in the compliance domain.',
    `material_location` STRING COMMENT 'Location of substance in product (die, package, solder)',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `regulation_reference` STRING COMMENT 'Applicable regulation reference',
    `substance_name` STRING COMMENT 'Name of substance',
    `test_report_reference` STRING COMMENT 'Reference to test report',
    `threshold_exceeded_flag` BOOLEAN COMMENT 'The threshold exceeded flag of the declaration substance record in the compliance domain.',
    `threshold_limit_ppm` DECIMAL(18,2) COMMENT 'Regulatory threshold limit in ppm',
    CONSTRAINT pk_declaration_substance PRIMARY KEY(`declaration_substance_id`)
) COMMENT 'Individual substance entries within compliance declarations linking substances to products and regulatory thresholds';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_to_export_license_id` FOREIGN KEY (`to_export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ADD CONSTRAINT `fk_compliance_declaration_substance_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ADD CONSTRAINT `fk_compliance_declaration_substance_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_semiconductors_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` SET TAGS ('dbx_subdomain' = 'trade_control');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Empowered Official');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `authorized_commodities` SET TAGS ('dbx_business_glossary_term' = 'Authorized Commodities');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `authorized_countries` SET TAGS ('dbx_business_glossary_term' = 'Authorized Countries');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `authorized_end_users` SET TAGS ('dbx_business_glossary_term' = 'Authorized End Users');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `compliance_agreement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Agreement');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'License Conditions');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_use_certificate_type` SET TAGS ('dbx_business_glossary_term' = 'End Use Certificate Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_use_description` SET TAGS ('dbx_business_glossary_term' = 'End Use Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_address` SET TAGS ('dbx_business_glossary_term' = 'End User Address');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `export_license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `registration_category` SET TAGS ('dbx_business_glossary_term' = 'Registration Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `usml_category` SET TAGS ('dbx_business_glossary_term' = 'USML Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `value_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Value Ceiling');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` SET TAGS ('dbx_subdomain' = 'trade_control');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Usage ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'ECCN Classification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `to_export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Target License');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `commodity_usml_category` SET TAGS ('dbx_business_glossary_term' = 'USML Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `cumulative_license_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percent');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `end_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `end_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_control_regulation` SET TAGS ('dbx_business_glossary_term' = 'Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_date` SET TAGS ('dbx_business_glossary_term' = 'Export Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `quantity_exported` SET TAGS ('dbx_business_glossary_term' = 'Quantity Exported');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` SET TAGS ('dbx_subdomain' = 'trade_control');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'ECCN Classification ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Classified By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classification_basis` SET TAGS ('dbx_business_glossary_term' = 'Classification Basis');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `commodity_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Commodity Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `control_reason` SET TAGS ('dbx_business_glossary_term' = 'Control Reason');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'ECCN Code');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `license_exception_available` SET TAGS ('dbx_business_glossary_term' = 'License Exception');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `license_exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `performance_parameter` SET TAGS ('dbx_business_glossary_term' = 'Performance Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `technology_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Level');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` SET TAGS ('dbx_subdomain' = 'trade_control');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Screening ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Screened By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `entity_country` SET TAGS ('dbx_business_glossary_term' = 'Entity Country');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Entity Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `list_matched` SET TAGS ('dbx_business_glossary_term' = 'List Matched');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `resolved_by` SET TAGS ('dbx_business_glossary_term' = 'Resolved By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_provider` SET TAGS ('dbx_business_glossary_term' = 'Screening Provider');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` SET TAGS ('dbx_subdomain' = 'substance_management');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'REACH Declaration ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Declared By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'IC Catalog');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `article_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Article Weight');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `candidate_list_version` SET TAGS ('dbx_business_glossary_term' = 'Candidate List Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Concentration');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `safe_use_instructions` SET TAGS ('dbx_business_glossary_term' = 'Safe Use Instructions');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `svhc_above_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Above Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `svhc_cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `svhc_substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` SET TAGS ('dbx_subdomain' = 'substance_management');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Managed By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `annual_usage_kg` SET TAGS ('dbx_business_glossary_term' = 'Annual Usage');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'EC Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `phase_out_date` SET TAGS ('dbx_business_glossary_term' = 'Phase Out Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `reach_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'REACH Registered');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `rohs_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'RoHS Restricted');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `safety_data_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'SDS Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substitute_substance` SET TAGS ('dbx_business_glossary_term' = 'Substitute');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `svhc_flag` SET TAGS ('dbx_business_glossary_term' = 'SVHC Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` SET TAGS ('dbx_subdomain' = 'regulatory_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `nonconformity_count` SET TAGS ('dbx_business_glossary_term' = 'Nonconformity Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Standard');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` SET TAGS ('dbx_subdomain' = 'regulatory_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Conclusion');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_standard` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'CA Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `finding_count` SET TAGS ('dbx_business_glossary_term' = 'Finding Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `major_nonconformity_count` SET TAGS ('dbx_business_glossary_term' = 'Major NC Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `minor_nonconformity_count` SET TAGS ('dbx_business_glossary_term' = 'Minor NC Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_subdomain' = 'regulatory_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Clause Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `effectiveness_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verified');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` SET TAGS ('dbx_subdomain' = 'regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Obligation ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `clawback_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Clawback Risk');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `funding_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `funding_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `guardrail_provision` SET TAGS ('dbx_business_glossary_term' = 'Guardrail Provision');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `last_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` SET TAGS ('dbx_subdomain' = 'substance_management');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `conflict_minerals_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'IC Catalog');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `cmrt_version` SET TAGS ('dbx_business_glossary_term' = 'CMRT Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `declaration_scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `drc_conflict_free_flag` SET TAGS ('dbx_business_glossary_term' = 'DRC Conflict Free');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `due_diligence_status` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `gold_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Gold Present');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `smelter_list_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Smelter List Provided');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `tantalum_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Tantalum Present');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `tin_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Tin Present');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `tin_present_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `tin_present_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `tungsten_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Tungsten Present');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` SET TAGS ('dbx_subdomain' = 'trade_control');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `trade_compliance_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `placed_date` SET TAGS ('dbx_business_glossary_term' = 'Placed Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `screening_result_reference` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` SET TAGS ('dbx_subdomain' = 'regulatory_assurance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` SET TAGS ('dbx_subdomain' = 'regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_source` SET TAGS ('dbx_business_glossary_term' = 'Source');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` SET TAGS ('dbx_subdomain' = 'trade_control');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'TCP ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'ECCN Classification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `access_controls` SET TAGS ('dbx_business_glossary_term' = 'Access Controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `personnel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Personnel Restrictions');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `technology_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `visitor_procedures` SET TAGS ('dbx_business_glossary_term' = 'Visitor Procedures');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_subdomain' = 'substance_management');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_association_edges' = 'compliance.reach_svhc_declaration,compliance.substance_inventory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `declaration_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Substance ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'IC Catalog');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'REACH Declaration');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `above_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Above Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Concentration Percent');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Concentration PPM');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Exemption Code');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `exemption_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Expiry');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `material_location` SET TAGS ('dbx_business_glossary_term' = 'Material Location');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `threshold_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit');
