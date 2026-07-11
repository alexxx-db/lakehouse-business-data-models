-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:17:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`compliance` COMMENT 'Regulatory compliance including export controls (EAR, ITAR), environmental regulations (RoHS, REACH, TSCA), trade compliance, CHIPS Act reporting, and industry standards adherence (SEMI, JEDEC, ISO). Manages compliance audits, certifications, product substance declarations, export license records, and regulatory filings.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` (
    `export_license_id` BIGINT COMMENT 'Unique identifier for the export license record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Export licenses are issued to specific customer accounts; required for license management reports and export compliance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Export‑license issuance requires an authorized official (employee) to sign off per export regulations.',
    `authorized_commodities` STRING COMMENT 'List of controlled items or technology categories covered by the license.',
    `authorized_countries` STRING COMMENT 'ISO 3-letter country codes where export is permitted.',
    `authorized_end_users` STRING COMMENT 'Names of approved end-user organizations or individuals.',
    `compliance_agreement` STRING COMMENT 'Reference to the signed compliance agreement document.',
    `conditions` STRING COMMENT 'Specific conditions, restrictions, or reporting requirements attached to the license.',
    `effective_from` DATE COMMENT 'Date the license becomes effective.',
    `effective_until` DATE COMMENT 'Date the license expires or ends.',
    `end_use_certificate_type` STRING COMMENT 'Type of supporting end-use documentation.. Valid values are `end_user_statement|import_certificate|delivery_verification`',
    `end_use_description` STRING COMMENT 'Description of the intended end use of the exported technology.',
    `end_user_address` STRING COMMENT 'Physical address of the end user.',
    `end_user_name` STRING COMMENT 'Name of the end user or recipient of the exported item.',
    `export_license_status` STRING COMMENT 'Current lifecycle status of the license.. Valid values are `active|suspended|revoked|expired|pending`',
    `issue_date` DATE COMMENT 'Date the license was issued.',
    `issuing_authority` STRING COMMENT 'Government agency that issued the license (e.g., BIS, DDTC).',
    `license_number` STRING COMMENT 'Official license or registration number assigned by the issuing authority.',
    `license_type` STRING COMMENT 'Category of export authorization.. Valid values are `individual|distribution|deemed_export|itar_registration|exception|taa`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the license record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the license record.',
    `registration_category` STRING COMMENT 'ITAR registration category for the entity.. Valid values are `manufacturer|exporter|broker`',
    `renewal_date` DATE COMMENT 'Deadline by which renewal must be submitted.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the license must be renewed before expiry.',
    `usml_category` STRING COMMENT 'United States Munitions List category applicable for ITAR licenses.',
    `value_ceiling` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed under the license.',
    `verification_date` DATE COMMENT 'Date when verification was completed.',
    `verification_status` STRING COMMENT 'Status of end-use verification.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_export_license PRIMARY KEY(`export_license_id`)
) COMMENT 'Master record for all export authorizations, registrations, and supporting end-use documentation under EAR (BIS) and ITAR (DDTC) governing semiconductor ICs, SoCs, ASICs, IP cores, and controlled technology. Captures authorization type (individual validated license, distribution license, deemed export license, ITAR registration, license exception, TAA), issuing authority, license/registration number, authorized scope (commodities, destinations, end-users, USML categories), validity period, value ceiling, conditions, and renewal status. For ITAR registrations: registration category (manufacturer, exporter, broker), USML categories covered, empowered official, and compliance agreements. For end-use documentation: certificate type (end-user statement, import certificate, delivery verification certificate), customer/end-user details, authorized/prohibited end-use descriptions, and verification status. SSOT for all export control authorizations, ITAR registrations, and supporting end-use certificates.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` (
    `export_license_usage_id` BIGINT COMMENT 'System-generated unique identifier for each export license usage record.',
    `account_id` BIGINT COMMENT 'Identifier of the party receiving the shipment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Usage records capture which employee created the entry for auditability.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Export license usage must reference the ECCN classification of the commodity; linking enables lookup of classification details.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Export License Usage reports track which wafer lot consumed the licensed technology, essential for audit of export-controlled semiconductor shipments.',
    `export_license_id` BIGINT COMMENT 'Internal surrogate key referencing the export license that is being drawn down.',
    `to_export_license` BIGINT COMMENT 'FK to compliance.export_license.export_license_id — Every license usage drawdown MUST reference its parent export license. Without this FK, usage records are orphaned and license balance tracking is impossible. Production-critical for BIS reporting.',
    `to_export_license_id` BIGINT COMMENT 'FK to compliance.export_license.export_license_id — Every license usage drawdown MUST reference the parent export license being consumed. This is the fundamental header-to-line relationship for license balance tracking. Without this FK, license utiliza',
    `audit_trail` STRING COMMENT 'Free‑form notes capturing audit comments, exceptions, or manual adjustments.',
    `commodity_usml_category` STRING COMMENT 'United States Munitions List category, if the commodity falls under ITAR.',
    `compliance_status` STRING COMMENT 'Result of compliance verification for this usage.. Valid values are `compliant|non_compliant|pending_review`',
    `consignee_name` STRING COMMENT 'Legal name of the consignee organization or individual.',
    `cumulative_license_utilization_percent` DECIMAL(18,2) COMMENT 'Running percentage of the total licensed quantity that has been used.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the declared value.. Valid values are `^[A-Z]{3}$`',
    `declared_value` DECIMAL(18,2) COMMENT 'Monetary value declared for customs and licensing purposes.',
    `destination_country_code` STRING COMMENT 'Three‑letter ISO country code of the shipment destination.. Valid values are `^[A-Z]{3}$`',
    `end_user_name` STRING COMMENT 'Name of the ultimate end‑user of the exported commodity.',
    `export_control_regulation` STRING COMMENT 'Regulatory regime governing the export (e.g., EAR, ITAR).. Valid values are `EAR|ITAR|EU|Other`',
    `export_date` DATE COMMENT 'Date the shipment was exported and the license drawdown occurred.',
    `export_license_type` STRING COMMENT 'Classification of the license (e.g., General, Specific, Temporary).',
    `export_license_usage_status` STRING COMMENT 'Current lifecycle status of the usage record.. Valid values are `active|closed|pending|rejected`',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether the usage record contains information subject to heightened confidentiality.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the usage record.',
    `license_balance_remaining` DECIMAL(18,2) COMMENT 'Remaining quantity or value available under the export license after this drawdown.',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric amount of the commodity shipped.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the exported quantity.. Valid values are `pieces|kg|liters|units|packs|sets`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the usage record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the usage record.',
    `shipment_reference` STRING COMMENT 'Internal reference number for the physical shipment tied to this usage.',
    `usage_number` STRING COMMENT 'Business identifier assigned to the usage event, often used in audit and reporting.',
    CONSTRAINT pk_export_license_usage PRIMARY KEY(`export_license_usage_id`)
) COMMENT 'Transactional record tracking individual shipment drawdowns against an export license. Captures the shipment reference, export license consumed, commodity ECCN/USML category, quantity shipped, declared value, destination country, consignee, end-user, export date, and cumulative license utilization. Enables real-time license balance monitoring and BIS/DDTC reporting compliance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` (
    `eccn_classification_id` BIGINT COMMENT 'Surrogate primary key for the ECCN classification master record.',
    `export_license_id` BIGINT COMMENT 'FK to compliance.export_license.export_license_id — Export licenses authorize specific ECCN-classified items. The license must reference the ECCN classification to validate commodity scope. Critical for license applicability determination.',
    `to_export_license_id` BIGINT COMMENT 'FK to compliance.export_license.export_license_id — Export licenses are issued for specific ECCN-classified items. The ECCN classification drives license requirement determination.',
    `change_history` STRING COMMENT 'Chronological log of changes made to the ECCN record.',
    `classification_rationale` STRING COMMENT 'Narrative explanation of why the specific ECCN was assigned.',
    `classification_timestamp` TIMESTAMP COMMENT 'Date and time when the ECCN classification was recorded.',
    `classification_version` STRING COMMENT 'Version identifier for the ECCN classification record (e.g., v1.0).',
    `classifying_engineer` STRING COMMENT 'Name of the engineer or specialist who performed the ECCN classification.',
    `compliance_officer` STRING COMMENT 'Name of the compliance officer responsible for oversight of the ECCN record.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the ECCN record.. Valid values are `compliant|non_compliant|under_review`',
    `controlling_parameter` STRING COMMENT 'Key parameter that drives the ECCN decision (e.g., process node, performance level).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ECCN record was first created in the system.',
    `deminimis_value_usd` DECIMAL(18,2) COMMENT 'Monetary threshold below which export licensing may be waived.',
    `documentation_url` STRING COMMENT 'Link to supporting documentation or export control analysis.. Valid values are `^https?://.+$`',
    `ear_control_codes` STRING COMMENT 'Comma‑separated list of applicable EAR control codes (e.g., AT, NS, MT, CB, RS, SS, UN, EI). [ENUM-REF-CANDIDATE: AT|NS|MT|CB|RS|SS|UN|EI — promote to reference product]',
    `eccn_classification_status` STRING COMMENT 'Current lifecycle status of the ECCN record.. Valid values are `active|inactive|pending|retired`',
    `eccn_code` STRING COMMENT 'Official ECCN code assigned to the product, IP core, technology or software (e.g., 3A001).. Valid values are `^[0-9][A-Z][0-9]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the ECCN classification expires or is superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the ECCN classification is considered effective.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license is required for the classified item.',
    `ip_core_identifier` STRING COMMENT 'Identifier for an IP core or reusable design block that may have a distinct ECCN.. Valid values are `^[A-Z0-9_]{1,30}$`',
    `is_deemed_export` BOOLEAN COMMENT 'Indicates whether the item is subject to deemed export rules.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the ECCN record.',
    `license_number` STRING COMMENT 'Identifier of the export license associated with the ECCN, if applicable.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next ECCN review.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the classification.',
    `performance_metric` STRING COMMENT 'Key performance metric used as a controlling parameter for classification.. Valid values are `GHz|GFLOPS|Mbps|None`',
    `process_node_nm` DECIMAL(18,2) COMMENT 'Technology node size in nanometers that influences classification.',
    `product_category` STRING COMMENT 'High‑level category of the product to which the ECCN applies.. Valid values are `IC|SoC|ASIC|FPGA|IP|Software`',
    `product_identifier` STRING COMMENT 'Unique part number or SKU that identifies the semiconductor product to which the ECCN applies.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory regime governing the classification.. Valid values are `EAR|ITAR|EU|CHIPS`',
    `restricted_country_list` STRING COMMENT 'Comma‑separated list of country codes where export is restricted.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory ECCN review cycles.',
    `technology_type` STRING COMMENT 'Category of the technology subject to classification.. Valid values are `hardware|software|firmware|design|process`',
    CONSTRAINT pk_eccn_classification PRIMARY KEY(`eccn_classification_id`)
) COMMENT 'Master record for Export Control Classification Number (ECCN) assignments applied to semiconductor products, IP cores, technology, and software. Captures ECCN code (e.g., 3A001, 3E001), classification rationale, controlling parameter (performance level, technology generation, process node), classification date, classifying engineer, review cycle, and applicable EAR controls (AT, NS, MT, CB, RS, SS, UN, EI). SSOT for product-level export control classification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` (
    `restricted_party_screening_id` BIGINT COMMENT 'System-generated unique identifier for each restricted party screening record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer screening against restricted party lists is performed per account; needed for compliance screening reports and risk assessments.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to sales.channel_partner. Business justification: Screening results are stored per channel partner; the FK ties each screening record to the partner it concerns.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance analyst who reviewed the screening.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Restricted party screening is performed in context of a specific export license; FK provides direct link to license details.',
    `analyst_name` STRING COMMENT 'Full name of the compliance analyst who performed the review.',
    `analyst_notes` STRING COMMENT 'Free‑form comments entered by the compliance analyst documenting rationale or observations.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) applicable to the screening (e.g., EAR, ITAR, RoHS, REACH, TSCA, CHIPS, SEMI, JEDEC). [ENUM-REF-CANDIDATE: EAR|ITAR|RoHS|REACH|TSCA|CHIPS|SEMI|JEDEC — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening record was first created in the system.',
    `disposition` STRING COMMENT 'Final decision taken after the screening: approved, blocked, or escalated for further review.. Valid values are `approved|blocked|escalated`',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether the screening outcome requires escalation to senior compliance.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening was escalated.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the screening was performed manually (True) or automatically (False).',
    `match_result` STRING COMMENT 'Outcome of the screening indicating whether the party is clear, a potential match, or a confirmed match.. Valid values are `clear|potential_match|confirmed_match`',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0‑100) representing the likelihood of a match.',
    `restricted_party_screening_status` STRING COMMENT 'Current lifecycle status of the screening process.. Valid values are `pending|completed|rejected`',
    `review_deadline` DATE COMMENT 'Date by which any required follow‑up review must be completed.',
    `risk_category` STRING COMMENT 'Overall risk classification derived from screening results.. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) reflecting the severity of the match.',
    `screened_entity_name` STRING COMMENT 'Legal name of the party (customer, supplier, distributor, or end‑user) that was screened.',
    `screened_entity_reference` BIGINT COMMENT 'Internal identifier of the screened party in the master party registry.',
    `screened_entity_type` STRING COMMENT 'Category of the screened party indicating its business role.. Valid values are `customer|supplier|distributor|end_user`',
    `screening_date` DATE COMMENT 'Date on which the screening was performed.',
    `screening_lists_checked` STRING COMMENT 'Pipe‑separated list of sanction or restricted‑party lists that were consulted (e.g., SDN|DPL|Entity List).',
    `screening_reference_number` STRING COMMENT 'Business identifier assigned to the screening event for traceability.',
    `screening_timestamp` TIMESTAMP COMMENT 'Exact timestamp (date and time) when the screening was executed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the screening record.',
    CONSTRAINT pk_restricted_party_screening PRIMARY KEY(`restricted_party_screening_id`)
) COMMENT 'Transactional record capturing the results of restricted party list screening performed against customers, distributors, end-users, and suppliers. Captures screened entity name, screening date, lists checked (SDN, DPL, Entity List, Unverified List, OFAC, EU/UK sanctions), match result (clear, potential match, confirmed match), match score, disposition (approved, blocked, escalated), and analyst review notes. Mandatory pre-shipment and onboarding compliance control.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` (
    `reach_svhc_declaration_id` BIGINT COMMENT 'Unique system-generated identifier for the environmental substance compliance declaration record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REACH/SVHC declarations must be signed by a responsible employee for regulatory proof.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the declaration record was first created in the system.',
    `audit_outcome` STRING COMMENT 'Result of the most recent compliance audit.. Valid values are `pass|fail|conditional`',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the declaration record.',
    `compliance_officer` STRING COMMENT 'Name of the compliance officer responsible for this declaration.',
    `compliance_officer_email` STRING COMMENT 'Email address of the compliance officer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `compliance_officer_phone` STRING COMMENT 'Phone number of the compliance officer.',
    `compliance_result` STRING COMMENT 'Overall compliance outcome for the product under this declaration.. Valid values are `compliant|non_compliant|partial|exempt`',
    `concentration_unit` STRING COMMENT 'Unit for the measured concentration (e.g., %w/w, ppm).',
    `created_by_user` STRING COMMENT 'System user identifier who created the record.',
    `customer_facing_format` STRING COMMENT 'Format used to deliver the declaration to customers.. Valid values are `IPC-1752A|IEC 62474|chemSHERPA|custom_pdf`',
    `declaration_date` DATE COMMENT 'Date the declaration was initially created.',
    `declaration_type` STRING COMMENT 'Category of compliance declaration (e.g., RoHS, REACH, TSCA, Prop 65, Halogen‑Free, Full Material).. Valid values are `rohs|reach|tsca|prop65|halogen_free|full_material`',
    `document_url` STRING COMMENT 'Link to the stored declaration document (e.g., PDF in the document repository).',
    `document_version` STRING COMMENT 'Version identifier of the declaration document.',
    `effective_end_date` DATE COMMENT 'Date on which the declaration expires or is superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date from which the declaration is considered valid.',
    `exemption_code` STRING COMMENT 'Code indicating any RoHS exemption applied to the product.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the declaration is treated as confidential information.',
    `is_exempt` BOOLEAN COMMENT 'True if the substance is exempt from the applicable regulation.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the substance is classified as hazardous.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for this declaration.',
    `measured_concentration` DECIMAL(18,2) COMMENT 'Actual measured concentration of the substance in the product.',
    `notes` STRING COMMENT 'Additional remarks or comments related to the declaration.',
    `product_name` STRING COMMENT 'Human‑readable name of the semiconductor product.',
    `product_sku` STRING COMMENT 'Identifier of the semiconductor product to which this declaration applies.',
    `reach_svhc_declaration_status` STRING COMMENT 'Current lifecycle state of the declaration.. Valid values are `active|expired|revoked|draft|pending`',
    `region_applicability` STRING COMMENT 'Geographic region(s) where the declaration is applicable (e.g., global, EU, US, CN, JP, KR, ROW). [ENUM-REF-CANDIDATE: global|EU|US|CN|JP|KR|ROW — promote to reference product]',
    `regulatory_framework` STRING COMMENT 'Regulation or standard governing this declaration (e.g., EU RoHS, US RoHS, China RoHS, REACH, TSCA, Prop 65, CHIPS Act, IEC 62474, IPC‑1752A). [ENUM-REF-CANDIDATE: EU RoHS|US RoHS|China RoHS|REACH|TSCA|Prop65|CHIPS Act|IEC 62474|IPC-1752A — promote to reference product]',
    `related_product_family` STRING COMMENT 'Name of the product family to which the SKU belongs.',
    `revision_number` STRING COMMENT 'Sequential revision number for the declaration.',
    `signatory_date` DATE COMMENT 'Date the signatory formally approved the declaration.',
    `signatory_email` STRING COMMENT 'Email address of the signatory for audit traceability.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_title` STRING COMMENT 'Job title or role of the signatory within the organization.',
    `substance_cas_number` STRING COMMENT 'Chemical Abstracts Service registry number identifying the substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `substance_category` STRING COMMENT 'Regulatory category to which the substance belongs.. Valid values are `rohs|reach|tsca|prop65|halogen`',
    `substance_name` STRING COMMENT 'Common name of the regulated substance.',
    `threshold_unit` STRING COMMENT 'Unit of measurement for regulatory concentration thresholds (e.g., %w/w, ppm).',
    `threshold_value` DECIMAL(18,2) COMMENT 'Maximum allowed concentration for the regulated substance.',
    `updated_by_user` STRING COMMENT 'System user identifier who last modified the record.',
    CONSTRAINT pk_reach_svhc_declaration PRIMARY KEY(`reach_svhc_declaration_id`)
) COMMENT 'Master record for all environmental substance compliance declarations covering RoHS restricted substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE, DEHP, BBP, DBP, DIBP), REACH SVHCs (candidate list substances above 0.1% w/w threshold), TSCA reportable chemicals, California Prop 65 listed substances, and halogen-free declarations for semiconductor products and packaging. Captures product SKU, declaration type (RoHS compliance statement, REACH SVHC notification, full material declaration, halogen-free declaration), regulatory framework, substance list with CAS numbers, measured concentrations vs thresholds, exemption codes (RoHS Annex III/IV), declaration date, validity period, signatory authority, and customer-facing declaration format (IPC-1752A, IEC 62474, chemSHERPA). Unified SSOT for all product-level environmental substance declarations required for global market access including EU, US, China RoHS, and customer-specific substance restrictions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` (
    `substance_inventory_id` BIGINT COMMENT 'Unique surrogate key for the substance inventory record.',
    `supplier_id` BIGINT COMMENT 'Surrogate key referencing the supplier master record.',
    `annual_usage_volume_kg` DECIMAL(18,2) COMMENT 'Total quantity of the substance used per calendar year, measured in kilograms.',
    `cas_number` STRING COMMENT 'Unique CAS registry identifier for the substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `chemical_formula` STRING COMMENT 'Molecular formula of the substance (e.g., C2H6O).',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review for the substance.',
    `compliance_status` STRING COMMENT 'Current compliance status of the substance.. Valid values are `compliant|non_compliant|under_review`',
    `controlled_substance_category` STRING COMMENT 'Regulatory category governing the substance.. Valid values are `ITAR|EAR|dual_use|none`',
    `disposal_method` STRING COMMENT 'Approved disposal method for the substance after use.. Valid values are `incineration|landfill|recycling|neutralization|special_handling`',
    `expiration_date` DATE COMMENT 'Date after which the substance should not be used.',
    `hazard_classification` STRING COMMENT 'Regulatory hazard class of the substance.. Valid values are `flammable|toxic|corrosive|reactive|environmental|non_hazardous`',
    `is_controlled_substance` BOOLEAN COMMENT 'True if the substance is subject to any export or use control regulations.',
    `is_itar_controlled` BOOLEAN COMMENT 'True if the substance is subject to ITAR export controls.',
    `is_pfas` BOOLEAN COMMENT 'True if the substance is a per‑ and poly‑fluoroalkyl substance.',
    `is_prohibited_in_eu` BOOLEAN COMMENT 'True if the substance is prohibited for use in the European Union.',
    `is_prohibited_in_us` BOOLEAN COMMENT 'True if the substance is prohibited for use in the United States.',
    `is_prop65` BOOLEAN COMMENT 'True if the substance is listed under California Proposition 65.',
    `is_reach_svhc` BOOLEAN COMMENT 'True if the substance is listed on the REACH SVHC list.',
    `is_rohs_restricted` BOOLEAN COMMENT 'True if the substance is restricted under the EU RoHS directive.',
    `is_tsca_active` BOOLEAN COMMENT 'True if the substance appears in the US TSCA Active Inventory.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inventory record.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the substance record.. Valid values are `active|inactive|retired|pending|archived`',
    `substance_inventory_name` STRING COMMENT 'Human‑readable name of the chemical substance.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the substance.',
    `physical_state` STRING COMMENT 'Physical state of the substance at standard conditions.. Valid values are `solid|liquid|gas|powder`',
    `purity_percent` DECIMAL(18,2) COMMENT 'Purity of the substance expressed as a percentage.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory record was first created.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from hazard, regulatory, and usage factors.',
    `sds_document_reference` STRING COMMENT 'Reference to the Safety Data Sheet document for the substance.',
    `storage_location` STRING COMMENT 'Designated storage area or facility for the substance.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature in degrees Celsius.',
    `substance_type` STRING COMMENT 'Category of the substance (e.g., precursor, slurry, photoresist, etchant, dopant, carrier gas, solvent, polymer). [ENUM-REF-CANDIDATE: precursor|slurry|photoresist|etchant|dopant|carrier_gas|solvent|polymer — promote to reference product]',
    CONSTRAINT pk_substance_inventory PRIMARY KEY(`substance_inventory_id`)
) COMMENT 'Master record for chemical substances and materials used in semiconductor fabrication (CVD/ALD precursors, CMP slurries, photoresists, etchants, dopants, carrier gases, solvents) and packaging materials. Captures substance name, CAS number, chemical formula, SDS reference, regulatory list memberships (REACH SVHC, TSCA Active Inventory, RoHS restricted, Prop 65, ITAR-controlled, PFAS designation), annual usage volume by FAB site, supplier, hazard classification, and disposal classification. Supports TSCA CDR reporting, REACH registration, and PFAS regulatory compliance. Distinct from substance_declaration which tracks product-level declarations to customers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`certification` (
    `certification_id` BIGINT COMMENT 'Primary key for certification',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Certification management tracks the employee responsible for maintaining the certification.',
    `audit_findings_summary` STRING COMMENT 'High-level summary of audit findings and any non-conformities.',
    `audit_frequency_months` STRING COMMENT 'Number of months between required audits.',
    `audit_report_url` STRING COMMENT 'Link to the audit report document.',
    `certificate_number` STRING COMMENT 'Unique identifier assigned by the certifying body.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|suspended|withdrawn|expired`',
    `certification_type` STRING COMMENT 'Standard or scheme of the certification (e.g., ISO 9001, IATF 16949, SEMI S2, AEC-Q100). [ENUM-REF-CANDIDATE: ISO 9001|IATF 16949|ISO 14001|ISO 45001|ISO 27001|SEMI S2|SEMI S8|AEC-Q100|AEC-Q104|AEC-Q200|IECQ|TL 9000 — promote to reference product]',
    `certifying_body` STRING COMMENT 'Organization that issued the certification (e.g., ISO, SEMI, IEC).',
    `compliance_category` STRING COMMENT 'Broad category of compliance the certification addresses.. Valid values are `export_control|environmental|quality|security|safety`',
    `compliance_risk_level` STRING COMMENT 'Risk rating associated with the certification compliance.. Valid values are `low|medium|high|critical`',
    `compliance_status_effective_date` DATE COMMENT 'Date when the current compliance status became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the digital copy of the certification document.',
    `expiration_notice_date` DATE COMMENT 'Date when the expiration notice was sent.',
    `expiration_notice_sent` BOOLEAN COMMENT 'Indicates whether a notice of upcoming expiration has been sent.',
    `expiry_date` DATE COMMENT 'Date when the certification expires.',
    `external_audit_agency` STRING COMMENT 'Third-party agency that performed the audit, if different from certifying body.',
    `internal_audit_required` BOOLEAN COMMENT 'Indicates if internal audits are mandated as part of the certification.',
    `issue_date` DATE COMMENT 'Date when the certification was issued.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the certification record.',
    `last_surveillance_audit_result` STRING COMMENT 'Outcome of the most recent surveillance audit.. Valid values are `pass|conditional|fail`',
    `next_audit_due_date` DATE COMMENT 'Planned date for the next scheduled audit or recertification.',
    `notes` STRING COMMENT 'Free-text field for any additional remarks or comments.',
    `process_area` STRING COMMENT 'Manufacturing process area covered (e.g., Front End of Line).. Valid values are `FEOL|BEOL|MOL|Assembly|Test|Packaging`',
    `product_line_code` STRING COMMENT 'Code of the product line covered by the certification.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether recertification is required before expiry.',
    `regulatory_reference` STRING COMMENT 'Reference to related regulatory requirement (e.g., ITAR, EAR, RoHS).',
    `related_regulation_codes` STRING COMMENT 'Comma-separated list of regulation codes linked to this certification (e.g., ITAR, EAR).',
    `scope_description` STRING COMMENT 'Textual description of the scope (sites, product lines, processes) covered by the certification.',
    `site_code` STRING COMMENT 'Identifier of the FAB/OSAT site where the certification applies.',
    `surveillance_audit_date` DATE COMMENT 'Date of the most recent surveillance audit required by the certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `version` STRING COMMENT 'Version or revision of the certification standard (e.g., ISO 9001:2015).',
    `created_by` STRING COMMENT 'User identifier who created the certification record.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Master record for industry standard certifications and quality management system certifications held by the organization or specific FAB/OSAT sites. Captures certification type (ISO 9001, IATF 16949, ISO 14001, ISO 45001, ISO 27001, SEMI S2, SEMI S8, AEC-Q100, AEC-Q104, AEC-Q200, IECQ, TL 9000), certifying body, scope of certification (site, product line, process), certificate number, issue date, expiry date, surveillance audit schedule, recertification requirements, and current status (active, suspended, withdrawn, expired). SSOT for all third-party certifications demonstrating compliance to customers, regulators, and industry bodies.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` (
    `audit_event_id` BIGINT COMMENT 'Unique system-generated identifier for the audit event record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit Management assigns a lead auditor employee to each audit for accountability and reporting.',
    `audit_category` STRING COMMENT 'Top‑level classification of the audit focus area.. Valid values are `process|product|system|supplier|environmental`',
    `audit_conducted_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the audit was officially started.',
    `audit_end_date` DATE COMMENT 'Calendar date when the audit activities concluded.',
    `audit_language` STRING COMMENT 'Primary language used for the audit documentation and communication.',
    `audit_notes` STRING COMMENT 'Free‑form comments or observations recorded by the auditor.',
    `audit_number` STRING COMMENT 'Human‑readable audit number assigned by the compliance team.. Valid values are `^AUD-[0-9]{6}$`',
    `audit_region` STRING COMMENT 'Three‑letter ISO country code where the audited site is located.. Valid values are `USA|CHN|KOR|JPN|DEU|TWN`',
    `audit_scope` STRING COMMENT 'Narrative description of the processes, products, or sites covered by the audit.',
    `audit_standard` STRING COMMENT 'Standard or regulatory framework against which the audit is performed.. Valid values are `iso_9001|iattf_16949|itar|ear|rba_eicc|semiconductor_semi`',
    `audit_start_date` DATE COMMENT 'Calendar date when the audit activities commenced.',
    `audit_type` STRING COMMENT 'Category of audit based on initiator or purpose.. Valid values are `internal|customer|third_party|regulatory`',
    `audit_version` STRING COMMENT 'Version identifier of the audit standard or internal procedure applied.',
    `auditing_body` STRING COMMENT 'Organization or authority conducting the audit (e.g., internal audit team, external certifier).',
    `closure_status` STRING COMMENT 'Current closure state of the audit record.. Valid values are `open|closed|in_progress`',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all corrective actions must be completed.',
    `corrective_action_plan_summary` STRING COMMENT 'High‑level description of the remediation plan agreed upon.',
    `documentation_url` STRING COMMENT 'Link to the digital folder or repository containing audit reports and evidence.',
    `findings_summary` STRING COMMENT 'Concise summary of all major and minor findings.',
    `lifecycle_status` STRING COMMENT 'Stage of the audit within its overall lifecycle.. Valid values are `planned|in_progress|completed|closed`',
    `major_findings_count` STRING COMMENT 'Number of critical non‑conformances identified.',
    `minor_findings_count` STRING COMMENT 'Number of less‑critical observations identified.',
    `overall_result` STRING COMMENT 'Final outcome of the audit after evaluation of findings.. Valid values are `pass|conditional_pass|fail`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this audit event record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this audit event record.',
    `risk_level` STRING COMMENT 'Risk classification assigned based on audit findings and impact.. Valid values are `low|medium|high|critical`',
    `site_audited` STRING COMMENT 'Name of the fab, OSAT partner, or supplier location that was audited.',
    CONSTRAINT pk_audit_event PRIMARY KEY(`audit_event_id`)
) COMMENT 'Transactional record capturing compliance audit events conducted against the organization, its FAB sites, OSAT partners, or suppliers. Captures audit type (internal, customer, third-party, regulatory), audit standard (ISO 9001, IATF 16949, ITAR, EAR, RBA/EICC), auditing body, lead auditor, audit scope, site audited, audit date range, overall result (pass, conditional pass, fail), number of major/minor findings, corrective action plan due date, and closure status.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` (
    `compliance_audit_finding_id` BIGINT COMMENT 'System‑generated unique identifier for each audit finding record.',
    `audit_event_id` BIGINT COMMENT 'FK to compliance.audit_event.audit_event_id — Every audit finding MUST reference its parent audit event. This is a mandatory header-to-line relationship — findings cannot exist without an audit context. Critical for audit closure tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Finding remediation process requires an employee owner to track responsibility and closure.',
    `primary_compliance_audit_event_id` BIGINT COMMENT 'Identifier of the audit or inspection event that generated this finding.',
    `actual_completion_date` DATE COMMENT 'Date when corrective/preventive actions were actually completed.',
    `clause_violated` STRING COMMENT 'Reference to the specific regulatory or internal clause that was violated (e.g., ISO‑9001‑8.5.1).',
    `compliance_audit_finding_status` STRING COMMENT 'Current lifecycle state of the finding.. Valid values are `open|in_progress|closed|rejected`',
    `corrective_action_plan` STRING COMMENT 'Planned actions to eliminate the root cause and correct the non‑conformance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the finding record was first created in the system.',
    `compliance_audit_finding_description` STRING COMMENT 'Detailed narrative of the non‑conformance, observation, or opportunity.',
    `effectiveness_verification_date` DATE COMMENT 'Date when the effectiveness of the CAPA was confirmed.',
    `effectiveness_verification_method` STRING COMMENT 'Method used to verify that corrective and preventive actions are effective (e.g., audit, test, metric).',
    `finding_reference` STRING COMMENT 'External reference code assigned to the finding (e.g., AFR‑2024‑001).',
    `finding_type` STRING COMMENT 'Classification of the finding: major non‑conformance, minor non‑conformance, observation, or opportunity for improvement.. Valid values are `major|minor|observation|opportunity`',
    `identified_by` STRING COMMENT 'Name of the auditor or employee who initially recorded the finding.',
    `preventive_action_plan` STRING COMMENT 'Planned actions to prevent recurrence of similar findings.',
    `regulatory_reference` STRING COMMENT 'Identifier of the regulation, standard, or directive that the finding relates to (e.g., ISO‑9001, ITAR, RoHS).',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the finding based on impact and likelihood.. Valid values are `low|medium|high|critical`',
    `root_cause_description` STRING COMMENT 'Narrative description of the identified root cause.',
    `root_cause_method` STRING COMMENT 'Methodology used to determine the root cause of the finding.. Valid values are `5-why|ishikawa|8d|fishbone`',
    `severity_score` STRING COMMENT 'Numeric rating of impact severity (1‑5, where 5 is highest).',
    `target_completion_date` DATE COMMENT 'Planned date for completion of corrective and preventive actions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the finding record.',
    CONSTRAINT pk_compliance_audit_finding PRIMARY KEY(`compliance_audit_finding_id`)
) COMMENT 'Master record for individual audit findings and their full Corrective/Preventive Action (CAPA) lifecycle raised during compliance audit events, regulatory inspections, customer complaints, or internal compliance assessments. Captures finding reference, parent audit event, finding type (major/minor nonconformance, observation, OFI), clause violated, finding description, source event type. For CAPA management: root cause analysis method (5-Why, Ishikawa, 8D), root cause determination, corrective action plan, preventive action plan, assigned owner, target/actual completion dates, effectiveness verification method and date, and closure status. Unified SSOT for the complete finding-to-root-cause-to-CAPA-to-verification-to-closure lifecycle supporting ISO 9001, IATF 16949, ISO 14001, and regulatory audit workflows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record.',
    `chips_act_obligation_id` BIGINT COMMENT 'FK to compliance.chips_act_obligation.chips_act_obligation_id — CHIPS Act compliance reports (a filing type) must reference the specific obligations being reported against. Essential for demonstrating obligation fulfillment through regulatory submissions.',
    `primary_regulatory_chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: Regulatory filing often satisfies a specific CHIPS Act obligation; linking provides traceability.',
    `related_filing_regulatory_filing_id` BIGINT COMMENT 'Identifier of a related filing (e.g., amendment).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory filing system records which employee submitted the filing for traceability.',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Regulatory filing reports must reference the test program that generated the certification data, enabling traceability for FCC/CE submissions.',
    `acknowledgment_date` DATE COMMENT 'Date the agency acknowledged receipt of the filing.',
    `action_deadline` DATE COMMENT 'Deadline to complete the required compliance action.',
    `action_status` STRING COMMENT 'Current status of the required compliance action.. Valid values are `not_started|in_progress|completed|deferred`',
    `agency` STRING COMMENT 'Regulatory agency receiving the filing (e.g., BIS, EPA, EU Commission).',
    `audit_trail_notes` STRING COMMENT 'Free-text notes for audit trail.',
    `regulatory_filing_category` STRING COMMENT 'High-level category of the filing.. Valid values are `export|environment|safety|trade|financial|product`',
    `change_description` STRING COMMENT 'Description of the regulatory change.',
    `change_effective_date` DATE COMMENT 'Date the regulatory change becomes effective.',
    `change_publication_date` DATE COMMENT 'Date the regulatory change was published.',
    `change_type` STRING COMMENT 'Type of regulatory change captured (if inbound).. Valid values are `new_requirement|amendment|repeal|guidance_update`',
    `classification_or_type` STRING COMMENT 'Classification of the filing based on regulatory domain.. Valid values are `export_control|environmental|safety|trade|financial|product`',
    `compliance_officer` STRING COMMENT 'Name of the compliance officer responsible for the filing.',
    `compliance_officer_email` STRING COMMENT 'Email of the compliance officer.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was created in the system.',
    `effective_from` DATE COMMENT 'Date when the filing becomes effective or applicable.',
    `effective_until` DATE COMMENT 'Date when the filing expires or is no longer applicable (nullable).',
    `evidence_document_url` STRING COMMENT 'Link to evidence document proving compliance action.',
    `filing_document_url` STRING COMMENT 'Link to the filed document submitted to the agency.',
    `filing_number` STRING COMMENT 'Official filing number assigned by the regulatory agency.',
    `filing_status_detail` STRING COMMENT 'Additional details about the filing status.',
    `filing_tags` STRING COMMENT 'Comma-separated tags for internal categorization.',
    `filing_type` STRING COMMENT 'Type of regulatory filing (e.g., mandatory, voluntary).. Valid values are `mandatory|voluntary|self_classification|audit_response|change_notification`',
    `filing_version` STRING COMMENT 'Version identifier for the filing document.',
    `impact_severity` STRING COMMENT 'Severity of the regulatory impact on the business.. Valid values are `low|medium|high|critical`',
    `impacted_product_line` STRING COMMENT 'Product line(s) affected by the filing.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the filing contains confidential information.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction of the filing (e.g., United States, EU).',
    `regulatory_filing_status` STRING COMMENT 'Current lifecycle status of the filing.. Valid values are `draft|submitted|acknowledged|approved|rejected|closed`',
    `required_action` STRING COMMENT 'Action required to comply with the filing (e.g., redesign, labeling).',
    `submission_date` DATE COMMENT 'Date the filing was submitted to the agency.',
    `submitter_email` STRING COMMENT 'Email address of the submitter.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `submitter_phone` STRING COMMENT 'Phone number of the submitter.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Master record for regulatory filings, submissions, voluntary disclosures, and regulatory change tracking for semiconductor compliance. Covers outbound filings (CHIPS Act reports, BIS self-classification, TSCA CDR, SEC conflict minerals, ITAR registration renewals, voluntary disclosures to BIS/DDTC) and inbound regulatory change monitoring (EAR/ITAR amendments, REACH SVHC candidate list updates, RoHS exemption renewals, AI chip export restrictions, entity list additions). For filings: filing type, jurisdiction, agency, submission date, acknowledgment, status. For regulatory changes: change type (new requirement, amendment, repeal, guidance update), publication/effective dates, impacted product lines, impact severity, required response actions, implementation deadline, and implementation evidence. SSOT for all regulatory interactions, horizon scanning, and compliance change management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` (
    `chips_act_obligation_id` BIGINT COMMENT 'System-generated unique identifier for the CHIPS Act obligation record.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - CHIPS Act obligations are incurred by specific legal entities receiving funding',
    `obligation_register_id` BIGINT COMMENT 'FK to compliance.obligation_register.obligation_register_id — CHIPS Act obligations are a specific subset of the compliance obligation register. Linking ensures CHIPS obligations appear in the unified obligation management framework.',
    `award_reference` STRING COMMENT 'External award number or code assigned by the funding agency for the CHIPS Act grant.',
    `childcare_provision` BOOLEAN COMMENT 'Indicates whether the obligation includes provision of childcare services for employees.',
    `chips_act_obligation_status` STRING COMMENT 'Current lifecycle state of the obligation.. Valid values are `active|inactive|fulfilled|breached|pending`',
    `clawback_condition` BOOLEAN COMMENT 'Indicates whether a clawback clause is triggered if obligations are not met.',
    `compliance_actual` DECIMAL(18,2) COMMENT 'Most recent measured value for the compliance metric.',
    `compliance_metric` STRING COMMENT 'Name of the metric used to measure compliance (e.g., production_units, trained_employees).',
    `compliance_status` STRING COMMENT 'Current assessment of compliance against the target.. Valid values are `on_track|off_track|met|not_met`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was first created in the system.',
    `domestic_production_commitment` BOOLEAN COMMENT 'Indicates whether the obligation includes a commitment to produce a specified volume domestically.',
    `effective_from` DATE COMMENT 'Date when the obligation becomes legally binding.',
    `effective_until` DATE COMMENT 'Date when the obligation expires or is no longer enforceable; null for open‑ended obligations.',
    `evidence_document_path` STRING COMMENT 'File system or URL location of supporting documentation proving compliance.',
    `funding_amount` DECIMAL(18,2) COMMENT 'Monetary amount awarded under the CHIPS Act grant.',
    `funding_currency` STRING COMMENT 'Currency code of the funding amount, typically USD.',
    `guardrail_restriction` BOOLEAN COMMENT 'Flag indicating a restriction on expanding capacity in China as part of the grant terms.',
    `last_reported_date` DATE COMMENT 'Date when the most recent compliance evidence was submitted.',
    `measurement_frequency` STRING COMMENT 'How often the compliance metric is measured and reported.. Valid values are `monthly|quarterly|annually`',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the target value.. Valid values are `units|employees|dollars|percent`',
    `next_due_date` DATE COMMENT 'Upcoming deadline for the next compliance reporting or measurement.',
    `obligation_description` STRING COMMENT 'Detailed textual description of the specific obligation and its business impact.',
    `obligation_type` STRING COMMENT 'Category of the CHIPS Act obligation, such as domestic production commitment or workforce training requirement.. Valid values are `domestic_production|workforce_training|childcare|guardrail|clawback`',
    `reporting_period` STRING COMMENT 'Fiscal or calendar period for which compliance is reported (e.g., FY2023 Q1).',
    `target_value` DECIMAL(18,2) COMMENT 'Quantitative target that must be achieved for the compliance metric.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    `workforce_training_requirement` BOOLEAN COMMENT 'Indicates whether the obligation requires a certain number of employees to receive training.',
    CONSTRAINT pk_chips_act_obligation PRIMARY KEY(`chips_act_obligation_id`)
) COMMENT 'Master record tracking obligations and commitments arising from US CHIPS and Science Act funding awards and incentive programs. Captures award reference, obligation type (domestic production commitment, workforce training requirement, childcare provision, guardrail restriction on China capacity expansion, clawback condition), obligation description, compliance metric, target value, measurement frequency, reporting period, current status, and evidence of compliance. Critical for CHIPS Act grant recipients.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` (
    `conflict_minerals_declaration_id` BIGINT COMMENT 'System-generated unique identifier for the conflict minerals declaration record.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Conflict minerals declaration references specific chemical substances; FK enables detailed substance lookup.',
    `amendment_number` STRING COMMENT 'Sequential number of amendments made to the original declaration.',
    `amendment_reason` STRING COMMENT 'Reason provided for amending the declaration.',
    `audit_date` DATE COMMENT 'Date when the independent audit was performed.',
    `audit_outcome` STRING COMMENT 'Result of the independent audit.. Valid values are `pass|fail|conditional|pending`',
    `cmrt_version` STRING COMMENT 'Version of the Conflict Minerals Reporting Template used for the declaration.',
    `compliance_officer` STRING COMMENT 'Name of the internal officer responsible for the declaration.',
    `compliance_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score derived from audit findings and material sourcing data.',
    `conflict_minerals_percentage` DECIMAL(18,2) COMMENT 'Percentage of the products material weight that is comprised of conflict minerals (3TG).',
    `country_of_origin` STRING COMMENT 'Primary country where the conflict minerals were sourced, expressed as a three‑letter ISO country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the declaration record was first created in the system.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the declaration data (e.g., SAP, Teamcenter).',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the declaration.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `declaration_type` STRING COMMENT 'Frequency or nature of the declaration.. Valid values are `annual|quarterly|ad_hoc|one_time`',
    `drc_conflict_free_status` STRING COMMENT 'Indicates whether the minerals are certified conflict‑free with respect to the Democratic Republic of Congo.. Valid values are `conflict_free|not_conflict_free|unknown`',
    `effective_date` DATE COMMENT 'Date when the declaration becomes effective for compliance purposes.',
    `expiration_date` DATE COMMENT 'Date when the declaration expires or is superseded, if applicable.',
    `external_report_reference` STRING COMMENT 'Identifier assigned by the external filing system (e.g., SEC accession number).',
    `independent_audit_reference` STRING COMMENT 'Reference identifier for the independent private‑sector audit that validates the declaration.',
    `internal_declaration_number` STRING COMMENT 'Business identifier assigned to the declaration for internal tracking and reference.',
    `is_conflict_free` BOOLEAN COMMENT 'Flag indicating whether the product is deemed conflict‑free based on the declaration.',
    `last_audit_year` STRING COMMENT 'Calendar year of the most recent audit covering this declaration.',
    `last_reviewed_by` STRING COMMENT 'Name of the person who performed the most recent review of the declaration.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review action.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the declaration.',
    `product_scope` STRING COMMENT 'Description of the product family or line to which the declaration applies (e.g., ICs, packaging).',
    `rcoi_methodology` STRING COMMENT 'Methodology used to conduct the Reasonable Country of Origin Inquiry.. Valid values are `survey|audit|third_party|self_assessment|other`',
    `regulatory_reporting_requirement` STRING COMMENT 'Regulatory framework under which the declaration is reported.. Valid values are `SEC|EU|CHIPS|ITAR|EAR|REACH`',
    `reporting_year` STRING COMMENT 'Fiscal year for which the conflict minerals data is reported.',
    `sec_filing_date` DATE COMMENT 'Date on which the declaration was filed with the U.S. Securities and Exchange Commission.',
    `smelter_refiner_list` STRING COMMENT 'Comma‑separated list of smelters and refiners (SOR) used in the supply chain for the declared product.',
    `source_country_of_material` STRING COMMENT 'Primary country where the raw material containing the conflict minerals was sourced.',
    `supplier_certification_status` STRING COMMENT 'Current certification status of the supplier(s) providing the minerals.. Valid values are `certified|pending|rejected|not_applicable`',
    `third_party_verification` BOOLEAN COMMENT 'Indicates whether a third‑party verification service was used.',
    `total_material_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the product or component in kilograms used for the percentage calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the declaration record.',
    `verification_document_path` STRING COMMENT 'File system or URL path to the uploaded audit or verification documents.',
    CONSTRAINT pk_conflict_minerals_declaration PRIMARY KEY(`conflict_minerals_declaration_id`)
) COMMENT 'Master record for conflict minerals (3TG: tantalum, tin, tungsten, gold) compliance declarations required under SEC Rule 13p-1 (Dodd-Frank Section 1502). Captures reporting year, product scope, smelter/refiner list (SOR), country of origin determination, RCOI (Reasonable Country of Origin Inquiry) methodology, CMRT (Conflict Minerals Reporting Template) version, DRC conflict-free status, independent private sector audit reference, and SEC filing date.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` (
    `trade_compliance_hold_id` BIGINT COMMENT 'System-generated unique identifier for the trade compliance hold record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Trade holds are placed on shipments to specific customer accounts; essential for hold tracking and export control enforcement.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Trade compliance holds are often placed due to export license constraints; FK links hold to the relevant license.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Trade‑compliance hold creation logs the employee who placed the hold for audit trail.',
    `restricted_party_screening_id` BIGINT COMMENT 'FK to compliance.restricted_party_screening.restricted_party_screening_id — Trade compliance holds triggered by restricted party matches must reference the screening record that generated the match. Essential for audit trail and hold resolution workflow.',
    `adjustment_amount_usd` DECIMAL(18,2) COMMENT 'Monetary adjustments (e.g., duties, fees) applied to the gross amount.',
    `commodity_eccn` STRING COMMENT 'ECCN assigned to the commodity under the EAR.',
    `commodity_usml_category` STRING COMMENT 'United States Munitions List category for the commodity.. Valid values are `Category I|Category II|Category III|Category IV|Category V`',
    `compliance_officer` STRING COMMENT 'Name of the compliance officer responsible for reviewing the hold.',
    `created_by_user` STRING COMMENT 'User who initially created the hold record.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `destination_country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the final destination country for the shipment.',
    `end_user_address` STRING COMMENT 'Physical address of the end user.',
    `end_user_name` STRING COMMENT 'Legal name of the ultimate end user of the commodity.',
    `escalation_history` STRING COMMENT 'Chronological log of any escalations performed on the hold.',
    `estimated_value_usd` DECIMAL(18,2) COMMENT 'Estimated monetary value of the shipment or order in US dollars.',
    `export_control_regulation` STRING COMMENT 'Regulatory framework governing the hold.. Valid values are `EAR|ITAR|EU_Dual_Use|Other`',
    `gross_amount_usd` DECIMAL(18,2) COMMENT 'Base monetary amount before any adjustments.',
    `hold_notes` STRING COMMENT 'Additional free‑form notes entered by compliance staff.',
    `hold_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was initially placed.',
    `hold_reason_code` STRING COMMENT 'Standardized code representing the specific reason for the hold.',
    `hold_reason_description` STRING COMMENT 'Free‑text description providing details of why the hold was applied.',
    `hold_reference` STRING COMMENT 'External reference number assigned to the hold for tracking across systems.',
    `hold_resolution_action` STRING COMMENT 'Action taken to resolve the hold.. Valid values are `release|block|refer_to_legal|apply_license_exception|escalate`',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold.. Valid values are `pending|reviewed|released|blocked|escalated`',
    `hold_type` STRING COMMENT 'Category of compliance hold based on export control criteria.. Valid values are `license_required|restricted_party_match|end_use_concern|country_embargo|technology_transfer|deemed_export_violation`',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether the hold contains sensitive or restricted information.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the jurisdiction applying the export control.',
    `last_modified_by_user` STRING COMMENT 'User who last modified the hold record.',
    `net_amount_usd` DECIMAL(18,2) COMMENT 'Final monetary amount after adjustments.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    `related_party_reference` BIGINT COMMENT 'Identifier of the party (customer, supplier, or other entity) associated with the hold.',
    `triggering_transaction_reference` BIGINT COMMENT 'System identifier of the transaction that caused the hold.',
    `triggering_transaction_type` STRING COMMENT 'Type of transaction that triggered the hold (e.g., order, shipment, account).',
    CONSTRAINT pk_trade_compliance_hold PRIMARY KEY(`trade_compliance_hold_id`)
) COMMENT 'Transactional record capturing trade compliance holds placed on shipments, orders, or customer accounts pending export control review. Captures hold reference, hold type (license required determination, restricted party match, end-use concern, country embargo, technology transfer review, deemed export violation), triggering transaction reference, hold placed date, hold placed by, review status, resolution action (release, block, refer to legal, apply license exception), resolution date, resolution rationale, and escalation history. Enables audit trail for export compliance decisions and supports BIS voluntary disclosure documentation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` (
    `obligation_register_id` BIGINT COMMENT 'Primary key for obligation_register',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Obligation register assigns a control‑owner employee to each regulatory obligation.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - regulatory obligations apply to specific legal entities',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: Obligation register tracks individual CHIPS Act obligations; linking provides direct reference.',
    `applicable_product_line` STRING COMMENT 'Product line or family (e.g., ASIC, SoC) that the obligation covers.',
    `applicable_site_code` STRING COMMENT 'Identifier of the fab or corporate site to which the obligation is scoped.',
    `assessment_frequency` STRING COMMENT 'How often the obligation must be assessed for compliance.. Valid values are `annual|semiannual|quarterly|monthly|weekly|ad_hoc`',
    `assessment_method` STRING COMMENT 'Methodology used for the compliance assessment.. Valid values are `self_assessment|desk_review|site_inspection|third_party_audit`',
    `assessor_name` STRING COMMENT 'Name of the person or entity that performed the assessment.',
    `audit_trail` STRING COMMENT 'Chronological log of changes and actions taken on the obligation record.',
    `compliance_category` STRING COMMENT 'High‑level category of the obligation.. Valid values are `export_control|environmental|safety|quality|financial|security`',
    `current_compliance_status` STRING COMMENT 'Result of the most recent compliance assessment.. Valid values are `compliant|partially_compliant|non_compliant|not_applicable`',
    `effective_from` DATE COMMENT 'Date the obligation becomes effective.',
    `effective_until` DATE COMMENT 'Date the obligation expires or is superseded (null if open‑ended).',
    `gap_description` STRING COMMENT 'Narrative of any compliance gaps identified during assessment.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country or region code to which the obligation applies.',
    `last_assessment_date` DATE COMMENT 'Date when the most recent compliance assessment was performed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the obligation record.. Valid values are `draft|active|suspended|retired|closed`',
    `next_review_date` DATE COMMENT 'Planned date for the next compliance assessment.',
    `obligation_code` STRING COMMENT 'Business identifier code for the regulatory or standards obligation.',
    `obligation_description` STRING COMMENT 'Full description of the regulatory, standard, or contractual requirement.',
    `obligation_title` STRING COMMENT 'Short human‑readable title summarizing the obligation.',
    `obligation_type` STRING COMMENT 'Category indicating the source of the obligation.. Valid values are `regulation|standard|customer_contract|industry_code|chips_act_award|internal_policy`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    `regulation_code` STRING COMMENT 'Official code or citation of the regulation (e.g., 15 CFR 734).',
    `regulatory_body` STRING COMMENT 'Governing authority or standards organization that issued the obligation (e.g., EAR, ITAR, RoHS, SEMI).',
    `remediation_plan` STRING COMMENT 'Planned actions to close the compliance gap.',
    `remediation_target_date` DATE COMMENT 'Target date for completing remediation activities.',
    `responsible_function` STRING COMMENT 'Business function accountable for compliance (e.g., Legal, Quality, Compliance).',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the identified gap.. Valid values are `low|medium|high|critical`',
    `scope` STRING COMMENT 'Geographic or organizational scope of the obligation.. Valid values are `global|regional|site|product|product_line|business_unit`',
    `source_document_reference` STRING COMMENT 'Reference identifier of the source regulation, standard, or contract document.',
    CONSTRAINT pk_obligation_register PRIMARY KEY(`obligation_register_id`)
) COMMENT 'Master record defining individual regulatory and standards compliance obligations applicable to the organization, specific sites, or product lines, including periodic compliance assessment history. Captures obligation source (regulation, standard, customer contract, industry code, CHIPS Act award), obligation description, applicable scope (global, regional, site-specific, product-specific), responsible function, compliance control owner, assessment frequency, current compliance status, next review date. For periodic assessments: assessment date, method (self-assessment, desk review, site inspection), assessor, compliance status (compliant, partially compliant, non-compliant), gap description, risk rating, remediation plan, and target remediation date. Serves as the unified compliance obligation register and assessment tracker underpinning the ISO 37301 compliance management framework.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` (
    `technology_control_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the Technology Control Plan.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Technology Control Plans list employees authorized to access controlled technology for security compliance.',
    `eccn_classification_id` BIGINT COMMENT 'FK to compliance.eccn_classification.eccn_classification_id — Technology Control Plans govern access to specific ECCN-classified technology. The TCP must reference the ECCN classification it protects to validate scope and applicability.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Technology Control Plans are defined per technology node to ensure export/ITAR compliance; the plan must reference the specific node used in fab.',
    `primary_technology_eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Technology control plan references an ECCN; FK avoids duplication of ECCN data.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Technology Control Plans are defined per process node; linking ensures the plan applies to the correct manufacturing node.',
    `superseded_technology_control_plan_id` BIGINT COMMENT 'Self-referencing FK on technology_control_plan (superseded_technology_control_plan_id)',
    `access_control_measures` STRING COMMENT 'Summary of physical and logical controls required to protect the technology.',
    `audit_trail` STRING COMMENT 'JSON or text log of audit events related to the plan.',
    `change_history` STRING COMMENT 'Chronological record of major changes to the plan.',
    `classification_rationale` STRING COMMENT 'Explanation of why the technology received its export classification.',
    `clean_team_protocol_description` STRING COMMENT 'Procedures governing clean‑team members who may access the controlled data.',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the plan.',
    `compliance_status` STRING COMMENT 'Overall compliance assessment of the plan.. Valid values are `compliant|non_compliant|pending_review`',
    `controlled_technology_description` STRING COMMENT 'Detailed description of the technology, process, or data that is controlled.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days the plan record must be retained for compliance.',
    `deminimis_value_usd` DECIMAL(18,2) COMMENT 'Monetary threshold below which export licensing may be waived.',
    `design_methodology` STRING COMMENT 'Design flow or methodology (e.g., RTL, gate‑level) covered by the plan.',
    `documentation_url` STRING COMMENT 'Link to the detailed plan documentation stored in the document repository.',
    `effective_date` DATE COMMENT 'Date when the Technology Control Plan becomes active.',
    `expiration_date` DATE COMMENT 'Date when the Technology Control Plan expires or is superseded.',
    `export_license_required` BOOLEAN COMMENT 'True if an export license is mandatory for the controlled technology.',
    `foreign_national_exclusions` STRING COMMENT 'List of nationalities or countries excluded from access under the plan.',
    `ip_block` STRING COMMENT 'Identifier of the IP block or core that is subject to export control under this plan.',
    `is_deemed_export` BOOLEAN COMMENT 'Indicates whether the plan involves a deemed export under U.S. regulations.',
    `it_access_restriction_description` STRING COMMENT 'Details of network, system, and file‑level restrictions applied to the technology.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan was last reviewed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the plan record.',
    `license_number` STRING COMMENT 'Identifier of the export license associated with the plan.',
    `mitigation_measures` STRING COMMENT 'Planned actions to mitigate identified compliance risks.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of the plan.',
    `physical_barrier_description` STRING COMMENT 'Description of any physical segregation (e.g., locked rooms, clean‑team areas).',
    `plan_name` STRING COMMENT 'Human‑readable name of the Technology Control Plan used for reference and reporting.',
    `plan_scope` STRING COMMENT 'Narrative description of the plans coverage (e.g., specific modules, processes, or IP blocks).',
    `plan_type` STRING COMMENT 'Category of the plan indicating the kind of controlled technology it governs.. Valid values are `technology|ip|design|process|assembly`',
    `process_node` STRING COMMENT 'Technology node or process generation (e.g., 7nm, 5nm) to which the plan applies.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory regime governing the plan.. Valid values are `EAR|ITAR|EU|CHIPS_ACT|SEMI`',
    `responsible_officer` STRING COMMENT 'Name or employee ID of the officer accountable for the plan.',
    `restricted_country_list` STRING COMMENT 'Comma‑separated list of countries to which export is prohibited.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory plan reviews.',
    `review_status` STRING COMMENT 'Current status of the most recent plan review.. Valid values are `pending|completed|overdue`',
    `risk_assessment_summary` STRING COMMENT 'High‑level summary of risks identified for the controlled technology.',
    `technology_control_plan_status` STRING COMMENT 'Current lifecycle state of the plan.. Valid values are `draft|active|suspended|revoked|closed`',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel must complete export‑control training.',
    `version_number` STRING COMMENT 'Incremental version of the plan for change tracking.',
    CONSTRAINT pk_technology_control_plan PRIMARY KEY(`technology_control_plan_id`)
) COMMENT 'Master record for Technology Control Plans (TCPs) governing access to export-controlled semiconductor technology, source code, and technical data within facilities employing foreign nationals. Captures TCP scope (process node, IP block, design methodology), controlled technology description, ECCN classification, access control measures (physical barriers, IT access restrictions, clean-team protocols), authorized personnel list, foreign national nationalities excluded, TCP effective date, review cycle, and responsible export control officer. Critical for EAR deemed export compliance in multinational semiconductor R&D and FAB environments.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` (
    `declaration_substance_id` BIGINT COMMENT 'Primary key for the declaration_substance association',
    `reach_svhc_declaration_id` BIGINT COMMENT 'Foreign key linking to the compliance declaration',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to the substance inventory record',
    `measured_concentration` DECIMAL(18,2) COMMENT 'Actual concentration of the substance measured in the product for this declaration',
    `threshold_value` DECIMAL(18,2) COMMENT 'Regulatory concentration limit for the substance applicable to this declaration',
    CONSTRAINT pk_declaration_substance PRIMARY KEY(`declaration_substance_id`)
) COMMENT 'Association product representing the link between a compliance declaration and a chemical substance. Each record captures the measured concentration of the substance in the product and the regulatory threshold value applicable to that substance.. Existence Justification: Each reach_svhc_declaration lists multiple chemical substances, and each substance can appear in many product declarations. The relationship is actively managed by compliance engineers who record measured concentration and regulatory threshold values for each substance within a declaration. This many‑to‑many association carries its own data, so it is modeled as an association entity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_to_export_license` FOREIGN KEY (`to_export_license`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_to_export_license_id` FOREIGN KEY (`to_export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ADD CONSTRAINT `fk_compliance_eccn_classification_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ADD CONSTRAINT `fk_compliance_eccn_classification_to_export_license_id` FOREIGN KEY (`to_export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ADD CONSTRAINT `fk_compliance_restricted_party_screening_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_primary_compliance_audit_event_id` FOREIGN KEY (`primary_compliance_audit_event_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_primary_regulatory_chips_act_obligation_id` FOREIGN KEY (`primary_regulatory_chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_related_filing_regulatory_filing_id` FOREIGN KEY (`related_filing_regulatory_filing_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ADD CONSTRAINT `fk_compliance_chips_act_obligation_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ADD CONSTRAINT `fk_compliance_conflict_minerals_declaration_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_restricted_party_screening_id` FOREIGN KEY (`restricted_party_screening_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening`(`restricted_party_screening_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_primary_technology_eccn_classification_id` FOREIGN KEY (`primary_technology_eccn_classification_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_superseded_technology_control_plan_id` FOREIGN KEY (`superseded_technology_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ADD CONSTRAINT `fk_compliance_declaration_substance_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ADD CONSTRAINT `fk_compliance_declaration_substance_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `vibe_semiconductors_v1`.`compliance`.`substance_inventory`(`substance_inventory_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_semiconductors_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` SET TAGS ('dbx_subdomain' = 'trade_controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Empowered Official Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `authorized_commodities` SET TAGS ('dbx_business_glossary_term' = 'Authorized Commodities (AC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `authorized_countries` SET TAGS ('dbx_business_glossary_term' = 'Authorized Countries (ACN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `authorized_end_users` SET TAGS ('dbx_business_glossary_term' = 'Authorized End Users (AEU)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `compliance_agreement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Agreement (CA)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'License Conditions (LC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_use_certificate_type` SET TAGS ('dbx_business_glossary_term' = 'End-Use Certificate Type (EUCT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_use_certificate_type` SET TAGS ('dbx_value_regex' = 'end_user_statement|import_certificate|delivery_verification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_use_description` SET TAGS ('dbx_business_glossary_term' = 'End Use Description (EUD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_address` SET TAGS ('dbx_business_glossary_term' = 'End User Address (EUA)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User Name (EUN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `end_user_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `export_license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status (LS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `export_license_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority (IA)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number (LN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type (LT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'individual|distribution|deemed_export|itar_registration|exception|taa');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `registration_category` SET TAGS ('dbx_business_glossary_term' = 'Registration Category (RC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `registration_category` SET TAGS ('dbx_value_regex' = 'manufacturer|exporter|broker');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date (RD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required (RR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `usml_category` SET TAGS ('dbx_business_glossary_term' = 'USML Category (UC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `value_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Value Ceiling (VC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `value_ceiling` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `value_ceiling` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date (VD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` SET TAGS ('dbx_subdomain' = 'trade_controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Usage ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Party ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `to_export_license` SET TAGS ('dbx_business_glossary_term' = 'To Export License');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `to_export_license_id` SET TAGS ('dbx_business_glossary_term' = 'To Export License Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `commodity_usml_category` SET TAGS ('dbx_business_glossary_term' = 'USML Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `cumulative_license_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Cumulative License Utilization (%)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End‑User Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `end_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `end_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_control_regulation` SET TAGS ('dbx_business_glossary_term' = 'Export Control Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_control_regulation` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|EU|Other');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_date` SET TAGS ('dbx_business_glossary_term' = 'Export Date (EXP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_type` SET TAGS ('dbx_business_glossary_term' = 'Export License Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status (USG_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `export_license_usage_status` SET TAGS ('dbx_value_regex' = 'active|closed|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Data Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `license_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Remaining License Balance');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Exported Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'pieces|kg|liters|units|packs|sets');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`export_license_usage` ALTER COLUMN `usage_number` SET TAGS ('dbx_business_glossary_term' = 'Usage Number (USG_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` SET TAGS ('dbx_subdomain' = 'trade_controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN) Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Export License Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `to_export_license_id` SET TAGS ('dbx_business_glossary_term' = 'To Export License Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `change_history` SET TAGS ('dbx_business_glossary_term' = 'Change History');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classification_rationale` SET TAGS ('dbx_business_glossary_term' = 'Classification Rationale');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Classification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classification_version` SET TAGS ('dbx_business_glossary_term' = 'Classification Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classifying_engineer` SET TAGS ('dbx_business_glossary_term' = 'Classifying Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classifying_engineer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `classifying_engineer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `controlling_parameter` SET TAGS ('dbx_business_glossary_term' = 'Controlling Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `deminimis_value_usd` SET TAGS ('dbx_business_glossary_term' = 'De‑Minimis Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `ear_control_codes` SET TAGS ('dbx_business_glossary_term' = 'EAR Control Codes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_classification_status` SET TAGS ('dbx_business_glossary_term' = 'ECCN Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN) Code');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `ip_core_identifier` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `ip_core_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `is_deemed_export` SET TAGS ('dbx_business_glossary_term' = 'Deemed Export Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'ECCN Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `performance_metric` SET TAGS ('dbx_value_regex' = 'GHz|GFLOPS|Mbps|None');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'IC|SoC|ASIC|FPGA|IP|Software');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `product_identifier` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (Part Number)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `product_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|EU|CHIPS');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `restricted_country_list` SET TAGS ('dbx_business_glossary_term' = 'Restricted Country List');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`eccn_classification` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = 'hardware|software|firmware|design|process');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` SET TAGS ('dbx_subdomain' = 'trade_controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Screening Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'approved|blocked|escalated');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Screening Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_business_glossary_term' = 'Match Result');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `restricted_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `restricted_party_screening_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `review_deadline` SET TAGS ('dbx_business_glossary_term' = 'Review Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screened_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_value_regex' = 'customer|supplier|distributor|end_user');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_lists_checked` SET TAGS ('dbx_business_glossary_term' = 'Screening Lists Checked');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`restricted_party_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` SET TAGS ('dbx_subdomain' = 'substance_regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach SVHC Declaration ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Email');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Phone');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Result');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `compliance_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `customer_facing_format` SET TAGS ('dbx_business_glossary_term' = 'Customer‑Facing Format');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `customer_facing_format` SET TAGS ('dbx_value_regex' = 'IPC-1752A|IEC 62474|chemSHERPA|custom_pdf');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'rohs|reach|tsca|prop65|halogen_free|full_material');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Declaration Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Exemption Code');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Exempt');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `measured_concentration` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Declaration Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `reach_svhc_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `reach_svhc_declaration_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|draft|pending');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `region_applicability` SET TAGS ('dbx_business_glossary_term' = 'Region Applicability');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `related_product_family` SET TAGS ('dbx_business_glossary_term' = 'Related Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `signatory_date` SET TAGS ('dbx_business_glossary_term' = 'Signatory Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `substance_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Substance CAS Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `substance_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `substance_category` SET TAGS ('dbx_business_glossary_term' = 'Substance Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `substance_category` SET TAGS ('dbx_value_regex' = 'rohs|reach|tsca|prop65|halogen');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `substance_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` SET TAGS ('dbx_subdomain' = 'substance_regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Identifier (SID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `annual_usage_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Annual Usage Volume (kg) (AUV_KG)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number (CAS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `chemical_formula` SET TAGS ('dbx_business_glossary_term' = 'Chemical Formula (CF)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date (COMP_REVIEW_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `controlled_substance_category` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Category (CTRL_SUB_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `controlled_substance_category` SET TAGS ('dbx_value_regex' = 'ITAR|EAR|dual_use|none');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (DM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|recycling|neutralization|special_handling');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (HC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|toxic|corrosive|reactive|environmental|non_hazardous');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag (CTRL_SUB_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Substance Flag (ITAR_CONTROLLED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_pfas` SET TAGS ('dbx_business_glossary_term' = 'PFAS Designation Flag (PFAS_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_prohibited_in_eu` SET TAGS ('dbx_business_glossary_term' = 'EU Prohibition Flag (EU_PROHIBITED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_prohibited_in_us` SET TAGS ('dbx_business_glossary_term' = 'US Prohibition Flag (US_PROHIBITED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_prop65` SET TAGS ('dbx_business_glossary_term' = 'California Proposition 65 Listing Flag (PROP65_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_reach_svhc` SET TAGS ('dbx_business_glossary_term' = 'REACH SVHC Designation (REACH_SVHC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_rohs_restricted` SET TAGS ('dbx_business_glossary_term' = 'RoHS Restricted Substance Flag (ROHS_RESTRICTED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `is_tsca_active` SET TAGS ('dbx_business_glossary_term' = 'TSCA Active Inventory Designation (TSCA_ACTIVE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending|archived');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_inventory_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name (SN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_inventory_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State (PS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|powder');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage (%) (PURITY_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `sds_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Document Identifier (SDS_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location (SL)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (STEMP_C)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`substance_inventory` ALTER COLUMN `substance_type` SET TAGS ('dbx_business_glossary_term' = 'Substance Type (ST)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` SET TAGS ('dbx_subdomain' = 'audit_obligations');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Holder Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|suspended|withdrawn|expired');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'export_control|environmental|quality|security|safety');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `compliance_status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `external_audit_agency` SET TAGS ('dbx_business_glossary_term' = 'External Audit Agency');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `internal_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `last_surveillance_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Surveillance Audit Result');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `last_surveillance_audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional|fail');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `process_area` SET TAGS ('dbx_value_regex' = 'FEOL|BEOL|MOL|Assembly|Test|Packaging');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `related_regulation_codes` SET TAGS ('dbx_business_glossary_term' = 'Related Regulation Codes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `surveillance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Certification Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` SET TAGS ('dbx_subdomain' = 'audit_obligations');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'process|product|system|supplier|environmental');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_conducted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Conducted Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_language` SET TAGS ('dbx_business_glossary_term' = 'Audit Language');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^AUD-[0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_region` SET TAGS ('dbx_business_glossary_term' = 'Audit Region (ISO Country Code)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_region` SET TAGS ('dbx_value_regex' = 'USA|CHN|KOR|JPN|DEU|TWN');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_standard` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard (ISO/ITAR/EAR/etc.)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_standard` SET TAGS ('dbx_value_regex' = 'iso_9001|iattf_16949|itar|ear|rba_eicc|semiconductor_semi');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|customer|third_party|regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_plan_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Summary');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Documentation URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `site_audited` SET TAGS ('dbx_business_glossary_term' = 'Site Audited');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `site_audited` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`audit_event` ALTER COLUMN `site_audited` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_subdomain' = 'audit_obligations');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `primary_compliance_audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Identifier (AEID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `clause_violated` SET TAGS ('dbx_business_glossary_term' = 'Violated Clause Identifier (VCI)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status (FS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description (FD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Date (EVD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method (EVM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Reference Code (AFR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type (FT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'major|minor|observation|opportunity');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By (IB)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `identified_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `identified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan (PAP)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (RR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description (RCD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Method (RCAM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_value_regex' = '5-why|ishikawa|8d|fishbone');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date (TCD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'audit_obligations');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `primary_regulatory_chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `related_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Filing ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Action Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Category');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_category` SET TAGS ('dbx_value_regex' = 'export|environment|safety|trade|financial|product');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Change Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `change_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Change Publication Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new_requirement|amendment|repeal|guidance_update');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Classification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'export_control|environmental|safety|trade|financial|product');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Email');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_document_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status_detail` SET TAGS ('dbx_business_glossary_term' = 'Filing Status Detail');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_tags` SET TAGS ('dbx_business_glossary_term' = 'Filing Tags');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|self_classification|audit_response|change_notification');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_version` SET TAGS ('dbx_business_glossary_term' = 'Filing Version');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `impacted_product_line` SET TAGS ('dbx_business_glossary_term' = 'Impacted Product Line');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|approved|rejected|closed');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `required_action` SET TAGS ('dbx_business_glossary_term' = 'Required Action');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_email` SET TAGS ('dbx_business_glossary_term' = 'Submitter Email');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_phone` SET TAGS ('dbx_business_glossary_term' = 'Submitter Phone');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submitter_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` SET TAGS ('dbx_subdomain' = 'audit_obligations');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Obligation ID');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `award_reference` SET TAGS ('dbx_business_glossary_term' = 'Award Reference (AWARD_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `childcare_provision` SET TAGS ('dbx_business_glossary_term' = 'Childcare Provision (CHILDCARE_PROV)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `chips_act_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `chips_act_obligation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|fulfilled|breached|pending');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `clawback_condition` SET TAGS ('dbx_business_glossary_term' = 'Clawback Condition (CLAWBACK_COND)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `compliance_actual` SET TAGS ('dbx_business_glossary_term' = 'Compliance Actual Value (COMPLIANCE_ACT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `compliance_metric` SET TAGS ('dbx_business_glossary_term' = 'Compliance Metric (COMPLIANCE_METRIC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'on_track|off_track|met|not_met');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `domestic_production_commitment` SET TAGS ('dbx_business_glossary_term' = 'Domestic Production Commitment (DOM_PROD_COMMIT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `evidence_document_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Path (EVIDENCE_PATH)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount (FUNDING_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency (FUNDING_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `guardrail_restriction` SET TAGS ('dbx_business_glossary_term' = 'Guardrail Restriction (GUARDRAIL_RESTR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `last_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Date (LAST_REPORTED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency (MEAS_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MEAS_UNIT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'units|employees|dollars|percent');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date (NEXT_DUE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description (OBLIGATION_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBLIGATION_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'domestic_production|workforce_training|childcare|guardrail|clawback');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period (REPORT_PERIOD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value (TARGET_VAL)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`chips_act_obligation` ALTER COLUMN `workforce_training_requirement` SET TAGS ('dbx_business_glossary_term' = 'Workforce Training Requirement (TRAINING_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` SET TAGS ('dbx_subdomain' = 'substance_regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `conflict_minerals_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Declaration ID (CM Decl ID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number (Amendment No.)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason (Amend Reason)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date (Audit Date)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome (Outcome)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `cmrt_version` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Reporting Template Version (CMRT Version)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer (Officer)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `compliance_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Score (Risk Score)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `conflict_minerals_percentage` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Percentage (CM %)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (Source System)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status (Status)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type (Type)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|ad_hoc|one_time');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `drc_conflict_free_status` SET TAGS ('dbx_business_glossary_term' = 'DRC Conflict‑Free Status (DRC Status)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `drc_conflict_free_status` SET TAGS ('dbx_value_regex' = 'conflict_free|not_conflict_free|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Effective Date)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (Expiration Date)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `external_report_reference` SET TAGS ('dbx_business_glossary_term' = 'External Report Identifier (External ID)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `independent_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Independent Audit Reference (Audit Ref)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `internal_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Declaration Number (IDN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `is_conflict_free` SET TAGS ('dbx_business_glossary_term' = 'Is Conflict Free (Conflict Free Flag)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `last_audit_year` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Year (Audit Year)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By (Reviewer)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (Reviewed At)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Notes)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope (Scope)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `rcoi_methodology` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Country of Origin Inquiry Methodology (RCOI Methodology)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `rcoi_methodology` SET TAGS ('dbx_value_regex' = 'survey|audit|third_party|self_assessment|other');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement (Reg Req)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_value_regex' = 'SEC|EU|CHIPS|ITAR|EAR|REACH');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year (Year)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `sec_filing_date` SET TAGS ('dbx_business_glossary_term' = 'SEC Filing Date (SEC Date)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `smelter_refiner_list` SET TAGS ('dbx_business_glossary_term' = 'Smelter/Refiner List (SOR List)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `source_country_of_material` SET TAGS ('dbx_business_glossary_term' = 'Source Country of Material (Source Country)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `supplier_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certification Status (Supplier Cert Status)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `supplier_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|rejected|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `third_party_verification` SET TAGS ('dbx_business_glossary_term' = 'Third Party Verification (Third Party Flag)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `total_material_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Material Weight (kg) (Weight KG)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated At)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration` ALTER COLUMN `verification_document_path` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Path (Doc Path)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` SET TAGS ('dbx_subdomain' = 'trade_controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `trade_compliance_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Hold Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `adjustment_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `commodity_eccn` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `commodity_usml_category` SET TAGS ('dbx_business_glossary_term' = 'USML Category (USML)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `commodity_usml_category` SET TAGS ('dbx_value_regex' = 'Category I|Category II|Category III|Category IV|Category V');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer (CO)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CBU)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `created_by_user` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `created_by_user` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code (DCC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `end_user_address` SET TAGS ('dbx_business_glossary_term' = 'End User Address (EUA)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `end_user_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `end_user_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User Name (EUN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `end_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `end_user_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `escalation_history` SET TAGS ('dbx_business_glossary_term' = 'Escalation History (EH)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `estimated_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `export_control_regulation` SET TAGS ('dbx_business_glossary_term' = 'Export Control Regulation (ECR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `export_control_regulation` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|EU_Dual_Use|Other');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `gross_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes (HN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp (HPT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code (HRC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description (HRD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Hold Reference Number (HRN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Action (HRA)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_resolution_action` SET TAGS ('dbx_value_regex' = 'release|block|refer_to_legal|apply_license_exception|escalate');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status (HS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|released|blocked|escalated');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type (HT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'license_required|restricted_party_match|end_use_concern|country_embargo|technology_transfer|deemed_export_violation');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Data Flag (SDF)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code (JCC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User (LMBU)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `net_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `related_party_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Party Identifier (RPI)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `triggering_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Triggering Transaction Identifier (TTI)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold` ALTER COLUMN `triggering_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Transaction Type (TTT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` SET TAGS ('dbx_subdomain' = 'audit_obligations');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `applicable_product_line` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Line (PROD_LINE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `applicable_site_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Site Code (SITE_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency (ASSMT_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly|monthly|weekly|ad_hoc');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method (ASSMT_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'self_assessment|desk_review|site_inspection|third_party_audit');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name (ASSESSOR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (AUDIT_TRAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (COMPL_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'export_control|environmental|safety|quality|financial|security');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `current_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Current Compliance Status (COMPL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `current_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `gap_description` SET TAGS ('dbx_business_glossary_term' = 'Gap Description (GAP_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JUR)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date (LAST_ASSESS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|closed');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (OBL_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description (OBL_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title (OBL_TITLE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'regulation|standard|customer_contract|industry_code|chips_act_award|internal_policy');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation Code (REG_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan (REMED_PLAN)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `remediation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Target Date (REMED_TARGET)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `responsible_function` SET TAGS ('dbx_business_glossary_term' = 'Responsible Function (RESP_FUNC)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Obligation Scope (OBL_SCOPE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'global|regional|site|product|product_line|business_unit');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`obligation_register` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference (SRC_DOC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` SET TAGS ('dbx_subdomain' = 'trade_controls');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Personnel Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `primary_technology_eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `superseded_technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Technology Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `superseded_technology_control_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `access_control_measures` SET TAGS ('dbx_business_glossary_term' = 'Access Control Measures');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `change_history` SET TAGS ('dbx_business_glossary_term' = 'Change History');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `classification_rationale` SET TAGS ('dbx_business_glossary_term' = 'Classification Rationale');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `clean_team_protocol_description` SET TAGS ('dbx_business_glossary_term' = 'Clean‑Team Protocol Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `controlled_technology_description` SET TAGS ('dbx_business_glossary_term' = 'Controlled Technology Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `deminimis_value_usd` SET TAGS ('dbx_business_glossary_term' = 'De‑Minimis Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `design_methodology` SET TAGS ('dbx_business_glossary_term' = 'Design Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `foreign_national_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Foreign National Exclusions');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `ip_block` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Block Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `is_deemed_export` SET TAGS ('dbx_business_glossary_term' = 'Is Deemed Export');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `it_access_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'IT Access Restriction Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `physical_barrier_description` SET TAGS ('dbx_business_glossary_term' = 'Physical Barrier Description');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_scope` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Scope');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Type (TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'technology|ip|design|process|assembly');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (NM)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|EU|CHIPS_ACT|SEMI');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `responsible_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Export Control Officer (ECO)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `restricted_country_list` SET TAGS ('dbx_business_glossary_term' = 'Restricted Country List');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `technology_control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `technology_control_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|revoked|closed');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`technology_control_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_subdomain' = 'substance_regulatory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` SET TAGS ('dbx_association_edges' = 'compliance.reach_svhc_declaration,compliance.substance_inventory');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `declaration_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Substance - Declaration Substance Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Substance - Reach Svhc Declaration Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Substance - Substance Inventory Id');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `measured_concentration` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration');
ALTER TABLE `vibe_semiconductors_v1`.`compliance`.`declaration_substance` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold');
