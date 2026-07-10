-- Schema for Domain: finance | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`finance` COMMENT 'Corporate finance and cost management domain governing general ledger, cost centers, profit centers, accounts payable, CapEx/OpEx tracking, EBITDA reporting, budgeting, financial planning and analysis, and financial consolidation via SAP FI/CO. Serves as SSOT for all internal financial structures and management accounting aligned with IFRS/GAAP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'System-generated unique identifier for the cost center.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual costs incurred by the cost center.',
    `allocation_basis` STRING COMMENT 'Method used to allocate costs from this center to other entities.. Valid values are `direct|percentage|activity_based`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the cost center for the fiscal period.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Business key used to identify the cost center in financial transactions.',
    `controlling_area_code` STRING COMMENT 'Code of the controlling area to which the cost center belongs.',
    `cost_center_group` DECIMAL(18,2) COMMENT 'Logical grouping of cost centers for reporting or allocation purposes.',
    `cost_center_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the cost center.',
    `cost_center_type` DECIMAL(18,2) COMMENT 'Classification of the cost center by functional area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was first created.',
    `currency_code` STRING COMMENT 'Currency in which the cost centers financials are recorded.. Valid values are `^[A-Z]{3}$`',
    `cost_center_description` DECIMAL(18,2) COMMENT 'Detailed description of the cost centers purpose and scope.',
    `external_reference` STRING COMMENT 'Identifier used to map the cost center to external systems or legacy codes.',
    `hierarchy_level` STRING COMMENT 'Depth of the cost center within the organizational hierarchy.',
    `hierarchy_path` STRING COMMENT 'Slash‑delimited path representing the cost centers position in the hierarchy (e.g., "/100/200/300").',
    `is_overhead` BOOLEAN COMMENT 'Indicates whether the cost center is used for overhead cost allocation.',
    `location_code` STRING COMMENT 'Code of the physical location or plant associated with the cost center.',
    `cost_center_name` DECIMAL(18,2) COMMENT 'Human‑readable name of the cost center.',
    `owner_department` STRING COMMENT 'Organizational department that owns the cost center.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual costs.',
    `valid_from` DATE COMMENT 'Date when the cost center becomes effective.',
    `valid_to` DATE COMMENT 'Date when the cost center is retired or becomes inactive.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for all SAP CO cost centers representing organizational units responsible for incurring costs. Captures cost center hierarchy, responsible manager, controlling area assignment, profit center assignment, currency, validity period, cost center category (production, administration, R&D, sales), and standard hierarchy position. Serves as the SSOT for internal cost allocation, overhead absorption, and management accounting structures. The primary controlling object for budget assignment, actual cost collection, and variance analysis in manufacturing operations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'System-generated unique identifier for the profit center.',
    `cost_center_id` BIGINT COMMENT 'Link to the primary cost center that supplies cost data for this profit center.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the immediate parent profit center in the hierarchy, if any.',
    `actual_profit` DECIMAL(18,2) COMMENT 'Realized profit for the profit center in the reporting period.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the profit center for the fiscal period.',
    `profit_center_code` STRING COMMENT 'Business identifier code assigned to the profit center, often used in financial postings.. Valid values are `^[A-Z0-9]{3,10}$`',
    `controlling_area` STRING COMMENT 'Code of the controlling area to which the profit center belongs for internal cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code in which the profit center records its functional amounts.. Valid values are `^[A-Z]{3}$`',
    `profit_center_description` STRING COMMENT 'Free‑text description providing context about the profit centers purpose and scope.',
    `financial_reporting_line` STRING COMMENT 'Line of financial reporting hierarchy (e.g., segment, division, business unit) used for IFRS segment reporting.. Valid values are `segment|division|business_unit`',
    `hierarchy_level` STRING COMMENT 'Numeric level indicating the profit centers depth in the organizational hierarchy.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the profit center is included in statutory and management reporting.',
    `last_review_date` DATE COMMENT 'Date of the most recent strategic review of the profit center.',
    `legal_entity_code` STRING COMMENT 'Code of the legal entity that owns the profit center, aligning with statutory reporting.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center used in reports and dashboards.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage assigned to the profit center for performance benchmarking.',
    `owner` STRING COMMENT 'Business unit or individual accountable for the profit centers performance.',
    `planned_profit` DECIMAL(18,2) COMMENT 'Profit amount planned for the profit center at the start of the reporting period.',
    `profit_center_group` STRING COMMENT 'Logical grouping name used for consolidated reporting across multiple profit centers.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification indicating whether the profit center is internal, external, or a joint‑venture entity.. Valid values are `internal|external|joint_venture`',
    `region` STRING COMMENT 'Geographic region where the profit center primarily operates.. Valid values are `NA|EMEA|APAC`',
    `reporting_currency_code` STRING COMMENT 'Currency code used for external financial reporting of the profit center.. Valid values are `^[A-Z]{3}$`',
    `segment` STRING COMMENT 'High‑level business segment classification for the profit center.. Valid values are `Manufacturing|Services|R&D|Support`',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the profit center.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the profit center record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the profit center record.',
    `valid_from` DATE COMMENT 'Date on which the profit center becomes effective for reporting.',
    `valid_to` DATE COMMENT 'Date on which the profit center ceases to be effective; null if still active.',
    `created_by` STRING COMMENT 'User identifier of the person who created the profit center record.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for profit centers representing autonomous business segments within the manufacturing enterprise used for internal profitability reporting. Captures profit center hierarchy, controlling area, responsible manager, segment classification, currency, and validity dates. Enables P&L reporting at sub-entity level per SAP EC-PCA (Profit Center Accounting) aligned with IFRS segment reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'System-generated unique identifier for the GL account record.',
    `chart_of_accounts_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: GL account may be assigned to a cost center for reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: GL account may be assigned to a profit center for reporting.',
    `account_category` STRING COMMENT 'Business‑level categorisation used for reporting and analysis.. Valid values are `operating|non_operating|tax|intercompany|regulatory`',
    `account_group` STRING COMMENT 'Higher‑level grouping code that aggregates multiple GL accounts for reporting.',
    `account_long_description` STRING COMMENT 'Extended description providing additional context for reporting and audit.',
    `account_name` STRING COMMENT 'Human‑readable name describing the purpose of the GL account.',
    `account_number` STRING COMMENT 'External business identifier for the GL account, used in postings and reporting.',
    `account_type` STRING COMMENT 'Classification of the account by financial statement section.. Valid values are `balance_sheet|profit_and_loss|equity|asset|liability`',
    `balance_amount` DECIMAL(18,2) COMMENT '',
    `balance_type` DECIMAL(18,2) COMMENT 'Indicates whether the account is a natural debit or credit account.',
    `blocked_flag` BOOLEAN COMMENT '',
    `consolidation_group` STRING COMMENT 'Identifier of the consolidation group for legal entity roll‑up.',
    `cost_element_category` DECIMAL(18,2) COMMENT 'Indicates whether the account is linked to a primary or secondary cost element for CO integration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency in which the account is denominated.',
    `current_balance` DECIMAL(18,2) COMMENT 'Running balance reflecting all posted transactions to date.',
    `gl_account_description` STRING COMMENT 'Long textual description of the account purpose and usage.',
    `external_system_code` STRING COMMENT 'Identifier of the source ERP or external system that created the account.',
    `functional_area` STRING COMMENT 'Organisational functional area to which the account belongs (e.g., Manufacturing, R&D, Sales).',
    `gl_account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|inactive|blocked|pending|closed`',
    `is_bank_account` BOOLEAN COMMENT 'True if the account is linked to a bank account for cash management.',
    `is_budget_enabled` BOOLEAN COMMENT 'True if the account participates in budgeting processes.',
    `is_cash_account` BOOLEAN COMMENT 'True if the account represents cash or cash equivalents.',
    `is_deprecated` BOOLEAN COMMENT 'True if the account is scheduled for retirement and should no longer be used for new postings.',
    `is_expense_account` BOOLEAN COMMENT 'True if the account is used for operating expense postings.',
    `is_fixed_asset_account` BOOLEAN COMMENT 'True if the account is used for fixed‑asset accounting.',
    `is_forecast_enabled` BOOLEAN COMMENT 'True if the account is included in financial forecasting.',
    `is_income_account` BOOLEAN COMMENT 'True if the account records income other than sales.',
    `is_intercompany` BOOLEAN COMMENT 'True if the account is used for intercompany transactions.',
    `is_inventory_account` BOOLEAN COMMENT 'True if the account tracks inventory valuation.',
    `is_purchase_account` BOOLEAN COMMENT 'True if the account records purchase expenses.',
    `is_reconciliation_account` BOOLEAN COMMENT 'True if the account is used for automatic reconciliation of sub‑ledger postings.',
    `is_sales_account` BOOLEAN COMMENT 'True if the account records sales revenue.',
    `is_tax_relevant` BOOLEAN COMMENT 'True if the account is subject to tax reporting requirements.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal year.',
    `reporting_currency` STRING COMMENT 'Currency used for consolidated financial reporting.',
    `segment` STRING COMMENT 'Business segment code (e.g., Industrial, Energy, Services) for segment reporting.',
    `tax_code` STRING COMMENT 'Tax classification applied to postings against this account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the GL account record.',
    `valid_from` DATE COMMENT 'Date from which the account becomes effective for posting.',
    `valid_to` DATE COMMENT 'Date after which the account is no longer valid for posting (nullable).',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger account master record serving as the SSOT for the chart of accounts used across all financial postings. Captures account number, account type (balance sheet, P&L), account group, reconciliation account flag, currency, tax category, field status group, cost element category (primary/secondary for CO integration), functional area, and IFRS/GAAP classification. Bridges financial accounting and management accounting by carrying cost element attributes that enable controlling postings. Governs all financial postings and is the backbone of the enterprise chart of accounts.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Surrogate key for company code record.',
    `business_partner_id` BIGINT COMMENT 'Reference to the Business Partner master record representing the legal entity.',
    `chart_of_accounts_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Company code is associated with a cost center for controlling.',
    `active_flag` BOOLEAN COMMENT '',
    `address_line` STRING COMMENT '',
    `annual_revenue_local_currency` DECIMAL(18,2) COMMENT 'Annual revenue reported in the entitys local currency.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to audit trail records for changes to this company code.',
    `chart_of_accounts` STRING COMMENT 'Chart of accounts key linked to the company code.',
    `company_code` STRING COMMENT 'Alphanumeric identifier for the legal entity as defined in SAP.',
    `company_code_status` STRING COMMENT 'Current lifecycle status of the company code.. Valid values are `active|inactive|pending|closed`',
    `company_name` STRING COMMENT '',
    `consolidation_group` STRING COMMENT 'Group identifier for financial consolidation.',
    `consolidation_method` STRING COMMENT 'Method used for consolidation (e.g., full, proportional).',
    `controlling_area` STRING COMMENT 'Controlling area assigned for cost accounting.',
    `country` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the legal entity is registered.',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the company code record was created in the source system.',
    `currency` STRING COMMENT 'ISO 4217 currency code used for the legal entitys financial reporting.',
    `currency_code` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'Date when the company code ceases to be effective, if applicable.',
    `effective_start_date` DATE COMMENT 'Date from which the company code becomes effective.',
    `elimination_scope` STRING COMMENT 'Scope of intercompany eliminations for the company code.',
    `fiscal_year_variant` STRING COMMENT 'Fiscal year variant assigned to the company code for period accounting.',
    `headquarter_address_line1` STRING COMMENT 'First line of the legal entitys headquarters address.',
    `headquarter_city` STRING COMMENT 'City of the legal entitys headquarters.',
    `headquarter_postal_code` STRING COMMENT 'Postal code of the headquarters address.',
    `headquarter_state` STRING COMMENT 'State or province of the headquarters.',
    `industry_classification_code` STRING COMMENT 'Industry classification code (e.g., NAICS) for the entity.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the company code is included in group consolidation.',
    `legal_entity_type` STRING COMMENT '',
    `legal_form` STRING COMMENT 'Legal form of the entity (e.g., corporation, LLC).',
    `company_code_name` STRING COMMENT 'Full legal name of the company entity.',
    `number_of_employees` STRING COMMENT 'Total number of employees for the legal entity.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official communications with the legal entity.',
    `public_company_flag` BOOLEAN COMMENT 'Indicates if the entity is publicly listed.',
    `registration_number` DECIMAL(18,2) COMMENT 'Official registration number of the entity with the corporate registry.',
    `segment` STRING COMMENT 'Business segment classification for reporting.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates if the entity is tax-exempt.',
    `tax_id_number` STRING COMMENT 'Tax identification number (e.g., VAT, EIN) for the legal entity.',
    `tax_registration_number` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the company code record.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master record for SAP FI company codes representing legally independent entities within the manufacturing group. Captures company code identifier, company name, country, currency, fiscal year variant, chart of accounts assignment, controlling area assignment, consolidation group, consolidation method, and elimination scope. Serves as the organizational anchor for all financial postings, statutory reporting under IFRS/GAAP, and the consolidation unit for group financial statement preparation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry record.',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry references a cost center; replace code with FK.',
    `gl_account_id` BIGINT COMMENT '',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Journal entry can be linked to an internal order for cost tracking.',
    `ledger_id` BIGINT COMMENT 'Identifier of the ledger (e.g., primary, secondary) where the entry is posted.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit requirement to trace each journal entry to the employee who posted it.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry references a profit center; replace code with FK.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit log entry for compliance tracking.',
    `batch_reference` STRING COMMENT 'Identifier of the processing batch for mass postings.',
    `business_area` STRING COMMENT 'Higher‑level business area used in financial reporting.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction currency.',
    `debit_amount` DECIMAL(18,2) COMMENT '',
    `document_date` DATE COMMENT 'Date on the original source document (e.g., invoice date).',
    `document_header_text` STRING COMMENT 'Header description of the journal document.',
    `document_number` STRING COMMENT 'External business identifier for the journal entry, typically the SAP document number.',
    `document_type` STRING COMMENT 'Category of the journal entry indicating its purpose (e.g., invoice, credit note).. Valid values are `invoice|credit_note|payment|adjustment|reversal|accrual`',
    `entry_date` DATE COMMENT 'Date when the journal entry was entered into the system.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert transaction currency to local company currency.',
    `exchange_rate_type` DECIMAL(18,2) COMMENT 'Indicator of the exchange rate calculation method (e.g., average, spot).',
    `fiscal_period` STRING COMMENT 'Numeric period (e.g., month) within the fiscal year for the posting.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the posting belongs.',
    `fiscal_year_variant` STRING COMMENT 'Variant of the fiscal year used for special reporting calendars.',
    `gaap_compliance_flag` BOOLEAN COMMENT 'True if the posting complies with local GAAP reporting standards.',
    `ifrs_compliance_flag` BOOLEAN COMMENT 'True if the posting complies with IFRS reporting standards.',
    `is_adjusted` BOOLEAN COMMENT 'True if the entry represents an adjustment rather than a primary posting.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Total amount of the posting converted to the company’s local currency.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount (debits minus credits) of the journal entry.',
    `posting_date` DATE COMMENT 'Date on which the journal entry was posted to the general ledger.',
    `posting_key` STRING COMMENT 'SAP posting key indicating debit or credit nature of the line.',
    `posting_period` STRING COMMENT 'Period identifier used for period‑end closing.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry.. Valid values are `posted|pending|reversed|error`',
    `posting_text` STRING COMMENT 'Free‑form text entered by the user describing the posting.',
    `posting_time` TIMESTAMP COMMENT 'Exact timestamp when the entry was posted to the ledger.',
    `reference_document` STRING COMMENT 'External document number referenced by this journal entry (e.g., purchase order).',
    `reversal_document_number` STRING COMMENT 'Document number of the original entry that this entry reverses.',
    `reversal_flag` BOOLEAN COMMENT '',
    `reversal_indicator` BOOLEAN COMMENT 'True if this entry reverses a previous posting.',
    `segment` STRING COMMENT 'Segment classification for reporting (e.g., Industrial, Services).',
    `tax_amount_total` DECIMAL(18,2) COMMENT 'Aggregate tax amount calculated for the posting.',
    `tax_code` STRING COMMENT 'Tax code applicable to the posting.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of credit line amounts for the journal entry in local currency.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of debit line amounts for the journal entry in local currency.',
    `transaction_currency_amount` DECIMAL(18,2) COMMENT 'Total amount of the posting in the transaction currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the journal entry.',
    `wbs_element` STRING COMMENT 'WBS element reference for project accounting.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core transactional record capturing all general ledger postings at both document header and line item level, serving as the single source of truth for the complete financial audit trail. Header attributes include document number, document type, posting date, fiscal year, period, company code, currency, exchange rate, reference document, reversal indicator, and IFRS/GAAP compliance flags. Line item attributes include line number, GL account, debit/credit indicator, amount in transaction and local currencies, cost center, profit center, WBS element reference, internal order, tax code, assignment field, and posting text. Covers manual journal entries, automated system postings, accruals, reversals, reclassifications, and period-end closing entries. Foundation for trial balance, financial statements, reconciliation, and audit evidence.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the budget record.',
    `company_code_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Budgets are planned for specific compliance obligations; linking enables obligation‑level budget tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget is planned for a specific cost center; replace code with FK.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the budget.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget can be linked to a GL account for accounting entries.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Budget may be tied to an internal order for project cost tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget is planned for a specific profit center; replace code with FK.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project associated with the budget, if any.',
    `actual_amount` DECIMAL(18,2) COMMENT '',
    `approval_date` DATE COMMENT 'Date when the budget was approved.',
    `approval_status` STRING COMMENT 'Current approval status of the budget.. Valid values are `pending|approved|rejected`',
    `approved_flag` BOOLEAN COMMENT '',
    `budget_amount` DECIMAL(18,2) COMMENT '',
    `budget_category` DECIMAL(18,2) COMMENT 'High-level category of the budget.',
    `budget_code` DECIMAL(18,2) COMMENT 'Business identifier code for the budget, used for reference and reporting.',
    `budget_name` DECIMAL(18,2) COMMENT 'Descriptive name of the budget.',
    `budget_status` STRING COMMENT '',
    `budget_type` DECIMAL(18,2) COMMENT 'Classification of the budget version: original, revised, or supplemental.',
    `committed_amount` DECIMAL(18,2) COMMENT '',
    `cost_element` DECIMAL(18,2) COMMENT 'Cost element classification for budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget amounts.',
    `department_code` STRING COMMENT 'Code of the department owning the budget.',
    `effective_end_date` DATE COMMENT 'Date when the budget expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the budget becomes effective.',
    `finance_budget_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which the budget applies.',
    `forecast_method` STRING COMMENT 'Method used to generate forecasted amounts within the budget.. Valid values are `historical|statistical|managerial|none`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the budget is currently active.',
    `is_capex` BOOLEAN COMMENT 'Indicates if the budget pertains to capital expenditures.',
    `is_opex` BOOLEAN COMMENT 'Indicates if the budget pertains to operational expenditures.',
    `last_review_date` DATE COMMENT 'Date of the most recent budget review.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the budget.',
    `period` STRING COMMENT 'Reporting period covered by the budget (quarterly or annual).. Valid values are `Q1|Q2|Q3|Q4|Annual`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the budget record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget record.',
    `region_code` STRING COMMENT 'Geographic region code for the budget.',
    `review_cycle` STRING COMMENT 'Frequency of budget review cycles.. Valid values are `monthly|quarterly|annual`',
    `total_committed_amount` DECIMAL(18,2) COMMENT 'Aggregate amount that has been committed (e.g., purchase orders).',
    `total_planned_amount` DECIMAL(18,2) COMMENT 'Aggregate planned amount for the budget across all periods and categories.',
    `total_revised_amount` DECIMAL(18,2) COMMENT 'Aggregate revised amount after adjustments.',
    `updated_by` STRING COMMENT 'User identifier who last updated the budget record.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Acceptable variance percentage between planned and actual amounts.',
    `version_number` STRING COMMENT 'Sequential version number of the budget.',
    `version_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version was created or released.',
    `created_by` STRING COMMENT 'User identifier who created the budget record.',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Budget planning and tracking records capturing both header-level governance and period-level line item detail for all controlling objects (cost centers, profit centers, internal orders). Header captures budget version, fiscal year, budget type (original, revised, supplemental), approval workflow status, responsible manager, and total planned amounts. Line items capture controlling object assignment, GL account, cost element, fiscal period, planned amount, revised amount, committed amount, currency, and budget category (CapEx, OpEx, headcount, materials). Supports FP&A variance analysis (plan vs actual vs forecast), budget-to-actual reporting, rolling forecast integration, budget transfer workflows, and CapEx/OpEx governance across the manufacturing enterprise.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'System-generated unique identifier for the internal order record.',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is accountable for the internal order execution.',
    `profit_center_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which the internal order is linked, if applicable.',
    `actual_amount` DECIMAL(18,2) COMMENT '',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total costs posted to the internal order to date.',
    `approval_status` STRING COMMENT 'Current approval state of the internal order.. Valid values are `pending|approved|rejected`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the internal order.',
    `capex_flag` BOOLEAN COMMENT 'True if the internal order is classified as capital expenditure.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Costs that have been committed (e.g., purchase orders) but not yet posted.',
    `controlling_area` STRING COMMENT 'Controlling area that governs the internal orders cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the internal order record was first captured.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.',
    `internal_order_description` STRING COMMENT 'Free‑text description of the purpose, scope, or details of the internal order.',
    `external_reference` STRING COMMENT 'Reference to an external systems identifier (e.g., ERP, project system).',
    `final_closure_date` DATE COMMENT 'Date when the internal order was finally closed and settled.',
    `functional_area` STRING COMMENT 'Business functional area responsible for the internal order.',
    `internal_order_status` STRING COMMENT 'Current lifecycle status of the internal order.. Valid values are `created|released|technically_completed|closed`',
    `opex_flag` BOOLEAN COMMENT 'True if the internal order is classified as operating expenditure.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the internal order was initially created in the business process.',
    `order_description` STRING COMMENT '',
    `order_number` STRING COMMENT 'External business identifier assigned to the internal order, used in finance and controlling processes.',
    `order_status` STRING COMMENT '',
    `order_type` STRING COMMENT 'Classification of the internal order indicating its purpose such as maintenance, capital project, research, or service.. Valid values are `maintenance|project|investment|research|service`',
    `planned_amount` DECIMAL(18,2) COMMENT 'Forecasted costs for the internal order based on planning.',
    `release_status` STRING COMMENT 'Indicates whether the internal order has been released for posting.. Valid values are `not_released|released`',
    `responsible_cost_center` DECIMAL(18,2) COMMENT 'Cost center assigned as the primary owner for budgeting and settlement of the internal order.',
    `settlement_rule` STRING COMMENT 'Rule that defines how costs of the internal order are settled to receivers (e.g., cost centers, projects).',
    `technical_completion_date` DATE COMMENT 'Date when technical completion of the order was confirmed.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the internal order record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual costs.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between budgeted and actual costs.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element code for detailed cost tracking.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order master records used to track costs for specific manufacturing projects, capital investments, maintenance activities, or R&D initiatives. Captures order number, order type, description, responsible cost center, profit center, controlling area, settlement rule, budget, actual costs, commitment amounts, status (created, released, technically completed, closed), and CapEx/OpEx classification.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique surrogate key for each cost allocation record.',
    `allocation_cycle_id` BIGINT COMMENT 'Identifier of the allocation run or cycle to which this record belongs.',
    `allocation_rule_id` BIGINT COMMENT 'Identifier of the allocation rule applied.',
    `cost_object_id` BIGINT COMMENT 'Identifier of the cost object associated with the allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created or last modified the allocation record.',
    `gl_account_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Cost center from which the cost is allocated.',
    `internal_order_id` BIGINT COMMENT 'Internal order receiving the allocated cost, if applicable.',
    `profit_center_id` BIGINT COMMENT 'Profit center receiving the allocated cost, if applicable.',
    `cost_element_id` BIGINT COMMENT 'Cost element associated with the sender cost center.',
    `statistical_key_figure_id` BIGINT COMMENT 'Identifier of the statistical key figure used for allocation, if method is statistical.',
    `tertiary_receiver_cost_center_id` BIGINT COMMENT '',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated from sender to receiver.',
    `allocation_basis` STRING COMMENT 'Key figure or driver used as basis for variable or statistical allocation.',
    `allocation_category` STRING COMMENT 'Business category of the allocation (e.g., overhead, direct, indirect).',
    `allocation_date` DATE COMMENT 'Date on which the allocation was posted.',
    `allocation_description` STRING COMMENT 'Free-text description or notes about the allocation.',
    `allocation_method` STRING COMMENT 'Method used to calculate the allocation (fixed percentage, variable key, or statistical key figure).. Valid values are `fixed_percentage|variable_key|statistical_key`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage used when allocation method is fixed percentage.',
    `allocation_reason` STRING COMMENT 'Reason or justification for the allocation.',
    `allocation_source` STRING COMMENT 'Origin of the allocation entry.. Valid values are `system|manual|adjustment`',
    `allocation_status` STRING COMMENT '',
    `allocation_version` STRING COMMENT 'Version number of the allocation record for change tracking.',
    `cost_center_type` DECIMAL(18,2) COMMENT 'Classification of the cost center type.',
    `cost_object_type` DECIMAL(18,2) COMMENT 'Type of cost object linked to the allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the allocation amount.. Valid values are `[A-Z]{3}`',
    `effective_from` DATE COMMENT 'Start date when the allocation becomes effective.',
    `effective_until` DATE COMMENT 'End date when the allocation ceases to be effective, if applicable.',
    `fiscal_period` STRING COMMENT 'Fiscal month period (01-12) of the allocation. [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|08|09|10|11|12 — 12 candidates stripped; promote to reference product]',
    `fiscal_year` STRING COMMENT 'Fiscal year of the allocation period.',
    `internal_order_type` STRING COMMENT 'Type of internal order receiving the allocation.. Valid values are `investment|maintenance|project|service`',
    `is_manual_allocation` BOOLEAN COMMENT 'Indicates whether the allocation was entered manually (true) or generated automatically (false).',
    `line_sequence` STRING COMMENT 'Sequence number of the allocation line within the allocation cycle.',
    `period` STRING COMMENT '',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation was posted to the ledger.',
    `posting_status` STRING COMMENT 'Current posting status of the allocation line.. Valid values are `posted|pending|error|reversed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center type.. Valid values are `product|service|region|segment`',
    `reversal_indicator` BOOLEAN COMMENT 'True if this allocation line reverses a previous allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation record.',
    `variable_key_figure_reference` BIGINT COMMENT 'Identifier of the variable key figure used for allocation, if method is variable.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Transactional records capturing periodic cost allocation, distribution, and assessment cycles executed in SAP CO. Captures allocation cycle, sender cost center/cost element, receiver cost center/profit center/internal order, allocation method (fixed percentage, variable key, statistical key figure), allocation amount, fiscal period, and posting status. Supports overhead absorption, indirect cost distribution, and internal service recharging across manufacturing business units. Drives management accounting accuracy for product costing and profitability analysis.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'Unique system-generated identifier for the capital expenditure request.',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capex request is associated with a cost center for cost allocation.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Capex request may be linked to an internal order representing the project.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who last approved or rejected the request.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Capital‑expenditure requests are tied to a specific project for tracking spend against project budgets.',
    `requester_employee_id` BIGINT COMMENT 'Identifier of the employee who submitted the CapEx request.',
    `approval_date` TIMESTAMP COMMENT 'Date and time when the request was approved or rejected.',
    `approval_stage` STRING COMMENT 'Current approval tier the request is pending (e.g., manager, finance, executive).. Valid values are `initial|manager|finance|executive`',
    `approved_amount` DECIMAL(18,2) COMMENT '',
    `asset_category` STRING COMMENT 'Classification of the asset to be acquired (e.g., equipment, facility, automation system).',
    `budget_line_item` DECIMAL(18,2) COMMENT 'Specific budget line or account code to which the request will be charged.',
    `business_justification` STRING COMMENT 'Narrative explaining the strategic and financial rationale for the investment.',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the asset will be capitalized on the balance sheet.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance constraints applicable to the request.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CapEx request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated amount.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the asset.. Valid values are `straight_line|declining_balance|units_of_production`',
    `depreciation_years` STRING COMMENT 'Number of years over which the asset will be depreciated.',
    `estimated_amount` DECIMAL(18,2) COMMENT 'Projected total cost of the capital investment before approval.',
    `expected_roi_percent` DECIMAL(18,2) COMMENT 'Projected ROI expressed as a percentage of the estimated investment.',
    `funding_source` STRING COMMENT 'Origin of funds for the investment (e.g., internal budget, external financing, lease).. Valid values are `internal|external|lease`',
    `last_modified_by` BIGINT COMMENT 'Identifier of the user who performed the latest update.',
    `needed_by_date` DATE COMMENT 'Target date by which the requested asset must be available.',
    `payback_period_months` STRING COMMENT 'Estimated number of months required to recoup the investment.',
    `priority` STRING COMMENT 'Business priority assigned to the request.. Valid values are `low|medium|high|critical`',
    `project_end_date` DATE COMMENT 'Planned completion date for the capital project.',
    `project_name` STRING COMMENT 'Descriptive name of the project or investment initiative.',
    `project_start_date` DATE COMMENT 'Planned start date for the capital project.',
    `regulatory_approval_needed` BOOLEAN COMMENT 'True if external regulatory sign‑off is required before proceeding.',
    `request_date` DATE COMMENT 'Date the CapEx request was initially submitted.',
    `request_description` STRING COMMENT '',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the CapEx request.',
    `request_status` STRING COMMENT 'Current state of the CapEx request through its approval workflow.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `requested_amount` DECIMAL(18,2) COMMENT '',
    `requesting_department` STRING COMMENT 'Department that originated the CapEx request.',
    `risk_rating` STRING COMMENT 'Qualitative assessment of financial and operational risk.. Valid values are `low|medium|high`',
    `roi_percentage` DECIMAL(18,2) COMMENT '',
    `tax_implications` STRING COMMENT 'Notes on tax treatment or benefits associated with the investment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    `wbs_element` STRING COMMENT 'WBS element that groups the request within project accounting.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital expenditure request and approval records governing CapEx investment decisions for manufacturing equipment, facilities, automation systems, and infrastructure. Captures request number, project description, asset category, requesting cost center, business justification, estimated investment amount, expected ROI, payback period, approval workflow status, approver hierarchy, approval dates, and linkage to internal order or WBS element.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the accounts payable invoice record.',
    `business_partner_id` BIGINT COMMENT '',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoice belongs to a cost center; replace string code with FK for referential integrity.',
    `gl_account_id` BIGINT COMMENT '',
    `purchase_order_id` BIGINT COMMENT 'Connect procurement.ap_invoice by adding column procurement_purchase_order_id (BIGINT) with an FK to procurement.purchase_order.purchase_order_id. P15: connect_table: procurement.ap_invoice** - add column procurement_purchase_order_id (BIGINT) with',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AP invoice belongs to a profit center; replace string code with FK.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the vendor that issued the invoice.',
    `approval_status` STRING COMMENT 'Current state of the invoice approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was approved.',
    `approval_user` STRING COMMENT 'User identifier of the person who approved the invoice.',
    `bank_statement_reconciliation_status` STRING COMMENT 'Status of matching the payment against bank statement entries.. Valid values are `reconciled|unreconciled|partial`',
    `baseline_date` DATE COMMENT 'Date used as the starting point for payment terms calculation.',
    `cash_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when payment is made within discount period.',
    `clearing_document_number` STRING COMMENT 'Reference to the accounting document that clears the invoice.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the invoice amounts.',
    `currency_code` STRING COMMENT '',
    `discount_taken` DECIMAL(18,2) COMMENT 'Monetary value of any cash discount applied.',
    `document_number` STRING COMMENT 'External invoice number assigned by the vendor or the organization.',
    `due_date` DATE COMMENT 'Date by which the invoice must be paid according to payment terms.',
    `goods_receipt_number` STRING COMMENT 'Reference to the goods receipt confirming receipt of materials.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and withholdings.',
    `house_bank_account` STRING COMMENT 'Bank account from which the payment will be issued.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice.',
    `invoice_number` STRING COMMENT '',
    `invoice_type` STRING COMMENT 'Classification of the invoice (e.g., standard invoice, credit memo).. Valid values are `standard|credit_memo|debit_memo`',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount payable after taxes, discounts, and withholdings.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Amount actually paid for the invoice.',
    `payment_block_reason` DECIMAL(18,2) COMMENT 'Reason why payment processing is blocked for this invoice.',
    `payment_date` TIMESTAMP COMMENT 'Date on which the payment was actually made.',
    `payment_method` DECIMAL(18,2) COMMENT 'Instrument used to settle the invoice.',
    `payment_reference` DECIMAL(18,2) COMMENT 'Reference number provided by the bank for the payment transaction.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current status of the payment execution.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard terms defining when payment is due (e.g., Net 30, 2% 10 Net 30).',
    `payment_value_date` TIMESTAMP COMMENT 'Date on which the payment amount is considered effective.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger.',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order that triggered the invoice.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the invoice.',
    `tax_code` STRING COMMENT 'Code that determines the tax rate and calculation rules applied.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax percentage for the invoice.',
    `three_way_match_status` STRING COMMENT 'Result of PO/GR/IR verification: matched, unmatched, or partially matched.. Valid values are `matched|unmatched|partial`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted at source.',
    `withholding_tax_code` STRING COMMENT 'Code defining the withholding tax rate and rules.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable full lifecycle records capturing vendor invoices and their associated payment execution processed as a unified payables document. Invoice attributes include document number, vendor, company code, invoice date, posting date, baseline date, payment terms, gross amount, tax amount, net amount, three-way match status (PO/GR/IR verification), payment block reason, and approval workflow status. Payment attributes include payment method (ACH, wire, check, direct debit), house bank account, value date, payment amount, discount taken, cash discount percentage, clearing document reference, payment run identifier, and bank statement reconciliation status. Covers the complete payables cycle from invoice receipt through three-way matching, approval, payment proposal, payment execution, and bank clearing. Serves as the SSOT for all vendor obligations, payment commitments, and outgoing cash flows.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` (
    `ar_item_id` BIGINT COMMENT 'System-generated unique identifier for the AR line item record.',
    `business_partner_id` BIGINT COMMENT '',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR item is posted to a cost center; replace string code with FK.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer party to whom the invoice is issued.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee responsible for collections on this item.',
    `gl_account_id` BIGINT COMMENT '',
    `invoice_id` BIGINT COMMENT 'Connect billing.ar_item by adding column invoice_id (BIGINT) with an FK to billing.invoice.invoice_id. P16: connect_table: billing.ar_item** - add column invoice_id (BIGINT) with FK to billing.invoice.invoice_id',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR item is posted to a profit center; replace string code with FK.',
    `aging_bucket` STRING COMMENT 'Categorization of the outstanding amount based on days past due.. Valid values are `0-30|31-60|61-90|90+`',
    `aging_days` STRING COMMENT 'Number of days the invoice is overdue.',
    `business_area` STRING COMMENT 'Higher‑level grouping of profit centers for consolidated reporting.',
    `cleared_amount` DECIMAL(18,2) COMMENT '',
    `cleared_flag` BOOLEAN COMMENT 'Indicates whether the AR item has been fully settled.',
    `clearing_document_number` STRING COMMENT 'Document number of the payment or credit memo that cleared this AR item.',
    `clearing_status` STRING COMMENT '',
    `collection_status` STRING COMMENT 'Current status of the collection effort for the AR item.. Valid values are `pending|in_progress|resolved`',
    `company_code` STRING COMMENT 'Four‑character code identifying the legal entity within the enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AR line item record was first created in the system.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Total amount of credit memos applied to reduce the invoice balance.',
    `credit_memo_flag` BOOLEAN COMMENT 'Indicates whether a credit memo has been issued against this AR item.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total cash discount taken on the invoice.',
    `dispute_status` STRING COMMENT 'Current status of any dispute raised against the invoice.. Valid values are `none|open|resolved`',
    `document_number` STRING COMMENT 'External document number assigned by SAP FI for the AR transaction.',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `dunning_level` STRING COMMENT 'Current dunning step indicating the severity of overdue collection.. Valid values are `1|2|3|4|5`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the invoice amount to the company codes local currency.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Gross amount of the invoice in the document currency before discounts, taxes, or adjustments.',
    `invoice_description` STRING COMMENT 'Free‑text description of goods or services billed.',
    `item_number` STRING COMMENT '',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment applied to this AR item.',
    `last_payment_method` DECIMAL(18,2) COMMENT 'Payment method used for the most recent payment.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount expressed in the company codes functional currency.',
    `material_number` STRING COMMENT 'SAP material identifier for the product sold.',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after discounts and taxes, representing the amount due.',
    `open_amount` DECIMAL(18,2) COMMENT 'Remaining amount still outstanding after payments and adjustments.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original gross amount at invoice creation before any adjustments.',
    `payment_date` TIMESTAMP COMMENT 'Date on which the invoice was fully or partially paid.',
    `payment_method` DECIMAL(18,2) COMMENT 'Means by which the customer remitted payment.',
    `payment_reference` DECIMAL(18,2) COMMENT 'Reference identifier supplied by the customer for the payment transaction.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment condition (e.g., NET30, 2% 10 NET30).',
    `posting_date` DATE COMMENT 'Date the AR document was posted to the general ledger.',
    `record_status` STRING COMMENT 'Lifecycle status of the AR item indicating its processing stage.. Valid values are `open|cleared|written_off|cancelled`',
    `sales_order_number` STRING COMMENT 'Sales order that generated the invoice.',
    `segment` STRING COMMENT 'Business segment classification for reporting (e.g., Industrial, Services).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the invoice calculated using the applicable tax code.',
    `tax_code` STRING COMMENT 'Code that determines tax rate and calculation rules for the invoice.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax percentage derived from the tax code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the AR line item.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount that has been written off for this AR item.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether the remaining balance has been written off as uncollectible.',
    CONSTRAINT pk_ar_item PRIMARY KEY(`ar_item_id`)
) COMMENT 'Accounts receivable open item and cleared item records from SAP FI-AR tracking customer receivables arising from product sales and service billings. Captures AR document number, customer account, company code, posting date, due date, invoice amount, currency, payment terms, dunning level, clearing document, aging bucket, and dispute status. Serves as the SSOT for customer receivables aging and cash collection tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'System-generated unique identifier for each fixed asset record.',
    `capex_asset_record_id` BIGINT COMMENT 'Connect asset.fixed_asset by adding column capex_asset_record_id (BIGINT) with an FK to asset.capex_asset_record.capex_asset_record_id. P14: connect_table: asset.fixed_asset** - add column capex_asset_record_id (BIGINT) with FK to asset',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed asset is assigned to a cost center for depreciation tracking.',
    `equipment_register_id` BIGINT COMMENT 'Connect asset.fixed_asset by adding column equipment_register_id (BIGINT) with an FK to asset.equipment_register.equipment_register_id. P13: connect_table: asset.fixed_asset** - add column equipment_register_id (BIGINT) with FK to asset',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded to date.',
    `acquisition_amount` DECIMAL(18,2) COMMENT '',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original cost incurred to acquire the asset, recorded in functional currency.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired or placed into service.',
    `asset_class` STRING COMMENT 'High‑level classification of the asset for reporting and depreciation policy.. Valid values are `Machinery|Vehicle|Building|IT_Equipment|Tooling`',
    `asset_description` STRING COMMENT 'Detailed textual description of the asset, including purpose and key characteristics.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset.',
    `asset_number` STRING COMMENT 'External asset identifier used in accounting and operations, often the tag or barcode.',
    `asset_origin` STRING COMMENT 'Source of the asset acquisition.. Valid values are `purchased|leased|internally_built`',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the cost has been capitalized as a fixed asset.',
    `condition_rating` STRING COMMENT 'Current physical condition of the asset as assessed by maintenance.. Valid values are `excellent|good|fair|poor`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the asset record was first created in the system.',
    `currency_code` STRING COMMENT '',
    `department_responsible` STRING COMMENT 'Department that owns or manages the asset.',
    `depreciation_method` STRING COMMENT 'Method used to calculate periodic depreciation expense.. Valid values are `straight_line|declining_balance|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin for the asset.',
    `fixed_asset_status` STRING COMMENT 'Current lifecycle status of the asset.. Valid values are `active|inactive|retired|maintenance|disposed`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the policy will pay for the asset.',
    `insurance_expiry_date` DATE COMMENT 'Date when the insurance coverage ends.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering the asset.',
    `insurance_provider` STRING COMMENT 'Company that provides the insurance coverage.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `lease_contract_number` STRING COMMENT 'Reference number of the lease agreement.',
    `lease_end_date` DATE COMMENT 'Date when a leased assets contract expires.',
    `lease_provider` STRING COMMENT 'Company that provides the leased asset.',
    `maintenance_contract_number` STRING COMMENT 'Reference number of the maintenance service agreement.',
    `maintenance_provider` STRING COMMENT 'Company or internal unit responsible for scheduled maintenance.',
    `manufacturer` STRING COMMENT 'Company that produced the asset.',
    `model_number` STRING COMMENT 'Manufacturers model identifier for the asset.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Assets carrying amount after subtracting accumulated depreciation.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `plant` STRING COMMENT 'Identifier of the manufacturing plant or site where the asset is located.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Estimated cost to replace the asset with a similar new one.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer.',
    `tax_accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded for tax purposes.',
    `tax_depreciation_rate` DECIMAL(18,2) COMMENT 'Depreciation rate applied for tax reporting purposes, expressed as a percentage.',
    `tax_net_book_value` DECIMAL(18,2) COMMENT 'Assets tax book value after tax depreciation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated number of years the asset will generate economic benefits.',
    `warranty_end_date` DATE COMMENT 'Date when the asset warranty expires.',
    `warranty_provider` STRING COMMENT 'Entity that provides the warranty coverage.',
    `warranty_start_date` DATE COMMENT 'Date when the asset warranty becomes effective.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset register and complete transaction history serving as the lifecycle record for all capitalized assets of the manufacturing enterprise including production machinery, CNC equipment, robotics, automation systems, buildings, vehicles, tooling, and IT infrastructure. Master data captures asset number, asset class, description, serial number, acquisition date and value, useful life, depreciation method/key, salvage value, location/plant assignment, and cost center assignment. Transaction history captures all asset movements: acquisitions, retirements, transfers, revaluations, impairments, and periodic depreciation postings with transaction type, posting date, amount, document reference, and depreciation area (book/tax/IFRS). Provides accumulated depreciation, net book value, replacement value, and insurance value. The SSOT for asset valuation, depreciation scheduling, capital base reporting, and insurance declarations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` (
    `financial_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the financial plan record.',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial plan is built for a cost center; replace code with FK.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the plan.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Financial plan is built for a profit center; replace code with FK.',
    `approval_status` STRING COMMENT 'Current approval state of the plan.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Identifier of the employee who approved the plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan was approved.',
    `budget_category` DECIMAL(18,2) COMMENT 'Category of budget (e.g., operational, capital) associated with the plan.',
    `capex_plan_amount` DECIMAL(18,2) COMMENT 'Planned capital expenditures for the plan horizon.',
    `classification` STRING COMMENT 'High‑level classification of the plan for reporting and governance purposes.. Valid values are `budget|forecast|scenario`',
    `company_code` STRING COMMENT 'Internal code identifying the legal entity or company within the enterprise.',
    `compliance_status` STRING COMMENT 'Indicates whether the plan complies with internal and external financial regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `consolidation_level` STRING COMMENT 'Level at which the plan is consolidated (e.g., company, region, global).. Valid values are `company|region|global`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts in the plan.. Valid values are `USD|EUR|GBP|JPY|CNY|CHF`',
    `data_source_system` STRING COMMENT 'Source system from which the plan data originates (e.g., SAP FI/CO).',
    `ebitda_target_amount` DECIMAL(18,2) COMMENT 'Target earnings before interest, taxes, depreciation, and amortization for the plan.',
    `effective_from` DATE COMMENT 'Date on which the financial plan becomes effective and binding for the organization.',
    `effective_until` DATE COMMENT 'Date on which the financial plan expires; null for open‑ended plans.',
    `external_audit_flag` BOOLEAN COMMENT 'True if the plan has been subject to an external audit.',
    `financial_year_end` DATE COMMENT 'End date of the financial year for the plan.',
    `financial_year_start` DATE COMMENT 'Start date of the financial year for the plan.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the plan primarily relates.',
    `headcount_plan` STRING COMMENT 'Projected number of full‑time equivalents (FTEs) to be employed under the plan.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the plan is a consolidated view across multiple entities.',
    `last_modified_by` STRING COMMENT 'Identifier of the user who last modified the plan record.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the plan.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the plan, indicating whether it is in draft, active, suspended, closed, or archived.. Valid values are `draft|active|suspended|closed|archived`',
    `next_review_date` DATE COMMENT 'Planned date for the next formal review of the plan.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or explanations.',
    `opex_plan_amount` DECIMAL(18,2) COMMENT 'Planned operating expenditures for the plan horizon.',
    `plan_code` STRING COMMENT '',
    `plan_name` STRING COMMENT 'Descriptive name of the financial plan for easy identification by business users.',
    `plan_number` STRING COMMENT 'Business identifier assigned to the financial plan, used for external reference and tracking.. Valid values are `^FP-d{6}$`',
    `plan_owner_department` STRING COMMENT 'Department to which the plan owner belongs.',
    `plan_status` STRING COMMENT '',
    `plan_type` STRING COMMENT 'Category of the plan indicating its purpose, such as annual operating plan, rolling forecast, or long‑range plan.. Valid values are `annual_operating_plan|rolling_forecast|long_range_plan`',
    `plan_version` STRING COMMENT '',
    `plan_version_description` STRING COMMENT 'Narrative description of changes introduced in this version of the plan.',
    `planned_cost` DECIMAL(18,2) COMMENT '',
    `planned_profit` DECIMAL(18,2) COMMENT '',
    `planned_revenue` DECIMAL(18,2) COMMENT '',
    `planning_horizon_years` STRING COMMENT 'Number of years covered by the plan horizon.',
    `revenue_plan_amount` DECIMAL(18,2) COMMENT 'Planned revenue amount for the period covered by the plan.',
    `risk_rating` STRING COMMENT 'Qualitative assessment of financial risk associated with the plan.. Valid values are `low|medium|high|critical`',
    `scenario_name` STRING COMMENT 'Name of the planning scenario (e.g., best case, worst case).',
    `sensitivity_analysis_flag` BOOLEAN COMMENT 'Indicates whether sensitivity analysis has been performed for the plan.',
    `total_plan_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount of all planned financial components.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plan record.',
    `version_number` STRING COMMENT 'Sequential version number of the plan record.',
    `created_by` STRING COMMENT 'Identifier of the user who created the plan record.',
    CONSTRAINT pk_financial_plan PRIMARY KEY(`financial_plan_id`)
) COMMENT 'Financial planning and analysis (FP&A) plan records capturing multi-year financial plans, rolling forecasts, and scenario models for the manufacturing enterprise. Captures plan version, plan type (annual operating plan, rolling forecast, long-range plan), fiscal year, planning horizon, company code, profit center, revenue plan, EBITDA target, CapEx plan, OpEx plan, headcount plan, and approval status. Supports management reporting and board-level financial governance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the intercompany transaction record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory and internal controls need the approving employee linked to each intercompany transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transaction is charged to a cost center; replace code with FK.',
    `gl_account_id` BIGINT COMMENT '',
    `agreement_id` BIGINT COMMENT 'Reference to the master agreement governing the transaction.',
    `company_code_id` BIGINT COMMENT '',
    `intercompany_sender_company_code_id` BIGINT COMMENT '',
    `invoice_id` BIGINT COMMENT 'Invoice identifier that documents the intercompany billing.',
    `order_header_id` BIGINT COMMENT 'Sales or production order identifier associated with the transaction.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intercompany transaction is charged to a profit center; replace code with FK.',
    `project_header_id` BIGINT COMMENT 'Project identifier linked to the transaction, if applicable.',
    `reversal_transaction_intercompany_transaction_id` BIGINT COMMENT 'Identifier of the original transaction that this record reverses.',
    `amount_currency` DECIMAL(18,2) COMMENT 'Three‑letter ISO currency code of the transaction amounts.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before taxes, fees, and adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Amount after tax and adjustments; the amount to be settled.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax amount applicable to the transaction.',
    `approval_status` STRING COMMENT 'Approval workflow state of the transaction.. Valid values are `approved|rejected|pending`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was approved.',
    `consolidation_period` STRING COMMENT 'Fiscal period (e.g., FY2024Q1) for which the transaction is consolidated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the system.',
    `currency_code` STRING COMMENT '',
    `intercompany_transaction_description` STRING COMMENT 'Free‑text description or notes about the transaction.',
    `elimination_date` DATE COMMENT 'Date when the transaction was eliminated during consolidation.',
    `elimination_flag` BOOLEAN COMMENT 'Indicates whether the transaction should be eliminated in consolidation.',
    `elimination_status` STRING COMMENT 'Current status of the elimination process.. Valid values are `pending|completed|exempt`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign currency amounts to group reporting currency.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the transaction belongs.',
    `intercompany_contract_number` STRING COMMENT 'External contract number associated with the transaction.',
    `intercompany_transaction_status` STRING COMMENT 'Current processing state of the transaction.. Valid values are `pending|posted|reversed|cancelled|closed`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount expressed in the reporting (group) currency.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied over the base transfer price.',
    `posting_date` DATE COMMENT 'Date on which the transaction is posted to the general ledger.',
    `posting_period` STRING COMMENT 'Accounting period identifier (e.g., 2024M03) for the posting.',
    `receiving_company_code` STRING COMMENT 'Code of the legal entity receiving the intercompany amount.',
    `reconciliation_status` STRING COMMENT '',
    `reference_document_number` STRING COMMENT 'External document number (e.g., invoice, purchase order) linked to the transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'True if the transaction is a reversal of a prior transaction.',
    `sending_company_code` STRING COMMENT 'Code of the legal entity sending the intercompany amount.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount based on the tax code.',
    `tax_code` STRING COMMENT 'Tax code applied to the transaction for tax determination.',
    `transaction_amount` DECIMAL(18,2) COMMENT '',
    `transaction_date` DATE COMMENT '',
    `transaction_number` STRING COMMENT 'External business identifier assigned to the intercompany transaction.',
    `transaction_subtype` STRING COMMENT 'Additional categorisation of the transaction type when needed.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction occurred in the business process.',
    `transaction_type` STRING COMMENT 'Classification of the transaction (e.g., goods transfer, service recharge).. Valid values are `goods_transfer|service_recharge|management_fee|loan|dividend|royalty`',
    `transfer_price` DECIMAL(18,2) COMMENT 'Unit price applied for the intercompany transfer.',
    `transfer_pricing_method` STRING COMMENT 'Method used to determine the intercompany price.. Valid values are `cost_based|market_based|arm|fixed`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the transaction record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany transaction records capturing all financial postings between legal entities within the manufacturing group that require elimination during consolidated financial statement preparation. Captures sending/receiving company codes, transaction type (goods transfer, service recharge, management fee, loan, dividend, royalty), amounts, transfer pricing details, markup percentages, elimination status, and consolidation period. Supports IFRS 10 consolidation, transfer pricing documentation, and intercompany reconciliation processes.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'System-generated unique identifier for the bank account record.',
    `company_code_id` BIGINT COMMENT '',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank account is linked to a GL account for cash management.',
    `pool_header_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (pool_header_bank_account_id)',
    `account_label` STRING COMMENT 'Human‑readable name or label for the bank account used in reports and UI.',
    `account_name` STRING COMMENT '',
    `account_number` STRING COMMENT 'Primary bank account number used for payments and cash management.',
    `account_status` STRING COMMENT '',
    `account_type` STRING COMMENT 'Classification of the bank account (checking, savings, operating, cash‑pool, loan).. Valid values are `checking|savings|operating|cash_pool|loan`',
    `active_flag` BOOLEAN COMMENT '',
    `balance` DECIMAL(18,2) COMMENT 'Current monetary balance of the account as of the latest reconciliation.',
    `bank_account_status` STRING COMMENT 'Current lifecycle status of the bank account.. Valid values are `active|inactive|closed|suspended|pending`',
    `bank_address` STRING COMMENT 'Physical address of the bank branch.',
    `bank_branch` STRING COMMENT 'Specific branch of the bank where the account is held.',
    `bank_city` STRING COMMENT 'City where the bank branch is located.',
    `bank_contact_number` STRING COMMENT 'Telephone number for the bank branch.',
    `bank_country_code` STRING COMMENT 'Three‑letter country code where the bank is located.',
    `bank_name` STRING COMMENT 'Legal name of the banking institution holding the account.',
    `cash_pool_membership` STRING COMMENT 'Indicates if the account participates in a cash‑pool (primary, secondary, or none).. Valid values are `primary|secondary|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the account (e.g., USD, EUR).',
    `current_balance` DECIMAL(18,2) COMMENT '',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate amount that can be processed in a single day.',
    `effective_from` DATE COMMENT 'Date when the bank account becomes active for posting.',
    `effective_to` DATE COMMENT 'Date when the bank account is no longer active (nullable for open‑ended).',
    `iban` STRING COMMENT 'Standardized international account identifier for cross‑border transactions.',
    `internal_reference` STRING COMMENT 'Free‑form field for internal notes or reference codes.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent bank statement reconciliation.',
    `payment_method_eligibility` DECIMAL(18,2) COMMENT 'Supported payment methods for this account (e.g., wire, ACH).',
    `swift_bic` STRING COMMENT 'Bank Identifier Code used for international wire transfers.',
    `swift_code` STRING COMMENT '',
    `treasury_region` STRING COMMENT 'Geographic region of the treasury unit responsible for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for all house bank accounts used by the manufacturing enterprise for payment processing, cash pooling, and liquidity management. Captures bank key, account number, IBAN, SWIFT/BIC, bank name, country, currency, GL account assignment, payment method eligibility, daily transaction limits, and cash pool membership. Serves as the SSOT for treasury operations and bank statement reconciliation in SAP FI.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` (
    `business_partner_id` BIGINT COMMENT 'Primary key for business_partner',
    `parent_business_partner_id` BIGINT COMMENT 'Self-referencing FK on business_partner (parent_business_partner_id)',
    `parent_partner_id` BIGINT COMMENT 'Identifier of the parent organization if the partner is part of a corporate hierarchy.',
    `address_line1` STRING COMMENT 'First line of the business partners primary address.',
    `address_line2` STRING COMMENT 'Second line of the business partners primary address.',
    `bank_account_number` STRING COMMENT 'Bank account number used for payments to the partner.',
    `bank_name` STRING COMMENT 'Name of the bank where the partner holds the account.',
    `city` STRING COMMENT 'City of the business partners primary address.',
    `classification_code` STRING COMMENT 'Internal code used to segment partners for reporting and risk analysis.',
    `company_code_id` BIGINT COMMENT '',
    `compliance_status` STRING COMMENT 'Current compliance status with internal and regulatory requirements.',
    `contact_person_email` STRING COMMENT 'Email address of the primary contact person.',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person for the partner.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the business partners primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the partner.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT '',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for transactions with the partner.',
    `data_classification` STRING COMMENT 'Classification level of the partner data as per corporate policy.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the partner.',
    `effective_from` DATE COMMENT 'Date when the partner relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the partner relationship ends or is scheduled to end; null if open-ended.',
    `external_reference_code` STRING COMMENT 'External system reference code for the partner.',
    `industry_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS) for the partner.',
    `is_exporter` BOOLEAN COMMENT 'True if the partner is designated as an exporter.',
    `is_importer` BOOLEAN COMMENT 'True if the partner is designated as an importer for customs purposes.',
    `last_review_date` DATE COMMENT 'Date when the partner record was last reviewed for accuracy.',
    `business_partner_name` STRING COMMENT 'Full legal name of the business partner (individual or organization).',
    `notes` STRING COMMENT 'Free-text field for additional remarks or comments about the partner.',
    `partner_name` STRING COMMENT '',
    `partner_number` STRING COMMENT '',
    `partner_status` STRING COMMENT '',
    `partner_type` STRING COMMENT 'Classification of the partner (e.g., vendor, customer, internal entity).',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment terms agreed with the partner.',
    `postal_code` STRING COMMENT 'Postal code of the business partners primary address.',
    `primary_contact_email` STRING COMMENT 'Primary email address for business partner communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the business partner.',
    `registration_number` DECIMAL(18,2) COMMENT 'Official registration number of the organization (e.g., company registration).',
    `risk_rating` STRING COMMENT 'Risk assessment rating for the partner.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the business partner.',
    `state_province` STRING COMMENT 'State or province of the business partners primary address.',
    `business_partner_status` STRING COMMENT 'Current lifecycle status of the partner record.',
    `swift_code` STRING COMMENT 'SWIFT/BIC code for international transfers to the partners bank.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the partner is tax-exempt (true) or not (false).',
    `tax_id_number` STRING COMMENT 'Government-issued tax identifier for the partner (e.g., EIN, VAT).',
    `tax_number` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner record.',
    `vat_number` STRING COMMENT 'Value Added Tax registration number, if applicable.',
    `website_url` STRING COMMENT 'Public website URL of the business partner.',
    CONSTRAINT pk_business_partner PRIMARY KEY(`business_partner_id`)
) COMMENT 'Master reference table for business_partner. Referenced by business_partner_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle',
    `allocation_rule_id` BIGINT COMMENT '',
    `company_code_id` BIGINT COMMENT '',
    `previous_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (previous_allocation_cycle_id)',
    `allocation_method` STRING COMMENT 'Method used to allocate costs within the cycle.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for amounts in the cycle.',
    `cycle_code` STRING COMMENT 'External code used to identify the allocation cycle (e.g., FY2023Q1).',
    `cycle_name` STRING COMMENT 'Human‑readable name describing the allocation cycle.',
    `cycle_status` STRING COMMENT '',
    `cycle_type` STRING COMMENT 'Classification of the cycle based on its periodicity.',
    `allocation_cycle_description` STRING COMMENT 'Detailed description of the purpose and scope of the allocation cycle.',
    `effective_from` DATE COMMENT 'Date when the allocation cycle becomes effective.',
    `effective_until` DATE COMMENT 'Date when the allocation cycle ends; null if open‑ended.',
    `fiscal_year` STRING COMMENT '',
    `frequency` STRING COMMENT 'How often the allocation cycle repeats.',
    `last_run_timestamp` TIMESTAMP COMMENT '',
    `period` STRING COMMENT '',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the allocation cycle record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation cycle record.',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle status of the allocation cycle.',
    `total_allocated_amount` DECIMAL(18,2) COMMENT '',
    `total_allocation_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount allocated in this cycle.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` (
    `cost_element_id` BIGINT COMMENT 'Primary key for cost_element',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `gl_account_id` BIGINT COMMENT '',
    `parent_cost_element_id` BIGINT COMMENT 'Identifier of the parent cost element in a hierarchical cost structure.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `active_flag` BOOLEAN COMMENT '',
    `allocation_method` STRING COMMENT 'Method used to allocate the cost element to cost objects.',
    `cost_element_category` DECIMAL(18,2) COMMENT 'Category within the group that further classifies the cost element.',
    `cost_element_code` STRING COMMENT 'Business identifier used in finance systems (e.g., SAP) to reference the cost element.',
    `confidentiality_level` STRING COMMENT 'Classification of the cost element data for internal governance.',
    `controlling_area` STRING COMMENT '',
    `cost_element_group` DECIMAL(18,2) COMMENT 'Higher‑level grouping of related cost elements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values linked to the cost element.',
    `data_source` STRING COMMENT 'Name of the source system that supplied the cost element record.',
    `default_rate` DECIMAL(18,2) COMMENT 'Default monetary rate for the cost element when used in budgeting or planning.',
    `deprecated_date` DATE COMMENT 'Date when the cost element was officially deprecated.',
    `cost_element_description` STRING COMMENT 'Detailed description of the cost element purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the cost element becomes valid for posting.',
    `effective_to` DATE COMMENT 'Date when the cost element ceases to be valid (null if open‑ended).',
    `external_reference` STRING COMMENT 'Identifier of the cost element in external financial or ERP systems.',
    `hierarchy_level` STRING COMMENT 'Depth level of the cost element within the cost hierarchy (0 = top level).',
    `is_deprecated` BOOLEAN COMMENT 'Flag indicating the cost element is deprecated and should not be used for new postings.',
    `is_fixed` BOOLEAN COMMENT 'Indicates whether the default rate is fixed (true) or variable (false).',
    `last_review_date` DATE COMMENT 'Date when the cost element definition was last reviewed.',
    `cost_element_name` STRING COMMENT 'Human‑readable name of the cost element.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the cost element.',
    `owner` DECIMAL(18,2) COMMENT 'Organizational department responsible for the cost element.',
    `owner_email` DECIMAL(18,2) COMMENT 'Contact email of the owner department.',
    `owner_phone` DECIMAL(18,2) COMMENT 'Contact phone number of the owner department.',
    `review_frequency` STRING COMMENT 'How often the cost element should be reviewed for relevance and accuracy.',
    `cost_element_status` STRING COMMENT 'Current lifecycle status of the cost element.',
    `subcategory` DECIMAL(18,2) COMMENT 'Fine‑grained subcategory for detailed reporting.',
    `cost_element_type` STRING COMMENT 'Classification of the cost element for reporting and allocation.',
    `unit_of_measure` STRING COMMENT 'Standard unit used when the cost element represents a rate (e.g., hour, kilogram).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost element record.',
    `version_number` STRING COMMENT 'Version of the cost element definition for change management.',
    `valid_from` DATE COMMENT '',
    `valid_to` DATE COMMENT '',
    CONSTRAINT pk_cost_element PRIMARY KEY(`cost_element_id`)
) COMMENT 'Master reference table for cost_element. Referenced by sender_cost_element_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` (
    `statistical_key_figure_id` BIGINT COMMENT 'Primary key for statistical_key_figure',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `derived_from_statistical_key_figure_id` BIGINT COMMENT 'Self-referencing FK on statistical_key_figure (derived_from_statistical_key_figure_id)',
    `aggregation_method` STRING COMMENT 'Statistical aggregation applied when the figure is rolled up.',
    `calculation_logic` STRING COMMENT 'Textual definition of the formula or algorithm used to derive the figure.',
    `statistical_key_figure_category` STRING COMMENT 'High‑level business domain the figure belongs to.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the figure definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the figure record was created.',
    `data_type` STRING COMMENT 'Technical data type of the figures value.',
    `effective_from` DATE COMMENT 'Date from which the figure definition is valid.',
    `effective_until` DATE COMMENT 'Date until which the figure definition is valid; null if still active.',
    `figure_code` STRING COMMENT 'Unique alphanumeric code identifying the statistical key figure.',
    `figure_description` STRING COMMENT 'Detailed description of what the figure measures and its business purpose.',
    `figure_name` STRING COMMENT 'Human‑readable name of the statistical key figure.',
    `fiscal_year` STRING COMMENT '',
    `frequency` STRING COMMENT 'Regularity with which the figure is calculated or reported.',
    `key_figure_category` STRING COMMENT '',
    `key_figure_code` STRING COMMENT '',
    `key_figure_name` STRING COMMENT '',
    `key_figure_value` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the figure.',
    `period` STRING COMMENT '',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the figure is required for regulatory reporting.',
    `related_business_process` STRING COMMENT 'Primary business process that consumes or produces this figure.',
    `statistical_key_figure_status` STRING COMMENT 'Current lifecycle status of the figure definition.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the figure (e.g., USD, kg, hours).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the figure record.',
    `version_number` STRING COMMENT 'Version of the figure definition for change‑management tracking.',
    CONSTRAINT pk_statistical_key_figure PRIMARY KEY(`statistical_key_figure_id`)
) COMMENT 'Master reference table for statistical_key_figure. Referenced by statistical_key_figure_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'Primary key for allocation_rule',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `parent_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (parent_allocation_rule_id)',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which the rule applies (if project‑level allocation).',
    `active_flag` BOOLEAN COMMENT '',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount used when the rule type is fixed‑amount.',
    `allocation_basis` STRING COMMENT '',
    `allocation_method` STRING COMMENT '',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage value used when the rule type is percentage‑based.',
    `applicability_scope` STRING COMMENT 'Scope of entities to which the rule can be applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary allocations.',
    `allocation_rule_description` STRING COMMENT 'Detailed description of the rule purpose and application.',
    `effective_from` DATE COMMENT 'Date when the allocation rule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the allocation rule expires or is superseded (null if open‑ended).',
    `last_review_date` DATE COMMENT 'Date when the rule was last reviewed for relevance and accuracy.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the rule.',
    `percentage_basis` DECIMAL(18,2) COMMENT '',
    `priority` STRING COMMENT 'Numeric priority determining rule evaluation order when multiple rules apply (lower number = higher priority).',
    `receiver_rule` STRING COMMENT '',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who performed the last review.',
    `rule_code` STRING COMMENT 'Business identifier or code used to reference the allocation rule in financial systems.',
    `rule_expression` STRING COMMENT 'Textual representation of the calculation logic (e.g., formula or script).',
    `rule_name` STRING COMMENT 'Human‑readable name of the allocation rule.',
    `rule_type` STRING COMMENT 'Category of the rule defining how allocation is calculated.',
    `sender_rule` STRING COMMENT '',
    `allocation_rule_status` STRING COMMENT 'Current lifecycle status of the allocation rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation rule record.',
    `version_number` STRING COMMENT 'Version of the rule for change management and audit.',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Master reference table for allocation_rule. Referenced by allocation_rule_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` (
    `cost_object_id` BIGINT COMMENT 'Primary key for cost_object',
    `cost_center_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department that owns or is responsible for the cost object.',
    `parent_cost_object_id` BIGINT COMMENT 'Identifier of the immediate parent cost object in the hierarchy.',
    `profit_center_id` BIGINT COMMENT '',
    `actual_cost` DECIMAL(18,2) COMMENT '',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual incurred cost recorded against the cost object.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs to this object.',
    `amortization_end_date` DATE COMMENT 'Date when amortization of the cost object ends.',
    `amortization_start_date` DATE COMMENT 'Date when amortization of the cost object begins.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to the cost object for the fiscal period.',
    `cost_object_category` STRING COMMENT 'High‑level business category for the cost object (e.g., Manufacturing, R&D, Sales).',
    `cost_object_code` DECIMAL(18,2) COMMENT 'External code or number assigned to the cost object (e.g., cost‑center code, internal order number).',
    `cost_nature` DECIMAL(18,2) COMMENT 'Indicates whether costs are capitalized, expensed, or classified as investment/operating.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost object record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts associated with the cost object.',
    `depreciation_method` STRING COMMENT 'Method used to depreciate assets linked to this cost object.',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `cost_object_description` STRING COMMENT 'Detailed textual description of the purpose and scope of the cost object.',
    `end_date` DATE COMMENT 'Date when the cost object is retired or no longer used for allocation.',
    `external_system_reference` STRING COMMENT 'Identifier of the cost object in an external ERP or legacy system.',
    `financial_year` STRING COMMENT 'Fiscal year to which the cost object is primarily associated.',
    `fiscal_period` STRING COMMENT 'Fiscal quarter or period for reporting purposes.',
    `hierarchy_path` STRING COMMENT 'Delimited path representing the full ancestry of the cost object (e.g., "/100/200/300").',
    `is_reportable` BOOLEAN COMMENT 'Flag indicating whether the cost object should be included in financial reporting.',
    `cost_object_level` DECIMAL(18,2) COMMENT 'Numeric level of the cost object within the cost hierarchy (0 = top level).',
    `manager` DECIMAL(18,2) COMMENT 'Name of the manager or person accountable for the cost object.',
    `cost_object_name` STRING COMMENT 'Human‑readable name of the cost object used in reports and analyses.',
    `owner` DECIMAL(18,2) COMMENT 'Business owner or department responsible for the cost object.',
    `planned_cost` DECIMAL(18,2) COMMENT '',
    `planned_cost_amount` DECIMAL(18,2) COMMENT 'Planned cost amount for the cost object before actuals are recorded.',
    `responsible` DECIMAL(18,2) COMMENT 'Individual or role accountable for day‑to‑day cost object management.',
    `start_date` DATE COMMENT 'Date when the cost object becomes effective for cost allocation.',
    `cost_object_status` STRING COMMENT 'Current lifecycle state of the cost object.',
    `subcategory` STRING COMMENT 'More detailed sub‑category within the main category.',
    `cost_object_type` STRING COMMENT 'Category of the cost object indicating its nature for accounting and reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost object record.',
    `useful_life_years` STRING COMMENT 'Estimated useful life of assets associated with the cost object, in years.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between planned and actual cost amounts (planned – actual).',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between planned and actual costs.',
    CONSTRAINT pk_cost_object PRIMARY KEY(`cost_object_id`)
) COMMENT 'Master reference table for cost_object. Referenced by cost_object_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Primary key for ledger',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts associated with this ledger.',
    `company_code_id` BIGINT COMMENT '',
    `source_ledger_id` BIGINT COMMENT 'Self-referencing FK on ledger (source_ledger_id)',
    `accounting_principle` STRING COMMENT '',
    `audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last audit action on the ledger.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Flag indicating whether audit trail is enabled for this ledger.',
    `audit_user` STRING COMMENT 'User who performed the last audit on the ledger.',
    `balance_amount` DECIMAL(18,2) COMMENT 'Current total balance amount recorded in the ledger.',
    `balance_currency` DECIMAL(18,2) COMMENT 'Currency of the balance amount.',
    `ledger_code` STRING COMMENT 'Unique business code identifying the ledger.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code linked to the ledger for cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for amounts recorded in the ledger.',
    `deletion_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger was logically deleted.',
    `ledger_description` STRING COMMENT 'Detailed description of the ledger purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the ledger becomes effective.',
    `effective_until` DATE COMMENT 'Date when the ledger ceases to be effective, if applicable.',
    `external_reference` STRING COMMENT 'External system reference identifier for the ledger.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the ledger belongs.',
    `fiscal_year_variant` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Indicates if the ledger is currently active for posting.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the ledger is used for consolidation across entities.',
    `is_deleted` BOOLEAN COMMENT 'Logical delete flag indicating if the ledger record is retired.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the ledger is included in financial reporting.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent reconciliation performed on the ledger.',
    `leading_ledger_flag` BOOLEAN COMMENT '',
    `ledger_type` STRING COMMENT 'Classification of the ledger based on its purpose.',
    `ledger_name` STRING COMMENT 'Human‑readable name of the ledger.',
    `period` STRING COMMENT 'Accounting period within the fiscal year.',
    `posting_rule` STRING COMMENT 'Rule that governs how transactions are posted to this ledger.',
    `profit_center_code` STRING COMMENT 'Profit center code linked to the ledger for profit reporting.',
    `reconciliation_status` STRING COMMENT 'Current status of the ledger reconciliation process.',
    `retention_policy` STRING COMMENT 'Data retention policy for ledger entries.',
    `segment` STRING COMMENT 'Business segment classification for the ledger.',
    `ledger_status` STRING COMMENT 'Current lifecycle status of the ledger.',
    `tax_reporting_flag` BOOLEAN COMMENT 'Indicates if the ledger is used for tax reporting purposes.',
    `updated_by` STRING COMMENT 'User identifier who last updated the ledger record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ledger record.',
    `version_number` STRING COMMENT 'Version number of the ledger definition for change management.',
    `created_by` STRING COMMENT 'User identifier who created the ledger record.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Master reference table for ledger. Referenced by ledger_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` (
    `cost_estimate_id` BIGINT COMMENT 'Primary key for cost_estimate',
    `company_code_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the estimate.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initially created the estimate record.',
    `cost_employee_id` BIGINT COMMENT 'Identifier of the user who approved the estimate.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project or initiative the estimate supports.',
    `reference_cost_estimate_id` BIGINT COMMENT 'Self-referencing FK on cost_estimate (reference_cost_estimate_id)',
    `approval_date` DATE COMMENT 'Date on which the estimate was approved.',
    `confidence_level` STRING COMMENT 'Confidence in the accuracy of the estimate.',
    `cost_category` DECIMAL(18,2) COMMENT 'Classification of the cost type covered by the estimate.',
    `costing_variant` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the estimate.',
    `cost_estimate_description` STRING COMMENT 'Free‑form text describing the scope and assumptions of the cost estimate.',
    `estimate_amount_gross` DECIMAL(18,2) COMMENT 'Total estimated cost before taxes, discounts, or adjustments.',
    `estimate_amount_net` DECIMAL(18,2) COMMENT 'Net estimated cost after tax and adjustments.',
    `estimate_date` DATE COMMENT 'Date on which the cost estimate was generated.',
    `estimate_name` STRING COMMENT '',
    `estimate_number` STRING COMMENT 'Human‑readable identifier assigned to the cost estimate, used in finance and project communications.',
    `estimate_status` STRING COMMENT '',
    `estimate_tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax component associated with the gross amount.',
    `estimate_type` STRING COMMENT '',
    `labor_cost` DECIMAL(18,2) COMMENT '',
    `material_cost` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT 'Additional remarks or comments captured by the estimator.',
    `overhead_cost` DECIMAL(18,2) COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or hours estimated for the cost item.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the estimate record was first captured in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the estimate record.',
    `risk_factor` STRING COMMENT 'Qualitative risk rating associated with the estimate assumptions.',
    `cost_estimate_status` STRING COMMENT 'Current lifecycle state of the cost estimate.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Aggregated cost (quantity × unit price) stored for reporting convenience.',
    `unit_of_measure` STRING COMMENT 'Measurement unit applied to the quantity field.',
    `unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of measure.',
    `valid_until` DATE COMMENT 'Date after which the estimate expires; null if open‑ended.',
    `version_number` STRING COMMENT 'Sequential version of the estimate record.',
    `valid_from` DATE COMMENT 'Date from which the estimate is considered valid.',
    CONSTRAINT pk_cost_estimate PRIMARY KEY(`cost_estimate_id`)
) COMMENT 'Master reference table for cost_estimate. Referenced by cost_estimate_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Primary key for chart_of_accounts',
    `parent_account_chart_of_accounts_id` BIGINT COMMENT 'Identifier of the immediate parent GL account for hierarchical structuring.',
    `parent_chart_of_accounts_id` BIGINT COMMENT 'Self-referencing FK on chart_of_accounts (parent_chart_of_accounts_id)',
    `account_category` STRING COMMENT 'Secondary classification providing finer granularity of the account.',
    `account_code` STRING COMMENT 'Unique alphanumeric code identifying the GL account.',
    `account_description` STRING COMMENT 'Detailed description of the account purpose and usage.',
    `account_group` STRING COMMENT 'Higher-level grouping of accounts for consolidated reporting.',
    `account_length` STRING COMMENT '',
    `account_name` STRING COMMENT 'Descriptive name of the GL account.',
    `account_type` STRING COMMENT 'Classification of the account by financial statement category.',
    `active_flag` BOOLEAN COMMENT '',
    `balance_nature` DECIMAL(18,2) COMMENT 'Indicates whether the account normally carries a debit or credit balance.',
    `coa_code` STRING COMMENT '',
    `coa_description` STRING COMMENT '',
    `coa_name` STRING COMMENT '',
    `company_code_id` STRING COMMENT 'Identifier of the legal entity that owns the account.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center associated with the account for internal cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code in which the account is denominated.',
    `effective_from` DATE COMMENT 'Date when the account becomes effective for posting.',
    `effective_to` DATE COMMENT 'Date when the account ceases to be effective; null if open-ended.',
    `financial_reporting_level` STRING COMMENT 'Level in the financial reporting hierarchy (e.g., 1‑5).',
    `group_coa_flag` BOOLEAN COMMENT '',
    `is_active` BOOLEAN COMMENT 'Indicates whether the account is currently active for posting.',
    `is_actual` BOOLEAN COMMENT 'True if the account records actual transactions.',
    `is_budgeted` BOOLEAN COMMENT 'True if the account is included in budgeting processes.',
    `is_consolidation_account` BOOLEAN COMMENT 'True if the account is used in corporate consolidation reporting.',
    `is_forecasted` BOOLEAN COMMENT 'True if the account is used in forecasting.',
    `language_code` STRING COMMENT '',
    `maintenance_language` STRING COMMENT '',
    `posting_restriction_flag` BOOLEAN COMMENT 'Indicates if posting to this account is restricted due to policy or control.',
    `profit_center_code` STRING COMMENT 'Profit center linked to the account for profitability reporting.',
    `tax_reporting_code` STRING COMMENT 'Code used for tax reporting purposes associated with the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account record.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_object_id` FOREIGN KEY (`cost_object_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_object`(`cost_object_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_statistical_key_figure_id` FOREIGN KEY (`statistical_key_figure_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`statistical_key_figure`(`statistical_key_figure_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_receiver_cost_center_id` FOREIGN KEY (`tertiary_receiver_cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ADD CONSTRAINT `fk_finance_financial_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ADD CONSTRAINT `fk_finance_financial_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ADD CONSTRAINT `fk_finance_financial_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_intercompany_sender_company_code_id` FOREIGN KEY (`intercompany_sender_company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_reversal_transaction_intercompany_transaction_id` FOREIGN KEY (`reversal_transaction_intercompany_transaction_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_pool_header_bank_account_id` FOREIGN KEY (`pool_header_bank_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ADD CONSTRAINT `fk_finance_business_partner_parent_business_partner_id` FOREIGN KEY (`parent_business_partner_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ADD CONSTRAINT `fk_finance_business_partner_parent_partner_id` FOREIGN KEY (`parent_partner_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_previous_allocation_cycle_id` FOREIGN KEY (`previous_allocation_cycle_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_parent_cost_element_id` FOREIGN KEY (`parent_cost_element_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ADD CONSTRAINT `fk_finance_statistical_key_figure_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ADD CONSTRAINT `fk_finance_statistical_key_figure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ADD CONSTRAINT `fk_finance_statistical_key_figure_derived_from_statistical_key_figure_id` FOREIGN KEY (`derived_from_statistical_key_figure_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`statistical_key_figure`(`statistical_key_figure_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_parent_allocation_rule_id` FOREIGN KEY (`parent_allocation_rule_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_parent_cost_object_id` FOREIGN KEY (`parent_cost_object_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_object`(`cost_object_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_source_ledger_id` FOREIGN KEY (`source_ledger_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ADD CONSTRAINT `fk_finance_cost_estimate_reference_cost_estimate_id` FOREIGN KEY (`reference_cost_estimate_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_account_chart_of_accounts_id` FOREIGN KEY (`parent_account_chart_of_accounts_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `vibe_manufacturing_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (AC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis (AB)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'direct|percentage|activity_based');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BA)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code (CA)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group (CCG)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status (CCS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type (CCT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description (CCD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (EXT_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HL)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path (HP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `is_overhead` SET TAGS ('dbx_business_glossary_term' = 'Is Overhead Cost Center Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Location Code (LOC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name (CCN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (OD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (VA)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (Valid From)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (Valid To)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `actual_profit` SET TAGS ('dbx_business_glossary_term' = 'Actual Profit');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `financial_reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Line');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `financial_reporting_line` SET TAGS ('dbx_value_regex' = 'segment|division|business_unit');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Target Percent');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Owner');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `planned_profit` SET TAGS ('dbx_business_glossary_term' = 'Planned Profit');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint_venture');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NA|EMEA|APAC');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Segment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'Manufacturing|Services|R&D|Support');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`profit_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID (GL_ACCOUNT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Category (GL_ACCOUNT_CATEGORY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_value_regex' = 'operating|non_operating|tax|intercompany|regulatory');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Group (GL_ACCOUNT_GROUP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_long_description` SET TAGS ('dbx_business_glossary_term' = 'Account Long Description (ACCOUNT_LONG_DESCRIPTION)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Name (GL_ACCOUNT_NAME)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Number (GL_ACCOUNT_NUMBER)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Type (GL_ACCOUNT_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|equity|asset|liability');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type (BALANCE_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group (CONSOLIDATION_GROUP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category (COST_ELEMENT_CATEGORY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURRENCY_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance (CURRENT_BALANCE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'GL Account Description (GL_ACCOUNT_DESCRIPTION)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code (EXTERNAL_SYSTEM_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area (FUNCTIONAL_AREA)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'GL Account Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending|closed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Indicator (IS_BANK_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_bank_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_budget_enabled` SET TAGS ('dbx_business_glossary_term' = 'Budget Enabled Indicator (IS_BUDGET_ENABLED)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_cash_account` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Indicator (IS_CASH_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Indicator (IS_DEPRECATED)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_expense_account` SET TAGS ('dbx_business_glossary_term' = 'Expense Account Indicator (IS_EXPENSE_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_fixed_asset_account` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Account Indicator (IS_FIXED_ASSET_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_forecast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Forecast Enabled Indicator (IS_FORECAST_ENABLED)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_income_account` SET TAGS ('dbx_business_glossary_term' = 'Income Account Indicator (IS_INCOME_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator (IS_INTERCOMPANY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_inventory_account` SET TAGS ('dbx_business_glossary_term' = 'Inventory Account Indicator (IS_INVENTORY_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_purchase_account` SET TAGS ('dbx_business_glossary_term' = 'Purchase Account Indicator (IS_PURCHASE_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator (IS_RECONCILIATION_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_sales_account` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Indicator (IS_SALES_ACCOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `is_tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevance Indicator (IS_TAX_RELEVANT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (OPENING_BALANCE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (REPORTING_CURRENCY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment (SEGMENT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date (VALID_FROM)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`gl_account` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date (VALID_TO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Surrogate ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `address_line` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `annual_revenue_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (Local Currency)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Key');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (Legal Entity Code)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `elimination_scope` SET TAGS ('dbx_business_glossary_term' = 'Elimination Scope');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarter Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarter City');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarter Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_state` SET TAGS ('dbx_business_glossary_term' = 'Headquarter State/Province');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `headquarter_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_code_name` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `company_code_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number of Employees');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `public_company_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Company Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'invoice|credit_note|payment|adjustment|reversal|accrual');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `gaap_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'GAAP Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `ifrs_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_text` SET TAGS ('dbx_business_glossary_term' = 'Posting Text');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_time` SET TAGS ('dbx_business_glossary_term' = 'Posting Time');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'planning_forecasting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Manager ID (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element (CE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'historical|statistical|managerial|none');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Is CapEx Flag (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `is_opex` SET TAGS ('dbx_business_glossary_term' = 'Is OpEx Flag (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|Annual');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Amount (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Amount (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revised Amount (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `total_revised_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `version_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Timestamp (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`finance_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (BGT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (MONETARY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (MONETARY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `capex_flag` SET TAGS ('dbx_business_glossary_term' = 'CapEx Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount (MONETARY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `final_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Final Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_completed|closed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `opex_flag` SET TAGS ('dbx_business_glossary_term' = 'OpEx Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'maintenance|project|investment|research|service');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (MONETARY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'not_released|released');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `responsible_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `technical_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (MONETARY)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`internal_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_object_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Object ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit User ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Internal Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `statistical_key_figure_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Key Figure ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_category` SET TAGS ('dbx_business_glossary_term' = 'Allocation Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'fixed_percentage|variable_key|statistical_key');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'system|manual|adjustment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Version');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `internal_order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `internal_order_type` SET TAGS ('dbx_value_regex' = 'investment|maintenance|project|service');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `is_manual_allocation` SET TAGS ('dbx_business_glossary_term' = 'Manual Allocation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|error|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'product|service|region|segment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_allocation` ALTER COLUMN `variable_key_figure_reference` SET TAGS ('dbx_business_glossary_term' = 'Variable Key Figure ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'capital_investment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Request ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Stage');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_value_regex' = 'initial|manager|finance|executive');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `budget_line_item` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Period (Years)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Investment Amount (USD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `expected_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment Percent');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|lease');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `needed_by_date` SET TAGS ('dbx_business_glossary_term' = 'Needed‑By Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Request Priority');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `project_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `project_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_needed` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Needed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `tax_implications` SET TAGS ('dbx_business_glossary_term' = 'Tax Implications');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`capex_request` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Invoice ID (AP_INVOICE_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID (VENDOR_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_user` SET TAGS ('dbx_business_glossary_term' = 'Approval User (APPROVER)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_statement_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Reconciliation Status (BANK_RECON_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_statement_reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|partial');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date (BASELINE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `cash_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Percentage (DISC_PCT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number (CL_DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken (DISC_TAKEN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Document Number (DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number (GR_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount (GROSS_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `house_bank_account` SET TAGS ('dbx_business_glossary_term' = 'House Bank Account (BANK_ACC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `house_bank_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `house_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date (INV_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type (INV_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount (PAY_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason (PAY_BLOCK_RSN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAY_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (PAY_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_value_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Value Date (PAY_VAL_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three‑Way Match Status (3WM_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount (WH_TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code (WH_TAX_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `ar_item_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUST_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent ID (COLL_AGENT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket (AGE_BUCKET)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '0-30|31-60|61-90|90+');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days (AGE_DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area (BUS_AREA)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Cleared Flag (CLRD_FLG)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number (CL_DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status (COLL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (CO_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount (CR_MEMO_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `credit_memo_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Flag (CR_MEMO_FLG)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status (DISP_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|open|resolved');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Document Number (AR_DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level (DUN_LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount (INV_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description (INV_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount (LAST_PAY_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `last_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Method (LAST_PAY_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount (LC_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MAT_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open Amount (OPEN_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount (ORIG_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAY_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (PAY_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERM)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'open|cleared|written_off|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number (SO_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment (SEGMENT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Amount (WO_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ar_item` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Flag (WO_FLG)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'capital_investment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier (FA_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation (AD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (AC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date (AD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class (AC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'Machinery|Vehicle|Building|IT_Equipment|Tooling');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description (AD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name (AN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number (AN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_origin` SET TAGS ('dbx_business_glossary_term' = 'Asset Origin (AO)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_origin` SET TAGS ('dbx_value_regex' = 'purchased|leased|internally_built');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag (CF)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating (CR)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `department_responsible` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department (RD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (DM)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (DSD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status (AS)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|maintenance|disposed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount (ICA)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date (IED)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (IPN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider (IP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LMD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Number (LCN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date (LED)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `lease_provider` SET TAGS ('dbx_business_glossary_term' = 'Lease Provider (LP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Number (MCN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_provider` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Provider (MP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer (MFR)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (MN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date (NMD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost (RC)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value (SV)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `tax_accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Tax Accumulated Depreciation (TAD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Rate (TDR)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `tax_net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Net Book Value (TNBV)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years) (UL)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date (WED)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_provider` SET TAGS ('dbx_business_glossary_term' = 'Warranty Provider (WP)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date (WSD)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` SET TAGS ('dbx_subdomain' = 'planning_forecasting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `financial_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Plan Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `capex_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Plan Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Financial Plan Classification');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'budget|forecast|scenario');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'company|region|global');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CHF');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `ebitda_target_amount` SET TAGS ('dbx_business_glossary_term' = 'EBITDA Target Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `external_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `financial_year_end` SET TAGS ('dbx_business_glossary_term' = 'Financial Year End Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `financial_year_start` SET TAGS ('dbx_business_glossary_term' = 'Financial Year Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `headcount_plan` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Plan Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Plan Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|closed|archived');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `opex_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'OPEX Plan Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Plan Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^FP-d{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Department');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Plan Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual_operating_plan|rolling_forecast|long_range_plan');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `plan_version_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `planning_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Years)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `revenue_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Plan Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `scenario_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `scenario_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `sensitivity_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `total_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Plan Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`financial_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Related Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Transaction ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Component Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `consolidation_period` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|completed|exempt');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled|closed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number (ITN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_subtype` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Subtype');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'goods_transfer|service_recharge|management_fee|loan|dividend|royalty');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_based|market_based|arm|fixed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Pool Header Bank Account Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_label` SET TAGS ('dbx_business_glossary_term' = 'Account Label');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (ACCOUNT_NUMBER)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|operating|cash_pool|loan');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Address');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `cash_pool_membership` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Membership');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `cash_pool_membership` SET TAGS ('dbx_value_regex' = 'primary|secondary|none');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `internal_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `payment_method_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Eligibility');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_business_glossary_term' = 'SWIFT BIC Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `treasury_region` SET TAGS ('dbx_business_glossary_term' = 'Treasury Region');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `parent_business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Business Partner Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `parent_business_partner_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `parent_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `bank_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `bank_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `classification_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Email');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Phone');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `is_exporter` SET TAGS ('dbx_business_glossary_term' = 'Is Exporter');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `is_importer` SET TAGS ('dbx_business_glossary_term' = 'Is Importer');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `business_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `business_partner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `business_partner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `business_partner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `short_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `short_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `business_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Swift Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Id Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `tax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'Vat Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`business_partner` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `previous_allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Allocation Cycle Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `previous_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_cycle` ALTER COLUMN `total_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allocation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `parent_cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Element Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `default_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Rate');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `deprecated_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `is_fixed` SET TAGS ('dbx_business_glossary_term' = 'Is Fixed');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Owner');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Owner Email');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Owner Phone');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `owner_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Subcategory');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `cost_element_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_element` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `statistical_key_figure_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Key Figure Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `derived_from_statistical_key_figure_id` SET TAGS ('dbx_business_glossary_term' = 'Derived From Statistical Key Figure Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `derived_from_statistical_key_figure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `calculation_logic` SET TAGS ('dbx_business_glossary_term' = 'Calculation Logic');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `statistical_key_figure_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `figure_code` SET TAGS ('dbx_business_glossary_term' = 'Figure Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `figure_description` SET TAGS ('dbx_business_glossary_term' = 'Figure Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `figure_name` SET TAGS ('dbx_business_glossary_term' = 'Figure Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `figure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `figure_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `key_figure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `related_business_process` SET TAGS ('dbx_business_glossary_term' = 'Related Business Process');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `statistical_key_figure_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`statistical_key_figure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `parent_allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Allocation Rule Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `parent_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Expression');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`allocation_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `parent_cost_object_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Object Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `amortization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization End Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_nature` SET TAGS ('dbx_business_glossary_term' = 'Cost Nature');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `financial_year` SET TAGS ('dbx_business_glossary_term' = 'Financial Year');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `manager` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Manager');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Owner');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `planned_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `responsible` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Responsible');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_object` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `source_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Source Ledger Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `source_ledger_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Balance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `balance_currency` SET TAGS ('dbx_business_glossary_term' = 'Balance Currency');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `deletion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deletion Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `posting_rule` SET TAGS ('dbx_business_glossary_term' = 'Posting Rule');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `tax_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`ledger` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` SET TAGS ('dbx_subdomain' = 'controlling_structure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `reference_cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Cost Estimate Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `reference_cost_estimate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_estimate_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `estimate_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Estimate Amount Gross');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `estimate_amount_net` SET TAGS ('dbx_business_glossary_term' = 'Estimate Amount Net');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Date');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `estimate_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Estimate Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `estimate_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimate Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `cost_estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Valid Until');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`cost_estimate` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_account_chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Chart Of Accounts Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Account Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_nature` SET TAGS ('dbx_business_glossary_term' = 'Balance Nature');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `coa_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Level');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_actual` SET TAGS ('dbx_business_glossary_term' = 'Is Actual');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidation Account');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `is_forecasted` SET TAGS ('dbx_business_glossary_term' = 'Is Forecasted');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Restriction Flag');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Code');
ALTER TABLE `vibe_manufacturing_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
