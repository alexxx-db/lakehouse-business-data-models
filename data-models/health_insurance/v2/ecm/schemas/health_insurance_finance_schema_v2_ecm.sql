-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`finance` COMMENT 'Owns enterprise financial management — general ledger (GL), accounts payable (AP), accounts receivable (AR), fixed assets (FA), cost center structures, GAAP and SAP statutory reporting, MLR calculations, and regulatory financial filings with state DOIs and NAIC. Manages capitation payments, provider incentive settlements, VBC shared savings distributions, and risk-based capital (RBC) reporting. Source system: Oracle Financials.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Unique identifier for the ledger record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Ledger entries for risk adjustment factors must be posted against the specific risk pool to produce accurate financial statements.',
    `account_name` STRING COMMENT 'Human‑readable name of the GL account.',
    `account_number` STRING COMMENT 'Unique alphanumeric code identifying the GL account.',
    `account_type` STRING COMMENT 'Classification of the account for financial reporting.. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_type` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance.. Valid values are `debit|credit`',
    `budget_owner` STRING COMMENT 'Identifier of the person or group responsible for the accounts budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Code for the department within the organization.',
    `ledger_description` STRING COMMENT 'Free‑form description providing additional context for the account.',
    `division_code` STRING COMMENT 'Code for the division within the organization.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the account becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'Date when the account ceases to be effective; null if open‑ended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_reporting_category` STRING COMMENT 'Category used for external financial reporting and regulatory filings.',
    `fund_code` STRING COMMENT 'Code representing the fund segment of the account.',
    `gaap_ledger_flag` BOOLEAN COMMENT 'True if the account is part of a GAAP ledger.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_budgeted` BOOLEAN COMMENT 'True if the account is included in the budgeting process.',
    `is_consolidated` BOOLEAN COMMENT 'True if the ledger entry belongs to a consolidated reporting set.',
    `ledger_status` STRING COMMENT 'Current lifecycle state of the account.. Valid values are `active|inactive|closed`',
    `legal_entity_code` STRING COMMENT 'Unique identifier for the legal entity owning the account.',
    `line_of_business` STRING COMMENT 'Identifier for the line of business to which the account belongs.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `posting_allowed` BOOLEAN COMMENT 'True if postings are permitted to this account.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `segment1` STRING COMMENT 'First custom segment value for the account (e.g., business unit).',
    `segment2` STRING COMMENT 'Second custom segment value for the account.',
    `segment3` STRING COMMENT 'Third custom segment value for the account.',
    `segment4` STRING COMMENT 'Fourth custom segment value for the account.',
    `segment5` STRING COMMENT 'Fifth custom segment value for the account.',
    `statutory_ledger_flag` BOOLEAN COMMENT 'True if the account is part of a statutory (SAP) ledger.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ledger record.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'General ledger (GL) master in Oracle Financials representing the chart of accounts, ledger structure, organizational cost center hierarchy, and segment value definitions. Defines account codes, account types (asset, liability, equity, revenue, expense), natural account segments, cost center segments (department codes, division codes, LOB segments, legal entity assignments, budget owner relationships), fund segments, and GAAP vs SAP statutory ledger designations. Cost center hierarchy supports PMPM cost allocation, MLR segmentation, and statutory expense reporting with drill-down from enterprise to department level. Each ledger instance corresponds to a legal entity or reporting purpose (primary, secondary, statutory). Serves as the authoritative financial accounting backbone and organizational structure master for all journal postings, trial balance generation, period-end close, cost center-based financial accountability, and regulatory financial reporting to state DOIs and NAIC.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate key for the cost center record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: cost_center has legal_entity_code BIGINT and legal_entity_name STRING — both denormalized from legal_entity. Adding legal_entity_id FK normalizes this. legal_entity has both legal_entity_code and lega',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who owns the cost center for budgeting purposes.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the organizational hierarchy.',
    `primary_cost_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for managing the cost center.',
    `allocation_method` STRING COMMENT 'Method used to allocate expenses to the cost center.. Valid values are `direct|percentage|formula`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage used when allocation_method is percentage.',
    `audit_trail` STRING COMMENT 'Free‑form notes capturing audit actions or comments related to the cost center.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the cost center, expressed in the reporting currency.',
    `budget_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the budget amount (e.g., USD).',
    `cost_center_category` STRING COMMENT 'Broad category describing the purpose of the cost center.. Valid values are `operational|support|administrative|strategic`',
    `cost_center_code` STRING COMMENT 'Business identifier code used in financial systems and reporting.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center.. Valid values are `active|inactive|closed|pending`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center (e.g., department, division, line of business, legal entity, project).. Valid values are `department|division|lob|legal_entity|project`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level for the cost center data.. Valid values are `internal|confidential|restricted`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Code representing the department that owns the cost center.',
    `cost_center_description` STRING COMMENT 'Free‑form description providing additional context about the cost center.',
    `division_code` STRING COMMENT 'Code representing the division that owns the cost center.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the cost center becomes effective for reporting.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'Date when the cost center ceases to be effective (nullable for open‑ended).',
    `end_date` DATE COMMENT 'Date when the cost center was retired or closed (nullable).',
    `external_reference` STRING COMMENT 'Identifier used by external systems (e.g., ERP, HR) to reference the cost center.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account` STRING COMMENT 'GL account number associated with the cost center for posting transactions.',
    `group_name` STRING COMMENT 'Logical grouping name for reporting clusters of cost centers.',
    `hierarchy_level` STRING COMMENT 'Numeric level of the cost center within the organizational hierarchy (1 = top level).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_budgeted` BOOLEAN COMMENT 'True if the cost center has an assigned budget; false otherwise.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the cost center is used for consolidated reporting across multiple entities.',
    `last_review_date` DATE COMMENT 'Date of the most recent budget or structure review for the cost center.',
    `line_of_business` STRING COMMENT 'Business line to which the cost center belongs.. Valid values are `health_insurance|dental|vision|wellness`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_flag` BOOLEAN COMMENT 'Indicates whether the cost center is included in MLR calculations.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center.',
    `pmpm_flag` BOOLEAN COMMENT 'True if the cost center is used in PMPM cost allocation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the cost center must be reported in statutory filings.',
    `reporting_code` STRING COMMENT 'Code used in financial reporting packages to reference the cost center.',
    `review_frequency` STRING COMMENT 'How often the cost center budget and structure are reviewed.. Valid values are `annual|quarterly|monthly`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied to the cost center for risk‑adjusted financial calculations.',
    `start_date` DATE COMMENT 'Date when the cost center became active in the organization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center hierarchy master managed in Oracle Financials. Defines the financial reporting structure — department codes, division codes, LOB (Line of Business) segments, legal entity assignments, and budget owner relationships. Used for PMPM cost allocation, MLR (Medical Loss Ratio) segmentation, and statutory expense reporting. Supports drill-down from enterprise to department level for financial accountability.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique system-generated identifier for the journal entry.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the journal entry.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Accounting creates journal entries for each appeal case to record adjustments; required for GAAP compliance and audit trail.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which the entry is charged.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Journal entries that record employer‑related transactions need the employer_group_id for accurate financial reporting and GAAP compliance.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: journal_entry has legal_entity_code BIGINT representing the legal entity posting the journal entry. Adding legal_entity_id FK normalizes this to the legal_entity master. legal_entity has legal_entity_',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department responsible for the transaction.',
    `primary_journal_employee_id` BIGINT COMMENT 'Identifier of the employee who prepared the journal entry.',
    `reversal_of_journal_entry_id` BIGINT COMMENT 'Self‑reference to the journal entry that this entry reverses, if applicable.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Journal entries for reserve adjustments, reinsurance recoveries, etc., need the associated risk pool for audit trails and reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Vendor expense audit report requires linking each journal entry to the originating vendor for expense verification and regulatory compliance (e.g., CMS vendor cost tracking).',
    `accounting_period` STRING COMMENT 'Period identifier (e.g., 2023-09) for the financial posting.',
    `approval_status` STRING COMMENT 'Current approval state of the entry.. Valid values are `approved|rejected|pending`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budgeted amount associated with the entry, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `[A-Z]{3}`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `journal_entry_description` STRING COMMENT 'Free‑form text describing the purpose or nature of the entry.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the journal entry.. Valid values are `posted|pending|reversed|error`',
    `entry_timestamp` TIMESTAMP COMMENT 'Timestamp of the business event that generated the journal entry (e.g., posting time).',
    `entry_type` STRING COMMENT 'Classification of the entry (e.g., accrual, reversal, manual adjustment).. Valid values are `accrual|reversal|adjustment|manual|system_generated`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting foreign currency to reporting currency.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fiscal_month` STRING COMMENT 'Numeric month (1‑12) of the fiscal period.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the journal entry.',
    `fund_code` STRING COMMENT 'Code representing the fund or pool of resources associated with the entry.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether the entry is part of the approved budget.',
    `is_consolidation_elimination` BOOLEAN COMMENT 'True if the entry is used to eliminate intercompany balances in consolidated statements.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether the entry is an intercompany transaction.',
    `is_statistical` BOOLEAN COMMENT 'True if the entry is for statistical reporting only (no financial impact).',
    `journal_number` STRING COMMENT 'External business identifier for the journal entry, often used in reporting and audit trails.',
    `line_of_business` STRING COMMENT 'Business line to which the journal entry pertains (e.g., medical, dental).. Valid values are `medical|dental|vision|wellness`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount (debits minus credits) representing the entrys impact.',
    `originating_entity_code` BIGINT COMMENT 'Legal entity that originated the intercompany transaction.',
    `posting_status` STRING COMMENT 'Indicates whether the entry has been posted to the ledger.. Valid values are `posted|unposted`',
    `receiving_entity_code` BIGINT COMMENT 'Legal entity that receives the intercompany transaction.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reference_document_number` STRING COMMENT 'External document number (e.g., invoice, claim) linked to the entry.',
    `source_module` STRING COMMENT 'Specific module within the source system that generated the entry (e.g., GL).',
    `statistical_amount` DECIMAL(18,2) COMMENT 'Amount recorded for statistical entries when applicable.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Aggregate credit amount for the journal entry.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Aggregate debit amount for the journal entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the journal entry record.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core GL journal entry in Oracle Financials capturing all financial postings — accruals, reversals, manual adjustments, intercompany eliminations, consolidation entries, and system-generated entries from sub-ledgers (AP, AR, FA). Includes header-level attributes (journal source, category, accounting period, currency, exchange rate, GAAP vs SAP basis, preparer, approver, posting status) and line-level detail (account code combination with natural account + cost center + LOB + fund segments, debit/credit amounts, entered and accounted amounts, statistical amounts, reconciliation references). Intercompany entries carry originating/receiving legal entity identifiers and elimination status for consolidated financial statement preparation. Supports all journal categories including intercompany management fees, cost allocations, intercompany loans, dividends, and consolidation eliminations. Foundation for period-end close, trial balance, statutory financial statements, and all regulatory filings to NAIC and state DOIs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'System-generated unique identifier for each journal entry line.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry header to which this line belongs.',
    `ledger_id` BIGINT COMMENT 'Identifier of the GL account (or account segment combination) associated with this line.',
    `accounted_amount` DECIMAL(18,2) COMMENT 'Final amount posted to the ledger after adjustments, taxes, and currency conversion.',
    `additional_segment` STRING COMMENT 'Optional fifth segment for extended chart of accounts (e.g., project or grant code).',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center to which the transaction is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction (e.g., USD, EUR).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `debit_credit_indicator` STRING COMMENT 'Specifies whether the line amount is a debit or a credit.. Valid values are `debit|credit`',
    `journal_entry_line_description` STRING COMMENT 'Free‑text description of the transaction line purpose or narrative.',
    `effective_date` DATE COMMENT 'Date the transaction becomes effective for accounting purposes.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `entered_amount` DECIMAL(18,2) COMMENT 'Original amount entered for the line before any adjustments.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied when the transaction currency differs from the reporting currency.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fund_code` STRING COMMENT 'Fund or financing source code used for the transaction.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_budgeted` BOOLEAN COMMENT 'True if the line amount is part of a budgeted allocation.',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether the line is a statistical (non‑monetary) entry.',
    `line_of_business` STRING COMMENT 'Business line or product line code (e.g., medical, dental, vision).',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the journal entry.',
    `line_status` STRING COMMENT 'Current processing status of the line.. Valid values are `open|posted|reversed|pending|error`',
    `line_type` STRING COMMENT 'Classification of the line purpose (e.g., regular transaction, tax, fee).. Valid values are `regular|adjustment|tax|fee|reversal`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `natural_account` STRING COMMENT 'Primary chart of accounts segment representing the account type (e.g., revenue, expense).',
    `posting_date` DATE COMMENT 'Date on which the line was posted to the general ledger.',
    `reconciliation_reference` STRING COMMENT 'External reference used for sub‑ledger or bank reconciliation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_module` STRING COMMENT 'Specific module or component within the source system (e.g., GL Posting, Billing).',
    `statistical_amount` DECIMAL(18,2) COMMENT 'Amount used for statistical reporting (non‑financial) such as volume or headcount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the journal entry line record.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line within a GL journal entry. Captures account code combination (natural account + cost center + LOB + fund), entered amount, accounted amount, currency, statistical amount, description, and reconciliation reference. Enables granular account-level analysis, sub-ledger reconciliation, and audit trail for GAAP and SAP statutory reporting. Each line maps to a specific ledger account segment combination.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the AP invoice record.',
    `baa_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: Invoices from business associates need BAA linkage to ensure PHI handling compliance.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: ap_invoice has bank_account_number STRING which is a denormalized reference to the bank account used for payment. Adding bank_account_id FK normalizes this. bank_account has account_number for JOIN re',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Invoices are generated for appeal‑related fees (penalties, processing charges); linking to the appeal case enables accurate billing and revenue tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_invoice has denormalized cost_center_code STRING. Adding a proper FK cost_center_id to cost_center normalizes this relationship. cost_center table has cost_center_code attribute, so the code can be',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AP invoice entry audit requires tracking the employee who entered the invoice for segregation of duties and compliance reporting.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Contract compliance reporting links each AP invoice to its underlying vendor contract to verify coverage, enforce terms, and support audit trails.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor/payee in the master vendor table.',
    `ap_invoice_status` STRING COMMENT 'Current processing state of the invoice. [ENUM-REF-CANDIDATE: draft|open|approved|paid|void|on_hold|cancelled — 7 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current approval state of the invoice.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the invoice.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was approved for payment.',
    `check_number` STRING COMMENT 'Check identifier when payment method is check.',
    `cleared_date` DATE COMMENT 'Date the payment cleared the bank.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the invoice amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `ap_invoice_description` STRING COMMENT 'Free‑text description of the invoice purpose or contents.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the invoice.',
    `division_code` STRING COMMENT 'Organizational division responsible for the invoice.',
    `due_date` DATE COMMENT 'Date by which payment is required according to payment terms.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eft_reference` STRING COMMENT 'Electronic Funds Transfer reference identifier.',
    `external_reference_number` STRING COMMENT 'Reference number from external systems (e.g., EDI 837 transaction ID).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Invoice)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_posting_flag` BOOLEAN COMMENT 'True if the invoice has been posted to the general ledger.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or adjustments.',
    `hold_reason` STRING COMMENT 'Reason why the invoice is on hold.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued by the vendor.',
    `invoice_number` STRING COMMENT 'External invoice identifier assigned by the vendor or generated by the system.',
    `invoice_type` STRING COMMENT 'Category of the invoice based on business process.. Valid values are `capitation|incentive|vendor_payment|reimbursement|shared_savings|other`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business line (e.g., medical, dental, vision) to which the invoice belongs.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `n1099_flag` BOOLEAN COMMENT 'Indicates whether the vendor requires IRS Form 1099 reporting.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after tax and discount.',
    `payment_date` DATE COMMENT 'Date the payment was executed.',
    `payment_method` STRING COMMENT 'Method used to disburse payment to the vendor.. Valid values are `check|eft|wire|credit_card|ach`',
    `payment_status` STRING COMMENT 'Current status of the payment transaction.. Valid values are `not_paid|paid|partial|failed|reversed`',
    `payment_terms` STRING COMMENT 'Standard payment terms code (e.g., Net30, Net45).',
    `reconciliation_status` STRING COMMENT 'Status of the invoice reconciliation against bank statements.. Valid values are `unmatched|matched|partial|exception`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `service_period_end` DATE COMMENT 'End date of the service period the invoice covers.',
    `service_period_start` DATE COMMENT 'Start date of the service period the invoice covers.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    `vendor_npi` STRING COMMENT 'NPI assigned to provider‑type vendors.',
    `vendor_tax_number` STRING COMMENT 'Tax identification number (e.g., EIN) for the vendor.',
    `void_flag` BOOLEAN COMMENT 'Indicates whether the invoice has been voided.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'GL-recorded accounts payable invoice version';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'System-generated unique identifier for the AP payment record.',
    `ap_invoice_id` BIGINT COMMENT 'Identifier of the AP invoice that this payment settles.',
    `baa_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: Payments to business associates must reference their BAA for ongoing compliance monitoring.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: ap_payment has bank_account_number STRING which is a denormalized reference to the disbursement bank account. Adding bank_account_id FK normalizes this. bank_account has account_number for JOIN retrie',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Payments for appeal penalties must be tied to the originating appeal case for auditability and financial reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_payment has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the relationship. cost_center.cost_center_code exists for JOIN retrieval. Populated at payment creation.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who processed the payment.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor, provider, or capitation recipient receiving the payment.',
    `ap_payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `pending|processed|cleared|voided|failed`',
    `check_number` STRING COMMENT 'Check identifier when payment is made by paper check.',
    `cleared_date` DATE COMMENT 'Date on which the payment cleared the bank.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for the payment.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `ap_payment_description` STRING COMMENT 'Free‑text description or notes about the payment.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount subtracted from the gross amount.',
    `division_code` STRING COMMENT 'Organizational division code linked to the payment.',
    `due_date` DATE COMMENT 'Date by which the payment should be made according to terms.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eft_reference` STRING COMMENT 'Electronic Funds Transfer reference code.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied when payment is in foreign currency.',
    `external_reference_number` STRING COMMENT 'Reference number from external systems (e.g., bank batch ID).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total payment amount before taxes, discounts, or adjustments.',
    `hold_reason` STRING COMMENT 'Reason why the payment is on hold.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_foreign_currency` BOOLEAN COMMENT 'True if the payment was made in a currency other than the functional currency.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been reconciled to bank statements.',
    `line_of_business` STRING COMMENT 'Business line associated with the payment.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount paid after taxes and discounts.',
    `payment_batch_number` BIGINT COMMENT 'Identifier of the batch run that includes this payment.',
    `payment_channel` STRING COMMENT 'Delivery channel through which the payment was processed.. Valid values are `online|batch|manual`',
    `payment_date` TIMESTAMP COMMENT 'Timestamp when the payment was executed or posted.',
    `payment_method` STRING COMMENT 'Instrument used to disburse the payment.. Valid values are `check|eft|wire|credit_card|cash`',
    `payment_number` STRING COMMENT 'External business identifier assigned to the payment transaction.',
    `payment_terms` STRING COMMENT 'Contractual terms governing when payment is due (e.g., Net30).',
    `payment_type` STRING COMMENT 'Category of the payment (e.g., capitation, incentive, claim).. Valid values are `capitation|incentive|claim|premium|shared_savings`',
    `reconciliation_date` DATE COMMENT 'Date when the payment was reconciled.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_module` STRING COMMENT 'Specific module within the source system (e.g., AP).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the payment.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the payment is exempt from tax.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage used to calculate tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment record.',
    `vendor_npi` STRING COMMENT 'Standard 10‑digit identifier for health care providers.. Valid values are `^d{10}$`',
    `vendor_tax_number` STRING COMMENT 'Tax identification number of the vendor for reporting and compliance.. Valid values are `^[A-Z0-9]{2,15}$`',
    `void_flag` BOOLEAN COMMENT 'Indicates whether the payment has been voided.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment transaction in Oracle Financials recording disbursements to vendors, providers, and capitation recipients. Captures payment method (check, EFT, wire), payment date, bank account, payment amount, currency, void status, and cleared date. Includes capitation payment runs to PCPs and specialist groups, provider incentive settlement disbursements, and VBC shared savings distributions. Reconciles against bank statements and AP invoice balances.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'System-generated surrogate primary key for the AR invoice record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ar_invoice has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the AR invoice to its cost center. cost_center.cost_center_code available via JOIN. Populated at invoice creati',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: AR invoices for premium billing must reference the employer group to reconcile revenue, meet audit and regulatory requirements.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) that owns the invoice.',
    `party_id` BIGINT COMMENT 'Identifier of the member, employer group, government program, or other party responsible for payment.',
    `reversal_invoice_ar_invoice_id` BIGINT COMMENT 'Reference to the invoice that reverses this one, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Commission calculations and sales performance dashboards require associating each AR invoice with the sales rep employee who originated the sale.',
    `ar_invoice_status` STRING COMMENT 'Current processing state of the invoice.. Valid values are `draft|open|posted|closed|cancelled|voided`',
    `billing_cycle` STRING COMMENT 'Recurrence pattern for the invoice.. Valid values are `monthly|quarterly|semiannual|annual|one_time|custom`',
    `collection_status` STRING COMMENT 'Current status of cash collection against the invoice.. Valid values are `unapplied|partial|paid|writeoff|overdue|disputed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the invoice amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `ar_invoice_description` STRING COMMENT 'Free‑form text describing the purpose or details of the invoice.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the invoice.',
    `division_code` STRING COMMENT 'Organizational division responsible for the invoice.',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `external_reference_number` STRING COMMENT 'Identifier from an external system (e.g., EDI 837 transaction number).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Invoice)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_end` DATE COMMENT 'Date after which late fees may be assessed if payment is not received.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or adjustments.',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and sent to the counter‑party.',
    `invoice_number` STRING COMMENT 'External business identifier assigned to the invoice by the billing system.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_void` BOOLEAN COMMENT 'Flag indicating whether the invoice has been voided.',
    `is_written_off` BOOLEAN COMMENT 'Flag indicating whether the invoice amount has been written off as uncollectible.',
    `line_of_business` STRING COMMENT 'Business line (e.g., individual, group, Medicare) associated with the invoice.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount due after tax and discount adjustments.',
    `party_type` STRING COMMENT 'Classification of the party (e.g., member, employer, government program).. Valid values are `member|employer|government|provider|vendor`',
    `payment_method` STRING COMMENT 'Instrument used by the payer to settle the invoice.. Valid values are `credit_card|debit_card|bank_transfer|check|cash|online`',
    `payment_status` STRING COMMENT 'Current status of the payment processing for the invoice.. Valid values are `pending|processed|failed|reversed|refunded|cancelled`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due (e.g., Net30).',
    `premium_period_end` DATE COMMENT 'End date of the coverage period for which the premium is billed.',
    `premium_period_start` DATE COMMENT 'Start date of the coverage period for which the premium is billed.',
    `receipt_date` DATE COMMENT 'Date the payment was received and posted.',
    `receipt_method` STRING COMMENT 'Channel used to receive payment (e.g., ACH, wire, check).. Valid values are `ACH|wire|check|lockbox|credit_card|cash`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_module` STRING COMMENT 'Specific module or component within the source system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the invoice amount that has not yet been applied to a receipt.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    `writeoff_date` DATE COMMENT 'Date the invoice was written off.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable (AR) sub-ledger in Oracle Financials representing the full invoice-to-receipt lifecycle for all premium and fee receivables. Captures invoice attributes (invoice number, customer/group ID, invoice date, due date, premium period, amount, tax, currency, collection status) and receipt/cash application attributes (receipt date, receipt method — ACH/wire/check/lockbox, receipt amount, applied invoice references, unapplied amount, bank deposit batch). Covers premium receivables from employer groups, member premium billings, ASO administrative fee receivables, and government program receivables (CMS Medicare Advantage, Medicaid managed care). Supports cash application, grace period tracking, premium revenue reconciliation, and feeds the GL for revenue recognition. Single source of truth for the complete AR sub-ledger lifecycle from invoice generation through cash receipt and application.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` (
    `ar_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the AR receipt record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that processed the receipt.',
    `party_id` BIGINT COMMENT 'Identifier of the party (member, employer, government agency) that made the payment.',
    `reversal_receipt_ar_receipt_id` BIGINT COMMENT 'Identifier of the receipt that reverses this transaction, if applicable.',
    `ach_trace_number` STRING COMMENT 'Trace number for ACH transactions.',
    `applied_invoice_ids` STRING COMMENT 'Delimited list of invoice identifiers to which the receipt has been applied.',
    `ar_receipt_status` STRING COMMENT 'Current lifecycle status of the receipt.. Valid values are `pending|posted|reversed|void`',
    `bank_deposit_batch` STRING COMMENT 'Identifier of the bank deposit batch containing this receipt.',
    `batch_number` STRING COMMENT 'Identifier of the processing batch that included this receipt.',
    `check_number` STRING COMMENT 'Check number associated with the receipt, when method is check.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the receipt record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the receipt currency.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deposit_date` DATE COMMENT 'Date the receipt was deposited into the bank.',
    `ar_receipt_description` STRING COMMENT 'Free‑form description or notes about the receipt.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the receipt.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied when receipt currency differs from functional currency.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_end_date` DATE COMMENT 'Date after which late fees may be assessed if receipt remains unapplied.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_foreign_currency` BOOLEAN COMMENT 'True if receipt was received in a currency other than the functional currency.',
    `is_locked` BOOLEAN COMMENT 'Indicates if the receipt is locked for further changes (e.g., after posting).',
    `is_reversed` BOOLEAN COMMENT 'Indicates whether the receipt has been reversed.',
    `lockbox_number` STRING COMMENT 'Identifier of the lockbox where the check was received, if applicable.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax and discount, posted to the account.',
    `party_type` STRING COMMENT 'Classification of the paying party.. Valid values are `member|employer|government|medicaid|cms`',
    `payment_channel` STRING COMMENT 'Operational channel through which the payment was processed.. Valid values are `online|batch|manual`',
    `payment_reference_number` STRING COMMENT 'Reference number provided by the payer (e.g., check number, ACH trace).',
    `payment_status` STRING COMMENT 'Current processing status of the payment.. Valid values are `received|applied|unapplied|failed`',
    `receipt_amount` DECIMAL(18,2) COMMENT 'Total gross amount received before any adjustments.',
    `receipt_date` TIMESTAMP COMMENT 'Timestamp when the cash receipt was actually received.',
    `receipt_method` STRING COMMENT 'Channel used to deliver the payment.. Valid values are `ACH|wire|check|lockbox|cash`',
    `receipt_number` STRING COMMENT 'External business identifier assigned to the receipt by the billing system.. Valid values are `^[A-Z0-9]{1,20}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_module` STRING COMMENT 'Specific module within the source system that produced the receipt.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component included in the receipt.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the receipt.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the receipt not yet applied to an invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the receipt record.',
    `wire_reference` STRING COMMENT 'Reference identifier for wire transfer receipts.',
    CONSTRAINT pk_ar_receipt PRIMARY KEY(`ar_receipt_id`)
) COMMENT 'Accounts receivable cash receipt transaction in Oracle Financials recording premium payments received from employer groups, individual members, CMS, and state Medicaid agencies. Captures receipt date, receipt method (ACH, wire, check, lockbox), receipt amount, currency, applied invoice references, unapplied amount, and bank deposit batch. Supports cash application, grace period tracking, and premium revenue reconciliation against billing system records.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'System-generated unique identifier for each fixed asset record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: fixed_asset has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the asset-to-cost-center assignment. cost_center.cost_center_code available via JOIN. Populated at asset acqui',
    `employee_id` BIGINT COMMENT 'Identifier of the party (e.g., department, business unit) that owns the asset.',
    `vendor_id` BIGINT COMMENT 'FK to vendor.vendor',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date for the asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original cost incurred to acquire the asset, before any depreciation.',
    `acquisition_date` DATE COMMENT 'Date the asset was purchased or otherwise capitalized.',
    `asset_category` STRING COMMENT 'High‑level classification of the asset (e.g., "IT Infrastructure", "Office Equipment").',
    `asset_condition` STRING COMMENT 'Physical condition of the asset at the time of assessment.. Valid values are `new|good|fair|poor`',
    `asset_description` STRING COMMENT 'Free‑form description providing additional details about the asset.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset (e.g., "Server Rack A1").',
    `asset_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number for the asset.',
    `asset_status` STRING COMMENT 'Operational status of the asset within the organization.. Valid values are `in_service|retired|under_maintenance|disposed`',
    `asset_subcategory` STRING COMMENT 'More detailed classification within the asset category (e.g., "Server", "Desktop Computer").',
    `asset_tag` STRING COMMENT 'External tag or code used to identify the asset on the shop floor or in inventory.',
    `assigned_department` STRING COMMENT 'Organizational department responsible for the assets use and upkeep.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation expense recognized for the most recent period.',
    `depreciation_end_date` DATE COMMENT 'Date when depreciation expense is scheduled to end (typically end of useful life).',
    `depreciation_expense_account` STRING COMMENT 'GL account used for recording periodic depreciation expense.',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation (e.g., straight‑line, declining balance).. Valid values are `straight_line|declining_balance`',
    `depreciation_period` STRING COMMENT 'Frequency at which depreciation expense is recognized.. Valid values are `monthly|quarterly|annual`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation expense began for the asset.',
    `disposal_date` DATE COMMENT 'Date the asset was removed from service or sold.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Monetary amount received from the disposal of the asset.',
    `disposal_status` STRING COMMENT 'Current disposal state of the asset.. Valid values are `active|disposed|pending_disposal`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date from which the asset record is considered active for reporting.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'Date after which the asset record is no longer active (null if still active).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_code` STRING COMMENT 'GL account to which the assets cost and depreciation are posted.',
    `insurance_expiration_date` DATE COMMENT 'Date the insurance coverage for the asset ends.',
    `insurance_policy_number` STRING COMMENT 'Policy number covering the asset against loss or damage.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance activity was performed.',
    `location_code` STRING COMMENT 'Code representing the physical location or site where the asset resides.',
    `maintenance_cost` DECIMAL(18,2) COMMENT 'Cost incurred for the most recent maintenance activity.',
    `maintenance_schedule` STRING COMMENT 'Standard maintenance cadence (e.g., "Quarterly", "Annual").',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the asset (cost less accumulated depreciation).',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order that sourced the asset.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated number of years the asset is expected to provide economic benefit.',
    `warranty_expiration_date` DATE COMMENT 'Date the vendor warranty for the asset expires.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset (FA) master and depreciation history in Oracle Financials representing capitalized assets owned by the health plan — IT infrastructure, office equipment, leasehold improvements, software licenses, and medical management systems. Captures asset-level attributes (asset number, category, acquisition date/cost, depreciation method, useful life, salvage value, location, assigned cost center, disposal status, disposal date, disposal proceeds) and periodic depreciation records (depreciation period, depreciation method — straight-line/declining balance, depreciation amount, accumulated depreciation, net book value, GL account distribution). Supports GAAP and SAP statutory balance sheet reporting, monthly close depreciation expense recognition, RBC (Risk-Based Capital) asset valuation calculations, and asset lifecycle management from acquisition through disposal.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` (
    `depreciation_transaction_id` BIGINT COMMENT 'Unique identifier for the depreciation transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: depreciation_transaction has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the depreciation posting to its cost center. cost_center.cost_center_code available via JOIN. Pop',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the fixed asset to which this depreciation applies.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: depreciation_transaction has legal_entity_code BIGINT representing the legal entity owning the depreciated asset. Adding legal_entity_id FK normalizes this to the legal_entity master. Populated at dep',
    `reversal_of_transaction_depreciation_transaction_id` BIGINT COMMENT 'Reference to the original depreciation transaction that is being reversed.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total accumulated depreciation for the asset after this transaction.',
    `audit_trail` STRING COMMENT 'Free‑form audit notes capturing manual adjustments or comments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation transaction record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Organizational department responsible for the asset.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Monetary amount of depreciation expense recognized in this transaction.',
    `depreciation_basis` STRING COMMENT 'Underlying basis used for depreciation (cost, revaluation, or fair value).. Valid values are `cost|revaluation|fair_value`',
    `depreciation_date` DATE COMMENT 'The date on which the depreciation expense is recorded.',
    `depreciation_life_years` STRING COMMENT 'Total useful life of the asset, in years, as defined for depreciation.',
    `depreciation_method` STRING COMMENT 'The accounting method used to calculate depreciation (e.g., straight‑line, declining balance).. Valid values are `straight_line|declining_balance|sum_of_years|units_of_production`',
    `depreciation_period` STRING COMMENT 'Code representing the fiscal period (month/quarter) to which the depreciation amount applies.',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Rate used to calculate depreciation, expressed as a percentage.',
    `depreciation_schedule_type` STRING COMMENT 'Frequency at which depreciation is posted (e.g., monthly).. Valid values are `monthly|quarterly|annual`',
    `depreciation_sequence` STRING COMMENT 'Ordinal sequence of the depreciation entry within the reporting period.',
    `depreciation_transaction_status` STRING COMMENT 'Current lifecycle status of the depreciation transaction.. Valid values are `posted|pending|reversed|cancelled`',
    `depreciation_transaction_description` STRING COMMENT 'Narrative description or notes for the depreciation transaction.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Start date of the depreciation period covered by this transaction.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'End date of the depreciation period covered by this transaction.',
    `external_reference` STRING COMMENT 'Reference number from an external system, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_credit` STRING COMMENT 'GL account code that receives the offsetting credit (e.g., accumulated depreciation).',
    `gl_account_debit` STRING COMMENT 'GL account code to which the depreciation expense is debited.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_estimated` BOOLEAN COMMENT 'True if the depreciation amount is an estimate rather than a final figure.',
    `line_of_business` STRING COMMENT 'Business line (e.g., health, dental, vision) that owns the asset.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Assets carrying amount after subtracting accumulated depreciation.',
    `posted_flag` BOOLEAN COMMENT 'True if the depreciation entry has been posted to the general ledger.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the depreciation entry was posted to the general ledger.',
    `posting_status` STRING COMMENT 'Status of the posting process for the depreciation transaction.. Valid values are `ready|error|completed`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reversal_flag` BOOLEAN COMMENT 'True if this transaction reverses a prior depreciation entry.',
    `source_module` STRING COMMENT 'Specific module or component that generated the transaction (e.g., Fixed Asset Module).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component attributable to the depreciation expense.',
    `tax_effect_flag` BOOLEAN COMMENT 'True if the depreciation expense has a tax effect.',
    `transaction_number` STRING COMMENT 'Business identifier for the depreciation transaction, used for tracking and reporting.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the depreciation transaction record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the transaction record.',
    CONSTRAINT pk_depreciation_transaction PRIMARY KEY(`depreciation_transaction_id`)
) COMMENT 'Periodic depreciation transaction in Oracle Financials recording the systematic allocation of fixed asset cost over useful life. Captures asset ID, depreciation period, depreciation method (straight-line, declining balance), depreciation amount, accumulated depreciation balance, net book value after depreciation, and GL account distribution. Supports monthly close, GAAP expense recognition, SAP statutory reporting, and RBC asset valuation adjustments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` (
    `vbc_settlement_id` BIGINT COMMENT 'System-generated unique identifier for the VBC settlement record.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider or ACO receiving the settlement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: VBC settlement oversight reports require identifying the internal manager employee accountable for each settlement.',
    `vbc_contract_id` BIGINT COMMENT 'Identifier of the VBC contract governing this settlement.',
    `vbc_program_id` BIGINT COMMENT 'Identifier of the Accountable Care Organization associated with the settlement.',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Actual health care expenditure incurred during the performance period.',
    `benchmark_expenditure_amount` DECIMAL(18,2) COMMENT 'Projected or benchmarked health care expenditure for the covered population.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the data lake.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary values.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `vbc_settlement_description` STRING COMMENT 'Free‑form notes or comments about the settlement.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Net amount payable to the provider after adjustments, expressed in the settlement currency.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_shared_risk` BOOLEAN COMMENT 'Indicates whether the settlement includes a shared‑risk component.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `payment_method` STRING COMMENT 'Method used to transfer the settlement funds.. Valid values are `electronic|check|wire|eft`',
    `payment_status` STRING COMMENT 'Current status of the settlement payment to the provider.. Valid values are `paid|unpaid|partial|failed`',
    `performance_period_end` DATE COMMENT 'End date of the performance measurement period for the settlement.',
    `performance_period_start` DATE COMMENT 'Start date of the performance measurement period for the settlement.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score used to adjust shared savings.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied to adjust payments based on member risk profile.',
    `savings_amount` DECIMAL(18,2) COMMENT 'Difference between benchmark and actual expenditures; positive for savings, negative for loss.',
    `settlement_number` STRING COMMENT 'External settlement reference number assigned by the finance system.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement transaction.. Valid values are `pending|processed|rejected|cancelled`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement was executed in the real world.',
    `settlement_type` STRING COMMENT 'Classification of the settlement based on contract model.. Valid values are `shared_savings|shared_risk|incentive|capitation`',
    `shared_savings_percentage` DECIMAL(18,2) COMMENT 'Percentage of the savings amount that is shared with the provider/ACO.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    CONSTRAINT pk_vbc_settlement PRIMARY KEY(`vbc_settlement_id`)
) COMMENT 'Value-Based Care (VBC) settlement transaction recording shared savings distributions, shared risk settlements, and performance incentive payments under ACO, bundled payment, and pay-for-performance contracts. Captures contract ID, performance period, provider/ACO entity, benchmark expenditure, actual expenditure, savings/loss amount, shared savings percentage, quality score, final settlement amount, and payment status. Supports VBC financial reconciliation and provider incentive accounting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` (
    `mlr_financial_entry_id` BIGINT COMMENT 'Unique surrogate key for each MLR financial entry record.',
    `submission_id` BIGINT COMMENT 'Unique identifier assigned by the state Department of Insurance to the submitted MLR report.',
    `mlr_calculation_id` BIGINT COMMENT 'Foreign key linking to compliance.mlr_calculation. Business justification: MLR financial entry must be tied to the exact MLR calculation for accurate reporting and audit.',
    `audit_user` STRING COMMENT 'Identifier of the user who initially created the MLR entry.',
    `audit_user_update` STRING COMMENT 'Identifier of the user who performed the most recent update to the MLR entry.',
    `calculation_date` DATE COMMENT 'Date on which the MLR calculation was performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MLR entry was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `mlr_financial_entry_description` STRING COMMENT 'Free‑form text for any supplemental information about the MLR entry.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Start date of the period for which the MLR calculation is effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'End date of the period for which the MLR calculation is effective; null if open‑ended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `incurred_claims_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of claims incurred during the reporting period.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business line to which the MLR calculation applies (e.g., Medical, Dental, Vision).',
    `market_segment` STRING COMMENT 'Segment of the market for which the MLR is calculated.. Valid values are `individual|small_group|large_group`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minimum_mlr_threshold` DECIMAL(18,2) COMMENT 'Regulatory minimum MLR threshold that must be met for the jurisdiction.',
    `mlr_financial_entry_status` STRING COMMENT 'Current lifecycle status of the MLR entry.. Valid values are `pending|completed|rejected`',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'Calculated MLR percentage (incurred claims ÷ earned premium).',
    `quality_improvement_expenses` DECIMAL(18,2) COMMENT 'Qualified expenses incurred for quality improvement activities that count toward the MLR denominator.',
    `rebate_liability_amount` DECIMAL(18,2) COMMENT 'Dollar amount of rebate liability owed to members if MLR falls below the minimum threshold.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reporting_year` STRING COMMENT 'Calendar year for which the MLR is reported.',
    `state_code` STRING COMMENT 'Two‑letter state code for the jurisdiction of the MLR calculation.. Valid values are `^[A-Z]{2}$`',
    `submission_date` DATE COMMENT 'Date the MLR filing was submitted to the regulator.',
    `submission_status` STRING COMMENT 'Current status of the MLR filing with CMS or the state Department of Insurance.. Valid values are `not_submitted|submitted|accepted|rejected`',
    `total_earned_premium` DECIMAL(18,2) COMMENT 'Total earned premium revenue for the reporting period, used as the MLR denominator.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MLR entry.',
    CONSTRAINT pk_mlr_financial_entry PRIMARY KEY(`mlr_financial_entry_id`)
) COMMENT 'Medical Loss Ratio (MLR) calculation record per ACA Section 2718 requirements, computed by LOB, market segment (individual, small group, large group), and state. Captures reporting year, incurred claims amount, quality improvement expenses, total earned premium, MLR percentage, minimum MLR threshold, rebate liability amount, and CMS/state DOI submission status. Drives ACA MLR rebate determinations and regulatory filings. Distinct from analytics — this is the authoritative operational record of each MLR computation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` (
    `actuarial_reserve_id` BIGINT COMMENT 'Primary key for actuarial_reserve',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Actuarial reserve records are tied to a specific cost center for financial reporting; adding cost_center_id FK eliminates the silo and enables proper joins.',
    `pool_id` BIGINT COMMENT 'add column risk_pool_id (BIGINT) with FK to risk.pool.pool_id - reserves are held against pools',
    `actuarial_reserve_status` STRING COMMENT 'Current lifecycle status of the reserve record.. Valid values are `active|inactive|closed`',
    `actuary_name` STRING COMMENT 'Full legal name of the certified actuary responsible for the reserve estimate.',
    `actuary_signature_date` TIMESTAMP COMMENT 'Date and time when the actuary signed off on the reserve estimate.',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the reserve estimate.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the reserve estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserve record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts.. Valid values are `[A-Z]{3}`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `development_method` STRING COMMENT 'Actuarial technique used to project the reserve (e.g., Chain‑Ladder, Bornhuetter‑Ferguson, Frequency‑Severity).. Valid values are `chain_ladder|bornhuetter_ferguson|frequency_severity`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the reserve estimate becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'Date when the reserve estimate expires or is superseded (nullable for open‑ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_posting_reference` STRING COMMENT 'Reference identifier linking the reserve to the corresponding GL posting.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business segment (e.g., Medical, Dental, Vision) for which the reserve is calculated.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_flag` BOOLEAN COMMENT 'Indicates whether the reserve is included in MLR calculations (true/false).',
    `notes` STRING COMMENT 'Free‑form comments or annotations entered by the actuary or reviewer.',
    `paid_claims_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of claims that have been paid to date for the period.',
    `paid_lae_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of loss‑adjustment expenses that have been paid to date.',
    `pmpm_flag` BOOLEAN COMMENT 'Indicates whether the reserve amount is reported on a per‑member‑per‑month basis.',
    `product_type` STRING COMMENT 'Specific product or plan type (e.g., HMO, PPO, HDHP) associated with the reserve.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reserve_estimate_amount` DECIMAL(18,2) COMMENT 'Actuarial estimate of the liability for the reserve period before adding confidence bounds.',
    `reserve_period` DATE COMMENT 'First day of the accounting period to which the reserve estimate applies.',
    `reserve_type` STRING COMMENT 'Category of reserve: Incurred But Not Reported (IBNR), Allocated Loss Adjustment Expense (ALAE), or Unallocated Loss Adjustment Expense (ULAE).. Valid values are `IBNR|ALAE|ULAE`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied to the reserve to reflect risk adjustments required by GAAP or SAP.',
    `total_liability_amount` DECIMAL(18,2) COMMENT 'Sum of paid amounts and reserve estimate representing the total projected liability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve record.',
    CONSTRAINT pk_actuarial_reserve PRIMARY KEY(`actuarial_reserve_id`)
) COMMENT 'Actuarial reserve record encompassing both Incurred But Not Reported (IBNR) claims reserves and Loss Adjustment Expense (LAE) reserves — including allocated LAE (ALAE) and unallocated LAE (ULAE). Produced by the actuarial system (Milliman MG-ALFA) representing estimated liabilities for claims incurred but not yet submitted/adjudicated and the costs to investigate, adjudicate, and settle those claims. Captures reserve period, LOB, product type, reserve type (IBNR, ALAE, ULAE), development method (chain-ladder, Bornhuetter-Ferguson), paid claims/LAE to date, reserve estimate, total liability, confidence interval, actuary sign-off/certification, and GL posting reference. Critical for GAAP and SAP statutory balance sheet accuracy, RBC calculations, NAIC Annual Statement Schedule P reporting, and state DOI solvency examinations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'System-generated unique identifier for the budget record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: budget has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the budget to its owning cost center. cost_center.cost_center_code available via JOIN. Populated at budget creation',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the approval.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Budgeting of premiums, reserves, and expenses is performed per risk pool; the FK supports pool‑specific budget creation and variance analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget was formally approved.',
    `approval_user_name` STRING COMMENT 'Full name of the user who approved the budget.',
    `budget_number` STRING COMMENT 'Human‑readable budget number assigned by finance for tracking and reporting.',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget.. Valid values are `draft|submitted|approved|active|closed|rejected`',
    `budget_type` STRING COMMENT 'Category of the budget indicating planning horizon.. Valid values are `annual|multi_year|reforecast`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Code representing the department responsible for the budget.',
    `budget_description` STRING COMMENT 'Narrative description of the budget purpose and scope.',
    `division_code` STRING COMMENT 'Organizational division code associated with the budget.',
    `effective_end_date` DATE COMMENT 'Date when the budget expires; null for open‑ended budgets.',
    `effective_start_date` DATE COMMENT 'Date when the budget becomes effective for spending.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business line (e.g., medical, dental, vision) the budget supports.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes captured during budgeting or reforecast cycles.',
    `owner_name` STRING COMMENT 'Full name of the budget owner.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'Actual spend recorded for the same fiscal period in the previous year.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `total_adjusted_amount` DECIMAL(18,2) COMMENT 'Sum of all approved adjustments (increases or decreases) to the original budget.',
    `total_budgeted_amount` DECIMAL(18,2) COMMENT 'Aggregate amount originally budgeted for the period.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net budget amount after adjustments (budgeted + adjustments).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the budget record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between total net budget and prior year actual (positive = over, negative = under).',
    `version` STRING COMMENT 'Version label of the budget (e.g., v1, v2) used during re‑forecast cycles.',
    `year` STRING COMMENT 'Four‑digit fiscal year to which the budget applies.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and multi-year financial budget in Oracle Financials capturing approved spending plans by cost center, LOB, account, and fiscal period. Includes header-level attributes (budget version, budget year, budget owner, approval status, budget type) and line-level detail (fiscal period, account code combination, cost center, budgeted amount, prior year actual, variance to prior year, reforecast adjustments, notes). Supports variance analysis against actuals, PMPM budget tracking, monthly budget-to-actual drill-down by department and LOB, reforecast cycles, and financial planning for premium rate setting and actuarial projections. Single source of truth for all budget headers and their period-level line allocations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique system-generated identifier for each budget line item.',
    `budget_id` BIGINT COMMENT 'Identifier of the budget record to which this line belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: budget_line has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the budget line to its cost center. cost_center.cost_center_code available via JOIN. Populated at budget line ',
    `employee_id` BIGINT COMMENT 'System identifier of the user who approved the budget line.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - budgets often allocate per plan',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Annual budgeting of vendor contracts allocates budget to specific vendors; linking budget_line to vendor enables vendor‑specific budget planning and cost control.',
    `account_code` STRING COMMENT 'Chart of accounts code that the budget amount is charged to.',
    `allocation_method` STRING COMMENT 'Rule used to distribute the budget amount across cost centers or projects.. Valid values are `percentage|fixed|rollover`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Portion of the total amount allocated to this line (if allocation_method = percentage).',
    `approval_status` STRING COMMENT 'Current state of the budget lines approval process.. Valid values are `approved|rejected|pending|under_review`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget line received final approval.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Amount allocated in the current budget cycle.',
    `budget_line_status` STRING COMMENT 'Operational status of the budget line item.. Valid values are `active|inactive|closed|draft|pending|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget line record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter currency identifier for the amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `division_code` STRING COMMENT 'Internal division identifier for reporting and allocation.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the budget line becomes effective for accounting.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'Date when the budget line ceases to be effective; null if open‑ended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fiscal_period` STRING COMMENT 'Period within the fiscal year (e.g., 2024‑01 for January 2024).',
    `fiscal_year` STRING COMMENT 'Four‑digit year to which the budget line is assigned.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_budgeted` BOOLEAN COMMENT 'True if the amount represents a planned budget rather than a recorded actual.',
    `is_consolidated` BOOLEAN COMMENT 'True if the line should be included in corporate‑level consolidated reporting.',
    `is_forecast` BOOLEAN COMMENT 'True if the line reflects a forecasted adjustment rather than an approved budget.',
    `line_of_business` STRING COMMENT 'Business segment (e.g., Medical, Dental, Vision) to which the budget line applies.',
    `line_sequence` STRING COMMENT 'Ordinal position of the line within the budget header.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional commentary or justification for the budget line.',
    `period_end_date` DATE COMMENT 'Last calendar day of the budgeting period covered by the line.',
    `period_start_date` DATE COMMENT 'First calendar day of the budgeting period covered by the line.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'Actual spend recorded in the same period of the previous fiscal year.',
    `quantity` STRING COMMENT 'Number of units (e.g., headcount, service units) associated with the budget line.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resource_type` STRING COMMENT 'Category of the resource (e.g., expense, revenue, capital) that the line supports.',
    `source_module` STRING COMMENT 'Specific module or component that generated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary variance (budgeted minus prior year actual).',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage representation of the variance amount.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual budget line item within a financial budget, capturing the granular period-level allocation by account and cost center. Captures budget line sequence, fiscal period, account code combination, budgeted amount, prior year actual, variance to prior year, and notes. Enables monthly budget-to-actual variance tracking, reforecast adjustments, and drill-down financial analysis by department and LOB.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` (
    `premium_revenue_id` BIGINT COMMENT 'System-generated unique identifier for the premium revenue record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group or association for group policies.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan under which the premium is booked.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Premium revenue calculations depend on each members risk score; linking enables traceability for pricing and regulatory audits.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the premium.',
    `premium_payment_id` BIGINT COMMENT 'add column premium_payment_id (BIGINT) with FK to billing.premium_payment.premium_payment_id - revenue is recognized on payment receipt',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Underwriting profit and loss analysis depends on linking premium revenue records to the underwriter employee responsible for the policy.',
    `accounting_period` STRING COMMENT 'Fiscal accounting period identifier (e.g., 2023Q1).. Valid values are `^d{4}Q[1-4]$`',
    `capitation_amount` DECIMAL(18,2) COMMENT 'Fixed amount paid under a capitation arrangement for the period.',
    `coverage_period_months` STRING COMMENT 'Length of the coverage period in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the premium revenue record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deficiency_reserve` DECIMAL(18,2) COMMENT 'Reserve for potential shortfalls in premium collection or underwriting loss.',
    `earned_premium` DECIMAL(18,2) COMMENT 'Portion of written premium that has been earned based on coverage elapsed.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Start date of the coverage period for which premium is recognized.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'End date of the coverage period for which premium is recognized.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fiscal_month` STRING COMMENT 'Numeric month (1‑12) within the fiscal year for the premium.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year associated with the premium.',
    `hcc_score` STRING COMMENT 'Aggregated HCC score for the member influencing risk adjustment.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_capitated` BOOLEAN COMMENT 'True if the premium is part of a capitation payment arrangement.',
    `lob` STRING COMMENT 'Business line classification of the product (e.g., HMO, PPO).. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `market_segment` STRING COMMENT 'Market segment classification for the premium (individual, group, etc.).. Valid values are `individual|group|government|employer`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_denominator_flag` BOOLEAN COMMENT 'Indicates whether this premium is included in the Medical Loss Ratio denominator.',
    `net_earned_premium` DECIMAL(18,2) COMMENT 'Earned premium after deducting reserves, adjustments, and reinsurance.',
    `premium_record_number` STRING COMMENT 'External business identifier assigned to the premium revenue record.. Valid values are `^PR[0-9]{10}$`',
    `premium_revenue_status` STRING COMMENT 'Current lifecycle status of the premium revenue record.. Valid values are `active|inactive|closed|pending|cancelled`',
    `premium_tax_base` DECIMAL(18,2) COMMENT 'Base amount used for calculating premium taxes.',
    `premium_type` STRING COMMENT 'Classification of the premium amount (e.g., written, earned).. Valid values are `written|earned|adjustment|reinsurance`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this premium record must be reported to regulatory bodies (e.g., CMS, NAIC).',
    `reinsurance_ceded_premium` DECIMAL(18,2) COMMENT 'Portion of premium transferred to reinsurance carriers.',
    `revenue_date` DATE COMMENT 'Date on which the premium revenue was recognized according to ASC 606.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used to adjust premium based on member risk scores.',
    `risk_corridor_adjustment` DECIMAL(18,2) COMMENT 'Adjustment amount resulting from the risk corridor (3Rs) mechanism.',
    `unearned_premium_reserve` DECIMAL(18,2) COMMENT 'Liability reserve for the portion of premium not yet earned.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the premium revenue record.',
    `vbc_shared_savings_amount` DECIMAL(18,2) COMMENT 'Amount of shared savings distributed under VBC contracts.',
    `written_premium` DECIMAL(18,2) COMMENT 'Total premium amount written for the coverage period before any earnings or adjustments.',
    CONSTRAINT pk_premium_revenue PRIMARY KEY(`premium_revenue_id`)
) COMMENT 'Premium revenue recognition record capturing earned premium by member, group, plan, LOB, market segment, and accounting period per ASC 606 / GAAP and SAP statutory standards. Derived from billing and enrollment data and posted to the GL as the authoritative revenue record. Captures member ID, group ID, plan ID, coverage period, written premium, earned premium, unearned premium reserve, deficiency reserve, risk corridor adjustment (3Rs), reinsurance ceded premium, and net earned premium. Supports GAAP revenue recognition, SAP statutory premium reporting, MLR denominator calculations, and premium tax base determination.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` (
    `reinsurance_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the reinsurance transaction record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the transaction record in the source system.',
    `vendor_id` BIGINT COMMENT 'Primary key of the reinsurer party involved in the transaction.',
    `reinsurance_arrangement_id` BIGINT COMMENT 'Unique identifier of the reinsurance treaty associated with this transaction.',
    `attachment_point_amount` DECIMAL(18,2) COMMENT 'Retention threshold amount before reinsurance coverage becomes payable.',
    `attachment_point_type` STRING COMMENT 'Specifies whether the attachment point is per claim, per period, or aggregate.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the reinsurance transaction occurred in the source system.',
    `ceded_loss_amount` DECIMAL(18,2) COMMENT 'Loss amount the insurer cedes to the reinsurer.',
    `ceded_premium_amount` DECIMAL(18,2) COMMENT 'Premium amount transferred to the reinsurer under the treaty.',
    `coverage_end_date` DATE COMMENT 'Last date of coverage period for which the transaction applies.',
    `coverage_start_date` DATE COMMENT 'First date of coverage period for which the transaction applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `reinsurance_transaction_description` STRING COMMENT 'Free‑form text describing the purpose or details of the transaction.',
    `effective_date` DATE COMMENT 'Date when the transaction becomes effective for accounting purposes.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the transaction ceases to be effective, if applicable.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_adjusted` BOOLEAN COMMENT 'True if the transaction reflects an adjustment to a prior entry.',
    `is_assumed` BOOLEAN COMMENT 'True if the transaction represents an assumed reinsurance amount.',
    `is_ceded` BOOLEAN COMMENT 'True if the transaction represents a ceded amount to a reinsurer.',
    `is_excess` BOOLEAN COMMENT 'True if the transaction is part of an excess‑of‑loss reinsurance treaty.',
    `is_partial_settlement` BOOLEAN COMMENT 'True if the settlement covers only a portion of the total amount.',
    `is_quota_share` BOOLEAN COMMENT 'True if the transaction pertains to a quota‑share arrangement.',
    `is_stop_loss` BOOLEAN COMMENT 'True if the transaction is related to a stop‑loss reinsurance treaty.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum liability the reinsurer will assume under the treaty.',
    `limit_type` STRING COMMENT 'Indicates if the limit is per claim, per occurrence, or aggregate.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary impact after premium, loss, and recovery amounts are applied.',
    `rbc_credit_amount` DECIMAL(18,2) COMMENT 'Amount of RBC credit recognized from the reinsurance transaction.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the reinsurer for previously ceded losses.',
    `reporting_category` STRING COMMENT 'Category used for internal and regulatory financial reporting.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used to adjust the transaction for risk weighting in regulatory calculations.',
    `risk_factor_code` STRING COMMENT 'Code representing the specific risk factor applied to the transaction.',
    `sap_schedule_f_flag` STRING COMMENT 'Indicator required for SAP statutory Schedule F reporting (Y/N).. Valid values are `Y|N`',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled with the reinsurer.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process for the transaction.. Valid values are `pending|settled|rejected|partial`',
    `transaction_number` STRING COMMENT 'External reference number assigned by the finance system for tracking.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the transaction record.. Valid values are `draft|open|closed|cancelled`',
    `transaction_type` STRING COMMENT 'Category of the transaction: ceded premium, ceded loss, recovery, or adjustment.. Valid values are `ceded_premium|ceded_loss|recovery|adjustment`',
    `transaction_type_code` STRING COMMENT 'System code representing the transaction type for integration purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_reinsurance_transaction PRIMARY KEY(`reinsurance_transaction_id`)
) COMMENT 'Reinsurance transaction record capturing ceded and assumed reinsurance activity — stop-loss treaties, quota share arrangements, and specific excess reinsurance. Captures treaty ID, reinsurer name, transaction type (ceded premium, ceded loss, recovery), coverage period, attachment point, limit, ceded premium amount, ceded loss amount, recovery amount, and settlement status. Supports SAP statutory Schedule F reporting, RBC credit for reinsurance, and net claims liability calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the intercompany transaction record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intercompany_transaction has denormalized cost_center_code STRING. Adding cost_center_id FK normalizes the intercompany transaction to its cost center. Populated at transaction creation.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: intercompany_transaction has originating_entity_code BIGINT representing the legal entity initiating the transaction. Adding originating_legal_entity_id FK normalizes this to the legal_entity master. ',
    `reversal_transaction_intercompany_transaction_id` BIGINT COMMENT 'Identifier of the transaction that reverses this one, if applicable.',
    `accounting_period` STRING COMMENT 'Fiscal accounting period code associated with the transaction.',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Sum of taxes, fees, discounts, or other adjustments applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total monetary amount before any adjustments, in the transaction currency.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after adjustments, representing the amount to be settled.',
    `approval_status` STRING COMMENT 'Current approval state of the transaction.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the transaction.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was approved.',
    `audit_trail` STRING COMMENT 'JSON or text log capturing key audit events for the transaction.',
    `consolidation_period` STRING COMMENT 'Period (e.g., FY2024Q1) for which the transaction is considered in consolidation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `intercompany_transaction_description` STRING COMMENT 'Free‑form text describing the purpose or nature of the transaction.',
    `division_code` STRING COMMENT 'Organizational division identifier relevant to the transaction.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `elimination_flag` BOOLEAN COMMENT 'Indicates whether the transaction has been eliminated for consolidation purposes.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Conversion rate applied when the transaction currency differs from the reporting currency.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fiscal_month` STRING COMMENT 'Numeric month (1‑12) of the fiscal year for the transaction.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the transaction.',
    `intercompany_elimination_status` STRING COMMENT 'Status of the elimination process for consolidation.. Valid values are `pending|completed|exempt`',
    `intercompany_transaction_status` STRING COMMENT 'Current lifecycle state of the transaction.. Valid values are `draft|open|posted|closed|cancelled`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_budgeted` BOOLEAN COMMENT 'True if the transaction amount is part of a budgeted allocation.',
    `is_foreign_currency` BOOLEAN COMMENT 'True if the transaction currency differs from the entitys functional currency.',
    `is_statistical` BOOLEAN COMMENT 'True if the transaction is for statistical reporting only and does not affect financial balances.',
    `line_of_business` STRING COMMENT 'Business line (e.g., Medical, Dental, Vision) associated with the transaction.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `posted_flag` BOOLEAN COMMENT 'True when the transaction has been posted to the general ledger.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction was posted to the ledger.',
    `receiving_entity_code` BIGINT COMMENT 'Identifier of the legal entity that receives the intercompany transaction.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `related_document_number` STRING COMMENT 'Reference number of a supporting document (e.g., invoice, contract) linked to the transaction.',
    `source_module` STRING COMMENT 'Specific module or component within the source system that originated the transaction.',
    `transaction_category` STRING COMMENT 'High‑level classification of the transaction for reporting (e.g., operating, capital).. Valid values are `operating|capital|investment|tax|other`',
    `transaction_number` STRING COMMENT 'External business identifier assigned to the transaction for reference and reporting.',
    `transaction_purpose` STRING COMMENT 'Business reason or objective behind the intercompany movement.',
    `transaction_subtype` STRING COMMENT 'More granular classification of the transaction type.. Valid values are `interest|principal|fee|royalty|other`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction occurred in the business process.',
    `transaction_type` STRING COMMENT 'Category of the intercompany transaction indicating its economic purpose.. Valid values are `management_fee|cost_allocation|intercompany_loan|dividend|service_charge`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record capturing intra-entity and inter-subsidiary financial activity requiring elimination in consolidated financial statements. Captures originating legal entity, receiving legal entity, transaction type (management fee, cost allocation, intercompany loan, dividend), transaction date, amount, currency, elimination status, and consolidation period. Supports GAAP consolidated financial statement preparation and SAP statutory entity-level reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique surrogate key for each bank account record.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which the accounts expenses are charged.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: bank_account has legal_entity_code BIGINT representing the legal entity owning the bank account. Adding legal_entity_id FK normalizes this to the legal_entity master. Populated at account setup — ever',
    `account_close_date` DATE COMMENT 'Date the bank account was closed, if applicable.',
    `account_holder_name` STRING COMMENT 'Legal name of the entity or individual that holds the account.',
    `account_number` STRING COMMENT 'Full bank account number used for payments and receipts.',
    `account_open_date` DATE COMMENT 'Date the bank account was opened.',
    `account_purpose` STRING COMMENT 'Business purpose or classification for the account (e.g., premium collection, claims disbursement).',
    `account_type` STRING COMMENT 'Classification of the account for cash management purposes.. Valid values are `operating|lockbox|payroll|claims_disbursement|fsa_custodial|hsa_custodial`',
    `bank_account_status` STRING COMMENT 'Current operational status of the account.. Valid values are `active|inactive|closed|pending`',
    `bank_name` STRING COMMENT 'Legal name of the bank where the account is held.',
    `bank_statement_balance` DECIMAL(18,2) COMMENT 'Balance reported on the bank statement for the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank account record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the account.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deposits_in_transit` DECIMAL(18,2) COMMENT 'Deposits recorded in the system but not yet reflected on the bank statement.',
    `bank_account_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the account.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the account became effective for cash management.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT 'Date the account is scheduled to be closed or become inactive.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Account)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_balance` DECIMAL(18,2) COMMENT 'Balance of the associated GL account for the period.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_claims_disbursement_account` BOOLEAN COMMENT 'True if the account is used to pay claim reimbursements.',
    `is_custodial_account` BOOLEAN COMMENT 'True if the account is used to hold funds on behalf of a third party (e.g., HSA, FSA).',
    `is_joint_account` BOOLEAN COMMENT 'True if the account is jointly owned by multiple parties.',
    `is_lockbox` BOOLEAN COMMENT 'True if the account is a lockbox used for receiving payments.',
    `is_operating_account` BOOLEAN COMMENT 'True if the account is used for day‑to‑day operating cash flows.',
    `is_payroll_account` BOOLEAN COMMENT 'True if the account is dedicated to payroll disbursements.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the most recent reconciliation cycle completed successfully.',
    `last_reconciliation_date` DATE COMMENT 'Date when the most recent successful reconciliation was completed.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `outstanding_checks` DECIMAL(18,2) COMMENT 'Total amount of checks issued but not yet cleared.',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'Balance after reconciling GL and bank statement amounts.',
    `reconciliation_period_end` DATE COMMENT 'End date of the current reconciliation reporting period.',
    `reconciliation_period_start` DATE COMMENT 'Start date of the current reconciliation reporting period.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process.. Valid values are `pending|completed|exception`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `routing_number` STRING COMMENT 'ABA routing number identifying the financial institution.',
    `signatory_name` STRING COMMENT 'Name of the individual(s) authorized to sign on the account.',
    `unreconciled_items_amount` DECIMAL(18,2) COMMENT 'Net amount of items that remain unreconciled for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master, cash management, and reconciliation record in Oracle Financials representing all corporate bank accounts used for premium collection, claims disbursement, capitation payments, payroll, and operating expenses. Captures account attributes (bank name, masked account/routing numbers, account type — operating/lockbox/payroll/claims disbursement/FSA-HSA custodial, currency, legal entity, cost center, status, signatory authorities) and periodic reconciliation records (reconciliation period, GL balance, bank statement balance, outstanding checks, deposits in transit, unreconciled items, reconciled balance, reconciliation status, preparer). Serves as the authoritative register for cash management, bank reconciliation, SOC 1 audit compliance, and internal controls over cash. Single source of truth for both bank account master data and reconciliation history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'System‑generated unique identifier for each bank reconciliation record.',
    `bank_account_id` BIGINT COMMENT 'Internal surrogate key referencing the corporate bank account being reconciled.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the reconciliation.',
    `approval_status` STRING COMMENT 'Current approval state of the reconciliation after review.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the reconciliation was approved or rejected.',
    `bank_statement_balance` DECIMAL(18,2) COMMENT 'Balance reported on the bank statement for the same period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts in the record.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deposits_in_transit_amount` DECIMAL(18,2) COMMENT 'Total of deposits recorded in the GL but not yet reflected on the bank statement.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_balance` DECIMAL(18,2) COMMENT 'Balance recorded in the General Ledger for the reconciliation period, in the accounts currency.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_adjusted` BOOLEAN COMMENT 'Indicates whether the reconciliation required manual adjustments after initial processing.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or observations entered by the preparer or reviewer.',
    `outstanding_checks_amount` DECIMAL(18,2) COMMENT 'Total amount of checks issued but not yet cleared by the bank.',
    `preparer_name` STRING COMMENT 'Full name of the employee who prepared the reconciliation.',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'Final balance after reconciling GL and bank statement amounts.',
    `reconciliation_number` STRING COMMENT 'Business‑visible identifier assigned to the reconciliation run, used in reporting and audit trails.',
    `reconciliation_period_end` DATE COMMENT 'Last day of the accounting period covered by the reconciliation.',
    `reconciliation_period_start` DATE COMMENT 'First day of the accounting period covered by the reconciliation.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation process.. Valid values are `pending|in_progress|completed|failed|adjusted`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date‑time when the reconciliation was executed.',
    `reconciliation_type` STRING COMMENT 'Classification of the reconciliation run (e.g., cash‑balance, bank‑statement, manual adjustment).. Valid values are `cash|bank|adjustment`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `unreconciled_items_amount` DECIMAL(18,2) COMMENT 'Net amount of items that remain unreconciled after processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the reconciliation record.',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Bank reconciliation record in Oracle Financials matching GL cash balances against bank statement balances for each corporate bank account. Captures reconciliation period, bank account, GL balance, bank statement balance, outstanding checks, deposits in transit, unreconciled items, reconciled balance, reconciliation status, and preparer. Supports internal controls, SOC 1 audit requirements, and cash management accuracy for premium and claims disbursement accounts.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` (
    `tax_filing_id` BIGINT COMMENT 'Unique identifier for the tax filing record.',
    `journal_entry_id` BIGINT COMMENT 'add column journal_entry_id (BIGINT) with FK to finance.journal_entry.journal_entry_id - tax filings post to the GL',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: tax_filing has legal_entity_code BIGINT representing the legal entity filing taxes. Adding legal_entity_id FK normalizes this to the legal_entity master. legal_entity has legal_entity_code for JOIN re',
    `prior_filing_tax_filing_id` BIGINT COMMENT 'Reference to the original filing that this amendment modifies.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment for the same tax year.',
    `audit_user` STRING COMMENT 'User who performed the most recent audit action.',
    `audit_user_update` STRING COMMENT 'User who performed the last update to the record.',
    `confirmation_number` STRING COMMENT 'Reference number returned by the tax authority confirming receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax filing record was created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_payments_amount` DECIMAL(18,2) COMMENT 'Sum of estimated tax payments made during the year.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_date` DATE COMMENT 'Date on which the filing was officially submitted.',
    `filing_description` STRING COMMENT 'Narrative description of the filing purpose or special circumstances.',
    `filing_error_code` STRING COMMENT 'Code returned by the tax authority if the filing was rejected.',
    `filing_error_description` STRING COMMENT 'Human‑readable description of the filing error.',
    `filing_method` STRING COMMENT 'Method used to submit the filing.. Valid values are `electronic|paper|fax`',
    `filing_number` STRING COMMENT 'External filing number assigned by the tax authority or internal system.',
    `filing_source_system` STRING COMMENT 'Source system that generated the filing record (e.g., Oracle Financials).',
    `filing_status` STRING COMMENT 'Current lifecycle status of the tax filing.. Valid values are `draft|submitted|accepted|rejected|closed`',
    `filing_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing was submitted to the tax authority.',
    `final_tax_due_amount` DECIMAL(18,2) COMMENT 'Remaining tax due after accounting for estimated payments.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_amended` BOOLEAN COMMENT 'Indicates whether this filing is an amendment to a prior filing.',
    `is_filed` BOOLEAN COMMENT 'Indicates whether the filing has been successfully submitted.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes related to the filing.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Amount actually paid for the tax liability.',
    `payment_due_date` DATE COMMENT 'Date by which the tax payment must be made.',
    `payment_method` STRING COMMENT 'Payment instrument used for the tax payment.. Valid values are `check|wire|eft|credit|cash`',
    `payment_received_date` DATE COMMENT 'Date the tax payment was received by the authority.',
    `payment_reference_number` STRING COMMENT 'Reference number associated with the tax payment transaction.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `tax_category` STRING COMMENT 'Category of tax for reporting and analysis.. Valid values are `income|premium|fee|1099`',
    `tax_form_code` STRING COMMENT 'Standard tax form identifier used for the filing.',
    `tax_jurisdiction_code` STRING COMMENT 'Two‑letter code representing the jurisdiction (e.g., state) for the tax.. Valid values are `^[A-Z]{2}$`',
    `tax_liability_amount` DECIMAL(18,2) COMMENT 'Calculated tax liability based on taxable base and rate.',
    `tax_payment_status` STRING COMMENT 'Current status of the tax payment.. Valid values are `pending|paid|partial|failed`',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `tax_type` STRING COMMENT 'Classification of the tax (federal, state, local, or other).. Valid values are `federal|state|local|other`',
    `tax_year` STRING COMMENT 'Fiscal year to which the tax filing applies.',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'Amount subject to tax before rates are applied.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax filing record.',
    CONSTRAINT pk_tax_filing PRIMARY KEY(`tax_filing_id`)
) COMMENT 'Tax filing record capturing federal and state tax obligations and submissions for the health plan legal entities — federal income tax (Form 1120), state premium tax filings, health insurer fee (HIF) under ACA, and 1099 vendor reporting. Captures tax type, tax jurisdiction, tax year, taxable base amount, tax rate, tax liability, estimated payments made, final tax due, filing date, and confirmation number. Supports tax compliance, regulatory reporting, and financial statement tax provision calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_legal_entity_id` BIGINT COMMENT 'Self-referencing FK on legal_entity (parent_legal_entity_id)',
    `address_line1` STRING COMMENT 'Primary street address of the entity.',
    `address_line2` STRING COMMENT '',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Total annual revenue of the entity.',
    `bank_account_currency` STRING COMMENT 'Currency of the bank account.',
    `bank_account_number` STRING COMMENT 'Bank account number used for payments to the entity.',
    `bank_account_type` STRING COMMENT 'Type of bank account (checking, savings, etc.).',
    `bank_name` STRING COMMENT 'Name of the bank holding the entitys account.',
    `bank_routing_number` STRING COMMENT 'Bank routing number for the entitys bank account.',
    `city` STRING COMMENT 'City component of the entitys address.',
    `legal_entity_code` STRING COMMENT 'External reference code used by the organization to identify the entity.',
    `compliance_notes` STRING COMMENT 'Notes related to compliance audits or findings.',
    `compliance_status` STRING COMMENT 'Current compliance status with regulatory requirements.',
    `country` STRING COMMENT 'Country component of the entitys address.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT '',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_to` DATE COMMENT '',
    `entity_type_code` STRING COMMENT '',
    `expiration_date` DATE COMMENT 'Date the entitys registration or agreement expires.',
    `fax` STRING COMMENT 'Fax number for the entity.',
    `federal_employer_identification_number` STRING COMMENT 'Federal employer ID for the entity.',
    `federal_tax_identifier` STRING COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `industry_code` STRING COMMENT 'NAICS or other industry classification code for the entity.',
    `industry_description` STRING COMMENT 'Textual description of the industry classification.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `legal_entity_status` STRING COMMENT 'Current operational status of the entity (active, inactive, dissolved).',
    `legal_entity_type` STRING COMMENT 'Classification of the entity (e.g., corporation, partnership, LLC, non‑profit).',
    `legal_status` STRING COMMENT 'Legal standing of the entity (operational, dissolved, bankrupt).',
    `legal_structure` STRING COMMENT 'Legal form of the entity (C‑corp, S‑corp, LLC, etc.).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `naic_company_code` STRING COMMENT '',
    `legal_entity_name` STRING COMMENT 'Full legal name of the entity.',
    `nature_of_business` STRING COMMENT 'Primary business activities of the entity.',
    `number_of_employees` STRING COMMENT 'Headcount of employees for the entity.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership held by the organization.',
    `ownership_type` STRING COMMENT 'Ownership classification (public, private, government, non‑profit).',
    `postal_code` STRING COMMENT 'Postal code component of the entitys address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the entity.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `registration_date` DATE COMMENT 'Date the entity was registered with the organization.',
    `state` STRING COMMENT 'State component of the entitys address.',
    `state_employer_identification_number` STRING COMMENT 'State employer ID for the entity.',
    `state_of_domicile` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    `state_tax_identifier` STRING COMMENT 'State tax identification number for the entity.',
    `tax_exempt_certificate_expiration_date` DATE COMMENT 'Expiration date of the tax exemption certificate.',
    `tax_exempt_certificate_number` STRING COMMENT 'Certificate number for tax exemption status.',
    `tax_exempt_status` STRING COMMENT 'Indicates whether the entity is tax exempt.',
    `tax_identification_number` STRING COMMENT '',
    `tax_identifier` STRING COMMENT 'Federal tax identification number (EIN) for the entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `website` STRING COMMENT 'Official website URL of the entity.',
    `federal_tax_id` STRING COMMENT '',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` (
    `finance_regulatory_filing_id` BIGINT COMMENT 'System‑generated unique identifier for each regulatory filing record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing process requires linking each filing to the specific regulatory obligation it satisfies.',
    `regulatory_submission_id` BIGINT COMMENT '',
    `acceptance_confirmation_number` STRING COMMENT 'Reference number provided by the regulator confirming acceptance of the filing.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment for the original filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deficiency_notice_number` STRING COMMENT 'Reference number for any deficiency notice issued by the regulator.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_payment_amount` DECIMAL(18,2) COMMENT 'Estimated amount to be paid to the regulator (if applicable).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_approval_timestamp` TIMESTAMP COMMENT 'Date and time the filing was approved by the reviewer.',
    `filing_category` STRING COMMENT 'High‑level classification of the filing.. Valid values are `Statutory|Tax|Regulatory`',
    `filing_document_hash` STRING COMMENT 'SHA‑256 hash of the filing document for integrity verification.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `filing_document_url` STRING COMMENT 'Link to the stored filing document (e.g., PDF) in the document repository.',
    `filing_is_amended` BOOLEAN COMMENT 'Indicates whether this filing is an amendment to a prior filing.',
    `filing_number` STRING COMMENT 'Business identifier assigned to the filing by the insurer.. Valid values are `^[A-Z0-9]{3,20}$`',
    `filing_period_end` DATE COMMENT 'End date of the reporting period covered by the filing.',
    `filing_period_start` DATE COMMENT 'Start date of the reporting period covered by the filing.',
    `filing_rejection_reason` STRING COMMENT 'Reason provided by the regulator for rejecting the filing.',
    `filing_review_comments` STRING COMMENT 'Comments entered by the reviewer during the approval process.',
    `filing_source_system` STRING COMMENT 'Name of the source system that generated the filing record.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the filing.. Valid values are `pending|submitted|accepted|rejected|closed`',
    `filing_status_detail` STRING COMMENT 'Free‑text field providing additional detail about the filing status.',
    `filing_submission_method` STRING COMMENT 'Method used to submit the filing to the regulator.. Valid values are `Electronic|Paper`',
    `filing_submission_reference` STRING COMMENT 'External reference identifier (e.g., EDI transaction ID) for the submission.',
    `filing_timestamp` TIMESTAMP COMMENT 'Date and time the filing was submitted to the regulator.',
    `filing_type` STRING COMMENT 'Category of regulatory filing (e.g., NAIC annual statement, CMS MLR report).. Valid values are `NAIC_Annual|NAIC_Quarterly|CMS_MLR|State_DOI|RBC|IRS_Tax`',
    `filing_version` STRING COMMENT 'Version number of the filing document.',
    `final_tax_due_amount` DECIMAL(18,2) COMMENT 'Final amount due after any adjustments or penalties.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `jurisdiction_code` STRING COMMENT 'Two‑letter code of the state or jurisdiction for the filing.. Valid values are `^[A-Z]{2}$`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `preparer_name` STRING COMMENT 'Full name of the employee who prepared the filing.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Regulatory authority receiving the filing.. Valid values are `CMS|NAIC|IRS|State_DOI|HHS`',
    `reviewer_name` STRING COMMENT 'Full name of the employee who reviewed and approved the filing.',
    `submission_deadline` DATE COMMENT 'Latest date the filing must be submitted to remain compliant.',
    `tax_liability_amount` DECIMAL(18,2) COMMENT 'Calculated tax liability for the filing.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'Base amount on which the filing tax is calculated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    CONSTRAINT pk_finance_regulatory_filing PRIMARY KEY(`finance_regulatory_filing_id`)
) COMMENT 'Financial regulatory and tax filing record tracking all statutory financial reports and tax submissions to state DOIs, NAIC, CMS, HHS, IRS, and state tax authorities. Captures filing type (NAIC Annual Statement, NAIC Quarterly Statement, CMS MLR Report, state DOI filing, RBC report, federal income tax Form 1120, state premium tax, health insurer fee under ACA, vendor 1099 reporting), filing period, regulatory/tax jurisdiction, submission date, filing status, taxable base amount, tax rate, tax liability, estimated payments made, final tax due, confirmation number, preparer, reviewer, acceptance confirmation, and deficiency notices. Serves as the single authoritative log of all financial regulatory submissions and tax compliance filings and their disposition. Consolidates what were previously separate regulatory and tax filing tracking systems into one SSOT.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversal_of_journal_entry_id` FOREIGN KEY (`reversal_of_journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_reversal_invoice_ar_invoice_id` FOREIGN KEY (`reversal_invoice_ar_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_reversal_receipt_ar_receipt_id` FOREIGN KEY (`reversal_receipt_ar_receipt_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ar_receipt`(`ar_receipt_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_reversal_of_transaction_depreciation_transaction_id` FOREIGN KEY (`reversal_of_transaction_depreciation_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`depreciation_transaction`(`depreciation_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ADD CONSTRAINT `fk_finance_actuarial_reserve_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_reversal_transaction_intercompany_transaction_id` FOREIGN KEY (`reversal_transaction_intercompany_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_prior_filing_tax_filing_id` FOREIGN KEY (`prior_filing_tax_filing_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`tax_filing`(`tax_filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`finance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`finance` SET TAGS ('pii_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `cost_center_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `balance_type` SET TAGS ('pii_business_glossary_term' = 'Balance Type (Debit/Credit)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `balance_type` SET TAGS ('pii_value_regex' = 'debit|credit');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `budget_owner` SET TAGS ('pii_business_glossary_term' = 'Budget Owner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `ledger_description` SET TAGS ('pii_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Account Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Account Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `financial_reporting_category` SET TAGS ('pii_business_glossary_term' = 'Financial Reporting Category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fund_code` SET TAGS ('pii_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `fund_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `gaap_ledger_flag` SET TAGS ('pii_business_glossary_term' = 'GAAP Ledger Designation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `is_budgeted` SET TAGS ('pii_business_glossary_term' = 'Budgeted Account Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `is_consolidated` SET TAGS ('pii_business_glossary_term' = 'Consolidated Ledger Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('pii_business_glossary_term' = 'Account Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `legal_entity_code` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `legal_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `posting_allowed` SET TAGS ('pii_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `segment1` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts Segment 1');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `segment2` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts Segment 2');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `segment3` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts Segment 3');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `segment4` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts Segment 4');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `segment5` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts Segment 5');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `statutory_ledger_flag` SET TAGS ('pii_business_glossary_term' = 'Statutory Ledger Designation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Owner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Parent Cost Center Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Manager Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('pii_value_regex' = 'direct|percentage|formula');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Center Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `budget_currency` SET TAGS ('pii_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('pii_value_regex' = 'operational|support|administrative|strategic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('pii_value_regex' = 'department|division|lob|legal_entity|project');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `data_classification` SET TAGS ('pii_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `data_classification` SET TAGS ('pii_value_regex' = 'internal|confidential|restricted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('pii_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Cost Center End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('pii_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `gl_account` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `group_name` SET TAGS ('pii_business_glossary_term' = 'Cost Center Group Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `group_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `group_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `group_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `group_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `is_budgeted` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost Center Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `is_consolidated` SET TAGS ('pii_business_glossary_term' = 'Consolidated Cost Center Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'health_insurance|dental|vision|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `mlr_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `pmpm_flag` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Inclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `reporting_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Reporting Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `reporting_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `review_frequency` SET TAGS ('pii_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Cost Center Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('pii_business_glossary_term' = 'Preparer ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_of_journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Of Journal Entry ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `accounting_period` SET TAGS ('pii_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('pii_value_regex' = 'accrual|reversal|adjustment|manual|system_generated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fund_code` SET TAGS ('pii_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `fund_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `is_budgeted` SET TAGS ('pii_business_glossary_term' = 'Budgeted Entry Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `is_consolidation_elimination` SET TAGS ('pii_business_glossary_term' = 'Consolidation Elimination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `is_intercompany` SET TAGS ('pii_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `is_statistical` SET TAGS ('pii_business_glossary_term' = 'Statistical Entry Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_number` SET TAGS ('pii_business_glossary_term' = 'Journal Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'medical|dental|vision|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_business_glossary_term' = 'Originating Legal Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `originating_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('pii_value_regex' = 'posted|unposted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `receiving_entity_code` SET TAGS ('pii_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `receiving_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('pii_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `statistical_amount` SET TAGS ('pii_business_glossary_term' = 'Statistical Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('pii_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('pii_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Line Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Account Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `accounted_amount` SET TAGS ('pii_business_glossary_term' = 'Accounted Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `additional_segment` SET TAGS ('pii_business_glossary_term' = 'Additional Account Segment');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('pii_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('pii_value_regex' = 'debit|credit');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_description` SET TAGS ('pii_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `entered_amount` SET TAGS ('pii_business_glossary_term' = 'Entered Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fund_code` SET TAGS ('pii_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fund_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `is_budgeted` SET TAGS ('pii_business_glossary_term' = 'Budgeted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `is_statistical` SET TAGS ('pii_business_glossary_term' = 'Statistical Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'open|posted|reversed|pending|error');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_type` SET TAGS ('pii_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_type` SET TAGS ('pii_value_regex' = 'regular|adjustment|tax|fee|reversal');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `natural_account` SET TAGS ('pii_business_glossary_term' = 'Natural Account (GL) Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reconciliation_reference` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `statistical_amount` SET TAGS ('pii_business_glossary_term' = 'Statistical Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_fhir_resource' = 'Invoice');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `baa_id` SET TAGS ('pii_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Invoice Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `check_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `cleared_date` SET TAGS ('pii_business_glossary_term' = 'Bank Clearance Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `eft_reference` SET TAGS ('pii_business_glossary_term' = 'EFT Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `external_reference_number` SET TAGS ('pii_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `external_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `gl_posting_flag` SET TAGS ('pii_business_glossary_term' = 'General Ledger Posting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `hold_reason` SET TAGS ('pii_business_glossary_term' = 'Invoice Hold Reason');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_value_regex' = 'capitation|incentive|vendor_payment|reimbursement|shared_savings|other');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `n1099_flag` SET TAGS ('pii_business_glossary_term' = '1099 Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|eft|wire|credit_card|ach');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'not_paid|paid|partial|failed|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'unmatched|matched|partial|exception');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `service_period_end` SET TAGS ('pii_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `service_period_start` SET TAGS ('pii_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Tax Identification Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `void_flag` SET TAGS ('pii_business_glossary_term' = 'Void Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Payable Invoice ID (AP_INVOICE_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `baa_id` SET TAGS ('pii_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processing User ID (PROC_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier (VENDOR_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Lifecycle Status (PAYMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_status` SET TAGS ('pii_value_regex' = 'pending|processed|cleared|voided|failed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number (CHECK_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('pii_business_glossary_term' = 'Cleared Date (CLEARED_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_description` SET TAGS ('pii_business_glossary_term' = 'Payment Description (PAYMENT_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code (DIVISION_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date (DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `eft_reference` SET TAGS ('pii_business_glossary_term' = 'EFT Reference (EFT_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `eft_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `eft_reference` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `external_reference_number` SET TAGS ('pii_business_glossary_term' = 'External Reference Number (EXT_REF_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `external_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Payment Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `hold_reason` SET TAGS ('pii_business_glossary_term' = 'Hold Reason (HOLD_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `is_foreign_currency` SET TAGS ('pii_business_glossary_term' = 'Foreign Currency Flag (FOREIGN_CURR_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `is_reconciled` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Flag (RECONCILED_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payment Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_batch_number` SET TAGS ('pii_business_glossary_term' = 'Payment Batch Identifier (BATCH_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel (PAYMENT_CHANNEL)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'online|batch|manual');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date and Time (PAYMENT_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method (PAYMENT_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|eft|wire|credit_card|cash');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_business_glossary_term' = 'Payment Number (PAYMENT_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type (PAYMENT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'capitation|incentive|claim|premium|shared_savings');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date (RECONCILIATION_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module (SRC_MODULE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `tax_exempt_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent (TAX_RATE_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_value_regex' = '^d{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Tax Identification Number (VENDOR_TAX_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_tax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `void_flag` SET TAGS ('pii_business_glossary_term' = 'Void Flag (VOID_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_fhir_resource' = 'Invoice');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable Invoice ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Identifier (LEGAL_ENT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Counter‑Party Identifier (PARTY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `reversal_invoice_ar_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Invoice Identifier (REV_INV_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Sales Rep Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Lifecycle Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('pii_value_regex' = 'draft|open|posted|closed|cancelled|voided');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_cycle` SET TAGS ('pii_business_glossary_term' = 'Billing Cycle (BILL_CYCLE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_cycle` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semiannual|annual|one_time|custom');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status (COLL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('pii_value_regex' = 'unapplied|partial|paid|writeoff|overdue|disputed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TSTMP)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_description` SET TAGS ('pii_business_glossary_term' = 'Invoice Description (DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code (DIV_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Due Date (DUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `external_reference_number` SET TAGS ('pii_business_glossary_term' = 'External Reference Number (EXT_REF_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `external_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('pii_business_glossary_term' = 'Grace Period End Date (GRACE_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Invoice Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Issue Date (ISSUE_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number (INV_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `is_void` SET TAGS ('pii_business_glossary_term' = 'Void Indicator (IS_VOID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `is_written_off` SET TAGS ('pii_business_glossary_term' = 'Write‑Off Indicator (IS_WRITTEN_OFF)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Invoice Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `party_type` SET TAGS ('pii_business_glossary_term' = 'Counter‑Party Type (PARTY_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `party_type` SET TAGS ('pii_value_regex' = 'member|employer|government|provider|vendor');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'credit_card|debit_card|bank_transfer|check|cash|online');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'pending|processed|failed|reversed|refunded|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms (PAY_TERM)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `premium_period_end` SET TAGS ('pii_business_glossary_term' = 'Premium Period End Date (PREM_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `premium_period_start` SET TAGS ('pii_business_glossary_term' = 'Premium Period Start Date (PREM_START_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date (RCPT_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `receipt_method` SET TAGS ('pii_business_glossary_term' = 'Receipt Method (RCPT_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `receipt_method` SET TAGS ('pii_value_regex' = 'ACH|wire|check|lockbox|credit_card|cash');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module (SRC_MOD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent (TAX_RATE_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `unapplied_amount` SET TAGS ('pii_business_glossary_term' = 'Unapplied Amount (UNAPPLIED_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TSTMP)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `writeoff_date` SET TAGS ('pii_business_glossary_term' = 'Write‑Off Date (WRITEOFF_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ar_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable Receipt ID (AR_RECEIPT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processing User ID (PROC_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Counterparty Identifier (PARTY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `party_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `party_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `reversal_receipt_ar_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Receipt ID (REV_RCPT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_business_glossary_term' = 'ACH Trace Number (ACH_TRC_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `applied_invoice_ids` SET TAGS ('pii_business_glossary_term' = 'Applied Invoice IDs (APPL_INV_IDS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ar_receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status (RCPT_STS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ar_receipt_status` SET TAGS ('pii_value_regex' = 'pending|posted|reversed|void');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `bank_deposit_batch` SET TAGS ('pii_business_glossary_term' = 'Bank Deposit Batch (DEP_BATCH)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Processing Batch Number (BATCH_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number (CHK_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `check_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `deposit_date` SET TAGS ('pii_business_glossary_term' = 'Deposit Date (DEP_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ar_receipt_description` SET TAGS ('pii_business_glossary_term' = 'Receipt Description (RCPT_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate (XCHG_RT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Grace Period End Date (GRACE_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `is_foreign_currency` SET TAGS ('pii_business_glossary_term' = 'Is Foreign Currency Flag (FCY_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `is_locked` SET TAGS ('pii_business_glossary_term' = 'Is Locked Flag (LOCK_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `is_reversed` SET TAGS ('pii_business_glossary_term' = 'Is Reversed Flag (REV_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `lockbox_number` SET TAGS ('pii_business_glossary_term' = 'Lockbox Number (LOCKBOX_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `lockbox_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `party_type` SET TAGS ('pii_business_glossary_term' = 'Counterparty Type (PARTY_TYP)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `party_type` SET TAGS ('pii_value_regex' = 'member|employer|government|medicaid|cms');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `payment_channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel (PAY_CHNL)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `payment_channel` SET TAGS ('pii_value_regex' = 'online|batch|manual');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payment Reference Number (PAY_REF_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status (PAY_STS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'received|applied|unapplied|failed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_amount` SET TAGS ('pii_business_glossary_term' = 'Receipt Amount (RCPT_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date (RCPT_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_method` SET TAGS ('pii_business_glossary_term' = 'Receipt Method (RCPT_MTHD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_method` SET TAGS ('pii_value_regex' = 'ACH|wire|check|lockbox|cash');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_number` SET TAGS ('pii_business_glossary_term' = 'Receipt Number (RCPT_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `receipt_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module (SRC_MOD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent (TAX_RT_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `unapplied_amount` SET TAGS ('pii_business_glossary_term' = 'Unapplied Amount (UNAPPL_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `wire_reference` SET TAGS ('pii_business_glossary_term' = 'Wire Transfer Reference (WIRE_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_subdomain' = 'asset_depreciation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Asset Owner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('pii_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('pii_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('pii_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('pii_business_glossary_term' = 'Asset Condition');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('pii_value_regex' = 'new|good|fair|poor');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('pii_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_business_glossary_term' = 'Asset Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_serial_number` SET TAGS ('pii_business_glossary_term' = 'Asset Serial Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_serial_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('pii_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('pii_value_regex' = 'in_service|retired|under_maintenance|disposed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_subcategory` SET TAGS ('pii_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('pii_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `assigned_department` SET TAGS ('pii_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_amount` SET TAGS ('pii_business_glossary_term' = 'Depreciation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_end_date` SET TAGS ('pii_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_expense_account` SET TAGS ('pii_business_glossary_term' = 'Depreciation Expense Account');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_period` SET TAGS ('pii_business_glossary_term' = 'Depreciation Period');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_period` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('pii_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('pii_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_status` SET TAGS ('pii_business_glossary_term' = 'Disposal Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_status` SET TAGS ('pii_value_regex' = 'active|disposed|pending_disposal');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_cost` SET TAGS ('pii_business_glossary_term' = 'Maintenance Cost');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_schedule` SET TAGS ('pii_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('pii_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('pii_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_subdomain' = 'asset_depreciation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Depreciation Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `reversal_of_transaction_depreciation_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Of Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `accumulated_depreciation` SET TAGS ('pii_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_amount` SET TAGS ('pii_business_glossary_term' = 'Depreciation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_basis` SET TAGS ('pii_business_glossary_term' = 'Depreciation Basis');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_basis` SET TAGS ('pii_value_regex' = 'cost|revaluation|fair_value');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_date` SET TAGS ('pii_business_glossary_term' = 'Depreciation Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_life_years` SET TAGS ('pii_business_glossary_term' = 'Depreciation Useful Life (Years)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|sum_of_years|units_of_production');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_period` SET TAGS ('pii_business_glossary_term' = 'Depreciation Period');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_rate` SET TAGS ('pii_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_schedule_type` SET TAGS ('pii_business_glossary_term' = 'Depreciation Schedule Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_schedule_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_sequence` SET TAGS ('pii_business_glossary_term' = 'Depreciation Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_transaction_status` SET TAGS ('pii_business_glossary_term' = 'Depreciation Transaction Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_transaction_status` SET TAGS ('pii_value_regex' = 'posted|pending|reversed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `depreciation_transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `external_reference` SET TAGS ('pii_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `gl_account_credit` SET TAGS ('pii_business_glossary_term' = 'GL Credit Account');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `gl_account_debit` SET TAGS ('pii_business_glossary_term' = 'GL Debit Account');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `is_estimated` SET TAGS ('pii_business_glossary_term' = 'Estimated Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `net_book_value` SET TAGS ('pii_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `posted_flag` SET TAGS ('pii_business_glossary_term' = 'Posted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `posting_status` SET TAGS ('pii_value_regex' = 'ready|error|completed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Depreciation Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `tax_effect_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Effect Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Depreciation Transaction Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_subdomain' = 'revenue_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `vbc_settlement_id` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care Settlement ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Settlement Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `vbc_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `vbc_program_id` SET TAGS ('pii_business_glossary_term' = 'ACO ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('pii_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `benchmark_expenditure_amount` SET TAGS ('pii_business_glossary_term' = 'Benchmark Expenditure Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `vbc_settlement_description` SET TAGS ('pii_business_glossary_term' = 'Settlement Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `final_settlement_amount` SET TAGS ('pii_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `is_shared_risk` SET TAGS ('pii_business_glossary_term' = 'Shared Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'electronic|check|wire|eft');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'paid|unpaid|partial|failed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `performance_period_end` SET TAGS ('pii_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `performance_period_start` SET TAGS ('pii_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `savings_amount` SET TAGS ('pii_business_glossary_term' = 'Savings (or Loss) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_number` SET TAGS ('pii_business_glossary_term' = 'Settlement Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_status` SET TAGS ('pii_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_status` SET TAGS ('pii_value_regex' = 'pending|processed|rejected|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('pii_business_glossary_term' = 'Settlement Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_type` SET TAGS ('pii_business_glossary_term' = 'Settlement Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `settlement_type` SET TAGS ('pii_value_regex' = 'shared_savings|shared_risk|incentive|capitation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `shared_savings_percentage` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_subdomain' = 'revenue_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `mlr_financial_entry_id` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio (MLR) Financial Entry ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'State DOI Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `mlr_calculation_id` SET TAGS ('pii_business_glossary_term' = 'Mlr Calculation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `audit_user` SET TAGS ('pii_business_glossary_term' = 'User Who Created Record');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `audit_user_update` SET TAGS ('pii_business_glossary_term' = 'User Who Last Updated Record');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `calculation_date` SET TAGS ('pii_business_glossary_term' = 'MLR Calculation Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `mlr_financial_entry_description` SET TAGS ('pii_business_glossary_term' = 'Additional Description or Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `incurred_claims_amount` SET TAGS ('pii_business_glossary_term' = 'Incurred Claims Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment (Individual, Small Group, Large Group)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `minimum_mlr_threshold` SET TAGS ('pii_business_glossary_term' = 'Minimum MLR Threshold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `mlr_financial_entry_status` SET TAGS ('pii_business_glossary_term' = 'MLR Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `mlr_financial_entry_status` SET TAGS ('pii_value_regex' = 'pending|completed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `mlr_percentage` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `quality_improvement_expenses` SET TAGS ('pii_business_glossary_term' = 'Quality Improvement Expenses (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `rebate_liability_amount` SET TAGS ('pii_business_glossary_term' = 'Rebate Liability Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `reporting_year` SET TAGS ('pii_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code (US Postal State Abbreviation)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'CMS/DOI Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `total_earned_premium` SET TAGS ('pii_business_glossary_term' = 'Total Earned Premium (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_subdomain' = 'risk_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuarial_reserve_id` SET TAGS ('pii_business_glossary_term' = 'Actuarial Reserve Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuarial_reserve_status` SET TAGS ('pii_business_glossary_term' = 'Reserve Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuarial_reserve_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('pii_business_glossary_term' = 'Actuary Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_signature_date` SET TAGS ('pii_business_glossary_term' = 'Actuary Signature Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `confidence_interval_high` SET TAGS ('pii_business_glossary_term' = 'Confidence Interval High');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `confidence_interval_low` SET TAGS ('pii_business_glossary_term' = 'Confidence Interval Low');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `development_method` SET TAGS ('pii_business_glossary_term' = 'Development Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `development_method` SET TAGS ('pii_value_regex' = 'chain_ladder|bornhuetter_ferguson|frequency_severity');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `gl_posting_reference` SET TAGS ('pii_business_glossary_term' = 'General Ledger Posting Reference');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `mlr_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Reserve Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `paid_claims_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Claims Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `paid_lae_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Loss Adjustment Expense Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `pmpm_flag` SET TAGS ('pii_business_glossary_term' = 'Per Member Per Month Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `product_type` SET TAGS ('pii_business_glossary_term' = 'Product Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `reserve_estimate_amount` SET TAGS ('pii_business_glossary_term' = 'Reserve Estimate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `reserve_period` SET TAGS ('pii_business_glossary_term' = 'Reserve Period (Start Date)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `reserve_type` SET TAGS ('pii_business_glossary_term' = 'Reserve Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `reserve_type` SET TAGS ('pii_value_regex' = 'IBNR|ALAE|ULAE');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `total_liability_amount` SET TAGS ('pii_business_glossary_term' = 'Total Liability Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Budget Approval User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_user_name` SET TAGS ('pii_business_glossary_term' = 'Budget Approval User Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_user_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_user_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_user_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_user_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `approval_user_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('pii_business_glossary_term' = 'Budget Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('pii_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|active|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('pii_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('pii_value_regex' = 'annual|multi_year|reforecast');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Budget Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `budget_description` SET TAGS ('pii_business_glossary_term' = 'Budget Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Budget Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Budget Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('pii_business_glossary_term' = 'Budget Owner Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('pii_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `total_adjusted_amount` SET TAGS ('pii_business_glossary_term' = 'Total Adjusted Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `total_budgeted_amount` SET TAGS ('pii_business_glossary_term' = 'Total Budgeted Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `total_net_amount` SET TAGS ('pii_business_glossary_term' = 'Total Net Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Budget Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `year` SET TAGS ('pii_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Budget Line Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('pii_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('pii_value_regex' = 'percentage|fixed|rollover');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'approved|rejected|pending|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budgeted Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('pii_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|draft|pending|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `is_budgeted` SET TAGS ('pii_business_glossary_term' = 'Budgeted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `is_consolidated` SET TAGS ('pii_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `is_forecast` SET TAGS ('pii_business_glossary_term' = 'Forecast Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('pii_business_glossary_term' = 'Prior Year Actual Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `resource_type` SET TAGS ('pii_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `variance_percent` SET TAGS ('pii_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_subdomain' = 'revenue_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_revenue_id` SET TAGS ('pii_business_glossary_term' = 'Premium Revenue Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Underwriter Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `accounting_period` SET TAGS ('pii_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `accounting_period` SET TAGS ('pii_value_regex' = '^d{4}Q[1-4]$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `capitation_amount` SET TAGS ('pii_business_glossary_term' = 'Capitation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `coverage_period_months` SET TAGS ('pii_business_glossary_term' = 'Coverage Period (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `deficiency_reserve` SET TAGS ('pii_business_glossary_term' = 'Deficiency Reserve');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `earned_premium` SET TAGS ('pii_business_glossary_term' = 'Earned Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fiscal_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `hcc_score` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `hcc_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `hcc_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `is_capitated` SET TAGS ('pii_business_glossary_term' = 'Capitation Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|group|government|employer');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `mlr_denominator_flag` SET TAGS ('pii_business_glossary_term' = 'MLR Denominator Inclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `net_earned_premium` SET TAGS ('pii_business_glossary_term' = 'Net Earned Premium');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_record_number` SET TAGS ('pii_business_glossary_term' = 'Premium Record Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_record_number` SET TAGS ('pii_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_record_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_revenue_status` SET TAGS ('pii_business_glossary_term' = 'Premium Revenue Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_revenue_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_tax_base` SET TAGS ('pii_business_glossary_term' = 'Premium Tax Base');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_type` SET TAGS ('pii_business_glossary_term' = 'Premium Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `premium_type` SET TAGS ('pii_value_regex' = 'written|earned|adjustment|reinsurance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Inclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `reinsurance_ceded_premium` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Ceded Premium');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `reinsurance_ceded_premium` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `reinsurance_ceded_premium` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `reinsurance_ceded_premium` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `reinsurance_ceded_premium` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `revenue_date` SET TAGS ('pii_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `risk_corridor_adjustment` SET TAGS ('pii_business_glossary_term' = 'Risk Corridor Adjustment (3Rs)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `unearned_premium_reserve` SET TAGS ('pii_business_glossary_term' = 'Unearned Premium Reserve');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `vbc_shared_savings_amount` SET TAGS ('pii_business_glossary_term' = 'Value‑Based Care Shared Savings Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `written_premium` SET TAGS ('pii_business_glossary_term' = 'Written Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_subdomain' = 'revenue_settlement');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_id` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (CREATED_BY_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurer Identifier (REINSURER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Treaty Identifier (TREATY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `attachment_point_amount` SET TAGS ('pii_business_glossary_term' = 'Attachment Point Amount (ATTACHMENT_POINT_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `attachment_point_type` SET TAGS ('pii_business_glossary_term' = 'Attachment Point Type (ATTACHMENT_POINT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `business_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Business Event Timestamp (BUSINESS_EVENT_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `ceded_loss_amount` SET TAGS ('pii_business_glossary_term' = 'Ceded Loss Amount (CEDED_LOSS_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `ceded_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Ceded Premium Amount (CEDED_PREMIUM_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date (COVERAGE_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date (COVERAGE_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description (DESCRIPTION)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reinsurance_transaction_description` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_adjusted` SET TAGS ('pii_business_glossary_term' = 'Adjustment Indicator (IS_ADJUSTED)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_assumed` SET TAGS ('pii_business_glossary_term' = 'Assumed Indicator (IS_ASSUMED)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_ceded` SET TAGS ('pii_business_glossary_term' = 'Ceded Indicator (IS_CEDED)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_excess` SET TAGS ('pii_business_glossary_term' = 'Excess Indicator (IS_EXCESS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_partial_settlement` SET TAGS ('pii_business_glossary_term' = 'Partial Settlement Indicator (IS_PARTIAL_SETTLEMENT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_quota_share` SET TAGS ('pii_business_glossary_term' = 'Quota‑Share Indicator (IS_QUOTA_SHARE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `is_stop_loss` SET TAGS ('pii_business_glossary_term' = 'Stop‑Loss Indicator (IS_STOP_LOSS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `limit_amount` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Limit Amount (LIMIT_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `limit_type` SET TAGS ('pii_business_glossary_term' = 'Limit Type (LIMIT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Transaction Amount (NET_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `rbc_credit_amount` SET TAGS ('pii_business_glossary_term' = 'Risk Based Capital Credit Amount (RBC_CREDIT_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created (RECORD_AUDIT_CREATED)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated (RECORD_AUDIT_UPDATED)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `recovery_amount` SET TAGS ('pii_business_glossary_term' = 'Recovery Amount (RECOVERY_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `reporting_category` SET TAGS ('pii_business_glossary_term' = 'Reporting Category (REPORTING_CATEGORY)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RISK_ADJUSTMENT_FACTOR)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `risk_factor_code` SET TAGS ('pii_business_glossary_term' = 'Risk Factor Code (RISK_FACTOR_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `risk_factor_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `sap_schedule_f_flag` SET TAGS ('pii_business_glossary_term' = 'SAP Schedule F Flag (SAP_SCHEDULE_F_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `sap_schedule_f_flag` SET TAGS ('pii_value_regex' = 'Y|N');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date (SETTLEMENT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `settlement_status` SET TAGS ('pii_business_glossary_term' = 'Settlement Status (SETTLEMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `settlement_status` SET TAGS ('pii_value_regex' = 'pending|settled|rejected|partial');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Number (TRANSACTION_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_business_glossary_term' = 'Transaction Lifecycle Status (TRANSACTION_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_value_regex' = 'draft|open|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Transaction Type (TRANSACTION_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_value_regex' = 'ceded_premium|ceded_loss|recovery|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_type_code` SET TAGS ('pii_business_glossary_term' = 'Transaction Type Code (TRANSACTION_TYPE_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `transaction_type_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Originating Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_transaction_intercompany_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `accounting_period` SET TAGS ('pii_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_adjustment` SET TAGS ('pii_business_glossary_term' = 'Transaction Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_gross` SET TAGS ('pii_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_net` SET TAGS ('pii_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `consolidation_period` SET TAGS ('pii_business_glossary_term' = 'Consolidation Period Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('pii_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `division_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('pii_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('pii_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_month` SET TAGS ('pii_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_elimination_status` SET TAGS ('pii_business_glossary_term' = 'Intercompany Elimination Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_elimination_status` SET TAGS ('pii_value_regex' = 'pending|completed|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('pii_business_glossary_term' = 'Intercompany Transaction Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('pii_value_regex' = 'draft|open|posted|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `is_budgeted` SET TAGS ('pii_business_glossary_term' = 'Budgeted Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `is_foreign_currency` SET TAGS ('pii_business_glossary_term' = 'Foreign Currency Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `is_statistical` SET TAGS ('pii_business_glossary_term' = 'Statistical Transaction Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posted_flag` SET TAGS ('pii_business_glossary_term' = 'Posted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_code` SET TAGS ('pii_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `related_document_number` SET TAGS ('pii_business_glossary_term' = 'Related Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `related_document_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `source_module` SET TAGS ('pii_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_category` SET TAGS ('pii_business_glossary_term' = 'Transaction Category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_category` SET TAGS ('pii_value_regex' = 'operating|capital|investment|tax|other');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_purpose` SET TAGS ('pii_business_glossary_term' = 'Transaction Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_subtype` SET TAGS ('pii_business_glossary_term' = 'Transaction Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_subtype` SET TAGS ('pii_value_regex' = 'interest|principal|fee|royalty|other');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('pii_value_regex' = 'management_fee|cost_allocation|intercompany_loan|dividend|service_charge');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_fhir_resource' = 'Account');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_close_date` SET TAGS ('pii_business_glossary_term' = 'Account Closing Date (ACCOUNT_CLOSE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('pii_business_glossary_term' = 'Account Holder Name (ACCOUNT_HOLDER_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number (ACCOUNT_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_open_date` SET TAGS ('pii_business_glossary_term' = 'Account Opening Date (ACCOUNT_OPEN_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('pii_business_glossary_term' = 'Account Purpose / Classification (ACCOUNT_PURPOSE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Bank Account Type (ACCOUNT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'operating|lockbox|payroll|claims_disbursement|fsa_custodial|hsa_custodial');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_business_glossary_term' = 'Bank Account Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Bank Name (BANK_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_business_glossary_term' = 'Bank Statement Balance (BANK_STATEMENT_BALANCE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `deposits_in_transit` SET TAGS ('pii_business_glossary_term' = 'Deposits In Transit Amount (DEPOSITS_IN_TRANSIT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_business_glossary_term' = 'Account Description (DESCRIPTION)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective End Date (EFFECTIVE_TO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `gl_balance` SET TAGS ('pii_business_glossary_term' = 'General Ledger Balance (GL_BALANCE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_claims_disbursement_account` SET TAGS ('pii_business_glossary_term' = 'Claims Disbursement Account Indicator (IS_CLAIMS_DISBURSEMENT_ACCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_custodial_account` SET TAGS ('pii_business_glossary_term' = 'Custodial Account Indicator (IS_CUSTODIAL_ACCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_joint_account` SET TAGS ('pii_business_glossary_term' = 'Joint Account Indicator (IS_JOINT_ACCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_lockbox` SET TAGS ('pii_business_glossary_term' = 'Lockbox Account Indicator (IS_LOCKBOX)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_operating_account` SET TAGS ('pii_business_glossary_term' = 'Operating Account Indicator (IS_OPERATING_ACCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_payroll_account` SET TAGS ('pii_business_glossary_term' = 'Payroll Account Indicator (IS_PAYROLL_ACCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `is_reconciled` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Flag (IS_RECONCILED)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Last Reconciliation Date (LAST_RECONCILIATION_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `outstanding_checks` SET TAGS ('pii_business_glossary_term' = 'Outstanding Checks Amount (OUTSTANDING_CHECKS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `reconciled_balance` SET TAGS ('pii_business_glossary_term' = 'Reconciled Balance (RECONCILED_BALANCE)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_period_end` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period End Date (RECONCILIATION_PERIOD_END)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_period_start` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period Start Date (RECONCILIATION_PERIOD_START)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status (RECONCILIATION_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|completed|exception');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number (ROUTING_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Signatory Name (SIGNATORY_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `unreconciled_items_amount` SET TAGS ('pii_business_glossary_term' = 'Unreconciled Items Amount (UNRECONCILED_ITEMS_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Bank Reconciliation ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Preparer ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_business_glossary_term' = 'Bank Statement Balance (BANK_STMT_BAL)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `deposits_in_transit_amount` SET TAGS ('pii_business_glossary_term' = 'Deposits In Transit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_balance` SET TAGS ('pii_business_glossary_term' = 'General Ledger Balance (GL_BAL)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `is_adjusted` SET TAGS ('pii_business_glossary_term' = 'Is Adjusted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_checks_amount` SET TAGS ('pii_business_glossary_term' = 'Outstanding Checks Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciled_balance` SET TAGS ('pii_business_glossary_term' = 'Reconciled Balance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Number (RECON_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_period_end` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_period_start` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|failed|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_value_regex' = 'cash|bank|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `unreconciled_items_amount` SET TAGS ('pii_business_glossary_term' = 'Unreconciled Items Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_subdomain' = 'risk_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_filing_id` SET TAGS ('pii_business_glossary_term' = 'Tax Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `prior_filing_tax_filing_id` SET TAGS ('pii_business_glossary_term' = 'Prior Filing Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `audit_user` SET TAGS ('pii_business_glossary_term' = 'Audit User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `audit_user_update` SET TAGS ('pii_business_glossary_term' = 'Audit User Update Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `confirmation_number` SET TAGS ('pii_business_glossary_term' = 'Filing Confirmation Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `confirmation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `estimated_payments_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Payments Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_description` SET TAGS ('pii_business_glossary_term' = 'Filing Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_error_code` SET TAGS ('pii_business_glossary_term' = 'Filing Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_error_description` SET TAGS ('pii_business_glossary_term' = 'Filing Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_method` SET TAGS ('pii_business_glossary_term' = 'Filing Method (Electronic, Paper, Fax)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_method` SET TAGS ('pii_value_regex' = 'electronic|paper|fax');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_business_glossary_term' = 'Filing Number (FILING_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_source_system` SET TAGS ('pii_business_glossary_term' = 'Filing Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_value_regex' = 'draft|submitted|accepted|rejected|closed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('pii_business_glossary_term' = 'Filing Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `final_tax_due_amount` SET TAGS ('pii_business_glossary_term' = 'Final Tax Due Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `is_amended` SET TAGS ('pii_business_glossary_term' = 'Is Amended Filing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `is_filed` SET TAGS ('pii_business_glossary_term' = 'Is Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Payment Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Tax Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Tax Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'check|wire|eft|credit|cash');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_received_date` SET TAGS ('pii_business_glossary_term' = 'Tax Payment Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Tax Payment Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `payment_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_category` SET TAGS ('pii_business_glossary_term' = 'Tax Category (Income, Premium, Fee, 1099)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_category` SET TAGS ('pii_value_regex' = 'income|premium|fee|1099');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_form_code` SET TAGS ('pii_business_glossary_term' = 'Tax Form Code (e.g., 1120, 1099-MISC)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_form_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('pii_business_glossary_term' = 'Tax Jurisdiction Code (State or Jurisdiction Code)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_liability_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Liability Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_payment_status` SET TAGS ('pii_business_glossary_term' = 'Tax Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_payment_status` SET TAGS ('pii_value_regex' = 'pending|paid|partial|failed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_type` SET TAGS ('pii_business_glossary_term' = 'Tax Type (e.g., Federal, State, Local)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_type` SET TAGS ('pii_value_regex' = 'federal|state|local|other');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `tax_year` SET TAGS ('pii_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `taxable_base_amount` SET TAGS ('pii_business_glossary_term' = 'Taxable Base Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_subdomain' = 'risk_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('pii_business_glossary_term' = 'Parent Legal Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Annual Revenue');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Bank Account Currency');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_currency` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_type` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Bank Account Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_account_type` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Bank Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Legal Entity City');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Compliance Notes');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Country');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `country` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_to` SET TAGS ('pii_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fax` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Fax');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fax` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fax` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_employer_identification_number` SET TAGS ('pii_business_glossary_term' = 'Federal Employer Identification Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_employer_identification_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_employer_identification_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_employer_identification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_tax_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_tax_identifier` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_tax_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `federal_tax_identifier` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `industry_code` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Industry Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `industry_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `industry_description` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Industry Description');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_status` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_type` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_status` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Legal Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_structure` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Legal Structure');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `naic_company_code` SET TAGS ('pii_business_glossary_term' = 'Naic Company Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `nature_of_business` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Nature Of Business');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `number_of_employees` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Number Of Employees');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Ownership Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Ownership Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Primary Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Primary Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Primary Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `registration_date` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Registration Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'Legal Entity State');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_employer_identification_number` SET TAGS ('pii_business_glossary_term' = 'State Employer Identification Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_employer_identification_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_employer_identification_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_employer_identification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_of_domicile` SET TAGS ('pii_business_glossary_term' = 'State Of Domicile');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_of_domicile` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_of_domicile` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_business_glossary_term' = 'State Tax Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_tax_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_exempt_certificate_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Tax Exempt Certificate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Tax Exempt Certificate Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_exempt_status` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Tax Exempt Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `website` SET TAGS ('pii_business_glossary_term' = 'Legal Entity Website');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_subdomain' = 'risk_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot_source_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot_duplicate_of' = 'compliance.compliance_regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot_master' = 'regulatory_filing');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot_canonical' = 'finance.finance_regulatory_filing');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('pii_ssot_concept' = 'finance_regulatory_filing');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `finance_regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Finance Regulatory Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `acceptance_confirmation_number` SET TAGS ('pii_business_glossary_term' = 'Acceptance Confirmation Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `acceptance_confirmation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `deficiency_notice_number` SET TAGS ('pii_business_glossary_term' = 'Deficiency Notice Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `deficiency_notice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `estimated_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Payment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Filing Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('pii_business_glossary_term' = 'Filing Category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('pii_value_regex' = 'Statutory|Tax|Regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_document_hash` SET TAGS ('pii_business_glossary_term' = 'Filing Document Hash');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_document_hash` SET TAGS ('pii_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_document_url` SET TAGS ('pii_business_glossary_term' = 'Filing Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_is_amended` SET TAGS ('pii_business_glossary_term' = 'Filing Is Amended Flag');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_period_end` SET TAGS ('pii_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_period_start` SET TAGS ('pii_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Filing Rejection Reason');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_review_comments` SET TAGS ('pii_business_glossary_term' = 'Filing Review Comments');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_source_system` SET TAGS ('pii_business_glossary_term' = 'Filing Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('pii_value_regex' = 'pending|submitted|accepted|rejected|closed');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_status_detail` SET TAGS ('pii_business_glossary_term' = 'Filing Status Detail');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_submission_method` SET TAGS ('pii_business_glossary_term' = 'Filing Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_submission_method` SET TAGS ('pii_value_regex' = 'Electronic|Paper');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_submission_reference` SET TAGS ('pii_business_glossary_term' = 'Filing Submission Reference');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('pii_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('pii_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('pii_value_regex' = 'NAIC_Annual|NAIC_Quarterly|CMS_MLR|State_DOI|RBC|IRS_Tax');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `filing_version` SET TAGS ('pii_business_glossary_term' = 'Filing Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `final_tax_due_amount` SET TAGS ('pii_business_glossary_term' = 'Final Tax Due Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `jurisdiction_code` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `jurisdiction_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `jurisdiction_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'CMS|NAIC|IRS|State_DOI|HHS');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `tax_liability_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Liability Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `tax_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `taxable_base_amount` SET TAGS ('pii_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
