-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`finance` COMMENT 'Financial management including GL, AP, AR, budgeting, forecasting, and financial reporting per USALI standards and GAAP/IFRS. Manages property-level P&L, departmental accounting, capital expenditure tracking (CapEx, FF&E), and consolidated financial statements. Tracks GOP, EBITDA, NOI calculations. Integrates with SAP S/4HANA. Supports SOX financial controls for publicly traded entities.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Some GL accounts have default cost centers for automatic allocation when no specific cost center is provided on transactions. The cost_center_code STRING should be replaced with a proper FK to cost_ce',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Some GL accounts have default profit centers for automatic allocation when no specific profit center is provided on transactions. The profit_center_code STRING should be replaced with a proper FK to p',
    `property_id` BIGINT COMMENT 'The unique identifier of the property to which this ledger account belongs. Supports property-level chart of accounts and multi-property financial consolidation. Links to the property master entity.',
    `account_category` STRING COMMENT 'The USALI-defined category grouping for the account (e.g., Rooms, Food and Beverage, Other Operated Departments, Administrative and General, Sales and Marketing, Property Operations and Maintenance, Utilities, Fixed Charges). Used for departmental P&L reporting and GOP calculation.',
    `account_name` STRING COMMENT 'The descriptive name of the general ledger account (e.g., Room Revenue, Food and Beverage Cost of Sales, Payroll and Related Expenses, Property Operations and Maintenance).',
    `account_number` STRING COMMENT 'The unique account number assigned to this general ledger account per USALI chart of accounts structure. Typically 4-10 digit numeric code used for financial reporting and transaction posting.. Valid values are `^[0-9]{4,10}$`',
    `account_subcategory` STRING COMMENT 'The detailed subcategory within the USALI account category (e.g., within Food and Beverage: Restaurant Revenue, Banquet Revenue, Room Service Revenue; within Rooms: Payroll and Related, Guest Supplies, Laundry and Linen). Enables granular financial analysis.',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the ledger account: asset, liability, equity, revenue, or expense. Determines placement in financial statements and normal balance behavior.. Valid values are `asset|liability|equity|revenue|expense`',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether detailed audit trail documentation is required for all transactions posted to this account. Used for high-risk accounts, regulatory compliance, and forensic accounting.',
    `balance_sheet_section` STRING COMMENT 'The section of the balance sheet where this account appears (current assets, non-current assets, current liabilities, non-current liabilities, equity). Determines liquidity classification and working capital calculation.. Valid values are `current_assets|non_current_assets|current_liabilities|non_current_liabilities|equity`',
    `cash_flow_classification` STRING COMMENT 'The cash flow statement category for this account: operating activities, investing activities, or financing activities. Used for automated cash flow statement preparation per GAAP/IFRS.. Valid values are `operating|investing|financing`',
    `consolidation_account` STRING COMMENT 'The account number used for consolidation at the corporate or regional level. Maps property-level accounts to standardized corporate chart of accounts for multi-property financial consolidation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ledger account record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this ledger account is denominated (e.g., USD, EUR, GBP). Supports multi-currency accounting for global property portfolios.. Valid values are `^[A-Z]{3}$`',
    `ledger_description` STRING COMMENT 'Extended description of the ledger account purpose, usage guidelines, and posting rules. Provides additional context beyond the account name for accounting staff and auditors.',
    `effective_end_date` DATE COMMENT 'The date on which this ledger account becomes inactive and no longer accepts new transactions. Null for accounts with no planned end date. Used for account retirement and chart of accounts cleanup.',
    `effective_start_date` DATE COMMENT 'The date from which this ledger account becomes active and available for transaction posting. Supports phased chart of accounts implementation and account structure changes.',
    `functional_area` STRING COMMENT 'The functional area classification for financial statement presentation (e.g., Operating Revenue, Cost of Sales, Operating Expenses, Fixed Charges). Used for USALI-compliant income statement formatting and GOP calculation.',
    `income_statement_section` STRING COMMENT 'The section of the income statement where this account appears per USALI format (e.g., Operated Departments Revenue, Operated Departments Expenses, Undistributed Operating Expenses, Fixed Charges). Supports GOP, EBITDA, and NOI calculation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the ledger account is currently active and available for transaction posting. Inactive accounts are retained for historical reporting but cannot accept new transactions.',
    `is_control_account` BOOLEAN COMMENT 'Indicates whether this is a control account (summary account) that aggregates balances from subsidiary ledgers (e.g., Accounts Receivable control account summarizing individual guest folios). Control accounts do not accept direct postings.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany transactions between properties or legal entities within the hospitality group. Intercompany accounts are eliminated during consolidated financial statement preparation.',
    `is_reconciliation_required` BOOLEAN COMMENT 'Indicates whether this account requires periodic reconciliation (e.g., bank accounts, accounts receivable, inventory accounts). Used for internal control and SOX compliance.',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this is a statistical account used for non-monetary metrics (e.g., room nights sold, covers served, occupied room count). Statistical accounts support KPI calculation (ADR, RevPAR, GOPPAR) but do not carry monetary balances.',
    `last_posting_date` DATE COMMENT 'The date of the most recent transaction posted to this account. Used for dormant account identification and account usage analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ledger account record was last modified. Used for change tracking and audit trail.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance. Assets and expenses have debit normal balances; liabilities, equity, and revenue have credit normal balances. Used for transaction validation and financial statement preparation.. Valid values are `debit|credit`',
    `notes` STRING COMMENT 'Free-form notes field for special instructions, reconciliation notes, or account-specific documentation. Used by accounting staff for operational guidance and audit documentation.',
    `posting_block_flag` BOOLEAN COMMENT 'Indicates whether direct posting to this account is blocked. Posting blocks are used for control accounts, summary accounts, or accounts under investigation. Transactions must be posted to subsidiary accounts instead.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to SOX internal control testing and documentation requirements. Typically true for material accounts affecting financial statement accuracy for publicly traded hospitality companies.',
    `tax_category` STRING COMMENT 'The tax category or tax line item code associated with this account for tax reporting purposes (e.g., taxable revenue, non-taxable revenue, deductible expense, non-deductible expense). Supports automated tax return preparation.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'General Ledger (GL) master entity representing the chart of accounts structure per USALI (Uniform System of Accounts for the Lodging Industry) standards. Each ledger account defines an account number, account name, account type (asset, liability, equity, revenue, expense), account group, normal balance indicator, and currency. Serves as the authoritative financial record backbone for all property-level and consolidated financial reporting including income statements, balance sheets, cash flow statements, GOP, EBITDA, NOI, and GOPPAR calculations. Supports period-end financial statement generation and multi-property consolidation with intercompany elimination. Sourced from SAP S/4HANA GL module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to a parent cost center in a hierarchical cost center structure, enabling roll-up reporting and consolidated P&L views. Null if this is a top-level cost center.',
    `property_id` BIGINT COMMENT 'Reference to the property to which this cost center belongs.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total annual budgeted amount allocated to this cost center for the current fiscal year, used for variance analysis and financial control.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether all financial transactions posted to this cost center must maintain a full audit trail for compliance and internal control purposes (True) or standard logging is sufficient (False).',
    `budget_allocation_flag` BOOLEAN COMMENT 'Indicates whether this cost center has a dedicated budget allocation and is subject to budget control and variance reporting (True) or operates without a formal budget (False).',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center within the property and financial system. Used in GL postings and financial reports.. Valid values are `^[A-Z0-9]{4,12}$`',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity to which this cost center belongs, used for consolidated financial reporting and legal compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP controlling area under which this cost center is managed, representing the organizational unit for internal cost accounting and management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate shared costs or overhead to this cost center: direct assignment, activity-based costing, percentage allocation, headcount-based, or square footage-based.. Valid values are `direct|activity_based|percentage|headcount|square_footage`',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center: active (operational and accepting postings), inactive (temporarily not in use), suspended (blocked for new postings), or closed (permanently retired).. Valid values are `active|inactive|suspended|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by its primary function: revenue-generating departments, support services, administrative functions, or overhead allocation centers.. Valid values are `revenue|support|administrative|overhead`',
    `created_by_user` STRING COMMENT 'The username or employee identifier of the user who created this cost center record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers financial transactions are recorded (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_category` STRING COMMENT 'High-level USALI category: Operated Departments (revenue-generating), Undistributed Operating Expenses (support), or Fixed Charges (property-level overhead).. Valid values are `operated|undistributed|fixed_charges`',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and operational responsibilities.',
    `effective_end_date` DATE COMMENT 'The date on which this cost center ceased operations or was closed. Null for currently active cost centers.',
    `effective_start_date` DATE COMMENT 'The date from which this cost center became active and began accepting financial postings.',
    `external_reporting_flag` BOOLEAN COMMENT 'Indicates whether this cost centers financial results are included in external financial statements and regulatory filings (True) or used only for internal management reporting (False).',
    `headcount_allocation` STRING COMMENT 'The number of full-time equivalent (FTE) employees allocated to this cost center, used for labor cost analysis and productivity metrics.',
    `hierarchy_level` STRING COMMENT 'The depth of this cost center in the organizational hierarchy (1=top-level, 2=sub-department, etc.), used for roll-up aggregation and reporting.',
    `labor_cost_tracking_flag` BOOLEAN COMMENT 'Indicates whether labor costs (payroll, benefits, overtime) are tracked and allocated to this cost center (True) or excluded from labor cost analysis (False).',
    `last_modified_by_user` STRING COMMENT 'The username or employee identifier of the user who last modified this cost center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated or modified.',
    `cost_center_name` STRING COMMENT 'The full business name of the cost center (e.g., Rooms Division, Food and Beverage, Spa Operations, Administration).',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the cost centers operations, budget constraints, or reporting requirements.',
    `profit_center_code` STRING COMMENT 'The profit center code to which this cost centers expenses and revenues are allocated for segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `revenue_posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether revenue transactions can be posted to this cost center (True for revenue-generating departments) or only expense postings are allowed (False for support/administrative centers).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX financial controls and audit requirements (True for publicly traded entities) or exempt (False).',
    `square_footage` DECIMAL(18,2) COMMENT 'The total square footage of physical space occupied by this cost center, used for space-based cost allocation and facility management analysis.',
    `usali_department_code` STRING COMMENT 'The standard USALI departmental code aligning this cost center to the industry-standard chart of accounts for lodging P&L reporting (e.g., 10=Rooms, 20=Food, 30=Beverage, 40=Other Operated Departments, 50=Administrative & General).. Valid values are `^[0-9]{2,4}$`',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master representing departmental accounting units within each property (e.g., Rooms, F&B, Spa, Administration). Aligns with USALI departmental P&L structure. Used for allocating OpEx, labor costs, and overhead across operating departments. Sourced from SAP S/4HANA Controlling (CO) module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the primary cost center associated with this profit center for expense allocation and departmental accounting per USALI standards.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee responsible for managing this profit center. Used for accountability reporting and performance evaluation.',
    `ownership_entity_id` BIGINT COMMENT 'Foreign key reference to the legal ownership entity responsible for this profit center. Supports consolidated financial statements across the portfolio and inter-company eliminations.',
    `parent_profit_center_id` BIGINT COMMENT 'Foreign key reference to the parent profit center in a hierarchical profit center structure. Enables roll-up reporting for complex properties with nested profit centers (e.g., a resort with multiple F&B (Food and Beverage) outlets).',
    `property_id` BIGINT COMMENT 'Foreign key reference to the parent property or resort to which this profit center belongs. Enables property-level P&L (Profit and Loss) consolidation and RevPAR (Revenue Per Available Room) contribution analysis.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key reference to the primary revenue center for this profit center. Used for revenue recognition and departmental revenue reporting per USALI.',
    `address_line_1` STRING COMMENT 'Primary street address line for the profit centers physical location. Required for property-level profit centers and standalone F&B (Food and Beverage) or event venues.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `brand_code` STRING COMMENT 'Brand or franchise affiliation code for the profit center (e.g., Marriott, Hilton, Hyatt, independent). Used for brand-level performance reporting and franchise fee calculations.',
    `business_area_code` STRING COMMENT 'SAP Business Area code for -code segment reporting. Enables consolidated reporting across multiple legal entities within the same business segment (e.g., luxury hotels, select-service properties).. Valid values are `^[A-Z0-9]{4}$`',
    `city` STRING COMMENT 'City or municipality where the profit center is located.',
    `closure_date` DATE COMMENT 'The date the profit center was permanently closed. Used for historical analysis and asset disposition reporting.',
    `profit_center_code` STRING COMMENT 'The externally-known unique business identifier for the profit center used in financial reporting and consolidation. Typically alphanumeric code assigned per SAP S/4HANA Profit Center Accounting standards.. Valid values are `^[A-Z0-9]{4,12}$`',
    `company_code` STRING COMMENT 'SAP Company Code representing the legal entity for external financial reporting. Links profit center results to the general ledger and statutory financial statements.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'SAP Controlling Area code to which this profit center is assigned. Defines the organizational boundary for internal cost and revenue accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the profit centers location. Used for multi-country consolidation and compliance with local regulatory reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system. Used for audit trail and data lineage tracking per SOX (Sarbanes-Oxley Act) compliance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the profit centers local currency. Used for multi-currency consolidation and foreign exchange translation per IFRS/GAAP.. Valid values are `^[A-Z]{3}$`',
    `profit_center_description` STRING COMMENT 'Detailed business description of the profit center, including its purpose, services offered, and unique characteristics. Used for internal documentation and reporting context.',
    `effective_end_date` DATE COMMENT 'The date on which this profit center ceased operations or was closed. Null for currently active profit centers. Used for historical reporting and closed property analysis.',
    `effective_start_date` DATE COMMENT 'The date from which this profit center became active and began contributing to financial statements. Used for time-based reporting and historical analysis.',
    `email_address` STRING COMMENT 'Primary email address for business correspondence related to this profit center. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter functional currency code for financial consolidation. May differ from local currency for properties operating in high-inflation or multi-currency environments.. Valid values are `^[A-Z]{3}$`',
    `hierarchy_level` STRING COMMENT 'The level of this profit center within the profit center hierarchy (1 = top-level property, 2 = department, 3 = sub-department, etc.). Used for recursive roll-up calculations.',
    `is_consolidated` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centers financial results are included in consolidated financial statements. Used for inter-company elimination and segment reporting per IFRS/GAAP.',
    `is_revenue_generating` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center directly generates guest-facing revenue (true) or is a support/overhead center (false). Used for GOP (Gross Operating Profit) and departmental profit analysis per USALI.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this profit center record. Used for change tracking and audit compliance per SOX (Sarbanes-Oxley Act).',
    `profit_center_name` STRING COMMENT 'The full business name of the profit center (e.g., Grand Plaza Hotel Downtown, Rooftop Bar & Lounge, Convention Center Ballroom A).',
    `opening_date` DATE COMMENT 'The original opening or launch date of the profit center. Used for property age analysis and lifecycle reporting.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the profit center. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the profit centers address.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active centers contribute to consolidated financial statements; inactive or closed centers are excluded from operational reporting.. Valid values are `active|inactive|suspended|closed|pending_activation`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by business unit type. Determines the applicable revenue and cost accounting rules per USALI departmental structure. [ENUM-REF-CANDIDATE: property|fnb_outlet|event_venue|spa|retail|parking|other — 7 candidates stripped; promote to reference product]',
    `room_count` STRING COMMENT 'Total number of guest rooms or keys available at this profit center (applicable only to property-level profit centers). Used for RevPAR (Revenue Per Available Room), GOPPAR (Gross Operating Profit Per Available Room), and occupancy calculations.',
    `seating_capacity` STRING COMMENT 'Maximum seating capacity for F&B (Food and Beverage) outlets or event venues. Used for revenue per seat analysis and capacity utilization reporting.',
    `segment_code` STRING COMMENT 'Business segment classification for the profit center (e.g., luxury, premium, select-service). Aligns with IFRS 8 segment reporting requirements and STR (Smith Travel Research) competitive set definitions.. Valid values are `luxury|premium|select_service|extended_stay|resort|other`',
    `short_name` STRING COMMENT 'Abbreviated or short name for the profit center used in reports and dashboards where space is limited.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the profit centers physical space. Used for revenue per square foot analysis and space utilization metrics.',
    `star_rating` DECIMAL(18,2) COMMENT 'Official star rating or quality classification for the profit center (e.g., 3.5, 4.0, 5.0). Used for competitive set analysis and ADR (Average Daily Rate) benchmarking per STR (Smith Travel Research) standards.',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for the profit centers location. Used for tax jurisdiction determination and regulatory reporting.. Valid values are `^[A-Z]{2,3}$`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code for sales tax, VAT (Value-Added Tax), or GST (Goods and Services Tax) reporting. Used for compliance with local tax regulations and automated tax calculation.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master representing revenue-generating business units within the property portfolio (e.g., individual hotels, resorts, F&B outlets, event venues). Enables property-level P&L reporting, RevPAR contribution analysis, and GOPPAR tracking. Supports consolidated financial statements across the portfolio. Sourced from SAP S/4HANA Profit Center Accounting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry transaction.',
    `allocation_run_id` BIGINT COMMENT 'Identifier of the cost allocation or expense distribution run that generated this journal entry, if applicable. Null for non-allocation entries. Used to track automated allocation postings.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries are allocated to cost centers for departmental accounting. The cost_center STRING attribute should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cost ',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the fixed asset or FF&E item to which this journal entry is related, if applicable. Used for asset acquisition, depreciation, and disposal tracking.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entries post to GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data for financi',
    `payroll_run_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_run. Business justification: Payroll journal entries must reference the source payroll run for audit trail, GL-to-payroll reconciliation, and SOX compliance - enables auditors to trace GL postings back to source payroll calculati',
    `employee_id` BIGINT COMMENT 'User ID or employee identifier of the person who created this journal entry in the system. Part of the SOX-compliant audit trail.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries are allocated to profit centers for revenue-generating business unit tracking. The profit_center STRING attribute should be replaced with a proper FK to profit_center.profit_center_id ',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property or resort to which this journal entry is attributed. Enables property-level P&L and financial reporting.',
    `recurring_entry_template_id` BIGINT COMMENT 'Identifier of the recurring journal entry template from which this entry was generated, if applicable. Null for non-recurring entries. Used to track automated periodic postings.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Manual journal entries often adjust revenue center-specific accounts (accruals, corrections, allocations). JE already links to cost_center and profit_center; adding revenue_center enables direct F&B d',
    `tertiary_journal_posted_by_user_employee_id` BIGINT COMMENT 'User ID or employee identifier of the person who executed the final posting of this journal entry to the general ledger. Null if not yet posted. Part of SOX segregation of duties controls.',
    `approved_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry was approved for posting. Null if not yet approved. Part of the approval workflow audit trail.',
    `audit_trail_notes` STRING COMMENT 'Additional audit trail notes or comments added by approvers, auditors, or system administrators for compliance and review purposes.',
    `capex_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry relates to capital expenditure (CapEx) or furniture, fixtures, and equipment (FF&E) investments. True for CapEx/FF&E entries, False for operating expenditure (OpEx).',
    `company_code` STRING COMMENT 'The legal entity or company code within the enterprise structure to which this journal entry belongs. Used for consolidated financial reporting and intercompany elimination.. Valid values are `^[A-Z0-9]{4,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was first created in the general ledger system. Part of the complete audit trail for SOX compliance.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount for this journal entry in the functional currency. Must balance with debit amount per double-entry accounting principles.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The total debit amount for this journal entry in the functional currency. Must balance with credit amount per double-entry accounting principles.',
    `journal_entry_description` STRING COMMENT 'Free-text narrative description of the business purpose and nature of this journal entry. Provides context for auditors and financial analysts.',
    `document_number` STRING COMMENT 'Externally-known unique document number assigned to this journal entry for reference and audit trail purposes. Typically follows format JE followed by numeric sequence.. Valid values are `^JE[0-9]{8,12}$`',
    `document_type` STRING COMMENT 'Classification of the journal entry by its business purpose: standard (regular postings), allocation (cost distribution), intercompany (cross-entity transactions), recurring (template-based periodic entries), accrual (period-end adjustments), reversal (correction entries).. Valid values are `standard|allocation|intercompany|recurring|accrual|reversal`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert transaction currency to functional currency at the time of posting. Null if transaction and functional currencies are the same.',
    `fiscal_period` STRING COMMENT 'The fiscal period (typically month 1-12 or period 1-13 for year-end adjustments) within the fiscal year to which this journal entry is posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry is posted, derived from the posting date and the organizations fiscal calendar.',
    `functional_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the functional currency in which this journal entry is recorded (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction between legal entities within the enterprise. True for intercompany entries requiring elimination in consolidated reporting.',
    `intercompany_partner_code` STRING COMMENT 'The company code of the intercompany partner entity for intercompany transactions. Used for intercompany reconciliation and elimination entries in consolidated financial statements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was last modified. Tracks all changes for audit and compliance purposes.',
    `posted_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry was posted to the general ledger. Null if not yet posted. This is the system processing time, distinct from the posting_date which is the accounting date.',
    `posting_date` DATE COMMENT 'The accounting date when this journal entry is posted to the general ledger. This is the business event date that determines which fiscal period the entry impacts, distinct from the creation or approval timestamps.',
    `posting_status` STRING COMMENT 'Current lifecycle state of the journal entry in the approval and posting workflow. Tracks progression from draft creation through approval to final posting in the general ledger.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `reference_text` STRING COMMENT 'Additional reference information or notes related to this journal entry, such as supporting documentation references, approval notes, or special instructions.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previous entry. True if this is a reversal entry, False otherwise.',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True.',
    `source_document_reference` STRING COMMENT 'Reference number or identifier of the originating source transaction document (e.g., invoice number, payment document, POS check number) that triggered this journal entry.',
    `tax_code` STRING COMMENT 'The tax code or tax jurisdiction code applicable to this journal entry, if the entry involves tax-related postings (sales tax, VAT, occupancy tax, etc.).',
    `transaction_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code of the original transaction currency if different from functional currency. Used for foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General Ledger journal entry transactional record capturing all financial postings including accruals, adjustments, intercompany transfers, expense allocations, and period-end closing entries. Each entry carries debit/credit totals, posting date, fiscal period, document type (standard, allocation, intercompany, recurring), reference to source transaction, and full audit trail (created by, approved by, posting timestamp). Supports SOX audit trail requirements, intercompany elimination tracking, and GAAP/IFRS compliance. Sourced from SAP S/4HANA GL.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for granular financial transaction analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each journal entry line is allocated to a specific cost center for departmental accounting. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable join',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line to the overall journal entry batch and posting context.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Each journal entry line posts to a specific GL account. The gl_account_code and gl_account_name STRING attributes should be replaced with a proper FK to ledger.ledger_id to enable joining to the autho',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each journal entry line is allocated to a specific profit center for revenue-generating business unit tracking. The profit_center_code STRING should be replaced with a proper FK to profit_center.profi',
    `property_id` BIGINT COMMENT 'FK to property.property.property_id',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: GL line items for vendor expenses (utilities, maintenance, services) need direct vendor attribution for spend analytics, vendor performance tracking, and USALI departmental cost reporting by vendor.',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'Line item amount converted to the corporate currency. Used for consolidated financial statements and EBITDA reporting.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Line item amount converted to the property or entity local currency. Used for property-level P&L and GOP calculation.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Line item amount in the original transaction currency. Supports multi-currency operations for international properties.',
    `asset_number` STRING COMMENT 'Fixed asset number for CapEx and FF&E line items. Links GL entry to asset master for depreciation and asset management.. Valid values are `^[A-Z0-9]{1,12}$`',
    `assignment_field` STRING COMMENT 'Assignment field for additional sorting and grouping. Used for payment clearing, reconciliation, and sub-ledger matching.. Valid values are `^[A-Z0-9]{1,18}$`',
    `baseline_payment_date` DATE COMMENT 'Baseline date for payment terms calculation. Used for AP aging and cash flow forecasting.',
    `business_area_code` STRING COMMENT 'Business area classification for segment reporting. Used for brand, region, or business unit financial consolidation.. Valid values are `^[A-Z0-9]{2,8}$`',
    `capex_indicator` BOOLEAN COMMENT 'Indicates whether this line item represents capital expenditure (CapEx or FF&E). Used for asset capitalization and depreciation tracking.',
    `clearing_date` DATE COMMENT 'Date when this open item was cleared. Critical for cash application and AR/AP aging analysis.',
    `clearing_document_number` STRING COMMENT 'Document number that cleared this open item. Used for payment reconciliation and AR/AP management.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was created in the system. Audit trail for data lineage and SOX compliance.',
    `customer_code` STRING COMMENT 'Customer or guest account code for AR line items. Links GL entry to customer master for receivables management.. Valid values are `^[A-Z0-9]{6,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) entry. Fundamental to double-entry bookkeeping and GL balancing.. Valid values are `D|C`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to local or group currency. Critical for multi-currency financial accuracy.',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales and functional expense reporting per USALI standards.. Valid values are `^[A-Z0-9]{2,8}$`',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency. Used for consolidated financial reporting.. Valid values are `^[A-Z]{3}$`',
    `line_item_text` STRING COMMENT 'Free-text description of the line item. Provides business context for the transaction for audit and analysis purposes.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the order of line items for display and audit purposes.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local currency amount. Typically the property operating currency.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was last modified. Audit trail for change tracking and SOX compliance.',
    `payment_terms_code` STRING COMMENT 'Payment terms code for AP/AR line items. Determines due date calculation and discount eligibility.. Valid values are `^[A-Z0-9]{2,6}$`',
    `posting_key` STRING COMMENT 'SAP posting key that controls the account type and debit/credit behavior. Standard SAP GL posting control mechanism.. Valid values are `^[0-9]{2}$`',
    `project_code` STRING COMMENT 'Project or work breakdown structure (WBS) element for capital projects, renovations, or PIP (Property Improvement Plan) tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `reference_document_number` STRING COMMENT 'External reference document number (invoice, receipt, PO). Links GL entry to source operational transaction.. Valid values are `^[A-Z0-9]{1,16}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal entry. Used for error correction and period-end adjustments.',
    `reversed_document_number` STRING COMMENT 'Document number of the original entry that this line reverses. Maintains audit trail for corrections.. Valid values are `^[0-9]{10}$`',
    `segment_code` STRING COMMENT 'Segment code for IFRS segment reporting. Supports brand, geography, or service-line financial disclosure.. Valid values are `^[A-Z0-9]{2,8}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this line item is subject to SOX financial controls. Required for publicly traded hospitality companies.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item. Supports tax reporting and compliance requirements.',
    `tax_code` STRING COMMENT 'Tax code applied to this line item. Determines tax treatment for VAT, sales tax, occupancy tax, or other jurisdiction-specific taxes.. Valid values are `^[A-Z0-9]{2,6}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner or intercompany entity code. Enables intercompany elimination and consolidation for multi-entity groups.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount. Enables multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `usali_department_code` STRING COMMENT 'USALI-compliant department code for hospitality-specific P&L reporting (rooms, F&B, GOP, undistributed expenses).. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a GL journal entry, capturing the specific account, cost center, profit center, debit/credit indicator, amount in transaction and local currency, tax code, and business area. Enables granular financial analysis at the account-line level. Required for USALI departmental reporting and SOX controls. Sourced from SAP S/4HANA GL line items.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoices are allocated to cost centers for departmental accounting per USALI standards. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joini',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to property.franchise_agreement. Business justification: Franchise fee invoices (royalty, marketing, reservation fees) reference specific franchise agreements for rate validation and compliance tracking. Real AP processing verifies fees against agreement te',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Three-way match validation requires direct link from invoice to goods receipt for quantity/quality verification, critical for F&B perishables and FF&E capital purchases before payment processing.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AP invoices post to GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data (account_name, ',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this invoice is assigned. Links to the property master.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order number that authorized this procurement. May be null for non-PO invoices.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Outlet-specific AP invoices (supplies, equipment, services) must allocate to revenue centers for departmental P&L accuracy. Enables USALI-compliant expense allocation, supports outlet-level profitabil',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who issued this invoice. Links to the vendor master in procurement domain.',
    `approval_status` STRING COMMENT 'Current approval status of the invoice in the multi-level approval workflow. Supports SOX financial controls.. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the invoice. Supports audit trail and SOX compliance.',
    `approved_date` DATE COMMENT 'The date the invoice was approved for payment. Key milestone in the AP workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ap_invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides business context for the procurement.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or negotiated discount amount applied to the invoice.',
    `dispute_date` DATE COMMENT 'The date the invoice was flagged as disputed. Null if no dispute exists.',
    `dispute_reason` STRING COMMENT 'Reason for disputing the invoice (e.g., pricing discrepancy, quantity mismatch, quality issue). Populated when invoice_status is disputed.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `expense_category` STRING COMMENT 'Classification of the expense type. OpEx (Operating Expenditure) for recurring costs, CapEx (Capital Expenditure) for long-term assets, FF&E (Furniture Fixtures and Equipment) for property improvements.. Valid values are `opex|capex|ffe`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this invoice is assigned.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice is assigned for financial reporting purposes.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before taxes and adjustments. Base amount for goods or services procured.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The externally-known unique invoice number assigned by the vendor. Business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the AP workflow. Tracks approval and payment state. [ENUM-REF-CANDIDATE: pending|approved|rejected|paid|cancelled|on_hold|disputed — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice type. Standard invoices represent normal purchases; credit memos represent vendor credits or returns.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this is a recurring invoice (e.g., monthly utilities, annual subscriptions). True if recurring, False otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Audit trail field for change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final payable amount after applying taxes, discounts, and adjustments. This is the amount due to the vendor.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. Used for special instructions, exceptions, or internal communication.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on the invoice. Calculated as net_amount minus paid_amount.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The total amount paid against this invoice to date. May be partial or full payment.',
    `payment_date` DATE COMMENT 'The date the payment was issued to the vendor. Null if invoice is unpaid.',
    `payment_method` STRING COMMENT 'The payment instrument used to pay the invoice (check, ACH, wire transfer, credit card, electronic funds transfer).. Valid values are `check|ach|wire_transfer|credit_card|eft`',
    `payment_reference_number` STRING COMMENT 'The reference number or transaction ID for the payment made against this invoice (e.g., check number, ACH trace number).',
    `payment_terms` STRING COMMENT 'The payment terms negotiated with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines discount and due date calculation.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. May differ from invoice date for period-end accruals.',
    `received_date` DATE COMMENT 'The date the invoice was received by the property or corporate AP department.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice (sales tax, VAT, GST, etc.).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation (PO, goods receipt, invoice). Ensures invoice accuracy and prevents duplicate payments.. Valid values are `matched|unmatched|exception`',
    `vendor_tax_number` STRING COMMENT 'The tax identification number (TIN, EIN, VAT number) of the vendor. Required for 1099 reporting and tax compliance.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts Payable invoice master representing vendor invoices received for goods and services procured by the property (FF&E, OTA commissions, utilities, F&B supplies). Tracks invoice number, vendor, PO reference, invoice date, due date, payment terms, gross amount, tax amount, and approval status. Sourced from SAP S/4HANA AP module. Supports CPOR analysis and OpEx management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the AP invoice being paid by this payment transaction.',
    `original_payment_ap_payment_id` BIGINT COMMENT 'Reference to the original payment transaction if this is a reversal or correction payment.',
    `payment_run_id` BIGINT COMMENT 'Identifier for the batch payment run that generated this payment, used for grouping payments processed together.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which this payment was disbursed.',
    `property_id` BIGINT COMMENT 'Reference to the property from which this payment originates.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor receiving this payment.',
    `approval_status` STRING COMMENT 'Workflow approval status indicating whether the payment has been authorized for processing.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this payment for processing, supporting SOX compliance and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was approved, supporting audit trail and SOX compliance requirements.',
    `bank_fee_amount` DECIMAL(18,2) COMMENT 'Transaction fees charged by the bank or payment processor for executing this payment.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the company base currency using the exchange rate for consolidated reporting.',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the company base currency used for financial reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `check_number` STRING COMMENT 'Physical check number when payment method is check, used for reconciliation and audit trail.',
    `clearing_date` DATE COMMENT 'The date on which the payment cleared the bank and was confirmed as successfully processed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or cash discount amount taken on this payment, reducing the total amount paid.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied when payment currency differs from the company base currency or invoice currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when this payment transaction is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this payment transaction is recorded for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'The accounting period date when this payment transaction was posted to the general ledger.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this payment record, supporting audit trail requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last updated or modified.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed to the vendor after all discounts, withholdings, and fees are applied.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross amount disbursed to the vendor in the payment currency before any adjustments or fees.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the payment was issued or executed. Principal business event timestamp for this transaction.',
    `payment_description` STRING COMMENT 'Free-text description or memo providing additional context about the payment purpose or details.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used to disburse funds to the vendor (e.g., ACH, wire transfer, check, EFT).. Valid values are `ACH|wire_transfer|check|electronic_funds_transfer|credit_card|cash`',
    `payment_number` STRING COMMENT 'Externally-known unique payment document number assigned by the payment system or payment run.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating its processing state.. Valid values are `pending|processed|cleared|failed|cancelled|reversed`',
    `payment_terms` STRING COMMENT 'Payment terms applied to this transaction (e.g., Net 30, 2/10 Net 30) indicating discount and due date conditions.',
    `payment_type` STRING COMMENT 'Classification of the payment transaction indicating its purpose or nature within the AP lifecycle.. Valid values are `standard|advance|partial|final|refund|reversal`',
    `reference_number` STRING COMMENT 'External reference number or transaction ID provided by the bank or payment processor for tracking and reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payment has been reversed or cancelled after initial processing.',
    `reversal_reason` STRING COMMENT 'Explanation or reason code for why the payment was reversed, supporting audit and reconciliation processes.',
    `value_date` DATE COMMENT 'The date on which the payment amount is debited from the company bank account and becomes effective for cash flow purposes.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from the payment as required by tax regulations, reducing the net amount paid to vendor.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this payment record, supporting audit trail requirements.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts Payable payment transaction recording disbursements made to vendors against AP invoices. Captures payment date, payment method (ACH, wire, check), bank account, cleared amount, exchange rate for foreign currency payments, and payment run reference. Supports cash flow management and vendor reconciliation. Sourced from SAP S/4HANA AP payment runs.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account for direct-bill invoices. Null for non-corporate invoices.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile associated with this invoice. Null for non-guest invoices.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AR invoices post to GL accounts for revenue recognition. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data for financial re',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where charges were incurred and invoice was generated.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the primary reservation associated with this invoice. Null for non-room invoices.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total post-billing adjustments including service recovery credits, billing corrections, and dispute resolutions. Can be positive or negative.',
    `aging_bucket` STRING COMMENT 'Categorization of invoice age for accounts receivable aging reports and collection workflow assignment.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `ancillary_revenue_amount` DECIMAL(18,2) COMMENT 'Total ancillary service charges including spa, parking, resort fees, minibar, laundry, and other guest services.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for the entity being invoiced.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, apartment, building).',
    `billing_city` STRING COMMENT 'City of the billing address.',
    `billing_contact_email` STRING COMMENT 'Email address for invoice delivery and billing correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_phone` STRING COMMENT 'Phone number for billing inquiries and collection contact.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_entity_name` STRING COMMENT 'Legal name of the entity being billed (guest, company, agency, or OTA partner).',
    `billing_entity_type` STRING COMMENT 'Type of entity being billed. Used for segmentation and credit policy application. [ENUM-REF-CANDIDATE: individual|corporate|travel_agency|ota|group|government|other — 7 candidates stripped; promote to reference product]',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address.',
    `billing_state_province` STRING COMMENT 'State or province of the billing address.',
    `collection_status` STRING COMMENT 'Current status of collection efforts for overdue invoices.. Valid values are `not_started|in_progress|on_hold|escalated|legal|resolved`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice.. Valid values are `^[A-Z]{3}$`',
    `days_outstanding` STRING COMMENT 'Number of days since invoice date. Used for aging analysis and collection prioritization.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discounts applied to this invoice including promotional discounts, loyalty rewards, and negotiated rate adjustments.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice is currently under dispute by the billing entity.',
    `dispute_reason` STRING COMMENT 'Description of the reason for invoice dispute if dispute_flag is true.',
    `due_date` DATE COMMENT 'The date by which payment is expected based on payment terms. Used for aging and collection prioritization.',
    `event_revenue_amount` DECIMAL(18,2) COMMENT 'Total event and meeting charges including space rental, audio-visual, and catering for Meetings, Incentives, Conferences, and Exhibitions (MICE).',
    `fnb_revenue_amount` DECIMAL(18,2) COMMENT 'Total food and beverage charges on this invoice from restaurants, bars, room service, and banquets.',
    `folio_number` STRING COMMENT 'The externally-known unique folio number assigned to this invoice in the Property Management System (PMS). Used for guest and accounting reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `invoice_date` DATE COMMENT 'The date the invoice was issued. Used for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'The official invoice number used for accounting and legal purposes. May differ from folio number for consolidated billing.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts receivable workflow. [ENUM-REF-CANDIDATE: draft|open|sent|partially_paid|paid|overdue|disputed|written_off|cancelled — 9 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the billing entity type. Determines billing workflow and collection procedures. [ENUM-REF-CANDIDATE: guest|corporate|group|travel_agency|ota|event|direct_bill — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User ID or system identifier that last modified this invoice record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this invoice for internal reference and customer communication.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice (total_amount minus paid_amount). Used for aging and collection prioritization.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid against this invoice to date. Updated as payments are received and applied.',
    `payment_method` STRING COMMENT 'Primary payment instrument type used or expected for this invoice. [ENUM-REF-CANDIDATE: credit_card|debit_card|bank_transfer|check|cash|direct_bill|virtual_card|other — 8 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this invoice. Determines due date calculation and collection procedures. [ENUM-REF-CANDIDATE: due_on_receipt|net_15|net_30|net_45|net_60|net_90|custom — 7 candidates stripped; promote to reference product]',
    `revenue_recognition_date` DATE COMMENT 'Date revenue was recognized for this invoice per GAAP/IFRS revenue recognition standards (ASC 606 / IFRS 15).',
    `room_revenue_amount` DECIMAL(18,2) COMMENT 'Total room and accommodation charges on this invoice. Key component of Average Daily Rate (ADR) and Revenue Per Available Room (RevPAR) calculations.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Total service charges and gratuities applied to this invoice, typically for F&B and event services.',
    `service_end_date` DATE COMMENT 'The last date of service covered by this invoice (e.g., check-out date for room charges).',
    `service_start_date` DATE COMMENT 'The first date of service covered by this invoice (e.g., check-in date for room charges).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all revenue line items before taxes and fees. Used for tax calculation base.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes applied to this invoice including occupancy tax, sales tax, VAT, and local jurisdiction taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final invoice total including all charges, taxes, fees, discounts, and adjustments. This is the amount due from the billing entity.',
    `write_off_date` DATE COMMENT 'Date the invoice was written off if write_off_flag is true.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether this invoice has been written off as uncollectible bad debt.',
    `write_off_reason` STRING COMMENT 'Business justification for writing off this invoice.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this invoice record.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts Receivable invoice representing charges billed to guests, corporate accounts, travel agencies, and OTA partners for hotel stays, F&B, events, and ancillary services. Tracks folio number, billing entity, invoice date, due date, total charges, taxes, outstanding balance, and collection status. Sourced from Oracle OPERA PMS AR module and SAP S/4HANA AR. Supports ADR and TRevPAR revenue recognition.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Unique identifier for the accounts receivable payment transaction. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Reference to the AR invoice against which this payment is applied. Links payment to the originating invoice for reconciliation and revenue recognition.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account making the payment. Applicable for direct bill corporate payments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR payments are allocated to cost centers for departmental cash receipt tracking. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cos',
    `employee_id` BIGINT COMMENT 'Reference to the cashier or staff member who processed the payment. Used for audit trail and SOX compliance.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who made the payment. Applicable for individual guest payments.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AR payments post to GL accounts for cash receipt and accounts receivable tracking. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account ma',
    `ota_partner_id` BIGINT COMMENT 'Reference to the OTA partner remitting payment. Applicable for OTA settlement payments.',
    `property_id` BIGINT COMMENT 'Reference to the property where the payment was received. Supports property-level financial reporting and reconciliation.',
    `reversed_payment_ar_payment_id` BIGINT COMMENT 'Reference to the original payment that this payment reverses. Creates audit trail for payment corrections and chargebacks.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied to specific AR invoices. May differ from payment amount if payment is partially applied or unapplied.',
    `authorization_code` STRING COMMENT 'Authorization code provided by payment processor or card issuer confirming approval of the payment transaction. Used for reconciliation and dispute resolution.',
    `bank_name` STRING COMMENT 'The name of the bank or financial institution for check, wire transfer, or ACH payments. Used for reconciliation and tracking.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the property base currency using the exchange rate. Used for consolidated financial reporting.',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the property base currency. Standard currency for property-level financial reporting.. Valid values are `^[A-Z]{3}$`',
    `card_last_four` STRING COMMENT 'The last four digits of the payment card number. Used for payment identification while maintaining PCI DSS compliance.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'The credit or debit card brand used for the payment. Applicable only for card-based payment methods. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners|unionpay — 7 candidates stripped; promote to reference product]',
    `cardholder_name` STRING COMMENT 'The name of the cardholder as it appears on the payment card. Used for verification and reconciliation purposes.',
    `check_number` STRING COMMENT 'The check number for check-based payments. Used for tracking and reconciliation with bank deposits.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and SOX compliance.',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited to the property bank account. Used for cash flow tracking and bank reconciliation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment currency to the property base currency. Used for multi-currency payment processing.',
    `is_advance_deposit` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is an advance deposit received prior to guest arrival or service delivery. Used for revenue recognition timing.',
    `is_refund` BOOLEAN COMMENT 'Boolean flag indicating whether this payment represents a refund to the guest or customer. True if refund, False if collection.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking per SOX requirements.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net amount received after deducting transaction fees. Represents actual cash collected by the property.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross amount received in the payment transaction, in the payment currency. Represents the total collected before any adjustments or fees.',
    `payment_channel` STRING COMMENT 'The interface or touchpoint through which the payment was received. Includes front desk, online portal, mobile app, call center, self-service kiosk, or mail.. Valid values are `front_desk|online|mobile_app|call_center|kiosk|mail`',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Indicates the currency in which the payment was received.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The business date on which the payment was received or posted. Used for revenue recognition and cash flow reporting per USALI standards.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to make the payment. Includes credit card, debit card, cash, check, wire transfer, ACH, or direct bill settlement. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|check|wire_transfer|ach|direct_bill — 7 candidates stripped; promote to reference product]',
    `payment_notes` STRING COMMENT 'Free-text notes or comments about the payment transaction. Used to capture special instructions, exceptions, or additional context.',
    `payment_number` STRING COMMENT 'Externally visible unique payment reference number used for tracking and reconciliation. Generated by PMS or financial system.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks progression from authorization through settlement or failure. [ENUM-REF-CANDIDATE: pending|authorized|captured|settled|failed|reversed|refunded — 7 candidates stripped; promote to reference product]',
    `payment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment transaction was recorded in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `reference_number` STRING COMMENT 'External reference number provided by the payer or payment processor. Used for cross-referencing with external systems and statements.',
    `reversal_reason` STRING COMMENT 'The reason for payment reversal if the payment status is reversed. Includes chargeback, error correction, guest dispute, etc.',
    `settlement_date` DATE COMMENT 'The date on which the payment processor settled funds to the property account. Used for reconciliation with processor settlement reports.',
    `shift_code` BIGINT COMMENT 'Reference to the cashier shift during which the payment was processed. Used for shift reconciliation and cash drawer balancing.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Processing fee charged by payment processor or financial institution for the transaction. Includes credit card merchant fees, wire transfer fees, etc.',
    `transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor or gateway. Used for tracking and reconciliation with processor settlement reports.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has not yet been applied to specific AR invoices. Represents credit on account or overpayment.',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts Receivable payment transaction recording collections received from guests, corporate accounts, and OTA partners against AR invoices. Captures payment date, payment method (credit card, direct bill, OTA settlement), amount received, currency, exchange rate, and application to specific invoices. Supports revenue recognition and cash management. Sourced from Oracle OPERA PMS cashiering and SAP S/4HANA AR.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the finance budget record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial budgets are allocated to cost centers for departmental budget planning. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cos',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Financial budgets are planned for specific GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account mast',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Financial budgets are allocated to profit centers for revenue-generating business unit budget planning. The profit_center_code STRING should be replaced with a proper FK to profit_center.profit_center',
    `property_id` BIGINT COMMENT 'Reference to the property for which this budget applies. Links to property master data.',
    `amount` DECIMAL(18,2) COMMENT 'The planned or forecasted monetary amount for this budget line item. Represents the target financial value for the specified GL account, cost center, and fiscal period combination.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or committee who approved this budget. Supports SOX financial controls and audit trail.',
    `approved_date` DATE COMMENT 'The date on which this budget was formally approved. Critical for audit trail and SOX compliance.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line: revenue (rooms, F&B, events), operating expense (utilities, supplies), labor expense (wages, benefits), capital expenditure (CapEx), or furniture, fixtures, and equipment (FF&E) reserve.. Valid values are `revenue|operating_expense|labor_expense|capex|ffe_reserve`',
    `budget_name` STRING COMMENT 'Descriptive name of the budget (e.g., FY2024 Annual Operating Budget, Q2 2024 Reforecast).',
    `budget_number` STRING COMMENT 'Externally-known unique identifier for this budget document. Used for reference in management reports and approvals.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (in preparation), submitted (awaiting approval), under review (being evaluated), approved (finalized), active (in use), closed (period ended), or superseded (replaced by newer version). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|closed|superseded — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by planning cycle: annual operating budget, quarterly forecast, monthly budget, rolling forecast, reforecast, or capital expenditure budget.. Valid values are `annual|quarterly|monthly|rolling_forecast|reforecast|capital`',
    `budgeted_adr` DECIMAL(18,2) COMMENT 'Forecasted Average Daily Rate for the budget period. Calculated as rooms revenue divided by rooms sold. Key rooms division KPI.',
    `budgeted_available_rooms` STRING COMMENT 'Forecasted total number of room nights available for sale during the budget period. Accounts for planned renovations and out-of-order rooms.',
    `budgeted_covers` STRING COMMENT 'Forecasted total number of F&B covers (guests served) for the budget period. Key volume metric for food and beverage operations.',
    `budgeted_cpor` DECIMAL(18,2) COMMENT 'Forecasted Cost Per Occupied Room for the budget period. Calculated as total departmental expenses divided by rooms sold. Measures cost efficiency.',
    `budgeted_ebitda` DECIMAL(18,2) COMMENT 'Forecasted EBITDA for the budget period. Represents operating profitability before financing and non-cash charges.',
    `budgeted_events_revenue` DECIMAL(18,2) COMMENT 'Forecasted total events and meetings revenue for the budget period. Includes MICE (Meetings, Incentives, Conferences, Exhibitions) revenue.',
    `budgeted_fnb_revenue` DECIMAL(18,2) COMMENT 'Forecasted total food and beverage revenue for the budget period. Includes restaurant, bar, banquet, and room service revenue.',
    `budgeted_gop` DECIMAL(18,2) COMMENT 'Forecasted Gross Operating Profit for the budget period. Calculated as total revenue minus departmental expenses and undistributed operating expenses. Key profitability metric per USALI.',
    `budgeted_goppar` DECIMAL(18,2) COMMENT 'Forecasted Gross Operating Profit Per Available Room for the budget period. Calculated as GOP divided by available rooms. Measures profitability efficiency.',
    `budgeted_labor_expense` DECIMAL(18,2) COMMENT 'Forecasted total labor costs including wages, salaries, benefits, and payroll taxes for the budget period.',
    `budgeted_noi` DECIMAL(18,2) COMMENT 'Forecasted Net Operating Income for the budget period. Represents property-level profitability after all operating expenses but before debt service and taxes.',
    `budgeted_occupancy_rate` DECIMAL(18,2) COMMENT 'Forecasted occupancy rate as a percentage for the budget period. Calculated as rooms sold divided by rooms available. Key demand metric.',
    `budgeted_operating_expense` DECIMAL(18,2) COMMENT 'Forecasted total operating expenses excluding labor for the budget period. Includes utilities, supplies, maintenance, and other departmental expenses.',
    `budgeted_other_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from other sources (spa, parking, telecommunications, etc.) for the budget period.',
    `budgeted_revpar` DECIMAL(18,2) COMMENT 'Forecasted Revenue Per Available Room for the budget period. Calculated as rooms revenue divided by available rooms, or ADR multiplied by occupancy rate. Primary revenue performance metric.',
    `budgeted_room_nights` STRING COMMENT 'Forecasted total number of room nights sold for the budget period. Key volume metric for rooms division.',
    `budgeted_rooms_revenue` DECIMAL(18,2) COMMENT 'Forecasted total rooms revenue for the budget period. Key metric for rooms division performance planning.',
    `budgeted_total_revenue` DECIMAL(18,2) COMMENT 'Forecasted total revenue across all departments for the budget period. Sum of rooms, F&B, events, and other revenue.',
    `budgeted_trevpar` DECIMAL(18,2) COMMENT 'Forecasted Total Revenue Per Available Room for the budget period. Calculated as total property revenue divided by available rooms. Measures total revenue productivity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget ceases to be effective. Null for open-ended budgets.',
    `effective_start_date` DATE COMMENT 'The date from which this budget becomes effective and active for planning and variance analysis.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the year (e.g., P01, P02, Q1, FY). Supports monthly, quarterly, and annual budget granularity.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies (e.g., 2024).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last updated. Supports change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text notes and commentary regarding budget assumptions, variances from prior periods, strategic initiatives, or special considerations.',
    `version` STRING COMMENT 'Version identifier for the budget (e.g., V1.0, V2.1 Reforecast). Supports tracking of budget revisions and reforecasts.',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Annual and periodic financial budget master representing planned and forecasted financial targets at both header and line-item granularity. Each budget contains line items by GL account, cost center, profit center, and fiscal period combination. Supports approved annual budgets, rolling forecasts, and reforecasts (distinguished by budget type/version). Captures budgeted revenue (rooms, F&B, events), budgeted expenses (labor, CPOR, FF&E reserve contributions), and budgeted KPIs (ADR, OCC, RevPAR, GOP, EBITDA, NOI). Enables granular budget-vs-actual and forecast-vs-actual variance analysis at the account, department, and property level. Supports USALI departmental budget reporting and management review. Sourced from SAP S/4HANA Planning and Budgeting module. SSOT: defers to revenue.revenue_budget (MVM). [SSOT_OWNER] [SSOT MASTER for group finance.finance_budget] [SSOT:budget] Canonical single-source-of-truth for the budget concept; other domain variants are domain-specific specializations referencing this owner.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Budget planning allocates spend by procurement category (F&B, housekeeping, maintenance, FF&E) for CPOR tracking, category-level variance analysis, and strategic sourcing decisions in hospitality oper',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for departmental budget planning. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cost cen',
    `finance_budget_id` BIGINT COMMENT 'Reference to the parent budget header to which this line item belongs.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Budget lines are planned for specific GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master da',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Budget lines for departmental operating expenses must tie to org units for operational budget ownership, manager accountability, and departmental variance reporting - enables department managers to tr',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Labor budget lines must tie to specific positions for headcount planning, position control, and budget-to-actual variance analysis - enables finance to track budgeted vs actual headcount by position a',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget lines are allocated to profit centers for revenue-generating business unit budget planning. The profit_center_code STRING should be replaced with a proper FK to profit_center.profit_center_id t',
    `property_id` BIGINT COMMENT 'Reference to the property for which this budget line is planned. Enables property-level budget tracking and consolidation.',
    `allocation_driver` STRING COMMENT 'The driver or basis used for allocation if allocation_method is driver-based. Examples include room nights, square footage, headcount, or revenue percentage.',
    `allocation_method` STRING COMMENT 'The method used to allocate this budget line to the cost center or profit center. Supports transparency in budget allocation logic.. Valid values are `direct|allocated|prorated|driver_based`',
    `approval_status` STRING COMMENT 'The current approval status of this budget line. Supports budget workflow and SOX financial controls.. Valid values are `draft|pending_approval|approved|rejected|locked`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this budget line. Supports audit trail and SOX compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line was approved. Supports audit trail and SOX compliance.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line. Distinguishes between revenue, operating expenses, fixed expenses, and capital expenditures per USALI standards.. Valid values are `revenue|operating_expense|fixed_expense|capital_expenditure`',
    `budget_owner` STRING COMMENT 'The name or identifier of the individual or role responsible for this budget line. Supports accountability and budget governance.',
    `budget_type` STRING COMMENT 'The type of budget this line belongs to. Supports multiple budget scenarios for planning and variance analysis.. Valid values are `original|revised|forecast|rolling_forecast|stretch`',
    `budget_version` STRING COMMENT 'The version identifier for this budget line. Supports multiple budget scenarios such as original budget, revised budget, forecast, or rolling forecast.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the planned amount. Supports multi-currency budget planning and consolidation.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code to which this budget line is allocated. Aligns with USALI departmental structure such as Rooms, Food and Beverage, Sales and Marketing, Property Operations and Maintenance.. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_end_date` DATE COMMENT 'The date until which this budget line remains effective. Null indicates the budget line is currently active.',
    `effective_start_date` DATE COMMENT 'The date from which this budget line becomes effective. Supports temporal budget management and mid-year budget changes.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for which this budget line is planned. Typically 1-12 for monthly periods, or 1-13 for 13-period calendars.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget line is planned. Four-digit year representation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line record was last modified. Supports audit trail and change tracking.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the parent budget. Used for ordering and referencing individual budget lines.',
    `locked_flag` BOOLEAN COMMENT 'Indicates whether this budget line is locked from further edits. True if locked, False if editable. Supports budget freeze and SOX controls.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or justification for this budget line. Used for management review and audit trail.',
    `planned_amount` DECIMAL(18,2) COMMENT 'The budgeted monetary amount for this GL account, cost center, profit center, and fiscal period combination. Represents the planned expense or revenue target.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual amount from the prior fiscal year for the same GL account, cost center, and fiscal period. Used for year-over-year budget comparison and trend analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The planned quantity associated with this budget line, if applicable. Used for volume-based budgeting such as room nights, covers, or headcount.',
    `source_system_code` STRING COMMENT 'The unique identifier of this budget line in the source system. Supports data lineage and reconciliation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the budget quantity field. Examples include ROOM_NIGHTS, COVERS, FTE (Full-Time Equivalent), UNITS.. Valid values are `^[A-Z]{2,10}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'The planned unit price or rate used to calculate the planned amount. Derived from planned_amount divided by quantity.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage for this budget line. Used to flag significant budget-vs-actual variances for management review.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual budget line item within a financial budget, capturing the planned amount for a specific GL account, cost center, profit center, and fiscal period combination. Enables granular budget-vs-actual variance analysis at the account and department level. Supports USALI departmental budget reporting and management review. Sourced from SAP S/4HANA budget line items.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset master data product.',
    `capex_request_id` BIGINT COMMENT 'Reference to the original CapEx request or approval that authorized the acquisition of this fixed asset.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed assets are allocated to cost centers for departmental asset tracking and depreciation allocation. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Asset capitalization date and initial valuation depend on goods receipt posting for FF&E and capital improvements; required for PIP project tracking and depreciation start date determination.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Fixed assets post to GL accounts for asset capitalization and depreciation tracking. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account ',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Fixed assets (HVAC, kitchen equipment, pool systems) are physically located in specific facilities. Real asset management requires location tracking for maintenance scheduling, depreciation allocation',
    `property_id` BIGINT COMMENT 'Reference to the property or business unit where this fixed asset is located and capitalized.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order number associated with the acquisition of this fixed asset.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom the fixed asset was purchased.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of acquiring the fixed asset, including purchase price, installation, and directly attributable costs.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or placed into service for accounting purposes.',
    `asset_category` STRING COMMENT 'Detailed sub-classification or category within the asset class for granular reporting and analysis.',
    `asset_class` STRING COMMENT 'Classification of the fixed asset type. FF&E refers to Furniture, Fixtures, and Equipment. [ENUM-REF-CANDIDATE: building|ffe|technology_system|leasehold_improvement|land|vehicle|equipment — 7 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable name or description of the fixed asset.',
    `asset_number` STRING COMMENT 'Externally-known unique asset tag or identification number assigned to the fixed asset for tracking and inventory purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset indicating its operational state and accounting treatment. [ENUM-REF-CANDIDATE: active|in_service|under_construction|retired|disposed|impaired|held_for_sale — 7 candidates stripped; promote to reference product]',
    `capex_approval_status` STRING COMMENT 'Approval status of the CapEx request associated with this fixed asset acquisition.. Valid values are `pending|approved|rejected|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and financial amounts.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation expense for this fixed asset.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculation begins for this fixed asset, typically the in-service date.',
    `disposal_date` DATE COMMENT 'Date when the fixed asset was disposed of, sold, retired, or otherwise removed from service.',
    `disposal_method` STRING COMMENT 'Method by which the fixed asset was disposed of or removed from the asset register.. Valid values are `sale|scrap|donation|trade_in|retirement`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the fixed asset.',
    `ffe_reserve_eligible` BOOLEAN COMMENT 'Indicates whether this asset is eligible for FF&E reserve funding, typically used for planned replacement programs.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'Calculated gain or loss on disposal, computed as disposal proceeds minus net book value at disposal date.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment or shows indicators of impairment.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Amount of impairment loss recognized when the recoverable amount of the asset is less than its carrying value.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering this fixed asset, if separately insured.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or service performed on the fixed asset.',
    `location_description` STRING COMMENT 'Physical location or room number where the fixed asset is installed or stored within the property.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or brand of the fixed asset.',
    `model_number` STRING COMMENT 'Model number or product code of the fixed asset as designated by the manufacturer.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was last modified or updated.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the fixed asset calculated as acquisition cost minus accumulated depreciation.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the fixed asset, including special handling, history, or other relevant information.',
    `pip_reference` STRING COMMENT 'Reference to the Property Improvement Plan under which this asset was acquired or renovated, if applicable.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life, not subject to depreciation.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or unique identifier for the physical asset, if applicable.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the fixed asset in years for depreciation calculation purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty for this fixed asset expires.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master representing the full lifecycle of capitalized property assets from CapEx request through acquisition, depreciation, and disposal. Covers buildings, FF&E (Furniture, Fixtures and Equipment), technology systems, and leasehold improvements. Tracks asset class, PIP (Property Improvement Plan) reference, CapEx approval status, acquisition date, acquisition cost, useful life, depreciation method and schedule, accumulated depreciation, net book value, and disposal status. Supports CapEx planning, depreciation posting to GL, EBITDA calculation (D&A add-back), FF&E reserve tracking, and IFRS/GAAP asset reporting. Sourced from SAP S/4HANA Asset Accounting (FI-AA).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique identifier for the tax posting transaction record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax postings are allocated to cost centers for departmental tax expense tracking. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cos',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Tax postings post to GL accounts for tax liability and expense tracking. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data ',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile for occupancy tax and transient occupancy tax postings.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax postings reference revenue centers for tax allocation. The revenue_center_code STRING should be replaced with a proper FK. Note: The target is profit_center because the existing FK profit_center.r',
    `property_id` BIGINT COMMENT 'Reference to the property where the tax transaction originated.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation for room-related tax postings.',
    `reversed_posting_tax_posting_id` BIGINT COMMENT 'Reference to the original tax posting ID that this record reverses, if applicable.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor for withholding tax postings on vendor payments.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment, correction, or reversal of the tax posting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax posting record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the tax amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'The externally-known unique document number for this tax posting, used for audit trail and reconciliation.',
    `due_date` DATE COMMENT 'The regulatory due date by which this tax must be filed and paid to avoid penalties.',
    `exemption_certificate_number` STRING COMMENT 'The certificate or authorization number supporting the tax exemption claim, if applicable.',
    `exemption_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction qualifies for tax exemption.',
    `filing_date` DATE COMMENT 'The date when the tax return or report was filed with the tax authority.',
    `filing_status` STRING COMMENT 'The current status of the tax filing and payment lifecycle: pending (not yet filed), filed (submitted to authority), paid (remitted), overdue (past due date), disputed (under review), or adjusted (corrected after filing).. Valid values are `pending|filed|paid|overdue|disputed|adjusted`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this tax posting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this tax posting is recorded for financial reporting purposes.',
    `jurisdiction_code` STRING COMMENT 'The standardized code representing the tax jurisdiction for system processing and reporting.',
    `modified_by` STRING COMMENT 'The user ID or system identifier that last modified this tax posting record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax posting record was last modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this tax posting for audit and compliance purposes.',
    `payment_date` DATE COMMENT 'The date when the tax amount was remitted to the tax authority.',
    `posting_date` DATE COMMENT 'The date when the tax transaction was posted to the general ledger.',
    `reporting_period` STRING COMMENT 'The tax reporting period identifier (e.g., monthly, quarterly, annually) for regulatory filing purposes.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax posting is a reversal or correction of a previous posting.',
    `source_document_number` STRING COMMENT 'The reference number of the source document (e.g., folio number, invoice number, check number) that originated this tax transaction.',
    `source_document_type` STRING COMMENT 'The type of source document that generated this tax posting: guest folio (room charges), F&B check, event invoice, vendor invoice, adjustment, or other.. Valid values are `guest_folio|fnb_check|event_invoice|vendor_invoice|adjustment|other`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount posted to the general ledger for this transaction.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'The gross taxable amount upon which the tax is calculated, before tax is applied.',
    `tax_code` STRING COMMENT 'The tax code identifier that defines the tax type, rate, and calculation method (e.g., VAT, GST, TOT, sales tax).',
    `tax_jurisdiction` STRING COMMENT 'The governmental jurisdiction or authority to which this tax is owed (e.g., federal, state, county, city, municipality).',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to the tax base amount to calculate the tax amount.',
    `tax_type` STRING COMMENT 'The category of tax being posted: VAT (Value Added Tax), GST (Goods and Services Tax), occupancy tax, TOT (Transient Occupancy Tax), sales tax on F&B and events, withholding tax on vendor payments, service tax, resort fee tax, or other. [ENUM-REF-CANDIDATE: VAT|GST|occupancy_tax|TOT|sales_tax|withholding_tax|service_tax|resort_fee_tax|other — 9 candidates stripped; promote to reference product]',
    `transaction_date` DATE COMMENT 'The actual business date when the taxable transaction occurred (e.g., guest check-out date, F&B sale date).',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this tax posting record.',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax transaction record capturing all tax-related financial postings including VAT/GST, occupancy tax, transient occupancy tax (TOT), sales tax on F&B and events, and withholding tax on vendor payments. Tracks tax code, tax base amount, tax amount, tax jurisdiction, reporting period, and filing status. Supports regulatory tax compliance and multi-jurisdiction reporting. Sourced from SAP S/4HANA Tax module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Bank accounts are linked to GL accounts for bank reconciliation and cash management. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account ',
    `master_account_bank_account_id` BIGINT COMMENT 'Reference to the master bank account for zero balance account (ZBA) cash pooling arrangements. Null if this is not a ZBA or if this is the master account.',
    `property_id` BIGINT COMMENT 'Reference to the property or corporate entity that owns this bank account. Links to property master data.',
    `account_closed_date` DATE COMMENT 'The date the bank account was closed, if applicable. Null for active accounts.',
    `account_name` STRING COMMENT 'The legal name or title of the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The full bank account number. Stored in masked or encrypted format for security and PCI DSS compliance.',
    `account_number_masked` STRING COMMENT 'Partially masked account number for display purposes (e.g., ****1234). Used in reports and user interfaces to protect sensitive data.',
    `account_opened_date` DATE COMMENT 'The date the bank account was originally opened with the financial institution.',
    `account_purpose` STRING COMMENT 'Description of the primary business purpose or use case for this bank account (e.g., AP disbursements, AR collections, payroll funding, property operating account).',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are available for transactions; inactive or closed accounts are not.. Valid values are `active|inactive|closed|suspended|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account by its primary purpose (checking, savings, money market, payroll, escrow, investment).. Valid values are `checking|savings|money_market|payroll|escrow|investment`',
    `ach_enabled` BOOLEAN COMMENT 'Indicates whether ACH transactions (direct deposits, electronic payments) are enabled for this account.',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance for disbursements, net of holds, pending transactions, and minimum balance requirements.',
    `bank_branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `bank_code` STRING COMMENT 'Unique identifier or code for the bank, often used in internal systems or for integration with treasury management systems.',
    `bank_contact_email` STRING COMMENT 'The email address of the primary bank contact. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary contact person at the bank for account inquiries and issue resolution.',
    `bank_contact_phone` STRING COMMENT 'The phone number of the primary bank contact. Organizational contact data classified as confidential.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `company_code` STRING COMMENT 'The SAP company code or equivalent organizational unit to which this bank account is assigned. Used for financial consolidation and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the account (e.g., USD, EUR, GBP). Supports multi-currency cash pooling and treasury management.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance of the bank account as of the last update or reconciliation. Reflects all posted transactions.',
    `electronic_banking_enabled` BOOLEAN COMMENT 'Indicates whether electronic banking services (ACH, wire transfers, electronic statements) are enabled for this account.',
    `iban` STRING COMMENT 'The International Bank Account Number for accounts in jurisdictions that use IBAN for international transactions.',
    `interest_bearing` BOOLEAN COMMENT 'Indicates whether this account earns interest on deposited funds.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the account balance, expressed as a decimal (e.g., 0.0250 for 2.50%). Null for non-interest-bearing accounts.',
    `is_primary_account` BOOLEAN COMMENT 'Indicates whether this is the primary operating bank account for the property or company code. Used for default account selection in AP and AR processes.',
    `is_zero_balance_account` BOOLEAN COMMENT 'Indicates whether this is a zero balance account that automatically sweeps funds to or from a master account for cash concentration.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent bank reconciliation for this account. Critical for SOX compliance and financial controls.',
    `last_statement_balance` DECIMAL(18,2) COMMENT 'The ending balance reported on the most recent bank statement. Used as the baseline for reconciliation.',
    `last_statement_date` DATE COMMENT 'The date of the most recent bank statement received for this account. Used for reconciliation and cash flow tracking.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account per bank agreement or internal treasury policy.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments about the bank account.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The opening balance of the bank account at the start of the current fiscal period or reconciliation cycle.',
    `positive_pay_enabled` BOOLEAN COMMENT 'Indicates whether positive pay fraud prevention service is enabled. Positive pay matches issued checks against a list to prevent fraudulent checks from clearing.',
    `reconciliation_status` STRING COMMENT 'Current status of the bank reconciliation process. Tracks whether the account has been reconciled, has discrepancies, or is pending review.. Valid values are `reconciled|pending|discrepancy|not_started`',
    `routing_number` STRING COMMENT 'The ABA routing number (US) or equivalent bank routing code used for electronic funds transfers and wire transactions.',
    `swift_code` STRING COMMENT 'The SWIFT/BIC code for international wire transfers. Used for cross-border payments and multi-currency transactions.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `wire_transfer_enabled` BOOLEAN COMMENT 'Indicates whether domestic and international wire transfers are enabled for this account.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master representing property and corporate bank accounts used for cash management, AP disbursements, AR collections, and payroll funding. Tracks bank name, account number (masked), account type, currency, bank routing details, account status, assigned company code, last reconciliation date, reconciliation status, opening/closing balances, and reconciliation history. Supports treasury management, cash flow visibility, automated bank statement reconciliation (SOX control evidence), multi-currency cash pooling, and daily cash position reporting. Sourced from SAP S/4HANA Bank Master Data and Electronic Bank Statement module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` (
    `management_fee_id` BIGINT COMMENT 'Unique identifier for the management fee calculation record. Primary key. Role: TRANSACTION_HEADER.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Management fees are allocated to cost centers for departmental expense tracking. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cost',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the management fee calculation.',
    `hma_contract_id` BIGINT COMMENT 'Reference to the Hotel Management Agreement contract that governs the terms and conditions of this management fee.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Management fees post to GL accounts for expense tracking and P&L reporting. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master da',
    `ownership_entity_id` BIGINT COMMENT 'Reference to the property owner entity that is being charged the management fee under the Hotel Management Agreement (HMA).',
    `primary_prior_period_management_fee_id` BIGINT COMMENT 'Self-referencing FK on management_fee (prior_period_management_fee_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Management fees are allocated to profit centers for revenue-generating business unit expense tracking. The profit_center_code STRING should be replaced with a proper FK to profit_center.profit_center_',
    `property_id` BIGINT COMMENT 'Reference to the hotel property for which the management fee is calculated.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments applied to the calculated management fee (e.g., prior period corrections, contractual adjustments, dispute resolutions).',
    `adjustment_reason` STRING COMMENT 'Business reason or explanation for any adjustment applied to the management fee amount.',
    `approval_status` STRING COMMENT 'Approval status of the management fee calculation, indicating whether it has been reviewed and approved by authorized personnel.. Valid values are `pending|approved|rejected|under_review`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the management fee calculation was approved.',
    `basis_amount` DECIMAL(18,2) COMMENT 'The actual financial amount (gross revenue, GOP, NOI, etc.) used as the calculation basis for this management fee, in the propertys functional currency.',
    `calculation_basis` STRING COMMENT 'The financial metric used as the basis for calculating the management fee amount, as defined in the Hotel Management Agreement (HMA). [ENUM-REF-CANDIDATE: gross_revenue|total_revenue|rooms_revenue|gop|noi|ebitda|adjusted_gop|custom — 8 candidates stripped; promote to reference product]',
    `calculation_date` DATE COMMENT 'Date when the management fee was calculated, representing the principal business event timestamp for this transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this management fee record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the management fee transaction.. Valid values are `^[A-Z]{3}$`',
    `fee_amount` DECIMAL(18,2) COMMENT 'The calculated management fee amount charged to the property owner, in the propertys functional currency.',
    `fee_number` STRING COMMENT 'Externally-known unique identifier or document number for this management fee calculation, used for owner reporting and audit trail.',
    `fee_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the calculation basis to determine the management fee amount, as specified in the Hotel Management Agreement (HMA).',
    `fee_status` STRING COMMENT 'Current lifecycle status of the management fee calculation and payment process. [ENUM-REF-CANDIDATE: draft|calculated|approved|invoiced|paid|disputed|reversed — 7 candidates stripped; promote to reference product]',
    `fee_type` STRING COMMENT 'Classification of the management fee type per the Hotel Management Agreement (HMA). Base fee is typically a percentage of gross revenue; incentive fee is typically a percentage of GOP (Gross Operating Profit) or NOI (Net Operating Income).. Valid values are `base_fee|incentive_fee|combined_fee|special_fee|termination_fee|transition_fee`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year for which the management fee applies.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the management fee applies, aligned with property financial reporting periods.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this management fee represents an intercompany transaction requiring elimination in consolidated financial statements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this management fee record was last modified or updated.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Final net management fee amount after all adjustments, representing the amount due to the management company.',
    `notes` STRING COMMENT 'Additional notes, comments, or explanations related to the management fee calculation, payment, or any special circumstances.',
    `payment_date` DATE COMMENT 'Actual date when the management fee was paid by the property owner.',
    `payment_due_date` DATE COMMENT 'Date by which the management fee payment is due from the property owner per the Hotel Management Agreement (HMA) payment terms.',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the payment received from the property owner.',
    `payment_status` STRING COMMENT 'Current payment status of the management fee, tracking whether the owner has remitted payment.. Valid values are `pending|paid|partial|overdue|waived|disputed`',
    `period_end_date` DATE COMMENT 'End date of the performance period covered by this management fee calculation.',
    `period_start_date` DATE COMMENT 'Start date of the performance period covered by this management fee calculation.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this management fee record represents a reversal or correction of a previously recorded fee.',
    `reversal_reason` STRING COMMENT 'Business reason or explanation for reversing the management fee calculation.',
    `source_document_reference` STRING COMMENT 'Reference to the source document or transaction in the originating system that generated this management fee record.',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this management fee transaction is subject to SOX financial controls and audit requirements for publicly traded entities.',
    CONSTRAINT pk_management_fee PRIMARY KEY(`management_fee_id`)
) COMMENT 'Management fee calculation record representing periodic fees charged by the hotel management company to property owners under Hotel Management Agreements (HMA). Tracks fee type (base fee as % of gross revenue, incentive fee as % of GOP/NOI), calculation basis, fee amount, payment schedule, owner entity, and fiscal period. Critical for owner reporting, P&L accuracy, and intercompany elimination in consolidated statements. Sourced from SAP S/4HANA and owner accounting systems.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` (
    `owner_distribution_id` BIGINT COMMENT 'Unique identifier for the owner distribution record. Primary key for this entity representing a single periodic distribution calculation and payment event under a Hotel Management Agreement (HMA).',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this owner distribution for payment. Typically a senior finance officer or property general manager with appropriate authorization.',
    `hma_contract_id` BIGINT COMMENT 'Foreign key linking to finance.hma_contract. Business justification: owner_distribution needs FK to hma_contract to link distributions to the governing management agreement. Currently has hma_contract_code (BIGINT code field). Adding hma_contract_id as proper FK enable',
    `ownership_entity_id` BIGINT COMMENT 'Identifier of the legal ownership entity receiving this distribution payment. May represent individual owners, investment funds, or ownership consortiums.',
    `prior_period_owner_distribution_id` BIGINT COMMENT 'Self-referencing FK on owner_distribution (prior_period_owner_distribution_id)',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property for which this owner distribution is calculated. Links to the property master record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this owner distribution was approved for payment. Critical for audit trail and Sarbanes-Oxley (SOX) compliance.',
    `base_management_fee_amount` DECIMAL(18,2) COMMENT 'Base management fee charged by the hotel operator, typically calculated as a percentage of gross revenue per the Hotel Management Agreement. First deduction in the waterfall.',
    `calculation_date` DATE COMMENT 'Date on which the owner distribution waterfall calculation was performed. Typically occurs after period close and financial statement finalization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this owner distribution record was first created in the system. Audit trail field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this distribution record. Typically matches the propertys functional currency.. Valid values are `^[A-Z]{3}$`',
    `debt_service_amount` DECIMAL(18,2) COMMENT 'Principal and interest payments on property-level debt obligations deducted from the distribution waterfall. Includes mortgage payments, construction loans, and other secured financing.',
    `dispute_date` DATE COMMENT 'Date on which the owner formally disputed this distribution. Starts the contractual dispute resolution timeline per the Hotel Management Agreement.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the owner has disputed this distribution calculation or payment. Triggers review and resolution workflow.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the owners dispute regarding this distribution. Documents the nature of the disagreement for resolution tracking.',
    `distribution_amount` DECIMAL(18,2) COMMENT 'Final net amount distributed to the owner entity after all waterfall deductions. This is the actual payment remitted to the ownership entity.',
    `distribution_number` STRING COMMENT 'Business identifier for this owner distribution payment. Typically follows a sequential or period-based numbering scheme for tracking and reconciliation purposes.',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the owner distribution. Tracks progression from initial calculation through approval, payment execution, and final settlement. [ENUM-REF-CANDIDATE: draft|calculated|approved|pending_payment|paid|cancelled|disputed — 7 candidates stripped; promote to reference product]',
    `ffe_reserve_balance` DECIMAL(18,2) COMMENT 'Cumulative balance in the Furniture Fixtures and Equipment reserve fund after this periods contribution. Tracks funds available for capital expenditure (CapEx) projects.',
    `ffe_reserve_contribution_amount` DECIMAL(18,2) COMMENT 'Mandatory contribution to the Furniture Fixtures and Equipment reserve fund, typically calculated as a percentage of gross revenue. Funds capital expenditure (CapEx) for property maintenance and renovation.',
    `fiscal_period` STRING COMMENT 'Fiscal period (typically month) within the fiscal year for which this distribution is calculated. Standard range is 1-12 for monthly distributions.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this owner distribution is calculated. Aligns with the propertys financial reporting calendar.',
    `gl_posting_date` DATE COMMENT 'Date on which the owner distribution transaction was posted to the general ledger. May differ from payment date due to accounting period cutoffs.',
    `gop_amount` DECIMAL(18,2) COMMENT 'Gross Operating Profit calculated as gross revenue minus operating expenses and management fees. Key performance metric in hotel financial reporting and distribution calculations.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated by the property during the distribution period. First line item in the distribution waterfall calculation, includes rooms, food and beverage (F&B), events, and ancillary revenue streams.',
    `incentive_management_fee_amount` DECIMAL(18,2) COMMENT 'Performance-based incentive management fee earned by the operator when property achieves specified Gross Operating Profit (GOP) or other performance thresholds defined in the Hotel Management Agreement.',
    `insurance_premium_amount` DECIMAL(18,2) COMMENT 'Property insurance premiums paid during the period, including general liability, property damage, business interruption, and other required coverage per the Hotel Management Agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this owner distribution record was last modified. Audit trail field for tracking changes to distribution calculations or payment details.',
    `noi_amount` DECIMAL(18,2) COMMENT 'Net Operating Income calculated after all operating expenses, management fees, reserves, debt service, and other deductions. Represents the distributable income available to owners.',
    `notes` STRING COMMENT 'Free-form notes and comments regarding this owner distribution. May include explanations of unusual items, adjustments, or special circumstances affecting the calculation.',
    `other_deductions_amount` DECIMAL(18,2) COMMENT 'Additional contractual deductions from the distribution waterfall not captured in standard categories. May include special assessments, brand fees, or owner-approved expenditures.',
    `payment_date` DATE COMMENT 'Actual date on which the owner distribution payment was executed and funds transferred to the owner entity.',
    `payment_due_date` DATE COMMENT 'Contractual due date by which the owner distribution payment must be remitted per the Hotel Management Agreement terms.',
    `payment_method` STRING COMMENT 'Method used to remit the owner distribution payment. Defines the financial instrument and transfer mechanism.. Valid values are `wire_transfer|ach|check|internal_transfer`',
    `payment_reference_number` STRING COMMENT 'Bank or payment system reference number for the distribution payment transaction. Used for reconciliation and audit trail purposes.',
    `period_end_date` DATE COMMENT 'End date of the operating period covered by this distribution calculation. Defines the close of the revenue and expense accumulation window.',
    `period_start_date` DATE COMMENT 'Start date of the operating period covered by this distribution calculation. Defines the beginning of the revenue and expense accumulation window.',
    `property_tax_amount` DECIMAL(18,2) COMMENT 'Real estate property taxes and assessments paid during the period. Deducted in the distribution waterfall before calculating net distributable income.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this distribution record is subject to Sarbanes-Oxley financial controls and enhanced audit requirements. Applies to publicly traded entities.',
    `total_operating_expenses_amount` DECIMAL(18,2) COMMENT 'Total operating expenses incurred during the period, including departmental costs, undistributed operating expenses, and property operations and maintenance. Deducted after management fees in the waterfall.',
    `working_capital_reserve_balance` DECIMAL(18,2) COMMENT 'Cumulative balance in the working capital reserve fund maintained per Hotel Management Agreement requirements. Provides liquidity buffer for operational needs.',
    CONSTRAINT pk_owner_distribution PRIMARY KEY(`owner_distribution_id`)
) COMMENT 'Owner distribution and P&L waterfall record representing the periodic calculation and payment of net operating income to property owners under Hotel Management Agreements (HMA). Tracks waterfall steps (gross revenue → management fees → operating expenses → FF&E reserve → debt service → owner distribution), distribution amount, payment date, owner entity, property, fiscal period, and reserve fund balances. Critical for managed hotel financial reporting, owner relations, and compliance with HMA contractual terms.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `bank_account_id` BIGINT COMMENT 'Reference to the source bank account from which funds will be disbursed for this payment run.',
    `gl_batch_id` BIGINT COMMENT 'Reference to the GL batch in SAP S/4HANA where payment run transactions were posted for financial consolidation.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity executing the payment run. Critical for multi-entity consolidated financial reporting per GAAP/IFRS.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this payment run. Required for audit trails and segregation of duties per SOX controls.',
    `payment_employee_id` BIGINT COMMENT 'Reference to the user who approved this payment run for execution. Required for SOX audit trails and segregation of duties.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort for which this payment run is being executed. Supports property-level financial segregation per USALI standards.',
    `reversal_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reversal_payment_run_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payment run requires managerial or executive approval before execution, typically based on amount thresholds or payment type per SOX controls.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run was approved by an authorized user.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run completed processing all payments, whether successful or failed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all payments in this run (e.g., USD, EUR, GBP). All payments within a single run must use the same currency.',
    `payment_run_description` STRING COMMENT 'Free-text description providing additional context about the purpose, scope, or special circumstances of this payment run.',
    `error_message` STRING COMMENT 'System-generated error message if the payment run failed, providing technical details for troubleshooting and resolution.',
    `execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment run was actually executed and payments were initiated.',
    `external_reference_code` STRING COMMENT 'External reference number from the source system or bank for cross-system reconciliation and audit trails.',
    `failed_amount` DECIMAL(18,2) COMMENT 'The total amount from payments that failed processing and were not disbursed.',
    `failed_payment_count` STRING COMMENT 'The number of payment transactions that failed during processing due to validation errors, insufficient funds, or other issues.',
    `gl_posting_date` DATE COMMENT 'The accounting date when the payment run transactions are posted to the general ledger for financial reporting purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was last modified.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'The net amount disbursed after deducting processing fees and adjustments from the total successful payment amount.',
    `notes` STRING COMMENT 'Internal notes or comments about the payment run, including any issues encountered, special handling instructions, or audit observations.',
    `payment_file_format` STRING COMMENT 'The technical format of the payment file: NACHA for ACH, ISO20022 for international standards, BAI2 for bank reconciliation, MT940 for SWIFT, proprietary for custom bank formats.',
    `payment_file_name` STRING COMMENT 'The name of the payment file generated for bank transmission (e.g., NACHA file for ACH, SWIFT file for wire transfers).',
    `payment_method` STRING COMMENT 'The financial instrument used for disbursement: ACH for automated clearing house transfers, wire for same-day transfers, check for paper instruments, card for credit/debit payments, cash for on-premise disbursements, virtual_card for single-use card numbers.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run: draft for initial creation, pending_approval awaiting authorization, approved ready for execution, processing during disbursement, completed when all payments successful, failed if errors occurred, cancelled if terminated before completion.',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged by payment processors, banks, or payment networks for executing this payment run.',
    `reconciliation_date` DATE COMMENT 'The date when this payment run was successfully reconciled against bank statements.',
    `reconciliation_status` STRING COMMENT 'Status of bank reconciliation for this payment run: pending awaiting bank confirmation, reconciled when all payments match bank records, discrepancy if mismatches found, under_review during investigation.',
    `retry_count` STRING COMMENT 'The number of times this payment run has been retried after initial failure, used for monitoring and escalation thresholds.',
    `run_number` STRING COMMENT 'Business identifier for the payment run, formatted as PR-YYYYMMDD-NNNN for external reference and audit trails.',
    `run_type` STRING COMMENT 'Classification of the payment run based on its purpose and scheduling: scheduled for regular cycles, ad_hoc for one-time payments, emergency for urgent disbursements, payroll for employee compensation, vendor for supplier payments, refund for guest reimbursements.',
    `scheduled_date` DATE COMMENT 'The planned date when the payment run is scheduled to execute and disburse funds.',
    `successful_amount` DECIMAL(18,2) COMMENT 'The total amount successfully disbursed from payments that completed without errors.',
    `successful_payment_count` STRING COMMENT 'The number of payment transactions that were successfully processed and disbursed.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total gross amount of all payments included in this run before any adjustments or fees.',
    `total_payment_count` STRING COMMENT 'The total number of individual payment transactions included in this payment run.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'Primary key for capex_request',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the capital expenditure request. Null if not yet approved.',
    `capex_requestor_employee_id` BIGINT COMMENT 'Identifier of the employee who initiated the capital expenditure request.',
    `property_id` BIGINT COMMENT 'Identifier of the property or hotel location for which the capital expenditure is requested.',
    `revised_capex_request_id` BIGINT COMMENT 'Self-referencing FK on capex_request (revised_capex_request_id)',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary vendor or contractor selected to execute the capital expenditure project. Null if not yet selected.',
    `actual_completion_date` DATE COMMENT 'Actual date when the capital expenditure project was completed and the asset placed in service. Null if not yet completed.',
    `actual_start_date` DATE COMMENT 'Actual date when the capital expenditure project commenced. Null if not yet started.',
    `approval_authority_level` STRING COMMENT 'Level of management authority required to approve this capital expenditure request based on amount thresholds and policy.',
    `approval_date` DATE COMMENT 'Date when the capital expenditure request was approved by authorized management. Null if not yet approved.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure amount approved by management, which may differ from the requested amount. Null if not yet approved.',
    `approver_name` STRING COMMENT 'Full name of the employee who approved the capital expenditure request. Null if not yet approved.',
    `asset_category` STRING COMMENT 'Classification of the asset type being acquired or improved through this capital expenditure.',
    `budget_year` STRING COMMENT 'Fiscal year for which the capital expenditure is budgeted and planned.',
    `business_justification` STRING COMMENT 'Rationale and business case for the capital expenditure, including strategic alignment and expected benefits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital expenditure request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested and approved amounts.',
    `department_code` STRING COMMENT 'Code identifying the department or cost center requesting the capital expenditure, aligned with USALI departmental structure.',
    `depreciation_method` STRING COMMENT 'Accounting method to be used for depreciating the capital asset over its useful life.',
    `environmental_impact_assessment` STRING COMMENT 'Assessment level of environmental impact associated with the capital expenditure project, supporting sustainability reporting.',
    `expected_useful_life_years` STRING COMMENT 'Estimated useful life of the asset in years for depreciation calculation purposes.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the capital expenditure will be capitalized, following the chart of accounts structure.',
    `is_multi_year_project` BOOLEAN COMMENT 'Indicates whether the capital expenditure project spans multiple fiscal years requiring phased budgeting and approval.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital expenditure request record was last modified or updated.',
    `notes` STRING COMMENT 'Additional comments, notes, or supplementary information related to the capital expenditure request.',
    `payback_period_months` STRING COMMENT 'Estimated number of months required to recover the capital expenditure investment through generated cash flows or savings.',
    `planned_completion_date` DATE COMMENT 'Planned date for the capital expenditure project to be completed and the asset placed in service.',
    `planned_start_date` DATE COMMENT 'Planned date for the capital expenditure project to commence.',
    `priority_level` STRING COMMENT 'Business priority assigned to the capital expenditure request based on urgency and strategic importance.',
    `project_description` STRING COMMENT 'Detailed narrative description of the capital expenditure project, including scope, objectives, and expected outcomes.',
    `project_name` STRING COMMENT 'Descriptive name of the capital expenditure project or initiative.',
    `purchase_order_number` STRING COMMENT 'Purchase order number issued for the capital expenditure procurement. Null if not yet issued.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a capital expenditure request is rejected by approving authority. Null if not rejected.',
    `request_date` DATE COMMENT 'Date when the capital expenditure request was formally submitted for review.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the capital expenditure request, formatted as CAPEX-YYYY-NNNNNN.',
    `request_status` STRING COMMENT 'Current lifecycle status of the capital expenditure request in the approval workflow.',
    `request_type` STRING COMMENT 'Classification of the capital expenditure request: CapEx (general capital expenditure), FF&E (furniture, fixtures, and equipment), renovation, expansion, maintenance, technology, or equipment.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure amount requested for the project in the propertys functional currency.',
    `requestor_name` STRING COMMENT 'Full name of the employee who initiated the capital expenditure request.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Estimated return on investment percentage for the capital expenditure project, used in financial justification.',
    `sox_control_required` BOOLEAN COMMENT 'Indicates whether this capital expenditure request is subject to SOX financial controls and audit requirements for publicly traded entities.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Master reference table for capex_request. Referenced by capex_request_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` (
    `recurring_entry_template_id` BIGINT COMMENT 'Primary key for recurring_entry_template',
    `property_id` BIGINT COMMENT 'FK to property.property.property_id',
    `control_id` BIGINT COMMENT 'Reference identifier linking this template to specific SOX financial controls for publicly traded entities.',
    `superseded_recurring_entry_template_id` BIGINT COMMENT 'Self-referencing FK on recurring_entry_template (superseded_recurring_entry_template_id)',
    `amount_type` STRING COMMENT 'Indicates whether the journal entry amount is a fixed value, variable (entered at generation time), or calculated using a formula.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether entries generated from this template require explicit approval before posting, supporting SOX segregation of duties controls.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this recurring entry template for use, supporting SOX segregation of duties.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this recurring entry template was approved, establishing the audit trail for template authorization.',
    `approver_role` STRING COMMENT 'Role or position authorized to approve journal entries generated from this template (e.g., Controller, Finance Manager, Property Accountant).',
    `auto_post_flag` BOOLEAN COMMENT 'Indicates whether journal entries generated from this template are automatically posted to the general ledger (true) or require manual review and approval (false).',
    `business_justification` STRING COMMENT 'Business rationale and supporting documentation for this recurring entry template, required for audit trail and SOX compliance.',
    `calculation_formula` STRING COMMENT 'Formula or calculation logic used to determine the journal entry amount when amount_type is formula_based. May reference other GL accounts, percentages, or system variables.',
    `capex_ffe_flag` BOOLEAN COMMENT 'Indicates whether this template relates to capital expenditure or FF&E reserve tracking, critical for hotel asset management and lender covenant compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recurring entry template record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts in this template (e.g., USD, EUR, GBP).',
    `department_code` STRING COMMENT 'Department or cost center code associated with this recurring entry template for departmental P&L tracking per USALI standards.',
    `effective_end_date` DATE COMMENT 'Date when this recurring entry template expires and stops generating journal entries. Null indicates an open-ended template.',
    `effective_start_date` DATE COMMENT 'Date when this recurring entry template becomes active and begins generating journal entries.',
    `entry_type` STRING COMMENT 'Classification of the journal entry type that this template generates (standard operating entry, period-end adjusting entry, accrual, reversal, cost allocation, or account reclassification).',
    `fixed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount to be used when generating journal entries from this template. Only applicable when amount_type is fixed.',
    `gaap_reference` STRING COMMENT 'Citation to specific GAAP or IFRS accounting standard that governs this recurring entry (e.g., ASC 606, IFRS 15).',
    `gl_account_credit` STRING COMMENT 'General ledger account number to be credited when this template generates a journal entry. Must conform to the USALI chart of accounts structure.',
    `gl_account_debit` STRING COMMENT 'General ledger account number to be debited when this template generates a journal entry. Must conform to the USALI chart of accounts structure.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this template generates intercompany journal entries requiring elimination in consolidated financial statements.',
    `last_generated_date` DATE COMMENT 'Date when this template last generated a journal entry, used for tracking and scheduling next occurrence.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this recurring entry template, supporting change control and audit requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this recurring entry template record was last modified, critical for SOX audit trail and version control.',
    `next_scheduled_date` DATE COMMENT 'Date when this template is scheduled to generate its next journal entry based on recurrence frequency.',
    `notes` STRING COMMENT 'Additional notes, instructions, or comments related to this recurring entry template for operational guidance and knowledge transfer.',
    `recurrence_frequency` STRING COMMENT 'Frequency at which this template generates journal entries (daily, weekly, monthly, quarterly, semi-annually, or annually).',
    `recurring_entry_template_status` STRING COMMENT 'Current lifecycle status of the recurring entry template indicating whether it is in draft, actively generating entries, temporarily suspended, permanently inactive, or archived.',
    `reversal_period_offset` STRING COMMENT 'Number of accounting periods after the original entry when the reversal should occur. Typically 1 for next-period reversals.',
    `reversal_required_flag` BOOLEAN COMMENT 'Indicates whether entries generated from this template require automatic reversal in the subsequent accounting period (true for accruals and certain adjusting entries).',
    `sap_integration_flag` BOOLEAN COMMENT 'Indicates whether this template is integrated with SAP S/4HANA for automated journal entry posting and synchronization.',
    `tax_impact_flag` BOOLEAN COMMENT 'Indicates whether entries from this template have income tax implications requiring coordination with tax accounting and reporting.',
    `template_code` STRING COMMENT 'Unique business identifier code for the recurring entry template, used for external reference and reporting.',
    `template_description` STRING COMMENT 'Detailed description of the recurring entry template including its purpose, business rationale, and any special instructions for processing.',
    `template_name` STRING COMMENT 'Descriptive name of the recurring entry template that clearly identifies its business purpose (e.g., Monthly Depreciation - FF&E, Quarterly Accrued Interest).',
    `usali_category` STRING COMMENT 'USALI financial statement category or line item that this recurring entry impacts (e.g., Rooms Revenue, F&B Cost of Sales, GOP, EBITDA).',
    `created_by` STRING COMMENT 'User ID or name of the person who created this recurring entry template, supporting audit trail requirements.',
    CONSTRAINT pk_recurring_entry_template PRIMARY KEY(`recurring_entry_template_id`)
) COMMENT 'Master reference table for recurring_entry_template. Referenced by recurring_entry_template_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` (
    `allocation_run_id` BIGINT COMMENT 'Primary key for allocation_run',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this allocation run for execution, ensuring segregation of duties.',
    `allocation_employee_id` BIGINT COMMENT 'Reference to the user who initiated or triggered this allocation run.',
    `allocation_reversed_run_id` BIGINT COMMENT 'Reference to the original allocation run that this run is reversing. Populated only when reversal_flag is True.',
    `allocation_rule_set_id` BIGINT COMMENT 'Reference to the predefined set of allocation rules and parameters applied in this run.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period for which this allocation run is executed.',
    `gl_batch_id` BIGINT COMMENT 'The batch identifier in the general ledger system where allocation journal entries were posted.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity under which this allocation run is processed for consolidated financial reporting.',
    `primary_reversal_allocation_run_id` BIGINT COMMENT 'Self-referencing FK on allocation_run (reversal_allocation_run_id)',
    `property_id` BIGINT COMMENT 'Reference to the property for which this allocation run is executed. Null for corporate-level allocations.',
    `cost_center_id` BIGINT COMMENT 'Reference to the originating cost center from which costs are being allocated.',
    `accounting_period` STRING COMMENT 'The accounting period in YYYY-MM format for which allocations are being processed.',
    `actual_execution_timestamp` TIMESTAMP COMMENT 'The actual date and time when the allocation run processing was initiated.',
    `allocation_basis` STRING COMMENT 'Detailed description of the allocation basis or driver used for cost distribution (e.g., occupied room nights, revenue percentage, employee count, square footage).',
    `allocation_line_count` STRING COMMENT 'The total number of individual allocation line items generated in this run.',
    `allocation_method` STRING COMMENT 'The methodology used to distribute costs across departments, properties, or cost centers (direct assignment, step-down, reciprocal, activity-based costing, revenue-based, headcount-based, or square footage-based).',
    `allocation_run_status` STRING COMMENT 'Current lifecycle status of the allocation run indicating its processing state.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation run was approved for execution.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation run processing was completed successfully or terminated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amounts.',
    `error_message` STRING COMMENT 'Detailed error or failure message if the allocation run encountered processing errors. Null for successful runs.',
    `gl_posting_date` DATE COMMENT 'The effective date when allocation entries were posted to the general ledger.',
    `gl_posting_status` STRING COMMENT 'Indicates whether the allocation results have been posted to the general ledger system.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this allocation run was executed automatically by the system (True) or manually triggered by a user (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation run record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this allocation run, including business justification, special circumstances, or manual adjustments.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the total allocated amounts reconcile to the source amounts (balanced) or if discrepancies exist (unbalanced).',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this allocation run is a reversal of a previously posted allocation (True) or an original allocation (False).',
    `run_number` STRING COMMENT 'Business-facing unique identifier for the allocation run, formatted as AR-YYYYMMDD-NNNN.',
    `run_type` STRING COMMENT 'Classification of the allocation run based on the scope and nature of cost distribution (departmental, property-level, corporate, intercompany, overhead, or capital expenditure).',
    `scheduled_execution_date` DATE COMMENT 'The planned date for executing this allocation run as part of the monthly close calendar.',
    `target_cost_center_count` STRING COMMENT 'The number of distinct cost centers or departments that received allocated costs in this run.',
    `total_amount_allocated` DECIMAL(18,2) COMMENT 'The total monetary value of costs distributed in this allocation run across all target cost centers or departments.',
    `validation_notes` STRING COMMENT 'Detailed notes or warnings from the validation process, including any exceptions or manual overrides applied.',
    `validation_status` STRING COMMENT 'Indicates whether the allocation run passed pre-execution validation checks (balancing, rule completeness, data integrity).',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between source amounts and allocated amounts, indicating rounding differences or allocation errors.',
    CONSTRAINT pk_allocation_run PRIMARY KEY(`allocation_run_id`)
) COMMENT 'Master reference table for allocation_run. Referenced by allocation_run_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` (
    `hma_contract_id` BIGINT COMMENT 'Primary key for hma_contract',
    `brand_id` BIGINT COMMENT 'Identifier of the hotel brand under which the property operates as specified in the management agreement.',
    `party_id` BIGINT COMMENT 'Identifier of the hotel operator party responsible for managing the property under this agreement.',
    `ownership_entity_id` BIGINT COMMENT 'Identifier of the property owner party who is the counterparty to this hotel management agreement contract.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property or resort covered under this management agreement contract.',
    `superseded_hma_contract_id` BIGINT COMMENT 'Self-referencing FK on hma_contract (superseded_hma_contract_id)',
    `accounting_standard` STRING COMMENT 'Financial accounting standard framework required for property financial reporting under the contract, such as USALI, US GAAP, or IFRS.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or modifications executed since the original contract signing.',
    `assignment_rights_flag` BOOLEAN COMMENT 'Indicates whether either party has the right to assign or transfer the contract to a third party without consent.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the owner has contractual rights to audit the operators books and records related to property operations and fee calculations.',
    `base_management_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross operating revenue or other defined base that the operator receives as base management fee under the contract terms.',
    `budget_approval_authority` STRING COMMENT 'Party or governance structure with authority to approve annual operating budgets and capital expenditure plans for the property.',
    `capital_expenditure_reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue required to be set aside annually for capital expenditure and furniture, fixtures, and equipment (FF&E) reserves.',
    `confidentiality_period_years` STRING COMMENT 'Duration in years that confidentiality obligations survive after contract termination or expiration.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the hotel management agreement contract, typically including property name and agreement type.',
    `contract_notes` STRING COMMENT 'Free-form text field for additional notes, special provisions, or contextual information about the hotel management agreement contract.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the hotel management agreement contract, typically formatted as HMA- followed by numeric sequence.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the hotel management agreement contract indicating its operational state.',
    `contract_type` STRING COMMENT 'Classification of the hotel management agreement type defining the operational and financial relationship structure between parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which contract fees and financial obligations are denominated.',
    `data_classification` STRING COMMENT 'Classification level of the contract data indicating sensitivity and access control requirements per organizational data governance policy.',
    `dispute_resolution_method` STRING COMMENT 'Primary method specified in the contract for resolving disputes between owner and operator parties.',
    `effective_date` DATE COMMENT 'Date when the hotel management agreement contract becomes legally binding and operational obligations commence.',
    `expiration_date` DATE COMMENT 'Date when the hotel management agreement contract term ends and obligations cease, unless renewed or extended. Nullable for evergreen contracts.',
    `fee_calculation_basis` STRING COMMENT 'The financial metric or basis upon which management fees are calculated, such as gross operating revenue, gross operating profit, or adjusted gross operating profit.',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes force majeure provisions that excuse performance obligations during extraordinary events beyond parties control.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law specified in the contract for dispute resolution and contract interpretation.',
    `incentive_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross operating profit (GOP) or adjusted gross operating profit (AGOP) that the operator receives as incentive fee when performance thresholds are met.',
    `indemnification_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount for indemnification obligations between parties under the contract terms, if capped.',
    `insurance_responsibility` STRING COMMENT 'Party responsible for procuring and maintaining required property and liability insurance coverage under the contract.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the original contract terms, if any amendments have been executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was most recently updated or modified in the system.',
    `minimum_annual_fee_amount` DECIMAL(18,2) COMMENT 'Guaranteed minimum annual management fee amount payable to the operator regardless of property performance, if applicable.',
    `non_compete_period_years` STRING COMMENT 'Duration in years of non-compete restrictions applicable to parties after contract termination, if specified.',
    `performance_test_flag` BOOLEAN COMMENT 'Indicates whether the contract includes performance test provisions that allow the owner to terminate if specified performance metrics are not met.',
    `renewal_option_count` STRING COMMENT 'Number of renewal option periods available to extend the contract beyond the initial term.',
    `renewal_option_years` STRING COMMENT 'Duration in years of each renewal option period if the contract is extended.',
    `reporting_frequency` STRING COMMENT 'Required frequency for financial and operational reporting from operator to owner under the contract terms.',
    `signed_date` DATE COMMENT 'Date when the hotel management agreement contract was executed and signed by all parties.',
    `term_years` STRING COMMENT 'Initial term duration of the hotel management agreement contract expressed in years.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract under standard termination provisions.',
    `working_capital_amount` DECIMAL(18,2) COMMENT 'Initial working capital amount required to be provided or maintained for property operations under the contract terms.',
    CONSTRAINT pk_hma_contract PRIMARY KEY(`hma_contract_id`)
) COMMENT 'Master reference table for hma_contract. Referenced by hma_contract_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `fiscal_prior_year_period_id` BIGINT COMMENT 'Reference to the corresponding fiscal period in the prior year. Used for year-over-year variance analysis and comparative financial reporting.',
    `primary_prior_fiscal_period_id` BIGINT COMMENT 'Self-referencing FK on fiscal_period (prior_fiscal_period_id)',
    `property_id` BIGINT COMMENT 'FK to property.property.property_id',
    `budget_version` STRING COMMENT 'The budget version or scenario associated with this fiscal period (e.g., Original Budget, Revised Budget, Forecast). Used for budget vs actual variance analysis.',
    `business_days_in_period` STRING COMMENT 'Total number of business days (excluding weekends and holidays) in this fiscal period. Used for operational metrics and productivity calculations.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which the period starts. Used for calendar-based reporting and seasonality analysis.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter number (1-4) in which the period starts. Used for calendar-based comparisons and external benchmarking.',
    `calendar_year` STRING COMMENT 'The calendar year in which the period starts (e.g., 2024). May differ from fiscal_year for companies with non-calendar fiscal years.',
    `close_date` DATE COMMENT 'The actual date when the fiscal period was closed for transaction posting. Null if period is still open. Used for financial close tracking and SOX compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal period record was first created in the system. Used for audit trail and data lineage tracking.',
    `days_in_period` STRING COMMENT 'Total number of calendar days in this fiscal period. Used for daily average calculations (e.g., Average Daily Rate, Revenue Per Available Room).',
    `fiscal_period_description` STRING COMMENT 'Additional descriptive text or notes about this fiscal period, including special circumstances, adjustments, or reporting considerations.',
    `end_date` DATE COMMENT 'The last calendar date included in this fiscal period. Defines the end boundary for transaction posting and financial reporting.',
    `fiscal_month` STRING COMMENT 'The fiscal month number within the fiscal year (1-12). Null for non-monthly periods. Used for monthly financial close and management reporting.',
    `fiscal_period_status` STRING COMMENT 'Current lifecycle status of the fiscal period. Open: period is active and transactions can be posted. Closed: period is closed for regular posting but can be reopened. Locked: period is finalized and cannot accept new transactions without special authorization. Archived: period is archived for historical reference only.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter number within the fiscal year (1-4). Null for non-quarterly periods. Used for quarterly financial reporting and SEC filings.',
    `fiscal_week` STRING COMMENT 'The fiscal week number within the fiscal year (1-52 or 1-53). Null for non-weekly periods. Used for weekly operational and revenue reporting in hospitality operations.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs (e.g., 2024). Used for year-over-year comparisons and annual financial statement consolidation.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment period (e.g., Period 13) used for year-end adjustments and accruals. True if adjustment period, False if regular operating period.',
    `is_leap_year` BOOLEAN COMMENT 'Indicates whether this fiscal period falls within a leap year. True if leap year, False otherwise. Used for accurate daily average calculations.',
    `lock_date` DATE COMMENT 'The date when the fiscal period was locked and finalized. Null if period is not yet locked. Used for audit trail and financial statement finalization.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal period record was last modified. Used for audit trail and change tracking.',
    `period_code` STRING COMMENT 'Business identifier code for the fiscal period, typically formatted as YYYY-MM or YYYY-Pnn (e.g., 2024-01, 2024-P01). Used in financial reports and external communications.',
    `period_name` STRING COMMENT 'Human-readable name of the fiscal period (e.g., January 2024, Q1 2024, FY2024-P01). Used for display in reports and dashboards.',
    `period_number` STRING COMMENT 'Sequential period number within the fiscal year (e.g., 1-12 for monthly periods, 1-4 for quarterly periods). Used for period-to-period comparisons and trend analysis.',
    `period_type` STRING COMMENT 'Classification of the fiscal period granularity: month (standard monthly period), quarter (quarterly period), year (annual fiscal year), week (weekly period for operational reporting), or custom (non-standard period for special reporting needs).',
    `reopen_date` DATE COMMENT 'The date when a previously closed period was reopened for adjustments. Null if period has never been reopened. Used for audit trail and SOX compliance monitoring.',
    `reporting_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code used for financial reporting in this period (e.g., USD, EUR, GBP). Used for multi-currency consolidation.',
    `start_date` DATE COMMENT 'The first calendar date included in this fiscal period. Defines the beginning of the period for transaction posting and financial reporting.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Master reference table for fiscal_period. Referenced by fiscal_period_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` (
    `gl_batch_id` BIGINT COMMENT 'Primary key for gl_batch',
    `gl_original_batch_id` BIGINT COMMENT 'Reference to the original GL batch that this batch reverses, if this is a reversal batch. Used to track the relationship between reversal entries and their original accruals. Null if this is not a reversal batch.',
    `gl_reversal_batch_id` BIGINT COMMENT 'Reference to the GL batch that reverses this batch, if applicable. Used to track the relationship between original accrual entries and their subsequent reversals. Null if batch has not been reversed.',
    `primary_reversal_gl_batch_id` BIGINT COMMENT 'Self-referencing FK on gl_batch (reversal_gl_batch_id)',
    `property_id` BIGINT COMMENT 'FK connection added per structural fix',
    `accounting_period` STRING COMMENT 'The fiscal period to which this GL batch applies, typically in format YYYY-MM or period number (e.g., 2024-01, Period 3 FY2024). Used for period-end closing and financial reporting alignment.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether this GL batch requires formal approval before it can be posted to the general ledger. True if approval workflow is required, False if batch can be posted without approval.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the GL batch for posting. Required for SOX compliance and audit trail. Null if batch has not been approved or does not require approval.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the GL batch was approved for posting. Part of the audit trail for SOX compliance. Null if batch has not been approved.',
    `batch_name` STRING COMMENT 'Descriptive name or title assigned to the GL batch to identify its purpose or content (e.g., Monthly Accruals - January 2024, Payroll Posting - Week 12).',
    `batch_number` STRING COMMENT 'Human-readable business identifier for the GL batch, typically assigned by the accounting system or finance team for tracking and reference purposes.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the GL batch: draft (being prepared), pending_approval (submitted for review), approved (authorized for posting), posted (committed to the general ledger), rejected (not approved), or cancelled (voided before posting).',
    `batch_type` STRING COMMENT 'Classification of the GL batch based on its accounting purpose: standard (regular transactions), recurring (automated periodic entries), adjustment (correcting entries), accrual (period-end accruals), reversal (reversing prior entries), or closing (period/year-end closing entries).',
    `control_total` DECIMAL(18,2) COMMENT 'Optional control total amount provided by the batch creator for validation purposes. Used to verify that the sum of batch entries matches the expected total before posting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the GL batch record was first created in the system. Part of the audit trail for tracking batch lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the GL batch amounts are denominated (e.g., USD, EUR, GBP).',
    `department_code` STRING COMMENT 'Code identifying the department or cost center associated with this GL batch (e.g., ROOMS, F&B, ADMIN). Used for departmental accounting and GOP calculation per USALI.',
    `gl_batch_description` STRING COMMENT 'Detailed textual description of the GL batch purpose, content, or context. Provides additional information beyond the batch name for audit trail and user reference.',
    `effective_date` DATE COMMENT 'The business date or transaction date that the GL batch entries represent. May differ from posting_date when backdating or forward-dating entries for accruals or adjustments.',
    `entry_count` STRING COMMENT 'Total number of individual journal entries or line items contained within this GL batch. Used for validation and reconciliation purposes.',
    `external_reference` STRING COMMENT 'External reference number or identifier from the source system or business process that originated this GL batch (e.g., invoice number, payroll run ID, bank statement reference). Used for cross-system reconciliation.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this GL batch belongs (e.g., 2024). Used for annual financial reporting and year-end closing processes.',
    `is_balanced` BOOLEAN COMMENT 'Indicates whether the GL batch is in balance (total debits equal total credits). True if balanced, False if out of balance. Out-of-balance batches cannot be posted.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this GL batch is part of a recurring batch template that is automatically generated on a scheduled basis (e.g., monthly rent accruals, depreciation entries).',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the GL batch. Part of the audit trail for SOX compliance. Null if batch has never been modified after creation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the GL batch was last modified. Part of the audit trail for tracking changes to the batch. Null if batch has never been modified after creation.',
    `notes` STRING COMMENT 'Free-form notes or comments added by users regarding the GL batch. Used for additional context, special instructions, or documentation of unusual circumstances.',
    `posted_by` STRING COMMENT 'User ID or name of the person who posted the GL batch to the general ledger. Required for audit trail and SOX compliance. Null if batch has not been posted.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the GL batch was posted to the general ledger. Represents the moment the batch entries were committed to the GL. Null if batch has not been posted.',
    `posting_date` DATE COMMENT 'The date on which the GL batch was or will be posted to the general ledger. This is the effective date for financial reporting and impacts the accounting period in which transactions are recognized.',
    `recurring_frequency` STRING COMMENT 'For recurring batches, specifies the frequency at which the batch is automatically generated: daily, weekly, monthly, quarterly, or annually. Null for non-recurring batches.',
    `rejection_reason` STRING COMMENT 'Textual explanation provided by the approver when rejecting a GL batch. Documents why the batch was not approved for posting. Null if batch has not been rejected.',
    `reversal_date` DATE COMMENT 'The date on which this GL batch should be automatically reversed, if applicable. Commonly used for accrual entries that need to be reversed in the subsequent period.',
    `source_module` STRING COMMENT 'Specific module or sub-system within the source system that generated the batch (e.g., Accounts Payable, Accounts Receivable, Fixed Assets, Payroll).',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of all credit entries in the GL batch. Must equal total_debit_amount for the batch to be in balance per double-entry accounting principles.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of all debit entries in the GL batch. Must equal total_credit_amount for the batch to be in balance per double-entry accounting principles.',
    `created_by` STRING COMMENT 'User ID or name of the person who created or initiated the GL batch. Part of the audit trail for SOX compliance and internal controls.',
    CONSTRAINT pk_gl_batch PRIMARY KEY(`gl_batch_id`)
) COMMENT 'Master reference table for gl_batch. Referenced by gl_batch_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` (
    `allocation_rule_set_id` BIGINT COMMENT 'Primary key for allocation_rule_set',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this allocation rule set record in the system.',
    `allocation_employee_id` BIGINT COMMENT 'Identifier of the user who approved this allocation rule set for active use in financial processing.',
    `allocation_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this allocation rule set record.',
    `property_id` BIGINT COMMENT 'FK connection added per structural fix',
    `superseded_allocation_rule_set_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule_set (superseded_allocation_rule_set_id)',
    `allocation_basis` STRING COMMENT 'The business driver or metric used as the basis for allocation calculations (e.g., room nights, square footage, headcount, revenue, labor hours).',
    `allocation_frequency` STRING COMMENT 'The cadence at which this allocation rule set is executed in the financial close process.',
    `allocation_method` STRING COMMENT 'The calculation methodology used by this rule set to distribute costs or revenues across entities (direct assignment, step-down, reciprocal, percentage-based, driver-based, or activity-based costing).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Fixed percentage used for allocation when the allocation method is percentage-based. Value between 0.00 and 100.00.',
    `allocation_rule_set_status` STRING COMMENT 'Current lifecycle status of the allocation rule set indicating whether it is actively being used in financial processing.',
    `approval_workflow_code` STRING COMMENT 'Reference to the approval workflow configuration that governs the review and approval process for allocations generated by this rule set.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation rule set was approved for active use.',
    `audit_trail_required` BOOLEAN COMMENT 'Boolean flag indicating whether detailed audit trail logging is required for all allocations performed using this rule set.',
    `business_justification` STRING COMMENT 'Business rationale and justification for this allocation rule set including regulatory requirements, management reporting needs, or operational drivers.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation rule set record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which threshold amounts and allocation calculations are denominated.',
    `department_filter` STRING COMMENT 'Comma-separated list or pattern of department codes to which this allocation rule set applies. Used to scope the rule set to specific departments.',
    `allocation_rule_set_description` STRING COMMENT 'Detailed business description of the allocation rule set including its purpose, scope, and any special considerations for its application.',
    `effective_end_date` DATE COMMENT 'The date on which this allocation rule set ceases to be active. Null indicates an open-ended rule set with no planned expiration.',
    `effective_start_date` DATE COMMENT 'The date from which this allocation rule set becomes active and applicable to financial transactions.',
    `external_reference_code` STRING COMMENT 'External system identifier or reference number for this allocation rule set used for integration and reconciliation with source financial systems.',
    `gl_account_filter` STRING COMMENT 'Comma-separated list or pattern of GL account codes to which this allocation rule set applies. Used to scope the rule set to specific account ranges.',
    `is_automated` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation rule set executes automatically during the financial close process or requires manual triggering.',
    `is_reciprocal_allocation` BOOLEAN COMMENT 'Boolean flag indicating whether this rule set supports reciprocal allocation where departments can allocate costs to each other iteratively.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation rule set record was most recently modified.',
    `maximum_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount for which this allocation rule set applies. Transactions above this threshold may use different allocation logic.',
    `minimum_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required for this allocation rule set to be applied. Transactions below this threshold are excluded from allocation.',
    `notes` STRING COMMENT 'Free-form notes and comments about this allocation rule set including implementation details, special handling instructions, or historical context.',
    `priority_rank` STRING COMMENT 'Numeric ranking that determines the order of execution when multiple allocation rule sets apply to the same transaction or entity. Lower numbers indicate higher priority.',
    `property_filter` STRING COMMENT 'Comma-separated list or pattern of property codes to which this allocation rule set applies. Used to scope the rule set to specific properties or property groups.',
    `requires_approval` BOOLEAN COMMENT 'Boolean flag indicating whether allocation results from this rule set require management approval before posting to the general ledger.',
    `rule_set_code` STRING COMMENT 'Unique business identifier code for the allocation rule set used for external reference and reporting.',
    `rule_set_name` STRING COMMENT 'Descriptive name of the allocation rule set that clearly identifies its purpose and scope.',
    `rule_set_type` STRING COMMENT 'Classification of the allocation rule set indicating what type of financial data it allocates (cost, revenue, expense, overhead, departmental, or property-level).',
    `source_entity_type` STRING COMMENT 'The type of organizational entity from which costs or revenues are being allocated (property, department, cost center, profit center, division, region, or brand).',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this allocation rule set was created or integrated (e.g., SAP S/4HANA, Oracle Financials, custom allocation engine).',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation rule set is subject to SOX financial controls and requires enhanced audit trail and segregation of duties.',
    `target_entity_type` STRING COMMENT 'The type of organizational entity to which costs or revenues are being allocated (property, department, cost center, profit center, division, region, or brand).',
    `version_number` STRING COMMENT 'Version number of this allocation rule set configuration used to track changes and maintain historical versions for audit and rollback purposes.',
    CONSTRAINT pk_allocation_rule_set PRIMARY KEY(`allocation_rule_set_id`)
) COMMENT 'Master reference table for allocation_rule_set. Referenced by allocation_rule_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_allocation_run_id` FOREIGN KEY (`allocation_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_recurring_entry_template_id` FOREIGN KEY (`recurring_entry_template_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template`(`recurring_entry_template_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_original_payment_ap_payment_id` FOREIGN KEY (`original_payment_ap_payment_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_reversed_payment_ar_payment_id` FOREIGN KEY (`reversed_payment_ar_payment_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_payment`(`ar_payment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_reversed_posting_tax_posting_id` FOREIGN KEY (`reversed_posting_tax_posting_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`tax_posting`(`tax_posting_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_master_account_bank_account_id` FOREIGN KEY (`master_account_bank_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_hma_contract_id` FOREIGN KEY (`hma_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_primary_prior_period_management_fee_id` FOREIGN KEY (`primary_prior_period_management_fee_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`management_fee`(`management_fee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ADD CONSTRAINT `fk_finance_owner_distribution_hma_contract_id` FOREIGN KEY (`hma_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ADD CONSTRAINT `fk_finance_owner_distribution_prior_period_owner_distribution_id` FOREIGN KEY (`prior_period_owner_distribution_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`owner_distribution`(`owner_distribution_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_gl_batch_id` FOREIGN KEY (`gl_batch_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`gl_batch`(`gl_batch_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reversal_payment_run_id` FOREIGN KEY (`reversal_payment_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_revised_capex_request_id` FOREIGN KEY (`revised_capex_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_superseded_recurring_entry_template_id` FOREIGN KEY (`superseded_recurring_entry_template_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template`(`recurring_entry_template_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_allocation_reversed_run_id` FOREIGN KEY (`allocation_reversed_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_allocation_rule_set_id` FOREIGN KEY (`allocation_rule_set_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set`(`allocation_rule_set_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_gl_batch_id` FOREIGN KEY (`gl_batch_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`gl_batch`(`gl_batch_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_primary_reversal_allocation_run_id` FOREIGN KEY (`primary_reversal_allocation_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_superseded_hma_contract_id` FOREIGN KEY (`superseded_hma_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_fiscal_prior_year_period_id` FOREIGN KEY (`fiscal_prior_year_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_primary_prior_fiscal_period_id` FOREIGN KEY (`primary_prior_fiscal_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ADD CONSTRAINT `fk_finance_gl_batch_gl_original_batch_id` FOREIGN KEY (`gl_original_batch_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`gl_batch`(`gl_batch_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ADD CONSTRAINT `fk_finance_gl_batch_gl_reversal_batch_id` FOREIGN KEY (`gl_reversal_batch_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`gl_batch`(`gl_batch_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ADD CONSTRAINT `fk_finance_gl_batch_primary_reversal_gl_batch_id` FOREIGN KEY (`primary_reversal_gl_batch_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`gl_batch`(`gl_batch_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ADD CONSTRAINT `fk_finance_allocation_rule_set_superseded_allocation_rule_set_id` FOREIGN KEY (`superseded_allocation_rule_set_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set`(`allocation_rule_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_subcategory` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `balance_sheet_section` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Section');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `balance_sheet_section` SET TAGS ('dbx_value_regex' = 'current_assets|non_current_assets|current_liabilities|non_current_liabilities|equity');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `ledger_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `income_statement_section` SET TAGS ('dbx_business_glossary_term' = 'Income Statement Section');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `income_statement_section` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `is_control_account` SET TAGS ('dbx_business_glossary_term' = 'Control Account Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `is_reconciliation_required` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `posting_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|percentage|headcount|square_footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'revenue|support|administrative|overhead');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `department_category` SET TAGS ('dbx_business_glossary_term' = 'Department Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `department_category` SET TAGS ('dbx_value_regex' = 'operated|undistributed|fixed_charges');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `external_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `headcount_allocation` SET TAGS ('dbx_business_glossary_term' = 'Headcount Allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `labor_cost_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Tracking Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `revenue_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Posting Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Entity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_activation');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `room_count` SET TAGS ('dbx_business_glossary_term' = 'Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|extended_stay|resort|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `allocation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_posted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_posted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_posted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `capex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^JE[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'standard|allocation|intercompany|recurring|accrual|reversal');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Posting Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_text` SET TAGS ('dbx_business_glossary_term' = 'Reference Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,18}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `capex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'opex|capex|ffe');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Invoice');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|credit_card|eft');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|exception');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tax Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `original_payment_ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|electronic_funds_transfer|credit_card|cash');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|cancelled|reversed');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|advance|partial|final|refund|reversal');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `ancillary_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|escalated|legal|resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `event_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Event Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `fnb_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `folio_number` SET TAGS ('dbx_business_glossary_term' = 'Folio Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `folio_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `room_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Room Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Payment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `ota_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Partner ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `reversed_payment_ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Payment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `is_advance_deposit` SET TAGS ('dbx_business_glossary_term' = 'Is Advance Deposit');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Is Refund');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'front_desk|online|mobile_app|call_center|kiosk|mail');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_reference' = 'revenue.revenue_budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_concept' = 'budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_group' = 'budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_canonical' = 'finance.finance_budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'revenue|operating_expense|labor_expense|capex|ffe_reserve');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|rolling_forecast|reforecast|capital');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_adr` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_available_rooms` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Available Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_covers` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Covers');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_cpor` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost Per Occupied Room (CPOR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_ebitda` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_events_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Events Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_fnb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Food and Beverage (F&B) Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_gop` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Gross Operating Profit (GOP)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_goppar` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Gross Operating Profit Per Available Room (GOPPAR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_labor_expense` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Expense');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_noi` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Net Operating Income (NOI)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Occupancy Rate (OCC)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_operating_expense` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Operating Expense (OpEx)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_other_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Other Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_revpar` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Revenue Per Available Room (RevPAR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_rooms_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Rooms Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Total Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `budgeted_trevpar` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Total Revenue Per Available Room (TRevPAR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_driver` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|allocated|prorated|driver_based');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|locked');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'revenue|operating_expense|fixed_expense|capital_expenditure');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|rolling_forecast|stretch');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Locked Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|trade_in|retirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `ffe_reserve_eligible` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Reserve Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `pip_reference` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `reversed_posting_tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Tax Posting ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `exemption_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'pending|filed|paid|overdue|disputed|adjusted');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Reversal Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `source_document_type` SET TAGS ('dbx_value_regex' = 'guest_folio|fnb_check|event_invoice|vendor_invoice|adjustment|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Master Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending_activation');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|money_market|payroll|escrow|investment');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `ach_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `electronic_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Banking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `interest_bearing` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `is_primary_account` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Account Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `is_zero_balance_account` SET TAGS ('dbx_business_glossary_term' = 'Is Zero Balance Account (ZBA) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `last_statement_balance` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `last_statement_balance` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `positive_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Positive Pay Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|not_started');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ALTER COLUMN `wire_transfer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` SET TAGS ('dbx_subdomain' = 'owner_reporting');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `management_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Management Fee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `management_fee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `hma_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Hotel Management Agreement (HMA) Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `primary_prior_period_management_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Management Fee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `primary_prior_period_management_fee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `primary_prior_period_management_fee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fee Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_number` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_rate_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'base_fee|incentive_fee|combined_fee|special_fee|termination_fee|transition_fee');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Management Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partial|overdue|waived|disputed');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` SET TAGS ('dbx_subdomain' = 'owner_reporting');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `owner_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Distribution ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `hma_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Hma Contract Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `prior_period_owner_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Owner Distribution Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `prior_period_owner_distribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `base_management_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Management Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `base_management_fee_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `debt_service_amount` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `distribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Distribution Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `distribution_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `ffe_reserve_balance` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Reserve Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `ffe_reserve_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Reserve Contribution Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `gop_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Operating Profit (GOP) Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `incentive_management_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Management Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `incentive_management_fee_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `insurance_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `noi_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|internal_transfer');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `property_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `total_operating_expenses_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenses Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ALTER COLUMN `working_capital_reserve_balance` SET TAGS ('dbx_business_glossary_term' = 'Working Capital Reserve Balance');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii' = 'pii_financial');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `gl_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Batch Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `reversal_payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Payment Run Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `reversal_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `failed_amount` SET TAGS ('dbx_business_glossary_term' = 'Failed Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `failed_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Payment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Gl Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_file_format` SET TAGS ('dbx_business_glossary_term' = 'Payment File Format');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_file_name` SET TAGS ('dbx_business_glossary_term' = 'Payment File Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `successful_amount` SET TAGS ('dbx_business_glossary_term' = 'Successful Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `successful_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Successful Payment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ALTER COLUMN `total_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `revised_capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Capex Request Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `revised_capex_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `is_multi_year_project` SET TAGS ('dbx_business_glossary_term' = 'Is Multi Year Project');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Roi Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ALTER COLUMN `sox_control_required` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `superseded_recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Recurring Entry Template Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `superseded_recurring_entry_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `amount_type` SET TAGS ('dbx_business_glossary_term' = 'Amount Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `auto_post_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Post Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `capex_ffe_flag` SET TAGS ('dbx_business_glossary_term' = 'Capex Ffe Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `gaap_reference` SET TAGS ('dbx_business_glossary_term' = 'Gaap Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `gl_account_credit` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Credit');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `gl_account_debit` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Debit');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `last_generated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Generated Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `reversal_period_offset` SET TAGS ('dbx_business_glossary_term' = 'Reversal Period Offset');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `reversal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `sap_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Sap Integration Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `tax_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Impact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `usali_category` SET TAGS ('dbx_business_glossary_term' = 'Usali Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_reversed_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Run Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Set Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Batch Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `primary_reversal_allocation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Allocation Run Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `primary_reversal_allocation_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Center Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `actual_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_line_count` SET TAGS ('dbx_business_glossary_term' = 'Allocation Line Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `allocation_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Gl Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Gl Posting Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `scheduled_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Execution Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `target_cost_center_count` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Center Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `total_amount_allocated` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Allocated');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` SET TAGS ('dbx_subdomain' = 'owner_reporting');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `hma_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Hma Contract Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Party Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `superseded_hma_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Hma Contract Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `superseded_hma_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `assignment_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rights Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `base_management_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Base Management Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `base_management_fee_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `budget_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `capital_expenditure_reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Reserve Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `capital_expenditure_reserve_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `confidentiality_period_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Period Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `contract_notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `data_classification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `fee_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `force_majeure_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `incentive_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incentive Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `incentive_fee_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `indemnification_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Cap Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `insurance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Responsibility');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `minimum_annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `non_compete_period_years` SET TAGS ('dbx_business_glossary_term' = 'Non Compete Period Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `performance_test_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Test Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `renewal_option_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `term_years` SET TAGS ('dbx_business_glossary_term' = 'Term Years');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ALTER COLUMN `working_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Working Capital Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_prior_year_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Period Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_prior_year_period_id` SET TAGS ('dbx_self_referencing' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `primary_prior_fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Fiscal Period Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `primary_prior_fiscal_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `business_days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Business Days In Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `calendar_quarter` SET TAGS ('dbx_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Days In Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_week` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_leap_year` SET TAGS ('dbx_business_glossary_term' = 'Is Leap Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Lock Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `reopen_date` SET TAGS ('dbx_business_glossary_term' = 'Reopen Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `gl_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Batch Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `gl_original_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Original Batch Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `gl_reversal_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Batch Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `primary_reversal_gl_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Gl Batch Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `primary_reversal_gl_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `batch_name` SET TAGS ('dbx_business_glossary_term' = 'Batch Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `control_total` SET TAGS ('dbx_business_glossary_term' = 'Control Total');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `gl_batch_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `entry_count` SET TAGS ('dbx_business_glossary_term' = 'Entry Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `is_balanced` SET TAGS ('dbx_business_glossary_term' = 'Is Balanced');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `posted_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `recurring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurring Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Set Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `superseded_allocation_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Allocation Rule Set Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `superseded_allocation_rule_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Allocation Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_rule_set_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `department_filter` SET TAGS ('dbx_business_glossary_term' = 'Department Filter');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `allocation_rule_set_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `gl_account_filter` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Filter');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `is_reciprocal_allocation` SET TAGS ('dbx_business_glossary_term' = 'Is Reciprocal Allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `maximum_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `minimum_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `property_filter` SET TAGS ('dbx_business_glossary_term' = 'Property Filter');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `rule_set_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `rule_set_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `rule_set_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `source_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `target_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
