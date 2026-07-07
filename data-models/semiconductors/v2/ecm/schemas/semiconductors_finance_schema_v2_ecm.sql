-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`finance` COMMENT 'Corporate financial management including general ledger, cost center accounting, capital expenditure tracking for fab equipment, R&D capitalization, budget planning, financial consolidation, NRE cost recovery, wafer cost modeling, and fab utilization-based cost allocation. Supports SOX-compliant financial reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'System-generated unique identifier for the cost center.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record within the cost center finance entity.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs (e.g., headcount, fab utilization, revenue, custom).. Valid values are `headcount|fab_utilization|revenue|custom`',
    `audit_trail` STRING COMMENT 'Free‑form notes capturing audit trail information for the cost center.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget amount allocated to the cost center for the fiscal year.',
    `budget_year` STRING COMMENT 'Fiscal year for which the budget amount applies.',
    `cost_center_category` STRING COMMENT 'Category classification such as expense, investment, or overhead.',
    `cost_center_code` STRING COMMENT 'Business code used to reference the cost center in financial postings.',
    `controlling_area` STRING COMMENT 'Controlling area to which the cost center belongs for internal reporting.',
    `cost_center_group` STRING COMMENT 'Logical grouping of cost centers for reporting (e.g., fab group, R&D group).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center.. Valid values are `active|inactive|planned|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center (e.g., fab, R&D, corporate, support).. Valid values are `fab|r&d|corporate|support`',
    `cost_element` STRING COMMENT 'Cost element code associated with the cost center for expense categorization.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the cost center operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was created in the source system.',
    `currency` STRING COMMENT 'ISO 4217 currency code used for budgeting and reporting.',
    `department_code` STRING COMMENT 'Code of the department to which the cost center belongs.',
    `cost_center_description` STRING COMMENT 'Free‑form description providing additional context about the cost center.',
    `external_reference` STRING COMMENT 'Identifier of the cost center in external systems (e.g., legacy ERP).',
    `hierarchy_level` STRING COMMENT 'Depth level of the cost center within the organizational hierarchy.',
    `is_active` BOOLEAN COMMENT 'True if the cost center is currently active; false otherwise.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the cost center contains confidential financial information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the cost center record in the finance domain.',
    `last_review_date` DATE COMMENT 'Date when the cost center was last reviewed for relevance and accuracy.',
    `legal_entity` STRING COMMENT 'Legal entity to which the cost center belongs.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the cost center record in the finance domain.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center.',
    `natural_account` STRING COMMENT 'General ledger natural account linked to the cost center.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant associated with the cost center.',
    `profit_center_code` STRING COMMENT 'Associated profit center code for revenue attribution.',
    `region_code` STRING COMMENT 'Three‑letter region identifier (e.g., APJ, EMEA, AMER).',
    `reporting_line` STRING COMMENT 'Organizational reporting line identifier for the cost center.',
    `responsibility_center_code` STRING COMMENT 'Code of the responsibility center linked to the cost center.',
    `review_cycle` STRING COMMENT 'Frequency of cost center reviews.. Valid values are `annual|quarterly|monthly`',
    `subdepartment_code` STRING COMMENT 'Code of the sub‑department within the department.',
    `tax_code` STRING COMMENT 'Tax code applicable to the cost center for tax reporting.',
    `to_company_code` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Cost centers belong to a specific company code/controlling area. Required for organizational hierarchy and reporting boundaries.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    `validity_flag` BOOLEAN COMMENT 'True if the cost center is within its validity period; false otherwise.',
    `valid_from` DATE COMMENT 'Date when the cost center becomes effective.',
    `valid_to` DATE COMMENT 'Date when the cost center ceases to be effective (null if open‑ended).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Authoritative master record for all SAP CO cost centers used in semiconductor operations. Captures fab cost centers (FEOL, BEOL, CMP, lithography), R&D cost centers, engineering support centers, and corporate overhead pools. Includes cost center hierarchy, responsible manager, controlling area, currency, validity periods, and budget allocation type. SSOT for cost center identity used across all financial postings.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique surrogate key for the GL account record.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record within the gl account finance entity.',
    `account_category` STRING COMMENT 'Secondary classification such as operating, non‑operating, or statutory.',
    `account_code` STRING COMMENT 'Business identifier used in the chart of accounts; often alphanumeric (e.g., 4000, 5-200).',
    `account_group` STRING COMMENT 'Group identifier used for reporting aggregation (e.g., 4‑Revenue, 5‑COGS).',
    `account_level` STRING COMMENT 'Hierarchical level of the account within the chart of accounts (e.g., 1‑5).',
    `account_name` STRING COMMENT 'Human‑readable name describing the purpose of the account.',
    `account_subgroup` STRING COMMENT 'Sub‑group within an account group for finer granularity.',
    `account_type` STRING COMMENT 'Classification of the account for financial statement mapping.. Valid values are `asset|liability|equity|revenue|expense`',
    `amortization_flag` BOOLEAN COMMENT 'Indicates whether the account is subject to amortization (e.g., intangible assets).',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the end of the fiscal year.',
    `cost_center_code` STRING COMMENT 'Cost center to which the account is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the functional currency for the account.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for asset‑type accounts.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `gl_account_description` STRING COMMENT 'Extended textual description of the account purpose and usage.',
    `external_reference` STRING COMMENT 'Reference to the account in external systems (e.g., legacy ERP code).',
    `financial_statement` STRING COMMENT 'Financial statement where the account is reported.. Valid values are `balance_sheet|income_statement|cash_flow`',
    `gl_account_status` STRING COMMENT 'Current lifecycle state of the account record.. Valid values are `active|inactive|pending|closed`',
    `is_active` BOOLEAN COMMENT 'The is active of the gl account record in the finance domain.',
    `is_budget_controlled` BOOLEAN COMMENT 'Indicates whether the account is subject to budgetary controls.',
    `is_consolidation_account` BOOLEAN COMMENT 'Indicates whether the account participates in legal entity consolidation.',
    `is_reconciliation_account` BOOLEAN COMMENT 'True if the account is used for automatic reconciliation of sub‑ledger postings.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the gl account record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the gl account record in the finance domain.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal year.',
    `posting_restriction_flag` BOOLEAN COMMENT 'True if posting to the account is restricted by policy.',
    `profit_center_code` STRING COMMENT 'Profit center associated with the account for profitability analysis.',
    `reporting_currency` STRING COMMENT 'Currency used for consolidated financial reporting.. Valid values are `^[A-Z]{3}$`',
    `segment_code` STRING COMMENT 'Business segment identifier (e.g., product line, geography) used for reporting.',
    `tax_category` STRING COMMENT 'Tax treatment applicable to the account.. Valid values are `taxable|exempt|zero_rate`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the account, expressed as a decimal (e.g., 7.25).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GL account record.',
    `valid_from` DATE COMMENT 'Date when the account becomes effective.',
    `valid_to` DATE COMMENT 'Date when the account is retired or becomes inactive; null if open‑ended.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger chart of accounts master for the semiconductor enterprise. Covers P&L accounts (wafer cost, NRE revenue, R&D expense, depreciation), balance sheet accounts (fab equipment assets, WIP inventory, receivables), and statistical accounts. Includes account type, financial statement version assignment, tax category, reconciliation account flag, and SOX control classification. Sourced from SAP FI chart of accounts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique system-generated identifier for the profit center.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record within the profit center finance entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the profit center finance entity.',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the immediate parent profit center in the hierarchy.',
    `profit_employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the profit center.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual expenditures recorded against the profit center.',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of corporate overhead allocated to this profit center.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the profit center for the fiscal period.',
    `budget_currency` STRING COMMENT 'ISO 4217 currency code of the budget amount, e.g., USD.',
    `profit_center_category` STRING COMMENT 'High‑level category used for reporting and analysis.. Valid values are `product_line|technology_node|geography|service|support`',
    `change_reason` STRING COMMENT 'Free‑form text describing why the profit center record was changed.',
    `profit_center_code` STRING COMMENT 'Business code used in SAP and reporting to identify the profit center.',
    `controlling_area` STRING COMMENT 'Controlling area code to which the profit center belongs in SAP CO.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate costs to the profit center.. Valid values are `direct|activity_based|standard`',
    `cost_center_code` STRING COMMENT 'Associated cost center code for internal cost allocation.',
    `created_by_user` STRING COMMENT 'User ID of the person who created the profit center record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created in the system.',
    `currency` STRING COMMENT 'The currency of the profit center record in the finance domain.',
    `profit_center_description` STRING COMMENT 'Free‑form description providing context and business purpose.',
    `end_date` DATE COMMENT 'Date when the profit center was retired or closed (nullable).',
    `fab_location` STRING COMMENT 'Fabrication facility location associated with the profit center.',
    `geographic_region` STRING COMMENT 'Regional market or sales region covered by the profit center.',
    `hierarchy_level` STRING COMMENT 'Depth level of the profit center within the organizational hierarchy.',
    `is_active` BOOLEAN COMMENT 'The is active of the profit center record in the finance domain.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the profit center is included in corporate consolidation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the profit center record in the finance domain.',
    `last_review_date` DATE COMMENT 'Date of the most recent financial or operational review.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the profit center record in the finance domain.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center, e.g., "Advanced Logic ASICs".',
    `product_line` STRING COMMENT 'Product family or line that the profit center supports.',
    `profit_center_group` STRING COMMENT 'Higher‑level grouping of profit centers for consolidated reporting.',
    `profit_center_status` STRING COMMENT 'Current operational status of the profit center.. Valid values are `active|inactive|planned|closed|suspended`',
    `profit_center_type` STRING COMMENT 'Category that defines the nature of the profit center.. Valid values are `product_line|technology_node|geography|service|support`',
    `reporting_currency` STRING COMMENT 'Currency in which the profit center reports financial results.',
    `responsibility_center` STRING COMMENT 'Internal responsibility center code for cost allocation.',
    `review_cycle` STRING COMMENT 'Frequency of scheduled reviews for the profit center.. Valid values are `monthly|quarterly|annual`',
    `sox_compliant` BOOLEAN COMMENT 'Flag indicating SOX compliance for financial reporting.',
    `start_date` DATE COMMENT 'Date when the profit center became effective.',
    `subgroup` STRING COMMENT 'Secondary grouping within a profit center group.',
    `technology_node` STRING COMMENT 'Process technology node (e.g., 5nm, 7nm) linked to the profit center.',
    `to_company_code` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Profit centers are assigned to company codes for legal entity-level profitability reporting.',
    `transfer_pricing_indicator` BOOLEAN COMMENT 'Flag indicating whether the profit center participates in internal transfer pricing.',
    `updated_by_user` STRING COMMENT 'User ID of the person who last updated the profit center record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the profit center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual spend (budget - actual).',
    `version_number` STRING COMMENT 'Incremental version number for change tracking.',
    `valid_from` DATE COMMENT 'The valid from of the profit center record in the finance domain.',
    `valid_to` DATE COMMENT 'The valid to of the profit center record in the finance domain.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP EC-PCA profit center master representing autonomous business segments for internal profitability reporting. Covers product lines (SoC, ASIC, FPGA, discrete), technology nodes (5nm, 7nm, 28nm), and geographic segments. Includes profit center hierarchy, responsible manager, controlling area assignment, and transfer pricing indicator. Enables margin analysis by product family and technology generation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry.',
    `ar_invoice_id` BIGINT COMMENT 'add column ar_invoice_id (BIGINT) with FK to invoice.ar_invoice.ar_invoice_id - journal entries record invoice transactions',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries are posted against cost center, profit center, internal order and WBS element; FK replaces ambiguous code fields.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export‑controlled sales require each journal entry to reference the export license authorizing the shipment for compliance reporting.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Link journal entry to internal order for cost allocation and tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee (e.g., payroll or expense entry).',
    `journal_posted_by_employee_id` BIGINT COMMENT 'Unique identifier for the journal posted by employee record within the journal entry finance entity.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record within the journal entry finance entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries need a reliable link to profit center for reporting.',
    `project_id` BIGINT COMMENT 'Identifier of the project linked to the entry.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Revenue journal entries must reference the originating sales order for audit trails and financial reporting.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor involved in the transaction.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Journal entries should reference the WBS element they belong to.',
    `amount_base` DECIMAL(18,2) COMMENT 'Total amount of the entry converted to the corporate group currency.',
    `amount_local` DECIMAL(18,2) COMMENT 'Total amount of the entry in the documents currency.',
    `asset_number` STRING COMMENT 'Fixed‑asset identifier for depreciation or acquisition postings.',
    `business_area` STRING COMMENT 'Higher‑level grouping of profit centers for reporting.',
    `company_code` STRING COMMENT 'Organizational unit identifier for legal entity reporting.',
    `consolidation_group` STRING COMMENT 'Group identifier for consolidation adjustments.',
    `consolidation_method` STRING COMMENT 'Method used for the consolidation entry.. Valid values are `elimination|translation|goodwill|minority|adjustment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the document.. Valid values are `[A-Z]{3}`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line is a debit or credit.. Valid values are `debit|credit`',
    `journal_entry_description` STRING COMMENT 'Free‑text description of the journal entry purpose.',
    `document_date` DATE COMMENT 'The document date associated with the journal entry finance record.',
    `document_number` STRING COMMENT 'External business identifier for the journal entry document.',
    `document_type` STRING COMMENT 'Category of the financial document (e.g., vendor invoice, intercompany).. Valid values are `vendor_invoice|customer_payment|asset_depreciation|accrual|intercompany|consolidation`',
    `entry_status` STRING COMMENT 'The entry status of the journal entry record in the finance domain.',
    `entry_type` STRING COMMENT 'The entry type of the journal entry record in the finance domain.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert document currency to group currency.',
    `fiscal_period` STRING COMMENT 'Two‑digit period within the fiscal year (01‑12).. Valid values are `0[1-9]|1[0-2]`',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the entry belongs.',
    `functional_area` STRING COMMENT 'Functional area code for internal reporting.',
    `intercompany_indicator` BOOLEAN COMMENT 'True if the entry is part of an intercompany transaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the journal entry record in the finance domain.',
    `ledger_account` STRING COMMENT 'General Ledger account number associated with the entry.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the journal entry record in the finance domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and adjustments.',
    `period_end_date` DATE COMMENT 'End date of the accounting period for the entry.',
    `posting_date` DATE COMMENT 'The posting date associated with the journal entry finance record.',
    `posting_key` STRING COMMENT 'SAP posting key that determines debit/credit logic.. Valid values are `d{2}`',
    `posting_status` STRING COMMENT 'Current processing status of the journal entry.. Valid values are `posted|pending|reversed|error`',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the entry was posted to the ledger.',
    `reference_document_number` STRING COMMENT 'Document number of the original entry being referenced.',
    `reference_text` STRING COMMENT 'The reference text of the journal entry record in the finance domain.',
    `reversal_date` DATE COMMENT 'Date on which the reversal was posted.',
    `reversal_indicator` BOOLEAN COMMENT 'True if the entry reverses a previous posting.',
    `segment` STRING COMMENT 'Market or product segment for analytical reporting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the entry.',
    `tax_code` STRING COMMENT 'Tax code determining tax calculation rules.',
    `to_company_code` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Every journal entry is posted within a specific legal entity (company code). Required for legal entity reporting and consolidation.',
    `total_credit` DECIMAL(18,2) COMMENT 'The total credit of the journal entry record in the finance domain.',
    `total_debit` DECIMAL(18,2) COMMENT 'The total debit of the journal entry record in the finance domain.',
    `updated_by` STRING COMMENT 'User identifier who last modified the journal entry record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the journal entry record.',
    `created_by` STRING COMMENT 'User identifier who created the journal entry record.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core SAP FI general ledger journal entry capturing all financial postings across the semiconductor enterprise including consolidation adjustments. Document types include vendor invoice, customer payment, asset depreciation, accrual, intercompany, and consolidation entries (intercompany elimination, minority interest adjustment, currency translation adjustment, goodwill amortization). Captures posting date, fiscal period, company code, currency, exchange rate, consolidation unit/group (for group entries), consolidation method, and SOX-relevant reversal indicator. Covers fab cost postings, NRE revenue recognition, R&D capitalization entries, period-end accruals, and group-level consolidation adjustments for SOX-compliant financial reporting under US GAAP or IFRS. Primary transactional record and audit trail for all financial activity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line record.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Revenue recognition report requires each journal entry line to map to its originating sales booking for reconciliation.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Cost center assignment on journal entry lines is required for management accounting, cost allocation, and P&L reporting by organizational unit.',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account.gl_account_id — Every journal entry line posts to a GL account. This is the core of double-entry bookkeeping and is required for trial balance, financial statements, and all reporting.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Line‑level journal entries need the order line ID to allocate revenue and cost precisely per SKU.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry header to which this line belongs.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center.profit_center_id — Profit center assignment enables profitability analysis by business segment, technology node, and product line - core semiconductor finance requirement.',
    `to_journal_entry_id` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Fundamental header-line relationship. Every journal entry line must reference its parent journal entry document. This is the most critical FK in the entire domain - without it, line items are orphaned',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the journal entry line record in the finance domain.',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line expressed in the documents currency.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line converted to the companys local currency.',
    `assignment_field` STRING COMMENT 'User‑defined field for additional cost allocation or tagging.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the document currency.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line is a debit or credit.. Valid values are `debit|credit`',
    `effective_date` DATE COMMENT 'Date from which the line amount becomes effective for reporting.',
    `functional_area` STRING COMMENT 'Functional area classification for reporting (e.g., R&D, Manufacturing).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the journal entry line record in the finance domain.',
    `line_description` STRING COMMENT 'Free‑text description of the line item.',
    `line_number` STRING COMMENT 'Sequential number of the line within the journal entry.',
    `line_status` STRING COMMENT 'Current processing status of the line.. Valid values are `open|cleared|reversed|pending`',
    `line_text` STRING COMMENT 'The line text of the journal entry line record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the journal entry line record in the finance domain.',
    `posting_date` DATE COMMENT 'Date on which the line is posted to the ledger.',
    `quantity` STRING COMMENT 'Quantity associated with the line (e.g., number of units, hours).',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line reverses a previous entry.',
    `tax_code` STRING COMMENT 'Tax code determining tax treatment for the line.',
    `to_journal_entry` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Header-line relationship is the most fundamental FK in any GL system. Every line item must reference its parent journal entry document. Without this, you cannot reconstruct a balanced journal entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit/credit line items within a SAP FI journal entry document. Each line captures GL account, cost center, profit center, WBS element, functional area, amount in document and local currency, tax code, and assignment field. Supports granular cost allocation to fab process steps, equipment depreciation lines, and NRE milestone revenue lines. Essential for drill-down financial analysis and SOX audit trails.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'System-generated unique identifier for the capital expenditure request.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee who originated the capex request.',
    `capex_requestor_employee_id` BIGINT COMMENT 'Unique identifier for the capex requestor employee record within the capex request finance entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capex requests are tied to a cost center; using an FK removes the ambiguous code column.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Capital equipment purchases subject to export controls must be tied to the relevant export license for financial tracking and audit.',
    `project_id` BIGINT COMMENT 'Identifier of the capital project or program linked to the request.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external supplier providing the equipment.',
    `fixed_asset_id` BIGINT COMMENT 'FK to finance.fixed_asset.fixed_asset_id — Approved capex requests result in fixed asset creation. Links investment approval to the resulting asset for lifecycle tracking.',
    `approval_date` DATE COMMENT 'The approval date associated with the capex request finance record.',
    `approval_stage` STRING COMMENT 'Current approval workflow stage of the request.. Valid values are `initial|financial|executive`',
    `approval_status` STRING COMMENT 'Result of the most recent approval action.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the request was last approved or rejected.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Final amount approved after any adjustments.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount allocated for the request.',
    `business_case_summary` STRING COMMENT 'Brief narrative describing the strategic rationale and expected ROI.',
    `capex_request_status` STRING COMMENT 'Current lifecycle status of the capex request.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `chips_act_funding_eligible` BOOLEAN COMMENT 'Indicates whether the request qualifies for CHIPS Act financial incentives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the requested amount (e.g., USD, EUR).',
    `depreciation_end_date` DATE COMMENT 'Date when the asset is fully depreciated.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the capital asset.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the asset begins.',
    `equipment_category` STRING COMMENT 'High‑level classification of the fab equipment being requested.. Valid values are `lithography|cmp|cvd|pvd|ald|ate`',
    `equipment_model` STRING COMMENT 'Manufacturer model number or SKU of the equipment (e.g., NXE:3400).',
    `funding_source` STRING COMMENT 'Source of capital funds for the investment.. Valid values are `internal|external|chips_act|government_grant`',
    `justification` STRING COMMENT 'Detailed technical justification, including technology node applicability and capacity impact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the capex request record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the capex request record in the finance domain.',
    `request_amount` DECIMAL(18,2) COMMENT 'Total monetary amount requested for the investment before any adjustments.',
    `request_date` DATE COMMENT 'Date and time when the capex request was initially submitted.',
    `request_number` STRING COMMENT 'Human‑readable request number assigned by the finance system (e.g., CR‑2023‑00123).',
    `request_status` STRING COMMENT 'The request status of the capex request record in the finance domain.',
    `request_title` STRING COMMENT 'The request title of the capex request record in the finance domain.',
    `requested_amount` DECIMAL(18,2) COMMENT 'The requested amount of the capex request record in the finance domain.',
    `requester_name` STRING COMMENT 'Full name of the employee requesting the investment.',
    `risk_rating` STRING COMMENT 'Risk assessment rating for the investment request.. Valid values are `low|medium|high|critical`',
    `technology_node` STRING COMMENT 'Process technology node the equipment will support.. Valid values are `5nm|7nm|10nm|14nm|28nm`',
    `to_fixed_asset_id` BIGINT COMMENT 'FK to finance.fixed_asset.fixed_asset_id — Approved capex requests result in fixed asset creation. This FK links the investment decision to the resulting asset record, enabling capex tracking from request through asset lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    `useful_life_years` STRING COMMENT 'Estimated economic useful life of the asset in years for depreciation.',
    `vendor_name` STRING COMMENT 'Legal name of the equipment supplier.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital expenditure request and approval record for semiconductor fab equipment investments. Captures investment type (lithography scanner, CMP tool, CVD/PVD/ALD system, ATE platform, metrology tool), requested amount, business justification, technology node applicability, expected useful life, depreciation method, and multi-level approval workflow status. Tracks NRE vs. recurring capex classification and CHIPS Act funding eligibility. Links to SAP IM investment program.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'System-generated unique identifier for each fixed asset record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset register requires assigning a custodian employee for accountability and audit of each fixed asset.',
    `capex_request_id` BIGINT COMMENT 'Unique identifier for the capex request record within the fixed asset finance entity.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Every fixed asset is assigned to a cost center for depreciation posting and cost allocation. Critical for fab equipment cost tracking.',
    `equipment_fab_id` BIGINT COMMENT 'Identifier of the fab (fabrication facility) where the asset resides.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation recorded to date for the asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to acquire the asset, including purchase price, freight, installation, and commissioning.',
    `acquisition_date` DATE COMMENT 'Date the asset was purchased or otherwise acquired.',
    `asset_category` STRING COMMENT 'Higher‑level classification (e.g., Equipment, Facility, IT Infrastructure).',
    `asset_class` STRING COMMENT 'The asset class of the fixed asset record in the finance domain.',
    `asset_description` STRING COMMENT 'The asset description of the fixed asset record in the finance domain.',
    `asset_name` STRING COMMENT 'Human‑readable name of the asset (e.g., EUV Lithography Scanner 1).',
    `asset_number` STRING COMMENT 'The asset number of the fixed asset record in the finance domain.',
    `asset_status` STRING COMMENT 'The asset status of the fixed asset record in the finance domain.',
    `asset_tag` STRING COMMENT 'Unique alphanumeric tag or barcode assigned to the asset for physical identification.',
    `asset_type` STRING COMMENT 'Category of the asset such as Lithography Scanner, CVD Tool, CMP Equipment, Cleanroom Infrastructure, or IT Asset.',
    `capitalized` BOOLEAN COMMENT 'Indicates whether the asset has been capitalized on the balance sheet (True) or remains expense (False).',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the asset record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the system.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the fixed asset finance record.',
    `depreciation_adjustment_amount` DECIMAL(18,2) COMMENT 'Additional depreciation amount applied due to changes in utilization or technology node retirement.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation expense posted for the most recent fiscal period.',
    `depreciation_end_date` DATE COMMENT 'Projected date when the asset will be fully depreciated or disposed.',
    `depreciation_key` STRING COMMENT 'Code that determines the depreciation area (e.g., book, tax, IFRS) and rules applied.',
    `depreciation_method` STRING COMMENT 'Algorithm used to calculate periodic depreciation.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin for the asset.',
    `disposal_date` DATE COMMENT 'Date the asset was removed from service and disposed of, sold, or transferred.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed.. Valid values are `sale|scrap|transfer`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Monetary proceeds received from the disposal of the asset.',
    `fixed_asset_status` STRING COMMENT 'Current operational state of the asset.. Valid values are `in_service|retired|maintenance|disposed|pending`',
    `grant_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the grant allocated to the asset.',
    `grant_recognition_date` DATE COMMENT 'Date on which the grant amount is recognized in financial statements.',
    `grant_tracking_number` STRING COMMENT 'Reference number for CHIPS Act or other government grant associated with the asset.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Monetary amount by which the assets carrying value is reduced due to impairment.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether an impairment test has been performed and resulted in a loss.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed on the asset.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the fixed asset record in the finance domain.',
    `location_bay` STRING COMMENT 'Specific bay or cleanroom area within the building housing the asset.',
    `location_building` STRING COMMENT 'Name or code of the building where the asset is installed.',
    `maintenance_contract_number` STRING COMMENT 'Contract identifier for the service agreement covering preventive maintenance.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the fixed asset record in the finance domain.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Assets carrying amount after subtracting accumulated depreciation.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `remaining_useful_life_years` STRING COMMENT 'Estimated remaining economic life of the asset, expressed in years.',
    `responsible_department` STRING COMMENT 'Organizational department that owns or manages the asset.',
    `technology_node_nm` DECIMAL(18,2) COMMENT 'Process node (in nanometers) the equipment is qualified for (e.g., 7.0, 5.0).',
    `updated_by_user` STRING COMMENT 'User identifier of the person who last modified the asset record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fixed asset record.',
    `useful_life_years` STRING COMMENT 'Planned economic life of the asset expressed in years for depreciation purposes.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Average operational utilization of the asset expressed as a percentage of its capacity.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'SAP FI-AA fixed asset master and full depreciation lifecycle for semiconductor manufacturing equipment and infrastructure. Covers EUV/DUV lithography scanners, deposition systems (CVD/PVD/ALD), etch tools, CMP equipment, ATE platforms, cleanroom infrastructure, and IT assets. Master attributes include asset class, acquisition cost, capitalization date, useful life, depreciation key, location (fab building/bay), technology node assignment, and CHIPS Act grant tracking. Depreciation records capture each periodic posting: run date, fiscal period, depreciation area (book/tax/IFRS), depreciation amount, accumulated depreciation, net book value, and remaining useful life. Supports fab utilization-based depreciation adjustments, technology node retirement accounting, asset impairment testing, and disposal/transfer processing. SSOT for the complete asset register from acquisition through disposal including all depreciation schedules. Generated by SAP FI-AA depreciation run (AFAB).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` (
    `asset_depreciation_id` BIGINT COMMENT 'System-generated unique identifier for each depreciation posting record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset depreciation records should reference the cost center responsible for the asset.',
    `depreciation_run_id` BIGINT COMMENT 'Identifier of the depreciation run (header) that generated this posting.',
    `employee_id` BIGINT COMMENT 'User ID of the person who approved or triggered the posting.',
    `fabrication_fab_id` BIGINT COMMENT 'Identifier of the fab facility that owns the asset.',
    `location_id` BIGINT COMMENT 'Identifier of the plant or fab site where the asset resides.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier of the fab equipment or infrastructure asset being depreciated.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation accumulated on the asset up to the posting date.',
    `approval_status` STRING COMMENT 'Workflow status of the depreciation posting approval.. Valid values are `approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the posting was approved or rejected.',
    `asset_depreciation_status` STRING COMMENT 'Current processing status of the depreciation line.. Valid values are `posted|reversed|pending|error`',
    `batch_number` STRING COMMENT 'Identifier of the batch job that performed the depreciation calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts (e.g., USD).',
    `depreciation_adjustment_amount` DECIMAL(18,2) COMMENT 'Additional amount added/subtracted to the base depreciation due to utilization or revaluation.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation expense posted for the period in the selected currency.',
    `depreciation_area` STRING COMMENT 'Accounting area for the depreciation amount – book (GAAP), tax, or IFRS.. Valid values are `book|tax|ifrs`',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the asset.. Valid values are `straight_line|double_declining|units_of_production|sum_of_years_digits`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `external_reference_number` STRING COMMENT 'Reference to external documentation or audit trail (e.g., audit report ID).',
    `fiscal_period` STRING COMMENT 'Period number within the fiscal year (typically month 1‑12).',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year of the depreciation posting (e.g., 2024).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the asset depreciation record in the finance domain.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the depreciation run.',
    `model_lineage_source` STRING COMMENT 'P3: shared.fab FK removed per VREQ-029',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the asset depreciation record in the finance domain.',
    `notes` STRING COMMENT 'Free‑form comments or explanations for the posting.',
    `period` STRING COMMENT 'The period of the asset depreciation record in the finance domain.',
    `period_month` STRING COMMENT 'The period month of the asset depreciation record in the finance domain.',
    `period_year` STRING COMMENT 'The period year of the asset depreciation record in the finance domain.',
    `posted_date` DATE COMMENT 'Date on which the depreciation entry was posted to the ledger.',
    `posting_date` DATE COMMENT 'The posting date associated with the asset depreciation finance record.',
    `remaining_useful_life_months` STRING COMMENT 'Estimated remaining service life of the asset in months after this posting.',
    `technology_node` STRING COMMENT 'Process technology node associated with the asset (e.g., 7nm, 14nm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the depreciation record.',
    `utilization_factor` DECIMAL(18,2) COMMENT 'Factor reflecting actual equipment utilization used to adjust depreciation.',
    CONSTRAINT pk_asset_depreciation PRIMARY KEY(`asset_depreciation_id`)
) COMMENT 'Periodic depreciation posting records for semiconductor fab equipment and infrastructure assets. Captures depreciation run date, fiscal period, asset, depreciation area (book, tax, IFRS), depreciation amount, accumulated depreciation to date, and remaining useful life. Supports fab utilization-based depreciation adjustments and technology node retirement accounting. Generated by SAP FI-AA depreciation run (AFAB).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'System-generated unique identifier for the internal order.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the primary cost center record within the internal order finance entity.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the asset‑under‑construction record created from capitalized costs.',
    `primary_internal_cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the orders expenses.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee accountable for the order execution.',
    `to_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Internal orders are assigned to responsible cost centers for settlement and organizational reporting.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount of the internal order record in the finance domain.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred against the internal order to date.',
    `auditor_approval_date` DATE COMMENT 'Date on which the auditor provided approval for capitalization.',
    `auditor_approval_flag` BOOLEAN COMMENT 'Indicates whether the internal order has been approved by the external auditor for capitalization.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the internal order expressed in the order currency.',
    `capitalization_date` DATE COMMENT 'Date on which eligible costs were capitalized to an intangible asset.',
    `capitalization_eligibility` BOOLEAN COMMENT 'Indicates whether the order meets criteria for R&D cost capitalization.',
    `closure_date` DATE COMMENT 'Date when the internal order was closed and settled.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Committed cost amount that cannot be exceeded without re‑approval.',
    `completion_date` DATE COMMENT 'Date when the order reached technically complete status.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the internal order record in the finance domain.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `[A-Z]{3}`',
    `internal_order_description` STRING COMMENT 'Free‑text description of the purpose and scope of the internal order.',
    `internal_order_status` STRING COMMENT 'Current lifecycle state of the internal order.. Valid values are `created|released|technically_complete|closed|cancelled|pending`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the internal order record in the finance domain.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition for the order.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the internal order record in the finance domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after any adjustments, taxes, or discounts applied to the order.',
    `order_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the internal order was initially created in the source system.',
    `order_description` STRING COMMENT 'The order description of the internal order record in the finance domain.',
    `order_number` STRING COMMENT 'Business-visible identifier assigned to the internal order.',
    `order_status` STRING COMMENT 'The order status of the internal order record in the finance domain.',
    `order_type` STRING COMMENT 'Classification of the order purpose (e.g., research & development, equipment maintenance, non‑recurring engineering).. Valid values are `R&D|Maintenance|NRE|Corporate|Capital|Other`',
    `real_indicator` BOOLEAN COMMENT 'True if the order records real, incurred costs.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the internal order record.',
    `release_date` DATE COMMENT 'Date when the internal order was released for execution.',
    `settlement_rule` STRING COMMENT 'Rule that determines how costs are settled (to an asset, cost center, or WBS element).. Valid values are `asset|cost_center|wbs`',
    `statistical_indicator` BOOLEAN COMMENT 'True if the order is used for statistical cost allocation rather than actual cost tracking.',
    `technology_node` STRING COMMENT 'Process technology node (e.g., 5nm, 7nm) associated with the R&D effort.',
    `to_cost_center` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Internal orders have a responsible cost center for settlement and organizational assignment. Required for cost collection and settlement processing.',
    `trl` STRING COMMENT 'Readiness level of the technology (1‑9) at the time of order creation.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element code to which the order costs are assigned.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order master for collecting, tracking, settling, and capitalizing costs of specific semiconductor initiatives. Covers R&D capitalization orders (process node development, IP core development, EDA tool evaluation), fab equipment maintenance campaign orders, customer-specific NRE execution orders, and corporate initiative orders. Includes order type, status lifecycle (created/released/technically complete/closed), responsible cost center, settlement rule (to asset, cost center, or WBS), overall budget, commitment value, actual cost, and statistical/real indicator. Full R&D capitalization lifecycle: tracks technology readiness level, capitalization eligibility assessment per ASC 730/IAS 38, original expense amounts, capitalized amounts, capitalization date, asset under construction reference, and auditor approval. Enables end-to-end cost collection from initial R&D expense through capitalization event to intangible asset creation. Sourced from SAP CO-OM/CO-PC.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique surrogate key for the WBS element record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WBS elements belong to a cost center; an FK provides a reliable link.',
    `internal_order_id` BIGINT COMMENT 'FK to finance.internal_order.internal_order_id — WBS elements in R&D projects link to internal orders for cost collection and capitalization. Required for project cost tracking and R&D capitalization workflow.',
    `parent_wbs_element_id` BIGINT COMMENT 'Unique identifier for the parent wbs element record within the wbs element finance entity.',
    `parent_wbs_wbs_element_id` BIGINT COMMENT 'Identifier of the immediate parent element in the WBS hierarchy.',
    `project_id` BIGINT COMMENT 'Unique identifier for the project record within the wbs element finance entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager accountable for the WBS element.',
    `wbs_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the wbs responsible employee record within the wbs element finance entity.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount of the wbs element record in the finance domain.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Real monetary cost incurred to date for the WBS element.',
    `actual_end_date` DATE COMMENT 'Real calendar date when work on the element actually completed.',
    `actual_start_date` DATE COMMENT 'Real calendar date when work on the element actually started.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS element was approved for execution.',
    `billing_element_flag` BOOLEAN COMMENT 'Indicates whether the WBS element is billable for NRE or customer invoicing.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monetary budget allocated to the WBS element.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate costs from this element to downstream entities.. Valid values are `fixed|percentage|usage_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|CNY|GBP`',
    `wbs_element_description` STRING COMMENT 'Detailed description of the work scope represented by the WBS element.',
    `external_reference` STRING COMMENT 'Identifier used by external systems (e.g., PLM, ERP) to reference this WBS element.',
    `financial_year` STRING COMMENT 'Fiscal year to which the elements financial data belongs.',
    `fiscal_period` STRING COMMENT 'Quarter within the financial year for reporting.. Valid values are `Q1|Q2|Q3|Q4`',
    `is_capital_expenditure` BOOLEAN COMMENT 'True if costs incurred under this element are treated as capital expenditures.',
    `is_template` BOOLEAN COMMENT 'True if the element is defined as a reusable template for future projects.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the WBS element record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the wbs element record in the finance domain.',
    `wbs_element_level` STRING COMMENT 'Depth level of the element within the WBS tree (root = 1).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the wbs element record in the finance domain.',
    `wbs_element_name` STRING COMMENT 'Human‑readable name of the WBS element.',
    `planned_end_date` DATE COMMENT 'Planned calendar date when work on the element is expected to finish.',
    `project_phase` STRING COMMENT 'Current phase of the overall project to which the element belongs.. Valid values are `development|qualification|ramp_up|production|closure`',
    `r_and_d_capitalization_flag` BOOLEAN COMMENT 'True if the elements costs are eligible for R&D capitalization under accounting standards.',
    `start_date` DATE COMMENT 'Planned calendar date when work on the element is scheduled to begin.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the WBS element record.',
    `wbs_code` STRING COMMENT 'Hierarchical alphanumeric code that uniquely identifies the WBS element within the project hierarchy.',
    `wbs_description` STRING COMMENT 'The wbs description of the wbs element record in the finance domain.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element.. Valid values are `planned|active|completed|on_hold|cancelled`',
    `wbs_element_type` STRING COMMENT 'Category of the WBS element indicating its granularity within the project hierarchy.. Valid values are `project|phase|task|subtask|milestone`',
    `wbs_hierarchy_path` STRING COMMENT 'Delimited string representing the full path from root to this element (e.g., 1.2.3).',
    `wbs_level` STRING COMMENT 'The wbs level of the wbs element record in the finance domain.',
    `wbs_status` STRING COMMENT 'The wbs status of the wbs element record in the finance domain.',
    `wbs_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the WBS element.',
    `created_by` STRING COMMENT 'User identifier of the person who created the WBS element record.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure element master from SAP PS for semiconductor R&D and capital projects. Structures complex multi-phase projects such as new process node development (PDK creation, process qualification, yield ramp), fab expansion programs, and EUV lithography integration. Captures WBS code, project definition, responsible manager, planned/actual dates, budget, and billing element flag for NRE milestone invoicing. Enables hierarchical project cost tracking and R&D capitalization.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'System-generated unique identifier for each cost allocation record.',
    `allocation_cycle_id` BIGINT COMMENT 'Identifier of the allocation cycle (header) to which this record belongs.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the cost allocation finance entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation records identify the sending cost center; the FK replaces the code and enforces referential integrity.',
    `source_cost_center_id` BIGINT COMMENT 'Unique identifier for the source cost center record within the cost allocation finance entity.',
    `target_cost_center_id` BIGINT COMMENT 'Unique identifier for the target cost center record within the cost allocation finance entity.',
    `tertiary_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Cost allocation cycles have sender cost centers (overhead pools) that distribute costs. Without this FK, allocation cycles cannot identify their source.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the receiver cost center.',
    `allocation_base_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allocation basis (e.g., total machine hours).',
    `allocation_basis` STRING COMMENT 'Primary driver used as the allocation base (e.g., machine hours, wafer passes).. Valid values are `machine_hours|wafer_passes|labor_hours|energy_consumption|area_sqft|custom`',
    `allocation_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the allocation.',
    `allocation_method` STRING COMMENT 'Method used to calculate the allocation (e.g., activity‑based, statistical, fixed percentage).. Valid values are `activity_based|statistical|fixed_percentage|direct|proportional|custom`',
    `allocation_percent` DECIMAL(18,2) COMMENT 'The allocation percent of the cost allocation record in the finance domain.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage of the cost allocation record in the finance domain.',
    `allocation_rate` DECIMAL(18,2) COMMENT 'Rate applied per unit of the allocation base (e.g., cost per machine hour).',
    `cost_allocation_status` STRING COMMENT 'Current processing status of the allocation record.. Valid values are `pending|allocated|reversed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the allocated amount.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the allocation becomes effective.',
    `expiration_date` DATE COMMENT 'Date after which the allocation is no longer valid (nullable).',
    `fiscal_period` STRING COMMENT 'Fiscal period for which the allocation is recorded, expressed as YYYYQ#.. Valid values are `^d{4}Q[1-4]$`',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) of the allocation.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the cost allocation record in the finance domain.',
    `line_sequence` STRING COMMENT 'Sequential number of the allocation line within its allocation cycle.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the cost allocation record in the finance domain.',
    `period` STRING COMMENT 'The period of the cost allocation record in the finance domain.',
    `period_month` STRING COMMENT 'The period month of the cost allocation record in the finance domain.',
    `period_year` STRING COMMENT 'The period year of the cost allocation record in the finance domain.',
    `receiver_cost_center_code` STRING COMMENT 'Code of the cost center receiving the allocated cost.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'True if this allocation record reverses a prior allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the allocation record.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Periodic cost allocation, assessment, and distribution cycle records for semiconductor fab overhead and shared service costs. Captures allocation cycle ID, sender cost center (fab overhead pool, shared services), receiver cost centers or orders, allocation method (activity-based using machine hours or wafer passes, statistical key figure, fixed percentage), allocation base quantity, allocated amount, fiscal period, and reversal indicator. Supports wafer cost modeling by distributing equipment depreciation, utilities, cleanroom maintenance, and indirect labor to process steps based on fab utilization rates and activity drivers. Enables accurate product costing and profitability analysis.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` (
    `wafer_cost_model_id` BIGINT COMMENT 'Unique surrogate key for each wafer cost model record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wafer cost models are allocated to cost centers; replace code with FK.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Identifier of the manufacturing process flow associated with this cost model.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - wafer cost models are technology node specific',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the wafer cost model finance entity.',
    `process_node_id` BIGINT COMMENT 'Unique identifier for the process node record within the wafer cost model finance entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wafer cost models are scoped to a profit center; the FK provides proper ownership and reporting.',
    `chemicals_gases_cost_usd_per_wafer` DECIMAL(18,2) COMMENT 'Direct material cost for chemicals and gases consumed per wafer.',
    `cost_per_wafer_usd` DECIMAL(18,2) COMMENT 'The cost per wafer usd of the wafer cost model record in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost model record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the model.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `die_size_um2` DECIMAL(18,2) COMMENT 'Area of a single die on the wafer in square micrometres.',
    `effective_date` DATE COMMENT 'The effective date associated with the wafer cost model finance record.',
    `effective_end_date` DATE COMMENT 'Date when the cost model is retired or superseded; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the cost model becomes valid for planning and reporting.',
    `equipment_depreciation_usd_per_wafer` DECIMAL(18,2) COMMENT 'Allocated equipment depreciation cost for each wafer pass.',
    `fab_location` STRING COMMENT 'Code representing the fab site (e.g., "US1", "SG2").. Valid values are `^[A-Z]{2,5}$`',
    `fab_overhead_rate_percent` DECIMAL(18,2) COMMENT 'Factory overhead rate applied to the wafer cost, expressed as a percent.',
    `fixed_cost_usd` DECIMAL(18,2) COMMENT 'The fixed cost usd of the wafer cost model record in the finance domain.',
    `labor_hours_per_wafer` DECIMAL(18,2) COMMENT 'Total labor hours required to process a single wafer.',
    `labor_rate_usd_per_hour` DECIMAL(18,2) COMMENT 'Hourly labor rate applied to wafer processing activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the wafer cost model record in the finance domain.',
    `mask_set_amortization_wafers` DECIMAL(18,2) COMMENT 'Number of wafers over which the mask set cost is amortized.',
    `mask_set_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of the photomask set required for the process flow, expressed in US dollars.',
    `model_code` STRING COMMENT 'Business identifier code used to reference the cost model in finance and planning systems.. Valid values are `^[A-Z0-9_]+$`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the wafer cost model record in the finance domain.',
    `model_name` STRING COMMENT 'Human‑readable name describing the cost model (e.g., "7nm High‑Yield Model").',
    `process_node_nm` STRING COMMENT 'The process node nm of the wafer cost model record in the finance domain.',
    `silicon_wafer_cost_usd` DECIMAL(18,2) COMMENT 'Cost of the raw silicon wafer per unit, in US dollars.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Planned percentage of good dies per wafer used for cost allocation.',
    `technology_node` STRING COMMENT 'Process technology node expressed in nanometers (e.g., "7nm").. Valid values are `^d+nm$`',
    `total_cost_per_wafer_usd` DECIMAL(18,2) COMMENT 'Fully‑loaded cost of a wafer after aggregating all direct and indirect cost components.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost model record.',
    `variable_cost_usd` DECIMAL(18,2) COMMENT 'The variable cost usd of the wafer cost model record in the finance domain.',
    `version_number` STRING COMMENT 'Sequential version identifier for the cost model, incremented on each change.',
    `wafer_cost_model_status` STRING COMMENT 'Current lifecycle status of the cost model.. Valid values are `active|inactive|deprecated`',
    `wafer_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of the silicon wafer in millimetres.',
    `wafer_size_mm` STRING COMMENT 'The wafer size mm of the wafer cost model record in the finance domain.',
    `yield_assumption_percent` DECIMAL(18,2) COMMENT 'The yield assumption percent of the wafer cost model record in the finance domain.',
    CONSTRAINT pk_wafer_cost_model PRIMARY KEY(`wafer_cost_model_id`)
) COMMENT 'Semiconductor-specific wafer cost model master defining the standard cost build-up for a wafer lot at a given technology node and process flow. Captures process node, wafer diameter, die size, target yield, mask set cost amortization, direct material cost (silicon wafer, chemicals, gases), direct labor rate, equipment depreciation per wafer pass, fab overhead rate, and fully-loaded cost per wafer out. Used for product pricing, NRE recovery planning, and fab utilization-based cost allocation. Unique to semiconductor manufacturing finance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` (
    `finance_nre_agreement_id` BIGINT COMMENT 'Surrogate primary key for the NRE agreement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party to whom the NRE agreement applies.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: NRE agreements can trigger CHIPS Act obligations; linking enables mandatory regulatory‑financial reporting of those obligations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NRE agreements are associated with a cost center; FK enforces this relationship.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC design project associated with the NRE agreement.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the finance nre agreement finance entity.',
    `primary_finance_employee_id` BIGINT COMMENT 'User identifier of the person who approved the NRE agreement.',
    `sales_nre_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_nre_agreement. Business justification: Financial NRE agreement must reference the matching sales NRE agreement to align revenue recognition with the sales contract.',
    `tertiary_finance_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the agreement record.',
    `agreement_date` DATE COMMENT 'The agreement date associated with the finance nre agreement finance record.',
    `agreement_number` STRING COMMENT 'External contract number assigned to the NRE agreement.',
    `agreement_status` STRING COMMENT 'The agreement status of the finance nre agreement record in the finance domain.',
    `agreement_type` STRING COMMENT 'Category of NRE work covered by the agreement.. Valid values are `mask|design|qualification|combined`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement was approved.',
    `comments` STRING COMMENT 'Additional notes or remarks about the NRE agreement.',
    `contract_version` STRING COMMENT 'Version identifier for the NRE contract document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the NRE amount.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the finance nre agreement finance record.',
    `effective_from` DATE COMMENT 'Date when the NRE agreement becomes binding.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the finance nre agreement finance record.',
    `effective_until` DATE COMMENT 'Date when the NRE agreement ends, if applicable.',
    `finance_nre_agreement_status` STRING COMMENT 'Current lifecycle status of the NRE agreement.. Valid values are `draft|active|suspended|terminated|closed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the finance nre agreement record in the finance domain.',
    `legal_entity_code` STRING COMMENT 'Code of the legal entity within the corporation that owns the NRE agreement.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the finance nre agreement record in the finance domain.',
    `payment_milestone_schedule` STRING COMMENT 'Serialized representation of payment milestones and amounts.',
    `recovery_method` STRING COMMENT 'Method used to recover NRE costs from the customer.. Valid values are `upfront|royalty|hybrid`',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the agreement.. Valid values are `NAM|EMEA|APAC|LATAM`',
    `revenue_recognition_method` STRING COMMENT 'Accounting method for recognizing revenue from the NRE agreement.. Valid values are `percentage_of_completion|completed_contract|milestone_based`',
    `signed_date` DATE COMMENT 'The signed date associated with the finance nre agreement finance record.',
    `tax_regime` STRING COMMENT 'Tax treatment applicable to the NRE agreement.. Valid values are `standard|reduced|exempt`',
    `termination_reason` STRING COMMENT 'Reason for termination if the agreement status is terminated.',
    `total_nre_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the NRE agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    CONSTRAINT pk_finance_nre_agreement PRIMARY KEY(`finance_nre_agreement_id`)
) COMMENT 'Non-Recurring Engineering cost recovery agreement master tracking NRE contracts with fabless customers for ASIC/SoC design services, mask set costs, and process qualification. Captures NRE type (mask NRE, design NRE, qualification NRE), total NRE amount, payment milestone schedule, recovery method (upfront, volume-based royalty, hybrid), customer, product design reference, and revenue recognition method per ASC 606/IFRS 15. SSOT for NRE financial obligations distinct from recurring product sales.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` (
    `finance_nre_milestone_id` BIGINT COMMENT 'Unique identifier for the NRE milestone record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NRE milestones inherit the cost center from their parent agreement; FK makes the link explicit.',
    `order_nre_milestone_id` BIGINT COMMENT 'Cross-domain SSOT FK reference to authoritative owner.',
    `finance_nre_agreement_id` BIGINT COMMENT 'Identifier of the NRE agreement to which this milestone belongs.',
    `project_id` BIGINT COMMENT 'Identifier of the associated IC design project.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each NRE milestone is owned by a responsible engineer; the milestone record must reference that employee.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone was actually completed.',
    `actual_date` DATE COMMENT 'The actual date associated with the finance nre milestone finance record.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total gross monetary amount for the milestone before taxes or adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net monetary amount after tax and any adjustments.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component of the milestone amount.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the milestone for billing.',
    `billing_trigger` STRING COMMENT 'The billing trigger of the finance nre milestone record in the finance domain.',
    `billing_trigger_event` STRING COMMENT 'Event that triggers billing for the milestone.. Valid values are `milestone_achieved|percentage_complete|date_based`',
    `completion_date` DATE COMMENT 'The completion date associated with the finance nre milestone finance record.',
    `compliance_flag` STRING COMMENT 'Indicates whether the milestone record complies with SOX reporting requirements.. Valid values are `sox_compliant|non_sox`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `USD|EUR|JPY|CNY|KRW`',
    `due_date` DATE COMMENT 'The due date associated with the finance nre milestone finance record.',
    `expense_type` STRING COMMENT 'Classification of the expense for accounting purposes.. Valid values are `capital|expense|research|development`',
    `finance_nre_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `planned|in_progress|completed|invoiced|rejected|cancelled`',
    `invoice_status` STRING COMMENT 'Current status of the invoice associated with the milestone.. Valid values are `not_issued|issued|paid|rejected`',
    `is_revenue_recognized` BOOLEAN COMMENT 'Indicates whether revenue has been recognized for this milestone.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the finance nre milestone record in the finance domain.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'The milestone amount of the finance nre milestone record in the finance domain.',
    `milestone_code` STRING COMMENT 'Business identifier code for the milestone (e.g., M001).',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., RTL Freeze, Tapeout Submission).',
    `milestone_number` STRING COMMENT 'The milestone number of the finance nre milestone record in the finance domain.',
    `milestone_status` STRING COMMENT 'The milestone status of the finance nre milestone record in the finance domain.',
    `milestone_type` STRING COMMENT 'Category of the milestone within the NRE project lifecycle.. Valid values are `design|tapeout|first_silicon|qualification|production`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the finance nre milestone record in the finance domain.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the milestone.',
    `planned_completion_date` DATE COMMENT 'Date the milestone is scheduled to be completed.',
    `planned_date` DATE COMMENT 'The planned date associated with the finance nre milestone finance record.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue is recognized for the milestone per ASC 606.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for the milestone.. Valid values are `percentage_of_completion|milestone_based`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the milestone record.',
    CONSTRAINT pk_finance_nre_milestone PRIMARY KEY(`finance_nre_milestone_id`)
) COMMENT 'Individual billing milestone records within an NRE agreement tracking completion of design and engineering deliverables. Captures milestone name (RTL freeze, tapeout submission, first silicon, qualification pass), planned and actual completion date, milestone amount, billing trigger event, invoice status, and revenue recognition date. Enables ASC 606-compliant revenue recognition at point of performance obligation satisfaction for NRE contracts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'System-generated unique identifier for the budget plan record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget plans are defined per cost center, profit center, and WBS element. Adding explicit FK columns replaces the string codes and enables proper joins for reporting and allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the budget plan finance entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget plans belong to a profit center; the FK enables drill‑down of profit‑center level budgeting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Budget plans are linked to a WBS element for project‑level budgeting; the FK replaces the free‑text WBS code.',
    `approval_date` DATE COMMENT 'The approval date associated with the budget plan finance record.',
    `approval_status` STRING COMMENT 'Current approval state of the budget plan within the governance workflow.. Valid values are `draft|submitted|approved|rejected`',
    `budget_type` STRING COMMENT 'Classification of the budget (e.g., operating expense, capital expenditure, R&D investment, headcount).. Valid values are `operating|capital|r&d|headcount`',
    `chips_act_funding_indicator` BOOLEAN COMMENT 'True if the budget includes funding that is aligned with the US CHIPS Act grant requirements.',
    `compliance_regulation_flag` BOOLEAN COMMENT 'Indicates whether the budget plan complies with applicable regulatory requirements (e.g., SOX, CHIPS Act).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the budget plan record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the local amount.. Valid values are `USD|EUR|JPY|CNY|GBP|CAD`',
    `financial_reporting_standard` STRING COMMENT 'Accounting framework used for the budget plan (e.g., IFRS, US‑GAAP).. Valid values are `IFRS|GAAP|US-GAAP|IFRS-16`',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year to which the budget plan applies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the budget plan record in the finance domain.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the budget plan record.. Valid values are `active|inactive|closed|archived`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the budget plan record in the finance domain.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or explanations about the budget plan.',
    `organization_unit_code` STRING COMMENT 'Code identifying the cost or profit center, division, or legal entity responsible for the budget.',
    `plan_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget plan received final approval.',
    `plan_end_date` DATE COMMENT 'Date on which the budget period ends.',
    `plan_name` STRING COMMENT 'The plan name of the budget plan record in the finance domain.',
    `plan_number` STRING COMMENT 'External business identifier assigned to the budget plan, used for tracking and reporting.. Valid values are `^BP-[0-9]{4}-[0-9]{4}$`',
    `plan_start_date` DATE COMMENT 'Date on which the budget period begins.',
    `plan_status` STRING COMMENT 'The plan status of the budget plan record in the finance domain.',
    `plan_version` STRING COMMENT 'The plan version of the budget plan record in the finance domain.',
    `planned_amount_group` DECIMAL(18,2) COMMENT 'Budgeted monetary amount expressed in the corporate currency.',
    `planned_amount_local` DECIMAL(18,2) COMMENT 'Budgeted monetary amount expressed in the local operating currency.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Planned count or volume associated with the budget line (e.g., wafer starts, FTEs, machine hours).',
    `planning_method` STRING COMMENT 'Methodology used to develop the budget (e.g., top‑down, bottom‑up, rolling forecast, zero‑based).. Valid values are `top-down|bottom-up|rolling|zero-based`',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total budget amount of the budget plan record in the finance domain.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the planned quantity.. Valid values are `wafer_start|fte|machine_hour|unit`',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the budget plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the budget plan record.',
    `variance_to_prior_year_amount` DECIMAL(18,2) COMMENT 'Difference between the planned amount and the actual amount of the prior fiscal year, expressed in currency.',
    `variance_to_prior_year_percent` DECIMAL(18,2) COMMENT 'Percentage difference between the planned amount and the prior year actual amount.',
    `version_number` STRING COMMENT 'Incremental version of the plan to support revisions and audit trails.',
    `created_by` STRING COMMENT 'Identifier of the user who initially created the budget plan.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Annual and multi-year financial budget plan with granular line-item detail for the semiconductor enterprise. Header captures planning version, fiscal year, budget type (operating expense, capital expenditure, R&D investment, headcount), organizational unit (cost center, profit center, company code), planning method, and approval status. Line items (owned within this product) specify GL account/cost element, cost center or WBS element, fiscal period distribution, planned quantity (wafer starts, headcount FTEs, machine hours), planned amount in local and group currency, and variance to prior year. Supports fab capacity-based opex planning, technology node R&D investment roadmaps, CHIPS Act grant-aligned capex budgets, rolling forecasts, and period-level budget vs. actual variance analysis. Enables drill-down from plan header to individual cost element allocations. Sourced from SAP BPC/CO planning cycles.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'System-generated unique identifier for the budget line record.',
    `budget_plan_id` BIGINT COMMENT 'Identifier of the parent budget plan to which this line belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replace string codes with proper foreign keys to enable joins and enforce referential integrity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget line approvals are signed off by the cost‑center manager employee, linking budget lines to that manager.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace string codes with proper foreign keys to enable joins and enforce referential integrity.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Budget lines for compliance activities reference specific regulatory filings to track allocated spend.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Replace string codes with proper foreign keys to enable joins and enforce referential integrity.',
    `allocation_method` STRING COMMENT 'Method used to allocate the budget amount to the line.. Valid values are `direct|activity_based|percentage`',
    `approval_status` STRING COMMENT 'Current approval workflow state of the budget line.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User identifier of the approver.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the line was approved.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the budget line record in the finance domain.',
    `budget_category` STRING COMMENT 'High‑level classification of the budget line (e.g., capital expenditure, operating expense).. Valid values are `CAPEX|OPEX|R&D|SG&A`',
    `budget_line_status` STRING COMMENT 'Current lifecycle state of the budget line.. Valid values are `planned|approved|released|closed`',
    `compliance_flag` STRING COMMENT 'Indicates regulatory compliance relevance (e.g., SOX, SEC).. Valid values are `SOX|SEC|None`',
    `cost_center_manager` STRING COMMENT 'User identifier of the manager responsible for the cost center.',
    `cost_element_type` STRING COMMENT 'Nature of the cost element represented by the line.. Valid values are `material|labor|overhead|service`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency identifier for the monetary values.. Valid values are `^[A-Z]{3}$`',
    `budget_line_description` STRING COMMENT 'Free‑text description providing context for the budget line.',
    `effective_end_date` DATE COMMENT 'Optional date when the budget line ceases to be effective.',
    `effective_start_date` DATE COMMENT 'Date when the budget line becomes effective for accounting.',
    `fiscal_period` STRING COMMENT 'Month or period identifier within the fiscal year (01‑12). [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|08|09|10|11|12 — 12 candidates stripped; promote to reference product]',
    `fiscal_year` STRING COMMENT 'Four‑digit year to which the budget line is allocated.',
    `is_frozen` BOOLEAN COMMENT 'Indicates whether the line is locked from further edits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the budget line record in the finance domain.',
    `line_description` STRING COMMENT 'The line description of the budget line record in the finance domain.',
    `line_number` STRING COMMENT 'The line number of the budget line record in the finance domain.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the budget document.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the budget line record in the finance domain.',
    `period` STRING COMMENT 'The period of the budget line record in the finance domain.',
    `period_month` STRING COMMENT 'The period month of the budget line record in the finance domain.',
    `period_year` STRING COMMENT 'The period year of the budget line record in the finance domain.',
    `planned_amount` DECIMAL(18,2) COMMENT 'Budgeted monetary amount for the line, expressed in the lines currency.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Forecasted amount of the resource (e.g., wafer starts, FTEs) for the period.',
    `planned_quantity_unit` STRING COMMENT 'Unit of measure for the planned quantity.. Valid values are `wafer|FTE|unit|kg|m`',
    `related_project_code` STRING COMMENT 'Identifier of the project or program associated with the line.',
    `revision_number` STRING COMMENT 'Version counter for changes to the budget line.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the budget line.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual spend and planned amount (actual – planned).',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance calculated as (variance_amount / planned_amount) * 100.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line items within a budget plan capturing granular cost element-level budget allocations. Each line specifies GL account/cost element, cost center or WBS element, fiscal period distribution, planned quantity (e.g., wafer starts, headcount FTEs), planned amount, and variance to prior year. Enables period-level budget vs. actual variance analysis for fab operations, R&D programs, and SG&A functions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` (
    `rd_capitalization_id` BIGINT COMMENT 'System-generated unique identifier for each R&D capitalization event record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the rd capitalization finance entity.',
    `design_ip_core_id` BIGINT COMMENT 'Reference to the IP core whose development costs were capitalized.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the asset‑under‑construction record that receives the capitalized cost.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the rd capitalization finance entity.',
    `internal_order_id` BIGINT COMMENT 'Unique identifier for the internal order record within the rd capitalization finance entity.',
    `project_id` BIGINT COMMENT 'Reference to the R&D project that generated the expense.',
    `reversal_of_capitalization_rd_capitalization_id` BIGINT COMMENT 'If this record is a reversal, references the original capitalization record.',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element.wbs_element_id — R&D capitalization events reference the WBS element whose costs are being capitalized. Required for project-to-asset reclassification audit trail.',
    `amortization_period_months` STRING COMMENT 'The amortization period months of the rd capitalization record in the finance domain.',
    `amortization_schedule_id` BIGINT COMMENT 'Reference to the amortization schedule applied to the capitalized amount.',
    `amortization_start_date` DATE COMMENT 'The amortization start date associated with the rd capitalization finance record.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the auditor approved the capitalization.',
    `auditor_approval_status` STRING COMMENT 'Result of the internal or external audit review of the capitalization.. Valid values are `approved|rejected|pending`',
    `auditor_name` STRING COMMENT 'Name of the auditor who approved or rejected the capitalization.',
    `capitalization_date` DATE COMMENT 'Date on which the expense was officially capitalized.',
    `capitalization_event_number` STRING COMMENT 'External reference number assigned to the capitalization event for tracking across systems.',
    `capitalization_period` STRING COMMENT 'The capitalization period of the rd capitalization record in the finance domain.',
    `capitalization_status` STRING COMMENT 'The capitalization status of the rd capitalization record in the finance domain.',
    `capitalized_amount` DECIMAL(18,2) COMMENT 'Portion of the original expense reclassified as a capitalized asset.',
    `capitalized_asset_type` STRING COMMENT 'Category of the asset created by the capitalization.. Valid values are `intangible|development_cost|equipment|process_node`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the capitalization (e.g., ASC 730, IAS 38).. Valid values are `asc_730|ias_38|sox|sec`',
    `cost_element` STRING COMMENT 'Accounting cost element used for the original expense.',
    `created_by_user` STRING COMMENT 'User identifier who initially loaded the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the amounts.',
    `depreciation_method` STRING COMMENT 'Method used to depreciate the capitalized asset.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the capitalized asset begins.',
    `rd_capitalization_description` STRING COMMENT 'Free‑form description of the capitalization event and rationale.',
    `effective_end_date` DATE COMMENT 'Date when the capitalized asset is retired or fully amortized (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the capitalized asset becomes effective for accounting purposes.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the capitalization event was recorded in the source system.',
    `expensed_amount` DECIMAL(18,2) COMMENT 'The expensed amount of the rd capitalization record in the finance domain.',
    `external_audit_flag` BOOLEAN COMMENT 'Indicates whether an external auditor has reviewed the event.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the capitalization belongs.',
    `internal_audit_flag` BOOLEAN COMMENT 'Indicates whether an internal audit has reviewed the event.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this record reverses a prior capitalization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the rd capitalization record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the rd capitalization record in the finance domain.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations.',
    `original_expense_amount` DECIMAL(18,2) COMMENT 'Amount originally expensed before capitalization, in the transaction currency.',
    `profit_center_code` STRING COMMENT 'Profit center associated with the expense, if applicable.',
    `rd_capitalization_status` STRING COMMENT 'Current processing status of the capitalization event.. Valid values are `pending|approved|rejected|reversed`',
    `related_ip_core_name` STRING COMMENT 'Human‑readable name of the related IP core.',
    `technology_readiness_level` STRING COMMENT 'Readiness level of the technology at the time of capitalization (e.g., TRL 1‑9). [ENUM-REF-CANDIDATE: trl_1|trl_2|trl_3|trl_4|trl_5|trl_6|trl_7|trl_8|trl_9 — promote to reference product]',
    `updated_by_user` STRING COMMENT 'User identifier who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `useful_life_years` STRING COMMENT 'Estimated useful life of the capitalized asset in years.',
    CONSTRAINT pk_rd_capitalization PRIMARY KEY(`rd_capitalization_id`)
) COMMENT 'R&D capitalization event record tracking the reclassification of qualifying R&D expenditures to intangible assets or capitalized development costs per ASC 730/IAS 38. Captures project WBS element, cost element, original expense amount, capitalized amount, capitalization date, asset under construction reference, technology readiness level at capitalization, and auditor approval. Specific to semiconductor companies capitalizing process node development and IP core creation costs.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the intercompany transaction record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transactions are posted to a cost center for internal reporting; the FK replaces the free‑text code.',
    `intercompany_agreement_id` BIGINT COMMENT 'Identifier of the master intercompany agreement governing this transaction.',
    `journal_entry_id` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Every intercompany transaction generates journal entries in both sending and receiving company codes. This FK enables reconciliation and elimination during consolidation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intercompany transactions also affect a profit center; the FK enables profit‑center level analysis.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the source legal entity record within the intercompany transaction finance entity.',
    `target_legal_entity_id` BIGINT COMMENT 'Unique identifier for the target legal entity record within the intercompany transaction finance entity.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the intercompany transaction record in the finance domain.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before taxes, fees, or adjustments, expressed in the transaction currency.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net amount after tax and adjustments, the amount to be settled.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component of the transaction amount.',
    `audit_documentation_ref` STRING COMMENT 'Reference to supporting audit documentation for the transaction.',
    `country_of_jurisdiction` STRING COMMENT 'Three‑letter ISO country code of the tax jurisdiction governing the transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the transaction.',
    `intercompany_transaction_description` STRING COMMENT 'Free‑text description of the transaction purpose or notes.',
    `effective_from` DATE COMMENT 'Start date of the transactions validity period.',
    `effective_until` DATE COMMENT 'End date of the transactions validity period (null if open‑ended).',
    `elimination_flag` BOOLEAN COMMENT 'Indicates whether the transaction should be eliminated during financial consolidation.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the transaction is booked.',
    `interco_to_sending_company` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Intercompany transactions must identify sending and receiving company codes. Required for elimination and transfer pricing compliance.',
    `intercompany_transaction_status` STRING COMMENT 'Current lifecycle status of the transaction.. Valid values are `draft|open|posted|closed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the intercompany transaction record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the intercompany transaction record in the finance domain.',
    `receiving_entity_code` STRING COMMENT 'Company code or legal entity identifier of the receiver in the intercompany transaction.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the transaction must be included in country‑by‑country (CbC) reporting.',
    `sending_entity_code` STRING COMMENT 'Company code or legal entity identifier of the sender in the intercompany transaction.',
    `tax_code` STRING COMMENT 'Tax code applicable to the transaction for VAT/GST purposes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The transaction amount of the intercompany transaction record in the finance domain.',
    `transaction_date` DATE COMMENT 'The transaction date associated with the intercompany transaction finance record.',
    `transaction_number` STRING COMMENT 'Business-visible transaction number assigned by the source ERP system.',
    `transaction_status` STRING COMMENT 'The transaction status of the intercompany transaction record in the finance domain.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction was recorded in the source system.',
    `transaction_type` STRING COMMENT 'Category of the intercompany transaction.. Valid values are `intercompany_loan|transfer_pricing_charge|royalty|shared_service_allocation|intercompany_sale`',
    `transfer_pricing_document_ref` STRING COMMENT 'Reference identifier to the supporting OECD transfer‑pricing documentation.',
    `transfer_pricing_margin` DECIMAL(18,2) COMMENT 'Margin applied when the cost‑plus method is used, expressed as a percentage.',
    `transfer_pricing_method` STRING COMMENT 'Method used to determine the arms‑length price for the intercompany transaction.. Valid values are `cost_plus|comparable_uncontrolled_price|resale_price|tnmm`',
    `transfer_pricing_rate` DECIMAL(18,2) COMMENT 'Rate (percentage or per‑unit) applied under the selected transfer pricing method.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction records with embedded transfer pricing governance for semiconductor enterprises with multi-entity structures (design center subsidiaries, fab entities, OSAT affiliates, IP holding companies). Transaction records capture sending/receiving company codes, transaction type (intercompany loan, transfer pricing charge, royalty, shared service allocation, intercompany sale of wafers/dies), amount, currency, elimination flag, and transfer pricing documentation reference. Transfer pricing master configuration embedded within: pricing method (cost-plus, CUP, resale price, TNMM), applicable entity pair, product/service category, price or margin rate, validity period, arms length documentation, and OECD documentation reference. Supports financial consolidation elimination, OECD transfer pricing compliance, country-by-country reporting under BEPS Action 13, and tax authority audit defense.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` (
    `consolidation_entry_id` BIGINT COMMENT 'System-generated unique identifier for the consolidation adjustment entry.',
    `consolidation_group_id` BIGINT COMMENT 'Identifier of the consolidation group (e.g., reporting entity) to which the entry belongs.',
    `consolidation_unit_id` BIGINT COMMENT 'Identifier of the legal entity or business unit that is the source of the consolidation entry.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the consolidation entry finance entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consolidation entries are aggregated per profit center; the FK ties each entry to its profit‑center owner.',
    `related_entry_consolidation_entry_id` BIGINT COMMENT 'Identifier of a related entry, such as the original entry for a reversal.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consolidation entry record in the finance domain.',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Net adjustment amount (e.g., elimination, translation gain/loss) applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before any adjustments or netting, expressed in the entry currency.',
    `amount_net` DECIMAL(18,2) COMMENT 'Resulting amount after applying adjustments, the amount that impacts the consolidated financial statements.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the entry received formal approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the consolidation entry.',
    `consolidation_entry_status` STRING COMMENT 'Current lifecycle status of the entry.. Valid values are `draft|posted|reversed|cancelled`',
    `consolidation_method` STRING COMMENT 'Methodology used for the consolidation (e.g., full consolidation, proportionate, equity method, cost method).. Valid values are `full|proportionate|equity|cost`',
    `consolidation_to_company` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Consolidation entries reference the consolidation unit (company code) being consolidated. Required for.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the entry (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `consolidation_entry_description` STRING COMMENT 'Free‑text description providing context or rationale for the entry.',
    `effective_date` DATE COMMENT 'Date from which the consolidation adjustment becomes effective for reporting.',
    `elimination_flag` BOOLEAN COMMENT 'The elimination flag of the consolidation entry record in the finance domain.',
    `entry_number` STRING COMMENT 'Business-visible sequential number assigned to the consolidation entry.',
    `entry_status` STRING COMMENT 'The entry status of the consolidation entry record in the finance domain.',
    `entry_type` STRING COMMENT 'Category of the consolidation adjustment (e.g., elimination of intercompany profit, minority interest, currency translation, goodwill amortization).. Valid values are `elimination|minority_interest|currency_translation|goodwill_amortization|other`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied for currency translation adjustments.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was determined.',
    `fiscal_period` STRING COMMENT 'Numeric period within the fiscal year (e.g., month number 1‑12).',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the entry is posted.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this entry is a reversal of a prior consolidation entry.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consolidation entry record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the consolidation entry record in the finance domain.',
    `period` STRING COMMENT 'The period of the consolidation entry record in the finance domain.',
    `posting_date` DATE COMMENT 'Date on which the consolidation entry is posted to the group ledger.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the consolidation entry.',
    CONSTRAINT pk_consolidation_entry PRIMARY KEY(`consolidation_entry_id`)
) COMMENT 'Financial consolidation adjustment entries for group-level reporting of the semiconductor enterprise. Captures consolidation unit, consolidation group, entry type (elimination of intercompany profit, minority interest adjustment, currency translation adjustment, goodwill amortization), fiscal period, and consolidation method. Supports SOX-compliant group financial statements under US GAAP or IFRS. Generated during period-end close in SAP FC/BPC consolidation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` (
    `standard_cost_id` BIGINT COMMENT 'Unique surrogate key for each standard cost record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Standard costs reference production cost centers for labor and overhead rate determination. Links cost model to organizational cost structure.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cost model ownership is assigned to a specific employee for governance and audit of standard costs.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Cost models must incorporate export classification (ECCN) to allocate compliance‑related costs accurately.',
    `equipment_fab_id` BIGINT COMMENT 'Code of the fab where the cost model is applied.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Identifier of the fab process flow associated with this cost.',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - standard costs are defined per product',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the standard cost finance entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Standard cost records are defined per profit center; the FK enables cost‑to‑profit‑center mapping.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the standard cost finance entity.',
    `allocation_method` STRING COMMENT 'Rule used to allocate shared costs to the product.. Valid values are `per_wafer|per_die|percentage`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the standard cost record in the finance domain.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost record received formal approval.',
    `approved_by` STRING COMMENT 'Identifier of the individual who approved the cost record.',
    `cost_basis` STRING COMMENT 'Methodology used to value inventory for cost calculation.. Valid values are `FIFO|LIFO|WeightedAverage`',
    `cost_calculation_method` STRING COMMENT 'Approach used to compute the standard cost (bottom‑up or top‑down).. Valid values are `bottom_up|top_down`',
    `cost_category` STRING COMMENT 'High‑level classification of the cost component.. Valid values are `material|labor|equipment|overhead|packaging`',
    `cost_component` STRING COMMENT 'The cost component of the standard cost record in the finance domain.',
    `cost_model_description` STRING COMMENT 'Narrative description of the cost model methodology.',
    `cost_per_good_die` DECIMAL(18,2) COMMENT 'Yield‑adjusted cost allocated to each functional die.',
    `cost_status` STRING COMMENT 'Current lifecycle status of the cost record.. Valid values are `active|inactive|archived`',
    `cost_type` STRING COMMENT 'Indicates whether the cost is a standard, actual, or forecast figure.. Valid values are `standard|actual|forecast`',
    `cost_version` STRING COMMENT 'Version label of the cost record, typically reflecting fiscal period or revision cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency identifier for all monetary amounts.',
    `die_size_um2` DECIMAL(18,2) COMMENT 'Area of a single die on the wafer in square micrometers.',
    `dies_per_wafer` STRING COMMENT 'Number of dies that can be placed on a wafer before yield adjustment.',
    `effective_date` DATE COMMENT 'Date on which the standard cost becomes effective for accounting.',
    `equipment_depreciation_per_wafer` DECIMAL(18,2) COMMENT 'Depreciation expense of fab equipment allocated to each wafer pass.',
    `expiration_date` DATE COMMENT 'Date on which the standard cost is superseded or retired.',
    `fab_overhead_rate` DECIMAL(18,2) COMMENT 'Rate for indirect fab costs (utilities, cleanroom, indirect labor) applied per wafer.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the standard cost record in the finance domain.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the cost record is currently active for costing.',
    `labor_cost` DECIMAL(18,2) COMMENT 'The labor cost of the standard cost record in the finance domain.',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Hourly labor cost applied to wafer processing activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the standard cost record in the finance domain.',
    `last_review_date` DATE COMMENT 'Date of the most recent cost review cycle.',
    `mask_set_cost` DECIMAL(18,2) COMMENT 'Amortized cost of photomasks for the product run.',
    `material_cost` DECIMAL(18,2) COMMENT 'The material cost of the standard cost record in the finance domain.',
    `material_cost_per_wafer` DECIMAL(18,2) COMMENT 'Direct material expense (silicon, chemicals, gases) allocated per wafer.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the standard cost record in the finance domain.',
    `notes` STRING COMMENT 'Additional remarks or comments about the cost record.',
    `overhead_cost` DECIMAL(18,2) COMMENT 'The overhead cost of the standard cost record in the finance domain.',
    `packaging_cost_per_die` DECIMAL(18,2) COMMENT 'Cost of packaging (die‑attach, encapsulation, testing) allocated per finished die.',
    `product_code` STRING COMMENT 'External part number or SKU used to identify the semiconductor product.',
    `product_family` STRING COMMENT 'High‑level family grouping of the semiconductor product.',
    `product_line` STRING COMMENT 'Specific product line within the family.',
    `revision_number` STRING COMMENT 'Sequential revision number for change tracking.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Planned percentage of good dies per wafer after processing.',
    `technology_node` STRING COMMENT 'Process technology node (e.g., 7nm, 14nm) for which the cost is defined.',
    `total_wafer_cost` DECIMAL(18,2) COMMENT 'Sum of all cost components for a single wafer before yield adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cost record.',
    `usd` DECIMAL(18,2) COMMENT 'The usd of the standard cost record in the finance domain.',
    `variance_reason` STRING COMMENT 'Explanation for any deviation from prior cost version.',
    `wafer_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of the silicon wafer in millimeters.',
    `valid_from` DATE COMMENT 'The valid from of the standard cost record in the finance domain.',
    `valid_to` DATE COMMENT 'The valid to of the standard cost record in the finance domain.',
    CONSTRAINT pk_standard_cost PRIMARY KEY(`standard_cost_id`)
) COMMENT 'Standard cost master for semiconductor products defining the pre-determined cost build-up for wafers, dies, and packaged chips at each technology node and process flow. Encompasses full wafer cost modeling: process node, wafer diameter, die size, target yield, mask set cost amortization, direct materials (silicon wafers, chemicals, gases, photomasks), direct labor rate, machine cost (equipment depreciation per wafer pass, maintenance allocation), fab overhead rate (utilities, cleanroom, indirect labor), and fully-loaded cost per wafer out. Calculates yield-adjusted cost per good die and packaging cost for finished product costing. Used as the basis for inventory valuation (ASC 330), COGS determination, manufacturing variance analysis (price/usage/efficiency/yield), product pricing decisions, NRE recovery planning, and fab utilization-based cost allocation. Updated each fiscal year during standard cost roll with quarterly variance reviews. Sourced from SAP CO-PC product costing.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` (
    `transfer_price_id` BIGINT COMMENT 'System-generated unique identifier for the transfer price master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transfer‑price agreements require an approving employee; the FK records who approved each price.',
    `intercompany_agreement_id` BIGINT COMMENT 'Unique identifier for the intercompany agreement record within the transfer price finance entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Transfer price agreements are typically managed at the profit‑center level; linking to profit_center provides proper ownership and reporting.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the transfer price finance entity.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the source legal entity record within the transfer price finance entity.',
    `target_legal_entity_id` BIGINT COMMENT 'Unique identifier for the target legal entity record within the transfer price finance entity.',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the intercompany pricing agreement.',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement method (e.g., cost-plus, comparable uncontrolled price, resale, transactional net margin method).. Valid values are `cost_plus|comparable|resale|tnmm`',
    `allocation_basis` STRING COMMENT 'Basis on which the transfer price is allocated (e.g., volume, value).. Valid values are `volume|value|weight|capacity`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the transfer price record in the finance domain.',
    `approval_by` STRING COMMENT 'Identifier of the user or approver who authorized the agreement.',
    `approval_status` STRING COMMENT 'Current approval state of the transfer pricing agreement.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the agreement received its latest approval decision.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement complies with BEPS Action 13 and local tax regulations.',
    `cost_component` STRING COMMENT 'Cost element used in the price calculation (e.g., material, labor, overhead).. Valid values are `material|labor|overhead|equipment|facility`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the transfer price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the price amount.. Valid values are `[A-Z]{3}`',
    `transfer_price_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and key terms of the transfer pricing agreement.',
    `effective_date` DATE COMMENT 'The effective date associated with the transfer price finance record.',
    `effective_from` DATE COMMENT 'Date on which the transfer pricing agreement becomes binding.',
    `effective_price_per_unit` DECIMAL(18,2) COMMENT 'Calculated price per unit of product or service after applying the method and margin.',
    `effective_until` DATE COMMENT 'Date on which the transfer pricing agreement expires or is superseded (null if open‑ended).',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the transfer price is subject to tax in the jurisdiction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the transfer price record in the finance domain.',
    `last_review_date` DATE COMMENT 'Date when the agreement was last reviewed for compliance or market changes.',
    `margin_rate` DECIMAL(18,2) COMMENT 'Target profit margin percentage applied to the cost base, expressed as a percent.',
    `markup_percent` DECIMAL(18,2) COMMENT 'The markup percent of the transfer price record in the finance domain.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The markup percentage of the transfer price record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the transfer price record in the finance domain.',
    `next_review_date` DATE COMMENT 'Planned date for the next compliance or market review of the agreement.',
    `notes` STRING COMMENT 'Supplementary remarks or comments related to the agreement.',
    `oecd_document_reference` STRING COMMENT 'Reference identifier to the OECD documentation supporting the transfer pricing methodology.',
    `price_amount` DECIMAL(18,2) COMMENT 'Monetary amount agreed for the transfer of the product or service.',
    `price_method` STRING COMMENT 'Method used to calculate the transfer price for the agreement.. Valid values are `cost_plus|comparable|resale|tnmm`',
    `product_category` STRING COMMENT 'Category of the transferred product (e.g., wafer, die, IP core, shared service).. Valid values are `wafer|die|ip|service`',
    `related_document_reference` BIGINT COMMENT 'Reference to supporting documentation (e.g., contract, audit file).',
    `service_category` STRING COMMENT 'Category of the transferred service when applicable.. Valid values are `design|testing|assembly|logistics`',
    `source_entity_code` STRING COMMENT 'Internal code of the legal entity that provides the product or service for the transfer price.',
    `target_entity_code` STRING COMMENT 'Internal code of the legal entity that receives the product or service under the transfer price.',
    `tax_jurisdiction_code` STRING COMMENT 'Three‑letter country code indicating the tax jurisdiction governing the transaction.. Valid values are `[A-Z]{3}`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Statutory tax rate applied to the transfer price, expressed as a percent.',
    `transfer_price_status` STRING COMMENT 'Current lifecycle state of the transfer pricing agreement.. Valid values are `active|inactive|draft|terminated|pending`',
    `transfer_price_type` STRING COMMENT 'Specifies whether the price applies to a product, service, or royalty arrangement.. Valid values are `product|service|royalty`',
    `unit_of_measure` STRING COMMENT 'Unit in which the effective price is expressed.. Valid values are `per_watt|per_die|per_mm2|per_unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the transfer price record.',
    `usd` DECIMAL(18,2) COMMENT 'The usd of the transfer price record in the finance domain.',
    `version_number` BIGINT COMMENT 'Sequential version identifier for change‑tracking of the agreement.',
    `valid_from` DATE COMMENT 'The valid from of the transfer price record in the finance domain.',
    `valid_to` DATE COMMENT 'The valid to of the transfer price record in the finance domain.',
    CONSTRAINT pk_transfer_price PRIMARY KEY(`transfer_price_id`)
) COMMENT 'Transfer pricing master records governing intercompany pricing of wafers, dies, IP royalties, and shared services between semiconductor group entities. Captures transfer pricing method (cost-plus, comparable uncontrolled price, resale price, TNMM), applicable entity pair, product or service category, price or margin rate, validity period, and OECD documentation reference. Supports tax-compliant intercompany transactions and country-by-country reporting under BEPS Action 13.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` (
    `tax_provision_id` BIGINT COMMENT 'System-generated unique identifier for the tax provision record.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the tax provision finance entity.',
    `journal_entry_id` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Tax provisions are booked as journal entries (current tax expense, deferred tax adjustments). Links tax calculation to GL posting for audit trail.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) to which the tax provision applies.',
    `primary_prior_period_tax_provision_id` BIGINT COMMENT 'Self-referencing FK on tax_provision (prior_period_tax_provision_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax provisions are recorded against a profit center for tax reporting; the FK replaces any ad‑hoc profit‑center reference.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the tax provision record in the finance domain.',
    `approval_status` STRING COMMENT 'Approval workflow status of the tax provision.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the tax provision.',
    `closure_date` DATE COMMENT 'Date when the tax provision was closed or finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `deferred_tax_asset_amount` DECIMAL(18,2) COMMENT 'Amount of deferred tax assets arising from temporary differences.',
    `deferred_tax_liability_amount` DECIMAL(18,2) COMMENT 'Amount of deferred tax liabilities arising from temporary differences.',
    `effective_from` DATE COMMENT 'Start date when the tax provision becomes effective.',
    `effective_tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate after reconciling statutory rates and tax provisions.',
    `effective_until` DATE COMMENT 'End date when the tax provision expires or is superseded.',
    `fiscal_period` STRING COMMENT 'Fiscal period (quarter) within the fiscal year.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the tax provision relates.',
    `jurisdiction` STRING COMMENT 'The jurisdiction of the tax provision record in the finance domain.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO 3166‑1 code representing the tax jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the tax provision record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tax provision record in the finance domain.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the tax provision.',
    `pretax_income` DECIMAL(18,2) COMMENT 'The pretax income of the tax provision record in the finance domain.',
    `provision_amount` DECIMAL(18,2) COMMENT 'The provision amount of the tax provision record in the finance domain.',
    `provision_date` TIMESTAMP COMMENT 'Date and time when the tax provision was generated or became effective.',
    `provision_number` STRING COMMENT 'Business identifier or reference number assigned to the tax provision.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this record represents a reversal of a prior provision.',
    `revision_number` STRING COMMENT 'Sequential revision identifier for audit purposes.',
    `tax_account_code` STRING COMMENT 'General ledger account code used for posting the tax provision.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'Monetary amount on which the tax rate is applied.',
    `tax_credit_carryforward_amount` DECIMAL(18,2) COMMENT 'Unutilized tax credits carried forward to future periods.',
    `tax_credit_used_amount` DECIMAL(18,2) COMMENT 'Portion of tax credits applied in the current period.',
    `tax_expense_amount` DECIMAL(18,2) COMMENT 'Current period tax expense recognized in the income statement.',
    `tax_explanation` STRING COMMENT 'Narrative explanation of the tax provision calculation or adjustments.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction of the tax provision record in the finance domain.',
    `tax_law_reference` STRING COMMENT 'Reference to the governing tax law or regulation (e.g., ASC 740, IAS 12).',
    `tax_provision_status` STRING COMMENT 'Current lifecycle status of the tax provision.. Valid values are `draft|pending|approved|rejected|closed`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Statutory tax rate applied to the tax base, expressed as a percentage.',
    `tax_rate_change_indicator` BOOLEAN COMMENT 'Flag indicating whether the tax rate changed during the period.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent of the tax provision record in the finance domain.',
    `tax_regulation_code` STRING COMMENT 'Internal code representing the specific tax regulation applicable.',
    `tax_type` STRING COMMENT 'Classification of the tax provision (current tax, deferred tax, or both).. Valid values are `current|deferred|both`',
    `taxable_income` DECIMAL(18,2) COMMENT 'The taxable income of the tax provision record in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax provision record.',
    `version` STRING COMMENT 'Version number of the tax provision record for change tracking.',
    CONSTRAINT pk_tax_provision PRIMARY KEY(`tax_provision_id`)
) COMMENT 'Tax provision and deferred tax asset/liability tracking for the semiconductor enterprise. Captures current tax expense, deferred tax positions arising from temporary differences (accelerated depreciation on fab equipment, R&D credit carryforwards, CHIPS Act incentive tax treatment, unrealized intercompany profits), effective tax rate reconciliation, uncertain tax positions (ASC 740/IAS 12), and country-by-country tax allocation. Essential for semiconductor companies with global operations, significant R&D tax credits, and complex transfer pricing structures.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` (
    `depreciation_run_id` BIGINT COMMENT 'Primary key for depreciation_run',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the depreciation run finance entity.',
    `employee_id` BIGINT COMMENT 'User who originally created the depreciation run record.',
    `depreciation_employee_id` BIGINT COMMENT 'Identifier of the user who triggered the depreciation run.',
    `depreciation_executed_by_employee_id` BIGINT COMMENT 'Unique identifier for the depreciation executed by employee record within the depreciation run finance entity.',
    `depreciation_updated_by_user_employee_id` BIGINT COMMENT 'User who last modified the depreciation run record.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record within the depreciation run finance entity.',
    `reversal_depreciation_run_id` BIGINT COMMENT 'Self-referencing FK on depreciation_run (reversal_depreciation_run_id)',
    `asset_count` STRING COMMENT 'Number of individual assets included in the depreciation calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the depreciation run record in the finance domain.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values in the run.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation for the run.',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Rate applied in the depreciation calculation (e.g., 0.2000 for 20%).',
    `depreciation_run_status` STRING COMMENT 'Current processing state of the depreciation run.',
    `depreciation_tax_adjustment` DECIMAL(18,2) COMMENT 'Tax or regulatory adjustments applied to the gross depreciation amount.',
    `error_message` STRING COMMENT 'Technical or business error details captured if the run fails.',
    `fiscal_period` STRING COMMENT 'The fiscal period of the depreciation run record in the finance domain.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the depreciation run record in the finance domain.',
    `is_manual_override` BOOLEAN COMMENT 'True if the run was manually forced or adjusted by a user.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the depreciation run record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the depreciation run record in the finance domain.',
    `net_depreciation_amount` DECIMAL(18,2) COMMENT 'Final depreciation expense after adjustments, used for financial reporting.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the processing team.',
    `period` STRING COMMENT 'The period of the depreciation run record in the finance domain.',
    `period_end_date` DATE COMMENT 'Last day of the accounting period covered by the run.',
    `period_start_date` DATE COMMENT 'First day of the accounting period covered by the run.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the depreciation run record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the depreciation run record.',
    `run_code` STRING COMMENT 'Human‑readable code assigned to the depreciation run for external reference.',
    `run_date` DATE COMMENT 'The run date associated with the depreciation run finance record.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the depreciation run finished execution.',
    `run_number` STRING COMMENT 'The run number of the depreciation run record in the finance domain.',
    `run_period` STRING COMMENT 'The run period of the depreciation run record in the finance domain.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the depreciation run started execution.',
    `run_status` STRING COMMENT 'The run status of the depreciation run record in the finance domain.',
    `run_type` STRING COMMENT 'Indicates whether the run is a full depreciation, incremental update, or a manual adjustment.',
    `run_version` STRING COMMENT 'Version identifier of the depreciation engine or configuration used.',
    `schedule_frequency` STRING COMMENT 'How often the depreciation schedule repeats.',
    `schedule_name` STRING COMMENT 'Name of the predefined schedule applied to the run.',
    `total_accumulated_depreciation` DECIMAL(18,2) COMMENT 'Cumulative depreciation recorded for the assets before this run.',
    `total_book_value` DECIMAL(18,2) COMMENT 'Sum of original acquisition costs for all assets in the run.',
    `total_depreciation_amount` DECIMAL(18,2) COMMENT 'Aggregate depreciation expense calculated by the run before any adjustments.',
    CONSTRAINT pk_depreciation_run PRIMARY KEY(`depreciation_run_id`)
) COMMENT 'Master reference table for depreciation_run. Referenced by depreciation_run_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` (
    `consolidation_unit_id` BIGINT COMMENT 'Primary key for consolidation_unit',
    `consolidation_group_id` BIGINT COMMENT 'Unique identifier for the consolidation group record within the consolidation unit finance entity.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that owns the consolidation unit.',
    `parent_consolidation_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit in the consolidation hierarchy.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the responsible employee record within the consolidation unit finance entity.',
    `consolidation_unit_code` STRING COMMENT 'Business identifier code assigned to the consolidation unit.',
    `consolidation_method` STRING COMMENT 'Method used to consolidate the units financials.',
    `consolidation_unit_status` STRING COMMENT 'Current lifecycle status of the consolidation unit.',
    `consolidation_unit_type` STRING COMMENT 'Category that defines the nature of the consolidation unit.',
    `consolidation_weight` DECIMAL(18,2) COMMENT 'Weight factor applied during proportional consolidation calculations.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the unit.',
    `country_code` STRING COMMENT 'Coded value representing the country code of the consolidation unit finance record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation unit record was first created in the system.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the consolidation unit finance record.',
    `consolidation_unit_description` STRING COMMENT 'Free‑form description providing additional context about the unit.',
    `effective_end_date` DATE COMMENT 'Date when the consolidation unit ceases to be effective (nullable for open‑ended).',
    `effective_from` DATE COMMENT 'The effective from of the consolidation unit record in the finance domain.',
    `effective_start_date` DATE COMMENT 'Date when the consolidation unit becomes effective for reporting.',
    `effective_until` DATE COMMENT 'The effective until of the consolidation unit record in the finance domain.',
    `external_reference_code` STRING COMMENT 'Identifier used to map the unit to external ERP or reporting systems.',
    `financial_reporting_frequency` STRING COMMENT 'Frequency at which the unit reports its financial results.',
    `hierarchy_level` STRING COMMENT 'Depth level of the unit within the consolidation hierarchy (0 = top level).',
    `is_active` BOOLEAN COMMENT 'The is active of the consolidation unit record in the finance domain.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the unit is included in external financial reporting.',
    `last_consolidation_date` DATE COMMENT 'Date of the most recent consolidation run for this unit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consolidation unit record in the finance domain.',
    `local_currency_code` STRING COMMENT 'Coded value representing the local currency code of the consolidation unit finance record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the consolidation unit record in the finance domain.',
    `consolidation_unit_name` STRING COMMENT 'Human‑readable name of the consolidation unit used in financial reporting.',
    `next_consolidation_due_date` DATE COMMENT 'Planned date for the next scheduled consolidation.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the unit.',
    `ownership_percent` DECIMAL(18,2) COMMENT 'The ownership percent of the consolidation unit record in the finance domain.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The ownership percentage of the consolidation unit record in the finance domain.',
    `reporting_currency` STRING COMMENT 'Currency in which the unit reports its financials, using ISO 4217 codes.',
    `reporting_currency_code` STRING COMMENT 'Coded value representing the reporting currency code of the consolidation unit finance record.',
    `segment_code` STRING COMMENT 'Code representing the business segment to which the unit belongs.',
    `tax_jurisdiction_code` STRING COMMENT 'Two‑letter code of the tax jurisdiction applicable to the unit.',
    `unit_code` STRING COMMENT 'Coded value representing the unit code of the consolidation unit finance record.',
    `unit_name` STRING COMMENT 'The unit name of the consolidation unit record in the finance domain.',
    `updated_by` STRING COMMENT 'User identifier who last modified the consolidation unit record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consolidation unit record.',
    `created_by` STRING COMMENT 'User identifier who created the consolidation unit record.',
    CONSTRAINT pk_consolidation_unit PRIMARY KEY(`consolidation_unit_id`)
) COMMENT 'Master reference table for consolidation_unit. Referenced by consolidation_unit_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` (
    `consolidation_group_id` BIGINT COMMENT 'Primary key for consolidation_group',
    `employee_id` BIGINT COMMENT 'Unique identifier for the consolidation responsible employee record within the consolidation group finance entity.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the consolidation group finance entity.',
    `parent_consolidation_group_id` BIGINT COMMENT 'Self-referencing FK on consolidation_group (parent_consolidation_group_id)',
    `parent_group_id` BIGINT COMMENT 'Identifier of the parent consolidation group for hierarchical grouping.',
    `consolidation_group_code` STRING COMMENT 'Coded value representing the code of the consolidation group finance record.',
    `consolidation_group_status` STRING COMMENT 'Current lifecycle status of the consolidation group.',
    `consolidation_method` STRING COMMENT 'Method used to consolidate financial results for the group.',
    `consolidation_scope` STRING COMMENT 'Scope of consolidation coverage for the group.',
    `cost_center_count` STRING COMMENT 'Number of cost centers aggregated within the consolidation group.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation group record was first created.',
    `consolidation_group_description` STRING COMMENT 'Detailed textual description of the consolidation groups purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the consolidation group becomes effective for reporting.',
    `effective_until` DATE COMMENT 'Date when the consolidation group ceases to be effective (nullable for open‑ended).',
    `fiscal_year_start_month` STRING COMMENT 'Month (1‑12) that marks the start of the groups fiscal year.',
    `group_code` STRING COMMENT 'Business identifier code used to reference the consolidation group in financial systems.',
    `group_currency_code` STRING COMMENT 'Coded value representing the group currency code of the consolidation group finance record.',
    `group_name` STRING COMMENT 'Human‑readable name of the consolidation group.',
    `group_type` STRING COMMENT 'Classification of the group indicating its purpose or scope.',
    `hierarchy_level` STRING COMMENT 'The hierarchy level of the consolidation group record in the finance domain.',
    `is_active` BOOLEAN COMMENT 'The is active of the consolidation group record in the finance domain.',
    `last_consolidation_date` DATE COMMENT 'Date when the most recent consolidation was performed for the group.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consolidation group record in the finance domain.',
    `legal_entity_count` STRING COMMENT 'Number of legal entities included in the consolidation group.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the consolidation group record in the finance domain.',
    `consolidation_group_name` STRING COMMENT 'The name of the consolidation group record in the finance domain.',
    `next_consolidation_date` DATE COMMENT 'Planned date for the next consolidation run.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the consolidation group.',
    `reporting_currency` STRING COMMENT 'ISO 4217 currency code in which the group reports financials.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the group produces consolidated financial statements.',
    `reporting_standard` STRING COMMENT 'The reporting standard of the consolidation group record in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consolidation group record.',
    CONSTRAINT pk_consolidation_group PRIMARY KEY(`consolidation_group_id`)
) COMMENT 'Master reference table for consolidation_group. Referenced by consolidation_group_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle',
    `employee_id` BIGINT COMMENT 'Unique identifier for the allocation responsible employee record within the allocation cycle finance entity.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the controlling cost center record within the allocation cycle finance entity.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the controlling legal entity record within the allocation cycle finance entity.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the allocation cycle finance entity.',
    `prior_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (prior_allocation_cycle_id)',
    `allocation_basis` STRING COMMENT 'Primary driver used for allocating costs (e.g., revenue, headcount).',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle state of the allocation cycle.',
    `allocation_frequency` STRING COMMENT 'How often allocations are performed within the cycle.',
    `allocation_method` STRING COMMENT 'Method used to calculate cost allocations for the cycle.',
    `allocation_type` STRING COMMENT 'The allocation type of the allocation cycle record in the finance domain.',
    `allocation_cycle_code` STRING COMMENT 'Coded value representing the code of the allocation cycle finance record.',
    `controlling_area` STRING COMMENT 'The controlling area of the allocation cycle record in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the allocation cycle finance record.',
    `cycle_code` STRING COMMENT 'External code used to reference the allocation cycle in financial systems.',
    `cycle_name` STRING COMMENT 'Human‑readable name describing the allocation cycle.',
    `cycle_status` STRING COMMENT 'The cycle status of the allocation cycle record in the finance domain.',
    `cycle_type` STRING COMMENT 'Category of the allocation cycle (e.g., monthly, quarterly, project‑based).',
    `default_allocation_percentage` DECIMAL(18,2) COMMENT 'Default percentage (e.g., 100.00) applied when no specific allocation rule is defined.',
    `allocation_cycle_description` STRING COMMENT 'Free‑form description providing additional context about the cycle.',
    `effective_end_date` DATE COMMENT 'Date on which the allocation cycle ends; null for open‑ended cycles.',
    `effective_from` DATE COMMENT 'The effective from of the allocation cycle record in the finance domain.',
    `effective_start_date` DATE COMMENT 'Date on which the allocation cycle becomes effective.',
    `effective_until` DATE COMMENT 'The effective until of the allocation cycle record in the finance domain.',
    `execution_frequency` STRING COMMENT 'The execution frequency of the allocation cycle record in the finance domain.',
    `execution_sequence` STRING COMMENT 'The execution sequence of the allocation cycle record in the finance domain.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the allocation cycle record in the finance domain.',
    `is_automatic` BOOLEAN COMMENT 'Indicates whether the allocation cycle is triggered automatically by the system.',
    `iteration_flag` BOOLEAN COMMENT 'The iteration flag of the allocation cycle record in the finance domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the allocation cycle record in the finance domain.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this allocation cycle.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the allocation cycle record in the finance domain.',
    `allocation_cycle_name` STRING COMMENT 'The name of the allocation cycle record in the finance domain.',
    `next_run_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next execution of the allocation cycle.',
    `notes` STRING COMMENT 'Additional free‑text notes or comments about the allocation cycle.',
    `period` STRING COMMENT 'The period of the allocation cycle record in the finance domain.',
    `period_frequency` STRING COMMENT 'The period frequency of the allocation cycle record in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation cycle record.',
    `version_number` STRING COMMENT 'Incremental version of the allocation cycle definition for change tracking.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` (
    `intercompany_agreement_id` BIGINT COMMENT 'Primary key for intercompany_agreement',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the first counter‑party in the intercompany agreement.',
    `intercompany_party_b_legal_entity_id` BIGINT COMMENT 'Unique identifier of the second counter‑party in the intercompany agreement.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the intercompany responsible employee record within the intercompany agreement finance entity.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the intercompany agreement finance entity.',
    `source_legal_entity_id` BIGINT COMMENT 'Unique identifier for the source legal entity record within the intercompany agreement finance entity.',
    `superseded_intercompany_agreement_id` BIGINT COMMENT 'Self-referencing FK on intercompany_agreement (superseded_intercompany_agreement_id)',
    `target_legal_entity_id` BIGINT COMMENT 'Unique identifier for the target legal entity record within the intercompany agreement finance entity.',
    `agreement_name` STRING COMMENT 'Human‑readable title or description of the intercompany agreement.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the intercompany agreement by the finance organization.',
    `agreement_status` STRING COMMENT 'The agreement status of the intercompany agreement record in the finance domain.',
    `agreement_type` STRING COMMENT 'Category of the intercompany agreement indicating the nature of the transaction.',
    `amendment_count` STRING COMMENT 'Number of times the agreement has been amended.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement received formal approval.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the agreement for execution.',
    `auto_renewal` BOOLEAN COMMENT 'True if the agreement automatically renews at expiry.',
    `comments` STRING COMMENT 'Additional remarks or notes entered by users.',
    `compliance_status` STRING COMMENT 'Indicates whether the agreement meets internal and regulatory compliance requirements.',
    `confidentiality_level` STRING COMMENT 'Classifies the sensitivity of the agreement content.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier charged for the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts in the agreement.',
    `intercompany_agreement_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the agreement.',
    `effective_date` DATE COMMENT 'The effective date associated with the intercompany agreement finance record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the intercompany agreement finance record.',
    `effective_from` DATE COMMENT 'Date on which the agreement becomes legally binding.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the intercompany agreement finance record.',
    `effective_until` DATE COMMENT 'Date on which the agreement expires or terminates; null for open‑ended agreements.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the intercompany agreement finance record.',
    `external_reference_code` STRING COMMENT 'Identifier used in external systems (e.g., ERP, legal repository) to reference the agreement.',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the agreement.',
    `intercompany_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.',
    `internal_owner` STRING COMMENT 'Name of the finance or business owner responsible for the agreement.',
    `is_intercompany` BOOLEAN COMMENT 'True if the agreement is between two entities within the same corporate group.',
    `jurisdiction` STRING COMMENT 'Country or region where the agreement is executed, expressed as ISO 3166‑1 alpha‑3 code.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the intercompany agreement record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the intercompany agreement record in the finance domain.',
    `oecd_compliance_flag` BOOLEAN COMMENT 'The oecd compliance flag of the intercompany agreement record in the finance domain.',
    `payment_terms` STRING COMMENT 'Standard payment condition applied to the agreement.',
    `pricing_method` STRING COMMENT 'The pricing method of the intercompany agreement record in the finance domain.',
    `receiving_entity_code` STRING COMMENT 'Coded value representing the receiving entity code of the intercompany agreement finance record.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement is eligible for renewal.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that a renewal notice must be issued.',
    `sending_entity_code` STRING COMMENT 'Coded value representing the sending entity code of the intercompany agreement finance record.',
    `signed_by` STRING COMMENT 'Name of the individual or entity that executed the agreement.',
    `signed_date` DATE COMMENT 'Date the agreement was signed by the authorized parties.',
    `termination_notice_period_days` STRING COMMENT 'Required notice period for early termination of the agreement.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value covered by the agreement.',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing method of the intercompany agreement record in the finance domain.',
    `transfer_pricing_rate` DECIMAL(18,2) COMMENT 'The transfer pricing rate of the intercompany agreement record in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the agreement record.',
    CONSTRAINT pk_intercompany_agreement PRIMARY KEY(`intercompany_agreement_id`)
) COMMENT 'Master reference table for intercompany_agreement. Referenced by intercompany_agreement_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` (
    `amortization_schedule_id` BIGINT COMMENT 'Primary key for amortization_schedule',
    `amortization_fixed_asset_id` BIGINT COMMENT 'Unique identifier for the amortization fixed asset record within the amortization schedule finance entity.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier of the capital asset that is being amortized.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the amortization schedule finance entity.',
    `rd_capitalization_id` BIGINT COMMENT 'Unique identifier for the rd capitalization record within the amortization schedule finance entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the responsible employee record within the amortization schedule finance entity.',
    `revised_amortization_schedule_id` BIGINT COMMENT 'Self-referencing FK on amortization_schedule (revised_amortization_schedule_id)',
    `amortized_fixed_asset_id` BIGINT COMMENT 'Unique identifier for the amortized fixed asset record within the amortization schedule finance entity.',
    `accumulated_amortization` DECIMAL(18,2) COMMENT 'Cumulative amortization amount recognized up to the current period.',
    `amortization_amount` DECIMAL(18,2) COMMENT 'The amortization amount of the amortization schedule record in the finance domain.',
    `amortization_method` STRING COMMENT 'Method used to calculate periodic amortization amounts.',
    `amortization_schedule_status` STRING COMMENT 'The status of the amortization schedule record in the finance domain.',
    `annual_amortization_amount` DECIMAL(18,2) COMMENT 'The annual amortization amount of the amortization schedule record in the finance domain.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule received formal approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the schedule.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier to which the amortization expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amortization schedule record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the amortization amounts.',
    `depreciation_category` STRING COMMENT 'Category that determines the accounting treatment of the amortization.',
    `effective_from` DATE COMMENT 'Date on which the amortization schedule becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the amortization schedule ends or is retired (nullable for open‑ended schedules).',
    `end_date` DATE COMMENT 'The end date associated with the amortization schedule finance record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the amortization schedule record in the finance domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the amortization schedule record in the finance domain.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the amortization schedule record in the finance domain.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the amortization schedule.',
    `number_of_periods` STRING COMMENT 'The number of periods of the amortization schedule record in the finance domain.',
    `original_amount` DECIMAL(18,2) COMMENT 'The original amount of the amortization schedule record in the finance domain.',
    `period` STRING COMMENT 'The period of the amortization schedule record in the finance domain.',
    `period_amortization_amount` DECIMAL(18,2) COMMENT 'The period amortization amount of the amortization schedule record in the finance domain.',
    `period_amount` DECIMAL(18,2) COMMENT 'Amortization charge allocated to the specific period.',
    `period_month` STRING COMMENT 'The period month of the amortization schedule record in the finance domain.',
    `period_number` STRING COMMENT 'Sequential number of the period within the schedule (e.g., 1 for first month).',
    `period_type` STRING COMMENT 'Frequency of amortization periods (e.g., monthly, quarterly, annually).',
    `period_year` STRING COMMENT 'The period year of the amortization schedule record in the finance domain.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The remaining amount of the amortization schedule record in the finance domain.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Outstanding balance of the asset that remains to be amortized.',
    `schedule_code` STRING COMMENT 'Coded value representing the schedule code of the amortization schedule finance record.',
    `schedule_number` STRING COMMENT 'External business identifier assigned to the amortization schedule (e.g., schedule reference code).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.',
    `schedule_type` STRING COMMENT 'Classification of the schedule based on the nature of the underlying cost (e.g., asset, lease, R&D).',
    `start_date` DATE COMMENT 'The start date associated with the amortization schedule finance record.',
    `tax_effect_flag` BOOLEAN COMMENT 'Indicates whether the amortization amount has tax implications (true = tax effect).',
    `total_amortized_amount` DECIMAL(18,2) COMMENT 'The total amortized amount of the amortization schedule record in the finance domain.',
    `total_amount` DECIMAL(18,2) COMMENT 'Original total cost of the asset that is subject to amortization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `version_number` STRING COMMENT 'Version of the schedule record for change‑tracking purposes.',
    CONSTRAINT pk_amortization_schedule PRIMARY KEY(`amortization_schedule_id`)
) COMMENT 'Master reference table for amortization_schedule. Referenced by amortization_schedule_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_legal_entity_id` BIGINT COMMENT 'Identifier of the immediate parent entity in a corporate hierarchy, if applicable.',
    `primary_ultimate_parent_legal_entity_id` BIGINT COMMENT 'Identifier of the top‑most parent entity in the corporate structure.',
    `address_line1` STRING COMMENT 'First line of the entitys primary mailing address.',
    `address_line2` STRING COMMENT 'Second line of the entitys primary mailing address, if needed.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Fiscal year total revenue reported in the entitys reporting currency.',
    `city` STRING COMMENT 'City of the entitys primary registered address.',
    `legal_entity_code` STRING COMMENT 'Coded value representing the code of the legal entity finance record.',
    `compliance_status` STRING COMMENT 'Overall compliance standing with regulatory requirements.',
    `country_code` STRING COMMENT 'Coded value representing the country code of the legal entity finance record.',
    `country_of_incorporation` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the jurisdiction where the entity was incorporated.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the legal entity record in the finance domain.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by rating agencies.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the legal entity finance record.',
    `data_classification_level` STRING COMMENT 'Classification of the entitys data for security handling.',
    `dba_name` STRING COMMENT 'Alternate trade name under which the entity conducts business.',
    `dissolution_date` DATE COMMENT 'Date the entity ceased to exist, if applicable.',
    `effective_from` DATE COMMENT 'The effective from of the legal entity record in the finance domain.',
    `effective_until` DATE COMMENT 'The effective until of the legal entity record in the finance domain.',
    `email_address` STRING COMMENT 'Primary email address used for official communications.',
    `entity_code` STRING COMMENT 'Coded value representing the entity code of the legal entity finance record.',
    `entity_name` STRING COMMENT 'The entity name of the legal entity record in the finance domain.',
    `entity_status` STRING COMMENT 'The entity status of the legal entity record in the finance domain.',
    `entity_type` STRING COMMENT 'Classification of the entitys legal structure.',
    `exchange_code` STRING COMMENT 'Code of the exchange where the entitys securities are listed.',
    `fiscal_year_end` STRING COMMENT 'The fiscal year end of the legal entity record in the finance domain.',
    `fiscal_year_end_month` STRING COMMENT 'Month (1‑12) in which the entitys fiscal year ends.',
    `functional_currency_code` STRING COMMENT 'Coded value representing the functional currency code of the legal entity finance record.',
    `governance_structure` STRING COMMENT 'High‑level governance model of the entity.',
    `incorporation_date` DATE COMMENT 'Date the entity was legally formed.',
    `industry_code` STRING COMMENT 'Standard industry classification (e.g., NAICS) for the entity.',
    `is_active` BOOLEAN COMMENT 'The is active of the legal entity record in the finance domain.',
    `is_public_company` BOOLEAN COMMENT 'Indicates whether the entity is publicly listed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the legal entity record in the finance domain.',
    `legal_entity_status` STRING COMMENT 'Current operational status of the entity.',
    `legal_entity_type` STRING COMMENT 'The type of the legal entity record in the finance domain.',
    `legal_name` STRING COMMENT 'The official registered name of the legal entity as it appears on incorporation documents.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the legal entity record in the finance domain.',
    `legal_entity_name` STRING COMMENT 'The name of the legal entity record in the finance domain.',
    `number_of_employees` STRING COMMENT 'Total headcount employed by the entity.',
    `ownership_percent` DECIMAL(18,2) COMMENT 'The ownership percent of the legal entity record in the finance domain.',
    `phone_number` STRING COMMENT 'Primary telephone number for the entity.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the primary address.',
    `primary_contact_detail` STRING COMMENT 'Contact information (e.g., email address or phone number) used for the primary contact method.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for official communications with the entity.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the legal entity record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the legal entity record.',
    `registration_number` STRING COMMENT 'Number assigned by the jurisdiction of incorporation.',
    `reporting_currency` STRING COMMENT 'ISO 4217 currency code used for financial reporting.',
    `sic_code` STRING COMMENT 'Legacy industry code used for regulatory reporting.',
    `state_province` STRING COMMENT 'First‑order administrative subdivision of the incorporation country.',
    `stock_ticker` STRING COMMENT 'Ticker symbol if the entity is publicly traded.',
    `tax_identification_number` STRING COMMENT 'The tax identification number of the legal entity record in the finance domain.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the entity.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction of the legal entity record in the finance domain.',
    `tax_jurisdiction_code` STRING COMMENT 'Coded value representing the tax jurisdiction code of the legal entity finance record.',
    `tax_status` STRING COMMENT 'Current tax compliance status of the entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the legal entity record in the finance domain.',
    `vat_number` STRING COMMENT 'The vat number of the legal entity record in the finance domain.',
    `website_url` STRING COMMENT 'Public website of the legal entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_to_journal_entry_id` FOREIGN KEY (`to_journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_depreciation_run_id` FOREIGN KEY (`depreciation_run_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`depreciation_run`(`depreciation_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_primary_internal_cost_center_id` FOREIGN KEY (`primary_internal_cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_to_cost_center_id` FOREIGN KEY (`to_cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_wbs_element_id` FOREIGN KEY (`parent_wbs_wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_source_cost_center_id` FOREIGN KEY (`source_cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_cost_center_id` FOREIGN KEY (`target_cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_center_id` FOREIGN KEY (`tertiary_cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ADD CONSTRAINT `fk_finance_finance_nre_milestone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ADD CONSTRAINT `fk_finance_finance_nre_milestone_finance_nre_agreement_id` FOREIGN KEY (`finance_nre_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement`(`finance_nre_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_reversal_of_capitalization_rd_capitalization_id` FOREIGN KEY (`reversal_of_capitalization_rd_capitalization_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_intercompany_agreement_id` FOREIGN KEY (`intercompany_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_target_legal_entity_id` FOREIGN KEY (`target_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_consolidation_unit_id` FOREIGN KEY (`consolidation_unit_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_unit`(`consolidation_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_related_entry_consolidation_entry_id` FOREIGN KEY (`related_entry_consolidation_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_entry`(`consolidation_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_intercompany_agreement_id` FOREIGN KEY (`intercompany_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_target_legal_entity_id` FOREIGN KEY (`target_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_primary_prior_period_tax_provision_id` FOREIGN KEY (`primary_prior_period_tax_provision_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_reversal_depreciation_run_id` FOREIGN KEY (`reversal_depreciation_run_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`depreciation_run`(`depreciation_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ADD CONSTRAINT `fk_finance_consolidation_unit_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ADD CONSTRAINT `fk_finance_consolidation_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ADD CONSTRAINT `fk_finance_consolidation_unit_parent_consolidation_unit_id` FOREIGN KEY (`parent_consolidation_unit_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_unit`(`consolidation_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ADD CONSTRAINT `fk_finance_consolidation_group_parent_consolidation_group_id` FOREIGN KEY (`parent_consolidation_group_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ADD CONSTRAINT `fk_finance_consolidation_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_prior_allocation_cycle_id` FOREIGN KEY (`prior_allocation_cycle_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_intercompany_party_b_legal_entity_id` FOREIGN KEY (`intercompany_party_b_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_source_legal_entity_id` FOREIGN KEY (`source_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_superseded_intercompany_agreement_id` FOREIGN KEY (`superseded_intercompany_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_target_legal_entity_id` FOREIGN KEY (`target_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_amortization_fixed_asset_id` FOREIGN KEY (`amortization_fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_revised_amortization_schedule_id` FOREIGN KEY (`revised_amortization_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`amortization_schedule`(`amortization_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ADD CONSTRAINT `fk_finance_amortization_schedule_amortized_fixed_asset_id` FOREIGN KEY (`amortized_fixed_asset_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_legal_entity_id`) REFERENCES `vibe_semiconductors_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_semiconductors_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'headcount|fab_utilization|revenue|custom');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'fab|r&d|corporate|support');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `natural_account` SET TAGS ('dbx_business_glossary_term' = 'Natural Account');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `responsibility_center_code` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `subdepartment_code` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Department Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `to_company_code` SET TAGS ('dbx_business_glossary_term' = 'To Company Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Validity Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Valid From Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Valid To Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID (GL Account ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category (GL Account Category)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code (GL Account Code)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group (GL Account Group)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Level (GL Account Level)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Name (GL Account Name)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_subgroup` SET TAGS ('dbx_business_glossary_term' = 'Account Subgroup (GL Account Subgroup)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (GL Account Type)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `amortization_flag` SET TAGS ('dbx_business_glossary_term' = 'Amortization Flag (GL Amortization Flag)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance (GL Closing Balance)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (GL Cost Center Code)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (GL Created Timestamp)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (GL Currency Code)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (GL Depreciation Method)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate (GL Depreciation Rate)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description (GL Account Description)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference (GL External Reference)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assignment (GL Financial Statement)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `financial_statement` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (GL Account Status)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `is_budget_controlled` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag (GL Budget Control)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Flag (GL Consolidation Flag)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag (GL Reconciliation Flag)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (GL Opening Balance)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `posting_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Restriction Flag (GL Posting Restriction)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (GL Profit Center Code)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (GL Reporting Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code (GL Segment Code)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category (GL Tax Category)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (GL Tax Rate)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (GL Updated Timestamp)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date (GL Valid From)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`gl_account` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date (GL Valid To)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (PC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier (PC_PARENT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Manager Identifier (PC_MGR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Actual Spend (PC_ACTUAL_SPEND)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Allocation Percent (PC_ALLOC_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Budget Amount (PC_BUDGET_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Budget Currency (PC_BUDGET_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category (PC_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_value_regex' = 'product_line|technology_node|geography|service|support');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason (PC_CHANGE_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (PC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO_AREA)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method (PC_COST_ALLOC_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|standard');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User (PC_CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Creation Timestamp (PC_CREATED_TSTMP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description (PC_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Profit Center End Date (PC_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `fab_location` SET TAGS ('dbx_business_glossary_term' = 'FAB Location (PC_FAB_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (PC_REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level (PC_HIER_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Flag (PC_CONSOLIDATED)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (PC_LAST_REV_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name (PC_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line (PC_PROD_LINE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group (PC_GROUP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status (PC_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type (PC_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'product_line|technology_node|geography|service|support');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (PC_REP_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `responsibility_center` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Center (PC_RESP_CENTER)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (PC_REV_CYCLE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `sox_compliant` SET TAGS ('dbx_business_glossary_term' = 'SOX Compliance Indicator (PC_SOX_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Start Date (PC_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `subgroup` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Sub‑Group (PC_SUBGROUP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (PC_TECH_NODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `to_company_code` SET TAGS ('dbx_business_glossary_term' = 'To Company Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Indicator (PC_TP_IND)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (PC_UPDATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Last Update Timestamp (PC_UPDATED_TSTMP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Variance Amount (PC_VARIANCE_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (PC_VER_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`profit_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID (JEID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID (EMPLOYEE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID (PROJECT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID (VENDOR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `amount_base` SET TAGS ('dbx_business_glossary_term' = 'Document Amount (Group Currency) (DOC_AMT_GC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `amount_local` SET TAGS ('dbx_business_glossary_term' = 'Document Amount (Local Currency) (DOC_AMT_LC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number (ASSET_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area (BUS_AREA)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (CO_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group (CONS_GROUP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method (CONS_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'elimination|translation|goodwill|minority|adjustment');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator (DC_IND)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Entry Description (DESCRIPTION)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (DOC_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DOC_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'vendor_invoice|customer_payment|asset_depreciation|accrual|intercompany|consolidation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period (FP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '0[1-9]|1[0-2]');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area (FUNC_AREA)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator (INTERCO_IND)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_account` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account (GL_ACCOUNT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date (PERIOD_END)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key (POST_KEY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = 'd{2}');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status (POST_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp (POST_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number (REF_DOC_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_text` SET TAGS ('dbx_business_glossary_term' = 'Reference Text');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date (REV_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (REV_IND)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment (SEGMENT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `to_company_code` SET TAGS ('dbx_business_glossary_term' = 'To Company Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `total_credit` SET TAGS ('dbx_business_glossary_term' = 'Total Credit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `total_debit` SET TAGS ('dbx_business_glossary_term' = 'Total Debit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPDATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID (JELID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID (JEID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `to_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'To Journal Entry Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency (AMT_DOC_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency (AMT_LOC_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field (ASSIGNMENT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator (DC_IND)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code (FUNC_AREA)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description (LINE_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LINE_SEQ)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status (LINE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|cleared|reversed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Text');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity (LINE_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (IS_REVERSAL)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `to_journal_entry` SET TAGS ('dbx_business_glossary_term' = 'To Journal Entry');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Request ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Fixed Asset Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Stage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_value_regex' = 'initial|financial|executive');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Capital Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Capital Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `business_case_summary` SET TAGS ('dbx_business_glossary_term' = 'Business Case Summary');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `chips_act_funding_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Funding Eligibility');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'lithography|cmp|cvd|pvd|ald|ate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|chips_act|government_grant');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Technical Justification');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `request_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Capital Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Request Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `request_title` SET TAGS ('dbx_business_glossary_term' = 'Request Title');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '5nm|7nm|10nm|14nm|28nm');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `to_fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'To Fixed Asset Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`capex_request` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Custodian Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `capitalized` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Period Depreciation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|transfer');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|disposed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `grant_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `grant_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Recognition Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `grant_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_bay` SET TAGS ('dbx_business_glossary_term' = 'Location Bay');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_building` SET TAGS ('dbx_business_glossary_term' = 'Location Building');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`fixed_asset` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Depreciation Record Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fabrication_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation to Date (Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Posting Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|error');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Adjustment Amount (Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount (Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = 'book|tax|ifrs');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production|sum_of_years_digits');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `period_month` SET TAGS ('dbx_business_glossary_term' = 'Period Month');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `period_year` SET TAGS ('dbx_business_glossary_term' = 'Period Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Posted Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `remaining_useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`asset_depreciation` ALTER COLUMN `utilization_factor` SET TAGS ('dbx_business_glossary_term' = 'Utilization Factor');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'project_controlling');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `primary_internal_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `to_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'To Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `auditor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Auditor Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `auditor_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Auditor Approval Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `capitalization_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligibility');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `internal_order_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_complete|closed|cancelled|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `order_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Order Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'R&D|Maintenance|NRE|Corporate|Capital|Other');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `real_indicator` SET TAGS ('dbx_business_glossary_term' = 'Real Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'asset|cost_center|wbs');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `statistical_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `to_cost_center` SET TAGS ('dbx_business_glossary_term' = 'To Cost Center');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `trl` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`internal_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'project_controlling');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'project_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Wbs Element Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent WBS Element Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `billing_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Element Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|usage_based');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `financial_year` SET TAGS ('dbx_business_glossary_term' = 'Financial Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Template Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_name` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'development|qualification|ramp_up|production|closure');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `r_and_d_capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'R&D Capitalization Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_description` SET TAGS ('dbx_business_glossary_term' = 'Wbs Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_value_regex' = 'project|phase|task|subtask|milestone');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'WBS Hierarchy Path');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Wbs Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_status` SET TAGS ('dbx_business_glossary_term' = 'Wbs Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wbs_element` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'project_controlling');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `source_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `target_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Base Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'machine_hours|wafer_passes|labor_hours|energy_consumption|area_sqft|custom');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'activity_based|statistical|fixed_percentage|direct|proportional|custom');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rate` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_status` SET TAGS ('dbx_value_regex' = 'pending|allocated|reversed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^d{4}Q[1-4]$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `period_month` SET TAGS ('dbx_business_glossary_term' = 'Period Month');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `period_year` SET TAGS ('dbx_business_glossary_term' = 'Period Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `receiver_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Receiver Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `receiver_cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` SET TAGS ('dbx_subdomain' = 'product_costing');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_cost_model_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `chemicals_gases_cost_usd_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Chemicals & Gases Cost per Wafer (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `cost_per_wafer_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Wafer Usd');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `die_size_um2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (UM2)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `equipment_depreciation_usd_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Depreciation per Wafer (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `fab_location` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `fab_location` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `fab_overhead_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fab Overhead Rate Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `fixed_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Fixed Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `labor_hours_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `labor_rate_usd_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (USD per Hour)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `mask_set_amortization_wafers` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Amortization Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]+$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `silicon_wafer_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Silicon Wafer Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (NM)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '^d+nm$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `total_cost_per_wafer_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost per Wafer (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `variable_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Variable Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_cost_model_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Model Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_cost_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (MM)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`wafer_cost_model` ALTER COLUMN `yield_assumption_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Assumption Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` SET TAGS ('dbx_ssot_owner' = 'nre_agreement');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `finance_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Finance NRE Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Product Design ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `tertiary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `tertiary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `tertiary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement Type (MASK, DESIGN, QUALIFICATION, COMBINED)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'mask|design|qualification|combined');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `finance_nre_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `finance_nre_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `payment_milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method (UPFRONT, ROYALTY, HYBRID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'upfront|royalty|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NAM|EMEA|APAC|LATAM');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method (ASC 606)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'percentage_of_completion|completed_contract|milestone_based');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `tax_regime` SET TAGS ('dbx_business_glossary_term' = 'Tax Regime');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `tax_regime` SET TAGS ('dbx_value_regex' = 'standard|reduced|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `total_nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Total NRE Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` SET TAGS ('dbx_ssot_owner' = 'nre_milestone');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `finance_nre_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'NRE Milestone Identifier (NRE_MILESTONE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `order_nre_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Order Nre Milestone Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `order_nre_milestone_id` SET TAGS ('dbx_ssot' = 'cross_domain_fk');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `finance_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement Identifier (NRE_AGREEMENT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp (ACTUAL_COMPLETION_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (AMOUNT_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (AMOUNT_NET)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (AMOUNT_TAX)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `billing_trigger` SET TAGS ('dbx_business_glossary_term' = 'Billing Trigger');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `billing_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Billing Trigger Event (BILLING_TRIGGER_EVENT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `billing_trigger_event` SET TAGS ('dbx_value_regex' = 'milestone_achieved|percentage_complete|date_based');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'sox_compliant|non_sox');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type (EXPENSE_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `expense_type` SET TAGS ('dbx_value_regex' = 'capital|expense|research|development');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `finance_nre_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `finance_nre_milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|invoiced|rejected|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status (INVOICE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'not_issued|issued|paid|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `is_revenue_recognized` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognized Flag (IS_REVENUE_RECOGNIZED)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code (MILESTONE_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name (MILESTONE_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type (MILESTONE_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'design|tapeout|first_silicon|qualification|production');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date (PLANNED_COMPLETION_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (REVENUE_RECOGNITION_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method (REVENUE_RECOGNITION_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'percentage_of_completion|milestone_based');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`finance_nre_milestone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'planning_budgeting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'budgeting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Identifier (BPI)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (BT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|r&d|headcount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `chips_act_funding_indicator` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Funding Indicator (CAFI)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `compliance_regulation_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation Flag (CRF)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CAD');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `financial_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard (FRS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `financial_reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|US-GAAP|IFRS-16');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|archived');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NTS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `organization_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Code (OUC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Timestamp (PAT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date (PED)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number (BPN)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^BP-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date (PSD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `planned_amount_group` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (Group Currency) (PAGC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `planned_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (Local Currency) (PALC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity (PQ)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_business_glossary_term' = 'Planning Method (PM)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_value_regex' = 'top-down|bottom-up|rolling|zero-based');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafer_start|fte|machine_hour|unit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UBU)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `variance_to_prior_year_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Year Amount (VPA)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `variance_to_prior_year_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Year Percent (VPP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number (PVN)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CBU)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'planning_budgeting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budgeting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|R&D|SG&A');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_value_regex' = 'planned|approved|released|closed');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'SOX|SEC|None');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_manager` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Manager Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `cost_element_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `cost_element_type` SET TAGS ('dbx_value_regex' = 'material|labor|overhead|service');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `is_frozen` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Frozen Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `period_month` SET TAGS ('dbx_business_glossary_term' = 'Period Month');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `period_year` SET TAGS ('dbx_business_glossary_term' = 'Period Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (Currency)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `planned_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `planned_quantity_unit` SET TAGS ('dbx_value_regex' = 'wafer|FTE|unit|kg|m');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `related_project_code` SET TAGS ('dbx_business_glossary_term' = 'Related Project Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`budget_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` SET TAGS ('dbx_subdomain' = 'planning_budgeting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` SET TAGS ('dbx_subdomain' = 'project_accounting');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Capitalization Record Identifier (RD_CAPITALIZATION_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Related IP Core Identifier (IP_CORE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction Identifier (AUC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `reversal_of_capitalization_rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Capitalization Identifier (REV_CAP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_period_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period Months');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Amortization Schedule Identifier (AMORT_SCH_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `auditor_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Auditor Approval Status (AUDIT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `auditor_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name (AUDITOR_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date (CAP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_event_number` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Event Number (CAP_EVENT_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_period` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalized_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Amount (CAP_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalized_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Asset Type (CAP_ASSET_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `capitalized_asset_type` SET TAGS ('dbx_value_regex' = 'intangible|development_cost|equipment|process_node');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (COMPLIANCE_REG)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'asc_730|ias_38|sox|sec');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code (COST_ELEMENT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (DEP_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (DEP_START_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `rd_capitalization_description` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Description (CAP_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Event Timestamp (CAP_EVENT_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `expensed_amount` SET TAGS ('dbx_business_glossary_term' = 'Expensed Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `external_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag (EXT_AUDIT_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period (FP)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `internal_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Flag (INT_AUDIT_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag (IS_REVERSAL)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `original_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Expense Amount (ORIG_EXP_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (PROFIT_CENTER)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `rd_capitalization_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Status (CAP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `rd_capitalization_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|reversed');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `related_ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Related IP Core Name (IP_CORE_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPDATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`rd_capitalization` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (YEARS)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'intercompany');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `target_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `audit_documentation_ref` SET TAGS ('dbx_business_glossary_term' = 'Audit Documentation Reference');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `country_of_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Country of Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `interco_to_sending_company` SET TAGS ('dbx_business_glossary_term' = 'Interco To Sending Company');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'intercompany_loan|transfer_pricing_charge|royalty|shared_service_allocation|intercompany_sale');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Documentation Reference');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_margin` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Margin');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|comparable_uncontrolled_price|resale_price|tnmm');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_rate` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` SET TAGS ('dbx_subdomain' = 'consolidation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `related_entry_consolidation_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Related Consolidation Entry Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Consolidation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Consolidation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_entry_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportionate|equity|cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_to_company` SET TAGS ('dbx_business_glossary_term' = 'Consolidation To Company');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'elimination|minority_interest|currency_translation|goodwill_amortization|other');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` SET TAGS ('dbx_subdomain' = 'product_costing');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility ID');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'per_wafer|per_die|percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|WeightedAverage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Calculation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_calculation_method` SET TAGS ('dbx_value_regex' = 'bottom_up|top_down');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'material|labor|equipment|overhead|packaging');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_component` SET TAGS ('dbx_business_glossary_term' = 'Cost Component');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_model_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Model Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_per_good_die` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Good Die');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'standard|actual|forecast');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `cost_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Version');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `die_size_um2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (µm²)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `dies_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Dies Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `equipment_depreciation_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Depreciation Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `fab_overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Fab Overhead Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `mask_set_cost` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `material_cost_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Material Cost Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Overhead Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `packaging_cost_per_die` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost Per Die');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield (%)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `total_wafer_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Wafer Cost');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `usd` SET TAGS ('dbx_business_glossary_term' = 'Usd');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`standard_cost` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` SET TAGS ('dbx_subdomain' = 'product_costing');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` SET TAGS ('dbx_subdomain' = 'intercompany');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `target_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'cost_plus|comparable|resale|tnmm');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'volume|value|weight|capacity');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `approval_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `cost_component` SET TAGS ('dbx_business_glossary_term' = 'Cost Component');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `cost_component` SET TAGS ('dbx_value_regex' = 'material|labor|overhead|equipment|facility');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `effective_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Effective Price Per Unit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `margin_rate` SET TAGS ('dbx_business_glossary_term' = 'Margin Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `markup_percent` SET TAGS ('dbx_business_glossary_term' = 'Markup Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `oecd_document_reference` SET TAGS ('dbx_business_glossary_term' = 'OECD Documentation Reference');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `price_method` SET TAGS ('dbx_business_glossary_term' = 'Price Determination Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `price_method` SET TAGS ('dbx_value_regex' = 'cost_plus|comparable|resale|tnmm');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'wafer|die|ip|service');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `related_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Document Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'design|testing|assembly|logistics');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `source_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `target_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Applicable Tax Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|terminated|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_type` SET TAGS ('dbx_value_regex' = 'product|service|royalty');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'per_watt|per_die|per_mm2|per_unit');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `usd` SET TAGS ('dbx_business_glossary_term' = 'Usd');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`transfer_price` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` SET TAGS ('dbx_subdomain' = 'tax');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `primary_prior_period_tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Tax Provision Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `primary_prior_period_tax_provision_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_asset_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `effective_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `pretax_income` SET TAGS ('dbx_business_glossary_term' = 'Pretax Income');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Provision Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `provision_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `provision_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Reversal Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_account_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_credit_carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Carryforward Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_credit_used_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Used Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Expense Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_explanation` SET TAGS ('dbx_business_glossary_term' = 'Tax Explanation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_law_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Law Reference');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|closed');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_rate_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Change Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Regulation Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'current|deferred|both');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `taxable_income` SET TAGS ('dbx_business_glossary_term' = 'Taxable Income');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`tax_provision` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Version');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_executed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_executed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_executed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_depreciation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Depreciation Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_depreciation_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `asset_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Count');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_tax_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Tax Adjustment');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Override');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `net_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Depreciation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Run Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_period` SET TAGS ('dbx_business_glossary_term' = 'Run Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_version` SET TAGS ('dbx_business_glossary_term' = 'Run Version');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `schedule_frequency` SET TAGS ('dbx_business_glossary_term' = 'Schedule Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `total_accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Total Accumulated Depreciation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `total_book_value` SET TAGS ('dbx_business_glossary_term' = 'Total Book Value');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`depreciation_run` ALTER COLUMN `total_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Depreciation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` SET TAGS ('dbx_subdomain' = 'consolidation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `parent_consolidation_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consolidation Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_weight` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Weight');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `financial_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `last_consolidation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Consolidation Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `consolidation_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `next_consolidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Consolidation Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `ownership_percent` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_unit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` SET TAGS ('dbx_subdomain' = 'consolidation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `parent_consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consolidation Group Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `parent_consolidation_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `parent_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Group Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Scope');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `cost_center_count` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Count');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Month');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `last_consolidation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Consolidation Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `legal_entity_count` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Count');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_group_name` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `next_consolidation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Consolidation Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`consolidation_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'project_controlling');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `prior_allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Allocation Cycle Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `prior_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Allocation Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `default_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Default Allocation Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Execution Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `execution_sequence` SET TAGS ('dbx_business_glossary_term' = 'Execution Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `is_automatic` SET TAGS ('dbx_business_glossary_term' = 'Is Automatic');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `iteration_flag` SET TAGS ('dbx_business_glossary_term' = 'Iteration Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `next_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Run Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `period_frequency` SET TAGS ('dbx_business_glossary_term' = 'Period Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`allocation_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` SET TAGS ('dbx_subdomain' = 'intercompany');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_party_b_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Party B Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `source_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `superseded_intercompany_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Intercompany Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `superseded_intercompany_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `target_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `internal_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Is Intercompany');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `oecd_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Oecd Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `receiving_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `sending_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `transfer_pricing_rate` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Rate');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`intercompany_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `amortization_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Amortization Schedule Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `amortization_fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `revised_amortization_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Amortization Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `revised_amortization_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `accumulated_amortization` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Amortization');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Amortization Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `amortization_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Amortization Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `annual_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Amortization Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `depreciation_category` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Category');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `number_of_periods` SET TAGS ('dbx_business_glossary_term' = 'Number Of Periods');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Period Amortization Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period_amount` SET TAGS ('dbx_business_glossary_term' = 'Period Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period_month` SET TAGS ('dbx_business_glossary_term' = 'Period Month');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `period_year` SET TAGS ('dbx_business_glossary_term' = 'Period Year');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `tax_effect_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Effect Flag');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `total_amortized_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amortized Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`amortization_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity Id');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country Of Incorporation');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Dba Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_code` SET TAGS ('dbx_business_glossary_term' = 'Entity Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Entity Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `governance_structure` SET TAGS ('dbx_business_glossary_term' = 'Governance Structure');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `is_public_company` SET TAGS ('dbx_business_glossary_term' = 'Is Public Company');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `ownership_percent` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percent');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_detail` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Detail');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_detail` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_detail` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_detail` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Sic Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `stock_ticker` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Status');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'Vat Number');
ALTER TABLE `vibe_semiconductors_v1`.`finance`.`legal_entity` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
