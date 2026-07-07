-- Schema for Domain: customer | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`customer` COMMENT 'Customer identity and account management domain serving as the SSOT for all B2B industrial customers, OEM accounts, distributors, and end-user organizations. Manages customer profiles, contacts, account hierarchies, segmentation, credit terms, relationship history, and SLA agreements via Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique surrogate identifier for the customer account record in the Databricks Silver Layer. Primary key for the customer_account master data product. Serves as the SSOT reference key for all downstream domains including sales, service, order, and billing.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal‑entity invoicing and tax reporting assign each customer to a company code for statutory compliance.',
    `parent_account_customer_account_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent customer_account record in the corporate hierarchy. Enables multi-level account hierarchy modeling (e.g., subsidiary → division → global parent). Null for top-level accounts.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Needed to assign a default payment term to each customer account, used in billing cycle setup and compliance with payment‑term policies.',
    `price_book_id` BIGINT COMMENT 'Identifier of the SAP S/4HANA pricing condition group or price list assigned to this customer. Determines applicable pricing, discounts, and surcharges during sales order creation.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal sales or account manager responsible for managing the customer relationship. References the Salesforce CRM User or Workday HCM employee record. Used for territory management and performance reporting.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Primary sales rep on an account drives quota allocation, forecasting, and territory performance metrics in industrial manufacturing.',
    `primary_ultimate_parent_account_customer_account_id` BIGINT COMMENT 'Identifier of the topmost entity in the corporate hierarchy for this customer account. Supports global account consolidation, enterprise-level revenue reporting, and strategic account management.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis per customer uses profit_center_id on the account to attribute revenue and margin to the correct profit center.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Direct FK to sales territory replaces the denormalized code, supporting territory‑based reporting and incentive calculations.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Linking account to its segment enables normalization of segment data and removes redundant string field.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Procurement planning and supplier performance dashboards require each account to designate a primary supplier.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Required for linking each customer account to its billing account for invoice generation and financial reporting, a core process in manufacturing finance.',
    `account_name` STRING COMMENT '',
    `account_source` STRING COMMENT 'Channel or method through which this customer account was originally acquired. Used for marketing attribution, channel effectiveness analysis, and sales pipeline reporting. [ENUM-REF-CANDIDATE: direct_sales|referral|trade_show|inbound_marketing|partner|acquisition|existing_relationship — 7 candidates stripped; promote to reference product]',
    `account_status` STRING COMMENT 'Current lifecycle state of the customer account. Controls whether transactions, orders, and service requests can be processed against this account. Managed in Salesforce CRM and synchronized to SAP S/4HANA.. Valid values are `active|inactive|prospect|suspended|terminated|on_hold`',
    `account_type` STRING COMMENT 'Classification of the customers commercial role in the industrial supply chain. Drives pricing tiers, contract templates, and service entitlements. [ENUM-REF-CANDIDATE: OEM|distributor|system_integrator|end_user|EPC_contractor|reseller|value_added_reseller|direct — promote to reference product if additional types are needed]. Valid values are `OEM|distributor|system_integrator|end_user|EPC_contractor|reseller`',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Customer organizations most recently reported annual revenue in the accounts local currency. Used for customer segmentation, credit risk assessment, and strategic account classification. Currency indicated by revenue_currency_code.',
    `billing_city` STRING COMMENT 'City of the customers primary billing address. Used for geographic segmentation, logistics planning, and tax jurisdiction determination.',
    `billing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the customers primary billing address country. Used for tax jurisdiction determination, regulatory compliance, and geographic segmentation.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the customers primary billing address. Used for tax jurisdiction mapping, logistics routing, and geographic analytics.',
    `billing_state_province` STRING COMMENT 'State or province of the customers primary billing address. Used for tax jurisdiction determination, sales territory assignment, and regional reporting.',
    `close_date` DATE COMMENT 'Date on which the customer account was formally closed or terminated. Null for active accounts. Used for churn analysis, lifecycle reporting, and regulatory record retention.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer account record was first created in the source system of record (Salesforce CRM). Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance permitted for this customer account, denominated in the accounts billing currency. Enforced in SAP S/4HANA SD order processing and credit management workflows.',
    `credit_limit_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the credit_limit field. Ensures correct interpretation of the credit limit in multi-currency environments.',
    `credit_rating` DECIMAL(18,2) COMMENT 'Credit rating assigned to the customer by an internal credit team or external agency (e.g., Dun & Bradstreet, Moodys). Used to determine credit limits, payment terms, and order approval workflows in SAP S/4HANA FI.',
    `crm_account_code` STRING COMMENT 'Native Account record ID from Salesforce CRM (Account object). Used to cross-reference the master record back to the operational source system for reconciliation and lineage tracing.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the completeness and accuracy of the customer account record as assessed by Informatica MDM data quality rules. Used to prioritize data stewardship activities and MDM enrichment workflows.',
    `distribution_channel_code` STRING COMMENT 'SAP S/4HANA distribution channel code indicating how products are sold to this customer (e.g., direct sales, wholesale, OEM channel). Part of the SAP SD organizational assignment.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number uniquely identifying the customers legal entity globally. Used for credit risk assessment, supplier/customer verification, and corporate hierarchy resolution.. Valid values are `^[0-9]{9}$`',
    `employee_count` STRING COMMENT 'Total number of employees at the customer organization as reported or estimated. Used for customer segmentation (SMB vs. enterprise), credit risk scoring, and market sizing analytics.',
    `incoterms_code` STRING COMMENT 'ICC Incoterms code defining the agreed delivery and risk transfer conditions for shipments to this customer. Used in SAP S/4HANA SD sales order processing and logistics planning. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `industry_naics_code` STRING COMMENT 'Six-digit NAICS code identifying the customers primary industry sector per North American classification standards. Complements SIC code for more granular industry segmentation and analytics.. Valid values are `^[0-9]{6}$`',
    `industry_sic_code` STRING COMMENT 'Four-digit Standard Industrial Classification code identifying the customers primary industry sector. Used for market segmentation, regulatory reporting, and credit risk assessment.. Valid values are `^[0-9]{4}$`',
    `is_global_account` BOOLEAN COMMENT 'Indicates whether this customer operates across multiple countries and is managed under a global account management program with consolidated commercial terms and cross-regional coordination.',
    `is_strategic_account` BOOLEAN COMMENT 'Indicates whether this customer is designated as a strategic account requiring executive-level relationship management and customized service agreements. Strategic accounts receive dedicated account teams and priority support.',
    `last_activity_date` DATE COMMENT 'Date of the most recent commercial activity (order, service request, or interaction) recorded against this customer account. Used for account health monitoring, dormancy detection, and re-engagement campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the customer account record in the source system of record. Used for change data capture (CDC), incremental ETL processing, and audit compliance.',
    `legal_name` STRING COMMENT 'Full registered legal name of the B2B customer organization as recorded in official corporate filings. Used for invoicing, contracts, and regulatory compliance. Must match the name on file with the relevant tax authority.',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Indicates whether this record has been designated as the MDM golden (master) record for the customer entity after deduplication and survivorship processing in Informatica MDM. False indicates a candidate or survivor record pending promotion.',
    `open_date` DATE COMMENT 'Date on which the customer account was formally opened and activated in the system of record. Marks the start of the commercial relationship. Used for customer tenure calculations and cohort analysis.',
    `phone` STRING COMMENT 'Primary business telephone number for the customer organization. Used for account management communications and service escalation. Stored in E.164-compatible format.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `preferred_language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region suffix) indicating the customers preferred language for communications, documents, and correspondence (e.g., en-US, de-DE, fr-FR).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `revenue_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the annual_revenue field (e.g., USD, EUR, GBP). Required to correctly interpret the revenue figure for multi-currency global accounts.',
    `sales_organization_code` STRING COMMENT 'SAP S/4HANA sales organization code responsible for selling to this customer. Determines the legal entity, currency, and pricing procedures applicable to sales transactions.',
    `sap_business_partner_code` STRING COMMENT 'Business Partner number assigned in SAP S/4HANA (SD/FI modules). Enables cross-system reconciliation between Salesforce CRM and SAP ERP for order-to-cash and accounts receivable processes.',
    `sla_tier` STRING COMMENT 'SLA tier assigned to this customer account, defining the service response times, support priority, and escalation paths applicable to service requests and after-sales support. Managed in Salesforce Service Cloud.. Valid values are `platinum|gold|silver|bronze|standard`',
    `status_date` DATE COMMENT 'Date on which the current account_status became effective. Supports lifecycle history tracking and audit compliance. Used to calculate duration in current status for account health reporting.',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the customers legal entity (e.g., EIN in the US, CRN in the UK). Required for invoicing, tax reporting, and regulatory compliance under IFRS/GAAP.',
    `trading_name` STRING COMMENT 'Commercial or brand name under which the customer operates if different from the legal entity name. Used in sales communications, account management, and CRM displays.',
    `vat_registration_number` DECIMAL(18,2) COMMENT 'VAT registration number for the customer entity, required for EU and international tax compliance. Used in invoice generation and cross-border transaction reporting.',
    `website` STRING COMMENT 'Official website URL of the customer organization. Used for account research, digital engagement tracking, and customer profile enrichment.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Master record for all B2B industrial customers, OEM accounts, distributors, and end-user organizations. Serves as the SSOT for customer identity in Salesforce CRM (Account object) and SAP Business Partner. Captures legal entity name, industry classification (SIC/NAICS), account type (OEM, distributor, system integrator, end-user, EPC contractor), account status with full lifecycle history, annual revenue, employee count, DUNS number, tax ID, VAT registration, credit rating, assigned account manager, parent account reference, and strategic account flag. Foundation entity referenced by all other products in this domain and cross-referenced by sales, service, order, and billing domains. Corporate hierarchy and commercial relationships are managed in account_relationship.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` (
    `customer_contact_id` BIGINT COMMENT 'Unique surrogate identifier for the contact record in the Databricks Silver Layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `customer_account_id` BIGINT COMMENT 'Reference to the parent B2B customer account (OEM, distributor, or end-user organization) to which this contact belongs. Establishes the person-to-account relationship.',
    `employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager who owns this contact record in Salesforce CRM. Drives assignment routing, quota crediting, and relationship accountability.',
    `reports_to_contact_id` BIGINT COMMENT 'Self-referencing identifier pointing to the contacts organizational superior within the same account. Enables modeling of the customer-side org chart for multi-stakeholder enterprise sales and service engagement strategies.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Assigning a sales rep to each contact enables contact‑level sales follow‑up and pipeline reporting, a standard practice in manufacturing account management.',
    `account_site` STRING COMMENT 'Specific plant, facility, or site within the parent account organization where this contact is based. Critical for industrial manufacturing customers with multiple production sites, enabling site-level service and sales targeting.',
    `assistant_name` STRING COMMENT 'Name of the contacts executive assistant or administrative coordinator. Used to facilitate scheduling, correspondence routing, and executive-level engagement for senior stakeholders at key accounts.',
    `assistant_phone` STRING COMMENT 'Phone number of the contacts executive assistant. Enables sales and service teams to reach senior contacts through their administrative support channel.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `birthdate` DATE COMMENT 'Date of birth of the contact. Captured selectively for key account contacts where relationship management programs require it. Subject to strict GDPR data minimization principles — only collected when there is a documented lawful basis.',
    `consent_record_code` STRING COMMENT 'Reference identifier linking to the formal consent record in the consent management system. Provides an auditable trail of the lawful basis under which this contacts personal data is processed, as required by GDPR Article 7.',
    `contact_type` STRING COMMENT 'Classification of the contacts decision-making role in the B2B buying and service process. Drives sales engagement strategy and marketing segmentation. [ENUM-REF-CANDIDATE: technical_evaluator|commercial_buyer|executive_approver|end_user|influencer|other — promote to reference product]. Valid values are `technical_evaluator|commercial_buyer|executive_approver|end_user|influencer|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was first created in the source system (Salesforce CRM). Serves as the RECORD_AUDIT_CREATED anchor for data lineage, GDPR data retention calculations, and contact age analytics.',
    `crm_contact_code` STRING COMMENT 'External identifier for this contact record as assigned by Salesforce CRM. Used for cross-system reconciliation and delta-load processing from the operational source of record.',
    `customer_contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Governs whether the contact is eligible for outreach, service engagement, and data processing activities. do_not_contact enforces opt-out and regulatory suppression requirements.. Valid values are `active|inactive|do_not_contact|pending_verification|deceased`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the completeness and accuracy of this contact record as assessed by Informatica MDM data quality rules. Drives data stewardship prioritization and master data governance workflows.',
    `department` STRING COMMENT 'Organizational department or functional unit to which the contact belongs at their employer (e.g., Engineering, Procurement, Manufacturing, Maintenance, Finance, Executive). Supports segmentation for targeted outreach.',
    `do_not_call` BOOLEAN COMMENT 'Indicates whether the contact has requested to be excluded from telephone outreach. True = phone contact suppressed. Enforced in compliance with national do-not-call registries and GDPR consent requirements.',
    `email` STRING COMMENT 'Primary business email address of the contact. Used as the principal digital communication channel for sales outreach, service notifications, and marketing campaigns. Governed under GDPR and applicable privacy regulations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_out` BOOLEAN COMMENT 'Indicates whether the contact has explicitly opted out of email communications. True = email suppressed; False = email permitted. Distinct from marketing_opt_in as it applies specifically to all email types including transactional. Enforced by Salesforce CRM email suppression lists.',
    `fax` STRING COMMENT 'Fax number associated with the contact or their office location. Retained for legacy B2B industrial communication workflows and regulatory document exchange in certain jurisdictions.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `first_name` STRING COMMENT 'Given name of the individual contact as recorded in Salesforce CRM. Used for personalized communication across sales, service, and marketing channels.',
    `gdpr_data_subject_code` STRING COMMENT 'Unique identifier assigned to this contact as a GDPR data subject. Used to process data subject rights requests (access, erasure, portability) and maintain the record of processing activities (ROPA) as required under GDPR Article 30.',
    `is_decision_maker` BOOLEAN COMMENT 'Indicates whether this contact holds formal decision-making authority for purchasing or contracting at their organization. True = authorized decision maker. Used to prioritize sales engagement and opportunity progression in the CRM pipeline.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is designated as the primary point of contact for their account. True = primary contact for account-level communications and escalations. Only one contact per account should hold this designation.',
    `job_title` STRING COMMENT 'Official job title of the contact at their organization (e.g., Plant Manager, Procurement Manager, Design Engineer, Maintenance Supervisor, VP of Operations). Critical for routing sales and service engagements to the appropriate stakeholder.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the contacts preferred language for communications and documentation (e.g., en, de, zh, fr, ja). Drives localization of marketing materials, service documents, and product manuals.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_activity_date` DATE COMMENT 'Date of the most recent logged activity (call, email, meeting, task) associated with this contact in Salesforce CRM. Used to identify dormant contacts, trigger re-engagement workflows, and measure sales cadence effectiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this contact record in the source system (Salesforce CRM). Used for incremental data extraction, change data capture (CDC), and audit trail maintenance in the Silver Layer.',
    `last_name` STRING COMMENT 'Family name or surname of the individual contact. Combined with first_name to form the full display name used in correspondence and CRM records.',
    `lead_source` STRING COMMENT 'Channel or origin through which this contact was first acquired or identified. Used for marketing attribution, ROI analysis of demand generation programs, and sales pipeline reporting. [ENUM-REF-CANDIDATE: trade_show|web_inquiry|referral|partner|direct_sales|marketing_campaign|distributor|other — promote to reference product]',
    `linkedin_url` STRING COMMENT 'URL of the contacts LinkedIn professional profile. Used by sales and marketing teams for social selling, account-based marketing (ABM), and contact enrichment workflows.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `mailing_city` STRING COMMENT 'City component of the contacts mailing address. Used in geographic segmentation, territory assignment, and regional sales reporting.',
    `mailing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the contacts mailing address (e.g., USA, DEU, CHN). Drives multi-national compliance, language preference defaults, and export control screening.. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'Postal or ZIP code component of the contacts mailing address. Used for geographic routing, logistics planning, and regional analytics.',
    `mailing_state` STRING COMMENT 'State or province component of the contacts mailing address. Supports territory management, tax jurisdiction determination, and regional compliance reporting.',
    `mailing_street` STRING COMMENT 'Street address line for the contacts mailing address. Used for physical correspondence, contract delivery, and regulatory document dispatch.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the contact has provided explicit consent to receive marketing communications. True = opted in; False = opted out or consent not obtained. Mandatory for GDPR and CAN-SPAM compliance. Must be False by default until affirmative consent is recorded.',
    `marketing_opt_in_date` DATE COMMENT 'Date on which the contact provided or last renewed their marketing consent. Required for GDPR audit trail demonstrating lawful basis for marketing data processing.',
    `mdm_golden_record_code` STRING COMMENT 'Identifier of the golden (master) record in Informatica MDM to which this contact has been matched and merged. Enables cross-system deduplication and single-view-of-contact analytics across Salesforce CRM, SAP S/4HANA, and other operational systems.',
    `mobile_phone` STRING COMMENT 'Mobile or cellular phone number for the contact. Used for SMS notifications, urgent service alerts, and field engineer coordination. Distinct from the primary business phone line.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `persona` STRING COMMENT 'Functional persona label describing the contacts primary business role in the industrial context (e.g., Design Engineer, Procurement Manager, Plant Manager, Maintenance Supervisor, Executive Sponsor, Quality Engineer). Used for targeted content delivery and sales play alignment.',
    `phone` STRING COMMENT 'Primary business phone number for the contact including country code where applicable. Used for direct voice communication by field sales, inside sales, and customer service teams.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `preferred_communication_channel` STRING COMMENT 'The contacts stated preferred channel for receiving communications from the company. Drives outreach strategy for sales, service, and marketing teams to maximize engagement effectiveness.. Valid values are `email|phone|mobile|in_person|video_call|portal`',
    `salutation` STRING COMMENT 'Formal honorific or title prefix used when addressing the contact in written and verbal communication (e.g., Mr., Dr., Prof.).. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `sla_tier` STRING COMMENT 'Service Level Agreement tier associated with this contacts account, determining response time commitments and support priority for after-sales service requests. Aligned with the SLA agreements managed in Salesforce Service Cloud.. Valid values are `platinum|gold|silver|bronze|standard`',
    `technical_contact_flag` BOOLEAN COMMENT 'Indicates whether this contact serves as a technical point of contact for product support, engineering queries, or MES/PLC/SCADA integration activities. True = designated technical contact. Drives routing of technical service cases and engineering change notifications (ECN).',
    CONSTRAINT pk_customer_contact PRIMARY KEY(`customer_contact_id`)
) COMMENT 'Individual person records associated with customer accounts representing key stakeholders at B2B industrial organizations — including design engineers, procurement managers, plant managers, maintenance supervisors, and executive sponsors. Maps to Salesforce CRM Contact object. Captures full name, job title, department, phone, email, preferred communication channel, language preference, marketing consent status, decision-making role (technical evaluator, commercial buyer, executive approver), and active/inactive status. Serves as the SSOT for person-level engagement across sales, service, and marketing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each parent-child account hierarchy relationship record in the Salesforce CRM account hierarchy model. Serves as the primary key for this Silver Layer data product.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the child account in the corporate hierarchy relationship. References the subsidiary, division, affiliate, or joint venture that reports up to the parent account.',
    `primary_customer_account_id` BIGINT COMMENT 'Identifier of the parent account in the corporate hierarchy relationship. References the account that owns or controls the child account (e.g., global OEM headquarters, holding company, or divisional parent).',
    `account_tier` STRING COMMENT 'Commercial tier classification of the child account within the hierarchy, reflecting strategic importance and revenue contribution. Strategic = top-tier global OEM or enterprise accounts; key = significant regional accounts; standard = regular commercial accounts; transactional = low-volume or spot-buy accounts. Drives SLA, pricing, and service prioritization.. Valid values are `strategic|key|standard|transactional`',
    `approval_status` STRING COMMENT 'Governance approval status of the hierarchy relationship record. Approved = validated and active for use in reporting; pending_approval = submitted for review; rejected = not approved for use; under_review = currently being evaluated by data governance or account management team.. Valid values are `approved|pending_approval|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user or data steward who approved this hierarchy relationship record. Supports data governance audit trails and accountability for master data changes.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the hierarchy relationship record was formally approved by the data steward or account management team. Supports governance audit trails and SLA compliance for master data management processes.',
    `consolidation_required` BOOLEAN COMMENT 'Indicates whether the child accounts financials must be consolidated into the parent accounts financial statements for regulatory and management reporting purposes. Drives SAP S/4HANA FI/CO consolidation processes.',
    `controlling_interest` BOOLEAN COMMENT 'Indicates whether the parent account holds a controlling interest (majority ownership or effective control) over the child account. True = controlling interest exists; False = non-controlling or minority interest. Drives financial consolidation rules per IFRS 10.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy relationship record was first created in the system. Provides the audit trail entry point for the record lifecycle. Sourced from Salesforce CRM CreatedDate or Informatica MDM record creation timestamp.',
    `credit_rollup_eligible` DECIMAL(18,2) COMMENT 'Indicates whether the child accounts credit exposure should be aggregated to the parent account for enterprise-wide credit limit management. True = include in parent credit roll-up; False = manage credit independently. Critical for global OEM credit risk management in SAP S/4HANA FI.',
    `crm_hierarchy_code` STRING COMMENT 'The native Salesforce CRM Account Hierarchy record identifier (18-character Salesforce ID) for this relationship. Enables direct traceability back to the source system of record for reconciliation and audit purposes.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Informatica MDM-calculated data quality score for this hierarchy relationship record, expressed as a percentage (0.00–100.00). Reflects completeness, accuracy, and consistency of the hierarchy data. Used by data stewards to prioritize remediation efforts and monitor MDM data quality KPIs.',
    `effective_from` DATE COMMENT 'The date on which the parent-child hierarchy relationship became legally or commercially effective. Used for temporal reporting, historical roll-up analysis, and compliance with IFRS 10 consolidation timelines.',
    `effective_until` DATE COMMENT 'The date on which the parent-child hierarchy relationship ceases to be effective. Null indicates an open-ended, currently active relationship. Populated upon divestiture, restructuring, or dissolution events.',
    `erp_customer_hierarchy_code` STRING COMMENT 'The SAP S/4HANA SD customer hierarchy node code corresponding to this parent-child relationship. Used for cross-system reconciliation between Salesforce CRM and SAP S/4HANA pricing, rebate, and revenue reporting hierarchies.',
    `geographic_scope` STRING COMMENT 'Indicates the geographic coverage scope of the hierarchy relationship. Global = worldwide enterprise; regional = multi-country region (e.g., EMEA, APAC); national = single country; local = sub-national (city, state, or plant level). Used for territory management and global OEM account segmentation.. Valid values are `global|regional|national|local`',
    `hierarchy_category` STRING COMMENT 'Classifies the purpose or basis of the hierarchy relationship. Legal = based on legal ownership structure; commercial = based on commercial/contractual relationship; operational = based on operational reporting lines; reporting = created for management reporting consolidation purposes only.. Valid values are `legal|commercial|operational|reporting`',
    `hierarchy_code` STRING COMMENT 'Externally-known business identifier for the hierarchy relationship record, used for cross-system referencing and reporting. Sourced from Salesforce CRM and aligned with SAP S/4HANA customer master hierarchy codes.. Valid values are `^AH-[A-Z0-9]{6,20}$`',
    `hierarchy_depth` STRING COMMENT 'Total number of levels in the hierarchy subtree rooted at the parent account in this relationship. Indicates the structural complexity of the account group. Distinct from hierarchy_level (which is the childs absolute position); hierarchy_depth measures the span below the parent.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child account within the corporate hierarchy tree, where level 1 represents the ultimate parent (global enterprise root). Used for roll-up reporting, consolidation logic, and OEM account management. For example, a global HQ is level 1, a regional division is level 2, a local subsidiary is level 3.',
    `hierarchy_name` STRING COMMENT 'Human-readable descriptive name for the parent-child hierarchy relationship (e.g., Siemens AG → Siemens Digital Industries GmbH). Used in reports, dashboards, and account management interfaces for quick identification.',
    `hierarchy_path` STRING COMMENT 'Full materialized path string representing the ancestry chain from the root account to the child account, using a delimiter-separated format (e.g., GlobalHQ/RegionEMEA/CountryDE/SubsidiaryXYZ). Enables efficient tree traversal queries and hierarchy visualization in analytics platforms.',
    `hierarchy_status` STRING COMMENT 'Current lifecycle state of the parent-child hierarchy relationship. Active indicates the relationship is in force; pending indicates awaiting approval or validation; terminated indicates the relationship has ended (e.g., divestiture, dissolution); suspended indicates temporarily inactive.. Valid values are `active|inactive|pending|terminated|suspended`',
    `industry_segment` STRING COMMENT 'The primary industry vertical or market segment of the child account within this hierarchy (e.g., Automotive OEM, Aerospace & Defense, Food & Beverage, Pharmaceuticals, Energy & Utilities). Used for market segmentation, strategic account planning, and industry-specific SLA assignment. [ENUM-REF-CANDIDATE: automotive|aerospace_defense|food_beverage|pharma|energy_utilities|electronics|heavy_industry|transportation — promote to reference product]',
    `last_reviewed_date` DATE COMMENT 'Date on which the hierarchy relationship was last reviewed and validated by the account management team or data steward. Supports periodic hierarchy governance reviews and ensures accuracy of the corporate structure for global OEM account management.',
    `mdm_hierarchy_code` STRING COMMENT 'The Informatica MDM golden record hierarchy identifier for this relationship, representing the authoritative cross-system master data reference. Ensures data quality and deduplication across Salesforce CRM and SAP S/4HANA hierarchy representations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy relationship record was last modified. Tracks the most recent update to any attribute of the record, supporting change detection, incremental data loading, and audit compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and validation of this hierarchy relationship by the account management team or data steward. Ensures timely governance of corporate structure changes and compliance with master data management policies.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, business rationale, or special instructions related to the hierarchy relationship. Examples include notes on pending restructuring, legal disputes, or special commercial arrangements that affect the hierarchy structure.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of equity ownership the parent account holds in the child account. Critical for IFRS 10 consolidation thresholds (>50% = subsidiary, 20-50% = associate/affiliate), financial roll-up reporting, and OEM account governance. Expressed as a decimal percentage (e.g., 75.00 = 75%).',
    `pricing_rollup_eligible` BOOLEAN COMMENT 'Indicates whether the child accounts purchase volumes should be aggregated to the parent account for volume-based pricing, rebate calculation, and global framework agreement pricing in SAP S/4HANA SD. True = volumes consolidated at parent level; False = priced independently.',
    `primary_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary country of the child account within this hierarchy relationship. Used for geographic roll-up reporting, trade compliance, and export control screening.. Valid values are `^[A-Z]{3}$`',
    `relationship_type` STRING COMMENT 'Classifies the nature of the corporate relationship between parent and child accounts. Drives legal, financial, and commercial treatment: subsidiary (majority-owned legal entity), division (internal business unit), affiliate (minority-owned or associated entity), joint_venture (co-owned entity), distributor (channel partner), franchise (licensed operator). [ENUM-REF-CANDIDATE: subsidiary|division|affiliate|joint_venture|distributor|franchise — promote to reference product if additional types are needed]. Valid values are `subsidiary|division|affiliate|joint_venture|distributor|franchise`',
    `revenue_rollup_eligible` DECIMAL(18,2) COMMENT 'Indicates whether the child accounts revenue should be rolled up and attributed to the parent account for enterprise-level revenue reporting and global OEM account performance tracking. True = include in parent roll-up; False = exclude (e.g., for minority affiliates or reporting-only hierarchy nodes).',
    `sla_inherited` BOOLEAN COMMENT 'Indicates whether the child account inherits the Service Level Agreement (SLA) terms from the parent account in this hierarchy relationship. True = child account uses parent SLA; False = child account has its own independently negotiated SLA. Drives Salesforce Service Cloud case routing and escalation logic.',
    `termination_reason` STRING COMMENT 'Business reason for the termination or deactivation of the hierarchy relationship. Captures the event that caused the relationship to end: divestiture (sale of subsidiary), merger (entities combined), acquisition (absorbed by another entity), restructuring (internal reorganization), dissolution (entity closed), reclassification (moved to different hierarchy), data_correction (error correction). [ENUM-REF-CANDIDATE: divestiture|merger|acquisition|restructuring|dissolution|reclassification|data_correction — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines parent-child corporate hierarchy relationships between customer accounts, enabling roll-up reporting across subsidiaries, divisions, and global enterprise accounts. Captures parent account, child account, hierarchy level, relationship type (subsidiary, division, affiliate, joint venture), effective date, and hierarchy depth. Critical for global OEM and enterprise account management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate identifier for the customer segment record in the Databricks Silver Layer. Serves as the primary key for all downstream joins and references.',
    `approval_date` DATE COMMENT 'Date on which the segment definition was formally approved by the designated commercial authority. Used for governance audit trails and to establish the authoritative effective date of the segment.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the commercial leadership authority (e.g., VP Sales, Regional Sales Director) who formally approved this segment definition and its commercial parameters. Sourced from Salesforce CRM approval workflow records.',
    `assigned_segment_manager` STRING COMMENT 'Full name or employee identifier of the commercial manager responsible for owning the segment strategy, reviewing segment performance, and approving account assignments. Sourced from Salesforce CRM user records and Workday HCM.',
    `channel_type` STRING COMMENT 'Indicates the go-to-market channel model applicable to this segment: Direct (manufacturer sells directly to end customer), Indirect (sales through distributors or channel partners), or Hybrid (combination of direct and indirect). Drives commercial policy and commission structures.. Valid values are `Direct|Indirect|Hybrid`',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the segment across systems (e.g., STRAT-001, KEY-002). Used as the business key in Salesforce CRM and SAP S/4HANA SD module for cross-system reconciliation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `contract_required` BOOLEAN COMMENT 'Indicates whether a formal master supply agreement or framework contract is mandatory for customer accounts in this segment before order processing can commence. Enforced in SAP S/4HANA SD order entry validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data lineage and governance tracking in the Databricks Silver Layer.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'Standard credit limit in USD applied to customer accounts assigned to this segment. Used as the default credit exposure ceiling in SAP S/4HANA FI-AR credit management for new account onboarding within the segment.',
    `criteria` STRING COMMENT 'Structured definition of the qualifying rules and thresholds used to assign a customer account to this segment (e.g., annual revenue > $10M, OEM classification, multi-site deployment). Supports automated segmentation logic in Salesforce CRM and Informatica MDM.',
    `crm_segment_record_code` STRING COMMENT 'Native Salesforce CRM record identifier for the corresponding segment or account group object in Salesforce Sales Cloud. Used for bi-directional synchronization between the Databricks Silver Layer and the CRM system of record.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `customer_account_type` STRING COMMENT 'Classification of the customer relationship type that this segment targets. OEM (Original Equipment Manufacturer) accounts receive differentiated pricing and co-development support; Distributors receive channel margin structures; End Users receive direct service SLAs; System Integrators and EPCs (Engineering, Procurement & Construction) receive project-based commercial terms.. Valid values are `OEM|Distributor|End User|System Integrator|EPC`',
    `dedicated_account_manager_required` BOOLEAN COMMENT 'Indicates whether customer accounts in this segment require a dedicated named account manager assignment in Salesforce CRM. Strategic and Key Account segments typically require dedicated coverage; Transactional segments may use pooled inside sales resources.',
    `segment_description` STRING COMMENT 'Detailed narrative description of the segments commercial purpose, qualifying criteria, and strategic intent. Used by sales managers and account teams to understand segment boundaries and apply correct commercial policies.',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to list prices for customers in this segment, expressed as a percentage (e.g., 12.50 = 12.5%). Confidential as it reflects commercial pricing strategy. Used in SAP S/4HANA SD pricing condition records.',
    `effective_from_date` DATE COMMENT 'Date from which this segment definition became commercially active and applicable to account assignments. Supports temporal validity tracking for segment versioning and historical analysis of commercial strategy changes.',
    `effective_until_date` DATE COMMENT 'Date on which this segment definition ceases to be commercially active. Null indicates the segment is open-ended with no planned expiry. Used for segment versioning, sunset planning, and historical reporting.',
    `erp_customer_group_code` STRING COMMENT 'SAP S/4HANA SD customer group code (Kundengruppe) mapped to this segment. Used to apply segment-specific pricing conditions, output determination, and reporting groupings in the ERP system of record.. Valid values are `^[A-Z0-9]{2,10}$`',
    `geographic_region` STRING COMMENT 'Primary geographic sales region associated with this segment definition (e.g., North America, EMEA, APAC, LATAM). Used to align segment management responsibilities with regional sales organizations and territory planning in Salesforce CRM. [ENUM-REF-CANDIDATE: North America|EMEA|APAC|LATAM|Greater China|South Asia|Middle East & Africa — promote to reference product]',
    `industry_vertical` STRING COMMENT 'The primary industry vertical classification of customers within this segment (e.g., Automotive OEM, Aerospace & Defense, Food & Beverage, Energy & Utilities, Building Automation, Transportation). Aligns with NAICS/SIC industry classification and Salesforce CRM account industry field. [ENUM-REF-CANDIDATE: Automotive OEM|Aerospace & Defense|Food & Beverage|Energy & Utilities|Building Automation|Transportation|Semiconductor|Pharmaceuticals|Oil & Gas|General Manufacturing — promote to reference product]',
    `last_review_date` DATE COMMENT 'Date on which the most recent formal review of this segments criteria, account assignments, and commercial performance was completed. Used to trigger the next review cycle and track governance compliance.',
    `max_account_count` STRING COMMENT 'Maximum number of customer accounts permitted in this segment before a split or restructuring review is triggered. Ensures segment managers maintain adequate coverage quality. Null indicates no upper cap.',
    `mdm_segment_code` STRING COMMENT 'Informatica MDM golden record identifier for this segment definition. Ensures cross-system consistency of segment master data across Salesforce CRM, SAP S/4HANA, and Microsoft Dynamics 365 Supply Chain Management.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `min_account_count` STRING COMMENT 'Minimum number of customer accounts that should be assigned to this segment to maintain commercial viability and justify dedicated segment management resources. Used in segment health monitoring and portfolio planning.',
    `moq_applicable` BOOLEAN COMMENT 'Indicates whether a Minimum Order Quantity (MOQ) policy applies to customer accounts in this segment. When True, the MOQ defined in SAP S/4HANA SD condition records is enforced during order entry for accounts in this segment.',
    `segment_name` STRING COMMENT 'Human-readable name of the customer segment (e.g., Strategic, Key Account, Growth, Transactional). Used in sales strategy, pricing tier assignment, and service prioritization workflows.',
    `nda_required` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) is required for customer accounts in this segment before sharing product roadmaps, engineering specifications, or pricing strategies. Relevant for Strategic and OEM segments involved in co-development programs.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this segment definition. Calculated from last_review_date plus review_cycle_months. Used by the segment manager and commercial governance team to plan review activities.',
    `owner_email` STRING COMMENT 'Business email address of the assigned segment manager. Used for automated notifications, review cycle reminders, and escalation routing in Salesforce CRM workflows. Classified confidential as it is an internal business contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `payment_terms_code` DECIMAL(18,2) COMMENT 'SAP S/4HANA payment terms code (e.g., NT30, NT60, 2/10NT30) assigned as the default for customer accounts in this segment. Defines invoice due dates, early payment discount eligibility, and cash flow planning inputs.',
    `pricing_tier_code` STRING COMMENT 'Code referencing the applicable pricing tier in SAP S/4HANA SD condition records for customers assigned to this segment. Drives list price, discount matrix, and rebate eligibility. Confidential as it encodes commercial pricing strategy.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `rebate_eligible` BOOLEAN COMMENT 'Indicates whether customer accounts in this segment are eligible for volume-based rebate programs. When True, rebate agreements are activated in SAP S/4HANA SD rebate processing for qualifying accounts.',
    `revenue_band_currency` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code in which the revenue band thresholds (revenue_band_min and revenue_band_max) are denominated (e.g., USD, EUR, GBP). Ensures consistent multi-currency interpretation across global sales regions.',
    `revenue_band_max` DECIMAL(18,2) COMMENT 'Maximum annual revenue threshold (in USD) that defines the upper boundary of the revenue band for this segment. Null indicates an open-ended upper bound (e.g., for the Strategic tier). Used in pricing tier assignment and SLA prioritization.',
    `revenue_band_min` DECIMAL(18,2) COMMENT 'Minimum annual revenue threshold (in USD) that a customer account must meet to qualify for this segment. Used in conjunction with revenue_band_max to define the revenue band boundary for segmentation scoring.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the segment definition, criteria, and account assignments are formally reviewed and validated by the segment manager and commercial leadership (e.g., 3 = quarterly, 6 = semi-annual, 12 = annual).',
    `segment_status` STRING COMMENT 'Current lifecycle state of the segment definition. Active segments are applied in commercial operations; Under Review segments are being reassessed during periodic review cycles; Archived segments are retired and no longer assigned to new accounts.. Valid values are `Active|Inactive|Under Review|Archived`',
    `segment_type` STRING COMMENT 'Classification of the segment into one of the four standard commercial tiers used by the industrial manufacturing sales organization: Strategic (top-tier OEM/enterprise accounts), Key Account (high-value recurring customers), Growth (emerging or expanding accounts), Transactional (low-frequency, price-driven buyers).. Valid values are `Strategic|Key Account|Growth|Transactional`',
    `service_priority_level` STRING COMMENT 'Service prioritization level for after-sales support and field service dispatch for customers in this segment. Critical and High priority segments receive preferential scheduling in Salesforce Service Cloud and Maximo work order queues.. Valid values are `Critical|High|Standard|Basic`',
    `sla_tier_code` STRING COMMENT 'Code identifying the SLA tier assigned to customers in this segment, referencing the SLA agreement product. Determines response time commitments, field service priority, spare parts availability guarantees, and escalation paths in Salesforce Service Cloud and Maximo Asset Management.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `strategic_account_flag` BOOLEAN COMMENT 'Indicates whether this segment is classified as a strategic segment requiring executive sponsorship, board-level visibility, and dedicated cross-functional account teams. Drives escalation routing and executive review cadence in Salesforce CRM.',
    `target_gross_margin_pct` DECIMAL(18,2) COMMENT 'Target gross margin percentage for the segment, used in pricing strategy and commercial deal approval thresholds. Deals below this margin threshold require escalated approval for accounts in this segment. Confidential as it encodes commercial profitability strategy.',
    `target_revenue_usd` DECIMAL(18,2) COMMENT 'Annual revenue target in USD for the aggregate of all customer accounts assigned to this segment. Used in commercial planning, sales quota allocation, and KPI tracking against actual segment revenue performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this segment record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, incremental data pipeline processing, and audit trail maintenance in the Databricks Silver Layer.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number tracking revisions to the segment definition, criteria, or commercial parameters. Supports audit trail and change history for governance and compliance reviews.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Market segmentation classification for customer accounts used in sales strategy, pricing tiers, and service prioritization. Captures segment name (Strategic, Key Account, Growth, Transactional), segment criteria, revenue band, industry vertical, geographic region, assigned segment manager, and review cycle. Enables targeted commercial strategies for OEMs, distributors, and end-users.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each address record in the customer domain. Serves as the primary key for the address data product in the Databricks Silver Layer.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns this address record. Links the address to the parent B2B industrial customer, OEM account, distributor, or end-user organization in the customer master.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the individual contact person associated with this address, when the address belongs to a specific contact rather than the account-level organization. Nullable for account-level addresses.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are in current use; inactive addresses are no longer used but retained for historical reference; pending addresses are awaiting validation or approval; archived addresses are soft-deleted for audit trail purposes.. Valid values are `active|inactive|pending|archived`',
    `address_type` STRING COMMENT 'Functional classification of the address indicating its business purpose. Billing addresses are used for invoicing (SAP SD), shipping/delivery addresses for logistics dispatch (SAP WM/TMS), headquarters for corporate correspondence, plant_site for manufacturing facility locations, mailing for postal communications, and field_service for on-site service dispatch. [ENUM-REF-CANDIDATE: billing|shipping|headquarters|plant_site|mailing|field_service|registered|returns — promote to reference product if additional types are needed]. Valid values are `billing|shipping|headquarters|plant_site|mailing|field_service`',
    `attention_line` STRING COMMENT 'Addressee attention line specifying the department, role, or individual to whom correspondence or deliveries should be directed at this address (e.g., Attn: Procurement Department, Attn: Receiving Dock). Common in B2B industrial shipping.',
    `building_name` STRING COMMENT 'Name of the building or facility at this address (e.g., Tower A, Building 7 - Final Assembly, North Warehouse). Common in large industrial campuses and multi-building manufacturing complexes. Supplements street address for precise delivery and field service dispatch.',
    `city` STRING COMMENT 'City, municipality, or locality name of the address. Used for logistics routing, tax jurisdiction determination, and field service territory assignment.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 Alpha-3 country code for the address (e.g., USA, DEU, CHN, GBR). Used for international logistics, customs documentation, export compliance, and regulatory jurisdiction determination.. Valid values are `^[A-Z]{3}$`',
    `county_district` STRING COMMENT 'County, district, or sub-regional administrative unit of the address. Used for local tax jurisdiction determination, permit compliance, and field service territory mapping in industrial manufacturing contexts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the source system. Supports audit trail requirements, data lineage tracking, and compliance with ISO 9001 quality management record-keeping requirements.',
    `delivery_instructions` STRING COMMENT 'Free-text special instructions for deliveries to this address, such as dock access hours, security clearance requirements, forklift availability, hazardous material handling notes, or contact person for receiving. Critical for industrial manufacturing shipments to plant sites.',
    `effective_from` DATE COMMENT 'Date from which this address record is valid and in effect for business operations. Supports bi-temporal address management for customers who relocate or open new facilities, ensuring correct address is used for historical invoicing and logistics.',
    `effective_until` DATE COMMENT 'Date until which this address record is valid. Null indicates the address is open-ended and currently active. Used for managing address changes over time, particularly for plant site relocations and facility closures.',
    `floor_number` STRING COMMENT 'Floor or level number within a building at this address. Used for precise field service dispatch and delivery routing within multi-story industrial facilities, office buildings, and distribution centers.',
    `geocoding_accuracy` STRING COMMENT 'Precision level of the geocoordinates assigned to this address. Rooftop indicates exact building-level precision; range_interpolated is street-level; geometric_center is centroid of a region; approximate is low-precision; ungeocoded means no coordinates assigned. Informs reliability of geospatial analytics.. Valid values are `rooftop|range_interpolated|geometric_center|approximate|ungeocoded`',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether this address/facility is certified to receive hazardous materials shipments. Relevant for industrial manufacturing customers receiving chemicals, electrification components, or other regulated materials. Supports EPA and OSHA compliance.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this is the primary address for the associated customer account or contact. Only one address per customer per address_type should be marked as primary. Used to determine the default address for invoicing, shipping, and correspondence.',
    `is_validated` BOOLEAN COMMENT 'Indicates whether the address has been validated against a postal authority or address verification service (e.g., USPS CASS, Informatica MDM address cleansing). Validated addresses reduce delivery failures and logistics errors.',
    `label` STRING COMMENT 'Human-readable descriptive label or nickname for the address record (e.g., Stuttgart HQ, Chicago Distribution Center, Plant 3 - Assembly Line). Facilitates quick identification in Salesforce CRM and SAP S/4HANA user interfaces.',
    `language_code` STRING COMMENT 'ISO 639-1 language code for the preferred communication language at this address (e.g., en, de, zh-CN, fr). Used to determine document language for invoices, shipping labels, and field service work orders dispatched to this location.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last updated in the source system. Used for change data capture (CDC), incremental data loading, and audit trail compliance in the Databricks Silver Layer.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the address in decimal degrees (WGS 84 datum). Precision to 7 decimal places (~1 cm accuracy). Used for field service dispatch routing, logistics optimization, and geospatial analytics in industrial manufacturing.',
    `line_1` STRING COMMENT 'Primary street address line including building number, street name, and any directional qualifiers. This is the first and mandatory line of the physical or mailing address as captured in Salesforce CRM and SAP S/4HANA customer master.',
    `line_2` STRING COMMENT 'Secondary address line for suite, floor, unit, building name, mail stop, or additional location qualifier. Optional field used when the primary address line is insufficient to fully identify the location.',
    `line_3` STRING COMMENT 'Tertiary address line for additional location details such as industrial park name, campus identifier, or zone designation. Used primarily for complex plant site and industrial facility addresses common in manufacturing environments.',
    `loading_dock_available` BOOLEAN COMMENT 'Indicates whether a loading dock is available at this address for receiving industrial equipment, automation systems, and bulk material shipments. Affects carrier selection (LTL vs FTL) and delivery scheduling in the Transportation Management System (TMS).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the address in decimal degrees (WGS 84 datum). Precision to 7 decimal places (~1 cm accuracy). Used alongside latitude for geospatial analytics, field service routing, and logistics network optimization.',
    `mdm_address_key` STRING COMMENT 'Unique address identifier assigned by Informatica MDM during master data consolidation and deduplication. Enables cross-system address matching and golden record linkage across SAP S/4HANA, Salesforce CRM, and other operational systems.',
    `plant_code` STRING COMMENT 'SAP S/4HANA plant code associated with this address when the address represents a customers manufacturing plant or production facility. Enables direct linkage between customer delivery addresses and SAP plant master data for production planning (MRP/MRP II) and goods receipt processing. Denormalized natural key; SSOT is asset.plant.plant_code.',
    `po_box` STRING COMMENT 'Post Office (PO) Box number for mailing addresses where physical street delivery is not applicable. Used for billing correspondence and formal legal notices to corporate customers. Stored separately from street address lines.',
    `po_box_postal_code` STRING COMMENT 'Postal code specific to the PO Box address, which may differ from the street address postal code. Required for accurate mail routing when a PO Box is used for billing or correspondence.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address. Format varies by country (e.g., 5-digit US ZIP, alphanumeric UK postcode). Used for mail delivery, logistics carrier routing (LTL/FTL), and geographic segmentation.',
    `postal_code_extension` STRING COMMENT 'Extended postal code suffix providing finer delivery point precision (e.g., ZIP+4 in the US). Improves mail delivery accuracy and carrier routing for industrial shipments.',
    `room_number` STRING COMMENT 'Room, suite, or unit number within a building at this address. Provides the most granular level of location detail for field service technician dispatch and internal mail routing at customer facilities.',
    `sales_region_code` STRING COMMENT 'Sales region or territory code associated with this address, used for sales force assignment, revenue reporting, and quota management. Derived from geographic location and aligned with SAP S/4HANA SD sales organization structure. Denormalized natural key; SSOT is sales.territory.territory_code.',
    `service_territory_code` STRING COMMENT 'Field service territory code assigned to this address, used to route field service engineers and technicians for equipment maintenance, installation, and after-sales support. Aligns with Salesforce Service Cloud territory management and Maximo Asset Management work order dispatch. Denormalized natural key; SSOT is service.zone.zone_code.',
    `shipping_condition` STRING COMMENT 'Default shipping condition or delivery method applicable to this address, indicating the preferred logistics mode. LTL (Less Than Truckload) and FTL (Full Truckload) are standard industrial shipping terms. Drives carrier selection and Transportation Management System (TMS) routing.. Valid values are `standard|express|freight|ltl|ftl|will_call`',
    `source_system_address_code` STRING COMMENT 'The native address identifier from the originating source system (e.g., Salesforce CRM Address ID, SAP ADRC ADDRNUMBER). Enables reverse lookup and reconciliation between the Databricks Silver Layer and operational systems during ETL and data quality processes. Denormalized natural key; SSOT is customer.address.mdm_address_key.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division of the address. Stored as ISO 3166-2 subdivision code (e.g., US-CA, DE-BY). Used for tax jurisdiction, regulatory compliance (OSHA, EPA), and logistics zone determination.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier for the address location, used to determine applicable sales tax, VAT, or GST rates for invoicing. Typically derived from postal code and state/province. Aligns with SAP S/4HANA tax determination and IFRS/GAAP revenue recognition requirements. Denormalized natural key; SSOT is finance.company_code.company_code.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/Chicago, Europe/Berlin, Asia/Shanghai). Used for scheduling field service visits, coordinating production planning across global manufacturing sites, and SLA response time calculations.',
    `validation_source` STRING COMMENT 'The system or method used to validate the address. Tracks whether validation was performed by USPS CASS certification, a geocoding API (Google Maps, HERE), Informatica MDM address cleansing, manual review, or not yet validated. Supports data quality governance.. Valid values are `usps_cass|google_maps|here_api|informatica_mdm|manual|unvalidated`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated against a postal authority or address verification service. Used to determine if re-validation is required based on data quality policies.',
    `vat_registration_number` DECIMAL(18,2) COMMENT 'Value Added Tax (VAT) registration number associated with this address, particularly for EU and international billing addresses. Required for cross-border B2B invoicing compliance and VAT reclaim processes in industrial manufacturing.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing address records for customer accounts and contacts, including headquarters, billing address, shipping/delivery address, and plant site addresses. Captures address type, street lines, city, state/province, postal code, country, geocoordinates, validated flag, and primary address indicator. Supports logistics, invoicing, and field service dispatch.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the customer credit profile record in the Databricks Silver Layer. Serves as the primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Credit analysis is executed by a designated employee; needed for credit review decisions and audit logs.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B industrial customer, OEM account, distributor, or end-user organization for whom this credit profile is maintained. Links to the customer master record.',
    `approval_date` DATE COMMENT 'Date on which the current credit limit and terms were formally approved by the authorized credit manager. Part of the credit governance audit trail required for SOX and IFRS compliance.',
    `approved_by` STRING COMMENT 'Name or employee ID of the credit manager or authorized approver who approved the current credit limit and terms. Required for segregation of duties (SoD) compliance and audit trail in SAP S/4HANA FI-AR.',
    `bad_debt_provision_amount` DECIMAL(18,2) COMMENT 'Amount provisioned for potential bad debt loss on this customers receivables under the IFRS 9 Expected Credit Loss (ECL) model or GAAP ASC 310 allowance method. Maintained in SAP S/4HANA FI-AR.',
    `bank_account_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers bank account details on file have been verified through the companys bank account validation process. True = verified; False = unverified. Required for direct debit and bank transfer payment methods.',
    `collection_strategy_code` DECIMAL(18,2) COMMENT 'Code identifying the dunning and collections strategy assigned to this customer in SAP S/4HANA FI-AR (e.g., standard dunning, escalated collections, legal action track). Drives automated dunning notice generation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage, audit trail, and IFRS/GAAP record-keeping requirements.',
    `credit_account_type` DECIMAL(18,2) COMMENT 'Classification of the credit account based on the nature of the customer relationship. Determines applicable credit policies and risk frameworks. [ENUM-REF-CANDIDATE: domestic|export|intercompany|distributor|oem|government — promote to reference product if additional types are required]',
    `credit_control_area` DECIMAL(18,2) COMMENT 'SAP organizational unit (credit control area code) responsible for managing and monitoring this customers credit. Defines the credit management scope and currency for credit limit enforcement in SAP S/4HANA FI-AR.',
    `credit_hold_date` DATE COMMENT 'Date on which the credit hold was applied to the customer account. Used for aging analysis of credit holds and SLA compliance tracking for credit resolution processes.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the customer account is currently placed on credit hold, blocking new order processing in SAP S/4HANA SD and Siemens Opcenter MES. True = credit hold active; False = no hold. Synchronized with Salesforce CRM account status.',
    `credit_hold_reason` DECIMAL(18,2) COMMENT 'Reason code explaining why the customer account has been placed on credit hold. Required for audit trail and CAPA (Corrective and Preventive Action) processes. Null when credit_hold_flag is False.',
    `credit_hold_released_date` DATE COMMENT 'Date on which the credit hold was lifted and normal order processing was reinstated. Null if the credit hold is still active. Used for credit resolution cycle time analysis.',
    `credit_insurance_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum insured amount under the trade credit insurance policy for this customer, in the account currency. Represents the maximum receivable amount recoverable in case of customer default.',
    `credit_insurance_expiry_date` DATE COMMENT 'Date on which the trade credit insurance policy for this customer expires. Triggers renewal workflow alerts to prevent uninsured credit exposure.',
    `credit_insurance_policy_number` DECIMAL(18,2) COMMENT 'Reference number of the trade credit insurance policy (e.g., Euler Hermes, Coface, Atradius) covering this customers receivables. Null if no credit insurance is in place. Used for insurance claim processing and risk mitigation reporting.',
    `credit_insurance_provider` DECIMAL(18,2) COMMENT 'Name of the trade credit insurance provider covering this customers receivables (e.g., Euler Hermes, Coface, Atradius, Credendo). Null if no credit insurance is in place.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure (in the account currency) that can be extended to the customer at any point in time. Set during credit review and enforced in SAP S/4HANA FI-AR credit management.',
    `credit_notes` DECIMAL(18,2) COMMENT 'Free-text field for credit analyst notes, special conditions, exceptions, or contextual information relevant to this customers credit profile. Supports credit review documentation and exception management.',
    `credit_rating` DECIMAL(18,2) COMMENT 'Internal or external credit risk rating assigned to the customer (e.g., A, B, C, D or numeric score). Used to classify credit risk tier and determine applicable credit terms, insurance requirements, and collection priority. May align with Dun & Bradstreet or internal scoring models.',
    `credit_rating_agency` DECIMAL(18,2) COMMENT 'Source or agency that issued the credit rating for this customer. Distinguishes between internally-derived ratings and third-party agency assessments used for credit risk management. [ENUM-REF-CANDIDATE: internal|dun_bradstreet|moody|sp|fitch|coface|euler_hermes — 7 candidates stripped; promote to reference product]',
    `credit_review_frequency` DECIMAL(18,2) COMMENT 'Frequency at which formal credit reviews are scheduled for this customer. Determined by credit risk tier and customer segment. Higher-risk customers require more frequent reviews.',
    `credit_segment` DECIMAL(18,2) COMMENT 'SAP S/4HANA credit segment identifier that groups customers under a common credit management policy and credit limit pool. Enables multi-segment credit management for customers operating across multiple business units or regions.',
    `credit_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the customer credit profile. Drives order release decisions in SAP S/4HANA SD and MES order management. on_hold and blocked prevent new order processing until resolved.',
    `credit_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the approved credit limit currently consumed by the outstanding balance (outstanding_balance / credit_limit × 100). Triggers credit hold alerts when threshold is breached. Synchronized from SAP S/4HANA FI-AR credit exposure calculation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit, outstanding balance, and financial terms are denominated (e.g., USD, EUR, GBP). Aligns with the customers billing currency in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `dso_days` DECIMAL(18,2) COMMENT 'Days Sales Outstanding — the average number of days it takes the customer to pay invoices, calculated as (outstanding_balance / total_credit_sales) × number_of_days. A key KPI for accounts receivable performance and cash flow management per IFRS/GAAP reporting.',
    `dunning_level` STRING COMMENT 'Current dunning level (1–4) indicating the escalation stage of overdue payment notices sent to the customer. Level 1 = first reminder; Level 4 = final notice before legal action. Managed in SAP S/4HANA FI-AR dunning program.',
    `early_payment_discount_days` DECIMAL(18,2) COMMENT 'Number of days from invoice date within which the customer must pay to qualify for the early payment discount. Null if no early payment discount applies.',
    `early_payment_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount offered to the customer for early payment within the discount period defined in the payment terms (e.g., 2.00 for a 2% early payment discount). Null if no early payment discount applies.',
    `effective_date` DATE COMMENT 'Date from which the current credit terms, credit limit, and risk classification became effective for this customer. Supports temporal credit management and audit trail requirements.',
    `expiry_date` DATE COMMENT 'Date on which the current credit terms and credit limit are scheduled to expire and require renewal or re-assessment. Null for open-ended credit agreements. Triggers next_credit_review_date workflow.',
    `last_credit_review_date` DATE COMMENT 'Date on which the most recent formal credit assessment was completed for this customer. Triggers next review scheduling and is used for credit governance compliance reporting.',
    `last_dunning_date` DATE COMMENT 'Date on which the most recent dunning notice was issued to the customer for overdue invoices. Used to track collections activity and enforce dunning intervals in SAP S/4HANA FI-AR.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this credit profile record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in Databricks Silver Layer ingestion and audit compliance.',
    `next_credit_review_date` DATE COMMENT 'Scheduled date for the next formal credit review of this customer. Drives workflow alerts in SAP S/4HANA FI-AR and Salesforce CRM for proactive credit management.',
    `oldest_overdue_days` STRING COMMENT 'Number of days since the oldest unpaid overdue invoice became due. Used for collections aging bucket analysis and bad debt provisioning triggers in SAP S/4HANA FI-AR.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Total open accounts receivable balance currently owed by the customer in the account currency, as synchronized from SAP S/4HANA FI-AR. Includes all open invoices, debit memos, and unapplied credits. Used for credit utilization monitoring.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Total value of invoices that have exceeded their due date and remain unpaid, in the account currency. A subset of outstanding_balance. Used for collections prioritization and bad debt provisioning per IFRS 9 expected credit loss model.',
    `payment_behavior_score` DECIMAL(18,2) COMMENT 'Internal scoring metric (0–100) reflecting the customers historical payment behavior, including on-time payment rate, frequency of late payments, and average days late. Inputs into credit rating and risk category determination.',
    `payment_method` DECIMAL(18,2) COMMENT 'Agreed payment instrument used by the customer for settling invoices (e.g., bank transfer, letter of credit for export customers, direct debit). Configured in SAP S/4HANA FI-AR payment method settings.',
    `payment_terms_code` DECIMAL(18,2) COMMENT 'SAP payment terms key defining the agreed payment schedule for this customer (e.g., NT30 = Net 30, NT60 = Net 60, NT90 = Net 90, 2/10NT30 = 2% discount if paid within 10 days, net 30). Drives invoice due date calculation in SAP S/4HANA FI-AR.',
    `payment_terms_days` DECIMAL(18,2) COMMENT 'Number of calendar days from invoice date within which payment is due under the agreed payment terms (e.g., 30 for Net 30, 60 for Net 60, 90 for Net 90). Used for DSO calculation and cash flow forecasting.',
    `risk_category` STRING COMMENT 'Categorical risk classification assigned to the customer based on credit rating, payment history, and financial health assessment. Drives credit limit setting, insurance requirements, and collection strategy.. Valid values are `low|medium|high|very_high|watch_list`',
    `salesforce_account_code` STRING COMMENT 'Salesforce CRM Account record ID for this customer, used for bi-directional synchronization of credit status and credit hold flags between SAP S/4HANA FI-AR and Salesforce CRM Sales Cloud.',
    `sap_customer_account_number` STRING COMMENT 'The externally-known SAP S/4HANA FI-AR customer account number (debtor number) used to uniquely identify the customer in the ERP system. Serves as the business identifier for cross-system reconciliation.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Customer credit assessment and terms management record. Captures credit limit, credit rating, payment terms (Net 30, Net 60, Net 90), currency, credit hold status, credit hold reason, last credit review date, next review date, credit insurance policy reference, outstanding balance, and days sales outstanding (DSO). Managed in SAP S/4HANA FI-AR and synchronized with Salesforce CRM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` (
    `sla_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the SLA agreement record in the Databricks Silver Layer. Primary key for this entity.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B industrial customer, OEM account, distributor, or end-user organization account to which this SLA agreement applies. Links to the customer account master in the customer domain.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the designated customer contact person who receives escalation notifications when SLA thresholds are at risk of breach or have been breached. Links to the contact master in the customer domain.',
    `customer_entitlement_id` BIGINT COMMENT 'The native record identifier of the corresponding Entitlement object in Salesforce Service Cloud. Used for cross-system reconciliation and data lineage tracing between the Databricks Silver Layer and the Salesforce source system.',
    `employee_id` BIGINT COMMENT 'Reference to the internal account manager or customer success manager responsible for managing this SLA agreement and the customer relationship. Links to the workforce/employee master.',
    `agreement_name` STRING COMMENT 'Descriptive name of the SLA agreement as displayed in Salesforce Service Cloud and customer-facing documents (e.g., Platinum Support SLA — Acme Automation 2024). Used for identification and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known, human-readable unique reference number for the SLA agreement as assigned in Salesforce Service Cloud (e.g., SLA-2024-00123). Used in customer communications, contract documents, and cross-system references.. Valid values are `^SLA-[A-Z0-9]{4,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the SLA agreement: draft (under negotiation), active (in force), suspended (temporarily paused), expired (past end date without renewal), or terminated (cancelled before end date). Governs whether SLA commitments are enforceable.. Valid values are `draft|active|suspended|expired|terminated`',
    `amendment_date` DATE COMMENT 'The date on which the most recent amendment or revision to the SLA agreement was executed and became effective. Null for the original version. Supports change management and audit compliance.',
    `annual_fee` DECIMAL(18,2) COMMENT 'The recurring annual fee charged to the customer for the SLA agreement, in the agreement currency. Used for revenue recognition, billing scheduling in SAP S/4HANA SD, and profitability analysis.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether the SLA agreement automatically renews upon expiry without requiring a new contract signature. True = auto-renews; False = requires explicit renewal action. Drives renewal workflow automation in Salesforce Service Cloud.',
    `billing_frequency` STRING COMMENT 'The frequency at which the customer is invoiced for the SLA agreement fee (e.g., monthly, quarterly, annual). Drives billing schedule creation in SAP S/4HANA SD and revenue recognition cadence.. Valid values are `monthly|quarterly|semi_annual|annual|one_time`',
    `contract_document_ref` STRING COMMENT 'Reference identifier or URL to the signed SLA contract document stored in the document management system (e.g., Siemens Teamcenter PLM or SharePoint). Enables traceability to the original legal document.',
    `contract_value` DECIMAL(18,2) COMMENT 'The total monetary value of the SLA agreement over its full term, expressed in the agreement currency. Used for financial reporting, revenue recognition under IFRS 15/ASC 606, and penalty cap calculations.',
    `covered_asset_count` STRING COMMENT 'The number of individual equipment units, machines, or installed assets covered under this SLA agreement. Used for capacity planning of field service resources and Maximo Asset Management integration.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA agreement record was first created in the source system (Salesforce Service Cloud). Represents the record audit creation time in ISO 8601 format with timezone offset.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value and penalty amounts in this SLA agreement (e.g., USD, EUR, GBP). Enables multi-currency financial reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The calendar date on which the SLA agreement becomes contractually binding and service commitments begin. Corresponds to the contract start date in Salesforce Service Cloud Entitlement.',
    `expiry_date` DATE COMMENT 'The calendar date on which the SLA agreement ceases to be binding. Null for open-ended agreements. Used to trigger renewal workflows and compliance reporting in Salesforce Service Cloud.',
    `field_service_included` BOOLEAN COMMENT 'Indicates whether on-site field service visits are included in the SLA agreement. True = field service dispatches are covered; False = remote support only. Drives field service scheduling and resource allocation in Salesforce Field Service.',
    `governing_law_country` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the interpretation and enforcement of this SLA agreement (e.g., USA, DEU). Determines applicable legal and regulatory frameworks for dispute resolution.. Valid values are `^[A-Z]{3}$`',
    `initial_response_time_hours` DECIMAL(18,2) COMMENT 'The maximum number of hours within which the service team must provide an initial acknowledgment or response to a customer-reported incident or service request under this SLA. A core contractual KPI metric tracked in Salesforce Service Cloud.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA agreement record was most recently updated in the source system (Salesforce Service Cloud). Used for incremental data ingestion, change detection, and audit trail compliance.',
    `max_annual_service_visits` STRING COMMENT 'The maximum number of on-site service visits (preventive or corrective) included per year under this SLA agreement. Null if unlimited or not applicable. Used for field service capacity planning and entitlement consumption tracking.',
    `notes` STRING COMMENT 'Free-text field for capturing additional contractual terms, special conditions, exclusions, or operational notes associated with the SLA agreement that are not captured in structured fields. Sourced from Salesforce Service Cloud Entitlement description.',
    `on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'The contractually committed minimum percentage of orders or shipments that must be delivered on or before the promised delivery date under this SLA. Applicable for on_time_delivery SLA types. Tracked against SAP S/4HANA SD delivery performance.',
    `parent_contract_ref` STRING COMMENT 'Reference number of the master or parent commercial contract (e.g., Master Service Agreement or Framework Agreement) under which this SLA agreement is issued. Enables hierarchical contract traceability in SAP S/4HANA SD.',
    `penalty_cap_pct` DECIMAL(18,2) COMMENT 'The maximum cumulative penalty or service credit that can be applied over the agreement period, expressed as a percentage of the total contract value. Limits the companys financial liability exposure from SLA breaches.',
    `penalty_clause_applicable` BOOLEAN COMMENT 'Indicates whether financial or service credit penalties apply to this SLA agreement when contractual thresholds are breached. True = penalty clauses are active; False = no penalty provisions. Drives financial exposure tracking and CAPA processes.',
    `penalty_credit_pct` DECIMAL(18,2) COMMENT 'The percentage of the contracted service fee or invoice value that is credited or refunded to the customer for each SLA breach event, as defined in the penalty clause. Null when penalty_clause_applicable is False.',
    `preventive_maintenance_included` BOOLEAN COMMENT 'Indicates whether scheduled preventive maintenance visits are included as part of the SLA agreement entitlement. True = preventive maintenance is covered; False = corrective/reactive only. Linked to TPM programs managed in Maximo.',
    `product_line_scope` STRING COMMENT 'Description of the specific product lines, equipment categories, or automation system families covered under this SLA agreement (e.g., CNC Machining Centers, PLC Control Systems, Electrification Solutions). Defines the boundary of service coverage.',
    `remote_monitoring_included` BOOLEAN COMMENT 'Indicates whether IIoT-based remote monitoring and diagnostics of covered assets is included in the SLA agreement. True = remote monitoring via Aveva SCADA or IIoT platform is active; False = not included.',
    `renewal_notice_days` STRING COMMENT 'The number of calendar days before the expiry date by which either party must provide written notice of intent to renew or terminate the SLA agreement. Triggers automated renewal alerts in Salesforce Service Cloud.',
    `resolution_time_hours` DECIMAL(18,2) COMMENT 'The maximum number of hours within which a reported incident or service request must be fully resolved under this SLA agreement. Drives escalation rules and penalty clause triggers in Salesforce Service Cloud.',
    `service_region` STRING COMMENT 'The primary geographic region where the SLA service commitments apply, expressed as an ISO 3166-1 alpha-3 country code (e.g., USA, DEU, GBR). Determines applicable regulatory requirements, support staffing, and logistics SLA parameters.. Valid values are `^[A-Z]{3}$`',
    `service_tier` STRING COMMENT 'The contractual service tier level assigned to this SLA agreement, determining the priority, response speed, and entitlements available to the customer. Platinum is the highest tier; Bronze is the base tier. Drives case prioritization in Salesforce Service Cloud.. Valid values are `Platinum|Gold|Silver|Bronze`',
    `sla_type` STRING COMMENT 'Classification of the SLA agreement by the primary service commitment it governs: response_time (initial response to incidents), uptime_guarantee (system/equipment availability), on_time_delivery (order fulfillment punctuality), support_entitlement (support tier access), or maintenance_coverage (preventive/corrective maintenance). [ENUM-REF-CANDIDATE: response_time|uptime_guarantee|on_time_delivery|support_entitlement|maintenance_coverage|field_service — promote to reference product]. Valid values are `response_time|uptime_guarantee|on_time_delivery|support_entitlement|maintenance_coverage`',
    `spare_parts_included` BOOLEAN COMMENT 'Indicates whether the cost of spare parts and replacement components is covered under this SLA agreement. True = parts included; False = parts billed separately. Impacts inventory planning in SAP S/4HANA MM and WMS.',
    `support_hours_coverage` STRING COMMENT 'The contracted support availability window defining hours per day and days per week during which the service team is obligated to respond (e.g., 8x5 = 8 hours/day, 5 days/week; 24x7 = round-the-clock). Determines staffing and escalation routing in Salesforce Service Cloud.. Valid values are `8x5|12x5|16x5|24x7|24x5`',
    `termination_date` DATE COMMENT 'The actual date on which the SLA agreement was terminated prior to its scheduled expiry date. Null for agreements that are active or expired naturally. Required for financial accrual reversal and CAPA closure in SAP S/4HANA.',
    `termination_reason` STRING COMMENT 'The reason code for early termination of the SLA agreement. Null when the agreement is active or expired naturally. Used for churn analysis, CAPA processes, and financial reporting.. Valid values are `customer_request|non_payment|breach_of_contract|mutual_agreement|product_discontinuation`',
    `uptime_target_pct` DECIMAL(18,2) COMMENT 'The contractually committed minimum system or equipment availability expressed as a percentage (e.g., 99.5 for 99.5% uptime). Applicable for uptime_guarantee SLA types. Used in OEE and availability reporting.',
    `version_number` STRING COMMENT 'Sequential version number of the SLA agreement, incremented each time the agreement is amended or renegotiated. Version 1 is the original agreement. Supports audit trail and change history tracking per ISO 9001 document control requirements.',
    CONSTRAINT pk_sla_agreement PRIMARY KEY(`sla_agreement_id`)
) COMMENT 'Service Level Agreement records defining contractual service commitments to industrial customers, including response time SLAs, uptime guarantees, on-time delivery targets, and support tier entitlements. Captures SLA type, tier (Platinum, Gold, Silver, Bronze), response time thresholds, resolution time thresholds, penalty clauses, effective date, expiry date, and associated account. Managed via Salesforce Service Cloud.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` (
    `account_relationship_id` BIGINT COMMENT 'Unique surrogate identifier for each account relationship record in the industrial customer domain. Serves as the primary key for the account_relationship data product.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the child, target, or subordinate account in the relationship. For corporate hierarchy relationships, this is the subsidiary, division, or affiliate. For commercial relationships, this is the receiving/target account (e.g., OEM licensee, distributor, reseller).',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee or sales representative responsible for managing and maintaining this account relationship. Maps to the Salesforce CRM relationship owner user record.',
    `primary_customer_account_id` BIGINT COMMENT 'Identifier of the parent, source, or owning account in the relationship. For corporate hierarchy relationships, this is the parent company or holding entity. For commercial relationships, this is the originating/source account (e.g., OEM licensor, distributor principal).',
    `agreement_reference_number` STRING COMMENT 'External contract or agreement number associated with a commercial relationship (e.g., OEM licensing agreement number, distributor contract ID, reseller agreement reference). Links to the formal legal document in the contract management system. Applicable for commercial relationship types.',
    `approval_date` DATE COMMENT 'Date on which the account relationship was formally approved by the authorized approver. Part of the relationship governance and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account relationship record was first created in the system of record. Supports audit trail, data lineage, and bi-temporal data management in the Databricks Silver layer.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure authorized for the child account within this relationship, expressed in the primary currency. Used for credit risk management and order approval workflows in SAP S/4HANA SD.',
    `crm_relationship_code` STRING COMMENT 'Native record identifier of this account relationship in Salesforce CRM. Used for cross-system reconciliation, data lineage, and integration with Salesforce Sales Cloud and Service Cloud.',
    `distribution_channel_code` STRING COMMENT 'SAP Distribution Channel code indicating how products and services are delivered to the child account within this relationship (e.g., direct sales, distributor, OEM channel). Drives pricing and order management rules.',
    `effective_date` DATE COMMENT 'The date from which the current version of the relationship record is considered authoritative and effective for reporting and roll-up purposes. Supports bi-temporal data management and point-in-time analytics.',
    `end_date` DATE COMMENT 'The calendar date on which the account relationship formally ends or is scheduled to end. Null for open-ended or perpetual relationships. For commercial agreements, aligns with contract expiry date.',
    `erp_customer_hierarchy_code` STRING COMMENT 'SAP S/4HANA customer hierarchy node identifier corresponding to this account relationship. Used for price determination, rebate processing, and financial roll-up in SAP SD and FI modules.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the commercial relationship includes an exclusivity clause, preventing either party from entering into similar arrangements with competitors within a defined territory or product category.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the commercial relationship agreement (e.g., DEU for Germany, USA for United States). Relevant for dispute resolution and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `hierarchy_depth` STRING COMMENT 'Total number of levels in the corporate hierarchy tree beneath the root parent account. Enables determination of the full depth of the organizational structure for roll-up reporting and consolidation. Applicable only when relationship_type = hierarchy.',
    `hierarchy_level` STRING COMMENT 'Numeric level of the child account within the corporate hierarchy tree, where level 1 represents the ultimate parent/holding company. Used for enterprise account roll-up reporting across subsidiaries and divisions. Applicable only when relationship_type = hierarchy.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain from the root parent to the current child account (e.g., /1001/1045/1078). Enables efficient subtree queries and roll-up aggregations without recursive joins in the Databricks lakehouse.',
    `industry_segment` STRING COMMENT 'Industry vertical or market segment classification of the account relationship, used for market analysis and targeted commercial strategies (e.g., automotive, energy, building_automation, transportation, process_industry). [ENUM-REF-CANDIDATE: automotive|energy|building_automation|transportation|process_industry|discrete_manufacturing|infrastructure|data_center — promote to reference product]',
    `is_global_account` BOOLEAN COMMENT 'Indicates whether this account relationship is part of a global enterprise account program, requiring coordinated management across multiple geographies and business units. True for multinational OEM and enterprise accounts.',
    `is_strategic_partner` BOOLEAN COMMENT 'Indicates whether the account relationship is classified as a strategic partnership requiring executive sponsorship and dedicated resources. True for key OEM partners, major distributors, and preferred EPC contractors.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the account relationship record. Used for change tracking, incremental data loading, and audit compliance in the Databricks Silver layer.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal business review conducted for this account relationship. Used to track review cadence compliance and identify relationships overdue for review.',
    `mdm_relationship_code` STRING COMMENT 'Informatica MDM golden record identifier for this account relationship. Serves as the cross-system master identifier for data quality, deduplication, and governance processes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal business review of this account relationship. Automatically calculated based on last_review_date and review_frequency. Used for account management planning.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent account in the child account for corporate hierarchy relationships (e.g., 100.00 for wholly-owned subsidiary, 51.00 for majority-owned affiliate). Null for non-equity commercial relationships. Relevant for financial consolidation under IFRS/GAAP.',
    `payment_terms_code` DECIMAL(18,2) COMMENT 'SAP payment terms code defining the agreed payment conditions for the commercial relationship (e.g., NET30, NET60, 2/10NET30). Sourced from SAP S/4HANA SD customer master payment terms.',
    `preferred_contact_method` STRING COMMENT 'Preferred communication channel for managing this account relationship, as agreed with the customer. Guides account managers on how to engage with the relationship counterpart for reviews, escalations, and business development.. Valid values are `email|phone|portal|in_person|video_conference`',
    `primary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary transactional currency of the commercial relationship (e.g., USD, EUR, GBP). Used for financial roll-up reporting and revenue attribution across the account hierarchy.. Valid values are `^[A-Z]{3}$`',
    `relationship_description` STRING COMMENT 'Free-text narrative describing the nature, context, and business purpose of the account relationship. Captures nuances not represented by structured fields, such as historical context, strategic rationale, or special commercial terms.',
    `relationship_health_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the overall health and strength of the account relationship, derived from engagement metrics, satisfaction surveys, payment behavior, and commercial activity. Used by account managers to prioritize relationship interventions.',
    `relationship_name` STRING COMMENT 'Human-readable descriptive name for the account relationship, typically combining the parent and child account names with the relationship subtype (e.g., Siemens AG — Siemens Energy GmbH (Subsidiary)). Used in reports and CRM displays.',
    `relationship_number` STRING COMMENT 'Externally-known, human-readable business identifier for the account relationship, used in correspondence, reporting, and cross-system reference. Sourced from Salesforce CRM relationship record number.. Valid values are `^REL-[0-9]{8,12}$`',
    `relationship_source` STRING COMMENT 'Identifies the operational system of record from which this account relationship record originated. Supports data lineage tracking and master data governance in Informatica MDM.. Valid values are `salesforce_crm|sap_s4hana|manual|migration|ariba`',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the account relationship. Active indicates the relationship is in force; pending indicates awaiting approval or activation; suspended indicates temporarily paused; terminated indicates formally ended.. Valid values are `active|inactive|pending|suspended|terminated`',
    `relationship_subtype` STRING COMMENT 'Granular classification of the relationship within its type. For hierarchy relationships: parent_subsidiary, division, affiliate, joint_venture, holding_company. For commercial relationships: oem_licensing, distributor_agreement, reseller_arrangement, preferred_supplier, epc_contractor, value_added_reseller. [ENUM-REF-CANDIDATE: parent_subsidiary|division|affiliate|joint_venture|oem_licensing|distributor_agreement|reseller_arrangement|preferred_supplier|epc_contractor|value_added_reseller — promote to reference product]',
    `relationship_type` STRING COMMENT 'Discriminator field classifying the relationship as either a corporate hierarchy structure (parent-child ownership, subsidiaries, divisions, affiliates, joint ventures) or a commercial partnership (OEM licensing, distributor agreements, reseller arrangements, preferred supplier, EPC contractor). Drives downstream roll-up logic and commercial analytics.. Valid values are `hierarchy|commercial`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Contractually agreed percentage of revenue shared between the parent and child accounts under a commercial relationship (e.g., OEM royalty rate, distributor margin percentage). Applicable for commercial relationship types with revenue-sharing arrangements.',
    `review_frequency` STRING COMMENT 'Agreed frequency of formal business review meetings between the manufacturing company and the account relationship counterpart. Drives scheduling of Quarterly Business Reviews (QBRs) and executive account reviews.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `sales_org_code` STRING COMMENT 'SAP Sales Organization code responsible for managing the commercial aspects of this account relationship. Determines pricing, order processing, and revenue booking rules applicable to the relationship.',
    `sla_tier` STRING COMMENT 'SLA tier assigned to this account relationship, determining the level of service, response times, and support entitlements applicable to the child account. Platinum and gold tiers receive priority support and dedicated account management.. Valid values are `platinum|gold|silver|bronze|standard`',
    `start_date` DATE COMMENT 'The calendar date on which the account relationship formally commenced. For hierarchy relationships, this is the date the corporate structure was established. For commercial relationships, this is the agreement or contract start date.',
    `strategic_importance_rating` DECIMAL(18,2) COMMENT 'Qualitative rating of the strategic importance of this account relationship to the manufacturing business. Critical indicates top-tier global accounts; high indicates major regional accounts; medium indicates standard commercial accounts; low indicates transactional or minor accounts.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the account relationship was terminated or ended. Populated only when relationship_status = terminated. Used for churn analysis and relationship lifecycle reporting.. Valid values are `contract_expiry|mutual_agreement|breach|acquisition|restructuring|other`',
    `territory_code` STRING COMMENT 'Sales territory or geographic region code assigned to this account relationship, used for territory management, revenue attribution, and sales performance reporting. Aligns with SAP S/4HANA SD sales territory configuration.. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_account_relationship PRIMARY KEY(`account_relationship_id`)
) COMMENT 'Single source of truth for all formal relationships between customer accounts, encompassing both corporate hierarchy structures (parent-child ownership, subsidiaries, divisions, affiliates, joint ventures with hierarchy level and depth for roll-up reporting) and commercial partnerships (OEM licensing, distributor agreements, reseller arrangements, preferred supplier status, EPC contractor relationships). Captures relationship type (hierarchy vs commercial — discriminator field), parent/child or source/target account references, hierarchy level and depth for corporate structures, start date, end date, relationship owner, strategic importance rating, relationship health score, and effective date. Supports global enterprise account roll-up reporting across subsidiaries and divisions, as well as commercial relationship tracking between independent entities in industrial automation and electrification markets.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique surrogate identifier for each customer interaction record in the silver layer lakehouse. Primary key for the interaction data product.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B customer account (OEM, distributor, or end-user organization) associated with this interaction. Maps to Salesforce CRM Account object.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the individual customer contact (person) who participated in this interaction. Maps to Salesforce CRM Contact object.',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity associated with this interaction, if applicable. Links interaction to active deal pipeline in Salesforce CRM.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee (sales rep, account manager, field engineer, or service agent) who owns and logged this interaction. Maps to Workday HCM worker record.',
    `request_id` BIGINT COMMENT 'Reference to the customer service case or support ticket associated with this interaction, if applicable. Links interaction to after-sales support and CAPA processes.',
    `sla_agreement_id` BIGINT COMMENT 'Reference to the SLA agreement governing the response and service standards applicable to this customer interaction. Enables SLA compliance monitoring for after-sales and service interactions.',
    `campaign_code` BIGINT COMMENT 'Reference to the marketing campaign that originated or is associated with this interaction (e.g., trade show campaign, email nurture campaign). Links interaction to campaign ROI analysis.',
    `capa_reference` STRING COMMENT 'Reference number of the CAPA record initiated as a result of this interaction, if applicable. Links customer feedback to the formal quality management corrective action process.',
    `channel` STRING COMMENT 'The communication medium or channel through which the interaction was conducted. Supports omnichannel relationship health analysis and customer experience tracking.. Valid values are `phone|email|in_person|virtual|survey|web_portal`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the interaction took place. Supports regional sales performance analysis and compliance with export control regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was first created in the system. Serves as the audit trail creation marker for data governance and lineage purposes.',
    `crm_activity_code` STRING COMMENT 'External identifier of the corresponding Task or Event record in Salesforce CRM. Used for cross-system traceability and delta-load reconciliation from the source system of record.',
    `interaction_description` STRING COMMENT 'Detailed narrative of the interaction content, topics discussed, key decisions made, and context. Supports relationship history review and account management continuity.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Actual elapsed duration of the interaction in minutes as recorded by the interaction owner. Supports engagement depth analysis and SLA compliance monitoring.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the customer interaction concluded. Combined with start timestamp to derive actual interaction duration.',
    `external_participants` STRING COMMENT 'Comma-separated list of customer-side participant names and roles who attended the interaction (e.g., John Smith - VP Engineering, Jane Doe - Procurement Manager). Classified confidential as it contains customer personnel information.',
    `follow_up_action` STRING COMMENT 'Description of the specific follow-up action to be taken after this interaction (e.g., Send product specification sheet, Schedule site visit, Prepare PPAP documentation).',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action resulting from this interaction must be completed. Used for account manager task management and SLA tracking.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up action or subsequent interaction is required as a result of this interaction. Drives task creation and account manager workflow.',
    `interaction_date` DATE COMMENT 'The calendar date on which the customer interaction took place. Used for day-level scheduling, reporting, and relationship cadence analysis.',
    `interaction_status` STRING COMMENT 'Current lifecycle state of the interaction record. Tracks whether the interaction has been planned, is underway, has been completed, or was cancelled or deferred.. Valid values are `planned|in_progress|completed|cancelled|deferred`',
    `interaction_type` STRING COMMENT 'Classification of the nature of the customer interaction. Distinguishes between sales-driven, technical, executive, and survey touchpoints. [ENUM-REF-CANDIDATE: sales_call|site_visit|product_demo|technical_consultation|executive_briefing|trade_show_meeting|nps_survey|email_outreach — promote to reference product]',
    `internal_participants` STRING COMMENT 'Comma-separated list of internal employee names or IDs who participated in the interaction (e.g., account manager, field application engineer, product specialist, executive sponsor). Supports multi-stakeholder engagement tracking.',
    `is_customer_complaint` BOOLEAN COMMENT 'Indicates whether this interaction involved a formal or informal customer complaint. Triggers CAPA workflow and quality management escalation per ISO 9001 requirements.',
    `is_executive_sponsor_involved` BOOLEAN COMMENT 'Indicates whether an executive sponsor (C-level or VP-level) from the company participated in this interaction. Flags high-touch executive engagement for strategic account management reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was last updated or modified. Supports delta-load processing in the lakehouse pipeline and audit trail requirements.',
    `location_name` STRING COMMENT 'Specific name or address of the location where the interaction occurred (e.g., Customer HQ - Detroit Plant 3, Hannover Messe Hall 9, Microsoft Teams). Supports geographic analysis of customer engagement.',
    `location_type` STRING COMMENT 'Classification of the physical or virtual location where the interaction took place. Distinguishes between customer-site visits, company-hosted meetings, trade show engagements, and virtual sessions.. Valid values are `customer_site|company_office|trade_show|virtual|factory_floor|neutral_venue`',
    `next_interaction_date` DATE COMMENT 'Planned date for the next scheduled customer interaction as agreed during this interaction. Supports proactive account management cadence and relationship continuity planning.',
    `nps_score` STRING COMMENT 'Net Promoter Score captured during customer satisfaction survey interactions. Integer value on a 0–10 scale where 0–6 = Detractor, 7–8 = Passive, 9–10 = Promoter. Null for non-survey interaction types.',
    `outcome` STRING COMMENT 'High-level result or outcome classification of the interaction. Indicates whether the interaction advanced the relationship, was neutral, resulted in escalation, or outcome is still pending.. Valid values are `positive|neutral|negative|pending|escalated`',
    `outcome_notes` STRING COMMENT 'Free-text notes elaborating on the interaction outcome, including specific commitments made, objections raised, or next steps agreed upon with the customer.',
    `participant_count` STRING COMMENT 'Total number of participants (internal and external combined) who attended the interaction. Used for engagement scale analysis and resource planning.',
    `priority` STRING COMMENT 'Business priority level assigned to the interaction, reflecting the strategic importance of the customer or the urgency of the topic discussed. Drives account manager workload prioritization.. Valid values are `critical|high|medium|low`',
    `product_line` STRING COMMENT 'The primary product line or solution portfolio discussed during the interaction (e.g., Automation Systems, Electrification Solutions, Smart Infrastructure). Supports product-level engagement analytics.',
    `relationship_health_score` STRING COMMENT 'Numeric score (1–100) representing the assessed health of the customer relationship at the time of this interaction, as rated by the account manager. Distinct from NPS — this is an internal assessment, not a customer-provided score.',
    `satisfaction_rating` STRING COMMENT 'Customer satisfaction rating on a 1–5 scale collected at the end of the interaction (1 = Very Dissatisfied, 5 = Very Satisfied). Applicable to service calls, technical consultations, and post-delivery reviews.',
    `sentiment_category` STRING COMMENT 'Categorized sentiment of the interaction as assessed by the interaction owner or derived from verbatim feedback analysis. Supports relationship health scoring and early warning detection for at-risk accounts.. Valid values are `positive|neutral|negative|mixed`',
    `source` STRING COMMENT 'System or method through which this interaction record was created or ingested. Supports data lineage tracking and source system reconciliation in the lakehouse silver layer.. Valid values are `salesforce_crm|manual_entry|email_integration|calendar_sync|survey_platform`',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the customer interaction began. Used for duration calculation, scheduling conflict detection, and time-zone-aware reporting.',
    `subject` STRING COMMENT 'Short descriptive title or subject line summarizing the purpose of the interaction (e.g., Q3 Automation System Review, PLC Upgrade Technical Demo). Maps to Salesforce CRM Activity Subject field.',
    `verbatim_feedback` DECIMAL(18,2) COMMENT 'Unstructured, verbatim text feedback provided by the customer during or after the interaction. Captured for voice-of-customer (VoC) analysis, sentiment analysis, and continuous improvement programs. Classified confidential as it contains customer-specific business opinions.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Records of all customer-facing business interactions and touchpoints including sales calls, site visits, product demonstrations, technical consultations, trade show meetings, executive briefings, and customer satisfaction survey responses (NPS). Maps to Salesforce CRM Activity (Task/Event). Captures interaction type, channel (phone, email, in-person, virtual, survey), date, duration, participants, outcome, satisfaction score (where applicable), verbatim feedback, follow-up actions, and associated opportunity or account. Supports relationship health monitoring and customer experience tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` (
    `customer_lead_id` BIGINT COMMENT 'Unique surrogate identifier for the sales lead record in the Databricks Silver Layer. Primary key for the lead data product.',
    `rep_id` BIGINT COMMENT 'Reference to the internal sales representative or account executive assigned to own and work this lead through the qualification and conversion process.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer_account record created upon successful lead conversion. Populated only when lead_status is Converted. Null for unconverted leads.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Supports lead qualification by capturing the exact SKU a prospect is interested in, driving accurate forecasting and targeted marketing.',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Estimated annual energy consumption of the prospective customers facilities in megawatt-hours. Key qualification criterion for electrification and energy management solution sales (ISO 50001 alignment).',
    `buying_stage` STRING COMMENT 'Estimated stage in the buyers journey for this lead based on engagement signals and sales rep assessment. Informs content strategy and sales approach for industrial automation solutions.. Valid values are `Awareness|Consideration|Evaluation|Decision|Not Determined`',
    `campaign_code` STRING COMMENT 'Identifier of the marketing campaign (trade show, digital campaign, webinar, email campaign) that generated or influenced this lead. Used for campaign ROI attribution and marketing spend analysis.',
    `city` STRING COMMENT 'City of the prospective companys primary operating location. Used for geographic segmentation, territory planning, and field sales routing.',
    `company_industry` STRING COMMENT 'Industry vertical of the prospective company (e.g., Automotive, Food & Beverage, Oil & Gas, Utilities, Building Automation, Transportation). Used for segmentation and targeted product positioning. [ENUM-REF-CANDIDATE: Automotive|Food & Beverage|Oil & Gas|Utilities|Building Automation|Transportation|Pharmaceuticals|Metals & Mining|Chemicals|Data Centers — promote to reference product]',
    `company_name` STRING COMMENT 'Legal or trading name of the prospective customer organization. Represents the B2B account target for industrial automation, electrification, or smart infrastructure products.',
    `company_size` STRING COMMENT 'Employee headcount band of the prospective organization. Used for lead scoring, segmentation, and determining appropriate sales motion (inside sales vs. field sales vs. enterprise).. Valid values are `1-50|51-200|201-1000|1001-5000|5001+`',
    `conversion_date` DATE COMMENT 'Date on which the lead was formally converted to a customer account and opportunity. Null for unconverted leads. Used for sales cycle duration analysis and conversion rate reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the prospective companys primary operating location (e.g., USA, DEU, CHN). Used for territory assignment, regional sales routing, and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lead record was first created in the source CRM system (Salesforce). Represents the RECORD_AUDIT_CREATED category. Used for lead age analysis, SLA tracking, and audit compliance.',
    `data_source` STRING COMMENT 'Originating system or method through which this lead record was created or enriched in the data platform. Used for data lineage, quality assessment, and MDM reconciliation.. Valid values are `Salesforce CRM|SAP S/4HANA|Manual Entry|Data Enrichment|Marketing Automation`',
    `disqualification_reason` STRING COMMENT 'Reason code explaining why the lead was disqualified using the BANT (Budget, Authority, Need, Timeline) framework or other criteria. Populated when lead_status = Disqualified. Used for funnel quality analysis. [ENUM-REF-CANDIDATE: No Budget|No Authority|No Need|No Timeline|Competitor|Duplicate|Invalid Data|Opted Out — 8 candidates stripped; promote to reference product]',
    `do_not_contact` BOOLEAN COMMENT 'Indicates whether the lead contact has opted out of all sales and marketing communications. When True, all outreach must cease immediately to comply with GDPR, CAN-SPAM, and CASL regulations.',
    `email` STRING COMMENT 'Primary business email address of the lead contact. Used for digital outreach, campaign tracking, and lead nurturing communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_out` BOOLEAN COMMENT 'Indicates whether the lead contact has specifically opted out of email marketing communications. Distinct from do_not_contact which covers all channels. Enforced for GDPR and CAN-SPAM compliance.',
    `estimated_annual_revenue` DECIMAL(18,2) COMMENT 'Estimated annual revenue of the prospective company in USD. Used for lead scoring, account tiering, and prioritization of sales resources. Sourced from public data, third-party enrichment, or sales rep input.',
    `estimated_close_date` DATE COMMENT 'Sales representatives estimated date by which the lead could be converted to a qualified opportunity or closed deal. Used for pipeline timing and sales cycle analysis.',
    `estimated_deal_value` DECIMAL(18,2) COMMENT 'Sales representatives estimate of the potential deal value in the revenue_currency if the lead converts to an opportunity. Used for pipeline forecasting and sales territory planning.',
    `existing_automation_vendor` STRING COMMENT 'Name of the incumbent automation or electrification vendor currently deployed at the prospective customers facilities (e.g., ABB, Rockwell, Schneider). Critical competitive intelligence for sales strategy and displacement campaigns.',
    `first_name` STRING COMMENT 'First (given) name of the primary contact person at the prospective organization. Used for personalized outreach and communication.',
    `grade` STRING COMMENT 'Alphabetic grade (A–D) representing the leads firmographic fit against the Ideal Customer Profile (ICP) for industrial automation and electrification products. Complements lead_score which measures behavioral engagement.. Valid values are `A|B|C|D`',
    `is_converted` BOOLEAN COMMENT 'Boolean flag indicating whether this lead has been successfully converted to a customer account, contact, and opportunity in the CRM. True when lead_status = Converted.',
    `job_title` STRING COMMENT 'Professional title or role of the primary contact at the prospective organization (e.g., Plant Manager, VP Engineering, Procurement Director). Informs sales approach and stakeholder mapping.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, email, meeting, demo) logged against this lead. Used to identify stale leads requiring re-engagement and to measure sales rep activity.',
    `last_name` STRING COMMENT 'Last (family) name of the primary contact person at the prospective organization. Combined with first_name to form the full contact identity.',
    `lead_source` STRING COMMENT 'Origination channel through which the lead was acquired. Drives marketing attribution, ROI analysis, and channel effectiveness reporting. [ENUM-REF-CANDIDATE: Trade Show|Website|Referral|Cold Outreach|Partner Referral|Webinar|Campaign|LinkedIn|Distributor|OEM Partner — promote to reference product]',
    `lead_status` STRING COMMENT 'Current lifecycle stage of the sales lead in the qualification funnel. New = uncontacted; Working = active outreach in progress; Qualified = meets ICP criteria; Converted = converted to customer_account; Disqualified = does not meet criteria or opted out.. Valid values are `New|Working|Qualified|Converted|Disqualified`',
    `lead_type` STRING COMMENT 'Classification of the lead by origination motion and relationship type. Distinguishes inbound (self-generated interest) from outbound (sales-initiated), and identifies OEM, distributor, or direct end-user engagement models.. Valid values are `Inbound|Outbound|Partner|OEM|Distributor|End User`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lead record in the source CRM system. Used for change detection, incremental data loading, and audit trail maintenance.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next sales follow-up action on this lead. Used by sales reps for pipeline management and by sales managers for activity monitoring.',
    `no_of_employees` STRING COMMENT 'Exact or estimated number of employees at the prospective company. Used alongside company_size band for more precise lead scoring and account tiering.',
    `no_of_production_sites` STRING COMMENT 'Estimated number of manufacturing plants, production facilities, or operational sites operated by the prospective company. Used to assess deal complexity, multi-site deployment potential, and enterprise account classification.',
    `phone` STRING COMMENT 'Primary business phone number of the lead contact including country code. Used for direct sales outreach and qualification calls.',
    `plc_installed_base` STRING COMMENT 'Description of the existing PLC (Programmable Logic Controller) installed base at the prospects facilities (e.g., Siemens S7-300, Allen-Bradley ControlLogix). Used to assess upgrade/migration opportunity and compatibility.',
    `product_interest_area` STRING COMMENT 'Primary product category or solution area the lead has expressed interest in. Drives sales rep assignment, product specialist routing, and targeted content delivery. [ENUM-REF-CANDIDATE: Drives|PLCs|Switchgear|Building Automation|Grid Solutions|Motion Control|Industrial IoT|SCADA|HMI|Robotics — promote to reference product]',
    `referral_partner_name` STRING COMMENT 'Name of the channel partner, distributor, OEM, or system integrator who referred this lead. Populated when lead_source is Partner Referral or Referral. Used for partner performance tracking and commission attribution.',
    `revenue_currency` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the estimated_annual_revenue field (e.g., USD, EUR, GBP). Enables multi-currency normalization for global lead management.',
    `sales_region` STRING COMMENT 'High-level geographic sales region grouping for the lead. Used for regional pipeline reporting, quota management, and executive dashboards.. Valid values are `North America|Europe|Asia Pacific|Latin America|Middle East & Africa`',
    `sales_territory` STRING COMMENT 'Geographic or account-based sales territory to which this lead is assigned (e.g., EMEA-North, APAC-Industrial, NA-Midwest). Drives sales rep routing and territory performance reporting.',
    `salesforce_lead_code` STRING COMMENT 'Native Salesforce CRM Lead object identifier (18-character Salesforce ID) used for cross-system traceability and synchronization with the source system of record.',
    `score` STRING COMMENT 'Numeric score (typically 0–100) representing the leads likelihood to convert based on behavioral signals, firmographic fit, and engagement data. Used for prioritization and sales rep workload management.',
    `state_province` STRING COMMENT 'State, province, or region of the prospective companys primary location. Used for territory management, sales rep assignment, and regional reporting.',
    `website` STRING COMMENT 'Official website URL of the prospective company. Used for research, data enrichment, and digital engagement tracking.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_customer_lead PRIMARY KEY(`customer_lead_id`)
) COMMENT 'Prospective customer records representing unqualified inbound or outbound sales leads for industrial automation, electrification, and smart infrastructure products. Maps to Salesforce CRM Lead object. Captures lead source (trade show, website, referral, cold outreach, partner referral), company name, industry, estimated annual revenue, product interest area (drives, PLCs, switchgear, building automation, grid solutions), lead status (New, Working, Qualified, Converted, Disqualified), lead score, assigned sales rep, conversion date, and converted account reference. Upon qualification and conversion, creates a new customer_account record.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`account_site` (
    `account_site_id` BIGINT COMMENT 'Unique surrogate identifier for the customer account site record in the Manufacturing lakehouse. Primary key for the account_site entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Site‑level cost tracking links each plant/site to a cost center for detailed operational expense reporting.',
    `customer_account_id` BIGINT COMMENT 'Reference to the parent customer account to which this site belongs. Links the physical site to the B2B customer, OEM, distributor, or end-user organization in the account master.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the primary contact person at this site responsible for coordinating field service visits, deliveries, and maintenance activities. Links to the contact master record.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Needed for site‑level asset management; links each plant site to the primary product installed for maintenance scheduling and warranty tracking.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Linking a manufacturing site to its responsible org unit enables cost allocation, governance and production planning.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center reporting per manufacturing site requires a profit_center_id on the site record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Site manager employee is needed for operations, maintenance scheduling and safety compliance reports.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Site‑level sales rep ownership is required for site‑specific revenue tracking and service contract management.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Linking a customer site to a supply‑chain network node enables routing, capacity, and cross‑docking decisions in logistics planning.',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing access restrictions, security clearance requirements, visitor registration procedures, or special entry protocols for field service engineers and delivery personnel at this site.',
    `address_line1` STRING COMMENT 'Primary street address line of the physical site location. Used for field service dispatch, logistics planning, and shipment routing.',
    `address_line2` STRING COMMENT 'Secondary address line for the site (suite, building, floor, gate number). Supplements address_line1 for precise field service and logistics routing.',
    `city` STRING COMMENT 'City or municipality in which the customer site is located. Used for geographic segmentation, logistics zone assignment, and field service territory planning.',
    `commissioning_date` DATE COMMENT 'Date on which the site was formally commissioned and became operational for Manufacturing product installations and services. Used to calculate site age, warranty period tracking, and lifecycle analytics.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the site location (e.g., USA, DEU, CHN). Drives regulatory compliance framework selection, export control classification, and multi-currency logistics costing.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account site record was first created in the system of record (Salesforce CRM). Provides audit trail for data governance and record lineage tracking per ISO 9001 documentation requirements.',
    `crm_site_code` STRING COMMENT 'Salesforce CRM native identifier for this account site record. Used for cross-system data lineage, reconciliation between the lakehouse silver layer and the Salesforce source system, and audit traceability.',
    `decommission_date` DATE COMMENT 'Date on which the site was or is planned to be decommissioned. Populated when site_status transitions to decommissioned. Used for installed base retirement tracking and asset lifecycle reporting.',
    `environmental_classification` STRING COMMENT 'Environmental condition classification of the site affecting product installation requirements, equipment ratings, and maintenance intervals. Informs selection of appropriate equipment IP ratings and material specifications. [ENUM-REF-CANDIDATE: standard|controlled|outdoor|corrosive|high_temperature|high_humidity — promote to reference product]. Valid values are `standard|controlled|outdoor|corrosive|high_temperature|high_humidity`',
    `erp_plant_code` STRING COMMENT 'SAP S/4HANA plant code corresponding to this customer site. Used for cross-system reconciliation of delivery addresses, service orders, and inventory movements associated with this site.. Valid values are `^[A-Z0-9]{1,10}$`',
    `industry_segment` STRING COMMENT 'Industry vertical or market segment classification of the customer site (e.g., Automotive, Food & Beverage, Oil & Gas, Utilities, Pharmaceuticals). Used for market analytics, product compatibility assessment, and regulatory compliance framework selection. [ENUM-REF-CANDIDATE: promote to reference product for full industry taxonomy]',
    `installed_product_count` STRING COMMENT 'Total number of Manufacturing products currently installed and tracked at this site. Drives installed base analytics, preventive maintenance scheduling volume, and spare parts demand forecasting.',
    `is_headquarters` BOOLEAN COMMENT 'Indicates whether this site is the primary headquarters or main facility of the customer account. Used for account hierarchy reporting, executive relationship management, and primary billing address determination.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account site record in the system of record. Used for change data capture (CDC), data freshness monitoring, and audit trail compliance.',
    `last_site_visit_date` DATE COMMENT 'Date of the most recent field service engineer or account manager visit to the site. Used for relationship management, service frequency analysis, and identifying sites overdue for preventive maintenance visits.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the site in decimal degrees (WGS 84). Enables geospatial analytics, field service route optimization, and proximity-based spare parts depot assignment.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the site in decimal degrees (WGS 84). Enables geospatial analytics, field service route optimization, and proximity-based spare parts depot assignment.',
    `maximo_location_code` STRING COMMENT 'IBM Maximo Asset Management location identifier for this site. Used to link account site records to Maximo work orders, preventive maintenance plans, and asset hierarchies for field service execution.',
    `mes_system_present` BOOLEAN COMMENT 'Indicates whether a Manufacturing Execution System (MES) is installed at the site. Used to assess integration readiness for Siemens Opcenter MES connectivity and shop floor data exchange.',
    `network_connectivity_type` STRING COMMENT 'Primary network connectivity type available at the site for IIoT device integration, remote monitoring, and SCADA/MES connectivity. Determines feasibility of remote diagnostics and predictive maintenance services.. Valid values are `ethernet|fiber|wireless|cellular|vpn|none`',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance visit at this site. Drives field service dispatch scheduling, spare parts pre-positioning, and resource capacity planning for the service organization.',
    `number_of_production_lines` STRING COMMENT 'Count of active production lines at the manufacturing site. Used to estimate installed base potential, maintenance workload, and spare parts demand. Relevant for manufacturing plant site types.',
    `operates_24x7` DECIMAL(18,2) COMMENT 'Indicates whether the site operates continuously 24 hours a day, 7 days a week. When true, overrides operational_hours_start/end for scheduling purposes and may trigger higher SLA tier assignment.',
    `operational_hours_end` DECIMAL(18,2) COMMENT 'Daily operational end time of the site in HH:MM (24-hour) format in the sites local time zone. Used to constrain field service scheduling, maintenance windows, and delivery cutoff times.',
    `operational_hours_start` DECIMAL(18,2) COMMENT 'Daily operational start time of the site in HH:MM (24-hour) format in the sites local time zone. Used to schedule field service visits, preventive maintenance windows, and delivery time slots within permitted hours.',
    `plant_floor_area_sqm` DECIMAL(18,2) COMMENT 'Total operational floor area of the site in square meters. Used for capacity planning, equipment density analysis, and logistics resource estimation for large-scale installations.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the customer site address. Used for logistics zone mapping, field service territory assignment, and tax jurisdiction determination.',
    `power_supply_frequency_hz` STRING COMMENT 'Electrical supply frequency at the site in Hertz (50 or 60 Hz). Required for equipment compatibility validation for automation systems, drives, and electrification products.',
    `power_supply_voltage` STRING COMMENT 'Primary electrical supply voltage standard at the site. Critical for ensuring compatibility of electrification solutions and automation equipment installed or to be installed at the site. [ENUM-REF-CANDIDATE: 110V|220V|380V|400V|480V|600V|other — 7 candidates stripped; promote to reference product]',
    `safety_classification` STRING COMMENT 'Safety and environmental classification of the site indicating special handling requirements for field service engineers and delivery personnel. Drives PPE requirements, access protocols, and compliance documentation. [ENUM-REF-CANDIDATE: hazardous|non_hazardous|restricted_access|cleanroom|explosion_proof — promote to reference product if additional classifications are required]. Valid values are `hazardous|non_hazardous|restricted_access|cleanroom|explosion_proof`',
    `scada_system_present` BOOLEAN COMMENT 'Indicates whether a SCADA system is installed and operational at the site. Relevant for integration planning with Aveva SCADA and for determining remote monitoring service eligibility.',
    `site_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the site across operational systems (SAP, Salesforce, Maximo). Used as the cross-system business key for site-level transactions, work orders, and shipments.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `site_contact_email` STRING COMMENT 'Email address of the primary on-site contact for service notifications, maintenance scheduling confirmations, and delivery alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `site_contact_name` STRING COMMENT 'Full name of the primary on-site contact person for field service coordination, delivery acceptance, and maintenance scheduling. Captured directly for operational use when the contact master record may not yet be established.',
    `site_contact_phone` STRING COMMENT 'Direct phone number for the primary on-site contact. Used by field service engineers and logistics teams for on-site coordination and delivery confirmation.',
    `site_criticality_rating` STRING COMMENT 'Business-assigned criticality level of the site reflecting the operational impact of downtime or service disruption. Drives SLA priority, spare parts stocking strategy, and preventive maintenance frequency. Aligned with FMEA risk classification.. Valid values are `critical|high|medium|low`',
    `site_name` STRING COMMENT 'Human-readable name of the physical plant, factory, or facility location (e.g., Chicago North Assembly Plant, Frankfurt Distribution Hub). Used in field service dispatch, logistics planning, and installed base reporting.',
    `site_status` STRING COMMENT 'Current lifecycle state of the customer site. Determines eligibility for field service dispatch, new product installations, and preventive maintenance scheduling. decommissioned sites are retained for historical installed base tracking.. Valid values are `active|decommissioned|under_construction|suspended|planned`',
    `site_type` STRING COMMENT 'Classification of the facility type indicating the primary operational purpose of the site. Drives field service routing, SLA tier assignment, and preventive maintenance scheduling. [ENUM-REF-CANDIDATE: manufacturing_plant|warehouse|distribution_center|data_center|commercial_building|substation — promote to reference product if additional types are required]. Valid values are `manufacturing_plant|warehouse|distribution_center|data_center|commercial_building|substation`',
    `sla_tier` STRING COMMENT 'SLA service tier assigned to this site, determining response time commitments, on-site support priority, and spare parts availability guarantees for field service and maintenance activities.. Valid values are `platinum|gold|silver|bronze|standard`',
    `state_province` STRING COMMENT 'State, province, or region of the customer site. Used for regulatory compliance jurisdiction determination (OSHA, EPA), tax zone assignment, and logistics planning.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the site location (e.g., America/Chicago, Europe/Berlin). Used for scheduling preventive maintenance windows, field service appointments, and operational hours alignment.',
    CONSTRAINT pk_account_site PRIMARY KEY(`account_site_id`)
) COMMENT 'Physical plant, factory, or facility locations associated with a customer account where Manufacturing products are installed, delivered, or serviced. Captures site name, site type (manufacturing plant, warehouse, distribution center, data center, commercial building, substation), address reference, site contact, installed product count, site criticality rating, site status (active, decommissioned, under construction), operational hours, and environmental/safety classification. Enables field service dispatch, logistics planning, installed base tracking, and preventive maintenance scheduling at customer locations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` (
    `customer_certification_id` BIGINT COMMENT 'Unique surrogate identifier for each customer certification record in the silver layer lakehouse. Primary key for the customer_certification data product.',
    `account_site_id` BIGINT COMMENT 'Reference to the specific customer facility, plant, or operational site to which this certification applies. A single account may hold certifications at multiple sites.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Certification audits are performed by internal auditors; tracking the employee provides audit trail and compliance reporting.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B customer account or OEM organization that holds this certification. Links the certification to the customer master record in Salesforce CRM.',
    `applicable_product_categories` STRING COMMENT 'Comma-separated list of product categories or commodity codes to which this certification applies, as declared in the certificate scope. Used to match certification coverage against specific procurement line items and OEM qualification requirements.',
    `body_country` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the country where the certifying body is registered and operates (e.g., USA, DEU, GBR). Used for jurisdictional compliance analysis and accreditation authority mapping.. Valid values are `^[A-Z]{3}$`',
    `capa_due_date` DATE COMMENT 'The deadline by which the customer must submit or complete their Corrective and Preventive Action (CAPA) plan to the certifying body or internal compliance team. Null when capa_required is False.',
    `capa_required` BOOLEAN COMMENT 'Indicates whether a Corrective and Preventive Action (CAPA) plan is required as a condition of maintaining or renewing this certification. Set to True when non-conformances have been identified that require formal corrective action.',
    `ce_marking_applicable` BOOLEAN COMMENT 'Indicates whether this certification is associated with or required for CE Marking (European Conformity) compliance. Relevant for customers supplying products to the European market under EU product safety directives.',
    `certificate_document_url` STRING COMMENT 'URL or path to the scanned or digital copy of the certificate document stored in the document management system (e.g., Siemens Teamcenter or SharePoint). Enables direct access to the source certificate for audit and verification purposes.',
    `certificate_number` STRING COMMENT 'The official certificate number or registration number issued by the certifying body. Used as the externally-known unique identifier for the certification document (e.g., ISO9001-2024-00123456). Required for OEM qualification and distributor onboarding verification.',
    `certification_scope` STRING COMMENT 'The declared scope of the certification as stated on the certificate, describing the products, processes, or services covered (e.g., Design, manufacture, and supply of industrial automation components). Critical for determining applicability to specific procurement categories.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the customer certification. active = valid and in force; expired = past expiry date without renewal; suspended = temporarily withdrawn by issuing body; withdrawn = permanently revoked; pending_renewal = renewal audit in progress; under_review = under surveillance audit.. Valid values are `active|expired|suspended|withdrawn|pending_renewal|under_review`',
    `certification_type` STRING COMMENT 'High-level classification of the certification by its governing domain (e.g., quality management, environmental management, product safety). Used to segment certifications for compliance reporting and supplier qualification workflows. [ENUM-REF-CANDIDATE: quality_management|environmental_management|occupational_health_safety|energy_management|automotive_quality|aerospace_quality|product_safety|cybersecurity — promote to reference product]',
    `country` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the country in which the certification is valid or was issued (e.g., USA, DEU, CHN). Relevant for multi-national customers where certifications may be jurisdiction-specific.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the lakehouse silver layer. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage requirements.',
    `days_to_expiry` STRING COMMENT 'The number of calendar days remaining until the certification expires, calculated from the current date to expiry_date. Used to drive automated renewal alerts and qualification eligibility checks. Negative values indicate the certification has already expired.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid unless renewed. Used to trigger renewal workflows and to gate OEM qualification and distributor onboarding eligibility. Formatted as yyyy-MM-dd.',
    `initial_certification_date` DATE COMMENT 'The date on which the customer first obtained this certification standard, regardless of subsequent renewals. Used to calculate total years of certified operation and assess supplier maturity in qualification processes.',
    `is_multi_site` BOOLEAN COMMENT 'Indicates whether this certificate covers multiple customer sites under a single certificate number (multi-site certification). When True, the certification scope applies to all sites listed in the certificate annex rather than a single facility.',
    `is_primary_certification` BOOLEAN COMMENT 'Indicates whether this certification is the primary or most critical certification for the customer account within its certification type. Used to prioritize compliance checks and qualification gate decisions when a customer holds multiple certifications of the same type.',
    `issue_date` TIMESTAMP COMMENT 'The date on which the certification was formally issued or granted by the certifying body. Represents the start of the current certification cycle. Formatted as yyyy-MM-dd.',
    `issuing_body_accreditation_number` BOOLEAN COMMENT 'The accreditation number of the certification body as granted by a national accreditation authority (e.g., ANAB, UKAS, DAkkS). Enables verification that the issuing body is formally accredited to issue the specific standard.',
    `issuing_body_name` BOOLEAN COMMENT 'The name of the accredited certification body or registrar that issued the certificate (e.g., Bureau Veritas, TÜV Rheinland, SGS, DNV, Intertek). Used to validate accreditation status and credibility of the certification.',
    `last_surveillance_audit_date` DATE COMMENT 'The date of the most recent surveillance audit conducted by the certifying body to verify ongoing compliance. ISO management system certifications typically require annual surveillance audits between recertification cycles.',
    `next_surveillance_audit_date` DATE COMMENT 'The scheduled date for the next surveillance audit by the certifying body. Used to proactively manage audit readiness and compliance calendar for the customer account.',
    `nonconformance_count` STRING COMMENT 'The number of open or unresolved non-conformances (NCRs) identified during the most recent audit cycle for this certification. A non-zero value may affect qualification eligibility and triggers CAPA (Corrective and Preventive Action) follow-up.',
    `notes` STRING COMMENT 'Free-text field for additional context, conditions, or remarks associated with the certification record (e.g., Certificate covers only the Monterrey plant, Renewal pending third-party audit scheduled for Q3). Captured by compliance or procurement teams in Salesforce CRM.',
    `qualification_eligibility` STRING COMMENT 'Derived qualification eligibility status of the customer based on this certification, used in OEM qualification, distributor onboarding, and procurement approval workflows. eligible = meets all certification requirements; ineligible = does not meet requirements; conditional = meets requirements with conditions; under_review = eligibility being assessed.. Valid values are `eligible|ineligible|conditional|under_review`',
    `regulatory_requirement_reference` STRING COMMENT 'Reference to the specific regulatory requirement, customer contract clause, or industry mandate that necessitates this certification (e.g., EU Machinery Directive 2006/42/EC, OSHA 29 CFR 1910, CE Marking Directive). Links the certification to its compliance obligation.',
    `renewal_date` DATE COMMENT 'The date on which the certification was most recently renewed or recertified. Distinct from issue_date when a renewal results in a new certificate number. Formatted as yyyy-MM-dd.',
    `renewal_status` STRING COMMENT 'Tracks the current state of the certification renewal process. not_due = renewal not yet required; in_progress = renewal audit underway; submitted = renewal application submitted to certifying body; approved = renewal granted; lapsed = renewal not completed before expiry.. Valid values are `not_due|in_progress|submitted|approved|lapsed`',
    `source_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., Salesforce CRM record ID, SAP Ariba document number). Enables traceability back to the system of record for reconciliation and data quality management.',
    `standard` STRING COMMENT 'The specific industry standard or scheme to which the certification applies (e.g., ISO 9001:2015, ISO 14001:2015, IATF 16949:2016, AS9100 Rev D, UL 508A, IEC 62443-2-1). Drives OEM qualification eligibility and regulatory compliance checks.',
    `ul_listing_number` STRING COMMENT 'The Underwriters Laboratories (UL) listing or file number associated with this certification, if applicable. Used for product safety certification tracking for customers supplying electrical or industrial components to North American markets.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last modified in the lakehouse silver layer. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Used to detect stale records and trigger re-verification workflows.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified for authenticity and current validity by the internal compliance or procurement team. Used to ensure certifications are periodically re-validated and not relied upon without current confirmation.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity and validity of the certification. manual_review = reviewed by internal compliance team; online_registry = validated via certifying bodys public registry; third_party_audit = verified by an independent auditor; self_declaration = customer-provided without independent verification.. Valid values are `manual_review|online_registry|third_party_audit|self_declaration`',
    `verified_by` STRING COMMENT 'The name or employee identifier of the internal compliance officer or procurement analyst who last verified the certification. Provides an audit trail for compliance accountability.',
    CONSTRAINT pk_customer_certification PRIMARY KEY(`customer_certification_id`)
) COMMENT 'Customer-held certifications and compliance qualifications relevant to industrial procurement and partnership eligibility, such as ISO 9001, ISO 14001, IATF 16949, AS9100, and UL certifications. Captures certification type, issuing body, certificate number, issue date, expiry date, renewal status, and associated account or site. Used in OEM qualification, distributor onboarding, and regulatory compliance checks.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` (
    `customer_entitlement_id` BIGINT COMMENT 'Unique surrogate identifier for the customer entitlement record in the Databricks Silver Layer. Maps to the Salesforce Service Cloud Entitlement object primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B customer account (OEM, distributor, or end-user organization) that holds this entitlement. Links to the customer account master in the customer domain.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the primary customer contact person responsible for managing this entitlement on the customer side. Used for service notifications, renewal communications, and escalation routing.',
    `employee_id` BIGINT COMMENT 'Reference to the internal Salesforce user (account manager or customer success manager) responsible for managing and renewing this entitlement. Drives ownership-based reporting and renewal task assignment.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the specific installed asset or equipment unit (e.g., CNC machine, PLC, automation cell) covered by this entitlement. Nullable when the entitlement applies at the account level rather than a specific asset.',
    `order_header_id` BIGINT COMMENT 'Reference to the SAP S/4HANA sales order that triggered the creation of this entitlement (e.g., purchase of a product with bundled warranty or support). Provides commercial traceability for entitlement provisioning.',
    `sku_master_id` BIGINT COMMENT 'Reference to the product or product family (e.g., automation system, electrification solution) that this entitlement covers. Drives eligibility rules for spare parts access and software updates.',
    `auto_renew` BOOLEAN COMMENT 'Indicates whether this entitlement is configured to automatically renew upon expiry based on the parent SLA agreement terms. Drives renewal workflow triggers in Salesforce CRM and SAP S/4HANA SD.',
    `business_unit` STRING COMMENT 'The internal business unit or division of the manufacturing organization responsible for delivering the services covered by this entitlement (e.g., Automation Systems, Electrification Solutions, Smart Infrastructure). Used for revenue attribution and service capacity planning.',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'The cumulative number of service units, incidents, visits, or licenses consumed against this entitlement to date. Updated each time a case, work order, or service event is closed and linked to this entitlement.',
    `contract_line_number` STRING COMMENT 'The specific line item number within the parent sales or service contract (SAP S/4HANA SD contract) from which this entitlement was generated. Enables traceability from entitlement back to the originating commercial contract.',
    `contracted_value` DECIMAL(18,2) COMMENT 'The total monetary value of the services covered by this entitlement as agreed in the commercial contract. Used for revenue recognition, deferred revenue tracking, and customer profitability analysis. Expressed in the currency defined by currency_code.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the customer site or asset location covered by this entitlement. Used for regulatory compliance, export control checks, and regional service routing.. Valid values are `^[A-Z]{3}$`',
    `coverage_schedule_code` BIGINT COMMENT 'Reference to the operating hours / coverage schedule that defines when this entitlements services are available (e.g., 8x5, 24x7, business hours only). Maps to the Salesforce Operating Hours object linked to the entitlement.',
    `coverage_type` STRING COMMENT 'Defines the mode of service delivery covered by this entitlement. on_site requires a field engineer visit; remote covers phone/digital support only; hybrid allows both; parts_only covers spare parts shipment without labor.. Valid values are `on_site|remote|hybrid|parts_only`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this entitlement record was first created in the source system (Salesforce Service Cloud). Represents the business event of entitlement provisioning, not the ETL ingestion time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary values associated with this entitlement (e.g., contracted service value, spare parts credit limit). Supports multi-currency reporting in SAP S/4HANA FI/CO.. Valid values are `^[A-Z]{3}$`',
    `customer_entitlement_status` STRING COMMENT 'Current lifecycle state of the entitlement record. active indicates the entitlement is valid and consumable; expired indicates the end date has passed; suspended indicates temporary hold pending review; pending_activation indicates awaiting contract confirmation.. Valid values are `active|inactive|expired|suspended|pending_activation`',
    `end_date` DATE COMMENT 'The date on which the entitlement expires and the customer is no longer entitled to the covered services. Nullable for open-ended entitlements such as perpetual licenses.',
    `entitlement_number` STRING COMMENT 'Externally-known business identifier for the entitlement record, used in customer-facing communications, service portals, and cross-system references. Sourced from Salesforce Service Cloud.. Valid values are `^ENT-[0-9]{8,12}$`',
    `entitlement_type` STRING COMMENT 'Classification of the entitlement category defining what service or coverage the customer is entitled to. Drives service fulfillment routing and eligibility checks in Salesforce Service Cloud and SAP S/4HANA QM. [ENUM-REF-CANDIDATE: warranty|support_incident|preventive_maintenance|software_update|spare_parts_access|field_service_visit — promote to reference product if additional types are needed]. Valid values are `warranty|support_incident|preventive_maintenance|software_update|spare_parts_access`',
    `escalation_contact` STRING COMMENT 'Name or identifier of the designated escalation contact (internal or customer-side) for critical service issues under this entitlement. Used when standard response time milestones are breached.',
    `geography_region` STRING COMMENT 'The geographic region where the entitlements covered asset or customer account is located (e.g., EMEA, APAC, AMER). Used for service dispatch routing, regional SLA compliance reporting, and capacity planning.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the entitlement is currently active and eligible for service consumption. Derived from status and date fields in Salesforce but stored as a denormalized field for fast eligibility checks in the Silver Layer.',
    `is_perpetual` BOOLEAN COMMENT 'Indicates whether this entitlement has no expiry date and is valid indefinitely (e.g., perpetual software licenses or lifetime warranty on specific components). When True, end_date is expected to be null.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this entitlement record was last updated in the source system (Salesforce Service Cloud). Used for incremental data ingestion, change detection, and audit trail maintenance in the Silver Layer.',
    `customer_entitlement_name` STRING COMMENT 'Human-readable name describing the entitlement, such as Gold Support – CNC Machining Line 2024 or Preventive Maintenance – Automation Cell A. Used for display and search in service portals.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, exclusions, or operational notes related to this entitlement. Examples include asset modification exclusions, geographic restrictions, or special handling instructions.',
    `parts_access_eligible` BOOLEAN COMMENT 'Indicates whether the customer is entitled to access spare parts under this entitlement. When True, the customer may order spare parts at contracted pricing or at no charge depending on the entitlement terms.',
    `preventive_maintenance_visits` STRING COMMENT 'Total number of scheduled preventive maintenance visits allocated under this entitlement per contract period. Applicable to entitlements of type preventive_maintenance. Supports TPM (Total Productive Maintenance) planning.',
    `preventive_maintenance_visits_used` STRING COMMENT 'Number of preventive maintenance visits already consumed against the allocated visits for this entitlement. Updated upon completion of each PM work order linked to this entitlement in Maximo or Salesforce.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the entitlement quantity fields (total, consumed, remaining). Examples: incident for support cases, visit for preventive maintenance, license for software seats, hour for service hours.. Valid values are `incident|visit|license|hour|unit`',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'The number of service units, incidents, visits, or licenses still available for consumption under this entitlement (total_quantity minus consumed_quantity). Maintained as a stored field in Salesforce for real-time eligibility checks rather than computed on-the-fly.',
    `renewal_date` DATE COMMENT 'The date on which this entitlement is scheduled for renewal review or automatic renewal. Used by the customer success team to initiate renewal negotiations and by Salesforce workflows to trigger renewal tasks.',
    `resolution_time_hours` DECIMAL(18,2) COMMENT 'Maximum number of hours within which a service issue must be fully resolved under this entitlement, as defined by the SLA tier. Drives escalation workflows and SLA breach alerts in Salesforce Service Cloud.',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Maximum number of hours within which the service team must respond to a service request under this entitlement, as defined by the SLA tier. Used for case routing and SLA compliance monitoring.',
    `service_hours_allocation` DECIMAL(18,2) COMMENT 'Total number of service hours allocated under this entitlement for on-site or remote support activities. Applicable primarily to time-and-materials or block-hour SLA entitlements. Null when the entitlement is incident-based rather than time-based.',
    `service_hours_consumed` DECIMAL(18,2) COMMENT 'Cumulative number of service hours consumed against the allocated service hours for this entitlement. Updated upon closure of service work orders or field service visits linked to this entitlement.',
    `sla_tier` STRING COMMENT 'The SLA service tier associated with this entitlement, determining response time commitments, escalation priorities, and service scope. Derived from the parent SLA agreement but stored here for fast eligibility lookup.. Valid values are `bronze|silver|gold|platinum`',
    `software_update_eligible` BOOLEAN COMMENT 'Indicates whether the customer is entitled to receive software updates, patches, or firmware upgrades for covered products under this entitlement. Relevant for PLC, SCADA, MES, and HMI software components.',
    `source_record_code` STRING COMMENT 'The native primary key or record identifier of this entitlement in the originating source system (e.g., Salesforce Entitlement ID 0i0XXXXXXXXXXXX). Enables bidirectional traceability between the lakehouse Silver Layer and the operational system.',
    `spare_parts_credit_limit` DECIMAL(18,2) COMMENT 'Maximum monetary value of spare parts the customer may claim or order at no charge or at contracted pricing under this entitlement. Applicable when entitlement_type includes spare_parts_access. Expressed in currency_code.',
    `start_date` DATE COMMENT 'The date on which the entitlement becomes effective and the customer may begin consuming the allocated service allowances. Corresponds to the contract or warranty activation date.',
    `total_quantity` DECIMAL(18,2) COMMENT 'The total number of service units, incidents, visits, or licenses originally allocated under this entitlement (e.g., 10 support incidents, 4 preventive maintenance visits, 5 software licenses). Represents the full allocation at entitlement creation.',
    `warranty_claim_eligible` BOOLEAN COMMENT 'Indicates whether the customer is currently eligible to submit warranty claims under this entitlement. May be set to False if the entitlement is suspended, the asset has been modified outside approved parameters, or warranty conditions have been voided.',
    CONSTRAINT pk_customer_entitlement PRIMARY KEY(`customer_entitlement_id`)
) COMMENT 'Customer entitlement records defining specific support services, warranty coverage, software licenses, and spare parts access a customer account is entitled to based on purchased products and active SLA agreements. Maps to Salesforce Service Cloud Entitlement object. Captures entitlement type (warranty, support incidents, preventive maintenance visits, software updates, spare parts access), start date, end date, remaining quantity, consumed quantity, service hours allocation, coverage schedule, and associated account and SLA tier. Distinct from sla_agreement which defines contractual terms — entitlement tracks the consumable allowances derived from those terms.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`account_team` (
    `account_team_id` BIGINT COMMENT 'Unique surrogate identifier for each account team member assignment record in the Manufacturing CRM system. Primary key for the account_team data product.',
    `employee_id` BIGINT COMMENT 'The internal Manufacturing employee identifier for the team member, sourced from Workday HCM. Used for cross-referencing HR records, compensation, and workforce analytics.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Team assignments reference segment for reporting; replace string with FK.',
    `account_user_employee_id` BIGINT COMMENT 'Reference to the internal Manufacturing employee or system user assigned to this account team role. Maps to the Salesforce CRM User record and Workday HCM employee record.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account to which this team member is assigned. Links to the B2B industrial customer, OEM, distributor, or end-user organization record.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this account team assignment belongs. Defines the geographic or market segment scope of the team members responsibility.',
    `access_level` STRING COMMENT 'The level of access granted to this team member for the customer account record in Salesforce CRM. Controls visibility and edit permissions for account data, contacts, opportunities, and cases.. Valid values are `read_only|read_write|full_access`',
    `assignment_reason` STRING COMMENT 'Free-text description of the business reason for this account team assignment (e.g., new account onboarding, territory realignment, escalation coverage, strategic account expansion).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the account team member assignment. Indicates whether the assignment is currently active, pending activation, temporarily suspended, or has been terminated.. Valid values are `active|inactive|pending|suspended|terminated`',
    `assignment_type` STRING COMMENT 'Classifies the nature of the account team assignment as permanent (long-term), temporary (project-based), interim (gap coverage), or coverage (vacation/leave backup). Supports workforce planning and continuity management.. Valid values are `permanent|temporary|interim|coverage`',
    `case_access` STRING COMMENT 'The level of access granted to this team member for service case records associated with the customer account. Governs visibility into support tickets, NCRs, RMAs, and CAPA records.. Valid values are `none|read_only|read_write`',
    `contact_access` STRING COMMENT 'The level of access granted to this team member for contact records associated with the customer account. Controls visibility into customer stakeholder information.. Valid values are `none|read_only|read_write`',
    `cost_center_code` DECIMAL(18,2) COMMENT 'The SAP S/4HANA cost center code associated with the team members department. Used for internal cost allocation of account management activities and OpEx reporting.',
    `coverage_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the primary country this team member covers for the assigned account. Used for regulatory compliance, export control, and regional reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this account team assignment record was first created in the source system. Used for audit trail, data lineage, and SLA compliance reporting.',
    `crm_owner_code` STRING COMMENT 'The Salesforce CRM user ID of the record owner responsible for maintaining this account team member record. Used for data stewardship, governance, and audit accountability.',
    `crm_team_member_code` STRING COMMENT 'External identifier for this account team member record as assigned by Salesforce CRM. Used for cross-system reconciliation and audit traceability back to the source system of record.',
    `data_source` STRING COMMENT 'Identifies the operational system of record from which this account team assignment record was sourced. Supports data lineage, reconciliation, and MDM governance processes.. Valid values are `salesforce_crm|sap_s4hana|workday_hcm|manual_entry`',
    `department` STRING COMMENT 'The organizational department or business unit of the Manufacturing employee, sourced from Workday HCM. Used for cost allocation, reporting hierarchy, and cross-functional team analytics.',
    `effective_from_timestamp` TIMESTAMP COMMENT 'The precise timestamp from which this account team assignment record version is valid in the Silver Layer lakehouse. Supports slowly changing dimension (SCD) Type 2 history tracking for the assignment.',
    `effective_to_timestamp` TIMESTAMP COMMENT 'The precise timestamp until which this account team assignment record version is valid in the Silver Layer lakehouse. Null indicates the current active version. Supports SCD Type 2 history tracking.',
    `end_date` DATE COMMENT 'The date on which the internal team members assignment to this customer account is scheduled to end or was terminated. Null indicates an open-ended, currently active assignment.',
    `engagement_model` STRING COMMENT 'The customer engagement model governing how this team member interacts with the account. Determines the frequency, depth, and mode of customer engagement activities.. Valid values are `strategic|transactional|self_service|partner_managed`',
    `industry_vertical` STRING COMMENT 'The industry vertical of the customer account (e.g., Automotive, Aerospace, Food & Beverage, Energy). Used for vertical-specific sales strategy alignment and application engineering expertise matching.',
    `is_current_record` BOOLEAN COMMENT 'Indicates whether this row represents the current active version of the account team assignment record in the Silver Layer SCD Type 2 history table. True for the latest version, False for historical versions.',
    `is_executive_sponsor` BOOLEAN COMMENT 'Indicates whether this team member serves as the executive sponsor for the customer account. Executive sponsors are senior Manufacturing leaders accountable for strategic relationship health.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this team member is designated as the primary point of contact for the customer account. Only one team member per account should hold this designation at any given time.',
    `is_team_lead` BOOLEAN COMMENT 'Indicates whether this team member is designated as the account team lead responsible for coordinating all team activities, internal escalations, and customer review cadences.',
    `job_title` STRING COMMENT 'The official job title of the Manufacturing employee as defined in Workday HCM. Provides context for the team members seniority and functional expertise relative to their account team role.',
    `last_customer_interaction_date` DATE COMMENT 'The date of the most recent logged interaction between this team member and the customer account (e.g., call, meeting, site visit). Used for relationship health monitoring and engagement cadence compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this account team assignment record was most recently updated in the source system. Used for change tracking, incremental data loading, and audit compliance.',
    `next_scheduled_review_date` DATE COMMENT 'The date of the next planned business review or customer engagement activity for this team member and account. Supports proactive relationship management and SLA compliance tracking.',
    `opportunity_access` STRING COMMENT 'The level of access granted to this team member for opportunity records associated with the customer account. Governs visibility into pipeline, deal stages, and revenue forecasts.. Valid values are `none|read_only|read_write`',
    `quota_amount` DECIMAL(18,2) COMMENT 'The revenue quota assigned to this team member for the associated customer account, expressed in the base currency. Used for sales performance tracking, incentive compensation, and KPI reporting.',
    `quota_currency` STRING COMMENT 'The ISO 4217 three-letter currency code for the quota amount assigned to this account team member (e.g., USD, EUR, GBP). Supports multi-currency reporting for global sales operations.. Valid values are `^[A-Z]{3}$`',
    `quota_period` STRING COMMENT 'The time period over which the assigned quota is measured (e.g., annual, quarterly). Aligns with the sales planning cycle and incentive compensation structure.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `sales_district` STRING COMMENT 'The sales district within the sales region to which this account team assignment is mapped. Provides sub-regional granularity for territory coverage analysis and quota assignment.',
    `sales_region` STRING COMMENT 'The geographic sales region to which this account team assignment belongs (e.g., North America, EMEA, APAC). Used for regional performance reporting and territory management.',
    `sla_tier` STRING COMMENT 'The SLA tier applicable to this account team assignment, defining the response time commitments and service quality standards the team member is accountable for delivering to the customer.. Valid values are `platinum|gold|silver|bronze|standard`',
    `start_date` DATE COMMENT 'The date on which the internal team members assignment to this customer account became effective. Used for tracking tenure, coverage continuity, and SLA accountability.',
    `team_member_role` STRING COMMENT 'The functional role of the internal Manufacturing employee on this customer account team. Defines responsibilities such as commercial ownership, technical pre-sales, post-sales support, or executive relationship management. [ENUM-REF-CANDIDATE: Account Manager|Field Sales Engineer|Application Engineer|Customer Success Manager|Executive Sponsor|Inside Sales Representative|Technical Support Engineer — promote to reference product]',
    `termination_reason` STRING COMMENT 'Free-text description of the reason this account team assignment was ended (e.g., employee departure, territory restructuring, account transfer, role elimination). Populated only when assignment_status is terminated.',
    CONSTRAINT pk_account_team PRIMARY KEY(`account_team_id`)
) COMMENT 'Assignment of internal Manufacturing personnel to customer accounts, defining the account team structure including account managers, field sales engineers, application engineers, customer success managers, and executive sponsors. Captures team member role, assignment start date, end date, primary contact flag, and territory assignment. Maps to Salesforce CRM Account Team Member.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` (
    `customer_onboarding_id` BIGINT COMMENT 'Unique system-generated identifier for the customer onboarding record. Primary key for the onboarding data product in the customer domain.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account being onboarded. Links this onboarding record to the master customer entity.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee assigned as the onboarding coordinator responsible for managing the activation workflow.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the signed contract that triggered the onboarding workflow. Onboarding begins upon contract signature.',
    `account_segment` STRING COMMENT 'Business segment classification of the customer account, used to prioritize onboarding resources and apply segment-specific SLA targets.. Valid values are `enterprise|mid_market|small_business|government`',
    `account_type` STRING COMMENT 'Classification of the customer account being onboarded. Determines the onboarding workflow template and requirements applied. OEM (Original Equipment Manufacturer), distributor, end-user, reseller, or strategic account.. Valid values are `oem|distributor|end_user|reseller|strategic`',
    `actual_completion_date` DATE COMMENT 'The actual date on which the customer onboarding was fully completed and the account achieved first-order readiness. Null if onboarding is still in progress.',
    `assigned_sales_region` STRING COMMENT 'The sales region to which the customer account is assigned, used for coordinator assignment, reporting, and regional SLA management.',
    `blocker_category` STRING COMMENT 'Categorical classification of the onboarding blocker type, enabling root cause analysis and process improvement reporting across the onboarding program. [ENUM-REF-CANDIDATE: credit|compliance|edi_technical|erp_setup|customer_response|internal_process|none — 7 candidates stripped; promote to reference product]',
    `blocker_description` STRING COMMENT 'Free-text description of any current impediment or blocker preventing the onboarding from progressing. Captures the nature of the issue for escalation and resolution tracking.',
    `checklist_completion_pct` DECIMAL(18,2) COMMENT 'The percentage of onboarding checklist items that have been marked as completed. Provides a quantitative measure of onboarding progress (0.00 to 100.00).',
    `completed_checklist_items` STRING COMMENT 'The number of onboarding checklist items that have been completed and verified. Numerator for checklist completion percentage.',
    `compliance_check_status` STRING COMMENT 'Status of mandatory regulatory and trade compliance screening for the new customer, including export control, sanctions screening, and anti-bribery checks.. Valid values are `pending|passed|failed|waived`',
    `contract_signature_date` DATE COMMENT 'The date on which the customer signed the contract, marking the official start trigger for the onboarding workflow.',
    `credit_limit_approved` DECIMAL(18,2) COMMENT 'The approved credit limit amount (in base currency) assigned to the customer account during onboarding. Established by the finance team as part of credit setup.',
    `credit_setup_status` DECIMAL(18,2) COMMENT 'Current status of the credit limit and payment terms setup for the new customer account in SAP S/4HANA FI. A prerequisite for first order processing.',
    `customer_primary_contact_email` STRING COMMENT 'Email address of the primary contact person at the customer organization for onboarding communications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the customer organization responsible for coordinating the onboarding process on the customer side.',
    `edi_setup_status` STRING COMMENT 'Current status of the Electronic Data Interchange (EDI) integration setup for the customer. Tracks configuration, testing, and go-live of EDI order transmission channels.. Valid values are `not_required|pending|in_progress|testing|completed|failed`',
    `erp_account_created_flag` BOOLEAN COMMENT 'Indicates whether the customer master record has been successfully created in SAP S/4HANA. A mandatory prerequisite for order processing and invoicing.',
    `erp_customer_number` STRING COMMENT 'The customer account number assigned in SAP S/4HANA upon master data creation. Used to link the onboarding record to the ERP customer master.',
    `escalation_date` DATE COMMENT 'The date on which the onboarding case was formally escalated. Null if no escalation has occurred.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the onboarding case has been formally escalated to management due to a blocker, SLA risk, or customer dissatisfaction.',
    `export_control_classification` STRING COMMENT 'Export control compliance classification for the customer, indicating whether the account is cleared for shipment of controlled goods under applicable trade regulations.. Valid values are `approved|restricted|embargoed|pending_review`',
    `first_order_date` DATE COMMENT 'The date on which the customer placed their first order following successful onboarding. Used to measure time-to-revenue and validate onboarding effectiveness.',
    `first_order_readiness_flag` BOOLEAN COMMENT 'Indicates whether all onboarding prerequisites have been met and the customer account is fully ready to place and process its first order. The primary success criterion for onboarding completion.',
    `industry_vertical` STRING COMMENT 'The industry sector of the customer being onboarded (e.g., automotive, aerospace, food and beverage, energy, logistics). Used to apply industry-specific onboarding requirements and compliance checks. [ENUM-REF-CANDIDATE: automotive|aerospace|food_beverage|energy|logistics|electronics|pharma|construction — promote to reference product]',
    `initiated_timestamp` TIMESTAMP COMMENT 'The exact date and time when the onboarding record was created and the activation workflow was formally initiated in the system.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the onboarding record was last modified. Used for audit trail and change tracking in the Silver layer.',
    `nda_signed_flag` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) has been executed with the customer. Required for OEM and strategic accounts before sharing proprietary product or engineering data.',
    `notes` STRING COMMENT 'Free-text field for the onboarding coordinator to capture additional context, special instructions, customer-specific requirements, or internal observations relevant to the onboarding case.',
    `onboarding_number` STRING COMMENT 'Externally visible, human-readable reference number for the onboarding case, used in communications with the customer and internal teams. Format: ONB-YYYY-NNNNNN.. Valid values are `^ONB-[0-9]{4}-[0-9]{6}$`',
    `onboarding_status` STRING COMMENT 'Current lifecycle state of the onboarding workflow. Tracks progression from initiation through full account activation. Values: not_started, in_progress, on_hold, completed, cancelled.. Valid values are `not_started|in_progress|on_hold|completed|cancelled`',
    `payment_terms_code` DECIMAL(18,2) COMMENT 'The SAP payment terms code assigned to the customer account (e.g., NET30, NET60, 2/10NET30). Defines the payment schedule and early payment discount terms.',
    `portal_setup_status` STRING COMMENT 'Current status of the customer self-service portal account provisioning, including login credentials, access rights, and order management capabilities.. Valid values are `not_required|pending|in_progress|completed|failed`',
    `pricing_setup_status` STRING COMMENT 'Current status of the customer-specific pricing configuration in SAP S/4HANA SD, including contract pricing, volume discounts, and special pricing agreements.. Valid values are `pending|in_progress|completed|approved`',
    `quality_agreement_signed_flag` BOOLEAN COMMENT 'Indicates whether a formal quality agreement has been signed with the customer, defining quality standards, inspection requirements, and CAPA (Corrective and Preventive Action) processes.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the onboarding has breached or is at risk of breaching the agreed SLA target completion date. True if the actual or projected completion date exceeds the SLA target.',
    `sla_target_days` STRING COMMENT 'The contractually or operationally agreed number of calendar days within which the onboarding must be completed from contract signature. Drives SLA compliance reporting.',
    `stage` STRING COMMENT 'Current named stage within the onboarding workflow, representing the active phase of the structured activation process (e.g., Contract Review, Credit Setup, System Configuration, Training, First Order Readiness). [ENUM-REF-CANDIDATE: contract_review|credit_setup|erp_account_creation|edi_portal_setup|pricing_setup|training|first_order_readiness — promote to reference product]',
    `target_completion_date` DATE COMMENT 'The planned date by which the customer onboarding should be fully completed and the account should be first-order ready. Used for SLA tracking and coordinator workload management.',
    `tax_exemption_certificate_number` STRING COMMENT 'The official certificate number of the customers tax exemption document. Required for tax-exempt account configuration in SAP S/4HANA FI.',
    `tax_exemption_flag` BOOLEAN COMMENT 'Indicates whether the customer has a valid tax exemption certificate on file. Affects tax configuration in SAP S/4HANA during account setup.',
    `template_code` STRING COMMENT 'The code identifying the onboarding workflow template applied to this account. Templates vary by account type (OEM, distributor, end-user) and define the required checklist items and stage sequence.',
    `total_checklist_items` DECIMAL(18,2) COMMENT 'The total number of onboarding checklist items applicable to this customer account, based on account type and segment. Denominator for checklist completion percentage.',
    `training_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer has completed all required product, portal, and ordering process training sessions as part of the onboarding checklist.',
    `training_completion_date` DATE COMMENT 'The date on which the customer completed all mandatory onboarding training sessions. Null if training has not yet been completed.',
    CONSTRAINT pk_customer_onboarding PRIMARY KEY(`customer_onboarding_id`)
) COMMENT 'Customer onboarding process records tracking the structured activation workflow for new industrial accounts from contract signature through first order readiness. Captures onboarding stage, checklist completion status, credit setup status, EDI/portal setup status, assigned onboarding coordinator, target completion date, actual completion date, and blockers. Ensures new OEM and distributor accounts are fully operational.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` (
    `customer_document_id` BIGINT COMMENT 'System-generated unique identifier for each customer document record.',
    `account_site_id` BIGINT COMMENT 'Identifier of the specific site or plant associated with the document.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account to which the document belongs.',
    `customer_contact_id` BIGINT COMMENT 'Identifier of the primary contact person responsible for the document.',
    `order_header_id` BIGINT COMMENT 'Identifier of the sales order that requires this document.',
    `employee_id` BIGINT COMMENT 'Employee responsible for the documents content and lifecycle.',
    `primary_customer_employee_id` BIGINT COMMENT 'Identifier of the employee who created the document record.',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the contract that references this document.',
    `superseded_customer_document_id` BIGINT COMMENT 'Self-referencing FK on customer_document (superseded_customer_document_id)',
    `approval_status` STRING COMMENT 'Approval workflow status of the document.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the document received final approval.',
    `checksum` STRING COMMENT 'SHA‑256 hash of the file for integrity verification.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the document against the referenced regulation.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `customer_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|active|superseded|archived`',
    `customer_document_description` STRING COMMENT 'Free‑form description of the document content and purpose.',
    `document_category` STRING COMMENT 'High‑level business category of the document.. Valid values are `technical|legal|compliance|marketing`',
    `document_type` STRING COMMENT 'Category of the document defining its business purpose. [ENUM-REF-CANDIDATE: edi_mapping|purchase_drawing|engineering_spec|qualification_package|rohs_declaration|supplier_quality_manual|blanket_po_terms|customs_document — 8 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which the document is considered legally effective.',
    `expiry_date` DATE COMMENT 'Date after which the document is no longer valid.',
    `file_name` STRING COMMENT 'Original file name as stored in the document management system.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the document contains confidential information.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the document is mandatory for the associated account or process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `mime_type` STRING COMMENT 'Internet media type of the stored file.. Valid values are `application/pdf|image/png|image/jpeg|text/plain|application/msword`',
    `regulatory_requirement_reference` STRING COMMENT 'Reference code of the regulatory requirement that mandates this document.',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained for compliance.',
    `status_reason` STRING COMMENT 'Explanation for the current status, e.g., reason for supersession.',
    `tags` STRING COMMENT 'Comma‑separated business tags for classification and search.',
    `title` STRING COMMENT 'Human‑readable title of the document.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the document was uploaded to the system.',
    `version_comment` STRING COMMENT 'Free‑form comment describing changes in this version.',
    `version_number` STRING COMMENT 'Version identifier following the companys versioning scheme (e.g., v1.0, v2.3).',
    CONSTRAINT pk_customer_document PRIMARY KEY(`customer_document_id`)
) COMMENT 'Customer-specific documents and files exchanged during qualification, onboarding, and ongoing commercial operations in industrial B2B relationships. Captures document type (EDI mapping specification, purchase drawing, engineering specification, qualification package, RoHS/REACH declaration, supplier quality manual, blanket PO terms, customs documentation), document title, version number, file reference, upload date, effective date, expiry date, document status (draft, active, superseded, archived), associated account, associated site, and responsible contact. Serves as the SSOT for all customer-furnished documentation required for order processing, manufacturing, and compliance in industrial automation and electrification supply chains.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_parent_account_customer_account_id` FOREIGN KEY (`parent_account_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_primary_ultimate_parent_account_customer_account_id` FOREIGN KEY (`primary_ultimate_parent_account_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_primary_customer_account_id` FOREIGN KEY (`primary_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_customer_entitlement_id` FOREIGN KEY (`customer_entitlement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_entitlement`(`customer_entitlement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_primary_customer_account_id` FOREIGN KEY (`primary_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ADD CONSTRAINT `fk_customer_customer_lead_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ADD CONSTRAINT `fk_customer_customer_certification_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ADD CONSTRAINT `fk_customer_customer_certification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ADD CONSTRAINT `fk_customer_customer_entitlement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ADD CONSTRAINT `fk_customer_customer_entitlement_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ADD CONSTRAINT `fk_customer_customer_onboarding_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ADD CONSTRAINT `fk_customer_customer_document_superseded_customer_document_id` FOREIGN KEY (`superseded_customer_document_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_document`(`customer_document_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Account Manager ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `primary_ultimate_parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_source` SET TAGS ('dbx_business_glossary_term' = 'Account Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|suspended|terminated|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'OEM|distributor|system_integrator|end_user|EPC_contractor|reseller');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `industry_naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `industry_naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `industry_sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `industry_sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `is_global_account` SET TAGS ('dbx_business_glossary_term' = 'Global Account Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `is_strategic_account` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sap_business_partner_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Business Partner (BP) ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `status_date` SET TAGS ('dbx_business_glossary_term' = 'Account Status Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name (DBA — Doing Business As)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Customer Website URL');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `website` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Owner Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `account_site` SET TAGS ('dbx_business_glossary_term' = 'Contact Account Site');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Assistant Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Assistant Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_business_glossary_term' = 'Contact Date of Birth');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `consent_record_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `consent_record_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'technical_evaluator|commercial_buyer|executive_approver|end_user|influencer|other');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `customer_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `customer_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|do_not_contact|pending_verification|deceased');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Contact Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Business Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-Out Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `fax` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `fax` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `fax` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `fax` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `gdpr_data_subject_code` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Subject ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `gdpr_data_subject_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `gdpr_data_subject_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Preferred Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Activity Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Contact Lead Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_state` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Street Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Consent Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Consent Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mdm_golden_record_code` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mdm_golden_record_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `persona` SET TAGS ('dbx_business_glossary_term' = 'Contact Persona');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Business Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|in_person|video_call|portal');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_contact` ALTER COLUMN `technical_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `primary_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'strategic|key|standard|transactional');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `consolidation_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Consolidation Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `controlling_interest` SET TAGS ('dbx_business_glossary_term' = 'Controlling Interest Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `credit_rollup_eligible` SET TAGS ('dbx_business_glossary_term' = 'Credit Roll-Up Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `crm_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Hierarchy ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `erp_customer_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Customer Hierarchy Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_category` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Category');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_category` SET TAGS ('dbx_value_regex' = 'legal|commercial|operational|reporting');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_value_regex' = '^AH-[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `mdm_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Hierarchy ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `pricing_rollup_eligible` SET TAGS ('dbx_business_glossary_term' = 'Pricing Roll-Up Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'subsidiary|division|affiliate|joint_venture|distributor|franchise');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `revenue_rollup_eligible` SET TAGS ('dbx_business_glossary_term' = 'Revenue Roll-Up Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `sla_inherited` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Inherited Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_hierarchy` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `assigned_segment_manager` SET TAGS ('dbx_business_glossary_term' = 'Assigned Segment Manager');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'Direct|Indirect|Hybrid');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `contract_required` SET TAGS ('dbx_business_glossary_term' = 'Contract Required');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (USD)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `crm_segment_record_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Segment Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `crm_segment_record_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `customer_account_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `customer_account_type` SET TAGS ('dbx_value_regex' = 'OEM|Distributor|End User|System Integrator|EPC');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `dedicated_account_manager_required` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Account Manager Required');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Description');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `erp_customer_group_code` SET TAGS ('dbx_business_glossary_term' = 'ERP (Enterprise Resource Planning) Customer Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `erp_customer_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `max_account_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Account Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `mdm_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Segment ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `mdm_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `min_account_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Account Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `moq_applicable` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Applicable');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `nda_required` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Required');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Segment Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `pricing_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `pricing_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `pricing_tier_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `rebate_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rebate Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band Currency');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_max` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band Maximum');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_min` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band Minimum');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Segment Review Cycle (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Under Review|Archived');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'Strategic|Key Account|Growth|Transactional');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `service_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Service Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `service_priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Standard|Basic');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `sla_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `sla_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `strategic_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `target_gross_margin_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `target_gross_margin_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `target_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Revenue (USD)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `target_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|headquarters|plant_site|mailing|field_service');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `attention_line` SET TAGS ('dbx_business_glossary_term' = 'Attention Line');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `attention_line` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_ssot_ref' = 'customer.address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_ssot' = 'reference.country.country_code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `county_district` SET TAGS ('dbx_business_glossary_term' = 'County / District');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `county_district` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `county_district` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Address Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Accuracy Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate|ungeocoded');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `is_validated` SET TAGS ('dbx_business_glossary_term' = 'Address Validated Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Address Label');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639-1)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geocoordinate)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `loading_dock_available` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Available Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geocoordinate)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Address Key');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_mdm_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_ssot_ref' = 'production.plant');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_ssot' = 'production.plant.plant_code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_denorm_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_normalize' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Extension (ZIP+4)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room / Suite Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_ssot_ref' = 'sales.territory');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_ssot' = 'sales.territory.region_code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_denorm_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_normalize' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_ssot_ref' = 'service.zone');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_ssot' = 'service.zone.territory_code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_denorm_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_normalize' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'standard|express|freight|ltl|ftl|will_call');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Address ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_denorm_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_SSOT' = 'source_system');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_normalize' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_ssot_ref' = 'finance.company_code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_denormalized' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_ssot' = 'finance.tax_determination.jurisdiction_code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_denorm_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_normalize' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_value_regex' = 'usps_cass|google_maps|here_api|informatica_mdm|manual|unvalidated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Authority');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `bad_debt_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Provision Amount');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `bad_debt_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `bank_account_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Verified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `bank_account_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `bank_account_verified_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `collection_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Strategy Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_account_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_released_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Released Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage Limit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Policy Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Provider');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_segment` SET TAGS ('dbx_business_glossary_term' = 'Credit Segment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_utilization_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `dso_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `dso_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `early_payment_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `last_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `oldest_overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Oldest Overdue Days');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Amount');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_behavior_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Behavior Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_behavior_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Category');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|watch_list');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Customer Account Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `customer_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Entitlement ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SLA-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Agreement Amendment Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `annual_fee` SET TAGS ('dbx_business_glossary_term' = 'SLA Annual Fee');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `annual_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'SLA Billing Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|one_time');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `contract_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'SLA Contract Value');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `covered_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Covered Asset Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `field_service_included` SET TAGS ('dbx_business_glossary_term' = 'Field Service Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `initial_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Initial Response Time Threshold (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `max_annual_service_visits` SET TAGS ('dbx_business_glossary_term' = 'Maximum Annual Service Visits');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SLA Agreement Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `parent_contract_ref` SET TAGS ('dbx_business_glossary_term' = 'Parent Contract Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `penalty_cap_pct` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `penalty_clause_applicable` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Applicable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `penalty_credit_pct` SET TAGS ('dbx_business_glossary_term' = 'Penalty Service Credit Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `preventive_maintenance_included` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `product_line_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Line Scope');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `remote_monitoring_included` SET TAGS ('dbx_business_glossary_term' = 'Remote Monitoring Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Threshold (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `service_region` SET TAGS ('dbx_business_glossary_term' = 'Service Region (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `service_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Service Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'Platinum|Gold|Silver|Bronze');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'response_time|uptime_guarantee|on_time_delivery|support_entitlement|maintenance_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `spare_parts_included` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `support_hours_coverage` SET TAGS ('dbx_business_glossary_term' = 'Support Hours Coverage Window');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `support_hours_coverage` SET TAGS ('dbx_value_regex' = '8x5|12x5|16x5|24x7|24x5');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Agreement Termination Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'SLA Agreement Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'customer_request|non_payment|breach_of_contract|mutual_agreement|product_discontinuation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `uptime_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Uptime Guarantee Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SLA Agreement Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `account_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Account Relationship ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `primary_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `crm_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'CRM Relationship ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `erp_customer_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'ERP Customer Hierarchy ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `is_global_account` SET TAGS ('dbx_business_glossary_term' = 'Is Global Account Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `is_strategic_partner` SET TAGS ('dbx_business_glossary_term' = 'Is Strategic Partner Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `mdm_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Relationship ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal|in_person|video_conference');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `primary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `primary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Health Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_name` SET TAGS ('dbx_business_glossary_term' = 'Relationship Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_number` SET TAGS ('dbx_business_glossary_term' = 'Relationship Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_number` SET TAGS ('dbx_value_regex' = '^REL-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source System');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_s4hana|manual|migration|ariba');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_subtype` SET TAGS ('dbx_business_glossary_term' = 'Relationship Subtype');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'hierarchy|commercial');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization (Sales Org) Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `strategic_importance_rating` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'contract_expiry|mutual_agreement|breach|acquisition|restructuring|other');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_relationship` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Owner Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `capa_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|virtual|survey|web_portal');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Interaction Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Activity ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_description` SET TAGS ('dbx_business_glossary_term' = 'Interaction Description');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `external_participants` SET TAGS ('dbx_business_glossary_term' = 'External Participants');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `external_participants` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Interaction Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `internal_participants` SET TAGS ('dbx_business_glossary_term' = 'Internal Participants');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `is_customer_complaint` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `is_executive_sponsor_involved` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Involvement Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Interaction Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Location Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'customer_site|company_office|trade_show|virtual|factory_floor|neutral_venue');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `next_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Next Planned Interaction Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|pending|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Total Participant Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line Discussed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Health Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `sentiment_category` SET TAGS ('dbx_business_glossary_term' = 'Interaction Sentiment Category');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `sentiment_category` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Interaction Record Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|manual_entry|email_integration|calendar_sync|survey_platform');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Verbatim Feedback');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `customer_lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Interested Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `annual_energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption (MWh)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `annual_energy_consumption_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `buying_stage` SET TAGS ('dbx_business_glossary_term' = 'Buying Stage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `buying_stage` SET TAGS ('dbx_value_regex' = 'Awareness|Consideration|Evaluation|Decision|Not Determined');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Lead City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_industry` SET TAGS ('dbx_business_glossary_term' = 'Lead Company Industry Sector');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Company Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_size` SET TAGS ('dbx_business_glossary_term' = 'Lead Company Employee Size Band');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `company_size` SET TAGS ('dbx_value_regex' = '1-50|51-200|201-1000|1001-5000|5001+');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Conversion Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Lead Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'Salesforce CRM|SAP S/4HANA|Manual Entry|Data Enrichment|Marketing Automation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Lead Disqualification Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Lead Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-Out Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `estimated_close_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Value');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `existing_automation_vendor` SET TAGS ('dbx_business_glossary_term' = 'Existing Automation Vendor');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `existing_automation_vendor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Contact First Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `first_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Lead Grade');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Lead Converted Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Lead Contact Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Contact Last Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `last_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Channel');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_value_regex' = 'New|Working|Qualified|Converted|Disqualified');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_value_regex' = 'Inbound|Outbound|Partner|OEM|Distributor|End User');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `no_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number of Employees');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `no_of_production_sites` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Sites');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Lead Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `plc_installed_base` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) Installed Base');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `plc_installed_base` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `product_interest_area` SET TAGS ('dbx_business_glossary_term' = 'Product Interest Area');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `referral_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Partner Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `referral_partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `referral_partner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `referral_partner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'North America|Europe|Asia Pacific|Latin America|Middle East & Africa');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `sales_territory` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `salesforce_lead_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Lead ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Lead State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Lead Company Website URL');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_lead` ALTER COLUMN `website` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Site Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Site Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Site Access Restriction Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Site City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Site Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Site Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `crm_site_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Site Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Site Environmental Classification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_value_regex' = 'standard|controlled|outdoor|corrosive|high_temperature|high_humidity');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Site Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `installed_product_count` SET TAGS ('dbx_business_glossary_term' = 'Installed Product Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `is_headquarters` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Site Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `last_site_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Site Visit Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Management Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `mes_system_present` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Present Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Site Network Connectivity Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_value_regex' = 'ethernet|fiber|wireless|cellular|vpn|none');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Preventive Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `number_of_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Lines');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operates_24x7` SET TAGS ('dbx_business_glossary_term' = '24x7 Operations Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours End Time');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `plant_floor_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Plant Floor Area (Square Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `power_supply_frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Site Power Supply Frequency (Hz)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `power_supply_voltage` SET TAGS ('dbx_business_glossary_term' = 'Site Power Supply Voltage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Site Safety Classification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|restricted_access|cleanroom|explosion_proof');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `scada_system_present` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System Present Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Site Criticality Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|decommissioned|under_construction|suspended|planned');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing_plant|warehouse|distribution_center|data_center|commercial_building|substation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Site State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Site Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot_group' = 'certification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot_master' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot_of' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot_subject' = 'customer_site_certification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_duplicate_resolution' = 'subject_partition');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_product_conformity_ssot' = 'product.product_certification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `customer_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Certification ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `applicable_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Categories');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `body_country` SET TAGS ('dbx_business_glossary_term' = 'Certification Body Country');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `body_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'CAPA Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `ce_marking_applicable` SET TAGS ('dbx_business_glossary_term' = 'CE Marking Applicable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|withdrawn|pending_renewal|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Certification Country');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `initial_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Certification Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `is_multi_site` SET TAGS ('dbx_business_glossary_term' = 'Is Multi-Site Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `is_primary_certification` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `issuing_body_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Accreditation Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `issuing_body_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `issuing_body_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `issuing_body_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `last_surveillance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Surveillance Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `next_surveillance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Surveillance Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `qualification_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Qualification Eligibility Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `qualification_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|conditional|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Renewal Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|in_progress|submitted|approved|lapsed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `ul_listing_number` SET TAGS ('dbx_business_glossary_term' = 'UL Listing Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual_review|online_registry|third_party_audit|self_declaration');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `auto_renew` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Entitlement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `contract_line_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted Entitlement Value');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `contracted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `coverage_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|parts_only');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending_activation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement End Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_value_regex' = '^ENT-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'warranty|support_incident|preventive_maintenance|software_update|spare_parts_access');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `geography_region` SET TAGS ('dbx_business_glossary_term' = 'Geography Region');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `is_perpetual` SET TAGS ('dbx_business_glossary_term' = 'Is Perpetual Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_pii_kind' = 'person_name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `customer_entitlement_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `parts_access_eligible` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Access Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `preventive_maintenance_visits` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Visits Allocated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `preventive_maintenance_visits_used` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Visits Used');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Quantity Unit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'incident|visit|license|hour|unit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Entitlement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Renewal Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `service_hours_allocation` SET TAGS ('dbx_business_glossary_term' = 'Service Hours Allocation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `service_hours_consumed` SET TAGS ('dbx_business_glossary_term' = 'Service Hours Consumed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `software_update_eligible` SET TAGS ('dbx_business_glossary_term' = 'Software Update Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `spare_parts_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Credit Limit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `spare_parts_credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Entitlement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_entitlement` ALTER COLUMN `warranty_claim_eligible` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `account_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `account_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `account_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Account Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read_only|read_write|full_access');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|interim|coverage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `case_access` SET TAGS ('dbx_business_glossary_term' = 'Case Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `case_access` SET TAGS ('dbx_value_regex' = 'none|read_only|read_write');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `contact_access` SET TAGS ('dbx_business_glossary_term' = 'Contact Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `contact_access` SET TAGS ('dbx_value_regex' = 'none|read_only|read_write');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `coverage_country_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `coverage_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `crm_owner_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Record Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `crm_team_member_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Team Member ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `crm_team_member_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `crm_team_member_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_s4hana|workday_hcm|manual_entry');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `effective_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `engagement_model` SET TAGS ('dbx_business_glossary_term' = 'Customer Engagement Model');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `engagement_model` SET TAGS ('dbx_value_regex' = 'strategic|transactional|self_service|partner_managed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `is_current_record` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `is_executive_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `is_team_lead` SET TAGS ('dbx_business_glossary_term' = 'Team Lead Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `last_customer_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Customer Interaction Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `next_scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `opportunity_access` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `opportunity_access` SET TAGS ('dbx_value_regex' = 'none|read_only|read_write');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Amount');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `quota_currency` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `quota_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `quota_period` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `sales_district` SET TAGS ('dbx_business_glossary_term' = 'Sales District');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `team_member_role` SET TAGS ('dbx_business_glossary_term' = 'Account Team Member Role');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_team` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Coordinator ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `account_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `account_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|small_business|government');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'oem|distributor|end_user|reseller|strategic');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `assigned_sales_region` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Region');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `blocker_category` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Blocker Category');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `blocker_description` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Blocker Description');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `checklist_completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Checklist Completion Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `completed_checklist_items` SET TAGS ('dbx_business_glossary_term' = 'Completed Checklist Items');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `contract_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signature Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `credit_limit_approved` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `credit_limit_approved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `credit_setup_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Setup Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `customer_primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `edi_setup_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Setup Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `edi_setup_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|testing|completed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `erp_account_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Account Created Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `erp_customer_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Customer Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'approved|restricted|embargoed|pending_review');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `first_order_date` SET TAGS ('dbx_business_glossary_term' = 'First Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `first_order_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'First Order Readiness Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Initiated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `nda_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Signed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `onboarding_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `onboarding_number` SET TAGS ('dbx_value_regex' = '^ONB-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `portal_setup_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Portal Setup Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `portal_setup_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `pricing_setup_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Setup Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `pricing_setup_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|approved');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `quality_agreement_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Signed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `tax_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Template Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `total_checklist_items` SET TAGS ('dbx_business_glossary_term' = 'Total Checklist Items');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_onboarding` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `customer_document_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Document ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Owner Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `primary_customer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `primary_customer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `primary_customer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Related Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `superseded_customer_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Customer Document Id');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `superseded_customer_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (SHA‑256)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `customer_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `customer_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|archived');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `customer_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'technical|legal|compliance|marketing');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `file_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'MIME Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `mime_type` SET TAGS ('dbx_value_regex' = 'application/pdf|image/png|image/jpeg|text/plain|application/msword');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Document Tags');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `version_comment` SET TAGS ('dbx_business_glossary_term' = 'Version Comment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
