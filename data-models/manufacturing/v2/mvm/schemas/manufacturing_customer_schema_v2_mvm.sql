-- Schema for Domain: customer | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`customer` COMMENT 'Customer identity and account management domain serving as the SSOT for all B2B industrial customers, OEM accounts, distributors, and end-user organizations. Manages customer profiles, contacts, account hierarchies, segmentation, credit terms, relationship history, and SLA agreements via Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique surrogate identifier for the customer account record in the Databricks Silver Layer. Primary key for the customer_account master data product. Serves as the SSOT reference key for all downstream domains including sales, service, order, and billing.',
    `parent_account_customer_account_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent customer_account record in the corporate hierarchy. Enables multi-level account hierarchy modeling (e.g., subsidiary → division → global parent). Null for top-level accounts.',
    `price_book_id` BIGINT COMMENT 'Identifier of the SAP S/4HANA pricing condition group or price list assigned to this customer. Determines applicable pricing, discounts, and surcharges during sales order creation.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Primary sales rep on an account drives quota allocation, forecasting, and territory performance metrics in industrial manufacturing.',
    `primary_ultimate_parent_account_customer_account_id` BIGINT COMMENT 'Identifier of the topmost entity in the corporate hierarchy for this customer account. Supports global account consolidation, enterprise-level revenue reporting, and strategic account management.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Linking account to its segment enables normalization of segment data and removes redundant string field.',
    `account_source` STRING COMMENT 'Channel or method through which this customer account was originally acquired. Used for marketing attribution, channel effectiveness analysis, and sales pipeline reporting. [ENUM-REF-CANDIDATE: direct_sales|referral|trade_show|inbound_marketing|partner|acquisition|existing_relationship — 7 candidates stripped; promote to reference product]',
    `account_status` STRING COMMENT 'Current lifecycle state of the customer account. Controls whether transactions, orders, and service requests can be processed against this account. Managed in Salesforce CRM and synchronized to SAP S/4HANA.. Valid values are `active|inactive|prospect|suspended|terminated|on_hold`',
    `account_type` STRING COMMENT 'Classification of the customers commercial role in the industrial supply chain. Drives pricing tiers, contract templates, and service entitlements. [ENUM-REF-CANDIDATE: OEM|distributor|system_integrator|end_user|EPC_contractor|reseller|value_added_reseller|direct — promote to reference product if additional types are needed]. Valid values are `OEM|distributor|system_integrator|end_user|EPC_contractor|reseller`',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Customer organizations most recently reported annual revenue in the accounts local currency. Used for customer segmentation, credit risk assessment, and strategic account classification. Currency indicated by revenue_currency_code.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Required for linking each customer account to its billing account for invoice generation and financial reporting, a core process in manufacturing finance.',
    `billing_city` STRING COMMENT 'City of the customers primary billing address. Used for geographic segmentation, logistics planning, and tax jurisdiction determination.',
    `billing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the customers primary billing address country. Used for tax jurisdiction determination, regulatory compliance, and geographic segmentation.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the customers primary billing address. Used for tax jurisdiction mapping, logistics routing, and geographic analytics.',
    `billing_state_province` STRING COMMENT 'State or province of the customers primary billing address. Used for tax jurisdiction determination, sales territory assignment, and regional reporting.',
    `close_date` DATE COMMENT 'Date on which the customer account was formally closed or terminated. Null for active accounts. Used for churn analysis, lifecycle reporting, and regulatory record retention.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer account record was first created in the source system of record (Salesforce CRM). Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance permitted for this customer account, denominated in the accounts billing currency. Enforced in SAP S/4HANA SD order processing and credit management workflows.',
    `credit_limit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the credit_limit field. Ensures correct interpretation of the credit limit in multi-currency environments.. Valid values are `^[A-Z]{3}$`',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the customer by an internal credit team or external agency (e.g., Dun & Bradstreet, Moodys). Used to determine credit limits, payment terms, and order approval workflows in SAP S/4HANA FI.',
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
    `revenue_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual_revenue field (e.g., USD, EUR, GBP). Required to correctly interpret the revenue figure for multi-currency global accounts.. Valid values are `^[A-Z]{3}$`',
    `sales_organization_code` STRING COMMENT 'SAP S/4HANA sales organization code responsible for selling to this customer. Determines the legal entity, currency, and pricing procedures applicable to sales transactions.',
    `sap_business_partner_code` STRING COMMENT 'Business Partner number assigned in SAP S/4HANA (SD/FI modules). Enables cross-system reconciliation between Salesforce CRM and SAP ERP for order-to-cash and accounts receivable processes.',
    `sla_tier` STRING COMMENT 'SLA tier assigned to this customer account, defining the service response times, support priority, and escalation paths applicable to service requests and after-sales support. Managed in Salesforce Service Cloud.. Valid values are `platinum|gold|silver|bronze|standard`',
    `status_date` DATE COMMENT 'Date on which the current account_status became effective. Supports lifecycle history tracking and audit compliance. Used to calculate duration in current status for account health reporting.',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the customers legal entity (e.g., EIN in the US, CRN in the UK). Required for invoicing, tax reporting, and regulatory compliance under IFRS/GAAP.',
    `trading_name` STRING COMMENT 'Commercial or brand name under which the customer operates if different from the legal entity name. Used in sales communications, account management, and CRM displays.',
    `vat_registration_number` STRING COMMENT 'VAT registration number for the customer entity, required for EU and international tax compliance. Used in invoice generation and cross-border transaction reporting.',
    `website` STRING COMMENT 'Official website URL of the customer organization. Used for account research, digital engagement tracking, and customer profile enrichment.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Master record for all B2B industrial customers, OEM accounts, distributors, and end-user organizations. Serves as the SSOT for customer identity in Salesforce CRM (Account object) and SAP Business Partner. Captures legal entity name, industry classification (SIC/NAICS), account type (OEM, distributor, system integrator, end-user, EPC contractor), account status with full lifecycle history, annual revenue, employee count, DUNS number, tax ID, VAT registration, credit rating, assigned account manager, parent account reference, and strategic account flag. Foundation entity referenced by all other products in this domain and cross-referenced by sales, service, order, and billing domains. Corporate hierarchy and commercial relationships are managed in account_relationship.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique surrogate identifier for the contact record in the Databricks Silver Layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `customer_account_id` BIGINT COMMENT 'Reference to the parent B2B customer account (OEM, distributor, or end-user organization) to which this contact belongs. Establishes the person-to-account relationship.',
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
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual person records associated with customer accounts representing key stakeholders at B2B industrial organizations — including design engineers, procurement managers, plant managers, maintenance supervisors, and executive sponsors. Maps to Salesforce CRM Contact object. Captures full name, job title, department, phone, email, preferred communication channel, language preference, marketing consent status, decision-making role (technical evaluator, commercial buyer, executive approver), and active/inactive status. Serves as the SSOT for person-level engagement across sales, service, and marketing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate identifier for the customer segment record in the Databricks Silver Layer. Serves as the primary key for all downstream joins and references.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: In manufacturing, customer segments are mapped to specific price books to drive segment-based pricing strategy and automated price book assignment. segment carries pricing_tier_code and discount_rate_',
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
    `payment_terms_code` STRING COMMENT 'SAP S/4HANA payment terms code (e.g., NT30, NT60, 2/10NT30) assigned as the default for customer accounts in this segment. Defines invoice due dates, early payment discount eligibility, and cash flow planning inputs.. Valid values are `^[A-Z0-9]{2,10}$`',
    `pricing_tier_code` STRING COMMENT 'Code referencing the applicable pricing tier in SAP S/4HANA SD condition records for customers assigned to this segment. Drives list price, discount matrix, and rebate eligibility. Confidential as it encodes commercial pricing strategy.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `rebate_eligible` BOOLEAN COMMENT 'Indicates whether customer accounts in this segment are eligible for volume-based rebate programs. When True, rebate agreements are activated in SAP S/4HANA SD rebate processing for qualifying accounts.',
    `revenue_band_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the revenue band thresholds (revenue_band_min and revenue_band_max) are denominated (e.g., USD, EUR, GBP). Ensures consistent multi-currency interpretation across global sales regions.. Valid values are `^[A-Z]{3}$`',
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
    `contact_id` BIGINT COMMENT 'Reference to the individual contact person associated with this address, when the address belongs to a specific contact rather than the account-level organization. Nullable for account-level addresses.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns this address record. Links the address to the parent B2B industrial customer, OEM account, distributor, or end-user organization in the customer master.',
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
    `plant_code` STRING COMMENT 'SAP S/4HANA plant code associated with this address when the address represents a customers manufacturing plant or production facility. Enables direct linkage between customer delivery addresses and SAP plant master data for production planning (MRP/MRP II) and goods receipt processing.',
    `po_box` STRING COMMENT 'Post Office (PO) Box number for mailing addresses where physical street delivery is not applicable. Used for billing correspondence and formal legal notices to corporate customers. Stored separately from street address lines.',
    `po_box_postal_code` STRING COMMENT 'Postal code specific to the PO Box address, which may differ from the street address postal code. Required for accurate mail routing when a PO Box is used for billing or correspondence.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address. Format varies by country (e.g., 5-digit US ZIP, alphanumeric UK postcode). Used for mail delivery, logistics carrier routing (LTL/FTL), and geographic segmentation.',
    `postal_code_extension` STRING COMMENT 'Extended postal code suffix providing finer delivery point precision (e.g., ZIP+4 in the US). Improves mail delivery accuracy and carrier routing for industrial shipments.',
    `room_number` STRING COMMENT 'Room, suite, or unit number within a building at this address. Provides the most granular level of location detail for field service technician dispatch and internal mail routing at customer facilities.',
    `sales_region_code` STRING COMMENT 'Sales region or territory code associated with this address, used for sales force assignment, revenue reporting, and quota management. Derived from geographic location and aligned with SAP S/4HANA SD sales organization structure.',
    `service_territory_code` STRING COMMENT 'Field service territory code assigned to this address, used to route field service engineers and technicians for equipment maintenance, installation, and after-sales support. Aligns with Salesforce Service Cloud territory management and Maximo Asset Management work order dispatch.',
    `shipping_condition` STRING COMMENT 'Default shipping condition or delivery method applicable to this address, indicating the preferred logistics mode. LTL (Less Than Truckload) and FTL (Full Truckload) are standard industrial shipping terms. Drives carrier selection and Transportation Management System (TMS) routing.. Valid values are `standard|express|freight|ltl|ftl|will_call`',
    `source_system_address_code` STRING COMMENT 'The native address identifier from the originating source system (e.g., Salesforce CRM Address ID, SAP ADRC ADDRNUMBER). Enables reverse lookup and reconciliation between the Databricks Silver Layer and operational systems during ETL and data quality processes.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division of the address. Stored as ISO 3166-2 subdivision code (e.g., US-CA, DE-BY). Used for tax jurisdiction, regulatory compliance (OSHA, EPA), and logistics zone determination.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier for the address location, used to determine applicable sales tax, VAT, or GST rates for invoicing. Typically derived from postal code and state/province. Aligns with SAP S/4HANA tax determination and IFRS/GAAP revenue recognition requirements.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/Chicago, Europe/Berlin, Asia/Shanghai). Used for scheduling field service visits, coordinating production planning across global manufacturing sites, and SLA response time calculations.',
    `validation_source` STRING COMMENT 'The system or method used to validate the address. Tracks whether validation was performed by USPS CASS certification, a geocoding API (Google Maps, HERE), Informatica MDM address cleansing, manual review, or not yet validated. Supports data quality governance.. Valid values are `usps_cass|google_maps|here_api|informatica_mdm|manual|unvalidated`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated against a postal authority or address verification service. Used to determine if re-validation is required based on data quality policies.',
    `vat_registration_number` STRING COMMENT 'Value Added Tax (VAT) registration number associated with this address, particularly for EU and international billing addresses. Required for cross-border B2B invoicing compliance and VAT reclaim processes in industrial manufacturing.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing address records for customer accounts and contacts, including headquarters, billing address, shipping/delivery address, and plant site addresses. Captures address type, street lines, city, state/province, postal code, country, geocoordinates, validated flag, and primary address indicator. Supports logistics, invoicing, and field service dispatch.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the customer credit profile record in the Databricks Silver Layer. Serves as the primary key for this entity.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B industrial customer, OEM account, distributor, or end-user organization for whom this credit profile is maintained. Links to the customer master record.',
    `approval_date` DATE COMMENT 'Date on which the current credit limit and terms were formally approved by the authorized credit manager. Part of the credit governance audit trail required for SOX and IFRS compliance.',
    `approved_by` STRING COMMENT 'Name or employee ID of the credit manager or authorized approver who approved the current credit limit and terms. Required for segregation of duties (SoD) compliance and audit trail in SAP S/4HANA FI-AR.',
    `bad_debt_provision_amount` DECIMAL(18,2) COMMENT 'Amount provisioned for potential bad debt loss on this customers receivables under the IFRS 9 Expected Credit Loss (ECL) model or GAAP ASC 310 allowance method. Maintained in SAP S/4HANA FI-AR.',
    `bank_account_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers bank account details on file have been verified through the companys bank account validation process. True = verified; False = unverified. Required for direct debit and bank transfer payment methods.',
    `collection_strategy_code` STRING COMMENT 'Code identifying the dunning and collections strategy assigned to this customer in SAP S/4HANA FI-AR (e.g., standard dunning, escalated collections, legal action track). Drives automated dunning notice generation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage, audit trail, and IFRS/GAAP record-keeping requirements.',
    `credit_account_type` STRING COMMENT 'Classification of the credit account based on the nature of the customer relationship. Determines applicable credit policies and risk frameworks. [ENUM-REF-CANDIDATE: domestic|export|intercompany|distributor|oem|government — promote to reference product if additional types are required]. Valid values are `domestic|export|intercompany|distributor|oem`',
    `credit_control_area` STRING COMMENT 'SAP organizational unit (credit control area code) responsible for managing and monitoring this customers credit. Defines the credit management scope and currency for credit limit enforcement in SAP S/4HANA FI-AR.',
    `credit_hold_date` DATE COMMENT 'Date on which the credit hold was applied to the customer account. Used for aging analysis of credit holds and SLA compliance tracking for credit resolution processes.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the customer account is currently placed on credit hold, blocking new order processing in SAP S/4HANA SD and Siemens Opcenter MES. True = credit hold active; False = no hold. Synchronized with Salesforce CRM account status.',
    `credit_hold_reason` STRING COMMENT 'Reason code explaining why the customer account has been placed on credit hold. Required for audit trail and CAPA (Corrective and Preventive Action) processes. Null when credit_hold_flag is False.. Valid values are `overdue_balance|credit_limit_exceeded|payment_default|legal_dispute|credit_review_pending|fraud_suspicion`',
    `credit_hold_released_date` DATE COMMENT 'Date on which the credit hold was lifted and normal order processing was reinstated. Null if the credit hold is still active. Used for credit resolution cycle time analysis.',
    `credit_insurance_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum insured amount under the trade credit insurance policy for this customer, in the account currency. Represents the maximum receivable amount recoverable in case of customer default.',
    `credit_insurance_expiry_date` DATE COMMENT 'Date on which the trade credit insurance policy for this customer expires. Triggers renewal workflow alerts to prevent uninsured credit exposure.',
    `credit_insurance_policy_number` STRING COMMENT 'Reference number of the trade credit insurance policy (e.g., Euler Hermes, Coface, Atradius) covering this customers receivables. Null if no credit insurance is in place. Used for insurance claim processing and risk mitigation reporting.',
    `credit_insurance_provider` STRING COMMENT 'Name of the trade credit insurance provider covering this customers receivables (e.g., Euler Hermes, Coface, Atradius, Credendo). Null if no credit insurance is in place.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure (in the account currency) that can be extended to the customer at any point in time. Set during credit review and enforced in SAP S/4HANA FI-AR credit management.',
    `credit_notes` STRING COMMENT 'Free-text field for credit analyst notes, special conditions, exceptions, or contextual information relevant to this customers credit profile. Supports credit review documentation and exception management.',
    `credit_rating` STRING COMMENT 'Internal or external credit risk rating assigned to the customer (e.g., A, B, C, D or numeric score). Used to classify credit risk tier and determine applicable credit terms, insurance requirements, and collection priority. May align with Dun & Bradstreet or internal scoring models.',
    `credit_rating_agency` STRING COMMENT 'Source or agency that issued the credit rating for this customer. Distinguishes between internally-derived ratings and third-party agency assessments used for credit risk management. [ENUM-REF-CANDIDATE: internal|dun_bradstreet|moody|sp|fitch|coface|euler_hermes — 7 candidates stripped; promote to reference product]',
    `credit_review_frequency` STRING COMMENT 'Frequency at which formal credit reviews are scheduled for this customer. Determined by credit risk tier and customer segment. Higher-risk customers require more frequent reviews.. Valid values are `monthly|quarterly|semi_annual|annual|event_driven`',
    `credit_segment` STRING COMMENT 'SAP S/4HANA credit segment identifier that groups customers under a common credit management policy and credit limit pool. Enables multi-segment credit management for customers operating across multiple business units or regions.',
    `credit_status` STRING COMMENT 'Current lifecycle status of the customer credit profile. Drives order release decisions in SAP S/4HANA SD and MES order management. on_hold and blocked prevent new order processing until resolved.. Valid values are `active|on_hold|blocked|suspended|closed`',
    `credit_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the approved credit limit currently consumed by the outstanding balance (outstanding_balance / credit_limit × 100). Triggers credit hold alerts when threshold is breached. Synchronized from SAP S/4HANA FI-AR credit exposure calculation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit, outstanding balance, and financial terms are denominated (e.g., USD, EUR, GBP). Aligns with the customers billing currency in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `dso_days` DECIMAL(18,2) COMMENT 'Days Sales Outstanding — the average number of days it takes the customer to pay invoices, calculated as (outstanding_balance / total_credit_sales) × number_of_days. A key KPI for accounts receivable performance and cash flow management per IFRS/GAAP reporting.',
    `dunning_level` STRING COMMENT 'Current dunning level (1–4) indicating the escalation stage of overdue payment notices sent to the customer. Level 1 = first reminder; Level 4 = final notice before legal action. Managed in SAP S/4HANA FI-AR dunning program.',
    `early_payment_discount_days` STRING COMMENT 'Number of days from invoice date within which the customer must pay to qualify for the early payment discount. Null if no early payment discount applies.',
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
    `payment_method` STRING COMMENT 'Agreed payment instrument used by the customer for settling invoices (e.g., bank transfer, letter of credit for export customers, direct debit). Configured in SAP S/4HANA FI-AR payment method settings.. Valid values are `bank_transfer|check|letter_of_credit|direct_debit|documentary_collection`',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key defining the agreed payment schedule for this customer (e.g., NT30 = Net 30, NT60 = Net 60, NT90 = Net 90, 2/10NT30 = 2% discount if paid within 10 days, net 30). Drives invoice due date calculation in SAP S/4HANA FI-AR.',
    `payment_terms_days` STRING COMMENT 'Number of calendar days from invoice date within which payment is due under the agreed payment terms (e.g., 30 for Net 30, 60 for Net 60, 90 for Net 90). Used for DSO calculation and cash flow forecasting.',
    `risk_category` STRING COMMENT 'Categorical risk classification assigned to the customer based on credit rating, payment history, and financial health assessment. Drives credit limit setting, insurance requirements, and collection strategy.. Valid values are `low|medium|high|very_high|watch_list`',
    `salesforce_account_code` STRING COMMENT 'Salesforce CRM Account record ID for this customer, used for bi-directional synchronization of credit status and credit hold flags between SAP S/4HANA FI-AR and Salesforce CRM Sales Cloud.',
    `sap_customer_account_number` STRING COMMENT 'The externally-known SAP S/4HANA FI-AR customer account number (debtor number) used to uniquely identify the customer in the ERP system. Serves as the business identifier for cross-system reconciliation.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Customer credit assessment and terms management record. Captures credit limit, credit rating, payment terms (Net 30, Net 60, Net 90), currency, credit hold status, credit hold reason, last credit review date, next review date, credit insurance policy reference, outstanding balance, and days sales outstanding (DSO). Managed in SAP S/4HANA FI-AR and synchronized with Salesforce CRM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` (
    `sla_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the SLA agreement record in the Databricks Silver Layer. Primary key for this entity.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In manufacturing, SLA agreements are frequently scoped to specific customer plant or facility sites rather than the entire account. For example, a customer may have different uptime targets, response ',
    `contact_id` BIGINT COMMENT 'Reference to the designated customer contact person who receives escalation notifications when SLA thresholds are at risk of breach or have been breached. Links to the contact master in the customer domain.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B industrial customer, OEM account, distributor, or end-user organization account to which this SLA agreement applies. Links to the customer account master in the customer domain.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Service contract scoping: Manufacturing SLA agreements are frequently scoped to entire product families (e.g., all drives, all motors). A FK to family_id enables service revenue reporting by produ',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique surrogate identifier for each customer interaction record in the silver layer lakehouse. Primary key for the interaction data product.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Customer interactions in manufacturing frequently occur at specific plant or facility sites (site visits, on-site technical reviews, maintenance coordination calls, commissioning meetings). interactio',
    `contact_id` BIGINT COMMENT 'Reference to the individual customer contact (person) who participated in this interaction. Maps to Salesforce CRM Contact object.',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B customer account (OEM, distributor, or end-user organization) associated with this interaction. Maps to Salesforce CRM Account object.',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Customer interactions in manufacturing are frequently triggered by or reference a specific field service visit — complaints about technician work, follow-up calls post-dispatch, or NPS surveys tied to',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Customer service interactions in manufacturing (order inquiries, delivery complaints, billing disputes) are routinely tied to a specific order. CRM-to-order linkage is a named business process enablin',
    `installed_base_id` BIGINT COMMENT 'Foreign key linking to service.installed_base. Business justification: Customer interactions in manufacturing frequently concern a specific installed asset — performance complaints, upgrade inquiries, or maintenance discussions. Linking interaction to installed_base enab',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity associated with this interaction, if applicable. Links interaction to active deal pipeline in Salesforce CRM.',
    `request_id` BIGINT COMMENT 'Reference to the customer service case or support ticket associated with this interaction, if applicable. Links interaction to after-sales support and CAPA processes.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Product quality and complaint management: Customer interactions (complaints, technical support, field visits) in manufacturing are tied to specific SKUs. This FK enables product-level complaint tracki',
    `sla_agreement_id` BIGINT COMMENT 'Reference to the SLA agreement governing the response and service standards applicable to this customer interaction. Enables SLA compliance monitoring for after-sales and service interactions.',
    `campaign_code` BIGINT COMMENT 'Reference to the marketing campaign that originated or is associated with this interaction (e.g., trade show campaign, email nurture campaign). Links interaction to campaign ROI analysis.',
    `capa_reference` STRING COMMENT 'Reference number of the CAPA record initiated as a result of this interaction, if applicable. Links customer feedback to the formal quality management corrective action process.',
    `channel` STRING COMMENT 'The communication medium or channel through which the interaction was conducted. Supports omnichannel relationship health analysis and customer experience tracking.. Valid values are `phone|email|in_person|virtual|survey|web_portal`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the interaction took place. Supports regional sales performance analysis and compliance with export control regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was first created in the system. Serves as the audit trail creation marker for data governance and lineage purposes.',
    `crm_activity_code` STRING COMMENT 'External identifier of the corresponding Task or Event record in Salesforce CRM. Used for cross-system traceability and delta-load reconciliation from the source system of record.',
    `interaction_description` STRING COMMENT 'Detailed narrative of the interaction content, topics discussed, key decisions made, and context. Supports relationship history review and account management continuity.',
    `duration_minutes` STRING COMMENT 'Actual elapsed duration of the interaction in minutes as recorded by the interaction owner. Supports engagement depth analysis and SLA compliance monitoring.',
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
    `verbatim_feedback` STRING COMMENT 'Unstructured, verbatim text feedback provided by the customer during or after the interaction. Captured for voice-of-customer (VoC) analysis, sentiment analysis, and continuous improvement programs. Classified confidential as it contains customer-specific business opinions.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Records of all customer-facing business interactions and touchpoints including sales calls, site visits, product demonstrations, technical consultations, trade show meetings, executive briefings, and customer satisfaction survey responses (NPS). Maps to Salesforce CRM Activity (Task/Event). Captures interaction type, channel (phone, email, in-person, virtual, survey), date, duration, participants, outcome, satisfaction score (where applicable), verbatim feedback, follow-up actions, and associated opportunity or account. Supports relationship health monitoring and customer experience tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`customer`.`account_site` (
    `account_site_id` BIGINT COMMENT 'Unique surrogate identifier for the customer account site record in the Manufacturing lakehouse. Primary key for the account_site entity.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: account_site duplicates physical address data inline (address_line1, address_line2, city, state_province, postal_code, country_code, latitude, longitude) that is already managed canonically in the add',
    `contact_id` BIGINT COMMENT 'Reference to the primary contact person at this site responsible for coordinating field service visits, deliveries, and maintenance activities. Links to the contact master record.',
    `customer_account_id` BIGINT COMMENT 'Reference to the parent customer account to which this site belongs. Links the physical site to the B2B customer, OEM, distributor, or end-user organization in the account master.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Site‑level sales rep ownership is required for site‑specific revenue tracking and service contract management.',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing access restrictions, security clearance requirements, visitor registration procedures, or special entry protocols for field service engineers and delivery personnel at this site.',
    `commissioning_date` DATE COMMENT 'Date on which the site was formally commissioned and became operational for Manufacturing product installations and services. Used to calculate site age, warranty period tracking, and lifecycle analytics.',
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
    `maximo_location_code` STRING COMMENT 'IBM Maximo Asset Management location identifier for this site. Used to link account site records to Maximo work orders, preventive maintenance plans, and asset hierarchies for field service execution.',
    `mes_system_present` BOOLEAN COMMENT 'Indicates whether a Manufacturing Execution System (MES) is installed at the site. Used to assess integration readiness for Siemens Opcenter MES connectivity and shop floor data exchange.',
    `network_connectivity_type` STRING COMMENT 'Primary network connectivity type available at the site for IIoT device integration, remote monitoring, and SCADA/MES connectivity. Determines feasibility of remote diagnostics and predictive maintenance services.. Valid values are `ethernet|fiber|wireless|cellular|vpn|none`',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance visit at this site. Drives field service dispatch scheduling, spare parts pre-positioning, and resource capacity planning for the service organization.',
    `number_of_production_lines` STRING COMMENT 'Count of active production lines at the manufacturing site. Used to estimate installed base potential, maintenance workload, and spare parts demand. Relevant for manufacturing plant site types.',
    `operates_24x7` BOOLEAN COMMENT 'Indicates whether the site operates continuously 24 hours a day, 7 days a week. When true, overrides operational_hours_start/end for scheduling purposes and may trigger higher SLA tier assignment.',
    `operational_hours_end` STRING COMMENT 'Daily operational end time of the site in HH:MM (24-hour) format in the sites local time zone. Used to constrain field service scheduling, maintenance windows, and delivery cutoff times.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operational_hours_start` STRING COMMENT 'Daily operational start time of the site in HH:MM (24-hour) format in the sites local time zone. Used to schedule field service visits, preventive maintenance windows, and delivery time slots within permitted hours.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `plant_floor_area_sqm` DECIMAL(18,2) COMMENT 'Total operational floor area of the site in square meters. Used for capacity planning, equipment density analysis, and logistics resource estimation for large-scale installations.',
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
    `time_zone` STRING COMMENT 'IANA time zone identifier for the site location (e.g., America/Chicago, Europe/Berlin). Used for scheduling preventive maintenance windows, field service appointments, and operational hours alignment.',
    CONSTRAINT pk_account_site PRIMARY KEY(`account_site_id`)
) COMMENT 'Physical plant, factory, or facility locations associated with a customer account where Manufacturing products are installed, delivered, or serviced. Captures site name, site type (manufacturing plant, warehouse, distribution center, data center, commercial building, substation), address reference, site contact, installed product count, site criticality rating, site status (active, decommissioned, under construction), operational hours, and environmental/safety classification. Enables field service dispatch, logistics planning, installed base tracking, and preventive maintenance scheduling at customer locations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_parent_account_customer_account_id` FOREIGN KEY (`parent_account_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_primary_ultimate_parent_account_customer_account_id` FOREIGN KEY (`primary_ultimate_parent_account_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `primary_ultimate_parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_source` SET TAGS ('dbx_business_glossary_term' = 'Account Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|suspended|terminated|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'OEM|distributor|system_integrator|end_user|EPC_contractor|reseller');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sap_business_partner_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Business Partner (BP) ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `status_date` SET TAGS ('dbx_business_glossary_term' = 'Account Status Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name (DBA — Doing Business As)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Customer Website URL');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ALTER COLUMN `website` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `account_site` SET TAGS ('dbx_business_glossary_term' = 'Contact Account Site');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Assistant Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Assistant Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_business_glossary_term' = 'Contact Date of Birth');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `consent_record_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `consent_record_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'technical_evaluator|commercial_buyer|executive_approver|end_user|influencer|other');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `customer_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `customer_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|do_not_contact|pending_verification|deceased');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Contact Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Business Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-Out Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `fax` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `fax` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `gdpr_data_subject_code` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Subject ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `gdpr_data_subject_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `gdpr_data_subject_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Preferred Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Activity Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Contact Lead Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_state` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Street Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Consent Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Consent Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mdm_golden_record_code` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mdm_golden_record_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `persona` SET TAGS ('dbx_business_glossary_term' = 'Contact Persona');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Business Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|in_person|video_call|portal');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ALTER COLUMN `technical_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `nda_required` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Required');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Segment Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `pricing_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `pricing_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `pricing_tier_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `rebate_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rebate Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Band Currency');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ALTER COLUMN `revenue_band_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|headquarters|plant_site|mailing|field_service');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `attention_line` SET TAGS ('dbx_business_glossary_term' = 'Attention Line');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `loading_dock_available` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Available Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geocoordinate)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Address Key');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `mdm_address_key` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `po_box_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Extension (ZIP+4)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `postal_code_extension` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room / Suite Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'standard|express|freight|ltl|ftl|will_call');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Address ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_value_regex' = 'usps_cass|google_maps|here_api|informatica_mdm|manual|unvalidated');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`address` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_account_type` SET TAGS ('dbx_value_regex' = 'domestic|export|intercompany|distributor|oem');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_value_regex' = 'overdue_balance|credit_limit_exceeded|payment_default|legal_dispute|credit_review_pending|fraud_suspicion');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|event_driven');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_segment` SET TAGS ('dbx_business_glossary_term' = 'Credit Segment');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|blocked|suspended|closed');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|letter_of_credit|direct_debit|documentary_collection');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Category');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|watch_list');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Customer Account Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`credit_profile` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` SET TAGS ('dbx_subdomain' = 'service_commitments');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement Name');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'service_commitments');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Site Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Site Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Site Access Restriction Notes');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Site Commissioning Date');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Management Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `mes_system_present` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Present Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Site Network Connectivity Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_value_regex' = 'ethernet|fiber|wireless|cellular|vpn|none');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Preventive Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `number_of_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Lines');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operates_24x7` SET TAGS ('dbx_business_glossary_term' = '24x7 Operations Flag');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours End Time');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `plant_floor_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Plant Floor Area (Square Meters)');
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
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Site Criticality Rating');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|decommissioned|under_construction|suspended|planned');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing_plant|warehouse|distribution_center|data_center|commercial_building|substation');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`account_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Site Time Zone');
