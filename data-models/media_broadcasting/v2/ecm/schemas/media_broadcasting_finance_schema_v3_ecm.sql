-- Schema for Domain: finance | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`finance` COMMENT 'Manages enterprise financial reporting, general ledger, cost centers, production budgets, EBITDA tracking, and financial reconciliation across all revenue streams (advertising, subscription, carriage fees, syndication). Integrates with SAP S/4HANA (FI/CO modules) for chart of accounts, period-end close, intercompany eliminations, and SOX-compliant financial controls. Provides the authoritative financial data layer for revenue assurance and corporate reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts entry. Primary key for the chart of accounts master data.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: GL accounts are defined per legal entity in SAP S/4HANA. The company_code is a business key reference to legal_entity. FK enables proper chart of accounts management per legal entity.',
    `account_currency` STRING COMMENT 'The primary currency in which this account is maintained, using ISO 4217 three-letter currency codes (e.g., USD, EUR, GBP). Determines the currency for postings and balance reporting.. Valid values are `^[A-Z]{3}$`',
    `account_group` STRING COMMENT 'SAP account group classification that controls field status, number range assignment, and screen layout for the account. Groups accounts with similar characteristics and processing rules (e.g., REVENUE, COGS, OPEX, CAPEX).',
    `account_name` STRING COMMENT 'The full descriptive name of the general ledger account, providing clear business context for the accounts purpose (e.g., Advertising Revenue - Linear TV, Content Production Costs, Subscription Revenue - SVOD).',
    `account_notes` STRING COMMENT 'Free-text field for additional notes, usage guidelines, or special instructions related to this account. Used to document account-specific policies, restrictions, or business context.',
    `account_short_text` STRING COMMENT 'Abbreviated name or short description of the account used in reports and transaction displays where space is limited.',
    `account_status` STRING COMMENT 'Current lifecycle status of the account: active (available for posting), inactive (not available for new postings but retains history), blocked (temporarily suspended), or pending_approval (awaiting activation approval).. Valid values are `active|inactive|blocked|pending_approval`',
    `account_type` STRING COMMENT 'High-level classification of the account into fundamental accounting categories: asset (balance sheet), liability (balance sheet), equity (balance sheet), revenue (P&L), or expense (P&L). Determines which financial statement the account appears on.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternative_account_number` STRING COMMENT 'An alternative or legacy account number used for mapping to previous chart of accounts structures, external reporting systems, or consolidation systems. Supports migration and integration scenarios.',
    `balance_sheet_classification` STRING COMMENT 'For balance sheet accounts, specifies whether the account is classified as current asset, non-current asset, current liability, non-current liability, or equity. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `chart_of_accounts_code` STRING COMMENT 'The chart of accounts identifier to which this account belongs. Media Broadcasting may maintain multiple charts of accounts for different regions or business units (e.g., USGA for US GAAP, IFRS for international operations).. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'The SAP company code (legal entity) to which this chart of accounts entry applies. Supports multi-entity environments where different legal entities may have entity-specific account configurations.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_account` STRING COMMENT 'The consolidation account code used for corporate consolidation and intercompany eliminations. Maps local entity accounts to group-level chart of accounts for consolidated financial reporting.',
    `cost_center_required` BOOLEAN COMMENT 'Indicates whether a cost center must be specified when posting to this account. True for expense accounts requiring cost center assignment; false for balance sheet and revenue accounts.',
    `cost_element_category` STRING COMMENT 'Classification of the account as a cost element for controlling purposes: primary (direct posting from FI), secondary (internal allocations/assessments), revenue (revenue postings), or none (not a cost element). Links financial accounting to management accounting.. Valid values are `primary|secondary|revenue|none`',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this chart of accounts entry in SAP S/4HANA. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was first created in the system. Part of the audit trail for master data governance.',
    `financial_statement_item` STRING COMMENT 'The line item code on the financial statement (balance sheet or income statement) where this accounts balance is reported. Used for financial statement generation and external reporting.',
    `functional_area` STRING COMMENT 'SAP functional area classification used for segment reporting and cost-of-sales accounting. Represents business functions such as Content Production, Distribution, Sales & Marketing, Technology, Corporate. Enables P&L reporting by business function per IFRS requirements.',
    `gl_account_number` STRING COMMENT 'The unique account code used to identify this general ledger account across all financial postings. This is the authoritative account identifier used in SAP S/4HANA FI module for all financial transactions.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this chart of accounts entry. Used for change tracking and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was last modified. Part of the audit trail for master data change management.',
    `line_item_display_allowed` BOOLEAN COMMENT 'Indicates whether individual line items (transaction details) can be displayed for this account. True enables drill-down to transaction level; false shows only account balance. Typically true for balance sheet accounts, false for P&L accounts.',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which transactions or balances in this account are considered material for audit and control purposes. Used to determine testing scope and control frequency for SOX compliance.',
    `open_item_management` BOOLEAN COMMENT 'Indicates whether this account uses open item management, tracking individual postings until they are cleared (e.g., for receivables, payables, clearing accounts). True enables clearing transactions; false for standard balance accounts.',
    `pl_statement_classification` STRING COMMENT 'For P&L accounts, specifies the detailed classification within the income statement (e.g., Operating Revenue, Cost of Sales, Operating Expenses, Depreciation, Interest Expense, Tax Expense). Not applicable for balance sheet accounts.',
    `planning_level` STRING COMMENT 'The planning level or budget category assigned to this account for financial planning and budgeting purposes. Links the account to budget planning hierarchies and enables budget vs. actual reporting.',
    `posting_blocked` BOOLEAN COMMENT 'Indicates whether direct postings to this account are currently blocked. True prevents new transactions; false allows normal posting. Used to freeze accounts during period-end close or for inactive accounts.',
    `profit_center_required` BOOLEAN COMMENT 'Indicates whether a profit center must be specified when posting to this account. True for accounts requiring segment profitability tracking; false otherwise.',
    `reconciliation_account_type` STRING COMMENT 'Identifies if this is a reconciliation account (subledger control account) and its type: customer (accounts receivable), vendor (accounts payable), asset (fixed assets), or none (standard GL account). Reconciliation accounts are automatically posted from subledgers.. Valid values are `customer|vendor|asset|none`',
    `sox_control_classification` STRING COMMENT 'Classification of the account for SOX compliance purposes: key_control (critical accounts requiring enhanced controls and testing), supporting_control (accounts with standard controls), or not_in_scope (accounts outside SOX scope). Drives audit testing requirements.. Valid values are `key_control|supporting_control|not_in_scope`',
    `tax_category` STRING COMMENT 'The tax category classification for this account, determining how tax is calculated and posted (e.g., Input Tax, Output Tax, Non-Taxable, Tax Exempt). Used for VAT/GST/sales tax processing.',
    `trading_partner_required` BOOLEAN COMMENT 'Indicates whether a trading partner (intercompany entity) must be specified when posting to this account. True for intercompany accounts requiring elimination tracking; false for standard accounts.',
    `valid_from_date` DATE COMMENT 'The date from which this account becomes active and available for posting. Supports time-dependent chart of accounts changes and new account activation.',
    `valid_to_date` DATE COMMENT 'The date until which this account remains active. After this date, the account is no longer available for posting. Null indicates the account is currently active with no planned end date.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'SAP S/4HANA FI-authoritative chart of accounts defining the complete hierarchy of general ledger account codes used across all Media Broadcasting entities. Captures account number, account type (P&L, balance sheet), account group, functional area, cost element category, currency, consolidation account mapping, and SOX control classification. Serves as the foundational reference for all financial postings, period-end close, and intercompany eliminations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Station cost centers map to licensed facilities for regulatory cost reporting (ownership reports, financial qualifications). Cost center structure typically mirrors license structure in broadcast oper',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cost centers belong to legal entities in SAP CO organizational structure. The company_code is a business key reference to legal_entity.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy, enabling hierarchical cost roll-ups and departmental P&L aggregation.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center to which this cost center is assigned for internal management reporting and EBITDA tracking.',
    `activity_type` STRING COMMENT 'The primary activity type or service provided by this cost center for internal cost allocation purposes (e.g., Studio Hours, Editing Hours, Transmission Hours).',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total annual budget allocated to this cost center for the current fiscal year, in the cost centers currency.',
    `budget_allocation_reference` STRING COMMENT 'Reference identifier to the annual or periodic budget allocation document for this cost center, used for budget vs. actual variance analysis.',
    `business_area` STRING COMMENT 'The business area or division within Media Broadcasting to which this cost center belongs (e.g., Linear Broadcasting, Streaming Platforms, News Division, Sports Division).',
    `cost_center_category` STRING COMMENT 'Classification of the cost center by cost behavior: direct costs attributable to specific content/programs, indirect costs supporting operations, overhead, or capital expenditure.. Valid values are `direct|indirect|overhead|capital`',
    `cost_center_code` STRING COMMENT 'The business identifier code for the cost center as defined in SAP Controlling (CO) module. Used for financial reporting and budget tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity to which this cost center is assigned for financial reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP Controlling Area code to which this cost center belongs. Controlling area represents the organizational unit for cost accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects (e.g., direct assignment, activity-based costing, percentage allocation, driver-based).. Valid values are `direct|activity_based|percentage|driver_based`',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center indicating whether it is operational and available for cost posting.. Valid values are `active|inactive|blocked|pending_closure`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional area within the media broadcasting business. [ENUM-REF-CANDIDATE: production|operations|sales|distribution|corporate|technology|content_acquisition — 7 candidates stripped; promote to reference product]',
    `cost_element_group` STRING COMMENT 'The primary cost element group or category that this cost center typically incurs (e.g., Personnel Costs, Production Costs, Technology Costs, Rights & Licensing).',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this cost center record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers budget and actual costs are tracked (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code within the organizational structure to which this cost center is assigned.',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and responsibilities within the organization.',
    `ebitda_reporting_segment` STRING COMMENT 'The EBITDA reporting segment to which this cost centers costs are allocated for executive and investor reporting.',
    `functional_area` STRING COMMENT 'The functional classification of the cost center for financial statement reporting (e.g., Production, Distribution, Sales & Marketing, General & Administrative).',
    `hierarchy_node` STRING COMMENT 'The position of this cost center within the organizational cost center hierarchy, used for roll-up reporting and consolidation.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this cost center participates in intercompany transactions requiring elimination entries during consolidation.',
    `is_revenue_generating` BOOLEAN COMMENT 'Flag indicating whether this cost center directly generates revenue (e.g., Ad Sales regions) or is purely a cost-incurring unit.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this cost center record in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated in the system.',
    `location_code` STRING COMMENT 'The physical location or facility code where this cost center operates (e.g., studio location, broadcast center, regional office).',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center (e.g., Digital Platform Operations, News Production Studio A, Ad Sales Northeast Region).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about this cost centers purpose or operational considerations.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX financial controls and requires enhanced audit trail and approval workflows.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center becomes active and available for cost posting in the financial system.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center remains active. Null indicates an open-ended validity period.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'SAP CO-authoritative cost center master data representing organizational units responsible for incurring costs across Media Broadcasting — including production studios, broadcast operations, digital platforms, sales regions, and corporate functions. Tracks cost center code, hierarchy node, responsible manager, controlling area, profit center assignment, currency, validity period, and budget allocation reference. Enables granular cost tracking for EBITDA reporting and departmental P&L.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique system identifier for the profit center record. Primary key.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Profit centers align with licensed stations for financial and regulatory reporting. License-level EBITDA is required for debt covenants, ownership attribution rules, and FCC financial qualification re',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Profit centers belong to legal entities in SAP CO organizational structure. The company_code is a business key reference to legal_entity. This is essential for P&L consolidation.',
    `employee_id` BIGINT COMMENT 'The unique employee identifier of the manager responsible for this profit center. Links to HR master data for organizational reporting.',
    `activation_date` DATE COMMENT 'The date on which this profit center was activated and began accepting financial postings. Used for historical analysis and lifecycle tracking.',
    `budget_allocation_method` STRING COMMENT 'The methodology used for allocating budgets to this profit center. Top-down allocates from corporate targets; bottom-up aggregates from operational plans; zero-based requires justification of all expenses; incremental adjusts prior year budgets.. Valid values are `top_down|bottom_up|zero_based|incremental`',
    `business_unit` STRING COMMENT 'The higher-level business unit or division to which this profit center belongs. Used for hierarchical rollup in management reporting. Examples: Digital Media, Broadcast Networks, Content Production.',
    `closure_date` DATE COMMENT 'The date on which this profit center was closed and ceased operations. Null for active profit centers. Used for historical reporting and archival.',
    `profit_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the profit center within the controlling area. Used in SAP CO for segment reporting and management accounting. Examples: SVOD-US, LINEAR-UK, ADSALES-NA.. Valid values are `^[A-Z0-9]{4,10}$`',
    `company_code` STRING COMMENT 'The company code representing the legal entity to which this profit center belongs. Used for financial statement preparation and legal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The controlling area to which this profit center is assigned. Controlling area is the organizational unit in SAP CO that represents a closed system for cost accounting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_assignment_flag` BOOLEAN COMMENT 'Indicates whether cost centers can be directly assigned to this profit center for cost allocation and internal charging purposes.',
    `country_code` STRING COMMENT 'The primary country of operation for this profit center. Three-letter ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The functional currency in which this profit center conducts its operations and reports financial results. Three-letter ISO 4217 code.. Valid values are `^[A-Z]{3}$`',
    `profit_center_description` STRING COMMENT 'Detailed textual description of the profit centers business purpose, scope of operations, and strategic role within the enterprise. Used for documentation and onboarding.',
    `ebitda_reporting_flag` BOOLEAN COMMENT 'Indicates whether this profit center is included in EBITDA segment reporting for management and investor communications. EBITDA is a key profitability metric in media broadcasting.',
    `geographic_region` STRING COMMENT 'The primary geographic region or market in which this profit center operates. Used for regional performance analysis and geographic segment reporting. Examples: North America, EMEA, APAC, Latin America.',
    `hierarchy_node` STRING COMMENT 'The node identifier within the profit center standard hierarchy. Used for multi-level aggregation and drill-down reporting in management accounting.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether transactions involving this profit center require intercompany elimination adjustments during financial consolidation. Used in multi-entity corporate structures.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this profit center record. Used for accountability and audit trail purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center record was last updated. Used for change tracking and audit compliance.',
    `profit_center_name` STRING COMMENT 'The full business name of the profit center. Human-readable label used in financial reports and management dashboards.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special instructions, or historical information about the profit center. Used by finance teams for operational reference.',
    `parent_profit_center_code` STRING COMMENT 'The code of the parent profit center in the organizational hierarchy, if this profit center rolls up to another. Enables hierarchical consolidation for segment EBITDA and management reporting.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active profit centers are operational and accept postings; inactive are temporarily suspended; planned are future entities; closed are historical and no longer accept transactions.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center based on its accountability model. Revenue centers are responsible for revenue generation; cost centers for cost control; investment centers for return on invested capital; service centers provide internal services.. Valid values are `revenue_center|cost_center|investment_center|service_center`',
    `revenue_posting_flag` BOOLEAN COMMENT 'Indicates whether revenue transactions can be posted directly to this profit center. Used to control which profit centers participate in revenue recognition workflows.',
    `segment_code` STRING COMMENT 'The segment classification for external segment reporting under IFRS 8 and US GAAP. Segments represent distinguishable components of the business for which discrete financial information is available and regularly reviewed by the chief operating decision maker. Examples: Streaming, Linear Broadcasting, Advertising, Syndication.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit center, used in condensed reports and system displays where space is limited.',
    `sox_control_scope_flag` BOOLEAN COMMENT 'Indicates whether this profit center is within the scope of SOX financial controls and requires enhanced audit trails and segregation of duties for financial postings.',
    `transfer_pricing_method` STRING COMMENT 'The method used for pricing internal transactions between this profit center and other organizational units. Examples: cost-plus, market-based, negotiated. Critical for accurate profit center performance measurement.',
    `valid_from_date` DATE COMMENT 'The date from which this profit center configuration is effective. Used for time-dependent master data versioning in SAP CO.',
    `valid_to_date` DATE COMMENT 'The date until which this profit center configuration is effective. Null indicates open-ended validity. Used for time-dependent master data versioning.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP CO-authoritative profit center master representing autonomous business units within Media Broadcasting that are evaluated on profitability — such as SVOD platform, linear broadcast network, advertising sales division, and syndication unit. Captures profit center code, hierarchy, controlling area, responsible manager, currency, and segment classification. Underpins segment reporting, EBITDA tracking, and management accounting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger record. Primary key for the general ledger data product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: GL entries reference chart of accounts for account metadata. The gl_account STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id. The gl_account_descr',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: General ledger entries belong to legal entities in SAP S/4HANA FI. The company_code is a business key reference to legal_entity. This is the foundational relationship for financial consolidation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: GL entries can be allocated to cost centers for cost tracking. The cost_center STRING column will be replaced by FK to cost_center.cost_center_id.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: GL entries can be allocated to profit centers for P&L tracking. The profit_center STRING column will be replaced by FK to profit_center.profit_center_id.',
    `account_type` STRING COMMENT 'High-level classification of the general ledger account into one of the five fundamental accounting categories: asset, liability, equity, revenue, or expense. Used for financial statement preparation and trial balance categorization.. Valid values are `asset|liability|equity|revenue|expense`',
    `budget_amount_functional_currency` DECIMAL(18,2) COMMENT 'Budgeted amount allocated to the general ledger account for the fiscal period, expressed in functional currency. Used for budget vs. actual variance analysis and financial planning. Particularly relevant for production budgets, content acquisition costs, and operational expense management.',
    `business_area` STRING COMMENT 'Four-character code representing the business area or division for code reporting. Enables consolidated financial statements across multiple legal entities within the same business segment (e.g., linear broadcasting, streaming platforms, syndication).. Valid values are `^[A-Z0-9]{4}$`',
    `closing_balance_functional_currency` DECIMAL(18,2) COMMENT 'Closing balance of the general ledger account at the end of the fiscal period, expressed in functional currency. Calculated as opening balance plus net period activity. Represents the ending position for trial balance and financial statement generation.',
    `company_code` STRING COMMENT 'Four-character alphanumeric identifier for the legal entity within the Media Broadcasting enterprise. Represents the organizational unit for which separate financial statements are prepared. Maps to SAP S/4HANA company code structure.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_unit` STRING COMMENT 'Consolidation unit code representing the entity for group consolidation and statutory reporting. Used for multi-entity financial consolidation, intercompany eliminations, and corporate-level financial statement preparation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `credit_amount_functional_currency` DECIMAL(18,2) COMMENT 'Total credit amount posted to the general ledger account for the period, expressed in the functional currency of the company code. Represents increases to liability, equity, and revenue accounts or decreases to asset and expense accounts.',
    `credit_amount_transaction_currency` DECIMAL(18,2) COMMENT 'Total credit amount posted to the general ledger account for the period, expressed in the original transaction currency. Maintained for audit trail and foreign exchange reconciliation purposes.',
    `debit_amount_functional_currency` DECIMAL(18,2) COMMENT 'Total debit amount posted to the general ledger account for the period, expressed in the functional currency of the company code. Represents increases to asset and expense accounts or decreases to liability, equity, and revenue accounts.',
    `debit_amount_transaction_currency` DECIMAL(18,2) COMMENT 'Total debit amount posted to the general ledger account for the period, expressed in the original transaction currency. Maintained for audit trail and foreign exchange reconciliation purposes.',
    `document_type` STRING COMMENT 'Two-character code representing the type of accounting document that generated the general ledger entry (e.g., SA for G/L account document, DR for customer invoice, KR for vendor invoice, DZ for payment). Used for document classification and posting control.. Valid values are `^[A-Z]{2}$`',
    `ebitda_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the general ledger account is included in EBITDA calculation for management reporting and investor disclosures. True if the account contributes to EBITDA (operating revenues and expenses), false if excluded (interest, taxes, depreciation, amortization).',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year for which the general ledger balance is recorded. Represents the accounting period year aligned with the companys financial reporting calendar.',
    `functional_area` STRING COMMENT 'Functional area code representing the business function or operational domain (e.g., content production, advertising sales, distribution, subscriber management). Used for cross-organizational reporting and functional cost analysis.. Valid values are `^[A-Z0-9]{4,6}$`',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency of the company code (e.g., USD, GBP, EUR). The functional currency is the primary currency in which the legal entity conducts business and prepares financial statements.. Valid values are `^[A-Z]{3}$`',
    `gl_account` STRING COMMENT 'General ledger account number from the chart of accounts. Represents the specific account classification (asset, liability, equity, revenue, expense) for financial transactions. Structured according to the enterprise chart of accounts hierarchy.. Valid values are `^[0-9]{6,10}$`',
    `last_posting_date` DATE COMMENT 'Date of the most recent transaction posted to this general ledger account within the fiscal period. Used for audit trail and period-end reconciliation validation.',
    `ledger_group` STRING COMMENT 'Ledger group code representing the accounting principle or reporting standard (e.g., 0L for leading ledger, 2L for IFRS, 3L for US GAAP). Enables parallel accounting for multiple reporting frameworks within a single system.. Valid values are `^[A-Z0-9]{2}$`',
    `net_balance_functional_currency` DECIMAL(18,2) COMMENT 'Net balance of the general ledger account for the period, calculated as debit amount minus credit amount (or vice versa depending on account type), expressed in the functional currency. Represents the aggregated account state for trial balance and financial statement generation.',
    `opening_balance_functional_currency` DECIMAL(18,2) COMMENT 'Opening balance of the general ledger account at the beginning of the fiscal period, expressed in functional currency. Represents the carried-forward balance from the previous period for balance sheet accounts.',
    `period_lock_status` STRING COMMENT 'Status of the posting period indicating whether the period is open for new postings, closed for regular postings but open for adjustments, or locked for all postings. Used for period-end close control and financial statement finalization.. Valid values are `open|closed|locked`',
    `posting_key` STRING COMMENT 'Two-digit numeric code that controls the posting behavior and determines whether the entry is a debit or credit (e.g., 40 for debit, 50 for credit). Used for transaction validation and account determination logic.. Valid values are `^[0-9]{2}$`',
    `posting_period` STRING COMMENT 'Numeric posting period within the fiscal year (typically 1-12 for monthly periods, with additional special periods 13-16 for year-end adjustments). Represents the accounting period for transaction posting and period-end close.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the general ledger account is a reconciliation account (subledger control account) that must reconcile with subsidiary ledgers such as accounts receivable, accounts payable, or fixed assets. True if reconciliation account, false otherwise.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the general ledger record was first created in the system. Represents the initial capture time for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the general ledger record was last modified. Represents the most recent change time for audit trail and change tracking. Updated whenever period balances are adjusted or corrected.',
    `revenue_stream_category` STRING COMMENT 'Classification of revenue accounts by primary revenue stream type for Media Broadcasting business. Categories include advertising (linear and digital ad sales), subscription (SVOD/AVOD), carriage fees (MVPD/vMVPD distribution), syndication (content resale), licensing (rights monetization), transactional (TVOD), and other. Used for revenue assurance and segment reporting. [ENUM-REF-CANDIDATE: advertising|subscription|carriage_fees|syndication|licensing|transactional|other — 7 candidates stripped; promote to reference product]',
    `segment` STRING COMMENT 'Segment code for external segment reporting as required by IFRS 8 and US GAAP. Represents reportable business segments for statutory financial reporting and investor disclosures (e.g., content production, advertising, subscription services).. Valid values are `^[A-Z0-9]{6,10}$`',
    `sox_control_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the general ledger account is subject to Sarbanes-Oxley Act internal control requirements and audit procedures. True if SOX-controlled account requiring enhanced documentation and approval workflows, false otherwise.',
    `trading_partner` STRING COMMENT 'Trading partner code identifying the intercompany counterparty for intercompany transactions. Used for intercompany eliminations and consolidated financial statement preparation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the original transaction currency if different from functional currency. Used for multi-currency transactions requiring foreign exchange conversion and revaluation.. Valid values are `^[A-Z]{3}$`',
    `variance_amount_functional_currency` DECIMAL(18,2) COMMENT 'Variance between actual net balance and budgeted amount for the fiscal period, expressed in functional currency. Calculated as actual minus budget. Positive variance indicates over-budget for expense accounts or under-budget for revenue accounts.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SAP FI general ledger representing period-level account balances and individual line items for all Media Broadcasting legal entities. Each record captures a GL account balance within a company code, fiscal year, and posting period — storing debit/credit totals, functional and transaction currency amounts, document type references, and SOX control indicators. Serves as the authoritative source for trial balance generation, statutory financial statements, and period-end close validation. Distinguished from journal_entry (which holds individual postings) by representing the aggregated account state.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `employee_id` BIGINT COMMENT 'The SAP user ID of the individual who approved this journal entry for posting, as required by SOX internal control procedures. Null if no approval was required or entry is still pending approval.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Journal entries belong to legal entities in SAP S/4HANA FI. The company_code is a business key reference to legal_entity. This is essential for financial consolidation and SOX controls.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries in media broadcasting post to cost centers for production cost allocation, departmental expense tracking, and budget monitoring. Enables drill-down from GL to cost center detail for va',
    `maintenance_work_order_id` BIGINT COMMENT 'Foreign key linking to technology.maintenance_work_order. Business justification: Maintenance costs (labor, parts, vendor services) are journalized from completed work orders. Finance posts work order costs to GL accounts for facility/equipment maintenance expense tracking, cost ce',
    `primary_journal_employee_id` BIGINT COMMENT 'The SAP user ID of the individual who posted this journal entry into the system. Used for audit trail and accountability purposes.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries for revenue recognition, intercompany eliminations, and P&L postings require profit center assignment for segment reporting and EBITDA calculation. Critical for media broadcasting busi',
    `recurring_entry_template_id` BIGINT COMMENT 'The identifier of the recurring entry template from which this journal entry was generated. Populated only when recurring_entry_indicator is True.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Journal entries support regulatory filings (ownership change accounting, financial certifications in license applications, spectrum auction payments). Audit trail from filing to supporting GL entries ',
    `source_document_id` BIGINT COMMENT 'The unique identifier of the source document in the originating system that generated this journal entry. Used for traceability and reconciliation back to operational systems.',
    `sox_control_id` BIGINT COMMENT 'The identifier of the SOX internal control that governs the posting and approval of this journal entry type. Links the entry to the companys SOX compliance framework.',
    `accrual_reversal_date` DATE COMMENT 'The future posting date on which this accrual entry will automatically reverse. Populated only when accrual_reversal_indicator is True.',
    `accrual_reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is an automatic accrual reversal. True if this entry will automatically reverse in the subsequent period.',
    `adjustment_type` STRING COMMENT 'Classification of the journal entry by its accounting purpose: standard operational posting, period-end accrual, prepayment amortization, account reclassification, intercompany elimination, or error correction.. Valid values are `standard|accrual|prepayment|reclassification|elimination|correction`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry was approved by the designated approver. Null if no approval was required or entry is still pending approval.',
    `batch_input_session` STRING COMMENT 'The name of the batch input session if this journal entry was posted via batch processing rather than manual entry. Empty for manually posted entries.',
    `company_code` STRING COMMENT 'Four-character code identifying the legal entity within the Media Broadcasting enterprise for which this journal entry is posted. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the journal entry amounts are denominated (e.g., USD, GBP, EUR). All line items within this document share this currency.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract) that gave rise to this journal entry. May differ from posting date when entries are posted retrospectively.',
    `document_header_text` STRING COMMENT 'Descriptive text at the document header level providing context or explanation for the journal entry, such as the business purpose, transaction description, or special instructions.',
    `document_number` STRING COMMENT 'The externally-known SAP document number assigned to this journal entry at posting time. This is the business identifier used across financial reporting and audit trails.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the nature of the accounting document (e.g., SA=General Ledger Document, DR=Customer Invoice, KR=Vendor Invoice, DZ=Customer Payment, KZ=Vendor Payment, AB=Accounting Document). Controls the number range and field status for the entry.. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'The calendar date when the journal entry was physically entered into the SAP system by the user, which may differ from both document date and posting date.',
    `entry_time` TIMESTAMP COMMENT 'The precise date and time when the journal entry was created in the SAP system. Provides audit trail for record creation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert document currency amounts to local currency amounts at the time of posting. Expressed as local currency per one unit of document currency.',
    `exchange_rate_type` STRING COMMENT 'Single-character code indicating the type of exchange rate used (e.g., M=Average Rate, B=Bank Buying Rate, G=Bank Selling Rate). Determines which rate table is consulted for currency conversion.. Valid values are `^[A-Z]{1}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this journal entry is posted, following the companys financial calendar. Used for period-end close and annual financial reporting.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction between different legal entities within Media Broadcasting. True for intercompany entries requiring elimination in consolidated reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry record was last modified in the system. Used for change tracking and audit compliance.',
    `ledger_group` STRING COMMENT 'Two-character code identifying the ledger group to which this journal entry belongs. Supports parallel accounting for different accounting principles (e.g., 0L=Leading Ledger, 2L=IFRS Ledger, 3L=Tax Ledger).. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency of the company code. Used for parallel accounting and statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `parked_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is in parked status (saved but not yet posted). True if parked, False if fully posted.',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the accounting date that determines the fiscal period and is used for financial statement reporting. Represents the principal business event timestamp for this transaction.',
    `posting_period` STRING COMMENT 'The accounting period (typically 1-12 for monthly periods, with additional special periods 13-16 for year-end adjustments) within the fiscal year when this entry was posted.',
    `recurring_entry_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is part of a recurring entry template (e.g., monthly depreciation, rent accruals). True if generated from a recurring template.',
    `reference_number` STRING COMMENT 'Free-text reference field used to store external document identifiers such as invoice numbers, purchase order numbers, contract references, or other source system identifiers that link this journal entry to originating business transactions.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previously posted document. True if this entry reverses another entry, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Two-digit code indicating the business reason for reversing the original document (e.g., 01=Error Correction, 02=Accrual Reversal, 03=Period-End Adjustment). Populated only when reversal_indicator is True.. Valid values are `^[0-9]{2}$`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system from which this journal entry was interfaced into SAP S/4HANA (e.g., WideOrbit for advertising revenue, Zuora for subscription billing, Rightsline for royalty accruals). Empty for entries created directly in SAP.',
    `trading_partner_company_code` STRING COMMENT 'The company code of the intercompany trading partner for intercompany transactions. Populated only when intercompany_indicator is True. Used for intercompany reconciliation and consolidation eliminations.',
    `transaction_code` STRING COMMENT 'The SAP transaction code (T-Code) used to post this journal entry (e.g., FB01, FB50, F-02). Indicates the posting interface and provides context for the entry method.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `workflow_status` STRING COMMENT 'Current status of the journal entry within the SOX-compliant approval workflow. Tracks the document through draft, approval, posting, and potential reversal stages.. Valid values are `draft|pending_approval|approved|rejected|posted|reversed`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Individual accounting document posted to the SAP S/4HANA general ledger capturing all financial transactions across Media Broadcasting — including revenue recognition postings, accruals, prepayments, intercompany charges, and period-end adjustments. Records document number, company code, posting date, document date, document type, reference, reversal indicator, posting user, and SOX approval workflow status. The atomic unit of financial record-keeping.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` (
    `production_budget_id` BIGINT COMMENT 'Primary key for production_budget',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Production budgets track facility usage costs for content creation. Productions book broadcast facilities (studios, control rooms) and production accounting allocates facility rental/usage charges to ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production budgets are allocated to cost centers for expense tracking. The cost_center_code STRING column will be replaced by FK to cost_center.cost_center_id.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Production budgets include line items for music licensing, archive footage licensing, and rights acquisitions governed by license agreements. Required for production cost tracking, budget variance ana',
    `project_id` BIGINT COMMENT 'Reference to the production project (scripted series, film, live event, news programming, digital original) for which this budget is allocated.',
    `studio_facility_id` BIGINT COMMENT 'Foreign key linking to technology.studio_facility. Business justification: Production budgets specifically track studio bookings and usage costs. Studios are booked per production project with hourly/daily rates charged to project budgets. Finance requires studio identificat',
    `above_the_line_amount` DECIMAL(18,2) COMMENT 'Budget allocated to above-the-line costs including key creative talent (writers, directors, producers, lead actors). These are typically negotiated individually and represent significant budget items.',
    `actual_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure against this budget as of the last financial update. Used for variance tracking and budget performance monitoring.',
    `approval_date` DATE COMMENT 'The date on which this production budget was formally approved for spending.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or financial authority who approved this production budget.',
    `below_the_line_amount` DECIMAL(18,2) COMMENT 'Budget allocated to below-the-line costs including crew, equipment, facilities, and production support. These are standard production costs not tied to key creative talent.',
    `budget_effective_date` DATE COMMENT 'The date from which this budget version becomes effective and spending authorization begins.',
    `budget_expiry_date` DATE COMMENT 'The date on which this budget version expires or is superseded by a new version. Null for open-ended budgets.',
    `budget_notes` STRING COMMENT 'Free-text notes and comments regarding this budget version, including justification for revisions, special conditions, or approval stipulations.',
    `budget_number` STRING COMMENT 'Externally-known unique identifier for the production budget, used for tracking and reference in financial systems and production workflows.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the production budget. Tracks progression from draft through approval to active spending and final closure. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|revised|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the production budget by content type. Different content types have different cost structures and budget approval workflows. [ENUM-REF-CANDIDATE: scripted_series|film|live_event|news_programming|digital_original|documentary|sports|reality|animation — 9 candidates stripped; promote to reference product]',
    `budget_version` STRING COMMENT 'Version number of the budget. Budgets are revised throughout the production lifecycle; this field tracks the iteration (e.g., 1 for initial, 2 for first revision).. Valid values are `^[0-9]{1,3}$`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount committed through purchase orders and contracts but not yet invoiced or paid. Used for funds reservation and budget availability calculation.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Contingency reserve allocated for unforeseen production costs and budget overruns. Typically 5-10% of total budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `facilities_amount` DECIMAL(18,2) COMMENT 'Budget allocated to production facilities including studio rental, location fees, set construction, and production office space.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this production budget is allocated. Used for annual financial planning and reporting.. Valid values are `^[0-9]{4}$`',
    `internal_order_number` STRING COMMENT 'SAP CO internal order number used for production cost control and tracking actual expenditures against this budget.. Valid values are `^[A-Z0-9]{6,15}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production budget record was last updated. Used for change tracking and audit trail.',
    `music_licensing_amount` DECIMAL(18,2) COMMENT 'Budget allocated to music licensing, original score composition, and music rights clearance for the production.',
    `post_production_amount` DECIMAL(18,2) COMMENT 'Budget allocated to post-production activities including editing, color correction, sound design, mixing, and final mastering.',
    `production_end_date` DATE COMMENT 'Planned or actual end date of production for this project. Used for budget closure and final cost reconciliation.',
    `production_start_date` DATE COMMENT 'Planned or actual start date of production for this project. Used for budget phasing and cash flow planning.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this budget is subject to SOX financial controls and audit requirements. True for budgets above materiality thresholds.',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'Total approved budget amount for the production project across all cost categories. This is the authorized spending limit.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between approved budget and actual spend (approved amount minus actual spend). Positive values indicate under-budget, negative values indicate over-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the approved budget. Used for budget performance dashboards and exception reporting.',
    `vfx_amount` DECIMAL(18,2) COMMENT 'Budget allocated to visual effects production. VFX is often a significant cost category for scripted series, films, and high-production-value content.',
    CONSTRAINT pk_production_budget PRIMARY KEY(`production_budget_id`)
) COMMENT 'Financial budget allocated to individual content production projects — covering scripted series, films, live events, news programming, and digital originals. Tracks approved budget amount by cost category (above-the-line talent, below-the-line crew, facilities, post-production, VFX, music licensing), budget version, fiscal year, production project reference, cost center, currency, approval status, and variance-to-actual tracking. Integrates with SAP CO internal orders for production cost control.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` (
    `budget_version_id` BIGINT COMMENT 'Unique identifier for the budget version record. Primary key.',
    `employee_id` BIGINT COMMENT 'The employee identifier of the approver in the HR system. Links to the employee master data for audit and authorization verification.',
    `budget_employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this budget version record. Links to the user management system for accountability and audit purposes.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget entity that this version belongs to. Links to the master budget record.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center for which this budget version applies. Used for departmental and operational expense tracking.',
    `project_id` BIGINT COMMENT 'Reference to the production project for which this budget version applies. Used for content production budget tracking and cost management.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for which this budget version applies. Used for revenue and profitability analysis by business unit or channel.',
    `approval_date` DATE COMMENT 'The date on which this budget version was formally approved by the authorized approver. Used for audit trail and compliance tracking.',
    `approver_name` STRING COMMENT 'The full name of the individual who approved this budget version. Typically a finance director, CFO, or department head with budget authority.',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The original baseline budget amount before any revisions or adjustments. Used as a reference point for variance analysis and tracking budget changes over time.',
    `budget_category` STRING COMMENT 'High-level classification of the budget type. Operating expense (OPEX) covers day-to-day costs; capital expenditure (CAPEX) covers long-term investments; production cost tracks content creation spend; revenue target sets income goals; headcount manages personnel costs; marketing covers promotional spend; content acquisition tracks licensing and rights purchases. [ENUM-REF-CANDIDATE: operating_expense|capital_expenditure|production_cost|revenue_target|headcount|marketing|content_acquisition — 7 candidates stripped; promote to reference product]',
    `budget_version_status` STRING COMMENT 'Current lifecycle status of the budget version. Draft indicates work in progress; pending approval is awaiting authorization; approved is authorized but not yet active; active is currently in effect; superseded has been replaced by a newer version; closed is finalized and archived.. Valid values are `draft|pending_approval|approved|active|superseded|closed`',
    `change_rationale` STRING COMMENT 'Detailed explanation of why this budget version was created. Captures the business justification for revisions, reforecasts, or supplemental allocations. Critical for variance analysis and audit compliance.',
    `consolidation_level` STRING COMMENT 'Indicates the organizational level at which this budget version is consolidated. Entity is the highest corporate level; division represents major business units; department is operational units; project is specific initiatives; consolidated represents fully aggregated budgets.. Valid values are `entity|division|department|project|consolidated`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget version record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP). Ensures accurate multi-currency budget tracking and consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget version ceases to be effective. Nullable for open-ended budgets. Used to manage budget version lifecycles and historical tracking.',
    `effective_start_date` DATE COMMENT 'The date from which this budget version becomes effective and active for budget control and variance reporting.',
    `external_reference_code` STRING COMMENT 'An external identifier or reference number from the source system or external budgeting tool. Used for cross-system reconciliation and traceability.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget version applies. Typically a four-digit year (e.g., 2024).',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version is locked from further edits. True means the version is frozen and cannot be modified; false means it is still editable. Used to enforce budget control and prevent unauthorized changes after approval.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget version record was last updated. Tracks the most recent change for audit and version control purposes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, assumptions, or context related to this budget version. Used by finance teams to document planning assumptions, constraints, or special considerations.',
    `planning_period` STRING COMMENT 'The planning period granularity for this budget version. Supports quarterly (Q1-Q4), monthly (M01-M12), half-yearly (H1-H2), or full fiscal year (FY) planning cycles.. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2]|FY)$`',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'The total monetary amount approved for this budget version. Represents the authorized spending limit or revenue target for the specified cost center, profit center, or production project.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'The acceptable variance percentage threshold for this budget version. Triggers alerts or approval workflows when actual spend deviates from budget by more than this percentage. Typically set between 5% and 15%.',
    `version_number` STRING COMMENT 'Sequential version number for this budget iteration. Increments with each revision or reforecast. Version 1 is typically the original approved budget.',
    `version_type` STRING COMMENT 'Classification of the budget version indicating its purpose and lifecycle stage. Original is the initial approved budget; revised reflects approved changes; forecast is a projection; actuals represent actual spend; rolling forecast is a continuous forward-looking estimate; supplemental is an additional allocation.. Valid values are `original|revised|forecast|actuals|rolling_forecast|supplemental`',
    CONSTRAINT pk_budget_version PRIMARY KEY(`budget_version_id`)
) COMMENT 'Versioned snapshot of an approved financial budget for a cost center, profit center, or production project within Media Broadcasting. Captures version number, version type (original, revised, forecast, actuals), fiscal year, planning period, total approved amount, currency, approval date, approver, and change rationale. Enables budget vs. actuals variance analysis and rolling forecast management across the enterprise.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` (
    `revenue_stream_id` BIGINT COMMENT 'Unique identifier for the revenue stream. Primary key for this entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Revenue streams map to GL accounts for revenue posting. The gl_account_code STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue streams can be associated with cost centers for revenue tracking. The cost_center_code STRING is a business key that should be supplemented with FK to cost_center.cost_center_id.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue streams are associated with profit centers for P&L attribution. The profit_center_code STRING is a business key that should be supplemented with FK to profit_center.profit_center_id.',
    `accounting_standard` STRING COMMENT 'The accounting standard governing revenue recognition for this stream (ASC 606 for US GAAP, IFRS 15 for international, or local GAAP variants).. Valid values are `ASC_606|IFRS_15|GAAP|local_GAAP`',
    `audience_measurement_source` STRING COMMENT 'Primary audience measurement provider used for revenue validation and guarantees (e.g., Nielsen, Comscore, Adobe Analytics). Critical for advertising revenue streams with audience guarantees.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether detailed audit trail and supporting documentation must be maintained for all transactions in this revenue stream (True for high-risk or regulated streams).',
    `business_unit` STRING COMMENT 'Business unit or division responsible for generating this revenue stream (e.g., Broadcast Networks, Digital Platforms, Studios).',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission rate percentage paid to sales representatives or agencies for revenue generated through this stream.',
    `content_type` STRING COMMENT 'Type of content delivery associated with this revenue stream: live, on-demand, linear (scheduled), non-linear, simulcast, catch-up, or archive. [ENUM-REF-CANDIDATE: live|on_demand|linear|non_linear|simulcast|catch_up|archive — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Type of contractual arrangement governing this revenue stream: upfront (advance commitment), scatter (spot market), guaranteed delivery, non-guaranteed, fixed fee, variable fee, or hybrid. [ENUM-REF-CANDIDATE: upfront|scatter|guaranteed|non_guaranteed|fixed_fee|variable_fee|hybrid — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue stream record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for revenue transactions in this stream (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this revenue stream classification ceased to be effective. Null for currently active streams. Used for historical analysis and sunset planning.',
    `effective_start_date` DATE COMMENT 'Date when this revenue stream classification became effective and began generating revenue. Used for historical revenue analysis and period-over-period comparisons.',
    `gl_account_code` STRING COMMENT 'General ledger account code in the chart of accounts where revenue from this stream is posted.. Valid values are `^[0-9]{4,10}$`',
    `is_deferred` BOOLEAN COMMENT 'Indicates whether revenue from this stream is initially recorded as deferred revenue and recognized over time (True for advance payments, subscriptions; False for immediate recognition).',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this revenue stream generates recurring revenue (True for subscriptions, carriage fees; False for one-time transactions, spot advertising).',
    `makegoods_policy` STRING COMMENT 'Policy for providing makegoods (compensatory ad spots) when delivery guarantees are not met: automatic, negotiated, none, audience-based, or technical failure only.. Valid values are `automatic|negotiated|none|audience_based|technical_failure`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this revenue stream record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue stream record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional business context, special handling instructions, or historical notes about this revenue stream classification.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for this revenue stream (e.g., Net 30, Net 60). Used for accounts receivable aging and cash flow forecasting.',
    `performance_obligation` STRING COMMENT 'Description of the performance obligation that must be satisfied for revenue recognition per ASC 606 / IFRS 15 (e.g., delivery of ad impressions, provision of streaming access, content licensing rights transfer).',
    `platform_type` STRING COMMENT 'Distribution platform type for this revenue stream: linear broadcast, OTT (Over-The-Top), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual MVPD), FAST (Free Ad-Supported Streaming TV), VOD, theatrical, syndication, or digital. [ENUM-REF-CANDIDATE: linear|OTT|MVPD|vMVPD|FAST|VOD|theatrical|syndication|digital — 9 candidates stripped; promote to reference product]',
    `pricing_model` STRING COMMENT 'Pricing structure for this revenue stream: CPM (Cost Per Mille for advertising), flat rate, tiered pricing, usage-based, revenue share, or hybrid model.. Valid values are `CPM|flat_rate|tiered|usage_based|revenue_share|hybrid`',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized per accounting standards: point in time (transactional), over time (subscription), usage-based (consumption), or milestone-based (licensing).. Valid values are `point_in_time|over_time|usage_based|milestone_based`',
    `reporting_segment` STRING COMMENT 'Corporate reporting segment for external financial reporting (e.g., Linear Broadcasting, Streaming Services, Content Licensing). Used for segment disclosure per ASC 280 / IFRS 8.',
    `revenue_category` STRING COMMENT 'High-level classification of revenue type: advertising (upfront, scatter, DAI), subscription (SVOD, AVOD, TVOD), carriage fees, syndication, content licensing, ancillary, or transactional. [ENUM-REF-CANDIDATE: advertising|subscription|carriage|syndication|licensing|ancillary|transactional — 7 candidates stripped; promote to reference product]',
    `revenue_stream_status` STRING COMMENT 'Current lifecycle status of the revenue stream: active (currently generating revenue), inactive (not in use), suspended (temporarily halted), pending approval (awaiting finance approval), or deprecated (phased out).. Valid values are `active|inactive|suspended|pending_approval|deprecated`',
    `revenue_subcategory` STRING COMMENT 'Detailed sub-classification within the revenue category (e.g., Upfront, Scatter, Programmatic for advertising; SVOD, AVOD, TVOD for subscription; Linear Carriage, OTT Carriage for carriage fees).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this revenue stream is subject to SOX internal controls and requires additional audit documentation (True for material revenue streams, False for immaterial).',
    `stream_code` STRING COMMENT 'Business identifier code for the revenue stream (e.g., ADV-UPFRONT, SVOD-PREM, CARRIAGE-FEE). Used across financial systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `stream_name` STRING COMMENT 'Full descriptive name of the revenue stream (e.g., Upfront Advertising Sales, Premium SVOD Subscription, Syndication License Fees).',
    `tax_jurisdiction` STRING COMMENT 'Primary tax jurisdiction for this revenue stream using ISO 3166-1 alpha-2 or alpha-3 country codes (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{2,3}$`',
    `tax_treatment` STRING COMMENT 'Tax treatment classification for this revenue stream: taxable (subject to VAT/GST/sales tax), exempt, zero-rated, or out of scope.. Valid values are `taxable|exempt|zero_rated|out_of_scope`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this revenue stream record. Used for audit trail and accountability.',
    CONSTRAINT pk_revenue_stream PRIMARY KEY(`revenue_stream_id`)
) COMMENT 'Master classification of all revenue-generating streams across Media Broadcasting — advertising (upfront, scatter, DAI), subscription (SVOD, AVOD, TVOD), carriage fees, syndication license fees, content licensing, and ancillary revenues. Defines stream code, stream name, revenue category, recognition method (ASC 606 / IFRS 15), associated profit center, tax treatment, and reporting segment. Serves as the authoritative revenue taxonomy for financial reconciliation and EBITDA reporting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event. Primary key for this transactional record of revenue posting in SAP S/4HANA.',
    `ad_sales_order_id` BIGINT COMMENT 'Reference to the originating sales order (from Wide Orbit for ad sales, or Salesforce Media Cloud for direct sales) that triggered this revenue recognition event.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Revenue recognition events post to GL accounts. The gl_account_code STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Revenue recognition events belong to legal entities for financial reporting. The company_code is a business key reference to legal_entity.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content rating determines revenue recognition timing and advertising restrictions. Rated-R content has different distribution windows and ad inventory constraints affecting ASC 606 performance obligat',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, episode, film, program) associated with this revenue recognition event. Enables revenue attribution by content asset for rights and royalties management.',
    `contract_id` BIGINT COMMENT 'Reference to the underlying contract or agreement that governs this revenue recognition event. Links to the master contract entity.',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: COPPA-directed content has restricted advertising revenue (no behavioral targeting, limited data collection). Revenue recognition must account for lower CPMs and consent-gated monetization. Finance ne',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue can be allocated to cost centers for revenue tracking. The cost_center_code STRING column will be replaced by FK to cost_center.cost_center_id.',
    `employee_id` BIGINT COMMENT 'SAP S/4HANA user ID of the person or system account that posted this revenue recognition event. Required for SOX segregation of duties controls and audit trails.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice issued to the customer for this revenue. Links revenue recognition to accounts receivable and cash collection for revenue assurance.',
    `original_recognition_event_revenue_recognition_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event ID if this record represents a reversal or adjustment. Enables full audit trail of revenue corrections.',
    `performance_obligation_id` BIGINT COMMENT 'Reference to the specific performance obligation within the contract that this revenue recognition event satisfies. Critical for ASC 606 / IFRS 15 compliance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue is allocated to profit centers for P&L tracking and EBITDA reporting. The profit_center_code STRING column will be replaced by FK to profit_center.profit_center_id.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Revenue recognition events are classified by revenue stream (advertising, subscription, carriage fees, syndication). The revenue_stream_type STRING column will be replaced by FK to revenue_stream.reve',
    `subscriber_id` BIGINT COMMENT 'Reference to the customer (advertiser, subscriber, distributor, licensee) who is the counterparty to the revenue-generating contract. Links to the master customer entity.',
    `accounting_document_number` STRING COMMENT 'The SAP S/4HANA accounting document number (FI document) that records this revenue recognition event. Provides full audit trail and drill-back capability to source transactions.',
    `asc_606_compliant_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) confirming that this revenue recognition event was processed in accordance with ASC 606 (US GAAP) revenue recognition standards.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity or business unit that recognized this revenue. Used for intercompany eliminations and consolidated financial reporting.',
    `contract_modification_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this revenue recognition event resulted from a contract modification. ASC 606 requires specific accounting treatment for modified contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition event record was first created in the system. Critical for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the recognized and deferred amounts (e.g., USD, GBP, EUR). Critical for multi-currency financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The monetary amount of revenue deferred (not yet recognized) as of this event. Represents unearned revenue that will be recognized in future periods as performance obligations are satisfied.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this revenue recognition event was posted. Critical for monthly financial reporting and revenue trending.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this revenue recognition event was posted. Used for period-end close, annual financial statements, and year-over-year revenue analysis.',
    `gl_account_code` STRING COMMENT 'The general ledger account code in SAP S/4HANA chart of accounts to which this revenue recognition event was posted. Enables financial statement mapping and SOX-compliant audit trails.',
    `ifrs_15_compliant_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) confirming that this revenue recognition event was processed in accordance with IFRS 15 (International Financial Reporting Standards) revenue recognition standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition event record was last modified. Tracks changes for SOX compliance and financial audit requirements.',
    `notes` STRING COMMENT 'Free-text notes providing additional context or explanation for this revenue recognition event. Used for audit documentation, special accounting treatments, or manual adjustments.',
    `platform_type` STRING COMMENT 'The distribution platform or channel through which the revenue was generated: linear (traditional broadcast), OTT (over-the-top streaming), VOD (video on demand), SVOD (subscription VOD), AVOD (ad-supported VOD), TVOD (transactional VOD), FAST (free ad-supported streaming TV), MVPD (multichannel video programming distributor), vMVPD (virtual MVPD), or syndication (content resale). [ENUM-REF-CANDIDATE: linear|ott|vod|svod|avod|tvod|fast|mvpd|vmvpd|syndication — 10 candidates stripped; promote to reference product]',
    `recognition_date` DATE COMMENT 'The accounting date on which this revenue was recognized in the general ledger. This is the principal business event timestamp for financial reporting and period-end close.',
    `recognition_method` STRING COMMENT 'The revenue recognition method applied: point_in_time (recognized at a single moment, e.g., ad spot delivery), over_time (recognized ratably over contract term, e.g., subscription), milestone (recognized upon achievement of contractual milestones), or percentage_of_completion (recognized based on progress toward completion).. Valid values are `point_in_time|over_time|milestone|percentage_of_completion`',
    `recognition_status` STRING COMMENT 'Current lifecycle status of this revenue recognition event: recognized (fully posted to GL), deferred (not yet earned), partially_recognized (over-time recognition in progress), reversed (corrected or cancelled), or adjusted (modified post-recognition).. Valid values are `recognized|deferred|partially_recognized|reversed|adjusted`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The monetary amount of revenue recognized in this event and posted to the general ledger. Represents the earned portion of the transaction price allocated to the performance obligation.',
    `revenue_assurance_status` STRING COMMENT 'Status of revenue assurance validation for this recognition event: verified (passed all controls), pending_verification (awaiting reconciliation), discrepancy_identified (variance detected), or reconciled (discrepancy resolved).. Valid values are `verified|pending_verification|discrepancy_identified|reconciled`',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for revenue reversal or adjustment if recognition_status is reversed or adjusted. Examples: contract cancellation, pricing correction, performance obligation not met, billing error.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this revenue recognition event is subject to Sarbanes-Oxley (SOX) internal control testing and audit requirements.',
    `transaction_date` DATE COMMENT 'The original business transaction date (e.g., ad spot air date, subscription activation date, content delivery date) that triggered the revenue recognition event. May differ from recognition_date for deferred or over-time recognition scenarios.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Transactional record of each revenue recognition event posted in SAP S/4HANA for Media Broadcasting revenue streams — capturing the point-in-time or over-time recognition of advertising revenue, subscription fees, carriage fees, and content licensing income. Stores recognition date, recognized amount, deferred amount, performance obligation reference, contract modification flag, revenue stream, GL account, company code, and ASC 606 / IFRS 15 compliance indicators.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable record. Primary key for this entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: AR postings reference GL accounts from the chart of accounts. The gl_account STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Accounts receivable records must be associated with a legal entity for consolidation and reporting. The company_code is a business key reference to legal_entity. FK enables proper legal entity consoli',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR records can be allocated to cost centers for revenue tracking. The cost_center STRING column will be replaced by FK to cost_center.cost_center_id.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document that originated this receivable entry.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR records track profit center for revenue attribution and EBITDA reporting. The profit_center STRING column will be replaced by FK to profit_center.profit_center_id.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: AR is classified by revenue stream type (advertising, subscription, carriage fees, syndication). The revenue_stream STRING column will be replaced by FK to revenue_stream.revenue_stream_id for proper ',
    `subscriber_id` BIGINT COMMENT 'Identifier of the customer (advertiser, MVPD, syndication partner, or content licensee) who owes the receivable amount.',
    `aging_bucket` STRING COMMENT 'The aging category of the receivable based on days past due (current, 1-30 days, 31-60 days, 61-90 days, over 90 days).. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `assignment_field` STRING COMMENT 'Free-text assignment field used for additional sorting, grouping, or reconciliation purposes in SAP FI-AR.',
    `baseline_date` DATE COMMENT 'The reference date used to calculate payment terms and due date, typically the document date or posting date.',
    `business_unit` STRING COMMENT 'The business unit or division within Media Broadcasting that owns this receivable (e.g., Linear TV, Streaming, News, Sports).',
    `clearing_date` DATE COMMENT 'The date when the receivable was fully cleared through payment or other settlement mechanism. Null if still open.',
    `clearing_status` STRING COMMENT 'Current clearing status of the receivable indicating whether it is open, partially cleared, fully cleared, disputed, or written off.. Valid values are `open|partially_cleared|fully_cleared|disputed|written_off`',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity that holds this receivable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts receivable record was first created in the system.',
    `days_past_due` STRING COMMENT 'The number of days the receivable is overdue, calculated as the difference between current date and due date. Zero or negative if not yet due.',
    `dispute_date` DATE COMMENT 'The date when the customer formally disputed this receivable.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer has disputed this receivable (True = disputed, False = not disputed).',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the customer has disputed this receivable, if applicable.',
    `document_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the receivable was originally denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date on the original business document (invoice date, credit memo date) that created this receivable.',
    `document_number` STRING COMMENT 'The externally-known business document number for this receivable entry, typically the SAP FI-AR document number.',
    `document_type` STRING COMMENT 'Classification of the receivable document type (invoice, credit memo, debit memo, payment, down payment, adjustment).. Valid values are `invoice|credit_memo|debit_memo|payment|down_payment|adjustment`',
    `due_date` DATE COMMENT 'The date by which payment is expected from the customer based on payment terms.',
    `dunning_date` DATE COMMENT 'The date when the most recent dunning notice was sent to the customer for this receivable.',
    `dunning_level` STRING COMMENT 'The current dunning level indicating the escalation stage of collection efforts (0 = no dunning, 1-9 = escalating levels).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert document currency to local currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when this receivable was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this receivable was posted, used for period-end close and financial reporting.',
    `gl_account` STRING COMMENT 'The general ledger account code to which this receivable is posted in the chart of accounts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts receivable record was last updated or modified.',
    `local_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the companys local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The receivable amount converted to the companys local reporting currency for consolidation and financial reporting.',
    `open_amount` DECIMAL(18,2) COMMENT 'The current outstanding amount still owed by the customer in document currency after partial payments or adjustments.',
    `original_amount` DECIMAL(18,2) COMMENT 'The original gross amount of the receivable in document currency when first posted.',
    `payment_method` STRING COMMENT 'The expected or actual payment method for settling this receivable (wire transfer, check, ACH, credit card, direct debit, cash).. Valid values are `wire_transfer|check|ach|credit_card|direct_debit|cash`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the due date calculation, discount periods, and payment conditions (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date when the receivable was posted to the general ledger in the financial system.',
    `reference_document` STRING COMMENT 'External reference document number such as customer purchase order number, contract number, or other business reference.',
    `text_description` STRING COMMENT 'Free-text description or memo field providing additional context about this receivable entry.',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'SAP FI-AR authoritative record of outstanding receivables owed to Media Broadcasting from advertisers, MVPDs, syndication partners, and content licensees. Captures customer account, invoice reference, due date, open amount, currency, payment terms, dunning level, clearing status, aging bucket, and dispute flag. Supports cash flow forecasting, revenue assurance, and period-end close reconciliation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique identifier for the accounts payable record. Primary key for the accounts payable entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: AP postings reference GL accounts from the chart of accounts. The gl_account STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id for referential inte',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Accounts payable records must be associated with a legal entity for consolidation and reporting. The company_code is a business key reference to legal_entity. FK will enable proper legal entity consol',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP records can be allocated to cost centers for expense tracking. The cost_center STRING column will be replaced by FK to cost_center.cost_center_id, enabling proper cost allocation and budget trackin',
    `equipment_procurement_id` BIGINT COMMENT 'Foreign key linking to technology.equipment_procurement. Business justification: AP invoices are matched to equipment purchase orders for three-way match (PO, goods receipt, invoice). Finance validates invoice against PO terms for payment approval, purchase price variance analysis',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to technology.vendor_contract. Business justification: AP invoices are paid under vendor contracts (maintenance agreements, service contracts, equipment leases, support agreements). Finance validates invoice terms, pricing, and payment terms against maste',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom payment is owed. Links to talent agencies, production vendors, content licensors, technology providers, and distribution partners.',
    `assignment_reference` STRING COMMENT 'Free-text reference field for additional assignment information (e.g., production code, content title, project ID). Used for detailed cost tracking.',
    `baseline_date` DATE COMMENT 'Date from which payment terms are calculated. Typically the document date or goods receipt date, used to determine the due date.',
    `clearing_date` DATE COMMENT 'Date when the payable was fully cleared (paid). Null if still open or partially cleared.',
    `clearing_document_number` STRING COMMENT 'SAP FI document number of the payment document that cleared this payable. Null if not yet cleared.. Valid values are `^[0-9]{10}$`',
    `clearing_status` STRING COMMENT 'Current clearing status of the payable. Open=unpaid, Partially Cleared=partial payment applied, Fully Cleared=completely paid.. Valid values are `open|partially_cleared|fully_cleared`',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity responsible for this payable. Used for financial consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts payable record was first created in the SAP FI-AP system. Used for audit trail and data lineage.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Potential cash discount amount available if payment is made by the discount due date, in document currency.',
    `discount_due_date` DATE COMMENT 'Date by which payment must be made to qualify for early payment discount. Null if no discount terms apply.',
    `document_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice (e.g., USD, EUR, GBP). Currency in which the vendor billed.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date on the vendor invoice or credit memo. Typically the invoice date provided by the vendor.',
    `document_number` STRING COMMENT 'Ten-digit SAP FI document number uniquely identifying this payable within the company code and fiscal year. The externally-known business identifier for this payable.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the payable. KR=Vendor Invoice, KG=Vendor Credit Memo, KN=Net Vendor Invoice, RE=Invoice Receipt, DR=Debit Memo.. Valid values are `KR|KG|KN|RE|DR`',
    `due_date` DATE COMMENT 'Date by which payment is due to the vendor. Calculated from baseline date and payment terms. Critical for cash management and avoiding late payment penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert document currency to local currency at posting date. Null if document currency equals local currency.',
    `fiscal_period` STRING COMMENT 'Fiscal period (1-12 or 1-16 for special periods) within the fiscal year when the document was posted. Used for monthly financial close.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the document was posted. Used for period-end close and financial reporting.',
    `gl_account` STRING COMMENT 'Ten-digit general ledger account number to which this payable is posted. Determines the expense or asset classification in the chart of accounts.. Valid values are `^[0-9]{10}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, in document currency. Represents the full amount billed by the vendor.',
    `invoice_reference` STRING COMMENT 'Vendor-provided invoice number or reference identifier. Used for vendor reconciliation and payment matching.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts payable record was last modified (e.g., payment block added, partial payment applied). Used for audit trail.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Net payable amount converted to the company code local currency for general ledger posting and financial reporting.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable to vendor after all deductions (discounts, withholding tax), in document currency. This is the amount that will be paid.',
    `open_amount` DECIMAL(18,2) COMMENT 'Outstanding unpaid amount remaining on this payable, in document currency. Reduced as partial payments are applied. Zero when fully cleared.',
    `payment_block` STRING COMMENT 'Single-character code indicating if payment is blocked (e.g., A=Blocked for Payment, R=Blocked for Review, blank=Not Blocked). Prevents automatic payment until resolved.. Valid values are `^[A-Z]{1}$`',
    `payment_block_reason` STRING COMMENT 'Free-text explanation for why payment is blocked (e.g., pending approval, invoice dispute, missing documentation). Null if not blocked.',
    `payment_method` STRING COMMENT 'Single-character code indicating the payment method (e.g., C=Check, T=Wire Transfer, E=Electronic Funds Transfer, A=ACH). Determines payment run processing.. Valid values are `^[A-Z]{1}$`',
    `payment_terms` STRING COMMENT 'Four-character code defining the payment terms negotiated with the vendor (e.g., net 30, 2/10 net 30). Determines due date and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Date when the accounts payable document was posted to the general ledger. Determines the fiscal period for financial reporting.',
    `purchase_order_number` STRING COMMENT 'Ten-digit purchase order number if this payable originated from a PO-based procurement. Used for three-way match (PO, goods receipt, invoice).. Valid values are `^[0-9]{10}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this payable is subject to SOX financial controls and requires additional approval workflows. True for material transactions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the invoice (VAT, sales tax, GST), in document currency. May include multiple tax jurisdictions.',
    `text_description` STRING COMMENT 'Free-text description of the payable, typically describing the goods or services invoiced (e.g., Q4 2023 content licensing fees, Studio equipment rental).',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from vendor payment per tax regulations (e.g., talent residuals withholding, foreign vendor withholding), in document currency.',
    `withholding_tax_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether withholding tax applies to this payable. True if withholding tax is calculated and deducted.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'SAP FI-AP authoritative record of outstanding payables owed by Media Broadcasting to talent agencies, production vendors, content licensors, technology providers, and distribution partners. Captures vendor account, invoice reference, due date, open amount, currency, payment terms, payment block status, withholding tax indicator, and clearing status. Supports cash management, vendor payment runs, and period-end close.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record within the Media Broadcasting corporate group.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Intercompany charges for facility usage (one legal entity using anothers broadcast facility) require facility identification for transfer pricing documentation, intercompany billing, and consolidatio',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Intercompany transactions post to GL accounts. The gl_account_code STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Intercompany transactions require disclosure in FCC ownership reports (attribution of revenue/expenses in JSA/SSA arrangements) and financial qualification filings. Regulatory filings reference specif',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transactions can be allocated to sending cost center. The sending_cost_center STRING column will be replaced by FK to cost_center.cost_center_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Intercompany transactions have a sending legal entity. The sending_company_code is a business key reference to legal_entity. FK enables proper intercompany elimination and netting.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this intercompany transaction requires formal approval workflow before posting, typically based on transaction amount thresholds or type.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was formally approved, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `approved_by` STRING COMMENT 'User ID or name of the authorized person who approved the intercompany transaction for posting, maintaining audit trail for SOX compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the system, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `intercompany_transaction_description` STRING COMMENT 'Free-text description providing additional business context for the intercompany transaction, such as the specific content title licensed, service provided, or purpose of the charge.',
    `due_date` DATE COMMENT 'The date by which the intercompany transaction amount is due for settlement between the legal entities, calculated based on payment terms.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this intercompany transaction requires elimination entries during consolidated financial statement preparation at group level.',
    `elimination_status` STRING COMMENT 'Current status of the consolidation elimination process for this intercompany transaction in the group financial consolidation system.. Valid values are `not_required|pending|eliminated|partially_eliminated`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency to local or group currency, typically sourced from the corporate treasury system.',
    `exchange_rate_type` STRING COMMENT 'The type of exchange rate used for currency conversion (e.g., spot rate, monthly average rate, budget rate, or fixed contractual rate).. Valid values are `spot|average|budget|fixed`',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the intercompany transaction is posted, following the corporate chart of accounts structure.. Valid values are `^[0-9]{6,10}$`',
    `group_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the corporate currency (typically USD for Media Broadcasting).. Valid values are `^[A-Z]{3}$`',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the corporate currency for consolidated financial statement preparation.',
    `local_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the local currency of the receiving company code.. Valid values are `^[A-Z]{3}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the local currency of the receiving company code for local statutory reporting purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last modified, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX), supporting audit trail requirements.',
    `netting_status` STRING COMMENT 'Indicates whether the intercompany transaction is subject to bilateral netting arrangements to reduce cash settlement volumes between legal entities.. Valid values are `not_applicable|pending_netting|netted|excluded_from_netting`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the due date calculation and settlement terms for the intercompany transaction (e.g., NET30, NET60, IMM for immediate).. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the general ledger, determining the fiscal period for financial statement inclusion.',
    `receiving_company_code` STRING COMMENT 'The SAP company code of the legal entity receiving or being charged for the intercompany transaction (the entity consuming the service, content, or financing).. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_cost_center` STRING COMMENT 'The cost center within the receiving company code that is being charged for the intercompany transaction, enabling detailed cost allocation and budget tracking.. Valid values are `^[A-Z0-9]{10}$`',
    `reconciliation_period` STRING COMMENT 'The fiscal period (YYYY-MM format) in which this intercompany transaction is subject to monthly intercompany reconciliation procedures.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `reconciliation_status` STRING COMMENT 'Current status of the intercompany reconciliation process indicating whether the transaction has been matched and confirmed by both sending and receiving entities.. Valid values are `pending|matched|unmatched|resolved|escalated`',
    `reference_document_number` STRING COMMENT 'External reference number linking this intercompany transaction to source documents such as content licensing agreements, service invoices, or loan agreements.',
    `sending_company_code` STRING COMMENT 'The SAP company code of the legal entity originating or charging the intercompany transaction (the entity providing the service, content, or financing).. Valid values are `^[A-Z0-9]{4}$`',
    `settlement_date` DATE COMMENT 'The actual date on which the intercompany transaction was settled through cash payment or netting between the legal entities.',
    `settlement_status` STRING COMMENT 'Current status of cash settlement for the intercompany transaction, tracking whether payment has been made between the legal entities.. Valid values are `unsettled|partially_settled|fully_settled|written_off`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this intercompany transaction is subject to SOX-compliant financial controls and requires additional audit trail documentation.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency, representing the gross charge before any adjustments or netting.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The business date on which the intercompany transaction occurred or was initiated, used for period assignment and financial reporting.',
    `transaction_number` STRING COMMENT 'Business-facing unique identifier for the intercompany transaction, typically following the format IC-XXXXXXXXXX for tracking and reconciliation purposes.. Valid values are `^IC-[0-9]{10}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction indicating its position in the approval, posting, and reconciliation workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|reconciled|disputed|cancelled — 7 candidates stripped; promote to reference product]',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the charge or transfer between legal entities (e.g., content licensing charges between production subsidiaries and broadcast networks, shared service allocations, management fees, technology recharges, intercompany loans, royalty payments).. Valid values are `content_licensing|shared_service_allocation|management_fee|technology_recharge|intercompany_loan|royalty_payment`',
    `value_date` DATE COMMENT 'The effective date for interest calculation and cash flow purposes, particularly relevant for intercompany loans and financing arrangements.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Financial transaction record between legal entities within the Media Broadcasting corporate group — capturing content licensing charges between production subsidiaries and broadcast networks, shared service allocations, management fees, technology recharges, and intercompany loans. Each record identifies sending and receiving company codes, transaction type, amount, currency, bilateral netting status, consolidation elimination flag, and reconciliation period. Essential for monthly intercompany reconciliation, consolidated financial statement preparation, and elimination entries at group level.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` (
    `period_close_id` BIGINT COMMENT 'Unique identifier for the financial period close record. Primary key for the period close entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Period close is executed per legal entity in SAP S/4HANA. The company_code is a business key reference to legal_entity. FK enables proper period-end close tracking and SOX controls.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Period close triggers regulatory filing deadlines (FCC Form 323 ownership reports, annual EEO reports, biennial ownership reports). Close calendar must track associated regulatory filings to ensure fi',
    `actual_close_date` DATE COMMENT 'The actual date when the period close was completed and the period was locked for further postings. Null if close is not yet completed.',
    `close_checklist_completion_pct` DECIMAL(18,2) COMMENT 'Percentage of period-end close checklist tasks that have been completed. Ranges from 0.00 to 100.00. Provides visibility into close progress.',
    `close_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the period close process was completed and the period was locked. Null if close is not yet completed.',
    `close_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the period close process was formally initiated in the system.',
    `close_notes` STRING COMMENT 'Free-text field for documenting significant events, issues, or observations during the period close process. Provides context for future reference and audit trail.',
    `close_phase` STRING COMMENT 'Current phase of the period-end close process. Pre-close for preliminary activities, soft close for initial close with limited posting allowed, hard close for final close with restricted access, final close for locked period after SOX sign-off.. Valid values are `pre_close|soft_close|hard_close|final_close`',
    `close_status` STRING COMMENT 'Current status of the period close execution. Tracks the lifecycle state from initiation through completion or failure.. Valid values are `not_started|in_progress|pending_review|completed|failed|reopened`',
    `company_code` STRING COMMENT 'Four-character alphanumeric identifier for the legal entity in SAP S/4HANA. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_status` STRING COMMENT 'Status of financial consolidation processing for this company code and period. Tracks whether the legal entity data has been successfully consolidated into .. Valid values are `not_required|pending|in_progress|completed|failed`',
    `controller_email` STRING COMMENT 'Email address of the responsible controller for communication and notification purposes during the close process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this period close record was first created in the system. Audit trail field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency. All monetary amounts in this record are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'Calculated EBITDA for this company code and period in local currency. Key profitability metric for media broadcasting operations and corporate reporting.',
    `external_audit_required` BOOLEAN COMMENT 'Indicates whether this period close requires external auditor review and sign-off. Typically true for quarterly and annual closes for publicly traded entities.',
    `external_audit_status` STRING COMMENT 'Status of external auditor review for this period close. Tracks the progress of third-party audit activities.. Valid values are `not_required|pending|in_progress|completed|issues_identified`',
    `fiscal_period` STRING COMMENT 'The accounting period number within the fiscal year (typically 1-12 for monthly periods, or 1-4 for quarterly periods). Represents the specific reporting period being closed.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the period close is being executed. Represents the 12-month financial reporting period for the organization.',
    `intercompany_elimination_status` STRING COMMENT 'Status of intercompany transaction elimination processing for consolidated financial reporting. Indicates whether intercompany balances have been identified and eliminated.. Valid values are `not_required|pending|completed|failed`',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this period close record. Audit trail field for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this period close record was most recently updated. Audit trail field for change tracking.',
    `last_reopen_date` DATE COMMENT 'Date when the period was most recently reopened for adjustments. Null if the period has never been reopened.',
    `open_items_count` STRING COMMENT 'Number of open line items (uncleared documents) remaining in the general ledger at the time of close execution. Indicates outstanding reconciliation work.',
    `period_lock_timestamp` TIMESTAMP COMMENT 'Date and time when the posting period was locked in the system. Null if the period is not yet locked.',
    `period_type` STRING COMMENT 'Classification of the accounting period being closed. Monthly for standard month-end close, quarterly for quarter-end, annual for year-end, special for adjustment periods.. Valid values are `monthly|quarterly|annual|special`',
    `posting_period_locked` BOOLEAN COMMENT 'Indicates whether the posting period has been locked to prevent further transactions. True when the period is closed and locked, false when still open for postings.',
    `reopen_count` STRING COMMENT 'Number of times this period has been reopened after initial close. Tracks the frequency of post-close adjustments and indicates close process quality.',
    `reopen_reason` STRING COMMENT 'Business justification for the most recent period reopen. Documents the reason for post-close adjustments for audit trail purposes.',
    `responsible_controller` STRING COMMENT 'Name or identifier of the financial controller responsible for executing and certifying the period close for this company code and period.',
    `revenue_assurance_status` STRING COMMENT 'Status of revenue assurance validation for this period. Indicates whether all revenue streams (advertising, subscription, carriage fees, syndication) have been reconciled and verified.. Valid values are `not_required|pending|verified|discrepancy_found|resolved`',
    `scheduled_close_date` DATE COMMENT 'The planned target date for completing the period close process. Established based on the financial calendar and reporting deadlines.',
    `sox_control_status` STRING COMMENT 'Status of SOX internal control testing and certification for this period close. Required for publicly traded companies to ensure financial reporting compliance.. Valid values are `not_required|pending|passed|failed|waived`',
    `sox_signoff_by` STRING COMMENT 'Name or identifier of the individual who provided the SOX control sign-off for this period close.',
    `sox_signoff_date` DATE COMMENT 'Date when the SOX control certification was completed and signed off by the responsible controller or compliance officer. Null if not yet signed off.',
    `unreconciled_amount` DECIMAL(18,2) COMMENT 'Total monetary value of unreconciled items in the company code currency. Represents the financial exposure from incomplete reconciliations.',
    `unreconciled_items_count` STRING COMMENT 'Number of accounts or subledger items that have not been reconciled to the general ledger at the time of close. Critical metric for close quality.',
    `variance_to_forecast_amount` DECIMAL(18,2) COMMENT 'Monetary variance between actual period results and forecasted amounts in company code currency. Positive indicates favorable variance, negative indicates unfavorable.',
    CONSTRAINT pk_period_close PRIMARY KEY(`period_close_id`)
) COMMENT 'Record of each financial period-end close cycle executed in SAP S/4HANA for Media Broadcasting legal entities. Tracks fiscal year, accounting period, company code, close phase (pre-close, soft close, hard close), close status, scheduled date, actual completion date, responsible controller, open items count, unreconciled items, and SOX sign-off status. Provides the authoritative audit trail for the monthly, quarterly, and annual close process.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the parent legal entity in the corporate hierarchy. Used to establish organizational structure and consolidation relationships. Null for the ultimate parent entity.',
    `accounting_standard` STRING COMMENT 'Primary accounting standard or framework used for financial reporting by this legal entity. Determines recognition, measurement, and disclosure requirements.. Valid values are `GAAP|IFRS|local_statutory`',
    `activation_date` DATE COMMENT 'The date on which the legal entity became active and began conducting business operations. Used for financial reporting period determination.',
    `broadcast_license_holder_flag` BOOLEAN COMMENT 'Indicates whether this legal entity holds one or more broadcast licenses issued by the FCC or equivalent regulatory authority. True if the entity is a licensed broadcaster.',
    `chart_of_accounts` STRING COMMENT 'Four-character code identifying the chart of accounts assigned to this legal entity in SAP S/4HANA. Defines the structure of general ledger accounts used for financial postings.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity within the SAP S/4HANA FI module. Used as the organizational unit for financial accounting and the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group` STRING COMMENT 'Identifier for the consolidation group or reporting unit to which this legal entity belongs. Used for corporate consolidation, intercompany eliminations, and segment reporting.',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the country where the legal entity is incorporated and registered. Determines primary legal jurisdiction and regulatory framework.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this legal entity record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_control_area` STRING COMMENT 'Four-character code identifying the credit control area assigned to this legal entity in SAP S/4HANA. Used for credit management and accounts receivable monitoring.. Valid values are `^[A-Z0-9]{4}$`',
    `deactivation_date` DATE COMMENT 'The date on which the legal entity ceased active operations or was dissolved. Null for active entities. Used to determine the end of financial reporting obligations.',
    `ebitda_reporting_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is included in corporate EBITDA calculations and segment performance reporting. True if the entity contributes to consolidated EBITDA metrics.',
    `entity_status` STRING COMMENT 'Current operational status of the legal entity. Active indicates the entity is conducting business; inactive indicates temporary suspension; dormant indicates no current operations but entity remains registered; liquidation indicates entity is being wound down; dissolved indicates entity has been formally closed.. Valid values are `active|inactive|dormant|liquidation|dissolved`',
    `entity_type` STRING COMMENT 'Classification of the legal entity based on its primary business function within the Media Broadcasting corporate structure. Determines the operational model and reporting requirements.. Valid values are `broadcast_network|streaming_platform|production_studio|holding_company|subsidiary|joint_venture`',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year structure for this legal entity, including the number of periods, period start and end dates, and year-end closing rules. Used for period-based financial reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency in which the entity conducts its business and maintains its books of account. Used for financial statement preparation and consolidation.. Valid values are `^[A-Z]{3}$`',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered with the governing authority.',
    `intercompany_elimination_group` STRING COMMENT 'Code identifying the group of entities for which intercompany transactions must be eliminated during consolidation. Used to ensure accurate consolidated financial statements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this legal entity record was last updated. Used for change tracking and audit compliance.',
    `legal_form` STRING COMMENT 'The legal structure or incorporation type of the entity (e.g., Corporation, Limited Liability Company, Partnership, Public Limited Company). Determines liability, taxation, and regulatory obligations.',
    `legal_entity_name` STRING COMMENT 'Full legal name of the entity as registered with the governing authority. This is the official name used in all legal documents, contracts, regulatory filings, and financial statements.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent entity. Used for consolidation calculations and minority interest determination. Range: 0.00 to 100.00.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official correspondence with the legal entity. Used for regulatory notifications and corporate communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the legal entity. Used for official business communications.',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address of the legal entity as filed with the incorporation authority. Used for legal correspondence and regulatory filings.',
    `registered_address_line2` STRING COMMENT 'Second line of the official registered address (suite, floor, building name). Optional field for additional address details.',
    `registered_city` STRING COMMENT 'City or municipality of the registered address.',
    `registered_country` STRING COMMENT 'Three-letter ISO country code for the registered address. Typically matches the country of incorporation.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or region of the registered address. Uses standard postal abbreviations where applicable.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the government authority in the country of incorporation. Used for legal identification and regulatory compliance.',
    `regulatory_reporting_obligations` STRING COMMENT 'Comma-separated list of regulatory reporting frameworks and obligations applicable to this legal entity (e.g., SEC 10-K, FCC Form 323, Ofcom Annual Return). Determines mandatory filings and disclosure requirements.',
    `reporting_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency used for external financial reporting and consolidation at the corporate level.. Valid values are `^[A-Z]{3}$`',
    `short_name` STRING COMMENT 'Abbreviated or trade name of the legal entity used for internal reporting and operational purposes.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is within the scope of SOX compliance and internal control testing. True if the entity is material to consolidated financial statements and subject to SOX Section 404 requirements.',
    `tax_identification_number` STRING COMMENT 'Primary tax identification number assigned by the tax authority in the country of incorporation. Used for all tax filings, withholding, and revenue reporting.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for entities operating in jurisdictions requiring VAT registration. Used for VAT reporting and cross-border transactions.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record of each legal entity, company code, and reporting unit within the Media Broadcasting corporate structure — including broadcast networks, streaming platforms, production studios, and holding companies. Captures company code, legal entity name, country of incorporation, functional currency, fiscal year variant, chart of accounts assignment, consolidation group, tax registration numbers, and regulatory reporting obligations (SOX, IFRS, GAAP). The organizational anchor for all financial postings.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation transaction record. Primary key for the cost allocation entity.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Shared facility costs (power, cooling, security, building maintenance) are allocated from central cost centers to user departments/productions. Finance allocates facility overhead based on usage metri',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cost allocations occur within legal entities for internal cost distribution. The company_code is a business key reference to legal_entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Cost elements in SAP CO are GL accounts from the chart of accounts. The cost_element STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `original_allocation_cost_allocation_id` BIGINT COMMENT 'Foreign key reference to the original cost allocation record that this record reverses. Null if this is not a reversal transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the cost center from which costs are being allocated (the source of the shared costs being distributed).',
    `profit_center_id` BIGINT COMMENT 'Foreign key reference to the profit center receiving the allocated costs. Null if the receiver is a cost center instead of a profit center.',
    `studio_facility_id` BIGINT COMMENT 'Foreign key linking to technology.studio_facility. Business justification: Studio costs are allocated to productions or departments based on booking hours and usage. Finance tracks studio utilization and allocates studio overhead (depreciation, maintenance, utilities) for pr',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount allocated from the sender cost center to the receiver cost center or profit center in the transaction currency. This is the core financial value of the allocation.',
    `allocation_key` STRING COMMENT 'The allocation key or driver used to determine the proportion of costs allocated to the receiver (e.g., headcount, square footage, revenue, FTE, transaction volume). Defines the basis for cost distribution.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `allocation_key_value` DECIMAL(18,2) COMMENT 'The numeric value of the allocation key used for this specific allocation (e.g., 15 FTEs, 2500 square feet, 1000000 transactions). Used to calculate the allocated amount.',
    `allocation_method` STRING COMMENT 'The method used to allocate costs from sender to receiver. Direct: one-to-one allocation. Statistical: based on statistical key figures. Activity-based: based on activity quantities consumed. Assessment: periodic allocation without traceability. Distribution: proportional distribution based on allocation keys.. Valid values are `direct|statistical|activity_based|assessment|distribution`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of total sender costs allocated to this receiver, expressed as a decimal (e.g., 15.75 for 15.75%). Derived from the allocation key value relative to total allocation base.',
    `allocation_run_date` DATE COMMENT 'The date on which the allocation cycle was executed and this allocation record was created. May differ from posting date if allocations are run in advance and posted later.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the cost allocation record. Posted: successfully posted to CO ledger. Pending: awaiting approval or posting. Reversed: allocation has been reversed. Cancelled: allocation was cancelled before posting. Error: allocation failed validation or posting.. Valid values are `posted|pending|reversed|cancelled|error`',
    `allocation_type` STRING COMMENT 'Business classification of the cost allocation indicating the nature of costs being distributed (e.g., overhead, shared services, facilities, technology infrastructure, corporate overhead, intercompany charges).. Valid values are `overhead|shared_services|facilities|technology|corporate|intercompany`',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation requires managerial approval before posting (True) or can be posted automatically (False). Used for governance and control of high-value or sensitive allocations.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this cost allocation was approved for posting. Null if no approval was required or allocation is still pending approval.',
    `approved_by_user` STRING COMMENT 'SAP user ID of the person who approved this cost allocation for posting. Null if no approval was required or allocation is still pending approval.. Valid values are `^[A-Z0-9]{6,20}$`',
    `business_area` STRING COMMENT 'The SAP business area to which this allocation is assigned. Used for segment reporting and code consolidation in Media Broadcasting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'The SAP company code under which this cost allocation is recorded. Represents the legal entity for financial reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP controlling area within which this cost allocation is executed. Represents the organizational unit for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_element` STRING COMMENT 'The SAP CO cost element (account assignment) under which the allocated cost is recorded. Maps to the general ledger account in SAP FI.. Valid values are `^[0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person or system process that created this cost allocation record. Part of standard audit trail for accountability and compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cost allocation record was first created in the system. Part of standard audit trail for data lineage and compliance.',
    `document_number` STRING COMMENT 'The SAP CO document number assigned to this cost allocation transaction. Provides traceability and audit trail for the allocation posting.. Valid values are `^[0-9]{10}$`',
    `ebitda_reporting_segment` STRING COMMENT 'The EBITDA reporting segment to which this allocation contributes. Used for segment-level EBITDA calculation and executive reporting in Media Broadcasting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the allocation was posted (1-12 or 1-13 for special periods). Used for monthly financial close and reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the cost allocation was posted (e.g., 2024). Used for period-based financial reporting and EBITDA tracking.',
    `functional_area` STRING COMMENT 'The functional area classification for this allocation (e.g., production, distribution, sales, administration). Used for cost-of-sales accounting and functional P&L reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation crosses company code boundaries and represents an intercompany charge (True) or is intra-company (False). Used for consolidation and elimination processing.',
    `last_modified_by_user` STRING COMMENT 'SAP user ID of the person or system process that last modified this cost allocation record. Part of standard audit trail for accountability and compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cost allocation record was last modified. Updated whenever any field in the record changes. Part of standard audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or business context regarding this cost allocation. Used for documentation and audit trail purposes.',
    `posting_date` DATE COMMENT 'The date on which the cost allocation transaction was posted to the SAP CO ledger. Determines the fiscal period assignment and financial reporting period.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation record is a reversal of a previous allocation (True) or an original allocation (False). Used for correction and adjustment tracking.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation is subject to SOX financial controls and requires additional audit documentation (True) or is outside SOX scope (False).',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD, EUR, GBP). Represents the currency in which the allocation was originally recorded.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Record of cost allocation and recharge transactions executed within SAP CO — distributing shared costs (facilities, technology infrastructure, corporate overhead, shared services) from sender cost centers to receiver cost centers or profit centers across Media Broadcasting. Captures allocation cycle, sender cost center, receiver cost center/profit center, allocation method (direct, statistical, activity-based), allocated amount, allocation key, and fiscal period. Enables accurate departmental P&L and EBITDA calculation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` (
    `capex_project_id` BIGINT COMMENT 'Unique identifier for the capital expenditure project record. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Capital projects (facility upgrades, equipment installations, infrastructure improvements) are executed at specific broadcast facilities. Finance tracks capex spend by facility location for asset capi',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Broadcast equipment capex (transmitter upgrades, tower modifications, EAS equipment) is license-specific and requires FCC notification/approval. Capital planning and asset capitalization must track wh',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Capex projects belong to legal entities for asset ownership and depreciation tracking. The company_code is a business key reference to legal_entity.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the capital project. Links to the organizational unit that owns the asset and will bear depreciation expense post-capitalization.',
    `actual_capitalization_date` DATE COMMENT 'Actual date when the project was settled to fixed assets and depreciation commenced. Used for SOX compliance and financial statement preparation.',
    `actual_completion_date` DATE COMMENT 'Actual date when project was completed and ready for asset settlement. Triggers capitalization workflow and depreciation start date calculation.',
    `actual_start_date` DATE COMMENT 'Actual date when project execution commenced. Used for variance analysis against planned timeline.',
    `approval_date` DATE COMMENT 'Date when the capital project received formal budget approval from the investment committee or authorized governance body. Marks the start of the capital commitment period.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total capital budget approved for the project by the investment committee. Represents the authorized spending limit for the capital investment.',
    `asset_class_code` STRING COMMENT 'Fixed asset class code that the project will be capitalized into upon completion. Determines depreciation method, useful life, and GL account assignment. Examples include broadcast equipment, buildings, IT infrastructure.',
    `auc_account_code` STRING COMMENT 'General ledger account code for the asset under construction balance sheet account. All project costs are accumulated in this account until capitalization. Typically a fixed asset sub-account per chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `business_area` STRING COMMENT 'Business area or segment for internal management reporting. Examples include Linear Broadcasting, OTT Streaming, News Division, Sports Network. Used for EBITDA segment reporting.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that owns the capital project. Used for financial statement consolidation and intercompany eliminations.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created the capital project record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was first created in the system. Used for audit trail and data lineage.',
    `cumulative_spend_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred to date on the capital project. Aggregates all posted costs from journal entries and purchase orders. Used for budget variance analysis and capitalization.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all project financial amounts. Typically matches the company code currency for domestic projects.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Planned depreciation method to be applied once the asset is capitalized. Straight line is most common for buildings and infrastructure; declining balance may be used for technology assets; units of production for usage-based assets.. Valid values are `straight_line|declining_balance|units_of_production|accelerated`',
    `governance_review_status` STRING COMMENT 'Status of the capital project governance review by the investment committee or capital allocation board. Tracks approval workflow and conditional requirements.. Valid values are `pending|approved|rejected|conditional_approval`',
    `investment_justification` STRING COMMENT 'Primary business rationale for the capital investment. Capacity expansion includes new studios or transmission capacity; technology upgrade covers platform modernization; regulatory compliance addresses FCC or technical standards; cost reduction targets operational efficiency; revenue generation supports new monetization channels.. Valid values are `capacity_expansion|technology_upgrade|regulatory_compliance|cost_reduction|revenue_generation|strategic_initiative`',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the capital project record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the capital project record. Used for change tracking and data freshness monitoring.',
    `notes` STRING COMMENT 'Free-form text field for additional project context, change history, or special instructions. Used for audit trail and knowledge transfer.',
    `planned_capitalization_date` DATE COMMENT 'Target date for transferring the asset under construction (AUC) to fixed assets and beginning depreciation. Aligns with asset placed-in-service date for financial reporting.',
    `planned_completion_date` DATE COMMENT 'Target date for project completion and readiness for capitalization. Used for depreciation planning and asset lifecycle management.',
    `planned_start_date` DATE COMMENT 'Scheduled date for project execution to begin. Used for resource planning and timeline tracking.',
    `project_classification` STRING COMMENT 'Categorical classification of the capital project type. Infrastructure includes broadcast towers and transmission equipment; technology covers OTT platforms and enterprise systems; facilities encompasses studio construction and office build-outs; equipment includes production gear and IRDs.. Valid values are `infrastructure|technology|facilities|equipment|broadcast_transmission|digital_platform`',
    `project_code` STRING COMMENT 'Business identifier for the capital project, used across financial systems and reporting. Typically follows organizational coding standards for capital investment tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `project_description` STRING COMMENT 'Detailed description of the capital project scope, objectives, and deliverables. Provides context for investment justification and asset capitalization.',
    `project_name` STRING COMMENT 'Descriptive name of the capital project, such as OTT Platform Infrastructure Upgrade or Studio B Renovation.',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital project. Planning indicates pre-approval stage; approved means budget authorized; in_progress reflects active execution; completed indicates project finished but not yet capitalized; capitalized means transferred to fixed assets; cancelled indicates project terminated. [ENUM-REF-CANDIDATE: planning|approved|in_progress|on_hold|completed|capitalized|cancelled — 7 candidates stripped; promote to reference product]',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Unspent budget balance available for the project. Calculated as approved budget minus cumulative spend. Used for commitment control and budget monitoring.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the capital project considering technical complexity, budget size, timeline, and strategic importance. Used for governance escalation and monitoring frequency.. Valid values are `low|medium|high|critical`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether the capital project is subject to SOX internal controls for financial reporting. True for projects above materiality thresholds or involving critical financial systems.',
    `sponsor_name` STRING COMMENT 'Name of the executive sponsor or business owner who approved and champions the capital investment. Typically a VP or C-level executive.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation calculation. Determined by asset class and regulatory/tax guidelines. Broadcast towers may be 20-30 years; technology platforms 3-7 years; studio facilities 15-40 years.',
    CONSTRAINT pk_capex_project PRIMARY KEY(`capex_project_id`)
) COMMENT 'Capital expenditure project master record tracking Media Broadcasting infrastructure investments from approval through capitalization — covering broadcast tower upgrades, OTT platform builds, studio construction, transmission equipment, and enterprise technology implementations. Captures project code, classification (infrastructure/technology/facilities), approved budget, cumulative spend, asset-under-construction (AUC) account, planned capitalization date, depreciation parameters, responsible cost center, and governance status. Links to fixed_asset upon settlement and to journal_entry for actual cost postings.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Fixed assets (cameras, switchers, transmitters, servers) are physically located at broadcast facilities. Finance requires facility location for insurance valuation, property tax allocation, depreciati',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Broadcast transmission assets (transmitters, antennas, towers) are licensed assets with regulatory obligations. Asset register must track license association for FCC technical compliance, insurance, a',
    `capex_project_id` BIGINT COMMENT 'Reference to the capital expenditure project under which this asset was approved and funded. Links the asset to CAPEX budget tracking and project lifecycle.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Fixed assets belong to legal entities for ownership and depreciation tracking. The company_code is a business key reference to legal_entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this asset. Links the asset to organizational responsibility and budget allocation.',
    `transmission_equipment_id` BIGINT COMMENT 'Foreign key linking to technology.transmission_equipment. Business justification: Transmission equipment (transmitters, encoders, satellite uplinks) are capitalized as fixed assets. Finance tracks these for depreciation calculation, insurance valuation, disposal accounting, and reg',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense recognized to date since acquisition. Used to calculate net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The original purchase price or capitalized cost of the asset at the time of acquisition, excluding accumulated depreciation. Represents the gross book value.',
    `acquisition_date` DATE COMMENT 'The date on which the asset was acquired or capitalized. This is the principal business event timestamp marking when the asset entered the companys balance sheet.',
    `asset_class` STRING COMMENT 'Classification code that categorizes the asset type (e.g., broadcast equipment, studio facilities, transmission towers, OTT infrastructure, production equipment, capitalized software). Determines depreciation rules and financial treatment.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_description` STRING COMMENT 'Detailed textual description of the fixed asset including make, model, specifications, and location details. Provides human-readable context for the asset.',
    `asset_location` STRING COMMENT 'Physical location or site where the asset is installed or deployed (e.g., transmission tower site, studio facility, data center). Used for asset tracking and maintenance planning.',
    `asset_notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the asset. Used for operational context and exception documentation.',
    `asset_number` STRING COMMENT 'The externally-known unique asset number assigned by SAP FI-AA for tracking and identification purposes. This is the business identifier used across financial reporting and asset management processes.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset indicating whether it is in active use, under construction, disposed, retired, or impaired.. Valid values are `active|inactive|under_construction|disposed|retired|impaired`',
    `asset_sub_number` STRING COMMENT 'Sub-asset number used when a main asset is divided into multiple components for separate depreciation tracking (e.g., building structure vs. HVAC system).',
    `asset_super_number` STRING COMMENT 'Parent asset number when this asset is part of a larger asset hierarchy (e.g., individual broadcast equipment within a transmission tower complex).',
    `business_area` STRING COMMENT 'The business area or division to which this asset is allocated (e.g., broadcast operations, streaming platform, production studio). Used for segment reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `capitalization_date` DATE COMMENT 'The date on which the asset was placed in service and capitalization began. May differ from acquisition date for assets under construction.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity that owns this asset. Used for financial consolidation and legal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fixed asset record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this asset (acquisition cost, depreciation, net book value).. Valid values are `^[A-Z]{3}$`',
    `depreciation_area` STRING COMMENT 'SAP depreciation area code indicating the valuation view (e.g., 01 for book depreciation, 15 for tax depreciation). Supports parallel accounting.. Valid values are `^[0-9]{2}$`',
    `depreciation_method` STRING COMMENT 'The accounting method used to calculate periodic depreciation expense for this asset. Determines how the assets cost is allocated over its useful life.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits|accelerated`',
    `disposal_date` DATE COMMENT 'The date on which the asset was disposed, sold, or retired from service. Null for active assets.',
    `disposal_method` STRING COMMENT 'The method by which the asset was disposed (e.g., sale, scrap, donation, trade-in, transfer to another entity, write-off). Null for active assets.. Valid values are `sale|scrap|donation|trade_in|transfer|write_off`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'The amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal. Null for active assets.',
    `ebitda_reporting_segment` STRING COMMENT 'The EBITDA reporting segment to which this assets depreciation expense is allocated. Used for segment profitability analysis and corporate reporting.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'The financial gain or loss recognized upon disposal, calculated as disposal proceeds minus net book value at disposal. Null for active assets.',
    `insurance_policy_number` STRING COMMENT 'The insurance policy number covering this asset. Used for risk management and claims processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fixed asset record was last updated. Used for audit trail and change tracking.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or vendor who produced the asset. Used for warranty claims and vendor management.',
    `model_number` STRING COMMENT 'Manufacturers model number or product code for the asset. Used for parts ordering and technical specifications lookup.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The current carrying value of the asset on the balance sheet, calculated as acquisition cost minus accumulated depreciation. Represents the assets current financial value.',
    `purchase_order_number` STRING COMMENT 'The purchase order number under which the asset was originally procured. Links the asset to procurement records.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'The number of years remaining in the assets useful life as of the current reporting period. Used for forward-looking depreciation planning.',
    `serial_number` STRING COMMENT 'Manufacturers serial number or unique equipment identifier for the physical asset. Used for warranty tracking and maintenance records.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this asset is subject to SOX financial controls and requires enhanced audit trails and approval workflows.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'The estimated number of years over which the asset is expected to provide economic benefit and be depreciated. Used in depreciation calculations.',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier from whom the asset was purchased. Used for vendor performance tracking.',
    `warranty_expiration_date` DATE COMMENT 'The date on which the manufacturers warranty for this asset expires. Used for maintenance planning and cost forecasting.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'SAP FI-AA authoritative master record for all capitalized fixed assets owned by Media Broadcasting — including broadcast transmission towers, satellite uplink equipment, studio facilities, OTT server infrastructure, production equipment, and capitalized software. Captures asset number, asset class, description, acquisition date, acquisition cost, accumulated depreciation, net book value, depreciation method, useful life, cost center, and disposal status. Supports balance sheet reporting and CAPEX-to-asset lifecycle tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` (
    `depreciation_run_id` BIGINT COMMENT 'Unique identifier for the depreciation calculation and posting run. Primary key for the depreciation run record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Depreciation runs are executed per legal entity in SAP FI-AA. The company_code is a business key reference to legal_entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Depreciation can be allocated to cost centers for expense tracking. The cost_center_code STRING column will be replaced by FK to cost_center.cost_center_id.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Depreciation can be allocated to profit centers for P&L tracking. The profit_center_code STRING column will be replaced by FK to profit_center.profit_center_id.',
    `asset_class` STRING COMMENT 'Classification code grouping fixed assets by type (e.g., broadcast equipment, studio facilities, transmission towers, vehicles, IT infrastructure). Determines default depreciation methods, useful life, and general ledger account assignments.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_count` STRING COMMENT 'The total number of fixed asset records processed in this depreciation run for the specified company code, asset class, and depreciation area. Used for run completeness validation and audit trail.',
    `business_area` STRING COMMENT 'Four-character code representing the business area (e.g., broadcast operations, digital streaming, production services) for segment reporting. Enables EBITDA tracking and financial analysis by business line.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'Four-character alphanumeric code identifying the legal entity within the SAP enterprise structure for which depreciation is calculated. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this depreciation run record was first created in the system. Provides audit trail for data lineage and supports SOX compliance requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which depreciation amounts are expressed (e.g., USD, GBP, EUR). Aligns with company code currency and general ledger posting currency.. Valid values are `^[A-Z]{3}$`',
    `depreciation_area` STRING COMMENT 'Two-digit code representing the depreciation area (e.g., 01 for book depreciation, 15 for tax depreciation, 20 for group consolidation). Allows parallel valuation of assets according to different accounting principles and legal requirements.. Valid values are `^[0-9]{2}$`',
    `depreciation_method` STRING COMMENT 'Four-character code identifying the depreciation calculation method applied (e.g., straight-line, declining balance, units of production). Determines how asset value reduction is calculated over the useful life.. Valid values are `^[A-Z0-9]{4}$`',
    `document_date` DATE COMMENT 'The document date assigned to the general ledger posting document created by the depreciation run. Typically matches the last day of the posting period for period-end depreciation postings.',
    `document_number` STRING COMMENT 'Ten-digit SAP financial document number generated when depreciation amounts are posted to the general ledger. Provides the link between asset accounting and financial accounting for audit trail and reconciliation.. Valid values are `^[0-9]{10}$`',
    `ebitda_reporting_segment` STRING COMMENT 'The EBITDA reporting segment to which this depreciation run contributes. Used for segment-level financial analysis and executive reporting of operating performance before depreciation impact.. Valid values are `broadcast|streaming|production|advertising|distribution|corporate`',
    `error_count` STRING COMMENT 'The number of asset records that encountered errors during the depreciation calculation or posting process. Non-zero values trigger exception handling and require investigation before period-end close.',
    `error_log_reference` STRING COMMENT 'Reference identifier or file path to the detailed error log generated during the depreciation run. Used for troubleshooting and resolving posting errors before period-end close.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the depreciation run was executed. Represents the accounting period year in which the depreciation expense is recognized.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this depreciation run record was last updated. Tracks changes to run status, posted amounts, or other attributes for audit trail and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, explanations for variances, manual adjustments applied, or special circumstances related to the depreciation run. Supports audit trail and period-end close documentation.',
    `planned_depreciation_amount` DECIMAL(18,2) COMMENT 'The total depreciation expense amount calculated by the system for the specified period, company code, and depreciation area based on asset master data and depreciation rules. Represents the expected value reduction before any adjustments or errors.',
    `posted_depreciation_amount` DECIMAL(18,2) COMMENT 'The actual depreciation expense amount successfully posted to the general ledger for the period. May differ from planned amount due to posting errors, manual adjustments, or period-end corrections.',
    `posting_date` DATE COMMENT 'The date on which the depreciation amounts were posted to the general ledger. Determines the fiscal period and year in which the expense is recognized for financial reporting purposes.',
    `posting_period` STRING COMMENT 'The posting period within the fiscal year (typically 1-12 for monthly periods, or 1-16 including special periods) to which the depreciation amounts are posted. Aligns with the period-end close calendar.',
    `repeat_run_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this run is a repeat execution for a period that was previously processed. True indicates repeat run to correct prior errors; false indicates initial run for the period.',
    `reversal_date` DATE COMMENT 'The date on which the depreciation run posting was reversed in the general ledger. Null if no reversal has occurred. Used for period-end close reconciliation and audit trail.',
    `reversal_document_number` STRING COMMENT 'The SAP financial document number of the reversal posting if this depreciation run was reversed. Null if no reversal has occurred. Links to the reversing document for audit trail.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this depreciation run was subsequently reversed due to errors or period adjustments. True indicates the run was reversed; false indicates the run remains active.',
    `run_completed_timestamp` TIMESTAMP COMMENT 'The precise date and time when the depreciation run completed processing (successfully or with errors). Used to calculate run duration and monitor period-end close performance.',
    `run_date` DATE COMMENT 'The calendar date on which the depreciation calculation and posting run was executed. Used for audit trail and reconciliation purposes.',
    `run_initiated_by_user` STRING COMMENT 'The SAP user ID of the person or system account that initiated the depreciation run. Provides accountability and audit trail for period-end close activities and SOX compliance.. Valid values are `^[A-Z0-9]{12}$`',
    `run_status` STRING COMMENT 'Current lifecycle status of the depreciation run. Tracks progression from initiation through completion or failure, supporting period-end close monitoring and exception management.. Valid values are `initiated|in_progress|completed|completed_with_errors|failed|cancelled`',
    `run_timestamp` TIMESTAMP COMMENT 'The precise date and time when the depreciation run was initiated in the SAP FI-AA system. Provides granular audit trail for period-end close activities.',
    `run_type` STRING COMMENT 'Categorization of the depreciation run execution. Planned runs are scheduled periodic calculations; unplanned runs address mid-period adjustments; repeat runs correct prior errors; test runs validate configuration without posting.. Valid values are `planned|unplanned|repeat|test`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this depreciation run is subject to SOX internal control requirements for financial reporting accuracy. True indicates SOX-controlled process requiring additional audit trail and approval workflows.',
    `test_run_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this was a test run executed to validate depreciation calculations without posting to the general ledger. True indicates test mode; false indicates production posting run.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between planned depreciation amount and posted depreciation amount (posted minus planned). Positive variance indicates over-posting; negative variance indicates under-posting. Used for reconciliation and exception investigation.',
    `warning_count` STRING COMMENT 'The number of asset records that generated warnings during the depreciation run. Warnings indicate potential data quality issues or configuration anomalies that do not prevent posting but require review.',
    CONSTRAINT pk_depreciation_run PRIMARY KEY(`depreciation_run_id`)
) COMMENT 'Record of each periodic depreciation calculation and posting run executed in SAP FI-AA for Media Broadcasting fixed assets. Captures depreciation run date, company code, asset class, depreciation area, planned depreciation amount, posted depreciation amount, depreciation method, fiscal period, run status, and error count. Provides the audit trail for asset value reduction postings and supports period-end close and balance sheet accuracy.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique identifier for the tax posting record in SAP FI. Primary key for the tax posting entity.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Property taxes, facility-specific taxes, and local jurisdiction taxes are posted by facility location. Finance tracks tax obligations by facility for compliance reporting, tax return preparation, and ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Tax postings reference GL accounts for tax liability and expense tracking. The gl_account_number STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tax postings belong to legal entities for tax reporting and compliance. The company_code is a business key reference to legal_entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax postings can be allocated to cost centers for expense tracking. The cost_center_code STRING column will be replaced by FK to cost_center.cost_center_id.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax postings can be allocated to profit centers for P&L tracking. The profit_center_code STRING column will be replaced by FK to profit_center.profit_center_id.',
    `subscriber_id` BIGINT COMMENT 'SAP customer master record number when the tax posting relates to a customer transaction (e.g., VAT on advertising sales or sales tax on subscriber transactions). Null for vendor-related tax postings.',
    `vendor_id` BIGINT COMMENT 'SAP vendor master record number when the tax posting relates to a vendor payment (e.g., withholding tax on talent or licensor payments). Null for customer-related tax postings.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for documenting special circumstances, adjustments, or explanations related to the tax posting. Used for audit defense and tax authority inquiries.',
    `business_area` STRING COMMENT 'Business area classification for code reporting. Used to consolidate tax postings across multiple legal entities for tax analysis.',
    `clearing_date` DATE COMMENT 'Date on which the tax liability was settled or cleared through payment to the tax authority. Null for uncleared postings. Used for cash flow analysis and tax remittance tracking.',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity for which the tax posting is recorded. Aligns with organizational structure in SAP S/4HANA FI module.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person or system process that created the tax posting record. Used for audit trail and accountability.. Valid values are `^[A-Z0-9]{8,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax posting record was first created in SAP FI. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tax posting amounts. All monetary values in this record are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date of the source document (invoice, payment, contract) that triggered the tax posting. May differ from posting date due to processing delays.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the tax posting was recorded. Used for period-based tax reporting and compliance.',
    `gl_account_number` STRING COMMENT 'The general ledger account number to which the tax amount is posted. Typically a tax liability or tax expense account in the chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_by_user` STRING COMMENT 'SAP user ID of the person or system process that last modified the tax posting record. Used for audit trail and change tracking.. Valid values are `^[A-Z0-9]{8,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax posting record was last modified in SAP FI. Used for audit trail and change tracking.',
    `payment_reference` STRING COMMENT 'Reference number of the payment transaction that cleared this tax liability. Links the tax posting to the actual remittance to the tax authority.',
    `posting_date` DATE COMMENT 'Date on which the tax posting was recorded in the general ledger. Determines the accounting period for financial reporting and tax return preparation.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the tax posting. Posted indicates active posting; Parked indicates pending approval; Cleared indicates settled with tax authority; Reversed indicates cancelled by reversal entry; Cancelled indicates voided before posting.. Valid values are `Posted|Parked|Cleared|Reversed|Cancelled`',
    `reference_document_number` STRING COMMENT 'External reference number linking the tax posting to the originating business transaction (invoice number, payment reference, contract number). Used for audit trail and reconciliation.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax posting is a reversal of a previous posting. True if this is a reversal entry; False for original postings.',
    `reversed_document_number` STRING COMMENT 'Tax document number of the original posting that this entry reverses. Populated only when reversal_indicator is True. Used for audit trail and reconciliation.. Valid values are `^[0-9]{10}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this tax posting is subject to SOX internal controls and audit requirements. True for material tax postings requiring additional review and documentation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount posted to the tax account. Derived from taxable base amount multiplied by tax rate. Used for tax liability tracking and remittance.',
    `tax_code` STRING COMMENT 'SAP tax code identifying the tax type, rate, and calculation method. Examples include VAT codes, withholding tax codes, sales tax codes, and use tax codes configured in SAP FI.. Valid values are `^[A-Z0-9]{2,4}$`',
    `tax_document_number` STRING COMMENT 'Ten-digit SAP document number uniquely identifying the tax posting document within the company code and fiscal year. Used for audit trail and tax return reconciliation.. Valid values are `^[0-9]{10}$`',
    `tax_jurisdiction` STRING COMMENT 'Code identifying the tax authority or jurisdiction (country, state, province, municipality) to which the tax is owed. Critical for multi-jurisdictional tax compliance and reporting.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the taxable base amount to calculate the tax amount. Expressed as a percentage (e.g., 20.00 for 20% VAT).',
    `tax_reporting_country` STRING COMMENT 'Three-letter ISO 3166 country code identifying the country where the tax return will be filed. May differ from company code country for cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `tax_return_period` STRING COMMENT 'The reporting period (quarterly or monthly) to which this tax posting applies for tax return filing. Format: YYYY-Q# for quarterly or YYYY-M## for monthly (e.g., 2024-Q1, 2024-M03).. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `tax_type` STRING COMMENT 'Classification of the tax posting by tax category. VAT/GST applies to advertising sales and subscription revenue; withholding tax applies to talent and licensor payments; sales tax applies to subscriber transactions; use tax applies to equipment purchases.. Valid values are `VAT|GST|Sales Tax|Use Tax|Withholding Tax|Excise Tax`',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The gross amount subject to taxation before tax calculation. Represents the revenue, payment, or transaction value on which the tax is computed.',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Record of tax-related financial postings in SAP FI for Media Broadcasting — covering VAT/GST on advertising sales, withholding tax on talent and licensor payments, sales tax on subscriber transactions, and use tax on equipment purchases. Captures tax document number, tax code, tax jurisdiction, taxable base amount, tax amount, tax rate, company code, posting date, and tax return period. Supports indirect tax compliance, tax return preparation, and audit defense.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` (
    `ebitda_snapshot_id` BIGINT COMMENT 'Unique identifier for the EBITDA snapshot record. Primary key for this period-locked financial management reporting record.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: License-level EBITDA reporting is required for debt covenant compliance, ownership attribution calculations (JSA/SSA revenue sharing), and FCC financial qualification reviews during license transfers.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: EBITDA snapshots are per legal entity for management reporting and consolidation. The company_code is a business key reference to legal_entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with this EBITDA snapshot. Cost centers track where costs are incurred within the organization.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for which this EBITDA snapshot is recorded. Profit centers represent organizational units responsible for costs and revenues.',
    `advertising_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from advertising sales during the reporting period, including linear TV ads, digital ads, and DAI (Dynamic Ad Insertion).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this EBITDA snapshot was approved and finalized for management reporting.',
    `approved_by_user` STRING COMMENT 'User ID or name of the manager or controller who approved this EBITDA snapshot for final reporting.',
    `budget_ebitda_amount` DECIMAL(18,2) COMMENT 'Budgeted EBITDA amount for this reporting period as approved in the annual planning cycle.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Variance between actual EBITDA and budgeted EBITDA, calculated as actual minus budget.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'Budget variance expressed as a percentage of budgeted EBITDA.',
    `business_segment` STRING COMMENT 'The business segment classification for this EBITDA snapshot, such as Linear Broadcasting, Streaming/OTT, Content Production, or Syndication.',
    `carriage_fee_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue from carriage fees and retransmission consent agreements with MVPDs (Multichannel Video Programming Distributors) and vMVPDs during the reporting period.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity for which this EBITDA snapshot is recorded.',
    `content_acquisition_cost_amount` DECIMAL(18,2) COMMENT 'Direct costs for acquiring or licensing content during the reporting period, including rights payments and royalties.',
    `controlling_area` STRING COMMENT 'The controlling area in SAP CO that groups one or more company codes for management accounting purposes.',
    `covenant_compliance_flag` BOOLEAN COMMENT 'Indicates whether this EBITDA snapshot is used for debt covenant compliance reporting and monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this EBITDA snapshot record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts in this snapshot are denominated.. Valid values are `^[A-Z]{3}$`',
    `distribution_cost_amount` DECIMAL(18,2) COMMENT 'Direct costs for content distribution and delivery, including CDN (Content Delivery Network) fees, playout, and transmission costs.',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'EBITDA calculated as gross margin minus total operating expenses. This is the authoritative management reporting metric for operational profitability.',
    `ebitda_margin_percentage` DECIMAL(18,2) COMMENT 'EBITDA expressed as a percentage of total revenue. Key profitability metric for board reporting and covenant compliance.',
    `facilities_expense_amount` DECIMAL(18,2) COMMENT 'Operating expenses for facilities, rent, utilities, and physical infrastructure during the reporting period.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year for which this EBITDA snapshot is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this EBITDA snapshot is recorded, representing the annual accounting period.',
    `forecast_ebitda_amount` DECIMAL(18,2) COMMENT 'Latest forecast EBITDA amount for this reporting period, updated through rolling forecast processes.',
    `forecast_variance_amount` DECIMAL(18,2) COMMENT 'Variance between actual EBITDA and forecast EBITDA, calculated as actual minus forecast.',
    `forecast_variance_percentage` DECIMAL(18,2) COMMENT 'Forecast variance expressed as a percentage of forecast EBITDA.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross margin calculated as total revenue minus total direct costs for the reporting period.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of total revenue.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this EBITDA snapshot record was last modified before being locked.',
    `marketing_expense_amount` DECIMAL(18,2) COMMENT 'Operating expenses for marketing, advertising, and promotional activities during the reporting period.',
    `notes` STRING COMMENT 'Free-text notes and commentary from management regarding this EBITDA snapshot, including explanations of variances or one-time adjustments.',
    `other_direct_cost_amount` DECIMAL(18,2) COMMENT 'Other direct costs not classified in the primary cost categories but directly attributable to revenue generation.',
    `other_operating_expense_amount` DECIMAL(18,2) COMMENT 'Other operating expenses not classified in the primary expense categories.',
    `other_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue from other sources not classified in the primary revenue streams, such as merchandise, events, or ancillary services.',
    `period_lock_date` DATE COMMENT 'The date on which this EBITDA snapshot was locked and became the authoritative management reporting record.',
    `personnel_expense_amount` DECIMAL(18,2) COMMENT 'Operating expenses for personnel costs including salaries, benefits, and talent residuals during the reporting period.',
    `prepared_by_user` STRING COMMENT 'User ID or name of the financial analyst who prepared this EBITDA snapshot.',
    `prior_period_ebitda_amount` DECIMAL(18,2) COMMENT 'EBITDA amount from the comparable prior period (prior year same period) for variance analysis.',
    `prior_period_variance_amount` DECIMAL(18,2) COMMENT 'Variance between current period EBITDA and prior period EBITDA, calculated as current minus prior.',
    `prior_period_variance_percentage` DECIMAL(18,2) COMMENT 'Prior period variance expressed as a percentage of prior period EBITDA.',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'Direct costs for content production and post-production activities during the reporting period.',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this EBITDA snapshot.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this EBITDA snapshot.',
    `snapshot_number` STRING COMMENT 'Business identifier for this EBITDA snapshot, typically following a sequential or period-based numbering scheme for management reporting.',
    `snapshot_status` STRING COMMENT 'Current status of this EBITDA snapshot in the period-close workflow. Once locked, the snapshot becomes the authoritative record for board reporting and covenant compliance.. Valid values are `draft|preliminary|final|locked|adjusted`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this EBITDA snapshot is subject to SOX financial reporting controls and audit requirements.',
    `subscription_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue from subscription services during the reporting period, including SVOD (Subscription Video On Demand) and membership fees.',
    `syndication_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue from content syndication and licensing to third-party broadcasters and platforms during the reporting period.',
    `technology_expense_amount` DECIMAL(18,2) COMMENT 'Operating expenses for technology infrastructure, software licenses, and IT services during the reporting period.',
    `total_direct_cost_amount` DECIMAL(18,2) COMMENT 'Total direct costs for the reporting period. Sum of content acquisition, production, distribution, and other direct costs.',
    `total_operating_expense_amount` DECIMAL(18,2) COMMENT 'Total operating expenses for the reporting period. Sum of personnel, marketing, technology, facilities, and other operating expenses.',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue across all streams for the reporting period. Sum of advertising, subscription, carriage fees, syndication, and other revenue.',
    CONSTRAINT pk_ebitda_snapshot PRIMARY KEY(`ebitda_snapshot_id`)
) COMMENT 'Periodic management accounting snapshot capturing EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) by profit center, business segment, and reporting period for Media Broadcasting. Stores revenue by stream, direct costs, gross margin, operating expenses, EBITDA amount, EBITDA margin percentage, prior period comparison, budget variance, and forecast variance. Derived from SAP CO actual postings and serves as the authoritative management reporting record — NOT an analytics aggregate but a period-locked financial record used for board reporting and covenant compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` (
    `financial_reconciliation_id` BIGINT COMMENT 'Unique identifier for the financial reconciliation record. Primary key for the financial reconciliation entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Reconciliations are performed per GL account. The gl_account_number STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Financial reconciliations are performed per legal entity during period-end close. The company_code is a business key reference to legal_entity.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who performed the reconciliation, used for audit trail and accountability purposes.',
    `reviewer_employee_id` BIGINT COMMENT 'Employee identifier of the person who reviewed the reconciliation, supporting SOX-compliant segregation of duties.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Reconciliations are SOX control activities (account reconciliation controls). Control testing requires linking reconciliation evidence to control documentation. Finance must track which SOX control ea',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to technology.vendor_contract. Business justification: Contract liability reconciliations (prepaid maintenance, deferred service revenue, accrued contract costs) require contract reference. Finance reconciles contract balances monthly for revenue recognit',
    `adjustment_document_number` STRING COMMENT 'The SAP FI document number of the journal entry posted to resolve the reconciliation variance, providing traceability to corrective actions.',
    `adjustment_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether a journal entry adjustment is required to resolve the identified variance.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity for which this reconciliation is performed, enabling multi-entity financial consolidation.',
    `created_by_user` STRING COMMENT 'The system user ID of the person who created this reconciliation record, supporting audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reconciliation amounts, supporting multi-currency financial operations.. Valid values are `^[A-Z]{3}$`',
    `ebitda_reporting_segment` STRING COMMENT 'The EBITDA reporting segment to which this reconciliation applies, supporting segment-level financial performance tracking and corporate reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year for which this reconciliation applies, typically used during period-end close.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this reconciliation is being performed, aligned with Media Broadcastings financial calendar.',
    `gl_account_number` STRING COMMENT 'The general ledger account number from the chart of accounts that is being reconciled, representing the GL balance side of the reconciliation.',
    `gl_balance_amount` DECIMAL(18,2) COMMENT 'The balance amount recorded in the general ledger for the specified GL account as of the reconciliation date.',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this reconciliation involves intercompany transactions requiring elimination during financial consolidation.',
    `last_modified_by_user` STRING COMMENT 'The system user ID of the person who last modified this reconciliation record, supporting audit trail and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was last updated, supporting change tracking and audit trail requirements.',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'The predetermined materiality threshold for this reconciliation type; variances below this amount may be considered immaterial and require less investigation.',
    `reconciler_name` STRING COMMENT 'Full name of the finance team member who performed the reconciliation activity.',
    `reconciliation_date` DATE COMMENT 'The business date on which the reconciliation activity was performed or completed, representing the principal business event timestamp for this reconciliation.',
    `reconciliation_notes` STRING COMMENT 'Additional free-text notes and comments related to the reconciliation activity, including special circumstances, follow-up actions, or audit observations.',
    `reconciliation_number` STRING COMMENT 'Business-facing unique identifier or reference number assigned to this reconciliation activity for tracking and audit purposes.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation activity indicating workflow stage and approval state.. Valid values are `draft|in_progress|pending_review|approved|rejected|closed`',
    `reconciliation_type` STRING COMMENT 'Category of reconciliation being performed: bank reconciliations, intercompany balance reconciliations, subledger-to-GL reconciliations (AR, AP, fixed assets), or revenue stream reconciliations between Wide Orbit billing, Zuora subscription billing, and SAP FI. [ENUM-REF-CANDIDATE: bank|intercompany|subledger_to_gl|revenue_stream|fixed_asset|accounts_receivable|accounts_payable — 7 candidates stripped; promote to reference product]',
    `review_date` DATE COMMENT 'The date on which the reconciliation was reviewed and validated by the reviewer, part of the SOX control evidence.',
    `reviewer_name` STRING COMMENT 'Full name of the finance manager or supervisor who reviewed and validated the reconciliation results.',
    `sign_off_status` STRING COMMENT 'Approval status indicating whether the reconciliation has been formally signed off by the reviewer as part of period-end close procedures.. Valid values are `pending|signed_off|rejected|escalated`',
    `sign_off_timestamp` TIMESTAMP COMMENT 'The precise date and time when the reconciliation was formally signed off, providing audit trail for SOX compliance.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this reconciliation is part of SOX-compliant internal control procedures requiring enhanced documentation and audit trail.',
    `subledger_balance_amount` DECIMAL(18,2) COMMENT 'The balance amount recorded in the subledger system (AR, AP, fixed assets, or revenue system) as of the reconciliation date, to be compared against the GL balance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The calculated difference between the GL balance and the subledger balance, representing the reconciliation discrepancy that requires investigation and resolution.',
    `variance_explanation` STRING COMMENT 'Detailed business explanation of the variance identified during reconciliation, including root cause analysis and corrective actions taken or planned.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the GL balance, used to assess materiality and prioritize reconciliation efforts.',
    CONSTRAINT pk_financial_reconciliation PRIMARY KEY(`financial_reconciliation_id`)
) COMMENT 'Record of financial reconciliation activities performed during period-end close for Media Broadcasting — including bank reconciliations, intercompany balance reconciliations, subledger-to-GL reconciliations (AR, AP, fixed assets), and revenue stream reconciliations between Wide Orbit billing, Zuora subscription billing, and SAP FI. Captures reconciliation type, reconciliation period, system-of-record source, GL balance, subledger balance, variance amount, variance explanation, reconciler, and sign-off status.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` (
    `facility_legal_assignment_id` BIGINT COMMENT 'Unique identifier for this facility-legal entity assignment record. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to the broadcast facility that is associated with the legal entity',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to the legal entity that has a legal or financial relationship with the broadcast facility',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this facility-legal entity assignment. Values: active (currently in effect), pending (future-dated assignment), expired (past end date), terminated (assignment ended before planned end date).',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of facility operating costs allocated to this legal entity. Used for intercompany charging and cost center allocation. Sum of percentages across all legal entities for a facility should equal 100.00 for shared facilities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this legal entity assignment ended or will end. Null indicates the assignment is currently active. Used for tracking facility transfers, lease expirations, and reorganizations.',
    `effective_start_date` DATE COMMENT 'Date on which this legal entity assignment became effective. Used for historical tracking of facility ownership and cost allocation changes over time.',
    `intercompany_charge_code` STRING COMMENT 'Code used for intercompany billing and cost allocation transactions related to this facility assignment. Links to the chart of accounts for proper financial posting.',
    `lease_or_own_flag` BOOLEAN COMMENT 'Boolean indicator of whether the facility is leased (true) or owned (false) by this legal entity. Simplified binary view of ownership_type for financial reporting.',
    `ownership_type` STRING COMMENT 'Classification of the legal relationship between the legal entity and the facility. Values: owned (legal entity owns the facility), leased (legal entity leases the facility), shared_services (facility shared across multiple entities), co_location (entity co-located within a facility owned by another entity), managed_services (third-party managed facility used by entity).',
    `primary_user_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is the primary operational user of the facility. Used to designate the primary responsible entity for regulatory reporting and operational management when multiple entities share a facility.',
    `tax_reporting_entity_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is responsible for tax reporting obligations related to this facility (property tax, local business tax, etc.). Critical for multi-entity shared facilities.',
    `updated_by` STRING COMMENT 'User or system identifier that last modified this assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified.',
    `created_by` STRING COMMENT 'User or system identifier that created this assignment record.',
    CONSTRAINT pk_facility_legal_assignment PRIMARY KEY(`facility_legal_assignment_id`)
) COMMENT 'This association product represents the legal and financial relationship between a legal entity and a broadcast facility. It captures ownership structure, cost allocation, and operational responsibility for facilities that may be owned, leased, or shared across multiple legal entities within the Media Broadcasting corporate structure. Each record links one legal entity to one broadcast facility with attributes that define the nature of the legal and financial relationship, supporting intercompany charging, tax compliance, and regulatory reporting.. Existence Justification: In Media Broadcasting corporate structures, legal entities commonly operate multiple broadcast facilities (studios, NOCs, transmission sites) across geographic regions, and facilities are frequently shared across multiple legal entities through co-location arrangements, shared services models, or intercompany leasing. The business actively manages these assignments for financial reporting (cost allocation, intercompany charging), tax compliance (property tax responsibility, VAT registration), and regulatory reporting (SOX scope, broadcast license holder designation). This is an operational relationship tracked in ERP and financial systems, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` (
    `project_assignment_id` BIGINT COMMENT 'Unique identifier for the project assignment record. Primary key.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to the capital expenditure project to which the employee is assigned.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `project_employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the capital project.',
    `project_manager_employee_id` BIGINT COMMENT '',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees working time allocated to this capital project. Used for resource planning and cost allocation. Explicitly identified in detection reasoning as allocation_percentage.',
    `assignment_status` STRING COMMENT 'Current status of the project assignment. Active indicates the employee is currently working on the project, Planned for future assignments, Completed for finished assignments, Suspended for temporarily paused assignments.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the employees time on this project is billable to the project budget or capitalized as part of project costs. Used for cost accounting and capitalization calculations. Explicitly identified in detection reasoning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was created in the system.',
    `end_date` DATE COMMENT 'Date when the employees assignment to this capital project ended or is planned to end. Null for ongoing assignments. Explicitly identified in detection reasoning.',
    `role` STRING COMMENT 'The specific role or function the employee performs on this capital project. Examples include Project Manager, Technical Lead, Finance Controller, Procurement Specialist. Explicitly identified in detection reasoning.',
    `start_date` DATE COMMENT 'Date when the employees assignment to this capital project began. Explicitly identified in detection reasoning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was last updated.',
    CONSTRAINT pk_project_assignment PRIMARY KEY(`project_assignment_id`)
) COMMENT 'This association product represents the Assignment between capex_project and employee. It captures the formal assignment of employees to capital expenditure projects in various roles beyond the single project manager. Each record links one capex_project to one employee with attributes that exist only in the context of this project assignment relationship, including role, time allocation, assignment dates, and billability status.. Existence Justification: In media broadcasting capital projects, multiple employees participate in different specialized roles (project manager, technical lead, finance controller, procurement specialist, engineers, architects) with varying time allocations and assignment periods. Employees work on multiple concurrent capex projects (e.g., a finance controller may oversee budget compliance for 3-4 projects simultaneously at 25% allocation each). The business actively manages these assignments as a workforce planning and project governance process, tracking who is assigned to which project, in what role, for what time period, and at what allocation percentage.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` (
    `obligation_gl_mapping_id` BIGINT COMMENT 'Unique identifier for this obligation-to-GL-account mapping record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to the general ledger account used to record costs or financial impacts related to this regulatory obligation.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation that generates financial postings to this GL account.',
    `accrual_required` BOOLEAN COMMENT 'Indicates whether costs for this obligation must be accrued in this GL account prior to cash payment. True for obligations with annual fees that must be accrued monthly, regulatory penalties under dispute, or multi-year license fees. Corresponds to accrual_required_flag from detection data.',
    `cost_allocation_rule` STRING COMMENT 'Business rule describing how costs for this obligation should be allocated to this GL account. May reference allocation keys, cost centers, profit centers, or percentage splits (e.g., Allocate 60% to linear TV cost center, 40% to OTT, Direct charge to broadcast operations functional area). Corresponds to cost_allocation_rule from detection data.',
    `effective_date` DATE COMMENT 'Date when this obligation-to-GL-account mapping became or becomes effective. Used to track changes in how obligations are recorded over time (e.g., when a new regulation requires a new GL account, or when cost allocation rules change). Corresponds to effective_date from detection data.',
    `estimated_annual_amount` DECIMAL(18,2) COMMENT 'Estimated annual financial impact of this obligation in this GL account, in the accounts currency. Used for budgeting, forecasting, and materiality assessments. May be null for event-driven obligations with unpredictable costs.',
    `expiration_date` DATE COMMENT 'Date when this mapping expires or is superseded by a new mapping rule. Null for ongoing mappings. Supports historical tracking of how obligation accounting has evolved.',
    `mapping_status` STRING COMMENT 'Current status of this mapping: active (currently in use for financial postings), inactive (no longer used but retained for historical reference), pending_approval (proposed mapping awaiting finance/compliance approval), superseded (replaced by a newer mapping).',
    `mapping_type` STRING COMMENT 'Classification of how this obligation maps to this GL account: license_fee (broadcast spectrum fees), compliance_expense (ongoing compliance costs), capital_expenditure (EAS equipment, closed captioning infrastructure), prepaid_regulatory (prepaid license fees), accrued_penalty (potential fines), legal_reserve (litigation reserves), equipment_maintenance (regulatory equipment upkeep), consulting_fee (compliance consultants), audit_cost (regulatory audits), other. Corresponds to obligation_gl_mapping_type from detection data.',
    `notes` STRING COMMENT 'Free-text notes explaining special circumstances, exceptions, or business context for this mapping (e.g., Per CFO directive 2023-Q2, all FCC license fees now flow through prepaid account, Mapping changed due to SOX control enhancement).',
    `reporting_line_item` STRING COMMENT 'The financial statement line item or regulatory report line where this obligation-account combination should be reported. Used for external regulatory financial reporting (e.g., FCC Form 323, Ofcom Annual Return) and internal management reporting. Corresponds to reporting_line_item from detection data.',
    CONSTRAINT pk_obligation_gl_mapping PRIMARY KEY(`obligation_gl_mapping_id`)
) COMMENT 'This association product represents the mapping between regulatory obligations and chart of accounts entries. It captures how each regulatory obligation flows through specific general ledger accounts for financial tracking, cost allocation, and regulatory reporting. Each record links one regulatory obligation to one GL account with mapping rules that govern how compliance costs are recorded and reported.. Existence Justification: In media broadcasting operations, regulatory obligations generate financial impacts across multiple GL accounts (e.g., FCC license fees flow through both regulatory expense and prepaid accounts; EAS equipment obligations touch capex, depreciation, and maintenance accounts). Conversely, each GL account receives postings from multiple regulatory obligations (e.g., the Regulatory Compliance Expense account aggregates costs from content regulations, licensing, EAS, closed captioning, and public file obligations). The compliance and finance teams actively manage these mappings to ensure proper cost allocation, accrual accounting, and regulatory financial reporting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` (
    `cost_center_obligation_allocation_id` BIGINT COMMENT 'Unique identifier for this cost center obligation allocation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center that holds partial responsibility for the regulatory obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation being allocated across cost centers',
    `employee_id` BIGINT COMMENT 'The employee identifier of the individual within this cost center who serves as the primary contact and responsible party for this obligation. Links to employee master data.',
    `allocation_effective_date` DATE COMMENT 'The date from which this cost center obligation allocation becomes effective and active.',
    `allocation_end_date` DATE COMMENT 'The date when this cost center obligation allocation ends or is superseded. Null indicates an ongoing allocation.',
    `allocation_status` STRING COMMENT 'Current status of this allocation: active (currently in effect), inactive (temporarily suspended), pending (approved but not yet effective), superseded (replaced by newer allocation).',
    `compliance_budget_amount` DECIMAL(18,2) COMMENT 'The budget amount allocated by this cost center specifically for compliance activities related to this regulatory obligation. Denominated in the cost centers currency.',
    `last_review_date` DATE COMMENT 'The date when this cost center last reviewed its compliance status and responsibilities for this specific regulatory obligation.',
    `next_review_date` DATE COMMENT 'The scheduled date for this cost centers next compliance review for this specific regulatory obligation.',
    `notes` STRING COMMENT 'Free-text field for additional context about this specific cost centers responsibility for this obligation, including special arrangements, dependencies, or coordination requirements with other cost centers.',
    `obligation_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of responsibility for this regulatory obligation allocated to this specific cost center. Used for budget allocation and accountability tracking. Sum of all allocations for a given obligation should equal 100%.',
    CONSTRAINT pk_cost_center_obligation_allocation PRIMARY KEY(`cost_center_obligation_allocation_id`)
) COMMENT 'This association product represents the allocation of regulatory compliance responsibility and budget across cost centers for specific regulatory obligations. It captures the distributed accountability model where multiple cost centers share responsibility for meeting a single regulatory obligation (e.g., EEO compliance spans HR and station cost centers; closed captioning spans production and engineering). Each record links one cost_center to one regulatory_obligation with allocation percentage, responsible contact, compliance budget, and review dates that exist only in the context of this shared responsibility relationship.. Existence Justification: In media broadcasting operations, regulatory obligations such as EEO compliance, closed captioning requirements, and content licensing span multiple organizational cost centers. A single regulatory obligation (e.g., FCC closed captioning compliance) requires coordinated effort and budget from production studios, engineering operations, and quality assurance cost centers. Conversely, a single cost center (e.g., Digital Platform Operations) is responsible for portions of multiple regulatory obligations (content licensing, data privacy, accessibility standards). The business actively manages these allocations with specific budget amounts, responsible contacts, and review schedules for each cost center-obligation pairing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` (
    `cost_center_authorization_id` BIGINT COMMENT 'Unique identifier for this cost center authorization record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center for which authorization is granted',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who holds authorization for this cost center',
    `cost_granted_by_employee_id` BIGINT COMMENT 'Reference to the employee who granted or approved this authorization. Used for audit trail and authorization chain of custody.',
    `cost_revoked_by_employee_id` BIGINT COMMENT 'Reference to the employee who revoked this authorization. Null if authorization has not been revoked.',
    `granted_by_employee_id` BIGINT COMMENT '',
    `revoked_by_employee_id` BIGINT COMMENT '',
    `approval_limit_amount` DECIMAL(18,2) COMMENT 'The maximum monetary amount this employee is authorized to approve for transactions against this cost center. Null indicates unlimited approval authority or non-monetary authorization.',
    `authorization_level` STRING COMMENT 'The hierarchical authorization level granted to this employee for this cost center. Higher levels typically correspond to higher approval limits and broader authority.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of this authorization indicating whether it is currently in force, suspended temporarily, permanently revoked, or pending activation.',
    `effective_end_date` DATE COMMENT 'The date on which this authorization expires or was revoked. Null indicates an open-ended authorization that remains active.',
    `effective_start_date` DATE COMMENT 'The date from which this authorization becomes active and the employee can exercise approval authority for this cost center.',
    `granted_date` DATE COMMENT 'The date on which this authorization was officially granted or approved.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or restrictions associated with this authorization.',
    `revocation_reason` STRING COMMENT 'Free-text explanation of why this authorization was revoked (e.g., role change, termination, reorganization, policy violation).',
    `revoked_date` DATE COMMENT 'The date on which this authorization was revoked. Null if authorization has not been revoked.',
    `role` STRING COMMENT 'The specific role or capacity in which the employee is authorized for this cost center (e.g., APPROVER, CONTROLLER, PROCUREMENT_MANAGER, DEPARTMENT_HEAD). Determines the type of actions the employee can perform.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this authorization is subject to SOX financial controls and requires enhanced audit trail and segregation of duties validation.',
    CONSTRAINT pk_cost_center_authorization PRIMARY KEY(`cost_center_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between cost_center and employee. It captures the formal approval authority granted to employees for specific cost centers, including their role, authorization level, approval limits, and validity period. Each record links one cost_center to one employee with attributes that exist only in the context of this authorization relationship.. Existence Justification: In media broadcasting organizations, cost centers require multiple authorized approvers with different roles and approval limits for financial control and segregation of duties. A single cost center has multiple employees authorized to approve transactions (department heads, finance controllers, procurement managers, budget owners), each with specific authorization levels and monetary limits. Conversely, senior employees (VPs, finance directors) hold approval authority across multiple cost centers within their span of control. The current models single responsible_manager_employee_id cannot represent this multi-approver authorization structure.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` (
    `facility_cost_allocation_id` BIGINT COMMENT 'Unique identifier for this cost allocation relationship. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically finance controller or facility manager) who approved this allocation arrangement.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to the broadcast facility whose costs are being allocated',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center that incurs allocated costs from facility usage',
    `allocation_method` STRING COMMENT 'The methodology used to calculate the allocation percentage: direct_usage (metered consumption), proportional_headcount (based on staff count), square_footage (based on space occupied), activity_based (based on activity drivers), fixed_percentage (negotiated static allocation).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of facility costs allocated to this cost center, representing proportional usage or consumption of facility resources. Used for overhead distribution and chargeback calculations.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation relationship: active (costs being allocated), pending (approved but not yet effective), suspended (temporarily paused), terminated (ended).',
    `approval_date` DATE COMMENT 'The date when this cost allocation arrangement was approved by finance and facility management.',
    `effective_end_date` DATE COMMENT 'The date on which this cost allocation relationship ends. Null indicates an ongoing allocation arrangement.',
    `effective_start_date` DATE COMMENT 'The date from which this cost allocation relationship becomes active and costs begin to be allocated to the cost center.',
    `monthly_allocated_amount` DECIMAL(18,2) COMMENT 'The calculated monthly cost amount allocated to this cost center from this facility, derived from allocation_percentage applied to facility operating costs. Used for budget tracking and variance analysis.',
    `notes` STRING COMMENT 'Free-text field for additional context about this allocation relationship, including special arrangements, seasonal adjustments, or business justification.',
    `usage_metric_type` STRING COMMENT 'The type of metric used to measure and justify the cost allocation: square_footage (floor space occupied), equipment_count (number of devices/racks), booking_hours (studio/control room reservation time), headcount (staff assigned to facility), bandwidth_gbps (network capacity consumed), power_kva (electrical load).',
    `usage_metric_value` DECIMAL(18,2) COMMENT 'The quantitative value of the usage metric for this allocation relationship. Interpretation depends on usage_metric_type (e.g., 2500.00 square feet, 150.00 booking hours per month, 45.00 equipment units).',
    CONSTRAINT pk_facility_cost_allocation PRIMARY KEY(`facility_cost_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between cost centers and broadcast facilities in Media Broadcasting operations. It captures how operational costs are distributed across shared physical infrastructure when multiple departments (news, sports, production, engineering) utilize the same studios, master control rooms, NOCs, and transmission sites. Each record links one cost center to one broadcast facility with allocation percentages, usage periods, and metrics that exist only in the context of this shared-resource relationship.. Existence Justification: In Media Broadcasting operations, broadcast facilities (studios, master control rooms, NOCs, transmission sites) are shared infrastructure used by multiple operational cost centers simultaneously. A single studio facility serves news, sports, and entertainment production departments, while a single cost center like Digital Platform Operations utilizes multiple facilities (studio, NOC, data center) across different locations. The business actively manages these allocation relationships to distribute facility overhead costs for accurate departmental P&L and EBITDA reporting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` (
    `recurring_entry_template_id` BIGINT COMMENT 'Primary key for recurring_entry_template',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with this recurring entry template for cost allocation and tracking.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division that owns and maintains this recurring entry template.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for internal management reporting and EBITDA tracking associated with this recurring entry template.',
    `employee_id` BIGINT COMMENT 'Reference to the user who originally created this recurring entry template record.',
    `recurring_employee_id` BIGINT COMMENT 'Reference to the user responsible for approving journal entries generated from this template when approval is required.',
    `recurring_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this recurring entry template record.',
    `source_recurring_entry_template_id` BIGINT COMMENT 'Self-referencing FK on recurring_entry_template (source_recurring_entry_template_id)',
    `created_by_employee_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT 'Standard monetary amount to be posted when generating journal entries from this template. May be overridden at execution time.',
    `approval_required_flag` BOOLEAN COMMENT 'Flag indicating whether journal entries generated from this template require managerial approval before posting.',
    `company_code` STRING COMMENT 'SAP company code identifying the legal entity to which this recurring entry template applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recurring entry template record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the template amount.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the recurring entry template generates debit or credit journal entries.',
    `document_type` STRING COMMENT 'SAP document type code that classifies the journal entry documents generated from this template.',
    `effective_end_date` DATE COMMENT 'Date after which the recurring entry template is no longer active. Null indicates open-ended recurrence.',
    `effective_start_date` DATE COMMENT 'Date from which the recurring entry template becomes active and eligible for journal entry generation.',
    `execution_count` STRING COMMENT 'Total number of times journal entries have been successfully generated from this recurring entry template since activation.',
    `gl_account_code` STRING COMMENT 'Chart of accounts general ledger account code to which this recurring entry template posts transactions.',
    `intercompany_flag` BOOLEAN COMMENT 'Flag indicating whether this recurring entry template generates intercompany transactions requiring elimination during consolidation.',
    `last_execution_date` DATE COMMENT 'Date when a journal entry was most recently generated from this recurring entry template.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recurring entry template record was most recently modified.',
    `next_scheduled_execution_date` DATE COMMENT 'Date when the next journal entry is scheduled to be automatically generated from this recurring entry template based on recurrence frequency.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, instructions, or documentation related to the recurring entry template.',
    `posting_key` STRING COMMENT 'SAP posting key that controls the account type and debit/credit posting behavior for journal entries generated from this template.',
    `recurrence_frequency` STRING COMMENT 'Frequency at which the recurring journal entry should be automatically generated from this template.',
    `reference_document_number` STRING COMMENT 'External reference document number or identifier that provides additional context or justification for the recurring entry template.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether journal entries generated from this template should be automatically reversed in the subsequent period.',
    `reversal_posting_date_offset_days` STRING COMMENT 'Number of days after the original posting date when the reversal entry should be posted. Applicable only when reversal_indicator is true.',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this recurring entry template is subject to Sarbanes-Oxley internal control requirements and audit procedures.',
    `recurring_entry_template_status` STRING COMMENT 'Current lifecycle status of the recurring entry template indicating whether it is available for use in journal entry generation.',
    `template_code` STRING COMMENT 'Unique business identifier code for the recurring entry template, used for external reference and system integration.',
    `template_description` STRING COMMENT 'Detailed description of the recurring entry template, including business purpose, accounting treatment, and usage guidelines.',
    `template_name` STRING COMMENT 'Human-readable name describing the purpose of the recurring journal entry template.',
    `template_type` STRING COMMENT 'Classification of the recurring entry template by accounting treatment type.',
    `trading_partner_code` STRING COMMENT 'Code identifying the intercompany trading partner entity for intercompany recurring entries. Applicable only when intercompany_flag is true.',
    CONSTRAINT pk_recurring_entry_template PRIMARY KEY(`recurring_entry_template_id`)
) COMMENT 'Master reference table for recurring_entry_template. Referenced by recurring_entry_template_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` (
    `source_document_id` BIGINT COMMENT 'Primary key for source_document',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account to which this source document is posted for financial reporting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this source document is assigned for internal cost allocation and management reporting.',
    `sales_account_id` BIGINT COMMENT 'Reference to the customer associated with this source document for receivables transactions.',
    `superseded_source_document_id` BIGINT COMMENT 'Self-referencing FK on source_document (superseded_source_document_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this source document for payables transactions.',
    `approval_date` DATE COMMENT 'The date on which this source document was approved for posting.',
    `approval_status` STRING COMMENT 'The approval status of the source document indicating whether it has been reviewed and approved per SOX-compliant financial controls.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this source document for posting.',
    `attachment_count` STRING COMMENT 'The number of supporting documents or attachments linked to this source document (e.g., scanned invoices, contracts, receipts).',
    `company_code` STRING COMMENT 'The company code representing the legal entity within the enterprise to which this source document belongs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this source document record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the source document amounts are denominated.',
    `source_document_description` STRING COMMENT 'Free-text description or header text providing additional context and details about the source document.',
    `document_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the source document in the document currency before any adjustments or taxes.',
    `document_date` DATE COMMENT 'The date the source document was created or issued by the originating party. This is the business event date that determines the accounting period assignment.',
    `document_number` STRING COMMENT 'The externally-known unique business identifier or reference number assigned to the source document (e.g., invoice number, contract number, purchase order number).',
    `document_status` STRING COMMENT 'Current lifecycle status of the source document indicating its processing state (e.g., draft, pending approval, approved, posted, cancelled, archived).',
    `document_type` STRING COMMENT 'Classification of the source document indicating its purpose and nature within the financial system (e.g., invoice, purchase order, contract, receipt, credit memo, journal entry).',
    `due_date` DATE COMMENT 'The date by which payment is due for this source document, calculated based on payment terms.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this source document is assigned.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this source document is assigned for financial reporting purposes.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this source document represents an intercompany transaction requiring elimination in consolidated financial reporting.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this source document record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this source document record was last modified in the system.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount of the source document after applying all taxes, discounts, and adjustments.',
    `payment_terms` STRING COMMENT 'The payment terms code or description specifying the due date calculation and discount conditions for this source document.',
    `posting_date` DATE COMMENT 'The date the source document was posted to the general ledger, determining the fiscal period for financial reporting.',
    `reference_number` STRING COMMENT 'External reference number or identifier provided by the counterparty (e.g., vendor invoice number, customer purchase order number) for cross-reference and reconciliation.',
    `reversal_date` DATE COMMENT 'The date on which this source document was reversed, if applicable.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this source document has been reversed or cancelled.',
    `reversal_reason` STRING COMMENT 'Free-text explanation or code indicating the reason for reversing this source document.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount associated with the source document, including sales tax, VAT, or other applicable taxes.',
    `trading_partner_code` STRING COMMENT 'The company code of the intercompany trading partner for intercompany transactions.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this source document record in the system.',
    CONSTRAINT pk_source_document PRIMARY KEY(`source_document_id`)
) COMMENT 'Master reference table for source_document. Referenced by source_document_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Primary key for depreciation_schedule',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that bears the depreciation expense. Used for management accounting and departmental cost allocation.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being depreciated. Links to the asset master record for equipment, facilities, broadcast infrastructure, or production equipment.',
    `revised_depreciation_schedule_id` BIGINT COMMENT 'Self-referencing FK on depreciation_schedule (revised_depreciation_schedule_id)',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense recognized to date since the asset was placed in service. Contra-asset account balance.',
    `annual_depreciation_amount` DECIMAL(18,2) COMMENT 'The calculated annual depreciation expense for this asset under the specified depreciation method. Used for budgeting and forecasting.',
    `approval_date` DATE COMMENT 'The date when this depreciation schedule was approved. Part of the audit trail for financial controls.',
    `approval_status` STRING COMMENT 'The approval workflow status for this depreciation schedule. Ensures proper authorization before depreciation posting.',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this depreciation schedule. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this schedule. Ensures consistent currency treatment across multi-currency operations.',
    `depreciable_base` DECIMAL(18,2) COMMENT 'The amount subject to depreciation, calculated as original cost minus salvage value. The total amount to be expensed over the assets useful life.',
    `depreciation_book_type` STRING COMMENT 'The accounting book or ledger for which this depreciation schedule applies. Supports parallel depreciation for different reporting frameworks.',
    `depreciation_method` STRING COMMENT 'The accounting method used to calculate depreciation expense over the assets useful life. Determines the pattern of expense recognition.',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'The percentage rate applied to calculate depreciation, particularly for declining balance methods. Expressed as a percentage.',
    `effective_end_date` DATE COMMENT 'The date when depreciation ends for this asset. May be the end of useful life, disposal date, or full depreciation date. Nullable for active schedules.',
    `effective_start_date` DATE COMMENT 'The date when depreciation begins for this asset. Typically the assets placed-in-service date or acquisition date.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this depreciation schedule is effective. Supports year-specific depreciation calculations and reporting.',
    `general_ledger_account_code` STRING COMMENT 'The chart of accounts code for posting depreciation expense. Links to the GL account master for financial statement classification.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'The amount of impairment loss recognized, reducing the carrying value of the asset. Nullable if no impairment has occurred.',
    `impairment_date` DATE COMMENT 'The date when an impairment loss was recognized for this asset. Nullable if no impairment has occurred.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment or shows indicators of impairment. Triggers impairment review processes.',
    `last_depreciation_run_date` DATE COMMENT 'The date when depreciation was last calculated and posted for this schedule. Used to track period-end close activities.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this depreciation schedule. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule record was last modified. Tracks changes for audit and compliance purposes.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The current carrying value of the asset, calculated as original cost minus accumulated depreciation. Represents the undepreciated balance.',
    `next_depreciation_run_date` DATE COMMENT 'The scheduled date for the next depreciation calculation. Used for planning period-end close and financial reporting cycles.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special instructions related to this depreciation schedule.',
    `original_cost` DECIMAL(18,2) COMMENT 'The initial acquisition or construction cost of the asset, including all costs necessary to bring the asset to its intended use.',
    `salvage_value` DECIMAL(18,2) COMMENT 'The estimated residual value of the asset at the end of its useful life. The amount expected to be recovered through sale or disposal.',
    `schedule_number` STRING COMMENT 'Business identifier for the depreciation schedule. Externally visible reference number used in financial reporting and audit trails.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this depreciation schedule is subject to SOX internal control testing and audit requirements.',
    `depreciation_schedule_status` STRING COMMENT 'Current lifecycle status of the depreciation schedule. Indicates whether depreciation is actively being calculated and posted.',
    `useful_life_units` BIGINT COMMENT 'The estimated total production capacity or usage units over the assets life. Used for units-of-production depreciation method. Nullable for time-based methods.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'The estimated economic useful life of the asset in years. Used to calculate annual depreciation expense under time-based methods.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Master reference table for depreciation_schedule. Referenced by depreciation_schedule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_recurring_entry_template_id` FOREIGN KEY (`recurring_entry_template_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template`(`recurring_entry_template_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_source_document_id` FOREIGN KEY (`source_document_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`source_document`(`source_document_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_original_recognition_event_revenue_recognition_event_id` FOREIGN KEY (`original_recognition_event_revenue_recognition_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_original_allocation_cost_allocation_id` FOREIGN KEY (`original_allocation_cost_allocation_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ADD CONSTRAINT `fk_finance_ebitda_snapshot_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ADD CONSTRAINT `fk_finance_ebitda_snapshot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ADD CONSTRAINT `fk_finance_ebitda_snapshot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ADD CONSTRAINT `fk_finance_facility_legal_assignment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ADD CONSTRAINT `fk_finance_obligation_gl_mapping_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ADD CONSTRAINT `fk_finance_cost_center_obligation_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ADD CONSTRAINT `fk_finance_facility_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_source_recurring_entry_template_id` FOREIGN KEY (`source_recurring_entry_template_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template`(`recurring_entry_template_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_superseded_source_document_id` FOREIGN KEY (`superseded_source_document_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`source_document`(`source_document_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_revised_depreciation_schedule_id` FOREIGN KEY (`revised_depreciation_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule`(`depreciation_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_short_text` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|revenue|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Item Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `line_item_display_allowed` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `pl_statement_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Statement Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_blocked` SET TAGS ('dbx_business_glossary_term' = 'Posting Blocked Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_required` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_value_regex' = 'customer|vendor|asset|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_value_regex' = 'key_control|supporting_control|not_in_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `trading_partner_required` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|capital');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|percentage|driver_based');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Node');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `budget_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `budget_allocation_method` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|zero_based|incremental');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `cost_center_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Assignment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `ebitda_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Node');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'revenue_center|cost_center|investment_center|service_center');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `revenue_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Posting Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `sox_control_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Scope Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `budget_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `closing_balance_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `consolidation_unit` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `consolidation_unit` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `credit_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `credit_amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount in Transaction Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `debit_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `debit_amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount in Transaction Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `ebitda_indicator` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `net_balance_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Balance in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `opening_balance_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `revenue_stream_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `sox_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`general_ledger` ALTER COLUMN `variance_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount in Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `maintenance_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `source_document_id` SET TAGS ('dbx_business_glossary_term' = 'Source Document Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'standard|accrual|prepayment|reclassification|elimination|correction');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `parked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Parked Document Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `recurring_entry_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code (T-Code)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|posted|reversed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `above_the_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Above-The-Line Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `actual_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `below_the_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Below-The-Line Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `facilities_amount` SET TAGS ('dbx_business_glossary_term' = 'Facilities Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `music_licensing_amount` SET TAGS ('dbx_business_glossary_term' = 'Music Licensing Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `post_production_amount` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `production_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`production_budget` ALTER COLUMN `vfx_amount` SET TAGS ('dbx_business_glossary_term' = 'Visual Effects (VFX) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_version_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approver Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Approver Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_version_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `budget_version_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|superseded|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Rationale');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Budget Consolidation Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'entity|division|department|project|consolidated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Locked Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2]|FY)$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`budget_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|actuals|rolling_forecast|supplemental');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'ASC_606|IFRS_15|GAAP|local_GAAP');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `audience_measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Audience Measurement Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `is_deferred` SET TAGS ('dbx_business_glossary_term' = 'Is Deferred Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `makegoods_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegoods Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `makegoods_policy` SET TAGS ('dbx_value_regex' = 'automatic|negotiated|none|audience_based|technical_failure');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `performance_obligation` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'CPM|flat_rate|tiered|usage_based|revenue_share|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|usage_based|milestone_based');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `revenue_stream_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `revenue_stream_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `revenue_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Revenue Subcategory');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `stream_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `stream_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `stream_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rated|out_of_scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_stream` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `ad_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `original_recognition_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Recognition Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `asc_606_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ASC 606 Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `ifrs_15_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 15 Compliant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recognition Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|milestone|percentage_of_completion');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'recognized|deferred|partially_recognized|reversed|adjusted');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Assurance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|discrepancy_identified|reconciled');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared|disputed|written_off');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'invoice|credit_memo|debit_memo|payment|down_payment|adjustment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|credit_card|direct_debit|cash');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_receivable` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Text Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `equipment_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Procurement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'KR|KG|KN|RE|DR');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_block` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_block` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Document Text Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|eliminated|partially_eliminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|budget|fixed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Netting Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending_netting|netted|excluded_from_netting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Receiving Cost Center');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|unmatched|resolved|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'unsettled|partially_settled|fully_settled|written_off');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^IC-[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'content_licensing|shared_service_allocation|management_fee|technology_recharge|intercompany_loan|royalty_payment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_checklist_completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Close Checklist Completion Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Completed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Initiated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_notes` SET TAGS ('dbx_business_glossary_term' = 'Close Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_phase` SET TAGS ('dbx_business_glossary_term' = 'Close Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_phase` SET TAGS ('dbx_value_regex' = 'pre_close|soft_close|hard_close|final_close');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|pending_review|completed|failed|reopened');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `consolidation_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `consolidation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `controller_email` SET TAGS ('dbx_business_glossary_term' = 'Controller Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `controller_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `controller_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `external_audit_required` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `external_audit_status` SET TAGS ('dbx_business_glossary_term' = 'External Audit Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `external_audit_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|issues_identified');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `intercompany_elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `intercompany_elimination_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `last_reopen_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reopen Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `open_items_count` SET TAGS ('dbx_business_glossary_term' = 'Open Items Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `period_lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|special');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `posting_period_locked` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Locked');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `reopen_count` SET TAGS ('dbx_business_glossary_term' = 'Reopen Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `reopen_reason` SET TAGS ('dbx_business_glossary_term' = 'Reopen Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `responsible_controller` SET TAGS ('dbx_business_glossary_term' = 'Responsible Controller');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Assurance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|discrepancy_found|resolved');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `scheduled_close_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `sox_signoff_by` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Sign-Off By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `sox_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Sign-Off Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `unreconciled_amount` SET TAGS ('dbx_business_glossary_term' = 'Unreconciled Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `unreconciled_items_count` SET TAGS ('dbx_business_glossary_term' = 'Unreconciled Items Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`period_close` ALTER COLUMN `variance_to_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Forecast Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|local_statutory');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `broadcast_license_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Holder Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `ebitda_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dormant|liquidation|dissolved');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'broadcast_network|streaming_platform|production_studio|holding_company|subsidiary|joint_venture');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `intercompany_elimination_group` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `regulatory_reporting_obligations` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `original_allocation_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_key` SET TAGS ('dbx_business_glossary_term' = 'Allocation Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_key_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Key Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|statistical|activity_based|assessment|distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|cancelled|error');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'overhead|shared_services|facilities|technology|corporate|intercompany');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_element` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) Reporting Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_allocation` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `actual_capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Capitalization Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `auc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction (AUC) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `auc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `cumulative_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Spend Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|accelerated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `governance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Governance Review Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `governance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `investment_justification` SET TAGS ('dbx_business_glossary_term' = 'Investment Justification');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `investment_justification` SET TAGS ('dbx_value_regex' = 'capacity_expansion|technology_upgrade|regulatory_compliance|cost_reduction|revenue_generation|strategic_initiative');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `planned_capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Capitalization Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_classification` SET TAGS ('dbx_business_glossary_term' = 'Project Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_classification` SET TAGS ('dbx_value_regex' = 'infrastructure|technology|facilities|equipment|broadcast_transmission|digital_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`capex_project` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_depreciation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `transmission_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Equipment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|disposed|retired|impaired');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_super_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Super Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits|accelerated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|trade_in|transfer|write_off');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_subdomain' = 'asset_depreciation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `asset_count` SET TAGS ('dbx_business_glossary_term' = 'Asset Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_value_regex' = 'broadcast|streaming|production|advertising|distribution|corporate');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `error_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Error Log Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `planned_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Depreciation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `posted_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Posted Depreciation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `repeat_run_indicator` SET TAGS ('dbx_business_glossary_term' = 'Repeat Run Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Completed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_initiated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Run Initiated By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_initiated_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|completed_with_errors|failed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned|repeat|test');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `test_run_indicator` SET TAGS ('dbx_business_glossary_term' = 'Test Run Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_run` ALTER COLUMN `warning_count` SET TAGS ('dbx_business_glossary_term' = 'Warning Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'Posted|Parked|Cleared|Reversed|Cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_reporting_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_reporting_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|GST|Sales Tax|Use Tax|Withholding Tax|Excise Tax');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`tax_posting` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `ebitda_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) Snapshot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `advertising_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Advertising Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `budget_ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `carriage_fee_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `content_acquisition_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Content Acquisition Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `covenant_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `distribution_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Distribution Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `ebitda_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) Margin Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `facilities_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Facilities Expense Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `forecast_ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `forecast_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `forecast_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `marketing_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Expense Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `other_direct_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Direct Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `other_operating_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Operating Expense Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `other_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `period_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `personnel_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Personnel Expense Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `prepared_by_user` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `prior_period_ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Period EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `prior_period_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `prior_period_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `snapshot_number` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|locked|adjusted');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `subscription_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `syndication_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Syndication Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `technology_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Technology Expense Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `total_direct_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `total_operating_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expense Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `financial_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Reconciliation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciler Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `adjustment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `gl_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Balance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciler_name` SET TAGS ('dbx_business_glossary_term' = 'Reconciler Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_review|approved|rejected|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|signed_off|rejected|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `subledger_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Subledger Balance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` SET TAGS ('dbx_subdomain' = 'asset_depreciation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` SET TAGS ('dbx_association_edges' = 'finance.legal_entity,technology.broadcast_facility');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `facility_legal_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Legal Assignment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Legal Assignment - Broadcast Facility Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Legal Assignment - Financial Entity Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `intercompany_charge_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Charge Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `lease_or_own_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease or Own Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `primary_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary User Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `tax_reporting_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Entity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_legal_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` SET TAGS ('dbx_association_edges' = 'finance.capex_project,workforce.employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `project_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment - Capex Project Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `project_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment - Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `project_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `project_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `project_manager_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Allocation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Assignment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Project Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`project_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` SET TAGS ('dbx_association_edges' = 'finance.chart_of_accounts,compliance.regulatory_obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `obligation_gl_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation GL Mapping ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Gl Mapping - Chart Of Accounts Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Gl Mapping - Regulatory Obligation Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `accrual_required` SET TAGS ('dbx_business_glossary_term' = 'Accrual Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `cost_allocation_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `estimated_annual_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `mapping_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation GL Mapping Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mapping Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`obligation_gl_mapping` ALTER COLUMN `reporting_line_item` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line Item');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` SET TAGS ('dbx_association_edges' = 'finance.cost_center,compliance.regulatory_obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `cost_center_obligation_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Obligation Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Obligation Allocation - Cost Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Obligation Allocation - Regulatory Obligation Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `compliance_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Compliance Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_obligation_allocation` ALTER COLUMN `obligation_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Obligation Allocation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` SET TAGS ('dbx_association_edges' = 'finance.cost_center,workforce.employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_center_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Authorization ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Authorization - Cost Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Authorization - Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_granted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Granted By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_granted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_granted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_revoked_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_revoked_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `cost_revoked_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `granted_by_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `revoked_by_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `granted_date` SET TAGS ('dbx_business_glossary_term' = 'Granted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `revoked_date` SET TAGS ('dbx_business_glossary_term' = 'Revoked Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Authorization Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`cost_center_authorization` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` SET TAGS ('dbx_association_edges' = 'finance.cost_center,technology.broadcast_facility');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `facility_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Cost Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Cost Allocation - Broadcast Facility Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Cost Allocation - Cost Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `monthly_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Allocated Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `usage_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Metric Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`facility_cost_allocation` ALTER COLUMN `usage_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Usage Metric Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `source_recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Source Recurring Entry Template Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `source_recurring_entry_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Execution Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `next_scheduled_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `reversal_posting_date_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Reversal Posting Date Offset Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `source_document_id` SET TAGS ('dbx_business_glossary_term' = 'Source Document Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `superseded_source_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Source Document Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `superseded_source_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `source_document_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `document_amount` SET TAGS ('dbx_business_glossary_term' = 'Document Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`source_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` SET TAGS ('dbx_subdomain' = 'asset_depreciation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `revised_depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Depreciation Schedule Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `revised_depreciation_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `annual_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Depreciation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciable_base` SET TAGS ('dbx_business_glossary_term' = 'Depreciable Base');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_book_type` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Book Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `impairment_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `last_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Run Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `next_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Next Depreciation Run Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `useful_life_units` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
