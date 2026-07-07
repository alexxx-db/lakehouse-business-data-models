-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`finance` COMMENT 'Enterprise financial management including general ledger, accounts payable and receivable, cost center accounting, capital and operating budgets, financial reporting, rate case preparation, GASB compliance, grant management, debt service tracking, and financial planning and analysis. Integrates with SAP FI/CO and Tyler Munis for fund accounting and municipal financial statements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Primary key. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'FK to fund. Ref: AWWA.',
    `parent_general_ledger_id` BIGINT COMMENT 'Parent account for hierarchy. Ref: AWWA.',
    `account_category` STRING COMMENT 'Sub-category within account type. Ref: AWWA.',
    `account_code` STRING COMMENT 'GL account code. Ref: AWWA.',
    `account_description` STRING COMMENT 'Description of account. Ref: AWWA.',
    `account_level` STRING COMMENT 'Hierarchy level. Ref: AWWA.',
    `account_name` STRING COMMENT 'Account name. Ref: AWWA.',
    `account_number` STRING COMMENT 'Full GL account number with segment concatenation. Ref: AWWA.',
    `account_status` STRING COMMENT 'Active/Inactive. Ref: AWWA.',
    `account_subtype` STRING COMMENT 'Subtype classification. Ref: AWWA.',
    `account_type` STRING COMMENT 'Asset/Liability/Revenue/Expense. Ref: AWWA.',
    `allow_manual_journal` BOOLEAN COMMENT 'Allow manual journal entries. Ref: AWWA.',
    `consolidation_account` STRING COMMENT 'Consolidation account for reporting. Ref: AWWA.',
    `created_date` TIMESTAMP COMMENT 'Date created. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `currency_code` STRING COMMENT 'ISO currency code',
    `effective_end_date` TIMESTAMP COMMENT 'End date. Ref: AWWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Start date. Ref: AWWA.',
    `external_reporting_code` STRING COMMENT 'External code. Ref: AWWA.',
    `financial_statement_line` STRING COMMENT 'Mapping to financial statement line item. Ref: AWWA.',
    `fund_type` STRING COMMENT 'Fund type. Ref: AWWA.',
    `gasb_category` STRING COMMENT 'GASB classification. Ref: AWWA.',
    `gasb_classification` STRING COMMENT 'GASB 34 classification code. Ref: AWWA.',
    `is_active` BOOLEAN COMMENT 'Active flag. Ref: AWWA.',
    `is_budget_controlled` BOOLEAN COMMENT 'Budget control flag. Ref: AWWA.',
    `is_budgeted` BOOLEAN COMMENT 'Whether account is budgeted. Ref: AWWA.',
    `is_capital_expenditure` BOOLEAN COMMENT 'CapEx flag. Ref: AWWA.',
    `is_grant_eligible` BOOLEAN COMMENT 'Grant eligible flag. Ref: AWWA.',
    `is_operating_expenditure` BOOLEAN COMMENT 'OpEx flag. Ref: AWWA.',
    `is_posting_allowed` BOOLEAN COMMENT 'Posting allowed flag. Ref: AWWA.',
    `is_rate_case_eligible` DECIMAL(18,2) COMMENT 'Rate case eligible. Ref: AWWA.',
    `is_reconciliation_required` BOOLEAN COMMENT 'Reconciliation required flag. Ref: AWWA.',
    `is_restricted` BOOLEAN COMMENT 'Restricted use flag. Ref: AWWA.',
    `is_summary_account` BOOLEAN COMMENT 'Summary account flag. Ref: AWWA.',
    `last_modified_by` STRING COMMENT 'Last modified by user. Ref: AWWA.',
    `last_modified_date` TIMESTAMP COMMENT 'Last modified date. Ref: AWWA.',
    `normal_balance` DECIMAL(18,2) COMMENT 'Debit/Credit. Ref: AWWA.',
    `notes` STRING COMMENT 'Notes. Ref: AWWA.',
    `profit_center_code` STRING COMMENT 'Profit center code. Ref: AWWA.',
    `requires_grant` BOOLEAN COMMENT 'Whether grant dimension is required. Ref: AWWA.',
    `requires_project` BOOLEAN COMMENT 'Whether project dimension is required. Ref: AWWA.',
    `sap_company_code` STRING COMMENT 'SAP company code. Ref: AWWA.',
    `statistical_account_flag` BOOLEAN COMMENT 'Statistical account flag. Ref: AWWA.',
    `tax_code` STRING COMMENT 'Tax code. Ref: AWWA.',
    `tyler_munis_account_code` BOOLEAN COMMENT 'Tyler Munis code. Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measure. Ref: AWWA.',
    `updated_by` STRING COMMENT 'Updated by user. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `created_by` STRING COMMENT 'Created by user. Ref: AWWA.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'Chart of accounts master for general ledger accounts used in journal entries, budgets, and financial reporting. Supports GASB fund accounting, cost center allocation, and rate case eligibility tracking. Integrates with SAP FI, Tyler Munis, and Oracle EBS.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`fund` (
    `fund_id` BIGINT COMMENT 'Primary key. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center. Ref: AWWA.',
    `parent_fund_id` BIGINT COMMENT 'Parent fund for sub-funds. Ref: AWWA.',
    `appropriation_authority` STRING COMMENT 'Appropriation authority. Ref: AWWA.',
    `appropriation_date` TIMESTAMP COMMENT 'Appropriation date. Ref: AWWA.',
    `balance_policy` DECIMAL(18,2) COMMENT 'Balance policy. Ref: AWWA.',
    `budget_cycle` STRING COMMENT 'Annual, Biennial. Ref: AWWA.',
    `capital_project_name` STRING COMMENT 'Capital project name. Ref: AWWA.',
    `fund_category` STRING COMMENT 'Governmental or Proprietary. Ref: AWWA.',
    `closed_date` TIMESTAMP COMMENT 'Closed date. Ref: AWWA.',
    `closure_reason` STRING COMMENT 'Closure reason. Ref: AWWA.',
    `fund_code` STRING COMMENT 'Fund code. Ref: AWWA.',
    `component_unit_flag` BOOLEAN COMMENT 'Component unit flag. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp. Ref: AWWA.',
    `debt_service_bond_issue` STRING COMMENT 'Bond issue. Ref: AWWA.',
    `department_code` STRING COMMENT 'Department code. Ref: AWWA.',
    `fund_description` STRING COMMENT 'Fund description. Ref: AWWA.',
    `established_date` TIMESTAMP COMMENT 'Established date. Ref: AWWA.',
    `external_audit_required_flag` BOOLEAN COMMENT 'External audit required flag. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'Fiscal year. Ref: AWWA.',
    `fiscal_year_end_date` TIMESTAMP COMMENT 'Fiscal year end date. Ref: AWWA.',
    `fiscal_year_end_month` STRING COMMENT 'Fiscal year end month (1-12). Ref: AWWA.',
    `fiscal_year_start_date` TIMESTAMP COMMENT 'Fiscal year start date. Ref: AWWA.',
    `fund_balance_policy` STRING COMMENT 'Fund balance policy reference. Ref: AWWA.',
    `fund_status` STRING COMMENT 'Fund status. Ref: AWWA.',
    `fund_type` STRING COMMENT 'Fund type. Ref: AWWA.',
    `gasb_fund_classification` STRING COMMENT 'GASB classification. Ref: AWWA.',
    `gasb_fund_type_code` STRING COMMENT 'GASB fund type classification. Ref: AWWA.',
    `general_ledger_account_prefix` STRING COMMENT 'GL account prefix. Ref: AWWA.',
    `grant_award_number` STRING COMMENT 'Grant award number. Ref: AWWA.',
    `grant_program_name` STRING COMMENT 'Grant program name. Ref: AWWA.',
    `interfund_transfer_allowed_flag` BOOLEAN COMMENT 'Interfund transfer allowed flag. Ref: AWWA.',
    `is_active` BOOLEAN COMMENT 'Active flag. Ref: AWWA.',
    `is_enterprise_fund` BOOLEAN COMMENT 'Enterprise fund flag. Ref: AWWA.',
    `is_restricted` BOOLEAN COMMENT 'Restricted fund flag. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp. Ref: AWWA.',
    `manager_email` STRING COMMENT 'Manager email. Ref: AWWA.',
    `manager_name` STRING COMMENT 'Manager name. Ref: AWWA.',
    `maximum_balance_amount` DECIMAL(18,2) COMMENT 'Maximum allowed balance. Ref: AWWA.',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'Minimum required balance. Ref: AWWA.',
    `minimum_fund_balance_amount` DECIMAL(18,2) COMMENT 'Minimum fund balance amount. Ref: AWWA.',
    `minimum_fund_balance_percentage` DECIMAL(18,2) COMMENT 'Minimum fund balance percentage. Ref: AWWA.',
    `fund_name` STRING COMMENT 'Fund name. Ref: AWWA.',
    `notes` STRING COMMENT 'Notes. Ref: AWWA.',
    `rate_case_inclusion_flag` DECIMAL(18,2) COMMENT 'Rate case inclusion flag. Ref: AWWA.',
    `reporting_entity` STRING COMMENT 'Reporting entity. Ref: AWWA.',
    `reserve_requirement_pct` DECIMAL(18,2) COMMENT 'Reserve requirement percentage. Ref: AWWA.',
    `restricted_purpose` STRING COMMENT 'Restricted purpose. Ref: AWWA.',
    `restriction_purpose` STRING COMMENT 'Purpose of restriction. Ref: AWWA.',
    `updated_by` STRING COMMENT 'Updated by user. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `created_by` STRING COMMENT 'Created by user. Ref: AWWA.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'GASB fund master for governmental fund accounting. Tracks fund type, fiscal year, balance policy, and grant/debt service associations. Supports enterprise, capital project, debt service, and special revenue funds.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key. Ref: AWWA.',
    `parent_cost_center_id` BIGINT COMMENT 'FK to parent cost center. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key to fund. Ref: AWWA.',
    `org_unit_id` BIGINT COMMENT 'Foreign key to organizational unit. Ref: AWWA.',
    `activity_type` STRING COMMENT 'Activity type. Ref: AWWA.',
    `allocation_basis` STRING COMMENT 'Allocation basis (volume, connections, labor hours). Ref: AWWA.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Annual budget amount. Ref: AWWA.',
    `asset_class` STRING COMMENT 'Asset class. Ref: AWWA.',
    `budget_authority_level` STRING COMMENT 'Budget authority level. Ref: AWWA.',
    `budget_currency_code` STRING COMMENT 'Budget currency code. Ref: AWWA.',
    `budget_profile` STRING COMMENT 'Budget profile. Ref: AWWA.',
    `business_area` STRING COMMENT 'Business area. Ref: AWWA.',
    `capex_opex_split_percentage` DECIMAL(18,2) COMMENT 'CapEx OpEx split percentage. Ref: AWWA.',
    `cost_center_category` DECIMAL(18,2) COMMENT 'Cost center category. Ref: AWWA.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code. Ref: AWWA.',
    `company_code` STRING COMMENT 'Company code. Ref: AWWA.',
    `controlling_area` STRING COMMENT 'Controlling area. Ref: AWWA.',
    `cost_allocation_method` DECIMAL(18,2) COMMENT 'Cost allocation method. Ref: AWWA.',
    `cost_center_status` DECIMAL(18,2) COMMENT 'Cost center status. Ref: AWWA.',
    `cost_center_type` DECIMAL(18,2) COMMENT 'Cost center type. Ref: AWWA.',
    `cost_element_group` DECIMAL(18,2) COMMENT 'Cost element group. Ref: AWWA.',
    `cost_pool` STRING COMMENT 'Cost pool for allocation. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'Created by user. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp. Ref: AWWA.',
    `department_code` STRING COMMENT 'Department code. Ref: AWWA.',
    `cost_center_description` DECIMAL(18,2) COMMENT 'Cost center description. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Effective end date. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Effective start date. Ref: AWWA.',
    `functional_area` STRING COMMENT 'Functional area. Ref: AWWA.',
    `geographic_region` STRING COMMENT 'Geographic region. Ref: AWWA.',
    `grant_eligible_flag` BOOLEAN COMMENT 'Grant eligible flag. Ref: AWWA.',
    `hierarchy_level` STRING COMMENT 'Hierarchy level. Ref: AWWA.',
    `is_active` BOOLEAN COMMENT 'Active flag. Ref: AWWA.',
    `is_direct_cost_center` BOOLEAN COMMENT 'Direct vs indirect cost center. Ref: AWWA.',
    `is_rate_base_eligible` BOOLEAN COMMENT 'Eligible for rate base inclusion. Ref: AWWA.',
    `last_modified_by_user` STRING COMMENT 'Last modified by user. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp. Ref: AWWA.',
    `location_code` STRING COMMENT 'Location code. Ref: AWWA.',
    `cost_center_name` DECIMAL(18,2) COMMENT 'Cost center name. Ref: AWWA.',
    `notes` STRING COMMENT 'Notes. Ref: AWWA.',
    `overhead_rate_percentage` DECIMAL(18,2) COMMENT 'Overhead rate percentage. Ref: AWWA.',
    `profit_center_code` STRING COMMENT 'Profit center code. Ref: AWWA.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Regulatory reporting flag. Ref: AWWA.',
    `updated_by` STRING COMMENT 'Updated by user. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `valid_from_date` TIMESTAMP COMMENT 'Valid from date. Ref: AWWA.',
    `valid_to_date` TIMESTAMP COMMENT 'Valid to date. Ref: AWWA.',
    `created_by` STRING COMMENT 'Created by user. Ref: AWWA.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master for internal cost allocation and management accounting. Supports hierarchical cost center structures, budget tracking, and overhead rate calculation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry header record. Primary key for the journal entry entity. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'The capital project or work breakdown structure (WBS) element identifier if this journal entry is associated with a specific capital improvement program (CIP) project. Used for project cost tracking and capitalization. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'The primary cost center or responsibility center to which this journal entry is assigned for management reporting. Cost centers may represent operational divisions such as water treatment plant (WTP), wastewater treatment plant (WWTP), distribution operations, customer service, or administrative functions. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Journal entries are posted to funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'The grant or award identifier if this journal entry is associated with a specific grant-funded project or program (e.g., EPA State Revolving Fund, USDA Rural Development grant). Used for grant accounting and compliance reporting. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Approved by employee. Ref: AWWA.',
    `journal_created_by_employee_id` BIGINT COMMENT 'Created by employee. Ref: AWWA.',
    `journal_posted_by_employee_id` BIGINT COMMENT 'Posted by employee. Ref: AWWA.',
    `recurring_entry_template_id` BIGINT COMMENT 'The identifier of the recurring journal entry template used to generate this entry, if applicable. Recurring templates are used for repetitive monthly postings such as depreciation, amortization, or allocated overhead costs. Ref: AWWA.',
    `reversed_by_journal_entry_id` BIGINT COMMENT 'Reversing journal entry. Ref: AWWA.',
    `accounting_period` STRING COMMENT 'The fiscal period (1-12 for monthly periods, or 1-13 for utilities using a 13-period calendar) to which this journal entry is posted. Used for period-level financial reporting and closing processes. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Approval date. Ref: AWWA.',
    `approved_by_user` STRING COMMENT 'The user ID or username of the person who approved this journal entry for posting. Populated only after the entry has been approved. Used for segregation of duties and audit trail. Ref: AWWA.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was approved for posting. Populated only after approval. Used for audit trail and to track approval timing. Ref: AWWA.',
    `attachment_count` STRING COMMENT 'The number of supporting documents or attachments linked to this journal entry (e.g., scanned invoices, approval memos, spreadsheets). Used to indicate availability of supporting documentation for audit purposes. Ref: AWWA.',
    `batch_number` STRING COMMENT 'The batch or session identifier for grouped journal entries that were posted together as part of a single processing run (e.g., month-end closing batch, payroll posting batch, billing cycle batch). Used for batch-level reconciliation and audit. Ref: AWWA.',
    `business_area` STRING COMMENT 'Optional cross-company code organizational segment used for internal management reporting. May represent water treatment, wastewater treatment, distribution, or other operational divisions within the utility. Ref: AWWA.',
    `company_code` STRING COMMENT 'The organizational unit or legal entity code to which this journal entry belongs. In SAP ERP, the company code represents an independent accounting entity. Water utilities may have multiple company codes for different service territories or subsidiaries. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by_user` STRING COMMENT 'The user ID or username of the person who created or entered this journal entry in the financial system. Used for audit trail and accountability. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was first created in the financial system. Used for audit trail and to track entry timing. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction currency of this journal entry (e.g., USD for US Dollar). Most water utilities operate in a single currency, but multi-national utilities may post in multiple currencies.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date the source document or transaction occurred, which may differ from the posting date. Used for audit trail and to track when the underlying business event took place. Ref: AWWA.',
    `document_number` STRING COMMENT 'Externally-known unique document number assigned to this journal entry by the source system (SAP FI document number or Tyler Munis posting document number). Used for audit trail and cross-system reconciliation. Ref: AWWA.. Valid values are `^[A-Z0-9]{8,20}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency amounts to local currency, if applicable. Populated only for journal entries involving foreign currency transactions. Ref: AWWA.',
    `fiscal_period` STRING COMMENT 'Fiscal period (1-12). Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) to which this journal entry is posted. Water utilities may operate on a calendar year or a fiscal year ending June 30 or other date depending on municipal requirements. Ref: AWWA.',
    `functional_area` STRING COMMENT 'The functional classification of this journal entry for governmental financial reporting (e.g., water supply, wastewater treatment, administration, debt service). Used to prepare functional expense statements per GASB requirements. Ref: AWWA.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry involves intercompany or inter-fund transactions between different legal entities or funds within the water utility organization. True if intercompany, false otherwise. Ref: AWWA.',
    `journal_entry_date` DATE COMMENT 'Journal entry date. Ref: AWWA.',
    `journal_entry_description` STRING COMMENT 'Narrative description or memo text explaining the business purpose and nature of this journal entry. Provides context for auditors, accountants, and financial analysts reviewing the posting. Ref: AWWA.',
    `journal_entry_number` STRING COMMENT 'Journal entry number. Ref: AWWA.',
    `journal_source` STRING COMMENT 'Manual, AP, AR, Payroll, Depreciation, Accrual. Ref: AWWA.',
    `journal_status` STRING COMMENT 'Draft, Posted, Reversed. Ref: AWWA.',
    `journal_type` STRING COMMENT 'Classification of the journal entry by its accounting purpose: standard (regular operational postings), adjusting (period-end accruals and deferrals), closing (fiscal year-end closing entries), reversing (automatic reversal of prior accruals), recurring (template-based repetitive entries), or statistical (non-financial postings for cost allocation). Ref: AWWA.. Valid values are `standard|adjusting|closing|reversing|recurring|statistical`',
    `line_item_count` STRING COMMENT 'The number of individual line items (debits and credits) contained in this journal entry header. Used for validation and summary reporting. Ref: AWWA.',
    `modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this journal entry record. Used for audit trail and change tracking. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was last modified. Used for audit trail and change tracking. Ref: AWWA.',
    `originating_module` STRING COMMENT 'The source system module or sub-ledger that generated this journal entry. GL (General Ledger) for manual entries, AP (Accounts Payable) for vendor invoice postings, AR (Accounts Receivable) for customer billing, FA (Fixed Assets) for depreciation, PM (Plant Maintenance) for work order capitalization, MM (Materials Management) for inventory transactions, HR/payroll for labor cost allocation, billing for revenue recognition, asset_accounting for capital asset transactions, or manual for ad-hoc adjustments. [ENUM-REF-CANDIDATE: GL|AP|AR|FA|PM|MM|HR|payroll|billing|asset_accounting|manual — 11 candidates stripped; promote to reference product]. Ref: AWWA.',
    `posted_by_user` STRING COMMENT 'The user ID or username of the person who posted this journal entry to the general ledger. Populated only after the entry has been posted. Used for audit trail and accountability. Ref: AWWA.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was posted to the general ledger. Populated only after posting. Used for audit trail and to track posting timing. Ref: AWWA.',
    `posting_date` DATE COMMENT 'The accounting date on which this journal entry is posted to the general ledger. Determines the fiscal period and year for financial reporting. Must fall within an open accounting period. Ref: AWWA.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry in the approval and posting workflow. Draft entries are being prepared, pending approval entries await authorization, approved entries are ready for posting, posted entries have been committed to the general ledger, reversed entries have been backed out, and rejected entries were denied approval. Ref: AWWA.. Valid values are `draft|pending_approval|approved|posted|reversed|rejected`',
    `profit_center_code` BIGINT COMMENT 'The profit center or business segment to which this journal entry is assigned for internal profitability analysis. Profit centers may represent water services, wastewater services, industrial customer segment, or geographic service territories. Ref: AWWA.',
    `reference_number` STRING COMMENT 'External reference number or identifier from the source transaction or document (e.g., invoice number, work order number, payroll batch ID, grant award number). Provides traceability back to the originating business event. Ref: AWWA.',
    `reversal_date` DATE COMMENT 'The posting date on which this journal entry will be automatically reversed, if applicable. Used for accrual entries that should reverse in the subsequent accounting period. Ref: AWWA.',
    `reversal_flag` BOOLEAN COMMENT 'Reversal entry flag. Ref: AWWA.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a prior entry. True if this entry reverses a previous posting (e.g., reversing an accrual in the subsequent period), false otherwise. Ref: AWWA.',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is true. Used to maintain audit trail of reversing entries. Ref: AWWA.',
    `tax_code` STRING COMMENT 'The tax jurisdiction or tax type code if this journal entry involves tax calculations (e.g., sales tax on materials purchases, use tax, property tax accruals). Used for tax reporting and compliance. Ref: AWWA.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit line item amounts in this journal entry. Must equal total_debit_amount to maintain double-entry accounting balance. Ref: AWWA.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit line item amounts in this journal entry. Must equal total_credit_amount to maintain double-entry accounting balance. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry document capturing all financial postings in the water utilitys books, including both header metadata and individual debit/credit line items. Header captures journal type (standard, adjusting, closing, reversing), posting date, accounting period, fiscal year, originating module, document number, posting user, approval status, and narrative. Each line item records GL account, fund, cost center, WBS element, functional area, debit/credit indicator, amount in transaction and functional currency, tax code, and line text. Supports full double-entry bookkeeping, GASB fund-level reporting, and integration with SAP FI and Tyler Munis posting documents.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key to CIP project. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key reference to the fixed asset associated with this line item. Used for asset acquisitions, disposals, depreciation, and capital project closeouts. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Journal entry lines are posted to funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Journal entry lines post to GL accounts. The gl_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Foreign key reference to the grant or restricted funding source. Used for tracking grant expenditures, compliance reporting, and restricted fund accounting. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the business partner (vendor, customer, employee) associated with this line item. Used for accounts payable, accounts receivable, and payroll transactions. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'User ID of the person or system account that created this journal entry line. Used for audit trail and accountability. Ref: AWWA.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key reference to the parent journal entry header. Links this line item to its containing journal entry batch. Ref: AWWA.',
    `journal_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person or system account that last modified this journal entry line. Null if never modified after creation. Ref: AWWA.',
    `journal_vendor_id` BIGINT COMMENT 'Foreign key reference to the business partner (vendor, customer, employee) associated with this line item. Used for accounts payable, accounts receivable, and payroll transactions. Ref: AWWA.',
    `primary_journal_employee_id` BIGINT COMMENT 'User ID of the person or system account that created this journal entry line. Used for audit trail and accountability. Ref: AWWA.',
    `document_id` BIGINT COMMENT 'Reference document ID. Ref: AWWA.',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the fixed asset associated with this line item. Used for asset acquisitions, disposals, depreciation, and capital project closeouts. Ref: AWWA.',
    `reversed_line_journal_entry_line_id` BIGINT COMMENT 'Foreign key reference to the original journal entry line that this entry reverses. Null for non-reversal entries. Ref: AWWA.',
    `allocation_indicator` BOOLEAN COMMENT 'Indicates whether this line item was created through an automated allocation or distribution process. True for allocated entries, false for direct postings. Ref: AWWA.',
    `amount` DECIMAL(18,2) COMMENT 'Line amount. Ref: AWWA.',
    `clearing_date` DATE COMMENT 'Date when this open item was cleared or settled. Null for uncleared items. Ref: AWWA.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing entry that settled this open item. Used for accounts payable and receivable reconciliation. Null for uncleared items. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was first created in the system. Used for audit trail and data lineage. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Currency code. Ref: AWWA.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item is a debit (D) or credit (C) entry. Required for double-entry bookkeeping and ensuring balanced journal entries. Ref: AWWA.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'Date of the source document that originated this journal entry line. May differ from posting date for backdated or forward-dated transactions. Ref: AWWA.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert transaction amount to functional amount. Null if transaction and functional currencies are the same. Ref: AWWA.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year. Typically 1-12 for monthly periods, or 1-13 for utilities with a 13-period calendar. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this journal entry line is posted. Derived from posting date and fiscal calendar configuration. Ref: AWWA.',
    `functional_amount` DECIMAL(18,2) COMMENT 'Monetary amount converted to the utilitys functional (reporting) currency. Used for consolidated financial statements and GASB reporting when transaction currency differs from functional currency. Ref: AWWA.',
    `functional_area_code` STRING COMMENT 'Functional area classification for cross-organizational reporting. Examples include water treatment, wastewater treatment, distribution, collection, customer service, and administration. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,6}$`',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the functional amount. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `gl_account_description` STRING COMMENT 'Descriptive name of the general ledger account for human readability and reporting purposes. Ref: AWWA.',
    `internal_order_number` STRING COMMENT 'Internal order number for tracking specific operational or maintenance activities. Used for short-term cost collection and allocation. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,12}$`',
    `line_description` STRING COMMENT 'Line description. Ref: AWWA.',
    `line_item_text` STRING COMMENT 'Free-form descriptive text providing additional context for the journal entry line. Used for audit trails, explanations, and supporting documentation references. Ref: AWWA.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the ordering of debit and credit line items within a single journal entry. Ref: AWWA.',
    `manual_entry_indicator` BOOLEAN COMMENT 'Indicates whether this line item was manually entered by a user or automatically generated by the system. True for manual entries, false for system-generated entries. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was last modified. Null if never modified after creation. Ref: AWWA.',
    `posting_date` DATE COMMENT 'Date when the journal entry line was posted to the general ledger. Determines the fiscal period for financial reporting and period-end closing. Ref: AWWA.',
    `profit_center_code` STRING COMMENT 'Profit center code for segment reporting and internal management accounting. Used to track financial performance by business unit or service area. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that originated this journal entry line. Categorizes the business transaction for reporting and analysis. [ENUM-REF-CANDIDATE: invoice|purchase_order|payment|work_order|payroll|adjustment|accrual|reversal|allocation|other — 10 candidates stripped; promote to reference product]. Ref: AWWA.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal of a previous entry. True for reversal entries, false for original postings. Ref: AWWA.',
    `statistical_amount` DECIMAL(18,2) COMMENT 'Statistical quantity (e.g., gallons, connections). Ref: AWWA.',
    `statistical_unit` STRING COMMENT 'Statistical unit of measure. Ref: AWWA.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount associated with this line item in functional currency. Null if no tax applies. Ref: AWWA.',
    `tax_code` STRING COMMENT 'Tax code for sales tax, use tax, or other tax treatment applicable to this line item. Used for tax reporting and compliance. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,6}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner code for intercompany or inter-fund transactions. Used for consolidation and elimination entries in multi-entity utilities. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,6}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the line item in the transaction currency. Always recorded as a positive value; debit/credit indicator determines the accounting treatment. Ref: AWWA.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. Supports multi-currency accounting for utilities with international operations or foreign debt.. Valid values are `^[A-Z]{3}$`',
    `value_date` DATE COMMENT 'Value date for cash management and treasury operations. Represents the effective date for interest calculation and cash flow analysis. Ref: AWWA.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for capital improvement program (CIP) project tracking. Links line items to specific capital projects for CAPEX reporting and asset capitalization. Ref: AWWA.. Valid values are `^[A-Z0-9.-]{6,20}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit and credit line items within a general ledger journal entry. Captures GL account, fund, cost center, WBS element (for CIP projects), functional area, debit/credit indicator, amount in transaction currency and functional currency, tax code, and line item text. Supports full double-entry bookkeeping and GASB fund-level reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key. Ref: Oracle CC&B.',
    `employee_id` BIGINT COMMENT 'Approved by employee. Ref: Oracle CC&B.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: AP invoices for capital projects require direct project linkage for proper capitalization decisions, project cost tracking, and audit trails. Distinct from ap_payment→project which tracks cash disburs. Ref: Oracle CC&B.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoices are allocated to cost centers for expense tracking. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: Oracle CC&B.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: AP invoices are charged to specific funds in municipal accounting. The fund_code STRING should be replaced with a proper FK to fund.fund_id for referential integrity. Ref: Oracle CC&B.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AP invoices post to general ledger accounts. The general_ledger_account_code STRING should be replaced with FK to general_ledger.general_ledger_id for proper GL account referencing. Ref: Oracle CC&B.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to purchase order. Ref: Oracle CC&B.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who issued this invoice. Links to the vendor master record in the supply chain domain. Ref: Oracle CC&B.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Invoices reference work orders for three-way matching (PO/goods receipt/invoice) validation and cost verification. Essential for accounts payable controls and work order cost reconciliation in utility. Ref: Oracle CC&B.',
    `ap_invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides business context for the invoice. Ref: Oracle CC&B.',
    `approval_date` DATE COMMENT 'Approval date. Ref: Oracle CC&B.',
    `approval_status` STRING COMMENT 'The approval status of the invoice in the workflow. Indicates whether the invoice has been reviewed and approved for payment by authorized personnel. Ref: Oracle CC&B.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or user ID of the person who approved the invoice for payment. Ref: Oracle CC&B.',
    `approved_date` DATE COMMENT 'The date the invoice was approved for payment. Ref: Oracle CC&B.',
    `baseline_date` DATE COMMENT 'The baseline date used to calculate the payment due date based on payment terms. Typically the invoice date or goods receipt date. Ref: Oracle CC&B.',
    `company_code` STRING COMMENT 'The company code or legal entity within the water utility organization that is responsible for this invoice. Used in multi-entity ERP systems. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the source system. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount available if payment is made within the early payment discount period (e.g., 2% discount if paid within 10 days). Ref: Oracle CC&B.',
    `discount_due_date` DATE COMMENT 'The date by which payment must be made to qualify for the early payment discount. Ref: Oracle CC&B.',
    `dispute_date` DATE COMMENT 'The date the invoice was flagged as disputed. Ref: Oracle CC&B.',
    `dispute_reason` STRING COMMENT 'Free-text explanation of why the invoice is disputed, if invoice_status is disputed. Common reasons include pricing discrepancies, quantity variances, or quality issues. Ref: Oracle CC&B.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms. Ref: Oracle CC&B.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which this invoice is recorded. Ref: Oracle CC&B.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this invoice is recorded for financial reporting purposes. Ref: Oracle CC&B.',
    `form_1099_box` STRING COMMENT '1099 box number. Ref: Oracle CC&B.',
    `gl_posted_flag` BOOLEAN COMMENT 'GL posted flag. Ref: Oracle CC&B.',
    `gl_posting_date` DATE COMMENT 'GL posting date. Ref: Oracle CC&B.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming that materials or services were received. Used for three-way match validation. Ref: Oracle CC&B.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before taxes and discounts. Represents the base value of goods or services invoiced. Ref: Oracle CC&B.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Invoice total amount. Ref: Oracle CC&B.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice. Ref: Oracle CC&B.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the vendor. This is the externally-known business identifier for the invoice. Ref: Oracle CC&B.',
    `invoice_received_date` DATE COMMENT 'The date the water utility received the invoice from the vendor. Ref: Oracle CC&B.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: received|verified|approved|paid|disputed|cancelled|on_hold — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `invoice_type` STRING COMMENT 'The type of invoice document. Standard is a normal vendor invoice; credit memo is a vendor credit; debit memo is an additional charge; prepayment is an advance payment invoice; recurring is for subscription or periodic services. Ref: Oracle CC&B.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `is_1099_reportable` BOOLEAN COMMENT '1099 reportable flag. Ref: Oracle CC&B.',
    `is_capex` BOOLEAN COMMENT 'Boolean flag indicating whether this invoice is for capital expenditure (CAPEX) or operating expenditure (OPEX). True if CAPEX, False if OPEX. Ref: Oracle CC&B.',
    `is_recurring` BOOLEAN COMMENT 'Boolean flag indicating whether this is a recurring invoice (e.g., monthly utility bills, subscription services). True if recurring, False if one-time. Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified in the source system. Ref: Oracle CC&B.',
    `net_amount` DECIMAL(18,2) COMMENT 'The total amount payable to the vendor after applying taxes and discounts. This is the final payment amount. Ref: Oracle CC&B.',
    `payment_date` DATE COMMENT 'The date the invoice was paid to the vendor. Null if the invoice has not yet been paid. Ref: Oracle CC&B.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to pay this invoice (e.g., ACH, wire transfer, check, electronic funds transfer). Ref: Oracle CC&B.. Valid values are `ach|wire_transfer|check|credit_card|eft`',
    `payment_reference_number` STRING COMMENT 'The payment transaction reference number or check number used to pay this invoice. Ref: Oracle CC&B.',
    `payment_terms` STRING COMMENT 'The payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines the due date calculation and any early payment discount conditions. Ref: Oracle CC&B.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. This determines the fiscal period for financial reporting. Ref: Oracle CC&B.',
    `received_date` DATE COMMENT 'Invoice received date. Ref: Oracle CC&B.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the invoice (sales tax, use tax, VAT, etc.). Ref: Oracle CC&B.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing purchase order, goods receipt, and invoice. Matched indicates all three documents align within tolerance; variance indicates discrepancies requiring review. Ref: Oracle CC&B.. Valid values are `matched|variance|blocked|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: Oracle CC&B.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the payment to the vendor, if applicable (e.g., for certain service providers or international vendors). Ref: Oracle CC&B.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable lifecycle management for vendor invoices and payments at the water utility. Covers the full AP process: invoice receipt (vendor, invoice number, date, terms, amounts, PO reference, three-way match status), approval workflow, and payment execution (payment method — ACH/check/wire, payment date, bank account, cleared amount, discount taken, remittance details). Tracks chemicals, equipment, contractor services, and O&M supply procurement through to disbursement. Integrates with SAP FI payment program and Tyler Munis AP/check processing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` (
    `ap_payment_id` DECIMAL(18,2) COMMENT 'Unique identifier for the accounts payable payment transaction. Ref: Oracle CC&B.',
    `employee_id` BIGINT COMMENT 'Created by employee. Ref: Oracle CC&B.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: AP payments are made against AP invoices within the finance domain. Currently ap_payment.invoice_id points to finance.invoice (cross-domain), but payments against vendor invoices should reference fina. Ref: Oracle CC&B.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the utilitys bank account from which the payment was disbursed. Ref: Oracle CC&B.',
    `cip_project_id` BIGINT COMMENT 'Identifier of the capital project or work order to which the payment is allocated (for capital expenditure tracking). Ref: Oracle CC&B.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP payments are allocated to cost centers for expense tracking. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: Oracle CC&B.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: AP payments are drawn from specific funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: Oracle CC&B.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AP payments post to general ledger accounts. The general_ledger_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: Oracle CC&B.',
    `grant_id` BIGINT COMMENT 'Identifier of the grant funding source if the payment is funded by a federal, state, or local grant program. Ref: Oracle CC&B.',
    `payment_run_id` BIGINT COMMENT 'Identifier of the batch payment run or payment proposal that generated this payment (SAP payment run or Tyler Munis batch ID). Ref: Oracle CC&B.',
    `primary_approved_by_employee_id` BIGINT COMMENT 'Approved by employee. Ref: Oracle CC&B.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor receiving payment for goods or services procured by the water utility. Ref: Oracle CC&B.',
    `ach_trace_number` STRING COMMENT 'ACH trace number. Ref: Oracle CC&B.',
    `approval_date` DATE COMMENT 'Approval date. Ref: Oracle CC&B.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the payment for disbursement. Ref: Oracle CC&B.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time the payment was approved for disbursement. Ref: Oracle CC&B.',
    `check_number` STRING COMMENT 'Physical check number if payment method is check; null for electronic payment methods. Ref: Oracle CC&B.',
    `cleared_date` DATE COMMENT 'Date the payment cleared the bank account and funds were successfully transferred to the vendor. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the payment record was first created in the financial system. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
    `ap_payment_description` STRING COMMENT 'Payment description. Ref: Oracle CC&B.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or other discount amount taken by the utility on this payment transaction. Ref: Oracle CC&B.',
    `due_date` DATE COMMENT 'Date the payment was due to the vendor per the invoice payment terms. Ref: Oracle CC&B.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year in which the payment was recorded. Ref: Oracle CC&B.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the payment was recorded for financial reporting and budgeting purposes. Ref: Oracle CC&B.',
    `gl_posted_flag` BOOLEAN COMMENT 'GL posted flag. Ref: Oracle CC&B.',
    `gl_posting_date` DATE COMMENT 'GL posting date. Ref: Oracle CC&B.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this is a recurring payment (e.g., monthly utility service contracts, lease payments). Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time the payment record was last modified or updated. Ref: Oracle CC&B.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount paid to the vendor after applying discounts and adjustments (payment_amount minus discount_amount). Ref: Oracle CC&B.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Gross amount of the payment disbursed to the vendor before any adjustments or discounts. Ref: Oracle CC&B.',
    `payment_date` DATE COMMENT 'Date the payment was issued or disbursed to the vendor. Ref: Oracle CC&B.',
    `payment_description` STRING COMMENT 'Textual description of the payment purpose or goods/services procured (e.g., Chlorine chemical supply for WTP, Contractor services for pipe repair). Ref: Oracle CC&B.',
    `payment_document_number` STRING COMMENT 'External business identifier for the payment document as recorded in the financial system (SAP payment document number or Tyler Munis check/ACH reference). Ref: Oracle CC&B.',
    `payment_method` STRING COMMENT 'Method or instrument used to disburse payment to the vendor (ACH, check, wire transfer, electronic funds transfer, credit card, procurement card). Ref: Oracle CC&B.. Valid values are `ACH|check|wire_transfer|electronic_funds_transfer|credit_card|procurement_card`',
    `payment_number` STRING COMMENT 'Payment number (check number, ACH trace). Ref: Oracle CC&B.',
    `payment_reference` STRING COMMENT 'Additional reference information for the payment such as vendor invoice number, contract reference, or external tracking number. Ref: Oracle CC&B.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction (pending approval, approved, issued to vendor, cleared by bank, voided, cancelled). Ref: Oracle CC&B.. Valid values are `pending|approved|issued|cleared|voided|cancelled`',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this payment (e.g., Net 30, 2/10 Net 30) as agreed with the vendor. Ref: Oracle CC&B.',
    `payment_type` STRING COMMENT 'Classification of the payment transaction type (vendor payment, refund to vendor, advance payment, employee reimbursement, petty cash disbursement). Ref: Oracle CC&B.. Valid values are `vendor_payment|refund|advance|reimbursement|petty_cash`',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the goods or services for which payment is being made. Ref: Oracle CC&B.',
    `remittance_advice_number` STRING COMMENT 'Reference number for the remittance advice document sent to the vendor detailing invoices paid and amounts applied. Ref: Oracle CC&B.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: Oracle CC&B.',
    `void_date` DATE COMMENT 'Date the payment was voided or cancelled. Ref: Oracle CC&B.',
    `void_reason` STRING COMMENT 'Reason the payment was voided or cancelled if applicable (e.g., duplicate payment, vendor dispute, incorrect amount). Ref: Oracle CC&B.',
    `wire_confirmation_number` STRING COMMENT 'Wire confirmation number. Ref: Oracle CC&B.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the payment per tax regulations (e.g., 1099 reporting for US vendors). Ref: Oracle CC&B.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment transaction recording disbursements to vendors for goods and services procured by the water utility (chemicals, equipment, contractor services, O&M supplies). Captures payment method (ACH, check, wire), payment date, bank account, cleared amount, discount taken, payment run ID, and remittance details. Integrates with SAP FI payment program and Tyler Munis check processing.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` (
    `ar_transaction_id` BIGINT COMMENT 'Unique identifier for the accounts receivable transaction record. Primary key for non-utility-billing revenue streams. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'FK to customer.customer_account. Ref: AWWA.',
    `ar_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer or entity responsible for payment. Links to customer master for non-utility billing customers. Ref: AWWA.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account if this AR transaction is associated with a specific billing account structure. Nullable for non-account-based transactions. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital project if this AR transaction is associated with a specific Capital Improvement Program (CIP) project. Used for developer contributions and connection fees. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR transactions are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: AR transactions are recorded in specific funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Reference to the grant program if this AR transaction represents a grant reimbursement. Nullable for non-grant transactions. Ref: AWWA.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: AR transactions represent customer invoices in the finance system. AR aging reports, collections workflows, and financial statement preparation require linking AR records to source billing invoices fo. Ref: AWWA.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key to journal entry. Ref: AWWA.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan arrangement if this AR transaction is part of a structured payment agreement. Nullable if not on payment plan. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AR transactions post to revenue GL accounts. The revenue_gl_account_code STRING should be replaced with FK revenue_general_ledger_id pointing to general_ledger.general_ledger_id. The FK name uses a de. Ref: AWWA.',
    `pretreatment_iup_id` BIGINT COMMENT 'Reference to the Industrial User Permit if this AR transaction represents an IUP fee. Nullable for non-IUP transactions. Ref: AWWA.',
    `payment_id` BIGINT COMMENT 'Foreign key to payment. Ref: AWWA.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total amount of adjustments applied to this AR transaction (credits, discounts, or additional charges). Can be positive or negative. Ref: AWWA.',
    `aging_bucket` STRING COMMENT 'Classification of the AR transaction by days past due. Used for aging reports and collection prioritization. Ref: AWWA.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days|over_120_days`',
    `ar_gl_account_code` STRING COMMENT 'General ledger account code for the accounts receivable balance. Used for balance sheet reporting and reconciliation. Ref: AWWA.. Valid values are `^[0-9]{4,10}$`',
    `ar_transaction_description` STRING COMMENT 'Detailed narrative description of the AR transaction including service provided, fee basis, and any special terms or conditions. Ref: AWWA.',
    `collection_priority` STRING COMMENT 'Priority level assigned for collection efforts based on amount, aging, customer history, and business rules. Ref: AWWA.. Valid values are `low|medium|high|critical`',
    `collection_status` STRING COMMENT 'Current status of collection efforts for this AR transaction. Tracks progression through the collection workflow. [ENUM-REF-CANDIDATE: not_started|in_progress|on_hold|escalated|legal_action|settled|closed — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AR transaction record was first created in the system. Used for audit trail and data lineage. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amounts. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `customer_name` STRING COMMENT 'Full legal name of the customer or entity responsible for the AR transaction. Denormalized for reporting convenience. Ref: AWWA.',
    `days_past_due` STRING COMMENT 'Number of days the transaction is overdue calculated from due date to current date. Negative values indicate not yet due. Ref: AWWA.',
    `dispute_date` DATE COMMENT 'Date when the customer initiated the dispute. Nullable if no dispute exists. Ref: AWWA.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this AR transaction. True if under dispute, false otherwise. Ref: AWWA.',
    `dispute_reason` STRING COMMENT 'Customer-provided reason for disputing the AR transaction. Nullable if no dispute exists. Ref: AWWA.',
    `due_date` DATE COMMENT 'Date by which payment is expected per the payment terms. Used for aging bucket calculation and collection prioritization. Ref: AWWA.',
    `gl_posted_flag` BOOLEAN COMMENT 'GL posted flag. Ref: AWWA.',
    `gl_posting_date` DATE COMMENT 'GL posting date. Ref: AWWA.',
    `last_collection_action_date` DATE COMMENT 'Date of the most recent collection activity (call, letter, email, or legal action) for this AR transaction. Ref: AWWA.',
    `modified_by` STRING COMMENT 'User ID or system process that last modified this AR transaction record. Used for audit trail and accountability. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AR transaction record was last modified. Used for audit trail and change tracking. Ref: AWWA.',
    `notes` STRING COMMENT 'Internal notes and comments regarding the AR transaction, collection efforts, disputes, or special handling instructions. Ref: AWWA.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original billed amount of the AR transaction before any payments, adjustments, or write-offs. Base amount for revenue recognition. Ref: AWWA.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Current unpaid balance of the AR transaction after applying payments, credits, and adjustments. Used for aging and collection reporting. Ref: AWWA.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid against this AR transaction to date. Sum of all payment applications. Ref: AWWA.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether this AR transaction is enrolled in a payment plan arrangement. True if on payment plan, false otherwise. Ref: AWWA.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due. Standard terms include Net 30, Net 60, or custom terms per agreement. Ref: AWWA.',
    `source_system_code` STRING COMMENT 'Unique identifier of this AR transaction in the source system. Used for traceability and reconciliation back to operational systems. Ref: AWWA.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Transaction amount. Ref: AWWA.',
    `transaction_date` DATE COMMENT 'Date when the AR transaction was originated or the service/product was delivered. Used for revenue recognition timing per GASB 33. Ref: AWWA.',
    `transaction_number` STRING COMMENT 'Externally-visible business identifier for the AR transaction. Used in customer communications and financial reporting. Ref: AWWA.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the AR transaction in the collection workflow. [ENUM-REF-CANDIDATE: draft|open|partially_paid|paid|written_off|disputed|cancelled — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `transaction_type` STRING COMMENT 'Classification of the AR transaction by revenue stream category. Determines accounting treatment and revenue recognition rules. Ref: AWWA.. Valid values are `industrial_user_permit_fee|connection_fee|developer_contribution|grant_reimbursement|intergovernmental_charge|miscellaneous_receivable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible per the utilitys bad debt policy. Reduces outstanding balance and impacts allowance for doubtful accounts. Ref: AWWA.',
    `created_by` STRING COMMENT 'User ID or system process that created this AR transaction record. Used for audit trail and accountability. Ref: AWWA.',
    CONSTRAINT pk_ar_transaction PRIMARY KEY(`ar_transaction_id`)
) COMMENT 'Accounts receivable transaction for non-utility-billing revenue including connection fees, capacity charges, developer contributions, industrial user permit fees, grant reimbursement receivables, intergovernmental charges, hydrant meter deposits, and miscellaneous receivables. Captures debtor entity, transaction type, invoice/charge date, amount, due date, aging bucket, collection status, revenue GL account, and fund. Distinct from customer utility billing (owned by billing domain) — covers all other receivable streams.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Approved by employee. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgets are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Budgets are established by fund. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Budgets are defined for GL accounts. The gl_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `allotment_amount` DECIMAL(18,2) COMMENT 'Portion of the appropriation amount allocated for a specific period (e.g., quarterly or monthly allotment), used for cash flow management and spending control. Ref: AWWA.',
    `amendment_number` STRING COMMENT 'Sequential number indicating the count of amendments made to the original budget, used for version control and audit trail. Ref: AWWA.',
    `amendment_reason` STRING COMMENT 'Explanation or justification for budget amendments, documenting the business rationale for changes to the original appropriation. Ref: AWWA.',
    `appropriation_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount appropriated for this budget line, representing the authorized spending limit for the fiscal year. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date when the budget was officially approved by the board, commission, or governing authority. Ref: AWWA.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or body that approved the budget (e.g., Board of Directors, City Council, Finance Committee). Ref: AWWA.',
    `authority_source` STRING COMMENT 'Legal or administrative source of budget authority, such as board resolution number, city ordinance, or state appropriation act, providing traceability to the authorizing document. Ref: AWWA.',
    `board_resolution_number` STRING COMMENT 'Board resolution number. Ref: AWWA.',
    `budget_category` STRING COMMENT 'High-level classification of the budget expenditure type: personnel (salaries and benefits), materials (supplies and inventory), services (contracted services), utilities (energy and water), debt service (principal and interest), or transfers (inter-fund transfers). Ref: AWWA.. Valid values are `personnel|materials|services|utilities|debt_service|transfers`',
    `budget_code` STRING COMMENT 'Budget code. Ref: AWWA.',
    `budget_description` STRING COMMENT 'Detailed narrative description of the budget line, explaining the purpose, scope, and intended use of the appropriated funds. Ref: AWWA.',
    `budget_name` STRING COMMENT 'Budget name. Ref: AWWA.',
    `budget_number` STRING COMMENT 'Externally-known unique identifier for the budget, typically formatted as BUD-YYYY-NNNNNN. Ref: AWWA.. Valid values are `^BUD-[0-9]{4}-[0-9]{6}$`',
    `budget_period_end_date` DATE COMMENT 'Budget period end date. Ref: AWWA.',
    `budget_period_start_date` DATE COMMENT 'Budget period start date. Ref: AWWA.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (in preparation), submitted (awaiting approval), approved (board-approved), active (in effect), or closed (fiscal year ended). Ref: AWWA.. Valid values are `draft|submitted|approved|active|closed`',
    `budget_type` STRING COMMENT 'Classification of the budget: operating (OPEX - day-to-day operations and maintenance), capital (CAPEX - infrastructure and asset investments), or grant (externally funded projects). Ref: AWWA.. Valid values are `operating|capital|grant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system, used for audit trail and data lineage. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amounts (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `debt_service_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this budget line is designated for debt service payments (principal and interest on bonds or loans). Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when this budget expires and spending authority ends, typically the last day of the fiscal year. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when this budget becomes effective and spending authority begins, typically the first day of the fiscal year. Ref: AWWA.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'Amount of the budget that has been encumbered (committed via purchase orders or contracts) but not yet expended, used for budget availability tracking. Ref: AWWA.',
    `expended_amount` DECIMAL(18,2) COMMENT 'Actual amount expended against this budget line to date, used for budget-to-actual variance analysis and financial reporting. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies, typically a four-digit year (e.g., 2024). Ref: AWWA.',
    `grant_number` STRING COMMENT 'Grant or external funding source identifier if this budget is funded by a grant, used for grant compliance and reporting. Ref: AWWA.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this budget record, used for accountability and audit purposes. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified, used for audit trail and change tracking. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or annotations related to this budget line, used for internal documentation and clarification. Ref: AWWA.',
    `officer_email` STRING COMMENT 'Email address of the budget officer responsible for this budget line, used for communication and escalation. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `officer_name` STRING COMMENT 'Name of the budget officer or financial manager responsible for this budget line, used for accountability and contact purposes. Ref: AWWA.',
    `program_code` STRING COMMENT 'Program or project code associated with this budget, enabling program-based budgeting and performance measurement. Ref: AWWA.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rate_case_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this budget line is included in rate case preparation and regulatory filings for rate adjustments. Ref: AWWA.',
    `ssot_entity_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `ssot_resolution_type` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `version` STRING COMMENT 'Version of the budget indicating its lifecycle stage: original (initial submission), amended (board-approved changes), revised (mid-year adjustments), or final (year-end approved). Ref: AWWA.. Valid values are `original|amended|revised|final`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this budget record, used for accountability and audit purposes. Ref: AWWA.',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Annual operating and capital budget for the water utility, covering both header-level budget metadata and detailed line item allocations by GL account, cost center, fund, and period. Header captures budget version (original, amended, final), fiscal year, budget type (operating, capital, grant), appropriation amount, allotment schedule, budget authority source, and budget officer. Line items capture original amount, current amended budget, encumbrances, actual expenditures to date, available balance, and variance by period. Supports rate case preparation, GASB budget-to-actual reporting, and board-level variance analysis. [SSOT canonical for project.project_budget] [SSOT: Canonical source of truth for this concept across domains.] Differentiated: finance_budget is enterprise-wide budget master. SSOT master for enterprise budgets.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item record. Primary key for the budget line entity. Ref: AWWA.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Capital budget lines are structured by asset class (water mains, pumps, treatment equipment) for CIP planning and asset renewal prioritization. Supports long-term capital planning and rate case justif. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for managing and monitoring this budget line item. Links to the employee or workforce entity. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `finance_budget_id` BIGINT COMMENT 'Reference to the parent approved budget document to which this line item belongs. Links to the budget header entity. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Budget lines are allocated to funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Budget lines are defined for GL accounts. The gl_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `primary_budget_manager_employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for managing and monitoring this budget line item. Links to the employee or workforce entity. Ref: AWWA.',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual amount. Ref: AWWA.',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'The cumulative actual expenditures posted to this budget line item to date within the fiscal year. Represents funds that have been spent and recorded in the general ledger. Ref: AWWA.',
    `amended_budget_amount` DECIMAL(18,2) COMMENT 'The current amended budget amount for this line item, reflecting all approved budget amendments, transfers, and adjustments since the original budget. This is the current authorized spending limit. Ref: AWWA.',
    `approval_date` DATE COMMENT 'The date on which this budget line item was formally approved by the governing board or authorized budget authority. Typically aligns with the annual budget adoption date. Ref: AWWA.',
    `available_balance_amount` DECIMAL(18,2) COMMENT 'The remaining available budget balance for this line item, calculated as amended budget amount minus encumbrances minus actual expenditures. Represents funds still available for commitment or expenditure. Ref: AWWA.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget amount. Ref: AWWA.',
    `budget_category` STRING COMMENT 'Classification of the budget line item as either Operating Expenditure (OPEX) or Capital Expenditure (CAPEX). OPEX covers day-to-day operations and maintenance (O&M); CAPEX covers capital improvements and asset acquisitions. Ref: AWWA.. Valid values are `OPEX|CAPEX`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget line item. Draft indicates preliminary allocation; approved indicates board-approved allocation; amended indicates modified after approval; frozen indicates no further changes allowed; closed indicates fiscal year end closure. Ref: AWWA.. Valid values are `draft|approved|amended|frozen|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line item record was first created in the system. Audit trail field for record creation tracking. Ref: AWWA.',
    `debt_service_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this budget line item represents debt service payments (principal and interest on bonds or loans). True indicates debt service allocation. Ref: AWWA.',
    `encumbered_amount` DECIMAL(18,2) COMMENT 'Encumbered amount. Ref: AWWA.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'The total amount of commitments and obligations (purchase orders, contracts, reservations) that have been encumbered against this budget line item but not yet expended. Represents funds reserved for future payment. Ref: AWWA.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this budget line item. Values typically range from 1 to 12. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget line item is allocated. Typically a four-digit year (e.g., 2024). Ref: AWWA.',
    `funding_source` STRING COMMENT 'The primary source of funding for this budget line item. Indicates whether the expenditure is funded by operating revenue, rate revenue, grants, bond proceeds, loans, reserves, developer contributions, or other sources. [ENUM-REF-CANDIDATE: operating_revenue|rate_revenue|grants|bonds|loans|reserves|developer_contributions|other — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `grant_code` STRING COMMENT 'The grant or external funding source code associated with this budget line item, if applicable. Used to track grant-funded expenditures and ensure compliance with grant terms and conditions. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,12}$`',
    `last_amendment_date` DATE COMMENT 'The date of the most recent budget amendment or adjustment that affected this budget line item. Null if no amendments have been made since original approval. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line item record was last modified or updated. Audit trail field for change tracking and data lineage. Ref: AWWA.',
    `line_description` STRING COMMENT 'Detailed textual description of the budget line item, explaining the purpose, scope, and nature of the budgeted expenditure or revenue. Ref: AWWA.',
    `line_number` STRING COMMENT 'Sequential line number within the parent budget document. Used for ordering and referencing budget line items within the budget. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or explanations related to this budget line item. Used to capture context, justifications, or special instructions. Ref: AWWA.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The original approved budget amount for this line item at the start of the fiscal year. Represents the initial allocation before any amendments or adjustments. Ref: AWWA.',
    `period_01_amount` DECIMAL(18,2) COMMENT 'Period 1 budget. Ref: AWWA.',
    `period_02_amount` DECIMAL(18,2) COMMENT 'Period 2 budget. Ref: AWWA.',
    `period_03_amount` DECIMAL(18,2) COMMENT 'Period 3 budget. Ref: AWWA.',
    `period_04_amount` DECIMAL(18,2) COMMENT 'Period 4 budget. Ref: AWWA.',
    `period_05_amount` DECIMAL(18,2) COMMENT 'Period 5 budget. Ref: AWWA.',
    `period_06_amount` DECIMAL(18,2) COMMENT 'Period 6 budget. Ref: AWWA.',
    `period_07_amount` DECIMAL(18,2) COMMENT 'Period 7 budget. Ref: AWWA.',
    `period_08_amount` DECIMAL(18,2) COMMENT 'Period 8 budget. Ref: AWWA.',
    `period_09_amount` DECIMAL(18,2) COMMENT 'Period 9 budget. Ref: AWWA.',
    `period_10_amount` DECIMAL(18,2) COMMENT 'Period 10 budget. Ref: AWWA.',
    `period_11_amount` DECIMAL(18,2) COMMENT 'Period 11 budget. Ref: AWWA.',
    `period_12_amount` DECIMAL(18,2) COMMENT 'Period 12 budget. Ref: AWWA.',
    `project_code` STRING COMMENT 'The Capital Improvement Program (CIP) project code or internal order number to which this budget line item is allocated. Applicable for Capital Expenditure (CAPEX) budget lines. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,15}$`',
    `rate_case_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this budget line item is included in the current rate case filing or rate study for regulatory approval. True indicates inclusion in rate case calculations. Ref: AWWA.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this budget line item is allocated for regulatory compliance activities (e.g., Safe Drinking Water Act (SDWA), Clean Water Act (CWA), National Pollutant Discharge Elimination System (NPDES) permit compliance). True indicates compliance-related expenditure. Ref: AWWA.',
    `useful_life_years` STRING COMMENT 'The estimated useful life in years for capital assets associated with this budget line item. Used for depreciation calculations and asset management planning. Applicable for Capital Expenditure (CAPEX) lines only. Ref: AWWA.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance between the amended budget amount and actual expenditures for this line item. Positive variance indicates under-spending; negative variance indicates over-spending. Used for budget performance analysis. Ref: AWWA.',
    `variance_pct` DECIMAL(18,2) COMMENT 'Variance percentage. Ref: AWWA.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the amended budget amount. Calculated as (variance amount / amended budget amount) * 100. Used for Key Performance Indicator (KPI) reporting and variance analysis. Ref: AWWA.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Detailed budget line item records within an approved budget, providing granular OPEX and CAPEX allocations by GL account, cost center, fund, and period. Captures original budget amount, current amended budget, encumbrances, actual expenditures to date, available balance, and variance. Enables period-level budget monitoring and variance analysis for utility management and board reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset register. Ref: AWWA.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class that categorizes this fixed asset (e.g., WTP Facilities, Distribution Mains, Pumping Stations, Treatment Equipment, Vehicles, IT Assets). Ref: AWWA.',
    `registry_id` BIGINT COMMENT 'Foreign key to asset registry. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project under which this asset was constructed or acquired. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this asset, used for departmental cost allocation and budget tracking. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Fixed assets are capitalized to specific funds for GASB 34 reporting and fund financial statements. Required for governmental fund accounting. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Fixed assets post to specific GL accounts for asset class tracking, depreciation calculation, and financial statement presentation. Required for GAAP/GASB compliance. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Reference to the grant program that funded this asset acquisition, if applicable. Used for grant compliance tracking and reporting. Ref: AWWA.',
    `location_id` BIGINT COMMENT 'Reference to the physical location where the asset is installed or stored, linking to GIS coordinates and facility records. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom the asset was purchased. Ref: AWWA.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Recorded in USD. Ref: AWWA.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total historical cost of acquiring the asset including purchase price, installation, freight, and other capitalized costs. Recorded in USD. Ref: AWWA.',
    `acquisition_date` DATE COMMENT 'Date when the asset was acquired, purchased, or placed into service by the utility. Ref: AWWA.',
    `asset_capacity` DECIMAL(18,2) COMMENT 'Rated capacity or throughput of the asset in appropriate units (e.g., MGD for treatment plants, GPM for pumps, PSI for pressure vessels). The unit of measure is specified in capacity_unit_of_measure. Ref: AWWA.',
    `asset_class` STRING COMMENT 'Asset class (Land, Buildings, Infrastructure, Equipment). Ref: AWWA.',
    `asset_description` STRING COMMENT 'Detailed description of the fixed asset including specifications, capacity, and distinguishing characteristics. Ref: AWWA.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the fixed asset (e.g., Main Street Pump Station, Water Treatment Plant Building A). Ref: AWWA.',
    `asset_number` STRING COMMENT 'Fixed asset number. Ref: AWWA.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset indicating its operational state and availability. Ref: AWWA.. Valid values are `active|inactive|under_construction|retired|disposed|transferred`',
    `asset_tag_number` STRING COMMENT 'Externally visible unique identifier assigned to the physical asset for tracking and inventory purposes. Typically affixed to the asset as a barcode or RFID tag. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,20}$`',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the asset capacity (e.g., MGD - Million Gallons per Day, GPM - Gallons per Minute, PSI - Pounds per Square Inch, HP - Horsepower). Ref: AWWA.',
    `condition_rating` STRING COMMENT 'Current physical condition assessment of the asset based on inspections and condition assessments. Ref: AWWA.. Valid values are `excellent|good|fair|poor|very_poor`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was first created in the system. Ref: AWWA.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the asset based on its impact on service delivery, public health, regulatory compliance, and operational continuity. Ref: AWWA.. Valid values are `critical|high|medium|low`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation expense for this asset. Straight-line is most common for municipal utilities; MACRS (Modified Accelerated Cost Recovery System) may be used for tax purposes. Ref: AWWA.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs|none`',
    `disposal_date` DATE COMMENT 'Date when the asset was physically disposed of, sold, scrapped, or transferred out of the utilitys ownership. Ref: AWWA.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of when retired from service. Ref: AWWA.. Valid values are `sold|scrapped|donated|traded|transferred|abandoned`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the asset, if applicable. Recorded in USD. Ref: AWWA.',
    `facility_name` STRING COMMENT 'Name of the WTP (Water Treatment Plant), WWTP (Wastewater Treatment Plant), pumping station, or other facility where the asset is located. Ref: AWWA.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'Gain or loss on disposal. Ref: AWWA.',
    `gasb_capital_asset_category` STRING COMMENT 'GASB-compliant capital asset classification for financial reporting and compliance with governmental accounting standards. [ENUM-REF-CANDIDATE: land|land_improvements|buildings|building_improvements|infrastructure|machinery_and_equipment|vehicles|construction_in_progress — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `gis_feature_reference` BOOLEAN COMMENT 'Unique identifier linking this asset to its spatial representation in the Esri ArcGIS system for network modeling and geographic analysis. Ref: AWWA.',
    `in_service_date` DATE COMMENT 'Date when the asset was placed into active operational service and began contributing to utility operations. This is the date from which depreciation typically begins. Ref: AWWA.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering this asset, if separately insured. Ref: AWWA.',
    `insurance_value` DECIMAL(18,2) COMMENT 'Insured value or replacement cost of the asset for insurance purposes. Recorded in USD. Ref: AWWA.',
    `is_contributed_asset` BOOLEAN COMMENT 'Contributed asset flag. Ref: AWWA.',
    `is_rate_base_eligible` BOOLEAN COMMENT 'Rate base eligible flag. Ref: AWWA.',
    `last_condition_assessment_date` DATE COMMENT 'Date of the most recent condition assessment or inspection performed on this asset. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was last updated or modified. Ref: AWWA.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured or produced the asset. Ref: AWWA.',
    `maximo_asset_number` STRING COMMENT 'Asset identifier in the IBM Maximo CMMS (Computerized Maintenance Management System), used to link financial asset records with maintenance work orders and service history.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the asset, used for parts ordering and maintenance planning. Ref: AWWA.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current book value of the asset calculated as acquisition cost minus accumulated depreciation. Represents the carrying value on the balance sheet. Recorded in USD. Ref: AWWA.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which the asset was procured, linking to procurement records. Ref: AWWA.',
    `responsible_department` STRING COMMENT 'Name of the department or division responsible for operating and maintaining this asset (e.g., Water Treatment Operations, Distribution Maintenance, Fleet Management). Ref: AWWA.',
    `retirement_date` DATE COMMENT 'Date when the asset was retired from active service and removed from operational use. Ref: AWWA.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life, used in depreciation calculations. Recorded in USD. Ref: AWWA.',
    `sap_asset_number` STRING COMMENT 'Asset master record number in SAP FI-AA (Fixed Assets) module, used for financial accounting and depreciation posting. Ref: AWWA.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation calculation purposes, based on asset class standards and engineering estimates. Ref: AWWA.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage expires for this asset. Ref: AWWA.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset register for the water utilitys capitalized infrastructure and equipment including WTP/WWTP facilities, distribution mains, pumping stations, treatment equipment, vehicles, and IT assets. Captures asset class, acquisition date, acquisition cost, useful life, depreciation method (straight-line, MACRS), accumulated depreciation, net book value, asset location, responsible cost center, and GASB capital asset classification. Integrates with SAP FI-AA and IBM Maximo asset records.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant` (
    `grant_id` BIGINT COMMENT 'Unique identifier for the grant record. Primary key. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'FK to fund per GASB requirements VREQ-042. Ref: AWWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key to granting agency. Ref: AWWA.',
    `administrator_email` STRING COMMENT 'Email address of the grant administrator for internal coordination and external grantor communication. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `administrator_name` STRING COMMENT 'Name of the utility employee responsible for administering this grant, including compliance, reporting, and drawdown coordination. Ref: AWWA.',
    `administrator_phone` STRING COMMENT 'Phone number of the grant administrator. Ref: AWWA.',
    `allowable_cost_categories` DECIMAL(18,2) COMMENT 'Description of the types of costs that may be charged to the grant (e.g., Capital construction, engineering design, equipment acquisition, project management or Operations and maintenance, personnel, supplies). Defined in the grant agreement. Ref: AWWA.',
    `award_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of the grant or loan award as specified in the grant agreement. For loans, this is the principal amount. Ref: AWWA.',
    `award_date` DATE COMMENT 'Date on which the grant or loan was officially awarded to the utility by the grantor agency. This is the effective date of the grant agreement. Ref: AWWA.',
    `cfda_number` STRING COMMENT 'Five-digit CFDA number identifying the federal program (e.g., 66.458 for Capitalization Grants for Clean Water State Revolving Funds). Required for federal grants and single audit reporting. Ref: AWWA.. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `closeout_date` DATE COMMENT 'Date on which the grant was formally closed out with the grantor agency, including submission of final financial and performance reports. Ref: AWWA.',
    `compliance_conditions` STRING COMMENT 'Summary of key compliance requirements and special conditions attached to the grant (e.g., Davis-Bacon prevailing wage requirements, Buy America provisions, environmental review compliance, quarterly progress reporting). Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the award amount (typically USD for U.S. water utilities).. Valid values are `^[A-Z]{3}$`',
    `grant_description` STRING COMMENT 'Grant description. Ref: AWWA.',
    `drawdown_schedule_description` STRING COMMENT 'Description of the schedule or milestones for drawing down grant funds (e.g., Quarterly reimbursement based on actual expenditures, Milestone-based: 30% at design completion, 60% at construction midpoint, 10% at final acceptance). Ref: AWWA.',
    `federal_award_identification_number` STRING COMMENT 'Unique Federal Award Identification Number (FAIN) assigned by the federal agency for tracking and reporting purposes. Required for federal transparency reporting (FFATA). Ref: AWWA.',
    `first_payment_due_date` DECIMAL(18,2) COMMENT 'Date on which the first loan repayment is due. Applicable only to loan-type grants. Ref: AWWA.',
    `forgiveness_conditions` STRING COMMENT 'Description of conditions under which a forgivable loan may be forgiven (e.g., Principal forgiveness of 50% upon project completion and 5 years of compliant operation). Null if not applicable. Ref: AWWA.',
    `grant_number` STRING COMMENT 'External grant award number assigned by the grantor agency (e.g., EPA WIFIA loan number, SRF project number, USDA award identifier). This is the business identifier used in all external correspondence and reporting. Ref: AWWA.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the grant: pending (application submitted), awarded (approved but not yet active), active (funds being drawn and spent), suspended (temporarily halted), closed (completed successfully), terminated (ended prematurely). Ref: AWWA.. Valid values are `pending|awarded|active|suspended|closed|terminated`',
    `grant_type` STRING COMMENT 'Classification of the grant instrument: grant (non-repayable), loan (repayable with interest), forgivable loan (repayable but may be forgiven under conditions), cooperative agreement (requires substantial federal involvement), or reimbursement (cost reimbursement basis). Ref: AWWA.. Valid values are `grant|loan|forgivable_loan|cooperative_agreement|reimbursement`',
    `grantor_agency_code` STRING COMMENT 'Standardized code for the grantor agency (e.g., EPA, USDA, HUD) used for classification and reporting. Ref: AWWA.',
    `grantor_agency_name` STRING COMMENT 'Name of the federal, state, or local agency providing the grant or loan (e.g., U.S. Environmental Protection Agency, State Water Resources Control Board, USDA Rural Development). Ref: AWWA.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Approved indirect cost rate (as a percentage) that may be applied to direct costs for this grant. Based on federally negotiated indirect cost rate agreement or de minimis rate. Ref: AWWA.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate for loan-type grants (e.g., SRF loans, WIFIA loans), expressed as a decimal (e.g., 0.0250 for 2.5%). Zero for non-repayable grants. Ref: AWWA.',
    `is_reimbursement_grant` BOOLEAN COMMENT 'Reimbursement grant flag. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was last updated in the system. Ref: AWWA.',
    `match_pct` DECIMAL(18,2) COMMENT 'Match percentage. Ref: AWWA.',
    `match_required_amount` DECIMAL(18,2) COMMENT 'Required match amount. Ref: AWWA.',
    `matching_amount_required` DECIMAL(18,2) COMMENT 'Dollar amount of local matching funds required by the grant agreement. Calculated based on matching_requirement_percentage and total project cost. Ref: AWWA.',
    `matching_requirement_percentage` DECIMAL(18,2) COMMENT 'Percentage of project costs that the utility must contribute as a match (e.g., 20.00 for a 20% local match requirement). Zero if no match is required. Ref: AWWA.',
    `grant_name` STRING COMMENT 'Descriptive name or title of the grant project (e.g., Water Infrastructure Improvements Financing Act Loan for Treatment Plant Expansion, State Revolving Fund - Distribution System Rehabilitation). Ref: AWWA.',
    `next_report_due_date` DATE COMMENT 'Date on which the next financial or performance report is due to the grantor agency. Updated after each report submission. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to grant administration, compliance, or coordination. Ref: AWWA.',
    `pass_through_entity_identifying_number` STRING COMMENT 'Identifying number assigned by the pass-through entity to this subaward. Required for Single Audit reporting when applicable. Ref: AWWA.',
    `pass_through_entity_name` STRING COMMENT 'Name of the pass-through entity if the grant is received from a state or local agency that is itself a federal grant recipient (e.g., State Water Resources Control Board). Null if received directly from federal agency. Ref: AWWA.',
    `period_of_performance_end_date` DATE COMMENT 'End date of the grant period. All allowable costs must be incurred by this date. Extensions require formal amendment. Ref: AWWA.',
    `period_of_performance_start_date` DATE COMMENT 'Start date of the grant period during which costs may be incurred and charged to the grant. May differ from award_date. Ref: AWWA.',
    `program` STRING COMMENT 'WIFIA, SRF, ARPA, FEMA, EPA. Ref: AWWA.',
    `program_name` STRING COMMENT 'Name of the specific grant program under which the award was made (e.g., Water Infrastructure Finance and Innovation Act (WIFIA), Clean Water State Revolving Fund (CWSRF), Drinking Water State Revolving Fund (DWSRF), American Rescue Plan Act (ARPA) Infrastructure Grants). Ref: AWWA.',
    `project_description` STRING COMMENT 'Detailed description of the capital or operational project funded by this grant (e.g., Replacement of 5 miles of aging water distribution mains in the downtown district, Upgrade of wastewater treatment plant secondary clarifiers and UV disinfection system). Ref: AWWA.',
    `project_location` STRING COMMENT 'Geographic location or service area where the grant-funded project is being implemented (e.g., Downtown Water Treatment Plant, 123 Main St, District 4 Distribution Network). Ref: AWWA.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds still available for drawdown. Calculated as award_amount minus total_amount_drawn. Ref: AWWA.',
    `repayment_term_months` STRING COMMENT 'Total repayment period in months for loan-type grants. Null for non-repayable grants. Ref: AWWA.',
    `reporting_frequency` STRING COMMENT 'Frequency at which financial and performance reports must be submitted to the grantor agency (monthly, quarterly, semi-annually, annually, or as required by specific milestones). Ref: AWWA.. Valid values are `monthly|quarterly|semi_annually|annually|as_required`',
    `single_audit_required` BOOLEAN COMMENT 'Single audit required flag. Ref: AWWA.',
    `single_audit_required_flag` BOOLEAN COMMENT 'Indicates whether this grant is subject to Single Audit Act requirements (OMB Uniform Guidance). True if the utility expends $750,000 or more in federal awards in a fiscal year. Ref: AWWA.',
    `total_amount_drawn` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of grant funds that have been drawn down or reimbursed to date. Updated as drawdown requests are processed. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each grant in the finance domain.',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Grant master and expenditure tracking for federal, state, and local grants received by the water utility (EPA WIFIA, SRF loans, USDA Rural Development, ARPA infrastructure grants). Covers the full grant lifecycle: award metadata (grantor, program, amount, period, matching requirements, compliance conditions), drawdown schedules, and individual expenditure transactions (cost category, vendor/payroll reference, eligible/ineligible classification, drawdown request reference). Supports GASB grant accounting, single audit SEFA reporting, and grantor compliance reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` (
    `grant_expenditure_id` BIGINT COMMENT 'Unique identifier for the grant expenditure transaction record. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital or operational project to which this expenditure is assigned. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grant expenditures are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `drawdown_request_id` BIGINT COMMENT 'Reference to the grant drawdown or reimbursement request in which this expenditure was included. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Reference to the employee for payroll-related expenditures charged to the grant. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Grant expenditures post to GL accounts. The gl_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Reference to the specific grant against which this expenditure is charged. Ref: AWWA.',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key to journal entry line. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom goods or services were purchased, if applicable. Ref: AWWA.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Grant-funded infrastructure projects track expenditures to specific work orders for federal/state compliance reporting, single audit requirements, and grant reimbursement documentation. Required for D. Ref: AWWA.',
    `approval_date` DATE COMMENT 'The date on which the expenditure was approved for grant charging. Ref: AWWA.',
    `approval_status` STRING COMMENT 'The current approval status of the expenditure for grant charging purposes. Ref: AWWA.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this expenditure for grant charging. Ref: AWWA.',
    `audit_finding_flag` BOOLEAN COMMENT 'Indicates whether this expenditure has been flagged in a grant audit or single audit finding. Ref: AWWA.',
    `audit_finding_reference` STRING COMMENT 'Reference number or description of the audit finding associated with this expenditure, if applicable. Ref: AWWA.',
    `cfda_number` STRING COMMENT 'The CFDA number identifying the federal program under which the grant was awarded (used for SEFA reporting). Ref: AWWA.',
    `cost_category` STRING COMMENT 'The classification of the expenditure according to grant budget categories (personnel, fringe benefits, travel, equipment, supplies, contractual, construction, other direct costs, indirect costs). [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|construction|other_direct|indirect — 9 candidates stripped; promote to reference product]. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this grant expenditure record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the expenditure amount (typically USD for U.S. water utilities).. Valid values are `^[A-Z]{3}$`',
    `grant_expenditure_description` STRING COMMENT 'A detailed narrative description of the goods, services, or activities for which the expenditure was incurred. Ref: AWWA.',
    `eligibility_classification` STRING COMMENT 'Classification indicating whether the expenditure is eligible, ineligible, partially eligible, or pending review for grant reimbursement. Ref: AWWA.. Valid values are `eligible|ineligible|partially_eligible|pending_review`',
    `eligible_amount` DECIMAL(18,2) COMMENT 'The portion of the expenditure amount that is eligible for reimbursement under the grant terms. Ref: AWWA.',
    `expenditure_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of the expenditure charged to the grant. Ref: AWWA.',
    `expenditure_category` STRING COMMENT 'Personnel, Equipment, Supplies, Contractual, Other. Ref: AWWA.',
    `expenditure_date` DATE COMMENT 'The date on which the expenditure was incurred or the transaction occurred. Ref: AWWA.',
    `federal_award_identification_number` STRING COMMENT 'The unique Federal Award Identification Number assigned by the federal agency for tracking and reporting purposes. Ref: AWWA.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Indirect cost amount. Ref: AWWA.',
    `ineligible_amount` DECIMAL(18,2) COMMENT 'The portion of the expenditure amount that is not eligible for reimbursement under the grant terms. Ref: AWWA.',
    `invoice_number` STRING COMMENT 'The invoice or payment document number associated with this expenditure. Ref: AWWA.',
    `is_direct_cost` BOOLEAN COMMENT 'Direct cost flag. Ref: AWWA.',
    `match_amount` DECIMAL(18,2) COMMENT 'The dollar amount of this expenditure that counts toward the grantee match or cost-sharing requirement. Ref: AWWA.',
    `match_requirement_flag` BOOLEAN COMMENT 'Indicates whether this expenditure is used to satisfy a grant match or cost-sharing requirement. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this grant expenditure record was last modified or updated. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the expenditure, eligibility determination, or special circumstances. Ref: AWWA.',
    `posting_date` DATE COMMENT 'The date on which the expenditure was posted to the general ledger or financial system. Ref: AWWA.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this expenditure, if applicable. Ref: AWWA.',
    `reimbursement_received_flag` BOOLEAN COMMENT 'Reimbursement received flag. Ref: AWWA.',
    `reimbursement_requested_flag` BOOLEAN COMMENT 'Reimbursement requested flag. Ref: AWWA.',
    `reporting_period_end_date` DATE COMMENT 'The end date of the federal or state reporting period to which this expenditure is assigned. Ref: AWWA.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the federal or state reporting period to which this expenditure is assigned. Ref: AWWA.',
    `wbs_element` STRING COMMENT 'The work breakdown structure element code for detailed project cost tracking within the grant. Ref: AWWA.',
    CONSTRAINT pk_grant_expenditure PRIMARY KEY(`grant_expenditure_id`)
) COMMENT 'Grant expenditure transaction recording costs charged against specific grants for reimbursement and compliance tracking. Captures grant ID, expenditure date, cost category, vendor or payroll reference, amount, eligible/ineligible classification, drawdown request reference, and federal/state reporting period. Supports grant drawdown requests, single audit Schedule of Expenditures of Federal Awards (SEFA), and grantor reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` (
    `debt_instrument_id` BIGINT COMMENT 'Unique identifier for the debt instrument record in the water utilitys long-term debt portfolio. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'FK to CIP project per VREQ-040. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'FK to fund per VREQ-039. Ref: AWWA.',
    `amortization_type` STRING COMMENT 'The structure of principal repayment over the life of the debt. Level principal has equal principal payments; level debt service has equal combined principal and interest payments; bullet has single principal payment at maturity; serial has staggered maturities; term has single maturity date. Ref: AWWA.. Valid values are `level_principal|level_debt_service|bullet|serial|term`',
    `bond_counsel_name` STRING COMMENT 'The name of the law firm that provided the legal opinion on the validity and tax-exempt status of the debt issuance. Ref: AWWA.',
    `bond_rating` STRING COMMENT 'The credit quality rating assigned to the debt instrument by rating agencies (e.g., Moodys, S&P, Fitch). Common ratings include AAA, AA, A, BBB, etc. Higher ratings indicate lower credit risk and typically result in lower interest costs. Ref: AWWA.',
    `cafr_reporting_category` STRING COMMENT 'The category under which this debt instrument is reported in the utilitys CAFR. Water utilities typically report under business-type activities as enterprise funds. Ref: AWWA.. Valid values are `governmental_activities|business_type_activities|component_unit`',
    `call_date` DATE COMMENT 'The earliest date on which the issuer may exercise the call option to redeem the debt instrument before maturity. Null if the instrument is non-callable. Ref: AWWA.',
    `call_premium_percentage` DECIMAL(18,2) COMMENT 'The premium above par value that the issuer must pay to bondholders if the debt is called before maturity, expressed as a percentage (e.g., 2.0000 represents 2.00% premium). Null if non-callable. Ref: AWWA.',
    `callable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the issuer has the right to redeem (call) the debt instrument before its stated maturity date. True indicates callable; False indicates non-callable. Ref: AWWA.',
    `coupon_frequency` STRING COMMENT 'The frequency at which interest payments (coupons) are made to bondholders or lenders. Semi-annual is most common for municipal bonds. Ref: AWWA.. Valid values are `monthly|quarterly|semi_annual|annual|at_maturity`',
    `covenant_description` STRING COMMENT 'Description of financial covenants and restrictions imposed by the debt agreement, such as debt service coverage ratio requirements, rate covenant obligations, reserve fund requirements, or restrictions on additional debt issuance. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this debt instrument record was first created in the system. Ref: AWWA.',
    `cusip_number` STRING COMMENT 'The 9-character alphanumeric identifier assigned to the debt instrument for trading and settlement purposes in the securities market. Format: 3 digits (issuer), 6 alphanumeric (issue), 1 check digit. Ref: AWWA.. Valid values are `^[0-9]{3}[0-9A-Z]{6}[0-9]$`',
    `debt_description` STRING COMMENT 'Debt description. Ref: AWWA.',
    `debt_number` STRING COMMENT 'Debt instrument number. Ref: AWWA.',
    `debt_service_reserve_requirement` DECIMAL(18,2) COMMENT 'The required balance to be maintained in the debt service reserve fund as specified in the bond indenture, typically equal to maximum annual debt service or a percentage of outstanding principal. Ref: AWWA.',
    `debt_type` STRING COMMENT 'Revenue Bond, GO Bond, SRF Loan, WIFIA Loan, Note Payable. Ref: AWWA.',
    `gasb_classification` STRING COMMENT 'The classification of the debt instrument for GASB financial reporting purposes. Long-term debt has maturity beyond one year; short-term debt matures within one year; current portion represents principal due within the next fiscal year; non-current portion represents principal due beyond the next fiscal year. Ref: AWWA.. Valid values are `long_term_debt|short_term_debt|current_portion|non_current_portion`',
    `instrument_number` STRING COMMENT 'The externally-known unique identifier or serial number assigned to the debt instrument by the issuer, trustee, or financial institution (e.g., bond CUSIP, loan agreement number). Ref: AWWA.',
    `instrument_status` STRING COMMENT 'Current lifecycle status of the debt instrument. Active indicates the debt is outstanding and serviced; matured indicates principal fully repaid at term end; defeased indicates legally satisfied through irrevocable trust; refunded indicates replaced by new debt issuance; defaulted indicates payment obligations not met; cancelled indicates instrument voided before issuance. Ref: AWWA.. Valid values are `active|matured|defeased|refunded|defaulted|cancelled`',
    `instrument_type` STRING COMMENT 'Classification of the debt instrument by its legal and financial structure. Revenue bonds are secured by utility revenues; general obligation bonds by taxing authority; SRF (State Revolving Fund) loans provide low-cost financing for water infrastructure; WIFIA (Water Infrastructure Finance and Innovation Act) loans offer federal credit assistance; commercial paper provides short-term financing; bank loans are direct borrowings from financial institutions. Ref: AWWA.. Valid values are `revenue_bond|general_obligation_bond|srf_loan|wifia_loan|commercial_paper|bank_loan`',
    `insurance_provider` STRING COMMENT 'The name of the bond insurance company providing credit enhancement for the debt instrument, if applicable. Bond insurance guarantees timely payment of principal and interest in case of issuer default. Ref: AWWA.',
    `interest_calculation_method` STRING COMMENT 'The day-count convention used to calculate accrued interest. 30/360 assumes 30-day months and 360-day years; Actual/360 uses actual days and 360-day years; Actual/365 uses actual days and 365-day years; Actual/Actual uses actual days and actual year length. Ref: AWWA.. Valid values are `30_360|actual_360|actual_365|actual_actual`',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the outstanding principal balance, expressed as a percentage (e.g., 3.5000 represents 3.50%). For variable rate instruments, this represents the current rate. Ref: AWWA.',
    `interest_rate_type` DECIMAL(18,2) COMMENT 'Classification of the interest rate structure. Fixed rates remain constant over the life of the instrument; variable rates adjust periodically based on market indices; zero coupon instruments accrue interest but pay at maturity. Ref: AWWA.',
    `is_callable` BOOLEAN COMMENT 'Callable flag. Ref: AWWA.',
    `is_taxable` BOOLEAN COMMENT 'Taxable flag. Ref: AWWA.',
    `isin_number` STRING COMMENT 'The 12-character alphanumeric code that uniquely identifies the debt instrument in international securities markets. Format: 2-letter country code + 9-character national identifier + 1 check digit. Ref: AWWA.. Valid values are `^[A-Z]{2}[0-9A-Z]{9}[0-9]$`',
    `issuance_date` DATE COMMENT 'The date on which the debt instrument was originally issued and funds were received by the water utility. Ref: AWWA.',
    `issue_date` DATE COMMENT 'Issue date. Ref: AWWA.',
    `liquidity_provider_name` STRING COMMENT 'For variable rate demand obligations, the name of the financial institution providing the standby bond purchase agreement or letter of credit to ensure liquidity if bonds cannot be remarketed. Ref: AWWA.',
    `maturity_date` DATE COMMENT 'The date on which the final principal payment is due and the debt instrument obligation is fully satisfied. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this debt instrument record was last modified or updated in the system. Ref: AWWA.',
    `original_principal_amount` DECIMAL(18,2) COMMENT 'The total face value or principal amount of the debt instrument at issuance, before any payments or amortization. Ref: AWWA.',
    `outstanding_principal_amount` DECIMAL(18,2) COMMENT 'Outstanding principal amount. Ref: AWWA.',
    `outstanding_principal_balance` DECIMAL(18,2) COMMENT 'The current unpaid principal balance remaining on the debt instrument after all principal payments to date. Ref: AWWA.',
    `paying_agent_name` STRING COMMENT 'The name of the financial institution designated to distribute principal and interest payments to bondholders on behalf of the issuer. Ref: AWWA.',
    `payment_frequency` STRING COMMENT 'Monthly, Quarterly, Semi-Annual, Annual. Ref: AWWA.',
    `project_description` STRING COMMENT 'Detailed description of the specific capital projects or initiatives funded by this debt instrument, including water treatment plant upgrades, distribution network expansion, wastewater treatment improvements, or other infrastructure investments. Ref: AWWA.',
    `purpose` STRING COMMENT 'The intended use of proceeds from the debt issuance, such as capital improvement projects (CIP), infrastructure replacement, system expansion, refunding existing debt, or working capital needs. Ref: AWWA.',
    `rate_case_inclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether debt service costs for this instrument are included in the utilitys rate base for rate-setting purposes. True indicates included in rates; False indicates excluded. Ref: AWWA.',
    `rate_reset_frequency` STRING COMMENT 'For variable rate debt, the frequency at which the interest rate is recalculated and adjusted based on the underlying index. Ref: AWWA.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `rating_agency` STRING COMMENT 'The name of the credit rating agency that assigned the bond rating (e.g., Moodys Investors Service, Standard & Poors, Fitch Ratings). Ref: AWWA.',
    `remarketing_agent_name` STRING COMMENT 'For variable rate demand obligations, the name of the financial institution responsible for resetting the interest rate and remarketing bonds tendered by investors. Ref: AWWA.',
    `security_type` STRING COMMENT 'The type of security or collateral backing the debt instrument. Revenue pledge is secured by utility operating revenues; general obligation by taxing power; special assessment by property assessments; moral obligation by non-binding commitment; unsecured has no specific collateral. Ref: AWWA.. Valid values are `revenue_pledge|general_obligation|special_assessment|moral_obligation|unsecured`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Boolean flag indicating whether interest income from this debt instrument is exempt from federal income tax. True indicates tax-exempt; False indicates taxable. Most municipal water utility bonds are tax-exempt. Ref: AWWA.',
    `trustee_name` STRING COMMENT 'The name of the financial institution serving as trustee, responsible for safeguarding bondholders interests, holding collateral, and ensuring compliance with bond covenants. Ref: AWWA.',
    `underwriter_name` STRING COMMENT 'The name of the investment banking firm or financial institution that underwrote the debt issuance and facilitated its sale to investors. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `variable_rate_index` DECIMAL(18,2) COMMENT 'For variable rate debt, the market index to which the interest rate is tied, such as SOFR (Secured Overnight Financing Rate), LIBOR (being phased out), SIFMA (Securities Industry and Financial Markets Association Municipal Swap Index), or Prime Rate. Ref: AWWA.',
    CONSTRAINT pk_debt_instrument PRIMARY KEY(`debt_instrument_id`)
) COMMENT 'Debt portfolio management for the water utilitys long-term obligations including revenue bonds, GO bonds, SRF loans, WIFIA loans, and commercial paper. Covers both instrument master data (type, issuance date, maturity, principal, interest rate, bond rating, trustee, GASB classification) and debt service payment transactions (scheduled/actual principal and interest payments, payment source fund, reserve fund draws, trustee confirmations). Supports amortization schedule management, bond covenant compliance monitoring, rate case preparation, and CAFR long-term debt disclosures.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` (
    `debt_service_payment_id` DECIMAL(18,2) COMMENT 'Unique identifier for the debt service payment transaction. Ref: Oracle CC&B.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Debt service payments for project-specific bonds must be tracked to the funded project for rate case cost recovery and debt service coverage ratio calculations. Ref: Oracle CC&B.',
    `debt_instrument_id` BIGINT COMMENT 'Reference to the specific debt instrument (bond, loan, note) for which this payment is made. Ref: Oracle CC&B.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Debt service payments are drawn from specific funds. The payment_source_fund_code STRING should be replaced with FK to fund.fund_id. Ref: Oracle CC&B.',
    `actual_payment_date` DATE COMMENT 'Actual payment date. Ref: Oracle CC&B.',
    `approval_date` DATE COMMENT 'Date on which the debt service payment was approved for processing by authorized personnel. Ref: Oracle CC&B.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the debt service payment for processing. Ref: Oracle CC&B.',
    `bank_account_number` STRING COMMENT 'The utility bank account number from which the debt service payment was disbursed. Ref: Oracle CC&B.',
    `covenant_compliance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this debt service payment was made in compliance with all bond covenants and debt service coverage requirements. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the debt service payment record was first created in the system. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the debt service payment. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `days_late` STRING COMMENT 'Number of days the debt service payment was made after the due date, if applicable. Ref: Oracle CC&B.',
    `debt_service_coverage_ratio` DECIMAL(18,2) COMMENT 'The debt service coverage ratio calculated at the time of this payment, representing the ratio of net revenues available for debt service to the debt service payment amount, used for bond covenant monitoring. Ref: Oracle CC&B.',
    `due_date` DATE COMMENT 'The scheduled date on which the debt service payment is contractually due per the bond indenture or loan agreement. Ref: Oracle CC&B.',
    `fees_amount` DECIMAL(18,2) COMMENT 'Additional fees associated with the debt service payment, including trustee fees, paying agent fees, or administrative charges. Ref: Oracle CC&B.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the debt service payment is recorded. Ref: Oracle CC&B.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the debt service payment is recorded for financial reporting and budgeting purposes. Ref: Oracle CC&B.',
    `gl_document_number` STRING COMMENT 'The general ledger document or journal entry number associated with the debt service payment transaction in SAP FI or Tyler Munis. Ref: Oracle CC&B.',
    `gl_posting_date` DATE COMMENT 'The date on which the debt service payment transaction was posted to the general ledger in the ERP system. Ref: Oracle CC&B.',
    `interest_amount` DECIMAL(18,2) COMMENT 'The portion of the debt service payment applied to interest expense on the debt instrument. Ref: Oracle CC&B.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the debt service payment record was last modified or updated in the system. Ref: Oracle CC&B.',
    `late_payment_indicator` DECIMAL(18,2) COMMENT 'Boolean flag indicating whether the debt service payment was made after the contractual due date. Ref: Oracle CC&B.',
    `late_payment_penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount assessed for late payment of debt service, if applicable per the bond indenture or loan agreement. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the debt service payment, including any special circumstances, adjustments, or explanations. Ref: Oracle CC&B.',
    `payment_date` DATE COMMENT 'The actual date on which the debt service payment was made or processed by the utility. Ref: Oracle CC&B.',
    `payment_method` STRING COMMENT 'The method by which the debt service payment was transmitted to the trustee or paying agent. Ref: Oracle CC&B.. Valid values are `wire_transfer|ach|check|electronic_funds_transfer`',
    `payment_number` STRING COMMENT 'Business identifier for the debt service payment, typically sequential or following a numbering convention established by the utility or trustee. Ref: Oracle CC&B.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the debt service payment indicating whether it is scheduled, processed, confirmed by trustee, failed, or reversed. Ref: Oracle CC&B.. Valid values are `scheduled|processed|confirmed|failed|reversed`',
    `payment_type` STRING COMMENT 'Classification of the debt service payment indicating whether it is a scheduled payment, prepayment, defeasance, refunding, or penalty payment. Ref: Oracle CC&B.. Valid values are `scheduled|prepayment|defeasance|refunding|penalty`',
    `premium_discount_amortization` DECIMAL(18,2) COMMENT 'The amortization amount for bond premium or discount allocated to this payment period, following the effective interest method or straight-line method as applicable. Ref: Oracle CC&B.',
    `principal_amount` DECIMAL(18,2) COMMENT 'The portion of the debt service payment applied to the principal balance of the debt instrument. Ref: Oracle CC&B.',
    `reserve_fund_draw_amount` DECIMAL(18,2) COMMENT 'The amount drawn from the debt service reserve fund to supplement this payment, if applicable. Ref: Oracle CC&B.',
    `reserve_fund_draw_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this debt service payment required a draw from the debt service reserve fund to meet the obligation. Ref: Oracle CC&B.',
    `sap_company_code` STRING COMMENT 'SAP ERP company code associated with the debt service payment transaction for multi-entity utilities. Ref: Oracle CC&B.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The total amount of the debt service payment, including principal, interest, amortization, and fees. Ref: Oracle CC&B.',
    `transaction_reference_number` STRING COMMENT 'Bank or financial system transaction reference number for the debt service payment, used for reconciliation and audit trail. Ref: Oracle CC&B.',
    `trustee_confirmation_number` STRING COMMENT 'Confirmation or reference number provided by the bond trustee or paying agent acknowledging receipt and processing of the debt service payment. Ref: Oracle CC&B.',
    `trustee_name` STRING COMMENT 'Name of the bond trustee or paying agent responsible for receiving and disbursing the debt service payment to bondholders. Ref: Oracle CC&B.',
    `tyler_munis_transaction_reference` BOOLEAN COMMENT 'Tyler Technologies Munis system transaction identifier for the debt service payment, used for municipal utilities. Ref: Oracle CC&B.',
    CONSTRAINT pk_debt_service_payment PRIMARY KEY(`debt_service_payment_id`)
) COMMENT 'Debt service payment transaction recording scheduled and actual principal and interest payments on the water utilitys debt obligations. Captures debt instrument reference, payment due date, actual payment date, principal amount, interest amount, total payment, payment source fund, reserve fund draw indicator, and trustee confirmation number. Supports GASB debt service fund accounting and bond covenant compliance monitoring.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` (
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Unique identifier for the rate case proceeding. Primary key for the rate case master record. Ref: Oracle CC&B.',
    `canonical_service_rate_case_id` DECIMAL(18,2) COMMENT 'Unique identifier for the canonical service rate case referenced by each finance rate case record in the finance domain.',
    `fund_id` BIGINT COMMENT 'Foreign key to fund. Ref: Oracle CC&B.',
    `service_rate_case_id` DECIMAL(18,2) COMMENT 'FK to canonical SSOT entity service.service_rate_case. Ref: Oracle CC&B.',
    `territory_id` BIGINT COMMENT 'FK to service territory per VREQ-041. Ref: Oracle CC&B.',
    `allowed_rate_of_return` DECIMAL(18,2) COMMENT 'The overall rate of return on rate base authorized by the regulatory commission, expressed as a decimal (e.g., 0.0725 for 7.25%). Represents the weighted average cost of capital (WACC) including debt and equity components. Ref: Oracle CC&B.',
    `allowed_return_on_equity` DECIMAL(18,2) COMMENT 'The authorized return on equity component of the rate of return, expressed as a decimal (e.g., 0.0950 for 9.50%). Represents the profit margin allowed on shareholder equity investment in the utility. Ref: Oracle CC&B.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether any party filed an appeal or request for rehearing of the commission decision. Appeals may delay rate implementation or require refund provisions. Ref: Oracle CC&B.',
    `approved_revenue_requirement` DECIMAL(18,2) COMMENT 'Total annual revenue requirement approved by the regulatory commission or utility board. This is the final authorized revenue level after regulatory review, hearings, and adjustments. May differ from the requested amount due to disallowed costs, rate base adjustments, or modified return on equity. Expressed in USD. Ref: Oracle CC&B.',
    `capital_improvement_program_amount` DECIMAL(18,2) COMMENT 'Total value of the Capital Improvement Program (CIP) or Capital Expenditure (CAPEX) plan supporting the rate case, covering planned infrastructure investments during the test year and rate period. Expressed in USD. Ref: Oracle CC&B.',
    `case_status` STRING COMMENT 'Current lifecycle status of the rate case proceeding. Tracks progression from initial draft through regulatory review, hearings, commission decision, and final disposition. [ENUM-REF-CANDIDATE: draft|filed|pending_review|hearing_scheduled|decision_pending|approved|denied|withdrawn — 8 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `case_type` STRING COMMENT 'Classification of the rate case proceeding. General rate case (GRC) is a comprehensive review of revenue requirements; interim adjustments address specific cost changes; surcharges recover specific program costs; cost of service reviews cost allocation; rate design modifies rate structure without changing revenue; emergency rates address urgent financial needs. Ref: Oracle CC&B.. Valid values are `general_rate_case|interim_rate_adjustment|surcharge|cost_of_service|rate_design|emergency_rate`',
    `commercial_rate_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage change in typical commercial customer bills resulting from the approved rate case. Ref: Oracle CC&B.',
    `consultant` STRING COMMENT 'Name of the external consulting firm or advisor retained to prepare the rate case filing, cost of service study, and regulatory testimony. Common firms include Black & Veatch, Raftelis, NewGen Strategies, and specialized rate consultants.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate case record was first created in the system. Used for audit trail and data lineage tracking. Ref: Oracle CC&B.',
    `customer_class_allocation_method` STRING COMMENT 'The cost allocation methodology used to distribute revenue requirements across customer classes (residential, commercial, industrial, public authority). Base-extra-capacity allocates fixed costs by capacity and variable by usage; commodity-demand splits by consumption and peak demand; customer count uses simple per-account allocation; meter equivalent weights by meter size; peak demand allocates by maximum usage contribution. Ref: Oracle CC&B.. Valid values are `base_extra_capacity|commodity_demand|customer_count|meter_equivalent|peak_demand`',
    `debt_service_amount` DECIMAL(18,2) COMMENT 'Annual debt service costs (principal and interest payments) on utility bonds and loans included in the revenue requirement. Expressed in USD. Ref: Oracle CC&B.',
    `decision_date` DATE COMMENT 'Date the regulatory commission issued its final decision and order on the rate case. This date establishes the official record and triggers appeal deadlines. Ref: Oracle CC&B.',
    `decision_document_url` STRING COMMENT 'Web link to the official commission decision document, order, or ruling. Typically hosted on the Public Utilities Commission website or document management system. Ref: Oracle CC&B.',
    `depreciation_expense_amount` DECIMAL(18,2) COMMENT 'Annual depreciation expense included in the revenue requirement, calculated based on approved depreciation rates and asset lives for utility plant and equipment. Expressed in USD. Ref: Oracle CC&B.',
    `docket_number` STRING COMMENT 'Official docket or case number assigned by the Public Utilities Commission (PUC) or regulatory body for tracking the rate proceeding. This is the externally-known identifier used in all regulatory filings and correspondence. Ref: Oracle CC&B.. Valid values are `^[A-Z0-9-]+$`',
    `effective_date` DATE COMMENT 'Effective date. Ref: Oracle CC&B.',
    `filing_date` DATE COMMENT 'Date the rate case application was formally filed with the Public Utilities Commission or regulatory authority. This date triggers statutory review timelines and procedural deadlines. Ref: Oracle CC&B.',
    `gasb_compliance_notes` STRING COMMENT 'Free-text notes documenting compliance with Governmental Accounting Standards Board (GASB) requirements for municipal utilities, including fund accounting, regulatory asset/liability treatment, and financial statement presentation. Ref: Oracle CC&B.',
    `hearing_date` DATE COMMENT 'Date of the formal public hearing before the regulatory commission where testimony is presented, witnesses are cross-examined, and public comment is received. Ref: Oracle CC&B.',
    `industrial_rate_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage change in typical industrial customer bills resulting from the approved rate case. Ref: Oracle CC&B.',
    `intervenor_count` STRING COMMENT 'Number of parties granted intervenor status in the rate case proceeding. Intervenors may include consumer advocates, industrial customer groups, environmental organizations, or other stakeholders with standing to participate. Ref: Oracle CC&B.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate case record was last updated. Used for audit trail and change tracking. Ref: Oracle CC&B.',
    `lead_attorney` TIMESTAMP COMMENT 'Name of the lead legal counsel representing the utility in the rate case proceeding. May be in-house counsel or external regulatory law firm. Ref: Oracle CC&B.',
    `next_rate_case_anticipated_date` DECIMAL(18,2) COMMENT 'Anticipated filing date for the next general rate case. Used for financial planning and analysis (FP&A) and long-term capital planning. May be driven by regulatory requirements, financial need, or strategic timing. Ref: Oracle CC&B.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, regulatory conditions, or internal commentary related to the rate case proceeding. Ref: Oracle CC&B.',
    `operating_expense_amount` DECIMAL(18,2) COMMENT 'Total annual operating expenses included in the approved revenue requirement. Includes operations and maintenance (O&M) costs, administrative expenses, purchased water, power, chemicals, labor, and other recurring costs. Expressed in USD. Ref: Oracle CC&B.',
    `public_notice_date` DATE COMMENT 'Date public notice of the rate case filing was published in newspapers, utility bills, or other media as required by regulatory rules. Triggers public comment period. Ref: Oracle CC&B.',
    `rate_base` DECIMAL(18,2) COMMENT 'Rate base. Ref: Oracle CC&B.',
    `rate_base_amount` DECIMAL(18,2) COMMENT 'The net value of utility plant and equipment upon which the utility is allowed to earn a return. Calculated as gross plant in service plus working capital minus accumulated depreciation and contributions in aid of construction. Expressed in USD. Ref: Oracle CC&B.',
    `rate_case_name` STRING COMMENT 'Rate case name. Ref: Oracle CC&B.',
    `rate_case_number` STRING COMMENT 'Rate case docket number. Ref: Oracle CC&B.',
    `rate_case_status` STRING COMMENT 'Filed, Pending, Approved, Denied. Ref: Oracle CC&B.',
    `rate_case_type` STRING COMMENT 'General Rate Case, Interim Rate Adjustment, WICA. Ref: Oracle CC&B.',
    `rate_design_methodology` STRING COMMENT 'The pricing methodology used to allocate the approved revenue requirement across customer classes and rate components. Cost of service allocates based on cost causation; value of service considers customer willingness to pay; marginal cost reflects incremental supply costs; tiered conservation encourages efficiency; uniform rate applies flat pricing; lifeline protects low-income customers. Ref: Oracle CC&B.. Valid values are `cost_of_service|value_of_service|marginal_cost|tiered_conservation|uniform_rate|lifeline`',
    `rate_effective_date` DATE COMMENT 'Date on which the approved rates become effective and are applied to customer bills. May be subject to refund provisions during appeal periods or interim rate periods. Ref: Oracle CC&B.',
    `rate_of_return` DECIMAL(18,2) COMMENT 'Rate of return. Ref: Oracle CC&B.',
    `regulatory_commission` STRING COMMENT 'Regulatory commission name. Ref: Oracle CC&B.',
    `regulatory_lag_days` STRING COMMENT 'Number of days between rate case filing and rate effective date. Regulatory lag represents the period during which the utility operates under outdated rates while awaiting approval, potentially impacting financial performance. Ref: Oracle CC&B.',
    `requested_revenue_requirement` DECIMAL(18,2) COMMENT 'Total annual revenue requirement requested by the utility in the rate case filing. Represents the utilitys calculation of the revenue needed to cover operating expenses (OPEX), capital costs (CAPEX), debt service, and allowed return on investment (ROI). Expressed in USD. Ref: Oracle CC&B.',
    `residential_rate_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage change in typical residential customer bills resulting from the approved rate case. Used for public communication and affordability analysis. Ref: Oracle CC&B.',
    `revenue_increase_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the approved revenue increase (or decrease if negative) compared to current authorized revenue levels. Calculated as approved revenue requirement minus current revenue requirement. Expressed in USD. Ref: Oracle CC&B.',
    `revenue_increase_percentage` DECIMAL(18,2) COMMENT 'Percentage increase (or decrease if negative) in authorized revenue compared to current levels. Calculated as (revenue increase amount / current revenue requirement) * 100. Used for public communication and rate impact analysis. Ref: Oracle CC&B.',
    `settlement_agreement_flag` BOOLEAN COMMENT 'Indicates whether the rate case was resolved through a negotiated settlement agreement among parties rather than a fully litigated commission decision. Settlements often result in faster resolution and reduced regulatory costs. Ref: Oracle CC&B.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each finance rate case in the finance domain.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: Oracle CC&B.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each finance rate case record in the finance domain.',
    `test_year` STRING COMMENT 'Test year. Ref: Oracle CC&B.',
    `test_year_end_date` DATE COMMENT 'Ending date of the test year period used to establish the utilitys revenue requirements and cost structure. Ref: Oracle CC&B.',
    `test_year_start_date` DATE COMMENT 'Beginning date of the test year period used to establish the utilitys revenue requirements and cost structure. The test year is the 12-month period (historical or forecasted) upon which rate calculations are based. Ref: Oracle CC&B.',
    `test_year_type` STRING COMMENT 'Indicates whether the test year is based on historical actual data, forecasted future data, or a hybrid approach combining historical base with known adjustments. Regulatory bodies may have preferences or requirements for test year methodology. Ref: Oracle CC&B.. Valid values are `historical|forecasted|hybrid`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: Oracle CC&B.',
    CONSTRAINT pk_finance_rate_case PRIMARY KEY(`finance_rate_case_id`)
) COMMENT 'Rate case master record for formal water and wastewater rate proceedings filed with the Public Utilities Commission or approved by the utility board. Captures rate case type (general rate case, interim rate, surcharge), filing date, test year, requested revenue requirement, approved revenue requirement, rate effective date, rate case consultant, regulatory docket number, and rate design methodology. Central to utility financial planning and regulatory compliance. [SSOT canonical for service.service_rate_case] [SSOT: Canonical source of truth for this concept across domains.] SSOT master for rate cases.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` (
    `revenue_requirement_id` BIGINT COMMENT 'Unique identifier for the revenue requirement calculation record. Ref: AWWA.',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Revenue requirements drive rate schedule design in rate cases. Rate analysts and regulators need to trace which rate schedules implement each revenue requirement calculation for cost-of-service valida. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Revenue requirements include specific CIP project costs for rate base calculations, depreciation expense, and return on investment. Essential for rate case filings. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue requirements are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `finance_rate_case_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.rate_case. Business justification: Revenue requirements support rate cases. The docket_number STRING should be replaced with FK to rate_case.finance_rate_case_id (note: rate_case PK is finance_rate_case_id, not rate_case_id). Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Revenue requirements are calculated by fund. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `amount` DECIMAL(18,2) COMMENT 'Component amount. Ref: AWWA.',
    `approval_date` DATE COMMENT 'The date when the revenue requirement calculation was approved by the regulatory authority or Public Utilities Commission (PUC). Ref: AWWA.',
    `approved_by` STRING COMMENT 'The name or identifier of the regulatory commissioner or authority representative who approved the revenue requirement. Ref: AWWA.',
    `authorized_rate_of_return_percentage` DECIMAL(18,2) COMMENT 'The rate of return on rate base authorized by the Public Utilities Commission (PUC), typically based on the utilitys weighted average cost of capital (WACC). Ref: AWWA.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the revenue requirement, typically cost-of-service for water utilities following AWWA standards.. Valid values are `cost_of_service|rate_base_rate_of_return|cash_needs|hybrid`',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the revenue requirement calculation in the regulatory approval process. Ref: AWWA.. Valid values are `draft|submitted|under_review|approved|rejected|superseded`',
    `capital_expenditure_amount` DECIMAL(18,2) COMMENT 'Planned capital expenditures allocated to this customer class for the test year, supporting infrastructure investment and asset renewal programs. Ref: AWWA.',
    `component_name` STRING COMMENT 'Component name. Ref: AWWA.',
    `component_type` STRING COMMENT 'Operating Expense, Depreciation, Taxes, Return, Revenue Credit. Ref: AWWA.',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate costs among customer classes, such as base-extra capacity, commodity-demand, customer count, meter equivalent, or consumption ratio. Ref: AWWA.. Valid values are `base_extra_capacity|commodity_demand|customer_count|meter_equivalent|consumption_ratio`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue requirement record was first created in the system. Ref: AWWA.',
    `current_revenue_amount` DECIMAL(18,2) COMMENT 'Current annual revenue collected from this customer class under existing rates, used to calculate the revenue sufficiency gap. Ref: AWWA.',
    `customer_class` STRING COMMENT 'The customer class or rate class for which this revenue requirement component is allocated (residential, commercial, industrial, municipal, wholesale, fire protection). Ref: AWWA.. Valid values are `residential|commercial|industrial|municipal|wholesale|fire_protection`',
    `debt_service_amount` DECIMAL(18,2) COMMENT 'Annual debt service obligations (principal and interest payments) allocated to this customer class for outstanding bonds and loans financing capital improvements. Ref: AWWA.',
    `depreciation_expense_amount` DECIMAL(18,2) COMMENT 'Annual depreciation expense allocated to this customer class based on the utilitys asset base and approved depreciation schedules. Ref: AWWA.',
    `effective_date` DATE COMMENT 'The date when the approved revenue requirement and associated rate adjustments become effective for customer billing. Ref: AWWA.',
    `filing_date` DATE COMMENT 'The date when the revenue requirement calculation was filed with the Public Utilities Commission (PUC) or regulatory authority for rate case proceedings. Ref: AWWA.',
    `grant_funding_amount` DECIMAL(18,2) COMMENT 'Grant funding or subsidies allocated to this customer class that offset the revenue requirement, such as EPA grants or state infrastructure funding. Ref: AWWA.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this revenue requirement record. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue requirement record was last modified. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or explanations regarding the revenue requirement calculation, assumptions, or regulatory adjustments. Ref: AWWA.',
    `om_expense_amount` DECIMAL(18,2) COMMENT 'Total operations and maintenance expenses allocated to this customer class for the test year, including labor, chemicals, utilities, and routine maintenance costs. Ref: AWWA.',
    `operating_expenditure_amount` DECIMAL(18,2) COMMENT 'Total operating expenditures allocated to this customer class for the test year, including O&M expenses and administrative costs. Ref: AWWA.',
    `rate_adjustment_percentage` DECIMAL(18,2) COMMENT 'The percentage rate increase or decrease required for this customer class to meet the revenue requirement, calculated as (revenue sufficiency gap / current revenue) * 100. Ref: AWWA.',
    `rate_base_amount` DECIMAL(18,2) COMMENT 'The net plant investment (original cost of utility plant in service less accumulated depreciation) allocated to this customer class, used to calculate the return on rate base. Ref: AWWA.',
    `regulatory_authority` STRING COMMENT 'The name of the regulatory authority or Public Utilities Commission (PUC) that has jurisdiction over this revenue requirement filing. Ref: AWWA.',
    `return_on_rate_base_amount` DECIMAL(18,2) COMMENT 'The allowed return on the utilitys rate base (net plant investment) allocated to this customer class, calculated as rate base multiplied by the authorized rate of return. Ref: AWWA.',
    `revenue_sufficiency_gap_amount` DECIMAL(18,2) COMMENT 'The difference between the total revenue requirement and current revenue, representing the additional revenue needed from this customer class. Positive values indicate a revenue shortfall; negative values indicate a surplus. Ref: AWWA.',
    `tax_expense_amount` DECIMAL(18,2) COMMENT 'Income taxes, property taxes, and other tax obligations allocated to this customer class for the test year. Ref: AWWA.',
    `test_year` STRING COMMENT 'The fiscal year used as the basis for the revenue requirement calculation, typically the historical year or projected year for rate case analysis. Ref: AWWA.',
    `total_revenue_requirement_amount` DECIMAL(18,2) COMMENT 'Total revenue requirement for this customer class, calculated as the sum of O&M expenses, depreciation, debt service, return on rate base, and taxes. Ref: AWWA.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this revenue requirement record. Ref: AWWA.',
    CONSTRAINT pk_revenue_requirement PRIMARY KEY(`revenue_requirement_id`)
) COMMENT 'Revenue requirement calculation record supporting rate case preparation and annual budget reconciliation. Captures test year, cost of service components (O&M expenses, depreciation, debt service, return on rate base, taxes), allocated by customer class (residential, commercial, industrial, municipal), revenue sufficiency gap, and rate adjustment percentage. Supports PUC filings and AWWA cost-of-service methodology.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` (
    `encumbrance_id` BIGINT COMMENT 'Unique identifier for the encumbrance record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Capital Improvement Program (CIP) project identifier or work breakdown structure (WBS) element if the encumbrance is associated with a capital project. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Encumbrances are allocated to cost centers. The cost_center_code STRING should be replaced with FK to cost_center.cost_center_id. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Encumbrances reserve funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Encumbrances post to GL accounts. The gl_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Grant identifier if the encumbrance is funded by a federal, state, or local grant program, enabling grant expenditure tracking and compliance reporting. Ref: AWWA.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to purchase order. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or contractor to whom the encumbrance obligation is owed, linking to the supplier master data. Ref: AWWA.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Purchase requisitions for work order materials create budget encumbrances before invoicing. Essential for commitment accounting, budget control, and preventing cost overruns on maintenance and capital. Ref: AWWA.',
    `accounting_period` STRING COMMENT 'Accounting period within the fiscal year when the encumbrance was recorded (e.g., 01, 02, ..., 12 or period name). Ref: AWWA.',
    `amount` DECIMAL(18,2) COMMENT 'Original total amount of budget funds reserved by the encumbrance at the time of commitment, representing the expected obligation. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date the encumbrance was approved by the authorized approver, establishing the commitment as valid. Ref: AWWA.',
    `approver_name` STRING COMMENT 'Name of the manager or authorized official who approved the encumbrance, ensuring budgetary control and authorization. Ref: AWWA.',
    `budget_line_item` STRING COMMENT 'Specific budget line item or appropriation code against which the encumbrance is charged, enabling detailed budget vs. actual tracking. Ref: AWWA.',
    `business_area` STRING COMMENT 'Business area or segment code for internal management reporting, enabling cross-functional analysis (e.g., water treatment, wastewater, distribution). Ref: AWWA.',
    `closed_date` DATE COMMENT 'Date the encumbrance was closed, either through full liquidation, cancellation, or fiscal year-end closure process. Ref: AWWA.',
    `company_code` STRING COMMENT 'SAP company code or Tyler Munis entity identifier representing the legal entity or organizational unit recording the encumbrance. Ref: AWWA.',
    `contract_end_date` DATE COMMENT 'End date of the contract or service agreement associated with the encumbrance, if applicable. Ref: AWWA.',
    `contract_start_date` DATE COMMENT 'Start date of the contract or service agreement associated with the encumbrance, if applicable. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the encumbrance record was first created in the lakehouse silver layer. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the encumbrance amounts. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `encumbrance_description` STRING COMMENT 'Detailed narrative description of the purpose and nature of the encumbrance, including goods or services to be acquired. Ref: AWWA.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'Encumbrance amount. Ref: AWWA.',
    `encumbrance_date` DATE COMMENT 'Date the encumbrance was recorded in the financial system, reserving budget funds for the obligation. Ref: AWWA.',
    `encumbrance_number` STRING COMMENT 'Business-facing document number for the encumbrance, typically generated by the financial system (SAP or Tyler Munis) for tracking and reference purposes. Ref: AWWA.',
    `encumbrance_status` STRING COMMENT 'Current lifecycle status of the encumbrance: open (active and uncommitted balance remains), partially_liquidated (some invoices applied), fully_liquidated (all funds expended), closed (fiscal year-end closure), cancelled (voided before liquidation), or reversed (accounting correction). Ref: AWWA.. Valid values are `open|partially_liquidated|fully_liquidated|closed|cancelled|reversed`',
    `encumbrance_type` STRING COMMENT 'Classification of the encumbrance stage: pre-encumbrance (requisition stage), encumbrance (purchase order or contract issued), reservation (blanket order), or commitment (other obligating document). Ref: AWWA.. Valid values are `pre-encumbrance|encumbrance|reservation|commitment`',
    `expected_delivery_date` DATE COMMENT 'Anticipated date when goods or services covered by the encumbrance are expected to be delivered or completed. Ref: AWWA.',
    `expenditure_category` STRING COMMENT 'High-level classification of the encumbrance: capital (CAPEX for infrastructure and equipment), operating (OPEX for day-to-day operations), debt_service (principal and interest payments), or grant (grant-funded expenditure). Ref: AWWA.. Valid values are `capital|operating|debt_service|grant`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the encumbrance was created and against which budget appropriation is reserved (e.g., 2024). Ref: AWWA.',
    `fund_type` STRING COMMENT 'Classification of the fund: governmental (general, special revenue, debt service, capital projects, permanent), proprietary (enterprise, internal service), or fiduciary (pension, investment trust, private-purpose trust, custodial). Ref: AWWA.. Valid values are `governmental|proprietary|fiduciary`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the encumbrance record was last updated in the lakehouse silver layer, capturing any changes to status, amounts, or other attributes. Ref: AWWA.',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of the encumbrance that has been liquidated (expended) through invoice payments or other expenditure transactions. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information related to the encumbrance. Ref: AWWA.',
    `originating_document_date` DATE COMMENT 'Date the originating document (purchase order, contract, etc.) was issued or executed, establishing the commitment. Ref: AWWA.',
    `originating_document_number` STRING COMMENT 'Document number of the source transaction that created this encumbrance (e.g., PO number, contract number, requisition number). Ref: AWWA.',
    `originating_document_type` STRING COMMENT 'Type of source document that created the encumbrance: purchase order, contract, blanket order, requisition, work order, or service agreement. Ref: AWWA.. Valid values are `purchase_order|contract|blanket_order|requisition|work_order|service_agreement`',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Remaining amount. Ref: AWWA.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Unliquidated balance of the encumbrance, calculated as encumbrance_amount minus liquidated_amount, representing funds still reserved for future expenditure. Ref: AWWA.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that initiated the requisition or purchase request leading to the encumbrance. Ref: AWWA.',
    `reversal_date` DATE COMMENT 'Date the encumbrance was reversed, if applicable. Ref: AWWA.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether the encumbrance has been reversed due to an accounting correction or cancellation. True if reversed, False otherwise. Ref: AWWA.',
    `reversal_reason` STRING COMMENT 'Explanation or reason code for why the encumbrance was reversed (e.g., vendor cancellation, budget reallocation, data entry error). Ref: AWWA.',
    `source_system_code` STRING COMMENT 'Unique identifier of the encumbrance record in the source operational system (SAP document number, Tyler Munis encumbrance ID). Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `year_end_carryforward_flag` BOOLEAN COMMENT 'Indicates whether the encumbrance is eligible to be carried forward to the next fiscal year if not fully liquidated by year-end. True if carryforward is allowed, False otherwise. Ref: AWWA.',
    CONSTRAINT pk_encumbrance PRIMARY KEY(`encumbrance_id`)
) COMMENT 'Budgetary encumbrance record reserving appropriated funds for committed obligations not yet expended, including purchase orders, contracts, and blanket agreements. Captures encumbrance type (pre-encumbrance, encumbrance), originating document reference, fund, cost center, GL account, original amount, liquidated amount, outstanding balance, fiscal year, and period. Essential for governmental budgetary control — prevents over-expenditure of appropriated funds and supports available balance reporting per GASB standards.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record in the water utilitys treasury management system. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Bank accounts are associated with specific funds in municipal accounting. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `sweep_target_account_id` BIGINT COMMENT 'The identifier of the bank account to which funds are swept when the sweep arrangement is triggered. Null if no sweep arrangement exists. Ref: AWWA.',
    `account_name` STRING COMMENT 'The legal name or title of the bank account as registered with the financial institution, used for identification and reconciliation purposes. Ref: AWWA.',
    `account_number` STRING COMMENT 'The full bank account number assigned by the financial institution. Stored in masked format for security purposes to protect sensitive financial information. Ref: AWWA.',
    `account_purpose` STRING COMMENT 'Operating, Debt Service, Construction, Payroll. Ref: AWWA.',
    `account_purpose_description` STRING COMMENT 'A detailed description of the specific business purpose and intended use of this bank account within the water utilitys operations. Ref: AWWA.',
    `account_status` STRING COMMENT 'The current operational status of the bank account in the utilitys treasury management system. Ref: AWWA.. Valid values are `active|inactive|closed|frozen|pending_closure`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its primary business purpose within the water utilitys treasury operations. Ref: AWWA.. Valid values are `operating|payroll|debt_service_reserve|construction_fund|investment|escrow`',
    `authorized_signatory_count` STRING COMMENT 'The number of individuals authorized to sign checks or approve electronic transactions on this account. Ref: AWWA.',
    `bank_branch_name` STRING COMMENT 'The name or identifier of the specific bank branch where the account is maintained. Ref: AWWA.',
    `bank_name` STRING COMMENT 'The legal name of the bank or financial institution where the account is held. Ref: AWWA.',
    `bank_routing_number` STRING COMMENT 'The nine-digit American Bankers Association (ABA) routing transit number that identifies the financial institution for electronic funds transfers and check processing. Ref: AWWA.. Valid values are `^[0-9]{9}$`',
    `closed_date` DATE COMMENT 'Account closed date. Ref: AWWA.',
    `closing_date` DATE COMMENT 'The date when the bank account was closed or is scheduled to be closed. Null for active accounts. Ref: AWWA.',
    `collateral_value_amount` DECIMAL(18,2) COMMENT 'The current market value of securities or other assets pledged by the financial institution as collateral for uninsured deposits in this account. Ref: AWWA.',
    `collateralization_required_flag` BOOLEAN COMMENT 'Indicates whether the financial institution is required to provide collateral for deposits exceeding FDIC insurance limits, as mandated by state law or utility policy. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was first created in the water utilitys treasury management system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the denomination of funds held in this account (typically USD for U.S. water utilities).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Current balance. Ref: AWWA.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'The most recent available balance in the bank account as of the last reconciliation or update, expressed in the accounts currency. Ref: AWWA.',
    `daily_balance_limit_amount` DECIMAL(18,2) COMMENT 'The maximum balance amount permitted in this account on any given day, as defined by treasury policy or regulatory requirements. Used for cash management and investment policy compliance. Ref: AWWA.',
    `dual_signature_required_flag` BOOLEAN COMMENT 'Indicates whether transactions above a certain threshold require two authorized signatures for approval, as a control measure. Ref: AWWA.',
    `dual_signature_threshold_amount` DECIMAL(18,2) COMMENT 'The transaction amount above which dual signature authorization is required. Ref: AWWA.',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether the account is insured by the Federal Deposit Insurance Corporation up to applicable limits. Ref: AWWA.',
    `fund_type` STRING COMMENT 'The classification of the associated fund according to GASB governmental accounting standards, indicating the nature and purpose of the fund. Ref: AWWA.. Valid values are `general|enterprise|debt_service|capital_projects|special_revenue|trust`',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether this account earns interest on deposited funds. Ref: AWWA.',
    `interest_rate_percentage` DECIMAL(18,2) COMMENT 'The current annual interest rate percentage applied to the account balance, if the account is interest-bearing. Ref: AWWA.',
    `investment_policy_compliance_flag` BOOLEAN COMMENT 'Indicates whether this account and its associated investment activities comply with the water utilitys board-approved investment policy and applicable state and federal regulations. Ref: AWWA.',
    `is_active` BOOLEAN COMMENT 'Active flag. Ref: AWWA.',
    `last_modified_by` STRING COMMENT 'The username or identifier of the user who most recently modified this bank account record. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was most recently updated in the treasury management system. Ref: AWWA.',
    `last_reconciliation_date` DATE COMMENT 'The date when the most recent bank reconciliation was completed for this account, ensuring that the utilitys records match the banks records. Ref: AWWA.',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'The minimum balance required to be maintained in the account to avoid fees or meet contractual obligations, particularly relevant for debt service reserve accounts. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional free-form notes or comments regarding the bank account, including special instructions, restrictions, or historical context. Ref: AWWA.',
    `opened_date` DATE COMMENT 'Account opened date. Ref: AWWA.',
    `opening_date` DATE COMMENT 'The date when the bank account was originally opened with the financial institution. Ref: AWWA.',
    `reconciliation_status` STRING COMMENT 'The current status of the bank reconciliation process for the most recent accounting period. Ref: AWWA.. Valid values are `reconciled|pending|discrepancy|not_started`',
    `routing_number` STRING COMMENT 'Bank routing number. Ref: AWWA.',
    `sap_company_code` STRING COMMENT 'The SAP ERP company code associated with this bank account for financial integration and reporting purposes. Ref: AWWA.',
    `sap_house_bank_code` STRING COMMENT 'The SAP house bank identifier that links this bank account to the SAP treasury management module for payment processing and cash management. Ref: AWWA.',
    `sweep_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this account participates in an automated cash sweep arrangement where excess funds are automatically transferred to an investment account or vice versa. Ref: AWWA.',
    `sweep_threshold_amount` DECIMAL(18,2) COMMENT 'The balance threshold that triggers the automated sweep of funds to or from the target account. Ref: AWWA.',
    `trustee_agreement_number` STRING COMMENT 'The reference number of the trust agreement governing this account, if managed by a trustee. Ref: AWWA.',
    `trustee_name` STRING COMMENT 'The name of the trustee institution managing this account, applicable for debt service reserve accounts and other trust arrangements. Ref: AWWA.',
    `tyler_munis_bank_code` BOOLEAN COMMENT 'The bank code identifier used in Tyler Technologies Munis system for municipal financial management and fund accounting integration. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: AWWA.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this bank account record in the system. Ref: AWWA.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Treasury management for the water utilitys bank accounts and reconciliation activities. Covers account master data (bank name, account number, account type, fund association, authorized signatories, balance limits, sweep arrangements, investment policy compliance) and monthly reconciliation records (GL balance vs. bank statement balance, outstanding checks, deposits in transit, reconciling items, preparer/reviewer/approval). Supports cash management, internal controls, external audit requirements, and GASB cash and investment disclosures.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'Unique identifier for the bank reconciliation record. Primary key for the bank reconciliation entity. Ref: AWWA.',
    `bank_account_id` BIGINT COMMENT 'Reference to the specific bank account being reconciled, linking to the master bank account registry. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Approved by employee. Ref: AWWA.',
    `bank_approved_by_user_employee_id` BIGINT COMMENT 'User ID of the authorized approver who provided final approval of the bank reconciliation, completing the control cycle. Ref: AWWA.',
    `bank_employee_id` BIGINT COMMENT 'User ID of the staff member who prepared the bank reconciliation, supporting segregation of duties and accountability. Ref: AWWA.',
    `bank_reconciled_by_employee_id` BIGINT COMMENT 'Reconciled by employee. Ref: AWWA.',
    `bank_reviewed_by_user_employee_id` BIGINT COMMENT 'User ID of the supervisor or manager who reviewed the bank reconciliation, supporting internal control requirements.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Bank reconciliations are performed by fund. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Bank reconciliations match bank statements to GL cash accounts. The gl_cash_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `primary_bank_employee_id` BIGINT COMMENT 'User ID of the staff member who prepared the bank reconciliation, supporting segregation of duties and accountability. Ref: AWWA.',
    `tertiary_bank_approved_by_user_employee_id` BIGINT COMMENT 'User ID of the authorized approver who provided final approval of the bank reconciliation, completing the control cycle. Ref: AWWA.',
    `adjusted_bank_balance_amount` DECIMAL(18,2) COMMENT 'The bank statement balance after applying outstanding checks, deposits in transit, and other bank-side adjustments. Ref: AWWA.',
    `adjusted_gl_balance_amount` DECIMAL(18,2) COMMENT 'The GL balance after applying unrecorded bank charges, credits, NSF checks, and other GL-side adjustments. Ref: AWWA.',
    `approval_date` DATE COMMENT 'The date on which the reconciliation received final approval, marking completion of the reconciliation workflow. Ref: AWWA.',
    `approved_by_name` STRING COMMENT 'Full name of the authorized approver who provided final approval for audit trail and reporting purposes. Ref: AWWA.',
    `audit_finding_flag` BOOLEAN COMMENT 'Boolean indicator of whether this reconciliation was subject to an audit finding or exception requiring corrective action. Ref: AWWA.',
    `audit_finding_reference` STRING COMMENT 'Reference number or description of any audit finding associated with this reconciliation, linking to audit management systems. Ref: AWWA.',
    `bank_adjustments_amount` DECIMAL(18,2) COMMENT 'Bank adjustments amount. Ref: AWWA.',
    `bank_charges_amount` DECIMAL(18,2) COMMENT 'Total amount of bank service charges, fees, and other deductions appearing on the bank statement but not yet recorded in the GL. Ref: AWWA.',
    `bank_credits_amount` DECIMAL(18,2) COMMENT 'Total amount of interest income, wire transfers, or other credits appearing on the bank statement but not yet recorded in the GL. Ref: AWWA.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the account being reconciled. Ref: AWWA.',
    `bank_statement_balance_amount` DECIMAL(18,2) COMMENT 'The ending balance per the bank statement for the reconciliation period, as reported by the financial institution. Ref: AWWA.',
    `bank_statement_date` DATE COMMENT 'The statement date from the bank statement being reconciled, which may differ from the period end date. Ref: AWWA.',
    `bank_statement_reference_number` STRING COMMENT 'The reference or document number from the bank statement being reconciled, used for audit trail and verification. Ref: AWWA.',
    `book_adjustments_amount` DECIMAL(18,2) COMMENT 'Book adjustments amount. Ref: AWWA.',
    `company_code` STRING COMMENT 'The SAP company code or organizational entity code to which this bank account and reconciliation belong. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank reconciliation record was first created in the system, supporting audit trail requirements. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bank account and all monetary amounts in this reconciliation.. Valid values are `USD|CAD|EUR|GBP|MXN|AUD`',
    `deposits_in_transit_amount` DECIMAL(18,2) COMMENT 'Total amount of deposits recorded in the GL but not yet reflected on the bank statement as of the period end date. Ref: AWWA.',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1-12 for monthly periods) to which this reconciliation applies. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reconciliation period belongs, used for financial reporting and compliance tracking. Ref: AWWA.',
    `gl_balance_amount` DECIMAL(18,2) COMMENT 'The cash balance per the general ledger for this account as of the period end date, before reconciling adjustments. Ref: AWWA.',
    `gl_ending_balance` DECIMAL(18,2) COMMENT 'GL ending balance. Ref: AWWA.',
    `gl_posting_date` DATE COMMENT 'The date on which reconciliation adjustments were posted to the general ledger. Ref: AWWA.',
    `gl_posting_document_number` STRING COMMENT 'The journal entry document number for any GL adjustments posted as a result of this reconciliation. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank reconciliation record was last updated, supporting change tracking and audit requirements. Ref: AWWA.',
    `nsf_checks_amount` DECIMAL(18,2) COMMENT 'Total amount of customer checks returned by the bank due to insufficient funds, requiring GL adjustment. Ref: AWWA.',
    `other_reconciling_items_amount` DECIMAL(18,2) COMMENT 'Net amount of all other reconciling items not classified in the standard categories, including errors, adjustments, and timing differences. Ref: AWWA.',
    `outstanding_checks_amount` DECIMAL(18,2) COMMENT 'Total amount of checks issued and recorded in the GL but not yet cleared by the bank as of the period end date. Ref: AWWA.',
    `outstanding_items_count` STRING COMMENT 'Total number of outstanding reconciling items (checks, deposits, adjustments) identified during the reconciliation process. Ref: AWWA.',
    `period_end_date` DATE COMMENT 'The last day of the accounting period being reconciled, typically month-end or fiscal period-end. Ref: AWWA.',
    `prepared_by_name` STRING COMMENT 'Full name of the staff member who prepared the reconciliation for audit trail and reporting purposes. Ref: AWWA.',
    `prepared_date` DATE COMMENT 'The date on which the reconciliation was prepared, distinct from the reconciliation date and period end date. Ref: AWWA.',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'Reconciled balance. Ref: AWWA.',
    `reconciled_balance_amount` DECIMAL(18,2) COMMENT 'The final reconciled cash balance that should match between adjusted GL and adjusted bank balances, representing the true cash position. Ref: AWWA.',
    `reconciliation_date` DATE COMMENT 'The date on which the bank reconciliation was performed, representing the principal business event timestamp for this transaction. Ref: AWWA.',
    `reconciliation_method` STRING COMMENT 'The method used to perform the reconciliation, indicating level of automation and system support. Ref: AWWA.. Valid values are `manual|automated|semi_automated`',
    `reconciliation_notes` STRING COMMENT 'Free-text notes documenting unusual items, explanations for variances, follow-up actions, or other relevant information for audit and review purposes. Ref: AWWA.',
    `reconciliation_number` STRING COMMENT 'Business identifier for the reconciliation record, typically formatted as RECON-YYYY-MM-ACCT or similar pattern used for external reference and audit trail. Ref: AWWA.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the bank reconciliation process indicating workflow stage from draft through final approval. Ref: AWWA.. Valid values are `draft|in_progress|completed|approved|rejected|under_review`',
    `reviewed_by_name` STRING COMMENT 'Full name of the supervisor or manager who reviewed the reconciliation for audit trail and reporting purposes.',
    `reviewed_date` DATE COMMENT 'The date on which the reconciliation was reviewed by the supervisor, supporting timely review requirements.',
    `sap_company_code` STRING COMMENT 'The SAP ERP company code for cross-system reconciliation and integration with SAP FI/CO modules. Ref: AWWA.',
    `statement_date` DATE COMMENT 'Bank statement date. Ref: AWWA.',
    `statement_ending_balance` DECIMAL(18,2) COMMENT 'Statement ending balance. Ref: AWWA.',
    `tyler_munis_transaction_reference` BOOLEAN COMMENT 'The Tyler Technologies Munis system transaction identifier for municipal utilities using Munis for financial management. Ref: AWWA.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between adjusted GL balance and adjusted bank balance, indicating unresolved reconciling items or errors requiring investigation. Ref: AWWA.',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Monthly bank reconciliation record matching the water utilitys general ledger cash balances to bank statement balances for each bank account. Captures reconciliation period, GL balance, bank statement balance, outstanding checks, deposits in transit, unrecorded bank charges, reconciling items, reconciled balance, preparer, reviewer, and approval date. Supports internal controls and external audit requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` (
    `interfund_transfer_id` BIGINT COMMENT 'Unique identifier for the interfund_transfer data product (auto-inserted pre-linking). Ref: AWWA.',
    `budget_line_id` BIGINT COMMENT 'FK to finance.budget_line. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Interfund transfers may fund specific capital projects and require project tracking for proper capitalization and fund accounting. Essential for GASB compliance. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Destination cost center. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Unique identifier for the destination fund referenced by each interfund transfer record in the finance domain.',
    `from_fund_id` BIGINT COMMENT 'Source fund. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Employee who approved transfer. Ref: AWWA.',
    `interfund_authorized_by_employee_id` BIGINT COMMENT 'Employee who authorized the transfer. Ref: AWWA.',
    `interfund_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the interfund created by employee referenced by each interfund transfer record in the finance domain.',
    `interfund_posted_by_employee_id` BIGINT COMMENT 'FK to workforce.employee (poster). Ref: AWWA.',
    `interfund_prepared_by_employee_id` BIGINT COMMENT 'Employee who prepared transfer. Ref: AWWA.',
    `interfund_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the interfund responsible employee referenced by each interfund transfer record in the finance domain.',
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry referenced by each interfund transfer record in the finance domain.',
    `reversal_interfund_transfer_id` BIGINT COMMENT 'Self-referencing FK on interfund_transfer (reversal_interfund_transfer_id). Ref: AWWA.',
    `source_cost_center_id` BIGINT COMMENT 'Source cost center. Ref: AWWA.',
    `source_fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Interfund transfers move money from a source fund. The interfund_transfer table has no visible attributes other than PK, so this FK is needed to link to the source fund. The FK uses the descriptive pr. Ref: AWWA.',
    `to_fund_id` BIGINT COMMENT 'Destination fund. Ref: AWWA.',
    `amount` DECIMAL(18,2) COMMENT 'Transfer amount. Ref: AWWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each interfund transfer in the finance domain.',
    `approval_date` DATE COMMENT 'The approval date associated with each interfund transfer record in the finance domain.',
    `approved_by` STRING COMMENT 'The approved by value recorded for each interfund transfer in the finance domain.',
    `approved_by_name` STRING COMMENT 'Name of the approving authority. Ref: AWWA.',
    `approved_date` DATE COMMENT 'Date transfer was approved. Ref: AWWA.',
    `approved_flag` BOOLEAN COMMENT 'The approved flag value recorded for each interfund transfer in the finance domain.',
    `authorization_reference` STRING COMMENT 'Board resolution or authorization reference. Ref: AWWA.',
    `board_resolution_number` STRING COMMENT 'Board resolution number. Ref: AWWA.',
    `interfund_transfer_category` STRING COMMENT 'The interfund transfer category value recorded for each interfund transfer in the finance domain.',
    `classification` STRING COMMENT 'The classification value recorded for each interfund transfer in the finance domain.',
    `interfund_transfer_code` STRING COMMENT 'The interfund transfer code value recorded for each interfund transfer in the finance domain.',
    `comments` STRING COMMENT 'Additional notes. Ref: AWWA.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each interfund transfer in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each interfund transfer in the finance domain.',
    `interfund_transfer_description` STRING COMMENT 'The interfund transfer description value recorded for each interfund transfer in the finance domain.',
    `effective_date` DATE COMMENT 'Effective accounting date. Ref: AWWA.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: AWWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: AWWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each interfund transfer record in the finance domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each interfund transfer record in the finance domain.',
    `fiscal_period` STRING COMMENT 'Fiscal period within year. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'Fiscal year of transfer. Ref: AWWA.',
    `gasb_classification` STRING COMMENT 'GASB classification: interfund loan, transfer, reimbursement. Ref: AWWA.',
    `gasb_compliant` BOOLEAN COMMENT 'Whether transfer is GASB compliant. Ref: AWWA.',
    `gasb_transfer_type` STRING COMMENT 'GASB classification: Interfund Transfer, Reimbursement, Loan. Ref: AWWA.',
    `interfund_transfer_number` STRING COMMENT 'The interfund transfer number value recorded for each interfund transfer in the finance domain.',
    `interfund_transfer_type` STRING COMMENT 'The interfund transfer type value recorded for each interfund transfer in the finance domain.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: AWWA.',
    `is_recurring` BOOLEAN COMMENT 'Whether this is a recurring transfer. Ref: AWWA.',
    `is_reversal` BOOLEAN COMMENT 'Whether this transfer reverses a prior transfer. Ref: AWWA.',
    `is_reversed` BOOLEAN COMMENT 'Boolean flag indicating whether the is reversed condition applies to the interfund transfer record.',
    `interfund_transfer_name` STRING COMMENT 'The interfund transfer name used to identify each interfund transfer record in the finance domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: AWWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each interfund transfer in the finance domain.',
    `posted_date` DATE COMMENT 'The posted date associated with each interfund transfer record in the finance domain.',
    `posting_date` DATE COMMENT 'Date posted to general ledger. Ref: AWWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each interfund transfer in the finance domain.',
    `purpose` STRING COMMENT 'The purpose value recorded for each interfund transfer in the finance domain.',
    `purpose_description` STRING COMMENT 'Purpose/justification for transfer. Ref: AWWA.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each interfund transfer in the finance domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: AWWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each interfund transfer in the finance domain.',
    `recurrence_frequency` STRING COMMENT 'Frequency if recurring (monthly, quarterly, annual). Ref: AWWA.',
    `recurring_frequency` STRING COMMENT 'Monthly, quarterly, annual. Ref: AWWA.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each interfund transfer in the finance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each interfund transfer in the finance domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each interfund transfer record in the finance domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each interfund transfer in the finance domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each interfund transfer in the finance domain.',
    `reversal_date` DATE COMMENT 'The reversal date associated with each interfund transfer record in the finance domain.',
    `reversal_flag` BOOLEAN COMMENT 'The reversal flag value recorded for each interfund transfer in the finance domain.',
    `reversal_reason` STRING COMMENT 'The reversal reason value recorded for each interfund transfer in the finance domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each interfund transfer record in the finance domain.',
    `interfund_transfer_status` STRING COMMENT 'Lifecycle status of the record. Ref: AWWA.',
    `transfer_amount` DECIMAL(18,2) COMMENT 'The transfer amount value recorded for each interfund transfer in the finance domain.',
    `transfer_amount_usd` DECIMAL(18,2) COMMENT 'The transfer amount usd value recorded for each interfund transfer in the finance domain.',
    `transfer_date` DATE COMMENT 'Date of transfer. Ref: AWWA.',
    `transfer_description` STRING COMMENT 'Description of the purpose of the interfund transfer. Ref: AWWA.',
    `transfer_number` STRING COMMENT 'Unique transfer reference number. Ref: AWWA.',
    `transfer_purpose` STRING COMMENT 'The transfer purpose value recorded for each interfund transfer in the finance domain.',
    `transfer_reason` STRING COMMENT 'Reason for interfund transfer. Ref: AWWA.',
    `transfer_status` STRING COMMENT 'Status (pending, approved, posted, reversed). Ref: AWWA.',
    `transfer_type` STRING COMMENT 'Type (operating, capital, debt_service, reimbursement). Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each interfund transfer in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each interfund transfer record in the finance domain.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure touch. Ref: AWWA.',
    CONSTRAINT pk_interfund_transfer PRIMARY KEY(`interfund_transfer_id`)
) COMMENT 'Interfund transfer transaction recording the movement of cash and resources between the water utilitys distinct accounting funds (e.g., transfers from Water Enterprise Fund to Debt Service Fund for bond payments, transfers from Capital Projects Fund). Captures source fund, destination fund, transfer amount, authorization reference (board resolution), fiscal year, posting period, and GL posting document. Required for GASB fund financial statements and CAFR preparation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation transaction. Primary key. Ref: AWWA.',
    `allocation_cycle_id` BIGINT COMMENT 'Reference to the allocation cycle or batch run during which this allocation was executed. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital improvement project or work breakdown structure element to which the allocated costs are assigned, if applicable. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'User ID of the person who approved this allocation rule. Supports audit trail and governance requirements. Ref: AWWA.',
    `cost_reversed_allocation_id` BIGINT COMMENT 'Reference to the original cost allocation transaction that is being reversed by this transaction, if applicable. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key to source cost center. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Cost allocations are performed within funds. The fund_code STRING should be replaced with FK to fund.fund_id. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Cost allocations post to GL accounts. The gl_account_code STRING should be replaced with FK to general_ledger.general_ledger_id. Ref: AWWA.',
    `primary_cost_employee_id` BIGINT COMMENT 'User ID of the person who approved the cost allocation transaction for posting. Ref: AWWA.',
    `primary_sender_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center. Ref: AWWA.',
    `source_cost_allocation_id` BIGINT COMMENT 'Self-referencing FK on cost_allocation (source_cost_allocation_id). Ref: AWWA.',
    `tertiary_cost_responsible_manager_employee_id` BIGINT COMMENT 'Employee ID of the manager responsible for this allocation rule. Links to HR system for organizational accountability. Ref: AWWA.',
    `to_cost_center_id` BIGINT COMMENT 'Foreign key to destination cost center. Ref: AWWA.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Total monetary amount of costs allocated from the sender cost center to the receiver cost center in this transaction. Ref: AWWA.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Allocation amount. Ref: AWWA.',
    `allocation_basis` STRING COMMENT 'The driver or basis used to allocate costs, such as Million Gallons per Day (MGD), Full-Time Equivalents (FTE), Asset Book Value, Square Footage, Direct Labor Hours, or Number of Service Connections. Ref: AWWA.',
    `allocation_code` STRING COMMENT 'Unique business identifier code for the cost allocation method or rule. Used for external reporting and cross-system reference. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,12}$`',
    `allocation_date` DATE COMMENT 'Business date on which the cost allocation was executed or effective, typically the last day of the posting period. Ref: AWWA.',
    `allocation_description` STRING COMMENT 'Detailed description of the allocation rule, including business rationale, methodology, and any special considerations or exceptions. Ref: AWWA.',
    `allocation_driver_unit_of_measure` STRING COMMENT 'Unit of measure for the allocation driver, such as MGD, FTE, USD, square_feet, hours, connections, or gallons. Defines how the allocation basis is quantified. Ref: AWWA.',
    `allocation_formula` STRING COMMENT 'Mathematical formula or expression defining the allocation calculation. May reference allocation drivers, weights, and cost pools. Used for complex or custom allocation logic. Ref: AWWA.',
    `allocation_frequency` STRING COMMENT 'Frequency at which this allocation rule is executed: monthly (standard period-end), quarterly (for quarterly closings), annually (year-end only), or on_demand (manual trigger). Ref: AWWA.. Valid values are `monthly|quarterly|annually|on_demand`',
    `allocation_method` STRING COMMENT 'Specific allocation basis or driver used to distribute costs: percentage split, statistical key figure (e.g., MGD treated, customer count), activity quantity, headcount, square footage, revenue, or direct labor hours. [ENUM-REF-CANDIDATE: percentage|statistical_key_figure|activity_quantity|headcount|square_footage|revenue|direct_labor_hours — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `allocation_name` STRING COMMENT 'Descriptive name of the cost allocation method or rule, such as Direct Labor Hours, MGD-Based Allocation, or Asset Value Allocation. Ref: AWWA.',
    `allocation_number` STRING COMMENT 'Business document number assigned to this cost allocation transaction for traceability and audit purposes. Ref: AWWA.',
    `allocation_pct` DECIMAL(18,2) COMMENT 'Allocation percentage. Ref: AWWA.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of sender cost center costs allocated to the receiver cost center when using percentage-based allocation method. Expressed as a decimal (e.g., 15.50 for 15.5%). Ref: AWWA.',
    `allocation_priority` STRING COMMENT 'Execution sequence priority for step-down or cascading allocation methods. Lower numbers execute first. Used to control the order of multi-stage cost allocations. Ref: AWWA.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the cost allocation transaction indicating whether it is in draft, approved for posting, posted to the general ledger, reversed, or cancelled. Ref: AWWA.. Valid values are `draft|approved|posted|reversed|cancelled`',
    `allocation_type` STRING COMMENT 'Classification of the allocation method used: assessment (fixed percentage), distribution (variable key), periodic (recurring), statistical (based on statistical key figures), activity-based (ABC costing), or direct (one-to-one). Ref: AWWA.. Valid values are `assessment|distribution|periodic|statistical|activity_based|direct`',
    `allocation_weight` DECIMAL(18,2) COMMENT 'Numeric weight or factor used in weighted allocation calculations. Represents the relative consumption or usage of the allocation driver by the target cost center. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date on which this allocation rule was formally approved. Supports audit trail and compliance documentation. Ref: AWWA.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this allocation rule requires formal approval before activation. True if approval workflow is required. Ref: AWWA.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cost allocation transaction was approved for posting. Ref: AWWA.',
    `business_area` STRING COMMENT 'Business area or segment for internal reporting, such as water treatment, wastewater treatment, or distribution operations. Ref: AWWA.',
    `capital_expenditure_flag` BOOLEAN COMMENT 'Indicates whether the allocated costs are capitalized as part of a capital project or asset acquisition. Ref: AWWA.',
    `capital_operating_split_flag` BOOLEAN COMMENT 'Indicates whether this allocation rule splits costs between capital expenditures (CAPEX) and operating expenditures (OPEX). True if split allocation is applied. Ref: AWWA.',
    `capital_percentage` DECIMAL(18,2) COMMENT 'Percentage of allocated costs classified as capital expenditures. Expressed as a decimal (e.g., 0.30 for 30%). Used when capital_operating_split_flag is true. Ref: AWWA.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or organizational unit for which the cost allocation is recorded. Ref: AWWA.',
    `controlling_area` STRING COMMENT 'SAP Controlling Area code representing the organizational unit for cost accounting and internal reporting. Defines the scope of cost allocation processing. Ref: AWWA.',
    `cost_element_group` STRING COMMENT 'Grouping of cost elements (GL accounts) subject to this allocation rule. Examples include Personnel Costs, Utilities, Depreciation, Administrative Overhead. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'User ID of the person who created this cost allocation record. Supports audit trail and accountability. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cost allocation record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
    `cost_allocation_description` STRING COMMENT 'Detailed textual description of the cost allocation transaction, including the purpose and context of the allocation. Ref: AWWA.',
    `document_date` DATE COMMENT 'Date assigned to the allocation document for audit and reference purposes, typically matching the allocation date. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date on which this cost allocation rule ceases to be effective. Null for open-ended rules. Supports temporal versioning and rule supersession. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date from which this cost allocation rule becomes effective and is applied in cost accounting cycles. Supports temporal versioning of allocation rules. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the cost allocation transaction belongs. Ref: AWWA.',
    `functional_area` STRING COMMENT 'Functional area classification such as Operations, Maintenance, Administration, Engineering, or Customer Service. Used for functional cost analysis. Ref: AWWA.',
    `gasb_category` STRING COMMENT 'GASB functional or program category to which the allocated costs are assigned for governmental financial reporting (e.g., water treatment, distribution, administration). Ref: AWWA.',
    `gasb_compliance_flag` BOOLEAN COMMENT 'Indicates whether this allocation method complies with GASB standards for governmental fund accounting and financial reporting. True if GASB-compliant. Ref: AWWA.',
    `last_execution_date` DATE COMMENT 'Date on which this allocation rule was last executed in a cost allocation cycle. Used for monitoring and reconciliation. Ref: AWWA.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this cost allocation record. Supports audit trail and accountability. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cost allocation record was last updated or modified. Ref: AWWA.',
    `next_scheduled_execution_date` DATE COMMENT 'Date on which this allocation rule is next scheduled to execute based on allocation_frequency. Used for planning and period-end close scheduling. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional free-form notes or comments related to the cost allocation transaction for audit trail and business context. Ref: AWWA.',
    `operating_percentage` DECIMAL(18,2) COMMENT 'Percentage of allocated costs classified as operating expenditures. Expressed as a decimal (e.g., 0.70 for 70%). Used when capital_operating_split_flag is true. Ref: AWWA.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the cost allocation transaction was posted to the general ledger. Ref: AWWA.',
    `posting_date` DATE COMMENT 'Date on which the cost allocation transaction was posted to the general ledger. Ref: AWWA.',
    `posting_period` STRING COMMENT 'Fiscal period to which the cost allocation is posted, in YYYYMM format (e.g., 202312 for December 2023). Ref: AWWA.. Valid values are `^d{6}$`',
    `profit_center_code` STRING COMMENT 'Profit center code for internal management reporting, identifying the profit center to which the allocated costs are assigned. Ref: AWWA.',
    `rate_case_eligible_flag` BOOLEAN COMMENT 'Indicates whether the allocated costs are eligible for inclusion in rate case cost-of-service calculations for regulatory rate-setting purposes. Ref: AWWA.',
    `reciprocal_allocation_flag` BOOLEAN COMMENT 'Indicates whether this allocation participates in reciprocal (mutual service) allocation calculations where departments provide services to each other. True if reciprocal method is used. Ref: AWWA.',
    `responsible_manager_name` STRING COMMENT 'Name of the manager or cost accountant responsible for maintaining and approving this allocation rule. Supports accountability and audit trail. Ref: AWWA.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this cost allocation transaction is a reversal of a previously posted allocation. Ref: AWWA.',
    `reversal_reason` STRING COMMENT 'Business reason or explanation for reversing the original cost allocation transaction. Ref: AWWA.',
    `source_cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code from which costs are being allocated. Represents the originating department or functional area (e.g., ADMIN, HR, IT, FLEET). Ref: AWWA.',
    `statistical_key_figure_code` STRING COMMENT 'Code representing the statistical key figure used as the allocation driver (e.g., MGD, customer count, meter count, employee headcount). Ref: AWWA.',
    `statistical_key_figure_value` DECIMAL(18,2) COMMENT 'Numeric value of the statistical key figure for the receiver cost center used to calculate the allocation proportion. Ref: AWWA.',
    `target_cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code to which costs are being allocated. Represents the receiving department or functional area (e.g., WTP_OPS, DIST_MAINT, WWTP_OPS). Ref: AWWA.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element code for detailed project cost tracking within SAP PS. Ref: AWWA.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Master reference table for cost_allocation. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` (
    `project_funding_allocation_id` BIGINT COMMENT 'Unique identifier for this grant-to-project funding allocation record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to the CIP project receiving funding from this allocation. Ref: AWWA.',
    `debt_instrument_id` BIGINT COMMENT 'Foreign key to debt instrument. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key to fund. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant providing funding for this allocation. Ref: AWWA.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated amount. Ref: AWWA.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds allocated to this specific CIP project. Sum of all allocation_amount values for a grant should not exceed the grants award_amount. Ref: AWWA.',
    `allocation_closeout_date` DATE COMMENT 'Date on which this allocation was formally closed out, indicating all eligible costs have been charged and final reporting completed. Null if allocation is still active. Ref: AWWA.',
    `allocation_date` DATE COMMENT 'Date on which this grant funding was formally allocated to this CIP project by finance or executive management. Ref: AWWA.',
    `allocation_pct` DECIMAL(18,2) COMMENT 'Allocation percentage. Ref: AWWA.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total grant award allocated to this CIP project. Calculated as (allocation_amount / grant.award_amount) * 100. Ref: AWWA.',
    `allocation_status` STRING COMMENT 'Current status of this funding allocation: active (funds available for drawdown), on_hold (temporarily suspended), fully_drawn (allocation fully expended), closed (allocation closed out with grantor), cancelled (allocation terminated). Ref: AWWA.',
    `amount_drawn_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of grant funds that have been drawn down or reimbursed for this specific project allocation. Should not exceed allocation_amount. Ref: AWWA.',
    `compliance_requirements` STRING COMMENT 'Specific compliance requirements and conditions that apply to this grant-project allocation, such as prevailing wage requirements, Buy America provisions, environmental review milestones, or project-specific reporting obligations. Derived from the grants compliance_conditions but tailored to this project. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `drawdown_schedule_type` STRING COMMENT 'Type of drawdown schedule governing how funds are requested and disbursed for this allocation: milestone_based (tied to project milestones), monthly_reimbursement (monthly cost reimbursement), quarterly_advance (quarterly advances), completion_based (upon project completion), cost_incurred (as costs are incurred). Ref: AWWA.',
    `eligible_cost_categories` DECIMAL(18,2) COMMENT 'Specific cost categories from this CIP project that are eligible to be charged against this grant allocation (e.g., design_engineering, construction, equipment or labor, materials). Subset of the grants allowable_cost_categories tailored to this project. Ref: AWWA.',
    `funding_source_type` STRING COMMENT 'Bond, Grant, Rate Revenue, Contribution, Other. Ref: AWWA.',
    `last_drawdown_date` DATE COMMENT 'Date of the most recent drawdown or reimbursement request submitted for this allocation. Null if no drawdowns have occurred yet. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text notes documenting special conditions, amendments, or administrative details specific to this grant-project allocation. Ref: AWWA.',
    `remaining_allocation_balance` DECIMAL(18,2) COMMENT 'Dollar amount of allocated grant funds still available for this project. Calculated as allocation_amount minus amount_drawn_to_date. Ref: AWWA.',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress and expenditure reports must be submitted to the grantor for this allocation: monthly, quarterly, semi_annual, annual, milestone_based, upon_completion. Ref: AWWA.',
    CONSTRAINT pk_project_funding_allocation PRIMARY KEY(`project_funding_allocation_id`)
) COMMENT 'This association product represents the funding allocation contract between grant and cip_project. It captures the specific terms, amounts, and compliance requirements for how each grant funds each CIP project. Each record links one grant to one cip_project with attributes that exist only in the context of this funding relationship, including allocation amounts, eligible cost categories, drawdown schedules, and grant-specific compliance requirements.. Existence Justification: In water utility operations, CIP projects are routinely funded by blending multiple funding sources: federal SRF loans, EPA WIFIA loans, state grants, USDA Rural Development grants, and local bonds. A single large infrastructure project (e.g., $50M treatment plant upgrade) may draw from 3-5 different grant programs, each with distinct allocation amounts, eligible cost categories, drawdown schedules, and compliance requirements. Conversely, a single large grant award (e.g., EPA Clean Water SRF) is typically allocated across multiple CIP projects within the utilitys capital program. The allocation relationship is actively managed by finance/grants staff who track drawdowns, ensure compliance, and report to grantors on a per-project, per-grant basis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` (
    `grant_allocation_id` BIGINT COMMENT 'Unique identifier for this grant allocation record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key to CIP project. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key to cost center. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant award funding this lift station project. Ref: AWWA.',
    `lift_station_id` BIGINT COMMENT 'Foreign key linking to the lift station receiving grant-funded improvements. Ref: AWWA.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated amount. Ref: AWWA.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds allocated to this specific lift station project from this grant award. Used for budget tracking and drawdown planning. Ref: AWWA.',
    `allocation_date` DATE COMMENT 'Date on which grant funds were formally allocated to this lift station project in the utilitys capital improvement plan and grant budget. Ref: AWWA.',
    `allocation_purpose` STRING COMMENT 'Allocation purpose description. Ref: AWWA.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this grant allocation: planned (budgeted but not started), active (project underway), complete (project finished, awaiting closeout), closed (fully reimbursed and closed out with grantor). Ref: AWWA.',
    `compliance_certification_date` DATE COMMENT 'Date on which the utility certified compliance with grant conditions for this lift station project (e.g., Davis-Bacon wage requirements, environmental review, AIS compliance). Required for final reimbursement and closeout. Ref: AWWA.',
    `construction_cost` DECIMAL(18,2) COMMENT 'Total estimated or actual construction cost for the lift station improvements funded by this grant allocation. May exceed allocation_amount if matching funds or other grants are involved. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `eligible_cost_amount` DECIMAL(18,2) COMMENT 'Dollar amount of project costs that are eligible for grant reimbursement under the grant agreement terms (excludes ineligible costs like land acquisition, certain administrative costs). Ref: AWWA.',
    `grant_percentage` DECIMAL(18,2) COMMENT 'Percentage of the lift station project cost covered by this specific grant (e.g., 75.00 for 75% grant funding, 25% local match). Used for cost allocation and compliance reporting. Ref: AWWA.',
    `ineligible_cost_amount` DECIMAL(18,2) COMMENT 'Dollar amount of project costs that are not eligible for grant reimbursement and must be funded by local sources. Ref: AWWA.',
    `project_completion_date` DATE COMMENT 'Date on which the grant-funded lift station improvements were substantially completed and the asset was returned to service. Used for final reimbursement requests. Ref: AWWA.',
    `project_description` STRING COMMENT 'Detailed description of the specific improvements being made to this lift station with this grant funding (e.g., Replace two 50HP pumps with energy-efficient models, Install 100kW backup generator, Upgrade SCADA telemetry). Ref: AWWA.',
    `project_milestone` STRING COMMENT 'Current milestone status of the grant-funded lift station project: design_complete, construction_started, construction_complete, operational, closeout. Used for progress reporting to grantor and drawdown eligibility. Ref: AWWA.',
    `project_start_date` DATE COMMENT 'Date on which construction or improvement work began on this grant-funded lift station project. Used for period of performance tracking. Ref: AWWA.',
    `reimbursement_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of grant funds that have been drawn down or reimbursed for this specific lift station project. Tracks expenditure against allocation_amount. Ref: AWWA.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each grant allocation in the finance domain.',
    CONSTRAINT pk_grant_allocation PRIMARY KEY(`grant_allocation_id`)
) COMMENT 'This association product represents the allocation of grant funding to specific lift station capital improvement projects. It captures the financial relationship between a grant award and the infrastructure assets it funds. Each record links one lift station to one grant with project-specific funding details, expenditure tracking, compliance milestones, and reimbursement status required for grantor reporting and GASB grant accounting.. Existence Justification: Water utilities routinely fund capital improvements to multiple lift stations using a single grant award (e.g., an EPA WIFIA loan for system-wide pump efficiency upgrades, or an ARPA resilience grant covering backup power at 10 stations). Conversely, a single lift station rehabilitation project often requires funding from multiple grant sources (e.g., 50% SRF loan, 25% state energy efficiency grant, 25% local match). The utility must track project-specific expenditures, reimbursement requests, and compliance certifications for each lift station-grant combination to support grantor reporting, GASB accounting, and single audit requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` (
    `grant_funded_segment_id` BIGINT COMMENT 'Unique identifier for this grant-segment funding relationship. Primary key. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant providing funding for this segment. Ref: AWWA.',
    `segment_id` BIGINT COMMENT 'Foreign key to customer segment. Ref: AWWA.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to the sewer network segment receiving grant funding. Ref: AWWA.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated amount. Ref: AWWA.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds allocated to this specific sewer segment for rehabilitation or replacement work. Used for cost tracking and drawdown requests. Ref: AWWA.',
    `allocation_date` DATE COMMENT 'Date when grant funds were formally allocated to this sewer segment in the capital improvement plan or grant budget. Establishes eligibility period for cost incurrence. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `customer_count` STRING COMMENT 'Number of customers served. Ref: AWWA.',
    `eligible_cost_flag` DECIMAL(18,2) COMMENT 'Indicates whether costs for this segment are eligible for reimbursement under this grants allowable cost categories and compliance conditions. False if segment work does not meet grantor requirements. Ref: AWWA.',
    `expended_amount` DECIMAL(18,2) COMMENT 'Expended amount. Ref: AWWA.',
    `expenditure_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of grant funds expended on this segment to date. Calculated from individual expenditure transactions. Used for drawdown reconciliation and remaining balance tracking. Ref: AWWA.',
    `grant_percentage` DECIMAL(18,2) COMMENT 'Percentage of the segment rehabilitation cost covered by this specific grant. Supports scenarios where multiple grants fund a single segment. Ref: AWWA.',
    `match_requirement_amount` DECIMAL(18,2) COMMENT 'Dollar amount of local matching funds required for this segment based on the grants matching percentage. Calculated as segment_rehabilitation_cost × grant.matching_requirement_percentage. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text notes documenting special conditions, cost allocation decisions, or grantor communications specific to this segment-grant funding relationship. Ref: AWWA.',
    `project_phase` STRING COMMENT 'Current phase of the grant-funded rehabilitation project for this segment. Values: Planning, Design, Bidding, Construction, Closeout, Complete. Used for milestone tracking and grantor reporting. Ref: AWWA.',
    `reimbursement_status` STRING COMMENT 'Current status of reimbursement request for expenditures on this segment. Values: Not Requested, Requested, Approved, Paid, Denied. Tracks the drawdown lifecycle for grantor compliance. Ref: AWWA.',
    `segment_rehabilitation_cost` DECIMAL(18,2) COMMENT 'Total estimated or actual cost of rehabilitation work on this sewer segment funded by this grant. May exceed allocation if multiple funding sources are used. Ref: AWWA.',
    `work_completion_date` DATE COMMENT 'Date when rehabilitation work was completed on this segment. Triggers final expenditure reconciliation and closeout processes for this segment-grant relationship. Ref: AWWA.',
    `work_start_date` DATE COMMENT 'Date when rehabilitation work began on this segment under this grant. Used for period of performance compliance and project timeline tracking. Ref: AWWA.',
    CONSTRAINT pk_grant_funded_segment PRIMARY KEY(`grant_funded_segment_id`)
) COMMENT 'This association product represents the funding relationship between sewer network segments and infrastructure grants. It captures the allocation of grant funds to specific sewer rehabilitation or replacement projects, tracking costs, reimbursement status, and compliance with grantor requirements. Each record links one sewer segment to one grant with financial and project phase attributes that exist only in the context of this funding relationship.. Existence Justification: In water utility capital improvement programs, a single sewer segment rehabilitation project is routinely funded by multiple grants simultaneously (e.g., 60% CWSRF, 30% EPA WIFIA, 10% state infrastructure bank), and each grant award covers multiple sewer segments across the service area. Grant administrators actively manage these funding relationships to track cost allocation, ensure compliance with each grantors allowable cost categories, prepare segment-specific drawdown requests, and report project progress to multiple agencies. This is an operational funding management process, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run. Ref: Oracle CC&B.',
    `bank_account_id` BIGINT COMMENT 'Foreign key to bank account. Ref: Oracle CC&B.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center. Ref: Oracle CC&B.',
    `fund_id` BIGINT COMMENT 'FK to finance.fund. Ref: Oracle CC&B.',
    `employee_id` BIGINT COMMENT 'Approved by employee. Ref: Oracle CC&B.',
    `payment_created_by_employee_id` BIGINT COMMENT 'Created by employee. Ref: Oracle CC&B.',
    `reissued_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reissued_payment_run_id). Ref: Oracle CC&B.',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary payee or vendor associated with the payment run. Ref: Oracle CC&B.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run finished processing. Ref: Oracle CC&B.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run actually started processing. Ref: Oracle CC&B.',
    `approval_date` DATE COMMENT 'Approval date. Ref: Oracle CC&B.',
    `approved_by_user` STRING COMMENT 'User who approved the payment run. Ref: Oracle CC&B.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to the audit trail record for this payment run. Ref: Oracle CC&B.',
    `created_by_user` STRING COMMENT 'User who created the payment run record. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment run amounts.',
    `payment_run_description` STRING COMMENT 'Free-text description or notes about the payment run. Ref: Oracle CC&B.',
    `external_reference_code` STRING COMMENT 'External reference identifier from integrated systems (e.g., SAP batch ID). Ref: Oracle CC&B.',
    `failed_transactions_count` BIGINT COMMENT 'Number of transactions that failed during the run. Ref: Oracle CC&B.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was generated automatically by the system. Ref: Oracle CC&B.',
    `is_priority` BOOLEAN COMMENT 'Flag indicating if the payment run was marked as high priority. Ref: Oracle CC&B.',
    `number_of_transactions` BIGINT COMMENT 'Count of individual payment transactions included in the run. Ref: Oracle CC&B.',
    `payment_channel` STRING COMMENT 'Channel through which the payment run was initiated. Ref: Oracle CC&B.',
    `payment_count` STRING COMMENT 'Number of payments. Ref: Oracle CC&B.',
    `payment_method` STRING COMMENT 'Primary payment instrument used for the run. Ref: Oracle CC&B.',
    `payment_run_date` DATE COMMENT 'Payment run date. Ref: Oracle CC&B.',
    `payment_run_number` STRING COMMENT 'Payment run number. Ref: Oracle CC&B.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created. Ref: Oracle CC&B.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when the payment run record was last modified. Ref: Oracle CC&B.',
    `run_name` STRING COMMENT 'Descriptive name for the payment run. Ref: Oracle CC&B.',
    `run_number` STRING COMMENT 'Unique business identifier for the payment run assigned by the finance system. Ref: Oracle CC&B.',
    `run_timestamp` TIMESTAMP COMMENT 'Primary business event time for the payment run. Ref: Oracle CC&B.',
    `run_type` STRING COMMENT 'Classification of the payment run purpose. Ref: Oracle CC&B.',
    `scheduled_date` DATE COMMENT 'Date on which the payment run is scheduled to execute. Ref: Oracle CC&B.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run. Ref: Oracle CC&B.',
    `successful_transactions_count` BIGINT COMMENT 'Number of transactions successfully processed. Ref: Oracle CC&B.',
    `total_adjustments_amount` DECIMAL(18,2) COMMENT 'Total adjustments (fees, discounts, taxes) applied across the payment run. Ref: Oracle CC&B.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of all payments before adjustments. Ref: Oracle CC&B.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount after adjustments. Ref: Oracle CC&B.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount. Ref: Oracle CC&B.',
    `total_records_processed` BIGINT COMMENT 'Total number of records processed (including successful and failed). Ref: Oracle CC&B.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle. Ref: AWWA.',
    `previous_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (previous_allocation_cycle_id). Ref: AWWA.',
    `allocation_basis` STRING COMMENT 'Primary basis for the allocation (e.g., per‑capita, usage volume, population). Ref: AWWA.',
    `allocation_method` STRING COMMENT 'Method used to calculate allocations (e.g., fixed amount, percentage of revenue, formula‑based). Ref: AWWA.',
    `allocation_type` STRING COMMENT 'Category of the allocation cycle indicating its periodicity. Ref: AWWA.',
    `allocation_cycle_code` STRING COMMENT 'External business code used to identify the allocation cycle (e.g., FY2024Q1). Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation cycle record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the budget amount.',
    `cycle_date` DATE COMMENT 'Cycle date. Ref: AWWA.',
    `cycle_name` STRING COMMENT 'Cycle name. Ref: AWWA.',
    `cycle_period` STRING COMMENT 'Monthly, Quarterly, Annual. Ref: AWWA.',
    `cycle_status` STRING COMMENT 'Draft, Approved, Posted. Ref: AWWA.',
    `allocation_cycle_description` STRING COMMENT 'Free‑form description providing context for the allocation cycle. Ref: AWWA.',
    `effective_from` DATE COMMENT 'Date on which the allocation cycle becomes effective. Ref: AWWA.',
    `effective_until` DATE COMMENT 'Date on which the allocation cycle ends; null for open‑ended cycles. Ref: AWWA.',
    `fiscal_period` STRING COMMENT 'Fiscal period. Ref: AWWA.',
    `fiscal_year` STRING COMMENT 'Fiscal year. Ref: AWWA.',
    `allocation_cycle_name` STRING COMMENT 'Human‑readable name of the allocation cycle. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes or comments related to the allocation cycle. Ref: AWWA.',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle status of the allocation cycle. Ref: AWWA.',
    `total_allocated_amount` DECIMAL(18,2) COMMENT 'Total allocated amount. Ref: AWWA.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total monetary amount allocated for the cycle. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation cycle record. Ref: AWWA.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` (
    `drawdown_request_id` BIGINT COMMENT 'Primary key for drawdown_request. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the drawdown request. Ref: AWWA.',
    `drawdown_employee_id` BIGINT COMMENT 'Identifier of the party (individual or organization) requesting the drawdown. Ref: AWWA.',
    `grant_id` BIGINT COMMENT 'Foreign key to grant. Ref: AWWA.',
    `superseded_drawdown_request_id` BIGINT COMMENT 'Self-referencing FK on drawdown_request (superseded_drawdown_request_id). Ref: AWWA.',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Adjustments applied to the gross amount (e.g., fees, discounts). Ref: AWWA.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount requested before any adjustments or fees. Ref: AWWA.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount to be disbursed after adjustments. Ref: AWWA.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the drawdown request was approved. Ref: AWWA.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Approved amount. Ref: AWWA.',
    `comments` STRING COMMENT 'Free‑form comments or notes entered by the requester or approver. Ref: AWWA.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the drawdown expense will be charged. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawdown request record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the drawdown amounts.',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'Disbursed amount. Ref: AWWA.',
    `disbursement_date` DATE COMMENT 'Disbursement date. Ref: AWWA.',
    `effective_date` DATE COMMENT 'Date on which the approved drawdown becomes effective and funds may be released. Ref: AWWA.',
    `expiration_date` DATE COMMENT 'Date after which the drawdown request expires if not funded; nullable for open‑ended requests. Ref: AWWA.',
    `funding_source` STRING COMMENT 'Origin of the funds requested (e.g., bond issuance, grant, loan, internal cash). Ref: AWWA.',
    `is_urgent` BOOLEAN COMMENT 'Indicates whether the drawdown request is marked as urgent. Ref: AWWA.',
    `pms_transaction_code` STRING COMMENT 'Payment Management System transaction ID. Ref: AWWA.',
    `project_code` STRING COMMENT 'Code of the capital project or initiative funded by the drawdown. Ref: AWWA.',
    `purpose_description` STRING COMMENT 'Narrative explaining the business purpose for the requested funds. Ref: AWWA.',
    `request_amount` DECIMAL(18,2) COMMENT 'Request amount. Ref: AWWA.',
    `request_date` DATE COMMENT 'Request date. Ref: AWWA.',
    `request_number` STRING COMMENT 'Business identifier assigned to the drawdown request, used for external reference. Ref: AWWA.',
    `request_status` STRING COMMENT 'Submitted, Approved, Disbursed, Rejected. Ref: AWWA.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the drawdown request was submitted. Ref: AWWA.',
    `drawdown_request_status` STRING COMMENT 'Current lifecycle status of the drawdown request. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the drawdown request record. Ref: AWWA.',
    CONSTRAINT pk_drawdown_request PRIMARY KEY(`drawdown_request_id`)
) COMMENT 'Master reference table for drawdown_request. Referenced by drawdown_request_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` (
    `recurring_entry_template_id` BIGINT COMMENT 'Primary key for recurring_entry_template. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center. Ref: AWWA.',
    `source_recurring_entry_template_id` BIGINT COMMENT 'Self-referencing FK on recurring_entry_template (source_recurring_entry_template_id). Ref: AWWA.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount to be posted for each occurrence. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created. Ref: AWWA.',
    `credit_account_code` STRING COMMENT 'Chart‑of‑accounts code for the credit side of the entry. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the entry amount.',
    `debit_account_code` STRING COMMENT 'Chart‑of‑accounts code for the debit side of the entry. Ref: AWWA.',
    `department_code` STRING COMMENT 'Organizational department responsible for the recurring entry. Ref: AWWA.',
    `recurring_entry_template_description` STRING COMMENT 'Detailed description of the purpose and usage of the template. Ref: AWWA.',
    `effective_from` DATE COMMENT 'Date the template becomes effective for generating entries. Ref: AWWA.',
    `effective_until` DATE COMMENT 'Date the template ceases to be effective; null if open‑ended. Ref: AWWA.',
    `frequency` STRING COMMENT 'How often the recurring entry is generated. Ref: AWWA.',
    `interval_count` STRING COMMENT 'Numeric multiplier for the frequency (e.g., every 2 weeks). Ref: AWWA.',
    `is_active` BOOLEAN COMMENT 'Active flag. Ref: AWWA.',
    `is_tax_included` BOOLEAN COMMENT 'True if tax is already included in the amount; false otherwise. Ref: AWWA.',
    `journal_source` STRING COMMENT 'Depreciation, Accrual, Allocation. Ref: AWWA.',
    `last_run_date` DATE COMMENT 'Date the most recent recurring entry was posted. Ref: AWWA.',
    `next_run_date` DATE COMMENT 'Date the next recurring entry will be posted. Ref: AWWA.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the template. Ref: AWWA.',
    `posting_period` STRING COMMENT 'Financial posting period identifier (e.g., 2023‑04). Ref: AWWA.',
    `recurring_entry_template_status` STRING COMMENT 'Current lifecycle status of the template. Ref: AWWA.',
    `tax_applicable` BOOLEAN COMMENT 'Indicates whether tax is applied to the entry. Ref: AWWA.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage used when tax_applicable is true. Ref: AWWA.',
    `template_code` STRING COMMENT 'External business identifier for the recurring entry template. Ref: AWWA.',
    `template_description` STRING COMMENT 'Template description. Ref: AWWA.',
    `template_name` STRING COMMENT 'Human‑readable name of the recurring entry template. Ref: AWWA.',
    `template_type` STRING COMMENT 'Classification of the recurring entry template by business purpose. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record. Ref: AWWA.',
    CONSTRAINT pk_recurring_entry_template PRIMARY KEY(`recurring_entry_template_id`)
) COMMENT 'Master reference table for recurring_entry_template. Referenced by recurring_entry_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_parent_general_ledger_id` FOREIGN KEY (`parent_general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_parent_fund_id` FOREIGN KEY (`parent_fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_recurring_entry_template_id` FOREIGN KEY (`recurring_entry_template_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`recurring_entry_template`(`recurring_entry_template_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversed_by_journal_entry_id` FOREIGN KEY (`reversed_by_journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_reversed_line_journal_entry_line_id` FOREIGN KEY (`reversed_line_journal_entry_line_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ADD CONSTRAINT `fk_finance_grant_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_drawdown_request_id` FOREIGN KEY (`drawdown_request_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`drawdown_request`(`drawdown_request_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ADD CONSTRAINT `fk_finance_finance_rate_case_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_sweep_target_account_id` FOREIGN KEY (`sweep_target_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_from_fund_id` FOREIGN KEY (`from_fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_reversal_interfund_transfer_id` FOREIGN KEY (`reversal_interfund_transfer_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`interfund_transfer`(`interfund_transfer_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_source_cost_center_id` FOREIGN KEY (`source_cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_source_fund_id` FOREIGN KEY (`source_fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_to_fund_id` FOREIGN KEY (`to_fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_reversed_allocation_id` FOREIGN KEY (`cost_reversed_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_primary_sender_cost_center_id` FOREIGN KEY (`primary_sender_cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_source_cost_allocation_id` FOREIGN KEY (`source_cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_to_cost_center_id` FOREIGN KEY (`to_cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ADD CONSTRAINT `fk_finance_grant_funded_segment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reissued_payment_run_id` FOREIGN KEY (`reissued_payment_run_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_previous_allocation_cycle_id` FOREIGN KEY (`previous_allocation_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_superseded_drawdown_request_id` FOREIGN KEY (`superseded_drawdown_request_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`drawdown_request`(`drawdown_request_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_source_recurring_entry_template_id` FOREIGN KEY (`source_recurring_entry_template_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`recurring_entry_template`(`recurring_entry_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_gl' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_chart_of_accounts' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_gasb' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_erp' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Level');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'Account Subtype');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `gasb_category` SET TAGS ('dbx_business_glossary_term' = 'GASB Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_budget_controlled` SET TAGS ('dbx_business_glossary_term' = 'Budget Controlled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_grant_eligible` SET TAGS ('dbx_business_glossary_term' = 'Grant Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_operating_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_posting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_rate_case_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_reconciliation_required` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_summary_account` SET TAGS ('dbx_business_glossary_term' = 'Summary Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `statistical_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `tyler_munis_account_code` SET TAGS ('dbx_business_glossary_term' = 'Tyler Munis Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_fund_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_gasb' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_governmental_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `appropriation_authority` SET TAGS ('dbx_business_glossary_term' = 'Appropriation Authority');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `appropriation_date` SET TAGS ('dbx_business_glossary_term' = 'Appropriation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `balance_policy` SET TAGS ('dbx_business_glossary_term' = 'Balance Policy');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `capital_project_name` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `component_unit_flag` SET TAGS ('dbx_business_glossary_term' = 'Component Unit');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `debt_service_bond_issue` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Bond Issue');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `external_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fiscal_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fiscal_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `gasb_fund_classification` SET TAGS ('dbx_business_glossary_term' = 'GASB Fund Classification');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `general_ledger_account_prefix` SET TAGS ('dbx_business_glossary_term' = 'GL Account Prefix');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `grant_award_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Award Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `grant_program_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `interfund_transfer_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Interfund Transfer Allowed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `manager_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `minimum_fund_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fund Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `minimum_fund_balance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fund Balance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `rate_case_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Inclusion');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `reporting_entity` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `restricted_purpose` SET TAGS ('dbx_business_glossary_term' = 'Restricted Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_cost_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_cost_center' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_sap' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_erp' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `budget_profile` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `capex_opex_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'CapEx OpEx Split Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_type` SET TAGS ('dbx_value_regex' = 'standard|adjusting|closing|reversing|recurring|statistical');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `originating_module` SET TAGS ('dbx_business_glossary_term' = 'Originating Module');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_by_user` SET TAGS ('dbx_business_glossary_term' = 'Posted By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Line Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `allocation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Allocation Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `manual_entry_indicator` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CAPEX)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|eft');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance|blocked|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `primary_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `primary_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Payment');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|check|wire_transfer|electronic_funds_transfer|credit_card|procurement_card');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|issued|cleared|voided|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'vendor_payment|refund|advance|reimbursement|petty_cash');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `pretreatment_iup_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days|over_120_days');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `collection_priority` SET TAGS ('dbx_business_glossary_term' = 'Collection Priority');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `collection_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `last_collection_action_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Action Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'industrial_user_permit_fee|connection_fee|developer_contribution|grant_reimbursement|intergovernmental_charge|miscellaneous_receivable');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_duplicate_of' = 'project.project_budget');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_pair' = 'project.project_budget');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_master_for' = 'project.project_budget');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `allotment_amount` SET TAGS ('dbx_business_glossary_term' = 'Allotment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `appropriation_amount` SET TAGS ('dbx_business_glossary_term' = 'Appropriation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `authority_source` SET TAGS ('dbx_business_glossary_term' = 'Budget Authority Source');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'personnel|materials|services|utilities|debt_service|transfers');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^BUD-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `debt_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `expended_amount` SET TAGS ('dbx_business_glossary_term' = 'Expended Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `grant_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `officer_email` SET TAGS ('dbx_business_glossary_term' = 'Budget Officer Email');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `officer_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `officer_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Officer Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `rate_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|amended|revised|final');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Manager Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `primary_budget_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Manager Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `primary_budget_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `primary_budget_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `amended_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Amended Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|approved|amended|frozen|closed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `debt_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `grant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `rate_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_capacity` SET TAGS ('dbx_business_glossary_term' = 'Asset Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|retired|disposed|transferred');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|very_poor');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs|none');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|donated|traded|transferred|abandoned');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `gasb_capital_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Capital Asset Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_condition_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Condition Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `sap_asset_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Grant Administrator Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Administrator Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_phone` SET TAGS ('dbx_business_glossary_term' = 'Grant Administrator Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `administrator_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Categories');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `compliance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Compliance Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `drawdown_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Schedule Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Award Identification Number (FAIN)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `first_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `forgiveness_conditions` SET TAGS ('dbx_business_glossary_term' = 'Forgiveness Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'pending|awarded|active|suspended|closed|terminated');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'grant|loan|forgivable_loan|cooperative_agreement|reimbursement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grantor_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Grantor Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grantor_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grantor_agency_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `matching_amount_required` SET TAGS ('dbx_business_glossary_term' = 'Matching Amount Required');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `matching_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Matching Requirement Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `pass_through_entity_identifying_number` SET TAGS ('dbx_business_glossary_term' = 'Pass-Through Entity Identifying Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `pass_through_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Pass-Through Entity Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `pass_through_entity_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `program_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `repayment_term_months` SET TAGS ('dbx_business_glossary_term' = 'Repayment Term (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|as_required');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `total_amount_drawn` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Drawn');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `grant_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `drawdown_request_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Request ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `audit_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `audit_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `grant_expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `eligibility_classification` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Classification');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `eligibility_classification` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|partially_eligible|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Eligible Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `expenditure_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Award Identification Number (FAIN)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `ineligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Ineligible Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `match_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `match_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Match Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_cites' = 'ISO');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_system_of_record' = 'OSIsoft_PI_Historian');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Debt Amortization Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'level_principal|level_debt_service|bullet|serial|term');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `bond_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Bond Counsel Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `bond_rating` SET TAGS ('dbx_business_glossary_term' = 'Bond Credit Rating');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `cafr_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Annual Financial Report (CAFR) Reporting Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `cafr_reporting_category` SET TAGS ('dbx_value_regex' = 'governmental_activities|business_type_activities|component_unit');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `call_premium_percentage` SET TAGS ('dbx_business_glossary_term' = 'Call Premium Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Debt Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_business_glossary_term' = 'Coupon Payment Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|at_maturity');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `covenant_description` SET TAGS ('dbx_business_glossary_term' = 'Debt Covenant Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `cusip_number` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `cusip_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[0-9A-Z]{6}[0-9]$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `debt_service_reserve_requirement` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Reserve Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `gasb_classification` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Classification');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `gasb_classification` SET TAGS ('dbx_value_regex' = 'long_term_debt|short_term_debt|current_portion|non_current_portion');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_value_regex' = 'active|matured|defeased|refunded|defaulted|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'revenue_bond|general_obligation_bond|srf_loan|wifia_loan|commercial_paper|bank_loan');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Bond Insurance Provider');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = '30_360|actual_360|actual_365|actual_actual');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `isin_number` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `isin_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9A-Z]{9}[0-9]$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `liquidity_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Provider Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Debt Maturity Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `original_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Principal Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `outstanding_principal_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `paying_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Paying Agent Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Financed Project Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `rate_case_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Inclusion Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `rate_reset_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Reset Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `rate_reset_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `remarketing_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Remarketing Agent Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `security_type` SET TAGS ('dbx_business_glossary_term' = 'Debt Security Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `security_type` SET TAGS ('dbx_value_regex' = 'revenue_pledge|general_obligation|special_assessment|moral_obligation|unsecured');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax-Exempt Status Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Bond Trustee Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `variable_rate_index` SET TAGS ('dbx_business_glossary_term' = 'Variable Rate Index');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `debt_service_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `covenant_compliance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `days_late` SET TAGS ('dbx_business_glossary_term' = 'Days Late');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `debt_service_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Fees Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `late_payment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `late_payment_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|electronic_funds_transfer');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|processed|confirmed|failed|reversed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'scheduled|prepayment|defeasance|refunding|penalty');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `premium_discount_amortization` SET TAGS ('dbx_business_glossary_term' = 'Premium or Discount Amortization');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `reserve_fund_draw_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Fund Draw Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `reserve_fund_draw_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reserve Fund Draw Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `trustee_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Trustee Confirmation Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `tyler_munis_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Tyler Munis Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_pair' = 'service.service_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_duplicate_of' = 'service.service_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_ssot_master_for' = 'service.service_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `canonical_service_rate_case_id` SET TAGS ('dbx_ssot_canonical_ref' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `canonical_service_rate_case_id` SET TAGS ('dbx_resolution' = 'CREATE_VIEW');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `service_rate_case_id` SET TAGS ('dbx_business_role' = 'related_service_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `allowed_rate_of_return` SET TAGS ('dbx_business_glossary_term' = 'Allowed Rate of Return (ROR)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `allowed_return_on_equity` SET TAGS ('dbx_business_glossary_term' = 'Allowed Return on Equity (ROE)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `approved_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Approved Revenue Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `capital_improvement_program_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'general_rate_case|interim_rate_adjustment|surcharge|cost_of_service|rate_design|emergency_rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `commercial_rate_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commercial Rate Impact Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `consultant` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Consultant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `customer_class_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Class Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `customer_class_allocation_method` SET TAGS ('dbx_value_regex' = 'base_extra_capacity|commodity_demand|customer_count|meter_equivalent|peak_demand');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `debt_service_amount` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Decision Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `decision_document_url` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `depreciation_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Expense Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `docket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `gasb_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Compliance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Public Hearing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `industrial_rate_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Industrial Rate Impact Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `intervenor_count` SET TAGS ('dbx_business_glossary_term' = 'Intervenor Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `lead_attorney` SET TAGS ('dbx_business_glossary_term' = 'Lead Attorney');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `next_rate_case_anticipated_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rate Case Anticipated Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `operating_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expense (OPEX) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Base Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `rate_design_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rate Design Methodology');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `rate_design_methodology` SET TAGS ('dbx_value_regex' = 'cost_of_service|value_of_service|marginal_cost|tiered_conservation|uniform_rate|lifeline');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `regulatory_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Lag Days');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `requested_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Requested Revenue Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `residential_rate_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Residential Rate Impact Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `revenue_increase_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Increase Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `revenue_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Increase Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `settlement_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'service.service_rate_case');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `test_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Year End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `test_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Year Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `test_year_type` SET TAGS ('dbx_business_glossary_term' = 'Test Year Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `test_year_type` SET TAGS ('dbx_value_regex' = 'historical|forecasted|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `revenue_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `authorized_rate_of_return_percentage` SET TAGS ('dbx_business_glossary_term' = 'Authorized Rate of Return Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'cost_of_service|rate_base_rate_of_return|cash_needs|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|superseded');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `capital_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'base_extra_capacity|commodity_demand|customer_count|meter_equivalent|consumption_ratio');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `current_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|wholesale|fire_protection');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `debt_service_amount` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `depreciation_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Expense Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `grant_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Funding Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `om_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Operations and Maintenance (O&M) Expense Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `operating_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `rate_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Base Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `return_on_rate_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Return on Rate Base Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `revenue_sufficiency_gap_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sufficiency Gap Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `tax_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Expense Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `test_year` SET TAGS ('dbx_business_glossary_term' = 'Test Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `total_revenue_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Requirement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `budget_line_item` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_description` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_date` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_number` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_value_regex' = 'open|partially_liquidated|fully_liquidated|closed|cancelled|reversed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_type` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_type` SET TAGS ('dbx_value_regex' = 'pre-encumbrance|encumbrance|reservation|commitment');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_value_regex' = 'capital|operating|debt_service|grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'governmental|proprietary|fiduciary');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `originating_document_date` SET TAGS ('dbx_business_glossary_term' = 'Originating Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `originating_document_number` SET TAGS ('dbx_business_glossary_term' = 'Originating Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `originating_document_type` SET TAGS ('dbx_business_glossary_term' = 'Originating Document Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `originating_document_type` SET TAGS ('dbx_value_regex' = 'purchase_order|contract|blanket_order|requisition|work_order|service_agreement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Encumbrance Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `year_end_carryforward_flag` SET TAGS ('dbx_business_glossary_term' = 'Year-End Carryforward Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `sweep_target_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sweep Target Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|frozen|pending_closure');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|debt_service_reserve|construction_fund|investment|escrow');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `authorized_signatory_count` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `collateralization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateralization Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `daily_balance_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Balance Limit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `dual_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `dual_signature_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `fdic_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insured Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'general|enterprise|debt_service|capital_projects|special_revenue|trust');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `investment_policy_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|not_started');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `sap_house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'SAP House Bank Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `sweep_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Sweep Arrangement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `sweep_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Sweep Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `trustee_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Trustee Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `tyler_munis_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Tyler Munis Bank Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciled_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciled_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reviewed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reviewed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reviewed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `tertiary_bank_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `tertiary_bank_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `tertiary_bank_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Bank Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_gl_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted General Ledger (GL) Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `audit_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `audit_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Charges Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_credits_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Credits Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_statement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|AUD');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `deposits_in_transit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposits In Transit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_posting_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `nsf_checks_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Checks Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `other_reconciling_items_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Reconciling Items Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_checks_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Checks Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_items_count` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Items Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `prepared_date` SET TAGS ('dbx_business_glossary_term' = 'Prepared Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciled_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'manual|automated|semi_automated');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `tyler_munis_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Tyler Munis Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for interfund_transfer');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Cost Center Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_authorized_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_authorized_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_authorized_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_posted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_posted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_prepared_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_prepared_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_prepared_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `reversal_interfund_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Interfund Transfer Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `source_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Center Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `source_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `gasb_compliant` SET TAGS ('dbx_business_glossary_term' = 'Gasb Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `gasb_transfer_type` SET TAGS ('dbx_business_glossary_term' = 'GASB Transfer Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `transfer_description` SET TAGS ('dbx_business_glossary_term' = 'Transfer Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_reversed_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Allocation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_reversed_allocation_id` SET TAGS ('dbx_self_ref_role' = 'reversal');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `primary_sender_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sender Cost Center Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `primary_sender_cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `source_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Allocation Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `source_cost_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_responsible_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_responsible_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_responsible_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Basis');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_driver_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_formula` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Formula');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Priority');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|approved|posted|reversed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'assessment|distribution|periodic|statistical|activity_based|direct');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_weight` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Weight');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `capital_expenditure_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `capital_operating_split_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Operating (CAPEX/OPEX) Split Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `capital_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `gasb_category` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `gasb_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `next_scheduled_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Execution Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `operating_percentage` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_period` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `rate_case_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `reciprocal_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reciprocal Allocation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `responsible_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `source_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `statistical_key_figure_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Key Figure Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `statistical_key_figure_value` SET TAGS ('dbx_business_glossary_term' = 'Statistical Key Figure Value');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_association_edges' = 'finance.grant,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `project_funding_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Allocation - Cip Project Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Allocation - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocation_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Closeout Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `amount_drawn_to_date` SET TAGS ('dbx_business_glossary_term' = 'Amount Drawn To Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `drawdown_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `eligible_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Categories');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `last_drawdown_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drawdown Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `remaining_allocation_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Allocation Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_association_edges' = 'wastewater.lift_station,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `grant_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `lift_station_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation - Lift Station Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `construction_cost` SET TAGS ('dbx_business_glossary_term' = 'Construction Cost');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `eligible_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `grant_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grant Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `ineligible_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Ineligible Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `project_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Project Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `project_milestone` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_association_edges' = 'wastewater.sewer_network,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `grant_funded_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Segment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Segment - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Segment - Sewer Network Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `eligible_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure to Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `grant_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grant Funding Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `match_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Requirement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Funding Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `segment_rehabilitation_cost` SET TAGS ('dbx_business_glossary_term' = 'Segment Rehabilitation Cost');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `work_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Work Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `work_start_date` SET TAGS ('dbx_business_glossary_term' = 'Work Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'treasury_transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `fund_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `reissued_payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reissued Payment Run Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `reissued_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `failed_transactions_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Transactions Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `is_priority` SET TAGS ('dbx_business_glossary_term' = 'Is Priority');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `number_of_transactions` SET TAGS ('dbx_business_glossary_term' = 'Number Of Transactions');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Run Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `successful_transactions_count` SET TAGS ('dbx_business_glossary_term' = 'Successful Transactions Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `total_adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `total_records_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Records Processed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `previous_allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Allocation Cycle Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `previous_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_subdomain' = 'debt_grants');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_request_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Request Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `superseded_drawdown_request_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Drawdown Request Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `superseded_drawdown_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Amount Adjustment');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Amount Gross');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `amount_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Amount Net');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `amount_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Is Urgent');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Purpose Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `source_recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Source Recurring Entry Template Id');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `source_recurring_entry_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `credit_account_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `debit_account_code` SET TAGS ('dbx_business_glossary_term' = 'Debit Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `interval_count` SET TAGS ('dbx_business_glossary_term' = 'Interval Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Included');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `last_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `next_run_date` SET TAGS ('dbx_business_glossary_term' = 'Next Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
